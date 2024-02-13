Return-Path: <linux-kernel+bounces-64350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBE7853D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7541C27E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C8762157;
	Tue, 13 Feb 2024 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emH4ojZ1"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87C60BA6;
	Tue, 13 Feb 2024 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860414; cv=none; b=TOXpZ2BZpbtkO/S0d8xzm5LMza+J71VAo8FV1xJ03XVqZERroS5rvnL63kp1eO+qGDJzVIArmzceLrGFj21jmuvsE0GmYsR+O6flYNyJL2urb6UbJZpdVulGDiy564c5SckgK3o8r0rg9YeqQJnW06f08LlqEIbjFsV0opB0enk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860414; c=relaxed/simple;
	bh=LkL2QMQiyyNde39vRKxk+dgt9HEbxB8lTPoOaWAPo8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BUQ8vqqD0UChCnZWe669t4IqjA360ZxLboPayMkWoZQvBC9iMMdHQQldTPPLigF9CglmEShTnHkLPC7ubXgC+Du0JYEkNuhvh7u8VRcDTdk4vFIHvVXqePTFf+JJowK1FRzsl+O/ztVYA7P6KRlMz7f+Va7SlzkhRhgR0k4yPiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emH4ojZ1; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d1094b5568so14068471fa.1;
        Tue, 13 Feb 2024 13:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707860411; x=1708465211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5xgi+WYpzjICsbXZzOuF2PrstHj2bvLsoG7REleosZE=;
        b=emH4ojZ18gRJ/YabiquJqYOe4qtP1G3Y4GL2SZnC/Xs5YkUT9iOa8R5jr9A7TscomP
         t0KqJTeNMsWNT4rKza7xOIVVRMYjxbJ7s9Q7S1uZaeTg3igRc6pSYb1lbvsjCvU5uNYM
         GvRzte+V5EAH5nOX+eNrB7jGQ8Ejs1BmIUYOxvOGWe+IuP0Y89TTNlFbMxTMjL7YioGw
         5FBlhGcCdyZRvW5RdxaHlzvcdUUYWGAbklaLxJULbRMuwNUP27UZyPgn5MvumU1to7k3
         XHHo5nG5QQa5QH85P3glW1BPkq5Vy1hcNHtHzHiGKaauucW4Ys2J2vlfGHDizzil/yr6
         gIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860411; x=1708465211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xgi+WYpzjICsbXZzOuF2PrstHj2bvLsoG7REleosZE=;
        b=u6b+49QPJCMb8lgtg7RetXCJEOQfeDEK9RsuwRsvOZw77qISswUecOfUHBhzxSN4HD
         RZTsO3UJnMFeEUxlEWAsnisU92Uu3BPS72Ao7GAkCTUEWZ3amvU/fYtBzOh5KKx3fJAN
         mXs10dIOSAzwBRtHXDa+Ki84/karBM7mJ6cOmPcg4m5xBnodwaiquFCHc3uEY2g8KaGe
         a5GQdOUiJnclBYAzsZVWD/JqWyz6weKDB1xXTaF8/mzerAnTVGfxAVC9iAQ1knyOMwub
         zRWhTZcSGp9oGyiRn17jo1tHZTpIiabAzt8+ZcTUdEJV7BiLgIc/MueRTfsSGaanWx8R
         5rUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkkPu7dIuu3X9Uf4qn2xCgaWijSXRoXWR+5lbdhyG8jTgVYwc0A2hoS74xTOwzfdGyHiKamR7iCWZ+49N+/YoEcI9xl0KXefg9II448s1hK7GEuFA26+4EQ4SUTp1i3VL74d85
X-Gm-Message-State: AOJu0Yymt0LvtZT0j7cQ5dQweWPN0YVKwoIpL3MhZyN3pc5fAt7W5Y/5
	fbL1MD6TBS8dG/7gnKNeybf2gVszRgKFDIeM3LWX6tzXi5Feyemm
X-Google-Smtp-Source: AGHT+IGOmnaHBOwP1iSu4U6sJK/sdqgVMs1njrcbnR1vZCjaZOsUsiEYgMEG/WmfEhN9NLq7naZrlQ==
X-Received: by 2002:a2e:b047:0:b0:2d0:d011:259e with SMTP id d7-20020a2eb047000000b002d0d011259emr692572ljl.18.1707860410635;
        Tue, 13 Feb 2024 13:40:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXytDIkNuibQr5jz3xMB+bu1nnzrTrku0T7xvLTbI2AqG10Y1IcVD4Lnfz8I4tGnkHz1bZaQj8mj/WJNHvO0FJ9D53TwDex1hm3dalFfntHbjl9Y9LX6wqXYmVayTrxN3xQ58n8vmRXt3zZrdVhcH6yabRxCEPNkrcnHhG9kGo8cm6Kl83fuTNdMyDPwFE1nCGQy4wC3Ga88JO3dRu83GcemTMdf0VoY+CE6axUUlN2vX2BsdDq/GhOjq9cV6YVpo5VogVV12DzyVqTrmd25lOdFfI0yglRIiCG6OXyr2ntjfWJXrDHLRZqsF3BvE6hf2BP1X1R3woNc0XGO2V2lRSUbuI=
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id k23-20020a05640212d700b005612987a525sm4003913edx.89.2024.02.13.13.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:40:10 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 net-next 00/14] net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY
Date: Tue, 13 Feb 2024 22:39:39 +0100
Message-Id: <20240213213955.178762-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
	- used defines MDIO_CTRL1_LPOWER and MDIO_PMA_CTRL1_SPEED1000
	  in mv88q222x_config_aneg_preinit
	- use genphy_c45_loopback
	- mv88q2xxx_read_status reads speed, master or slave state when
	  autonegotiation is enabled
	- added defines for magic values in mv88q222x_get_sqi

Changes in v3:
	- mv88q2xxx_read_status includes autonegotiation case
	- add support for 100BT1 and 1000BT1 linkmode advertisement
	- use mv88q2xxx_get_sqi and mv88q2xxx_get_sqi_max, remove
	  mv88q222x_get_sqi and mv88q222x_get_sqi_max
	- fix typo: rename mv88q2xxxx_get_sqi and mv88q2xxxx_get_sqi_max to
	  mv88q2xxx_get_sqi and mv88q2xxx_get_sqi
	- add define MDIO_MMD_PCS_MV_RX_STAT for magic value 0x8230, documented
	  in latest datasheets for both PHYs

Changes in V4:
	- clean up init sequence
	- separate patch for fixing typos in upstreamed code

Changes in V5:
	- add missing statics for mv88q222x_revb0_init_seq0 and
	  mv88q222x_revb0_init_seq1
	- fix typo in commit message: autonegotiation
	- fix ordering of Signed-off-by and Reviewed-by in commit messages
	- add interrupt support for link detection
	- add suspend / resume ops
	- add support for internal temperature sensor
	- add cable test support
	- call .soft_reset in mv88q2xxx_config_aneg, this makes
	  mv88q2xxx_config_aneg compatible for Marvell88Q222x devices and
	  remove mv88q222x_config_aneg which is then just duplicated code
	- cleanup mv88q2xxx_config_init and make it compatible with
	  Marvell88Q222x devices
	- move parts from mv88q222x_config_init to mv88q2xxx_config_init
	  that are applicable for all Marvell88Q2xxx devices.

Changes in V6:
	- add copyright and where the code is derived from (patch 5). Sorry
	  Andrew. It is already reviewed, but I think it is the right place.
	  Didn't remove the Reviewed-by because the changes doesn't touch any
	  code that is getting executed.
	- add HWMON dependeny in Kconfig (patch 8)
	- use IS_ENABLED(CONFIG_HWMON) instead of ifdef CONFIG_HWMON to support
	  hwmon built as module (patch 8)
	- drop shift constant MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_SHIFT
	  and use FIELD_GET and FIELD_PREP instead(patch 8)
	- drop shift constant MDIO_MMD_PCS_MV_TDR_STATUS_DIST_SHIFT and use
	  FIELD_GET and FIELD_PREP instead (patch 9)
	- split previous patch 13 into two patches.

Dimitri Fedrau (14):
  net: phy: Add BaseT1 auto-negotiation constants
  net: phy: Support 100/1000BT1 linkmode advertisements
  net: phy: c45: detect 100/1000BASE-T1 linkmode advertisements
  net: phy: marvell-88q2xxx: fix typos
  net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY
  net: phy: marvell-88q2xxx: add interrupt support for link detection
  net: phy: marvell-88q2xxx: add suspend / resume ops
  net: phy: marvell-88q2xxx: add support for temperature sensor
  net: phy: marvell-88q2xxx: add cable test support
  net: phy: marvell-88q2xxx: make mv88q2xxx_config_aneg generic
  net: phy: marvell-88q2xxx: switch to mv88q2xxx_config_aneg
  net: phy: marvell-88q2xxx: cleanup mv88q2xxx_config_init
  net: phy: marvell-88q2xxx: remove duplicated assignment of pma_extable
  net: phy: marvell-88q2xxx: move interrupt configuration

 drivers/net/phy/Kconfig           |   1 +
 drivers/net/phy/marvell-88q2xxx.c | 630 ++++++++++++++++++++++++++++--
 drivers/net/phy/phy-c45.c         |   3 +-
 include/linux/marvell_phy.h       |   1 +
 include/linux/mdio.h              |   8 +
 include/uapi/linux/mdio.h         |   2 +
 6 files changed, 615 insertions(+), 30 deletions(-)

-- 
2.39.2


