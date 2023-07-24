Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8676B760102
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGXVRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjGXVRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:17:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350781AA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:17:48 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rsc@pengutronix.de>)
        id 1qO2vw-0007nO-2D; Mon, 24 Jul 2023 23:17:36 +0200
Received: from rsc by pty.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <rsc@pengutronix.de>)
        id 1qO2vt-009q1A-8O; Mon, 24 Jul 2023 23:17:33 +0200
Date:   Mon, 24 Jul 2023 23:17:33 +0200
From:   Robert Schwebel <r.schwebel@pengutronix.de>
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 0/4] fs/9p: fix mmap regression
Message-ID: <ZL7qbTU7D1mAJePi@pengutronix.de>
References: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: rsc@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Wed, Jul 19, 2023 at 03:17:04PM +0000, Eric Van Hensbergen wrote:
> This series attempts to fix a reported exception with mmap
> on newer kernels.
>
> Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
> Link: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
> Reported-by: Robert Schwebel <r.schwebel@pengutronix.de>
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
> Changes in v3:
> - Clarify debug print to read-only mmap mode versus no mmap mode in
>   v9fs_file_mmap
> - Fix suggested regression tags and propagate across series
> - Link to v2: https://lore.kernel.org/r/20230716-fixes-overly-restrictive-mmap-v2-0-147d6b93f699@kernel.org
>
> Changes in v2:
> - fix requested changes in commit messages
> - add patch to remove unnecessary invalidate_inode_pages in mmap readonly path
> - Link to v1: https://lore.kernel.org/r/20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org

I've tested this patch series with my qemu setup and it resolves the
issue. Thanks for taking care!

Tested-by: Robert Schwebel <r.schwebel@pengutronix.de>

----------8<----------

rsc@dude05:~/work/DistroKit$ configs/platform-v7a/run
Forwarding SSH port 127.0.0.1:24910 -> qemu:22
[    0.000000] L2C: platform modifies aux control register: 0x02020000 -> 0x02420000
[    0.000000] L2C: DT/platform modifies aux control register: 0x02020000 -> 0x02420000
[    0.004896] smp_twd: clock not found -2
[    0.726397] simple-pm-bus bus@40000000:motherboard-bus@40000000:iofpga@7,00000000: Failed to create device link (0x180) with dcc:tcrefclk
[    0.742338] simple-pm-bus bus@40000000:motherboard-bus@40000000:iofpga@7,00000000: Failed to create device link (0x180) with dcc:tcrefclk
[    0.809910] physmap-flash 48000000.psram: map_probe failed
[    1.201306] 9pnet_virtio: no channels available for device root

 ____                        _                   _
|  _ \ ___ _ __   __ _ _   _| |_ _ __ ___  _ __ (_)_  __
| |_) / _ \ '_ \ / _` | | | | __| '__/ _ \| '_ \| \ \/ /
|  __/  __/ | | | (_| | |_| | |_| | | (_) | | | | |>  <
|_|   \___|_| |_|\__, |\__,_|\__|_|  \___/|_| |_|_/_/\_\
                 |___/

 ____  _     _             _  ___ _
|  _ \(_)___| |_ _ __ ___ | |/ (_) |_
| | | | / __| __| '__/ _ \| ' /| | __|
| |_| | \__ \ |_| | | (_) | . \| | |_
|____/|_|___/\__|_|  \___/|_|\_\_|\__|


OSELAS(R)-DistroKit-2019.12.0-00429-g57ffae760eb9 / v7a-2019.12.0-00429-g57ffae760eb9
ptxdist-2023.07.1/2023-07-11T19:56:50+0200

DistroKit login: root
root@DistroKit:~ mount / -o remount,rw
root@DistroKit:~ ldconfig
root@DistroKit:~ uname -a
Linux DistroKit 6.4.0 #1 SMP PREEMPT 2023-07-01T00:00:00+00:00 armv7l GNU/Linux

----------8<----------

rsc
-- 
Pengutronix e.K.                           | Dipl.-Ing. Robert Schwebel  |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
