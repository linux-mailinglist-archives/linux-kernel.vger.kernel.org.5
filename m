Return-Path: <linux-kernel+bounces-78017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB284860E05
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2E01C238D7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0015C916;
	Fri, 23 Feb 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c+CIh3+7"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EFE5C8F8;
	Fri, 23 Feb 2024 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680777; cv=none; b=g5etB6sgDj1bLhFQLLKWODzTaI25NPgiiO2EJLqRr5dHmQ5pJqEgrxuCXjkpNe6MEx4ZysL9yhK3Hb9ujSjt3bSF6rE4MirNYKO0EqXa/c7OiYovhbWD5t6sP8HIX9RKus3SIhlG06ULiRmE5ZBcjr6Gl79BSsCOBGSfeymFWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680777; c=relaxed/simple;
	bh=mEvL7/gYsYZ1cJJ7RW2LMAVRTvamARtEVGX5pY48Ceo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bU61i3jr6P188iEDLqJeJJ6H+oRj9VjkFoXMlcSXwJYWktuKnPcLGhf7e6sW495nkDdoe7AHGFfVQv5f3xL3lAbd3RV+1Gql2EgkAVmjQ2VKdTUaOqoVFs+d2ZogIiBFAF2yPjvPHHwtt5NtG75vGk8G8utxxobudjeLNp2o/0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c+CIh3+7; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ADADF20009;
	Fri, 23 Feb 2024 09:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708680767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hnXzPpHTj+T9YeQJru+i3t1PG7BaiX5w87lRUOTBO18=;
	b=c+CIh3+7NW7eYmh/AVp/oGIxz9WJ7KyJyUocnGE+Gkxf10/lI8uzylg887LV0uL9K9VG70
	Nm5ma4fr++lr1eFGov7xZAJKpfudcgKIBHYl//L+F0HNGyXVNQRnWH4Nqcwn2XgRosJvWU
	e5XHF4vjmlFVIZl5+BqKDvJKDWWqidH9KQXUs716NUOdqA5QCvFdMU56qXuSdLSParGfJo
	88vZsljcKkJKNQCtQrBLuic8PBUMZfalyECZGVMsRK0+tfwZrzIGBn7plLJ1WkZWxNyyHf
	6kg75lpGELxPov3Xh0+UuryoWn43VzU+dhig8171yPZyNL7kbJCxK4Uw0Y1KwQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v2 0/3] Add multi mode support for omap-mcspi
Date: Fri, 23 Feb 2024 10:32:10 +0100
Message-Id: <20240223-spi-omap2-mcspi-multi-mode-v2-0-afe94476b9c3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABtm2GUC/42OOQ6DMBBFr4Jcx5EXAiRV7hFReBkHS16QDSgR4
 u4xdOloRv//4r1ZUYZkIaNHtaIEi802hlLYpUJqEOEN2OrSESOsJpQ1OI8WRy9Ghr3as5/dVG7
 UgKFhpulk2wnNUQFIkQHLJIIaCiLMzpVxTGDs5zC++tIHm6eYvscDC93XU66FYoINvZmatUrfR
 feUMU7OhquKfpefhmhac825IQbIH6Tftu0HjCZc3iABAAA=
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Miquel Raynal <miquel.raynal@bootlin.com>, 
 yen-mei.goh@keysight.com, koon-kee.lie@keysight.com, 
 jeremie.dautheribes@bootlin.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1903;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=mEvL7/gYsYZ1cJJ7RW2LMAVRTvamARtEVGX5pY48Ceo=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl2GYtkgipQhcSQ6jGnKMzjV2Id3VvGxSRzKlVc5WG
 7PWbSOuJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZdhmLQAKCRAgrS7GWxAs4jqUEA
 Cygcn/3ypJxayMGlmEuFiN1yYm2cn9RgmxBaoa1wMO3px6TpBhp8vPDMXmvT2WYt6wgHxUYixf2Mml
 2j6mUKjA/1YHxoHzSdhzIil/hylyqnBQ8mwLMD0RyPd4eHz3gEB+7zcZKIkHKMcYg93y+bY3BnC0cJ
 mlFrQXwF5T0SsT3WgY8dLAcBAaBYhYQHzO9xQfP0rr6aAaPxFztwNuM7CTg+9dChp6rCu1n5RCp+ae
 8t4a1V35WmArc1TOafki4CYydxenOix3Vqj9+HD4qtM2E9blt6K858QS97Rm/7Ez7oTXQEvjhA1eGG
 W0nE3PZiME/CrXbMg3dZjWxI91rZL0HtvAXf/W4o5VZ40B3rZ/+jHttvB1fv4Vww6PJm3lqQL5Us5m
 DEJRqPqp00Krb94QerLGzFoIgU9ARgoWhh3JXf3RrNNuaMo2sEn1I7QFnZJikdtj7/4FBG5bKUT2r/
 ty/hm3Rp/I96jyj5NEQ2CTA6MtJ/9+g5cnL1ovUTeQAgmjI+0OzblWGHOF+kYDYJeE2ARXf8XgcxIC
 YZLqaqEOQMvSaNtS+jj1LFhHm7msKWDauvplpYnEHM4ujGiGy49bHZYjHTjjGwnrl7NUJz5GAA9zAG
 5A27b5qfF8mwGt+W7UsofB21Wva4lMWgPMV9mfVKGMVwW1ttdk2yD9xsyYFQ==
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

 drivers/spi/spi-omap2-mcspi.c                 | 96 +++++++++++++++++++++------
 include/linux/platform_data/spi-omap2-mcspi.h |  3 -
 2 files changed, 75 insertions(+), 24 deletions(-)
---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20240126-spi-omap2-mcspi-multi-mode-e62f68b78ad3

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


