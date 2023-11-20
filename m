Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8937F10BC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjKTKqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjKTKqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:46:46 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3E2CA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:46:41 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CB6924000F;
        Mon, 20 Nov 2023 10:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700477200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jp8xDlTKHw0X2EagTkm2Mx/zhDz7J44QLcdr/8aP10s=;
        b=o77SBd9D6+b6eM/IFzIavj/aya6sOa5EYCaOvOW+JbMIttzuVGUvhHQ/KRUVwhJjnj4NjP
        d9PyEV5GMe6kBGZnokG0sYTuNtdLBV1qGLoRpDB/ZlMJeW/oOsqNu5a8dO0JCA1dPVSC81
        4PQab6GMNYR4IF6V801Zfo+yJnusV3FUxyKfzRpWf6/ICSCaWa2bI3fKXuW5Q1+mJPUaq4
        UZpm8HteHoVYcFQ1341NHtoqkyQh8eZTRCGrExPZ0Zu0uGCRWU1mg36ehDF7larY64tStj
        Qc1Hm3mMycUhPcrnpnpvDbcnjFpOdAPWRwpYxTshVSR1/TD9hWW+heGlTwKT5Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ronald Monthero <debug.penguin32@gmail.com>,
        miquel.raynal@bootlin.com, andriy.shevchenko@linux.intel.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        martin.blumenstingl@googlemail.com, paul@crapouillou.net,
        robh@kernel.org, u.kleine-koenig@pengutronix.de,
        AVKrasnov@sberdevices.ru, r.czerwinski@pengutronix.de,
        jaimeliao.tw@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Poonam Aggrwal <poonam.aggrwal@freescale.com>,
        Dipen Dudhat <Dipen.Dudhat@freescale.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>, Liu Shuo <b35362@freescale.com>
Subject: Re: [PATCH v4] mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand controller response
Date:   Mon, 20 Nov 2023 11:46:37 +0100
Message-Id: <20231120104637.3524982-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118083156.776887-1-debug.penguin32@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'923fb6238cb3ac529aa2bf13b3b1e53762186a8b'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-11-18 at 08:31:51 UTC, Ronald Monthero wrote:
> Under heavy load it is likely that the controller is done
> with its own task but the thread unlocking the wait is not
> scheduled in time. Increasing IFC_TIMEOUT_MSECS allows the
> controller to respond within allowable timeslice of 1 sec.
> 
> fsl,ifc-nand 7e800000.nand: Controller is not responding
> 
> [<804b2047>] (nand_get_device) from [<804b5335>] (nand_write_oob+0x1b/0x4a)
> [<804b5335>] (nand_write_oob) from [<804a3585>] (mtd_write+0x41/0x5c)
> [<804a3585>] (mtd_write) from [<804c1d47>] (ubi_io_write+0x17f/0x22c)
> [<804c1d47>] (ubi_io_write) from [<804c047b>] (ubi_eba_write_leb+0x5b/0x1d0)
> 
> Fixes: 82771882d960 ("NAND Machine support for Integrated Flash Controller")
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
