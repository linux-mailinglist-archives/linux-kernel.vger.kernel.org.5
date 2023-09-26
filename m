Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B067AF592
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbjIZUyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjIZUyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:54:00 -0400
X-Greylist: delayed 260 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 13:53:53 PDT
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06062120;
        Tue, 26 Sep 2023 13:53:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DEFC6180E3;
        Tue, 26 Sep 2023 16:49:32 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=vnqORXqaBxujrZIwo1zw9KvIE221dEcvbIpGK6
        4Mu0s=; b=vaFd9L+aUbp5kYsflkkBuBk0cPY9S/Fs34MF26wTXU/E6ubR8UR7CB
        cja+kCZim2PSDYi06Aaj6lmFuXOAEtN+APYQjGyynNWXFS48os/xaRZeGXtsNqZY
        BOQGQjDxLTYu6dqEKpQTDrgF4SCIbhFBDNQ6pNxjVfGMPUz4kEhvM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D556B180E2;
        Tue, 26 Sep 2023 16:49:32 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=vnqORXqaBxujrZIwo1zw9KvIE221dEcvbIpGK64Mu0s=; b=c2g49f/Co2qpG8GQZCZBFdVMaFoFpRzOvTK55BZZtx7t/WROFvbYnzEe/C83x9gt8lr07HbLcISFV83C3MDHOnUE+5TibodhLL4de/jNvbsAQG5TuSX+qCmP1aDziPPCsU4oKob9NklAlUR9sIBKsHrQXkL3g5XyUi4jj6aa77Q=
Received: from yoda.fluxnic.net (unknown [184.162.17.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DE15C180E1;
        Tue, 26 Sep 2023 16:49:28 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu (xanadu [10.0.0.101])
        by yoda.fluxnic.net (Postfix) with ESMTPSA id 90996956C15;
        Tue, 26 Sep 2023 16:49:26 -0400 (EDT)
Date:   Tue, 26 Sep 2023 22:49:26 +0200 (CEST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        paulburton@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Willy Tarreau <w@1wt.eu>,
        =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
        Tim Bird <tim.bird@sony.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1 0/7] DCE/DSE: Add Dead Syscalls Elimination support,
 part1
In-Reply-To: <a08e1cee-05e0-447a-b25b-6c2ebb116e8d@app.fastmail.com>
Message-ID: <6n7o7p99-9pr2-9orq-6nq1-093n7n7n43o9@syhkavp.arg>
References: <cover.1695679700.git.falcon@tinylab.org> <fbb6f526-0db9-4bbe-9635-8cb55b4335ee@app.fastmail.com> <a08e1cee-05e0-447a-b25b-6c2ebb116e8d@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 2FB1520E-5CAE-11EE-B67F-F515D2CDFF5E-78420484!pb-smtp20.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023, Arnd Bergmann wrote:

> On Tue, Sep 26, 2023, at 09:14, Arnd Bergmann wrote:
> > On Tue, Sep 26, 2023, at 00:33, Zhangjin Wu wrote:
> >
> > It would be nice to include some size numbers here for at least
> > one practical use case. If you have a defconfig for a shipping
> > product with a small kernel, what is the 'size -B' output you
> > see comparing with and without DCE and, and with DCE+DSE?
> 
> To follow up on this myself, for a very rough baseline,
> I tried a riscv tinyconfig build with and without 
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION (this is currently
> not supported on arm, so I did not try it there), and
> then another build with simply *all* system calls stubbed
> out by hacking asm/syscall-wrapper.h:
> 
> $ size build/tmp/vmlinux-*
>    text	   data	    bss	     dec    hex	filename
>   754772  220016  71841	 1046629  ff865	vmlinux-tinyconfig
>   717500  223368  71841	 1012709  f73e5	vmlinux-tiny+nosyscalls
>   567310  176200  71473	  814983  c6f87	vmlinux-tiny+gc-sections
>   493278  170752  71433	  735463  b38e7	vmlinux-tiny+gc-sections+nosyscalls
> 10120058 3572756 493701	14186515 d87813	vmlinux-defconfig
>  9953934 3529004 491525	13974463 d53bbf	vmlinux-defconfig+gc
>  9709856 3500600 489221	13699677 d10a5d	vmlinux-defconfig+gc+nosyscalls
> 
> This would put us at an upper bound of 10% size savings (80kb) for
> tinyconfig, which is clearly significant. For defconfig, it's
> still 2.0% or 275kb size reduction when all syscalls are dropped.

I did something similar a while ago. Results included here:

https://lwn.net/Articles/746780/

In my case, stubbing out all syscalls produced a 7.8% reduction which 
was somewhat disappointing compared to other techniques. Of course it 
all depends on what is your actual goal.


Nicolas
