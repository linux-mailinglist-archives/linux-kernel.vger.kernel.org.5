Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E117F783D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjHVJ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjHVJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:58:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D721A1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:58:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D1CB635ED
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1659EC433C8;
        Tue, 22 Aug 2023 09:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692698332;
        bh=sVhI0MwQkWiaY9ZR0rZ894LsScW3MR+I1sFldvIieKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gb6SCw3ct7+U5PyNUDKDZtox3L7LrfOJa1QWQ3ZpygAuiBicNU2/d0m8v24Z6Jvbq
         9IFtI5hEOvJUS5dL0nxlcGMF5cTmSf0H/km9MtFvhOVXh4ucX4bmcmlJZ+d9GF4bhe
         6itsB4aIKQIQlPmWLZhCJ6kxdNsnwrM3NEsimqsweAW2fJ+9C9Owyocd7fJJPpNSaN
         UNTMnfrKZW5/9wvHbqgflwKPoIq508SUYHL3psSxMFKnmwOFPWEx5Y7TUgRTWrPfpy
         xRx4zY+IrOEFkTCftINpvLLEYe6m78IeZduMtnx/7kk3ruy7OznYnuMOunCxjaWfSY
         mf5214Q5Exa2w==
Date:   Tue, 22 Aug 2023 10:58:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Qi Zheng <qi.zheng@linux.dev>, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        muchun.song@linux.dev, pasha.tatashin@soleen.com,
        wangkefeng.wang@huawei.co
Subject: Re: [PATCH] arm64: mm: use ptep_clear() instead of pte_clear() in
 clear_flush()
Message-ID: <20230822095847.GA20667@willie-the-truck>
References: <20230810093241.1181142-1-qi.zheng@linux.dev>
 <20230811110311.GB6993@willie-the-truck>
 <CAOgjDMi6kTZUjEianbO670RQxJ8=JhHxkeci9NspSCRT5rPhYw@mail.gmail.com>
 <20230811112107.GE6993@willie-the-truck>
 <CAOgjDMgVZXbEeA6O2yPR9N27JWCMNR3D7cgHJbmbfYYUdKF3eQ@mail.gmail.com>
 <20230821132119.110668fde87a29443f0bff28@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230821132119.110668fde87a29443f0bff28@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 01:21:19PM -0700, Andrew Morton wrote:
> On Fri, 11 Aug 2023 19:28:41 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> > Will Deacon <will@kernel.org>于2023年8月11日 周五19:21写道：
> > 
> > > On Fri, Aug 11, 2023 at 07:16:20PM +0800, Qi Zheng wrote:
> > > >    Will Deacon <[1]will@kernel.org>于2023年8月11日 周五19:03写道：
> > > >
> > > >      On Thu, Aug 10, 2023 at 09:32:41AM +0000, Qi Zheng wrote:
> > > >      > From: Qi Zheng <[2]zhengqi.arch@bytedance.com>
> > > >      >
> > > >      > In clear_flush(), the original pte may be a present entry, so we
> > > >      should
> > > >      > use ptep_clear() to let page_table_check track the pte clearing
> > > >      operation,
> > > >      > otherwise it may cause false positive in subsequent set_pte_at().
> > > >
> > > >      Isn't this true for most users of pte_clear()? There are some in the
> > > >      core
> > > >      code, so could they trigger the false positive as well?
> > > >
> > > >    No, the PTE entry in other places where pte_clear() is used is
> > > non-present
> > > >    PTE.
> > > >    The page_table_check does not does track the pte operation in this
> > > case,
> > > >    so it will not cause false positives.
> > >
> > > Are you sure? For example, the call from flush_all_zero_pkmaps() in
> > > highmem.c really looks like it's clearing a valid entry. Not that arm64
> > > cares about highmem, but still.
> > 
> > 
> > Ah, this is init_mm, not user mm, page_table_check does not care about this
> > case.
> 
> It's unclear where we stand with this patch.  An ack or a nack, please?

Sorry Andrew, I saw you'd queued it so I marked it as "done" on my list. I
think it's fine:

Acked-by: Will Deacon <will@kernel.org>

Will
