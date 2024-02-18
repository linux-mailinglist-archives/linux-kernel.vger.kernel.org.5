Return-Path: <linux-kernel+bounces-70258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0351C859557
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7115A1F21AA1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3614E56E;
	Sun, 18 Feb 2024 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0ttSnfQ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CB82903;
	Sun, 18 Feb 2024 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243081; cv=none; b=Ms6774vWYv5NEDkGS3QbiCxUDmHl8irwg47YL2rgtFjTZiR2UCjDfFCV17K4jMi0q7OewntZDGvnQLaxNqcxfanIr2bcAFyAL5jtax3nAcC4g3EujBObLAubPMKxOCrpGBtwpS2d0DQ4aNVY3A+TA172Waa/qiG3Qqw6tSR3ifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243081; c=relaxed/simple;
	bh=niUdSdZH2M2PkKxoK0UU8OXfTdka6tGuiqend9RSynM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rd3Ny85o8JbjTmLXEVsILG20UGIplFBZkUTQRSGfXPQ504ZIV8R3qwqrDYWAftfbh+sAtYlUztL+vEvqPYmXlBPHnDgNqqKUgo8xebgJdHhC9VSn49yrBx/J3S3xUjNC7a5KvTtOPPoaZ5sWnrCIt/Ch94egJ/X4xf6Dd7Zjs9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0ttSnfQ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e7f7b3d95so7675166b.3;
        Sat, 17 Feb 2024 23:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708243078; x=1708847878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lTVqjqgKw1ETC+oMyZeqtgkr+oHu5hVNHdodzDyKUeM=;
        b=E0ttSnfQ60Kd43woxhbM8jlinwcVAhE1qvuuJWyGmdW6lBQB8ZWz65pQ0hVveJmZRi
         74BJpdlJMvCn8Tl49AZiIVmpDgfeCgITDu5wYjafXxAmjZE1I/i4oT4aLryKlQgs1mlp
         FXpHRyqRFoH0YcZy49EAV5wRqzeLcJ8+Ih0MQ5q2iSgMC9NBDOwpeF4bysSWXVqYM85q
         KNgZr/at0n8CrDpeXpJsaKAKYEdFF9XrUlfSxNo0VmVsLFBcvQ2QWSvS3ZP7h6fpZg8o
         u1xXPAeAZ+Bb+6g2UgM5Ww2kXUyfEAclxy5at5hB5ZKvClhApb1NiYJYTYDh8HoTKESD
         3+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708243078; x=1708847878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTVqjqgKw1ETC+oMyZeqtgkr+oHu5hVNHdodzDyKUeM=;
        b=bVfqnflDmNrgkkgtlVwcrqYOXJS0cCwjcPa9R4wxg1D0r3gbEbfg26+JaHqYhp/Mnu
         ZRtQ3mH7EZaqa0UFMf3rKzWBSKmtAK/CoEtpCuy1SZSK5tYI1CdSO1ag28XAQ5NTe8hl
         r1JgHuo6CzH37+QrJTYgc3HGz4qjIFz7xmsKDaYvWpyaDK3uD250hqh/0so1QQvbdzYn
         jCgB5BDEf8WZpAbdUT2eHS5V0poKZ+wONdQRCdbG+TJofcy20PKj2PbhjLOHy2drb53f
         hgTFIEe4hLMjgjS+rOKQXnxhyFVzXv5+UjFjBcSejSSSkvbrDUrMFpHjvKBMY6oNEOW+
         iayg==
X-Forwarded-Encrypted: i=1; AJvYcCXUCauR4IloznZYzWQB/NxVjKTX0DOPQ3OlKlQ1Sk3Q8TYYCre/Ai/46fn8XpEIVbVSH2dORIr6FB2dGTVHjT56e0SEJrmntyHWuRUc8XXR0HPTm0spuAhGogiqJZGmTfOEVDaQ
X-Gm-Message-State: AOJu0Yy5ezo2F2wRTnAcDiNITEaF1dRofruLj2JG9uwocNRkc+alLoqW
	B+R/0+ZYgRN6acguw6iXf7IWdJjb3QqvW4LvWq50NldKMI4aqr//
X-Google-Smtp-Source: AGHT+IGI4YJxjuWZALbks+/NjtROdQL+kd518F75va/Y4eBv2syELGGGxjU1IeppquwzEZn+Di7+SA==
X-Received: by 2002:a17:906:2ddb:b0:a3d:c3c4:8e1b with SMTP id h27-20020a1709062ddb00b00a3dc3c48e1bmr4761650eji.65.1708243077446;
        Sat, 17 Feb 2024 23:57:57 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170907984c00b00a3e64bcd2c1sm458732ejc.142.2024.02.17.23.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:57:56 -0800 (PST)
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
Subject: [PATCH v7 net-next 00/14] net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY
Date: Sun, 18 Feb 2024 08:57:37 +0100
Message-Id: <20240218075753.18067-1-dima.fedrau@gmail.com>
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

Changes in V7:
	- Check if cable test id done, rather than checking if test is in
	  progress

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
 drivers/net/phy/marvell-88q2xxx.c | 640 ++++++++++++++++++++++++++++--
 drivers/net/phy/phy-c45.c         |   3 +-
 include/linux/marvell_phy.h       |   1 +
 include/linux/mdio.h              |   8 +
 include/uapi/linux/mdio.h         |   2 +
 6 files changed, 625 insertions(+), 30 deletions(-)

-- 
2.39.2


