Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C7878338F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 22:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjHUUV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjHUUVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:21:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389B711C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAEAC63E9A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 20:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F61C433C7;
        Mon, 21 Aug 2023 20:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1692649281;
        bh=UYHFeqSQzpPFRn6m2yxsPjlcReEMpIU+Exeq39DnB8U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sLmXwHgFuqqapxRe3+yeZKK7CDPOs5xCFuV15p5m/gNNZUxfaxQNNl1rElZVR4pCi
         Ppty/+tE0UhCDIXeAfmiFjsuaVq69GF8A6+zw1hbKjOqCBWxjQu9qN7p4SoNcfxHP9
         6URjiAPZPAAlNrGRJwtt4UmKUbSGVe8q8G7B/Moc=
Date:   Mon, 21 Aug 2023 13:21:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Will Deacon <will@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        pasha.tatashin@soleen.com, wangkefeng.wang@huawei.co
Subject: Re: [PATCH] arm64: mm: use ptep_clear() instead of pte_clear() in
 clear_flush()
Message-Id: <20230821132119.110668fde87a29443f0bff28@linux-foundation.org>
In-Reply-To: <CAOgjDMgVZXbEeA6O2yPR9N27JWCMNR3D7cgHJbmbfYYUdKF3eQ@mail.gmail.com>
References: <20230810093241.1181142-1-qi.zheng@linux.dev>
        <20230811110311.GB6993@willie-the-truck>
        <CAOgjDMi6kTZUjEianbO670RQxJ8=JhHxkeci9NspSCRT5rPhYw@mail.gmail.com>
        <20230811112107.GE6993@willie-the-truck>
        <CAOgjDMgVZXbEeA6O2yPR9N27JWCMNR3D7cgHJbmbfYYUdKF3eQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 19:28:41 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> Will Deacon <will@kernel.org>于2023年8月11日 周五19:21写道：
> 
> > On Fri, Aug 11, 2023 at 07:16:20PM +0800, Qi Zheng wrote:
> > >    Will Deacon <[1]will@kernel.org>于2023年8月11日 周五19:03写道：
> > >
> > >      On Thu, Aug 10, 2023 at 09:32:41AM +0000, Qi Zheng wrote:
> > >      > From: Qi Zheng <[2]zhengqi.arch@bytedance.com>
> > >      >
> > >      > In clear_flush(), the original pte may be a present entry, so we
> > >      should
> > >      > use ptep_clear() to let page_table_check track the pte clearing
> > >      operation,
> > >      > otherwise it may cause false positive in subsequent set_pte_at().
> > >
> > >      Isn't this true for most users of pte_clear()? There are some in the
> > >      core
> > >      code, so could they trigger the false positive as well?
> > >
> > >    No, the PTE entry in other places where pte_clear() is used is
> > non-present
> > >    PTE.
> > >    The page_table_check does not does track the pte operation in this
> > case,
> > >    so it will not cause false positives.
> >
> > Are you sure? For example, the call from flush_all_zero_pkmaps() in
> > highmem.c really looks like it's clearing a valid entry. Not that arm64
> > cares about highmem, but still.
> 
> 
> Ah, this is init_mm, not user mm, page_table_check does not care about this
> case.

It's unclear where we stand with this patch.  An ack or a nack, please?
