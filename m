Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BDB754A16
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjGOQT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGOQTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:19:25 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1E911C
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 09:19:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E23020002;
        Sat, 15 Jul 2023 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689437962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dlIhZ9cfFkihaTXZUNHm8+GcslExR23+39+IT1xIDsc=;
        b=d6ZJx5pKwMJZjAERl31AmymcOB9SMQ/+mBsarvOMWIosFMnzU/wBtwzC7q1t8TL3mzp5F4
        JcBRBfeyJEtZxF8s84cErO6D8/S4talyv4OQgb2YyYiQiGw9CdmBaYvaRMzJHCLYON0Uum
        Xopv28dxUjjw1v0Qsy6LTD45e6Z19EmSrqbhi7c4DWyEiGclhG+gD0nkx4or00tgrdvxdw
        i2QewPVpUmOuZ2bhxYuRvDERtc9UtggGCm3w3oc1zOl7URj82rbZdlbDRw7oWBR5LKWH88
        nPjWPZo8/s1jXpuVdnX3BEF+wwBSAPLyBkN4ueFajXZZc8rtGhZfvGnWgR87nQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>, miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Subject: Re: [PATCH v5 2/2] mtd: rawnand: rockchip: Align hwecc vs. raw page helper layouts
Date:   Sat, 15 Jul 2023 18:19:18 +0200
Message-Id: <20230715161918.20613-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5e782c08-862b-51ae-47ff-3299940928ca@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ea690ad78dd611e3906df5b948a516000b05c1cb'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-14 at 15:21:21 UTC, Johan Jonker wrote:
> Currently, read/write_page_hwecc() and read/write_page_raw() are not
> aligned: there is a mismatch in the OOB bytes which are not
> read/written at the same offset in both cases (raw vs. hwecc).
> 
> This is a real problem when relying on the presence of the Page
> Addresses (PA) when using the NAND chip as a boot device, as the
> BootROM expects additional data in the OOB area at specific locations.
> 
> Rockchip boot blocks are written per 4 x 512 byte sectors per page.
> Each page with boot blocks must have a page address (PA) pointer in OOB
> to the next page. Pages are written in a pattern depending on the NAND chip ID.
> 
> Generate boot block page address and pattern for hwecc in user space
> and copy PA data to/from the already reserved last 4 bytes before ECC
> in the chip->oob_poi data layout.
> 
> Align the different helpers. This change breaks existing jffs2 users.
> 
> Fixes: 058e0e847d54 ("mtd: rawnand: rockchip: NFC driver for RK3308, RK2928 and others")
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
