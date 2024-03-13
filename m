Return-Path: <linux-kernel+bounces-101591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E696687A915
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1586D1C22879
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898A64437F;
	Wed, 13 Mar 2024 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NuC5oEb8"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572394597F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338934; cv=none; b=FWmYzpYTByfzLbkWpcl38xNumXZcn/NaP/ad2dwLqyXqD750DsdleMOoZLmjYHnynlVbqk1gBbyuaGExzBHxBLM+4evyVw9uZtU1OHFjGdMU4b1UAuDoAdZ5YUSGt3LKd5HEZpzTok+nMKLNc3F5zWQi2iPipGT3NfqXlTxjzVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338934; c=relaxed/simple;
	bh=jjis7xsIFrLu1sl29w85XAmU74ruhJPA4C3PFk6UMzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSpZdpHVwlyGFMyBPtyHkE5MUobS9DLtHo1oUH/9MD69kNKnRQs7vSdbiHJDSKuZXh4MrRODslt2WdvxR20l49MsPw+TREW4cPfEm8d9uIMYxaZ5J3x3D5vgI4y24MFfarYsNcMaxT+efrKcA3Y102EITt3wfpl5f5eqFmS7bmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NuC5oEb8; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5684ea117a3so6302494a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710338930; x=1710943730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+qHX7SxjysW+WBJacqKls7OusP1dBurz/GxAdGzZn4=;
        b=NuC5oEb8vzIMVS7FoXIilQf3/9z7y+Wul5g9pUQVPsZd9lxh4GMS9TB3VT3TQd1rJh
         7rgjNPrmoRhOjMiZPjFpDvCA9y1HA2I0Esc9bqSzgJFSYpqSR9sreANzEsfXQ83MnClq
         DIBcIKcptvzlKzE1M5dCPm/+CHbHEe9cRh1BA0evQ45Tn2DPQMXIysrU8J9Rm4dL9xHi
         vE9KNa2D14rr9LSlcMPzj9G4jjQ8eKeWcHCMqS9yPIKaysFa+9swh5n3PZTTETatd3ER
         1IkzPTxioeYUr/uw2hc7m+5DRHe6luqBzgxVCN0Vx9mQnmPNITc904h7HyzdgZCx4ePg
         qbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710338930; x=1710943730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+qHX7SxjysW+WBJacqKls7OusP1dBurz/GxAdGzZn4=;
        b=PRkamW7h5rHaRx4q7qL+42t2/wTFfKpF+0guM5IfxXpwG9D7vGaESfwrHYsIlPL7Qh
         ep5qIg2liOCTCkLBfGULZWM4uh1ErcgRN79zwJKyJ7iVcJULXbM30JV5OxGOQQW476n9
         BDlTfQhyewPMOJGGLEPOWbf3pnnE4dqDcQtp5mxOBsVcRNIVPKgUx7KV7NRjLvvfXW1C
         FkOs3yDMv0l7K006XQR01rAklkvOP4za8jbVhCgaojCkNOL5Nnb9Rytry4dzOQU3JfDk
         b44T789oC0V09px9X1BJ0qfe6SHg+XdNYL8WZ1pXni5cL3CksvRBUqZMVCQHxNkuSrkD
         +fNw==
X-Forwarded-Encrypted: i=1; AJvYcCWbHy0vO+c59M1IivJ4zkWATIrPVzPojYL4U2+xlJ+JNgv6bpsWQ3ZIA7qn9libNmlQIEHXV5O2ZIaFLi4cxsunhvsJD1lePiymv+kl
X-Gm-Message-State: AOJu0YxA6v/4GDfFq5gdDigj/DLNkzeS9IQFLFEwvdk1Cl95y/jccM4+
	f30Kmhdp8Yw1vfrM9m9gTrqhh6GQYE3U4idImx+UA3AMTFpyFx8mFgpS65CQVds=
X-Google-Smtp-Source: AGHT+IEQhY1LzZrqKG46nbukNSNTyWGekHoM+pNHxFUDfOcSbMTklqa6OdRjNge+Unwg8hREwyz0mg==
X-Received: by 2002:a17:907:c30a:b0:a45:84e7:b265 with SMTP id tl10-20020a170907c30a00b00a4584e7b265mr2885296ejc.7.1710338929747;
        Wed, 13 Mar 2024 07:08:49 -0700 (PDT)
Received: from localhost (host-82-56-173-172.retail.telecomitalia.it. [82.56.173.172])
        by smtp.gmail.com with ESMTPSA id o13-20020a17090611cd00b00a45ff1fe8dasm4792514eja.115.2024.03.13.07.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:08:49 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dave.stevenson@raspberrypi.com
Cc: Phil Elwell <phil@raspberrypi.org>,
	Maxime Ripard <maxime@cerno.tech>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Dom Cobley <popcornmix@gmail.com>,
	Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 02/15] dmaengine: bcm2835: Add support for per-channel flags
Date: Wed, 13 Mar 2024 15:08:27 +0100
Message-ID: <da598378f733a8d45a35ed77f9626cc082262b1a.1710226514.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710226514.git.andrea.porta@suse.com>
References: <cover.1710226514.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Elwell <phil@raspberrypi.org>

Add the ability to interpret the high bits of the dreq specifier as
flags to be included in the DMA_CS register. The motivation for this
change is the ability to set the DISDEBUG flag for SD card transfers
to avoid corruption when using the VPU debugger.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/dma/bcm2835-dma.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 428253b468ac..3d9973dd041d 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -137,6 +137,10 @@ struct bcm2835_desc {
 #define BCM2835_DMA_S_DREQ	BIT(10) /* enable SREQ for source */
 #define BCM2835_DMA_S_IGNORE	BIT(11) /* ignore source reads - read 0 */
 #define BCM2835_DMA_BURST_LENGTH(x) (((x) & 15) << 12)
+#define BCM2835_DMA_CS_FLAGS(x) ((x) & (BCM2835_DMA_PRIORITY(15) | \
+				      BCM2835_DMA_PANIC_PRIORITY(15) | \
+				      BCM2835_DMA_WAIT_FOR_WRITES | \
+				      BCM2835_DMA_DIS_DEBUG))
 #define BCM2835_DMA_PER_MAP(x)	(((x) & 31) << 16) /* REQ source */
 #define BCM2835_DMA_WAIT(x)	(((x) & 31) << 21) /* add DMA-wait cycles */
 #define BCM2835_DMA_NO_WIDE_BURSTS BIT(26) /* no 2 beat write bursts */
@@ -449,7 +453,8 @@ static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
 	c->desc = to_bcm2835_dma_desc(&vd->tx);
 
 	writel(c->desc->cb_list[0].paddr, c->chan_base + BCM2835_DMA_ADDR);
-	writel(BCM2835_DMA_ACTIVE, c->chan_base + BCM2835_DMA_CS);
+	writel(BCM2835_DMA_ACTIVE | BCM2835_DMA_CS_FLAGS(c->dreq),
+	       c->chan_base + BCM2835_DMA_CS);
 }
 
 static irqreturn_t bcm2835_dma_callback(int irq, void *data)
@@ -476,7 +481,8 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 	 * if this IRQ handler is threaded.) If the channel is finished, it
 	 * will remain idle despite the ACTIVE flag being set.
 	 */
-	writel(BCM2835_DMA_INT | BCM2835_DMA_ACTIVE,
+	writel(BCM2835_DMA_INT | BCM2835_DMA_ACTIVE |
+	       BCM2835_DMA_CS_FLAGS(c->dreq),
 	       c->chan_base + BCM2835_DMA_CS);
 
 	d = c->desc;
-- 
2.35.3


