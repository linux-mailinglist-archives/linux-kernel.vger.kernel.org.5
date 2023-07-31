Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75CD769545
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjGaLwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjGaLwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:52:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3168A1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6015F6108A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556C0C433C7;
        Mon, 31 Jul 2023 11:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690804332;
        bh=/AYjU/vSc3wf9r50UiRvnk6wekIDVhhqPGjM9BKbUvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOZiL0RyBDUTJLSxZ0mRr+gonZxxr6TOEGZCatCGirdCYF8+tXOl2htserQD1w+mh
         29XRnZzirppyUvjMarv7AeHmVlBkgu8x/xwDDtD/cjXchBnZ/SCPJ1wLMSoGYoUDII
         wH8fwU6kDSs1D4INE5cyiL4GFh2saaWdyFF/gurKJGcM6K4rhYB3/ZeJvDLlCiaGF/
         6edvTP7S41kHDODYBKj6VHG5WqS1KHdwfoCbMzfVMZcOiMjr6wvovZ669HJjlWVTb4
         wZcCfhzysCfAGvxIoL8SnhPscOvQrwQWGdgSKoAWfxQZH19mOCVCQwdIr0fV3g2Qbw
         4ECQVtwMgYpKg==
Date:   Mon, 31 Jul 2023 12:52:07 +0100
From:   Will Deacon <will@kernel.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, lstoakes@gmail.com,
        wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        ardb@kernel.org
Subject: Re: arm64: perf test 26 rpi4 oops
Message-ID: <20230731115207.GB24767@willie-the-truck>
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
 <20230728141852.GA21718@willie-the-truck>
 <8c56256399e2e6c41bc574749d6170d5529f24fc.camel@gmx.de>
 <20230731104340.GA24767@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731104340.GA24767@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 11:43:40AM +0100, Will Deacon wrote:
> [+Lorenzo, Kefeng and others]
> 
> On Sun, Jul 30, 2023 at 06:09:15PM +0200, Mike Galbraith wrote:
> > On Fri, 2023-07-28 at 15:18 +0100, Will Deacon wrote:
> > >
> > > Looking at this quickly with Mark, the most likely explanation is that
> > > a bogus kernel address is being passed as the source pointer to
> > > copy_to_user().
> > 
> > 'start' in read_kcore_iter() is bogus a LOT when running perf test 26,
> > and that back to at least 5.15.  Seems removal of bogon-proofing gave a
> > toothless old bug teeth, but seemingly only to perf test 26.  Rummaging
> > around with crash vmlinux /proc/kcore seems to be bogon free anyway.
> > 
> > Someone should perhaps take a peek at perf.  Bogons aside, it also
> > doesn't seem to care deeply about kernel response.  Whether the kernel
> > oops or I bat 945 bogons aside, it says 'OK'.  That seems a tad odd.
> 
> Aha, so I think I triggered the issue you're seeing under QEMU (log
> below). perf (unhelpfully) doesn't have stable test numbers, so it's
> test 21 in my case. However, it only explodes if I run it as root, since
> /proc/kcore is 0400 on my system.
> 
> The easiest way to trigger the problem is simply:
> 
> # objdump -d /proc/kcore
> 
> Looking at the history, I wonder whether this is because of a combination
> of:
> 
> e025ab842ec3 ("mm: remove kern_addr_valid() completely")
> 
> which removed the kern_addr_valid() check on the basis that kcore used
> copy_from_kernel_nofault() anyway, and:
> 
> 2e1c0170771e ("fs/proc/kcore: avoid bounce buffer for ktext data")
> 
> which replaced the copy_from_kernel_nofault() with _copy_to_user().
> 
> So with both of those applied, we're missing the address check on arm64.

Digging into this a little more, the fault occurs because kcore is
treating everything from '_text' to '_end' as KCORE_TEXT and expects it
to be mapped linearly. However, there's plenty of stuff we _don't_ map
in that range on arm64 (e.g. .head.text, the pKVM hypervisor, the entry
trampoline) so kcore is broken.

One hack is to limit KCORE_TEXT to actually point at the kernel text
(see below), but this is a user-visible change in behaviour for things
like .data so I think it would be better to restore the old behaviour
of handling the faults.

Lorenzo?

Will

--->8

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 9cb32e1a78a0..3696a209c1ec 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -635,7 +635,7 @@ static struct kcore_list kcore_text;
  */
 static void __init proc_kcore_text_init(void)
 {
-       kclist_add(&kcore_text, _text, _end - _text, KCORE_TEXT);
+       kclist_add(&kcore_text, _stext, _etext - _stext, KCORE_TEXT);
 }
 #else
 static void __init proc_kcore_text_init(void)

