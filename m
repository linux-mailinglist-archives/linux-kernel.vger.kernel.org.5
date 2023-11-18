Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452807F0051
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjKRPhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKRPhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:37:00 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB664C4;
        Sat, 18 Nov 2023 07:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nmqU21qbLBipYaRstMKAglKCu2uL8lE+8Hu6o1FhMEI=; b=I+6tloqdssaYDTvjf127c/KdoC
        0ijQ7lvtFPm3q6J7iqH9NhXl1qNIGG3fIKug1TAMNjAJtvCOe/wUKhdf0DkfH2fzkcCT9p2NUzPCl
        r6QwfjYgPl1A2qfXJEBfVPV3fDMs4aYk6MRjmU4gI6sKQ0mEVlV1FK3UEmkhD5orhOmMEEMnTl4hW
        3PDJyW1VRNs+f5VXm/dfDd1m08/OQ1X94HGsDSq7P3ziiINrydAnApnTq6yPBHn2XG76Aj0S5gXQ3
        jWYBAgxFS3arDVU4wRnjfdDewoz/KRA06t/LydyiKqDtVbtQaeEvUTRjlfs7PlLO8t88r+9PW/hQ8
        YIl2IA8g==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <aurel32@debian.org>)
        id 1r4NNK-002GW9-7M; Sat, 18 Nov 2023 15:36:50 +0000
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2] helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurel32@debian.org>)
        id 1r4NNG-00AvqW-UC; Sat, 18 Nov 2023 16:36:46 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.97)
        (envelope-from <aurel32@debian.org>)
        id 1r4NNF-00000003iRQ-0d40;
        Sat, 18 Nov 2023 16:36:45 +0100
Date:   Sat, 18 Nov 2023 16:36:45 +0100
From:   Aurelien Jarno <aurel32@debian.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        syq@debian.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: process: Remove lazy context flags for new kernel
 thread
Message-ID: <ZVjaDTcjNpD3m0cC@aurel32.net>
Mail-Followup-To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, syq@debian.org, stable@vger.kernel.org
References: <20231026111715.1281728-1-jiaxun.yang@flygoat.com>
 <ZTvQGs/lEpizUFLh@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTvQGs/lEpizUFLh@aurel32.net>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Debian-User: aurel32
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023-10-27 16:58, Aurelien Jarno wrote:
> On 2023-10-26 12:17, Jiaxun Yang wrote:
> > We received a report from debian infra team, says their build machine
> > crashes regularly with:
> > 
> > [ 4066.698500] do_cpu invoked from kernel context![#1]:
> > [ 4066.703455] CPU: 1 PID: 76608 Comm: iou-sqp-76326 Not tainted 5.10.0-21-loongson-3 #1 Debian 5.10.162-1
> > [ 4066.712793] Hardware name: Loongson Lemote-3A4000-7A-1w-V1.00-A1901/Lemote-3A4000-7A-1w-V1.00-A1901, BIOS Loongson-PMON-V3.3-20201222 12/22/2020
> > [ 4066.725672] $ 0   : 0000000000000000 ffffffff80bf2e48 0000000000000001 9800000200804000
> > [ 4066.733642] $ 4   : 9800000105115280 ffffffff80db4728 0000000000000008 0000020080000200
> > [ 4066.741607] $ 8   : 0000000000000001 0000000000000001 0000000000000000 0000000002e85400
> > [ 4066.749571] $12   : 000000005400cce0 ffffffff80199c00 000000000000036f 000000000000036f
> > [ 4066.757536] $16   : 980000010025c080 ffffffff80ec4740 0000000000000000 980000000234b8c0
> > [ 4066.765501] $20   : ffffffff80ec5ce0 9800000105115280 98000001051158a0 0000000000000000
> > [ 4066.773466] $24   : 0000000000000028 9800000200807e58
> > [ 4066.781431] $28   : 9800000200804000 9800000200807d40 980000000234b8c0 ffffffff80bf3074
> > [ 4066.789395] Hi    : 00000000000002fb
> > [ 4066.792943] Lo    : 00000000428f6816
> > [ 4066.796500] epc   : ffffffff802177c0 _save_fp+0x10/0xa0
> > [ 4066.801695] ra    : ffffffff80bf3074 __schedule+0x804/0xe08
> > [ 4066.807230] Status: 5400cce2 KX SX UX KERNEL EXL
> > [ 4066.811917] Cause : 1000002c (ExcCode 0b)
> > [ 4066.815899] PrId  : 0014c004 (ICT Loongson-3)
> > [ 4066.820228] Modules linked in: asix usbnet mii sg ip6t_REJECT nf_reject_ipv6 ip6table_filter ip6_tables nfnetlink_log nfnetlink xt_hashlimit ipt_REJECT nf_reject_ipv4 xt_NFLOG xt_multiport xt_tcpudp xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter sch_fq tcp_bbr fuse drm drm_panel_orientation_quirks configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic ohci_pci dm_mod r8169 realtek mdio_devres ohci_hcd ehci_pci of_mdio xhci_pci fixed_phy xhci_hcd ehci_hcd libphy usbcore usb_common
> > [ 4066.868085] Process iou-sqp-76326 (pid: 76608, threadinfo=0000000056dd346c, task=000000001209ac62, tls=000000fff18298e0)
> > [ 4066.878897] Stack : ffffffff80ec0000 0000000000000000 ffffffff80ec0000 980000010db34100
> > [ 4066.886867]         9800000100000004 d253a55201683fdc 9800000105115280 0000000000000000
> > [ 4066.894832]         0000000000000000 0000000000000001 980000010db340e8 0000000000000001
> > [ 4066.902796]         0000000000000004 0000000000000000 980000010db33d28 ffffffff80bf36d0
> > [ 4066.910761]         980000010db340e8 980000010db34100 980000010db340c8 ffffffff8070d740
> > [ 4066.918726]         980000010946cc80 9800000104b56c80 980000010db340c0 0000000000000000
> > [ 4066.926690]         ffffffff80ec0000 980000010db340c8 980000010025c080 ffffffff80ec5ce0
> > [ 4066.934654]         0000000000000000 9800000105115280 ffffffff802c59b8 980000010db34108
> > [ 4066.942619]         980000010db34108 2d7071732d756f69 ffff003632333637 d253a55201683fdc
> > [ 4066.950585]         ffffffff8070d1c8 980000010db340c0 98000001092276c8 000000007400cce0
> > [ 4066.958552]         ...
> > [ 4066.960981] Call Trace:
> > [ 4066.963414] [<ffffffff802177c0>] _save_fp+0x10/0xa0
> > [ 4066.968270] [<ffffffff80bf3074>] __schedule+0x804/0xe08
> > [ 4066.973462] [<ffffffff80bf36d0>] schedule+0x58/0x150
> > [ 4066.978397] [<ffffffff8070d740>] io_sq_thread+0x578/0x5a0
> > [ 4066.983764] [<ffffffff8020518c>] ret_from_kernel_thread+0x14/0x1c
> > [ 4066.989823]
> > [ 4066.991297] Code: 000c6940  05a10011  00000000 <f4810af0> f4830b10  f4850b30  f4870b50  f4890b70  f48b0b90
> > 
> > It seems like kernel is trying to save a FP context for a kthread.
> > Since we don't use FPU in kernel for now, TIF_USEDFPU must be set
> > accidentally for that kthread.
> > 
> > Inspecting the code it seems like create_io_thread may be invoked
> > from threads that have FP context alive, causing TIF_USEDFPU to be
> > copied from that context to kthread unexpectedly.
> > 
> > Move around code blocks to ensure flags regarding lazy hardware
> > context get cleared for kernel threads as well.
> > 
> > Cc: stable@vger.kernel.org
> > Reported-by: Aurelien Jarno <aurel32@debian.org>
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> Thanks for the patch. In the meantime we have found that the problem is
> reproducible by building the kitinerary package. The crash happens when
> cmake starts the build. It's not impossible that other packages are able
> to also trigger the crash, but we haven't identified them yet.
> 
> Anyway, I have been able to test a backport of the patch onto the 5.10
> kernel (with minor adjustments) and I confirm it fixes the reported
> issue.
> 
> Tested-by: Aurelien Jarno <aurel32@debian.org>

It seems that this patch hasn't been merged yet, either in Linus' tree
or in the MIPS tree. Is there anything blocking?

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
