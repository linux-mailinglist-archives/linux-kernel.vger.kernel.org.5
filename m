Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF008002FF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjLAF1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAF1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:27:03 -0500
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [IPv6:2001:41d0:203:375::b4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8436310F9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 21:27:08 -0800 (PST)
Date:   Fri, 1 Dec 2023 00:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701408426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xIA8KPNVXbCu0ZyJqk42JwtW3XZ71pnbV5diGZ+c2Fs=;
        b=KyAwaXG0KgzEwxfvzmEvbM2dfa1Mgz9mOcsqpNKtTp9BED0daThuXIbd9zDI29YPIpEK50
        2kVnk+iZCo0gJb/hEsnyS0ROB6UqfIM5VXrtSMPI0uuhJzqK85lkp0D+V7DicClMwR0L02
        Pnzay/naMpTr0OEwbZm55rhb+NeAjVU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Daniel J Blueman <daniel@quora.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-bcachefs@vger.kernel.org
Subject: Re: bcachefs page fault oops after device evacuate/remove and unmount
Message-ID: <20231201052701.jrxwpjte4htzn6wo@moria.home.lan>
References: <CAMVG2stxMYZbDoAHeVQjgJ7f+Td7+VJrLNRbY8au68ZVkzhb0g@mail.gmail.com>
 <20231201032548.5y3lafkwamlhruqs@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201032548.5y3lafkwamlhruqs@moria.home.lan>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 10:25:48PM -0500, Kent Overstreet wrote:
> On Thu, Nov 30, 2023 at 08:47:33PM -0500, Daniel J Blueman wrote:
> > Hi Kent et al,
> > 
> > On upstream bcachefs (master @ evilpiepirate.org/git/bcachefs.git) SHA
> > f8a1ba26, I was able to develop a minimal reproducer [1] for a page
> > not present oops I can provoke [2]. It appears we need further
> > synchronisation during unmount.
> > 
> > Let me know when there is a patch I can test, or for debug.
> > 
> > Thanks,
> >   Dan
> > 
> > -- [1]
> > 
> > modprobe brd rd_size=536870912 rd_nr=2
> > bcachefs format -f /dev/ram0 /dev/ram1
> > mount -t bcachefs /dev/ram0:/dev/ram1 /mnt
> > fio --group_reporting --ioengine=io_uring --directory=/mnt --size=16m
> > --time_based --runtime=60s --iodepth=256 --verify_async=8 --bs=4k-64k
> > --norandommap --random_distribution=zipf:0.5 --numjobs=16 --rw=randrw
> > --name=A --direct=1 --name=B --direct=0 >/dev/null &
> > bcachefs device evacuate /dev/ram0
> > bcachefs device remove --force --force-metadata /dev/ram1
> > bcachefs device remove --force --force-metadata /dev/ram1
> > kill %1
> > wait
> > umount /mnt
> 
> The remove fails for me with DEVICE_SET_STATE_NOT_ALLOWED - evacuate set
> ram0 to ro, we can't remove our last rw dev.

Got it to repro, just had to ignore those errors - there's now a ktest
test for it, and the fix is in master :)
