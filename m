Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC467CA417
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjJPJ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjJPJ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:27:09 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1239CAD;
        Mon, 16 Oct 2023 02:27:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7FEDD240012;
        Mon, 16 Oct 2023 09:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697448425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AnVL+zrDTr8QgteqkwzGAp+s0MFLelcomSpW2exEsdA=;
        b=MigWbuavOpPnKklMd+nDek00kQjQD4T+OPGYVxh0TG8mNbC6yPP0RjEwnIpU9C6K/RokMZ
        5cqAJlnwNAZo609xfxqRp2N+QLEnP0lOJ9NgkX2skwyGMpNUXkk3hTAtQXV7dRyBn0kXX/
        JwyZr2P7AS2Q00pGLo2wOF+btpzFvxCLjk6Od8JcYK6a3NWmkNFbNJyKTTNNDFZkIX9Km3
        VqkbmHYsdnMSZzJqZYg9NptHtJKi9BiN41E0mavBUVZl8i+BV8Src0c5zuWSbma9VWXtF8
        vNolmxwgPFqlrsTnsxsESi3LYVjXegp0PwgKMsT53wJA+uyC5dLrGh9Ol1NvdA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        =?utf-8?q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>,
        =?utf-8?b?TcOl?= =?utf-8?b?bnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Alexander Shiyan <eagle.alexander923@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        JaimeLiao <jaimeliao.tw@gmail.com>
Cc:     kernel@pengutronix.de, stable@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: Ensure the nand chip supports cached reads
Date:   Mon, 16 Oct 2023 11:27:02 +0200
Message-Id: <20231016092702.288259-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922141717.35977-1-r.czerwinski@pengutronix.de>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'f6ca3fb6978f94d95ee79f95085fc22e71ca17cc'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-22 at 14:17:16 UTC, Rouven Czerwinski wrote:
> Both the JEDEC and ONFI specification say that read cache sequential
> support is an optional command. This means that we not only need to
> check whether the individual controller supports the command, we also
> need to check the parameter pages for both ONFI and JEDEC NAND flashes
> before enabling sequential cache reads.
> 
> This fixes support for NAND flashes which don't support enabling cache
> reads, i.e. Samsung K9F4G08U0F or Toshiba TC58NVG0S3HTA00.
> 
> Sequential cache reads are now only available for ONFI and JEDEC
> devices, if individual vendors implement this, it needs to be enabled
> per vendor.
> 
> Tested on i.MX6Q with a Samsung NAND flash chip that doesn't support
> sequential reads.
> 
> Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
