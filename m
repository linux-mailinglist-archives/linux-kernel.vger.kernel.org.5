Return-Path: <linux-kernel+bounces-120560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B7F88D95C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A389D1C27145
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E578136B1D;
	Wed, 27 Mar 2024 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZO5BfdhX"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE502E85D;
	Wed, 27 Mar 2024 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529029; cv=none; b=Bf6K5oXf7afDhpE589j14pKZ/DMXch6fJlgUBL6bv9qFfqfvdhORroSsUgKnlG4GC3ZcAIUf/k9TQtv6lrzuNDT/H6ThvkofDneuKM/vTa7p6tbj18zZ2r5EHW0tTyjrdPCdfMgCVX7CNDOKL79S+WYsjrKntm4X6lCMU5SPbKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529029; c=relaxed/simple;
	bh=Be4IEMfgO+NQg96KLT0RH17FuIbGLM/+Ly84HY6myDo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QQrndv7XHBXqKOOTHjIVt1ZEuMYDXGnrnWz/gJdy8Gf1RHdfUZPCtfSg5Ss6SQRQXi66+JqETLgWFUAIVGWzYgTNdMdywciPhFC+fOjLzIAt7+XOQ2SSjLV9i1syuFgM1LEatliAMssrOAmdwms+3QjBGAewHwwGSyqvm5N1Oec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZO5BfdhX; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F331FF803;
	Wed, 27 Mar 2024 08:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711529024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i89OkT3P+4nNC4N0ixmTN+nbvd6Z0Vz30h4VrjrK+ZY=;
	b=ZO5BfdhXUTtz034fILAk2e8gSpW4pJqYWrIiRgzhypuo0klMWW63VTrLvOjbYTRaFler6M
	5m4BR+PMnojDrpRkBNbtdUqtaZxaSn7LX72eESNjTq1AJBuayH56PhOZBeDVfXL1WrzunB
	Z2lXvTUJnDT72qzL2wdPhngwTfPpniYSUJBNbvU2avLnveplvi1L4TCz1f1WQW47q+yRS9
	f3xGr6Yp/v4mZ23pqU7BrtR4PJ804hTKD0mQfP4QGOL5tVidbw7Zwd7mx/0jrBX4jaG6+U
	xPqO7120ohaQNqJS69JEp0RG8GQB8hnqgtOhVfVAB7QdnH5fhjYMSXe1rpKxVQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v3 0/3] Add multi mode support for omap-mcspi
Date: Wed, 27 Mar 2024 09:43:35 +0100
Message-Id: <20240327-spi-omap2-mcspi-multi-mode-v3-0-c4ac329dd5a2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADfcA2YC/42Oyw7CIBBFf8WwFgMD9uHK/zAueAyWpIUG2kZj+
 u9SN8aNcTOZexfnnifJmDxmcto9ScLFZx9DCWK/I6ZT4YbU25IJMJCMQ0Xz6Gkc1Ah0MNs/zP1
 UbrRIsQJXNbpulBWkALTKSHVSwXQFEea+L+WY0Pn7e/FyLbnzeYrp8RZY+Nb+tbVwyqjjRyehN
 rZVzVnHOPU+HEwctvG/IZZLYYVwzCH7gmx2C3yMAMRPGBSYcthKWVe6NeIbtq7rC99ttdFtAQA
 A
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Miquel Raynal <miquel.raynal@bootlin.com>, 
 yen-mei.goh@keysight.com, koon-kee.lie@keysight.com, 
 jeremie.dautheribes@bootlin.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2080;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Be4IEMfgO+NQg96KLT0RH17FuIbGLM/+Ly84HY6myDo=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmA9w/c9Cnfvrqqq1MDDNUKvNAz41Dvk9GITU1loRj
 A8OVKIiJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZgPcPwAKCRAgrS7GWxAs4ihlD/
 4/Q5DgfZ1iSI4FrQZ7Pf67vcWlI1/96ahnk+N+PMw8Pbtm3itcncI96DPxrwr5edOaCPF7pom0C93J
 byF/fwZYNBa/oZq0JHO8D5fY9jnmgyGLsOqyOOMhR+ihypn7aKXQkAq/rd50d7LGAgIELRZfoK5Tlj
 29Vi7pbp6t1sBWSXRAtXrkh53QoPA6TJvZF7PBfmPdpWcw7riIcvApkoIeOV02HV24DSLdxC8oaVEQ
 A38s6HuYbb/qb6AG72cYJALK9w9sbUcFGQYT9senwHMJhJT0AeluyhHiNZam+RoYoOTvBSmpTPNqh0
 fjkoJ/tHq+Dt6n4l466vrW+0dz/zHUekO7AEkCG/PcS3xaNod2uxg5Oj2EBiU0eGPlZ4iGIQ+RF5MG
 JzFa9dKFM9y4kd2IAKN3f5W6PsyniueCsk1CLatn5B/hMG2pOnN1jcOEErkhfiumgBsRhStg58LqH7
 xu6VMWYD0VuUGWEF20ebJ7YQz82YgL7xdkhf5M9dyffItGlwFHFY3+gVZVZa6oqFIQBqbCgMGtE9rH
 L2mVk02Go5eD6Qv4CWBGTB3IwxcLuLpUCx81taJqrB+ISBcsoUlebzAJNb7cCt55aGQT/c4KcZTwDz
 DAvtBEOj6tgmVGQHdKSkg5a1OX1+709/NaexU1Qm/gxIG2ugo4uq1dN3Osug==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

This series adds the support for the omap-mcspi multi mode which allows
sending SPI messages with a shorter delay between CS and the message.

One drawback of the multi-mode is that the CS is raised between each word, 
so it can only be used with messages containing 1 word transfers and 
asking for cs_change. Few devices, like FPGAs, may easily workaround this 
limitation.

The first patch removes the current implementation, which is working, but 
don't comply with what is asked in the spi transfer (The CS is raised by 
the hardware regardless of cs_change state). No drivers or board file use this 
implementation upstream.

The second patch adds the implementation of the multi-mode, which complies 
with what is asked in the SPI message.

The third patch is the suggested optimization for using MULTI mode in more 
situations.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Changes in v3:
- Fix compilation warnings found with allmodconfig
- Link to v2: https://lore.kernel.org/r/20240223-spi-omap2-mcspi-multi-mode-v2-0-afe94476b9c3@bootlin.com

Changes in v2:
- Updated the commit line for the first patch to use the correct format;
- Updated the commit message for the second patch, adding precision on how
  the controler works;
- Added the suggestion from Mark Brown to merge multiple transfers word 
  into one when applicable;
- Link to v1: https://lore.kernel.org/r/20240126-spi-omap2-mcspi-multi-mode-v1-0-d143d33f0fe0@bootlin.com

---
Louis Chauvet (3):
      spi: spi-omap2-mcspi.c: revert "Toggle CS after each word"
      spi: omap2-mcspi: Add support for MULTI-mode
      spi: omap2-mcpsi: Enable MULTI-mode in more situations

 drivers/spi/spi-omap2-mcspi.c                 | 95 +++++++++++++++++++++------
 include/linux/platform_data/spi-omap2-mcspi.h |  3 -
 2 files changed, 74 insertions(+), 24 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240126-spi-omap2-mcspi-multi-mode-e62f68b78ad3

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


