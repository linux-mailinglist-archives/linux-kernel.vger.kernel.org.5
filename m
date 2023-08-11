Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06253778D85
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbjHKLWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbjHKLVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198811FE1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A5B663184
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFFDC433C9;
        Fri, 11 Aug 2023 11:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691752873;
        bh=8iO5ssaC++/QeuKpj5WA1omKjZ55tlXWJLExPQldY/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+Lejx63MILxcvLOE+PXzKkhIa1ZB2LbJtvCU2LJSQxUOQIvJ1PkLnvFir5Q3kR3y
         zMqqHR4wCe1A+1iaaW9NvFlo3CU5u0mZSWEmSzfs9ZEzSwhBOKuOXxEMGnBefOcz5U
         PgbubM91fJzFi4neJvIP1SWRWzSsSRTM3kTbkDviHX+Qf69u4i4xB9JsXdO2OTa612
         lTpqxLBrL15OYXUdgoPofsSzzMqhsSkmClvj0rHhfr4XS5yBxEioLjgXZvUGFRqxlu
         StZKrKC01KQu8aqmfYrS0IEckC/87gxNiWEA68AgJVEX3sZOWcdIP+5WjT2tcG+fSR
         GLWuwntI4YmNA==
Date:   Fri, 11 Aug 2023 12:21:07 +0100
From:   Will Deacon <will@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Qi Zheng <qi.zheng@linux.dev>, akpm@linux-foundation.org,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        pasha.tatashin@soleen.com, wangkefeng.wang@huawei.co
Subject: Re: [PATCH] arm64: mm: use ptep_clear() instead of pte_clear() in
 clear_flush()
Message-ID: <20230811112107.GE6993@willie-the-truck>
References: <20230810093241.1181142-1-qi.zheng@linux.dev>
 <20230811110311.GB6993@willie-the-truck>
 <CAOgjDMi6kTZUjEianbO670RQxJ8=JhHxkeci9NspSCRT5rPhYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOgjDMi6kTZUjEianbO670RQxJ8=JhHxkeci9NspSCRT5rPhYw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 07:16:20PM +0800, Qi Zheng wrote:
>    Will Deacon <[1]will@kernel.org>于2023年8月11日 周五19:03写道：
> 
>      On Thu, Aug 10, 2023 at 09:32:41AM +0000, Qi Zheng wrote:
>      > From: Qi Zheng <[2]zhengqi.arch@bytedance.com>
>      >
>      > In clear_flush(), the original pte may be a present entry, so we
>      should
>      > use ptep_clear() to let page_table_check track the pte clearing
>      operation,
>      > otherwise it may cause false positive in subsequent set_pte_at().
> 
>      Isn't this true for most users of pte_clear()? There are some in the
>      core
>      code, so could they trigger the false positive as well?
> 
>    No, the PTE entry in other places where pte_clear() is used is non-present
>    PTE. 
>    The page_table_check does not does track the pte operation in this case,
>    so it will not cause false positives.

Are you sure? For example, the call from flush_all_zero_pkmaps() in
highmem.c really looks like it's clearing a valid entry. Not that arm64
cares about highmem, but still.

Will
