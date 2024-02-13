Return-Path: <linux-kernel+bounces-64419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E882853E16
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945731C28EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B0262157;
	Tue, 13 Feb 2024 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrTEgkaC"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2086168C;
	Tue, 13 Feb 2024 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861882; cv=none; b=d94BErKriFi9ReKsNX2tXTNXGIEmpSofEX96y5XRB2vAz97pjnv/QdUeQU6JdoZpOhOzLA5bo/9tf9wVcYm4hjmIWsLspWrgtboaKSJgHnUGYGdNKleTybNJiUTHGZLOArDZFig+jIz+PIvOo3VB0slpIXcZUEMuE0rUIZyqIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861882; c=relaxed/simple;
	bh=dKqZtTLc45KoJCCIgdU1ZkLj49H1pqeoe+o3/5yfvqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bKgyjNcAkKuw39ltmol7I60iLmAqVo7BHKNGckcTNrdcZQF5KZFmwQPeFHxf2Zniwp8j/5A4AOGwAAxVkhX0lRoQZQPTAfHXLf1droRNnO396u8wfGw7RKQWRdd+HNGjefGeq7R+OzQQNALtv0TDld0+vrBDqQQglhD5TZK0gMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrTEgkaC; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3cc2f9621aso149883766b.1;
        Tue, 13 Feb 2024 14:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707861878; x=1708466678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7mWQWt5oyL1VODqmZv9zqn+1WNyN1jr5CwPq7mjcwIE=;
        b=YrTEgkaCBGHwn4SeG5VBG/FZsgbT1SqxkIU2dkQLRABbaxuPm7XQjqNPca8ew04nWG
         cSnXKKZGFJy5r0E945uHnnhBWGSVM5g7aDgK3tnv+eMGafAdn5dZWOT5U89PxGBu6RWA
         HFSkSoEIKDcBZ6M8csSMnSerbkJITfCqx7xzbuTk7s/M2pYZp+Hisv0NA0tVNJul/AHm
         Mdjyp58yflPVh8Y/ZBG40Y1+iUBUC1MLcPfKjvgm9aW6VTuPndqxd/SVq241VxBGEuhw
         nbYFlQ2OkQZiqZXNpxQB7gUvI2ZJqk+LNpU/p42cNDBSZovnfxvtM0l5RMM5OR8iIekV
         KJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861878; x=1708466678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7mWQWt5oyL1VODqmZv9zqn+1WNyN1jr5CwPq7mjcwIE=;
        b=YLb0vL9KTJOf6JbG9Rz/1AmfVDC9RDuPaa/6YCKoC/J8tci8O5XsMhjpzABRWQ6KH/
         tp2PD8yjNr3DDouq6H0e45JMXIJbab1lLcwSHIsnZSlmhVT/4tSfczutF4RYRh6+F0TE
         G5TCirpxnKhRJYLTLHtW20M5PJnzXh8aw+BPcl2BmRvUXvdHvmZkTRaE9GD/ubYpP+Ar
         Ijvcr+6fvv1HBZdQzi+e4kjl1pbzO603k0WdCUrYtaE9epDMTDOosKkmD4fhL/k+BzL0
         6jgmmQy4I5qANteZSgi98K2Z4AcpHugHJJgSrg8e7xEfYWBl01Oe0kFgZxKjKMu24PxH
         RKrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW1y4DnDo/LpjJp2w48LZvg9S5UdzpaqIzjFd2foj2jU5vNC2zaJDE9I7q4XjBMT0Xs07BwHFoA/p248Ekx1vM+jeDixwXyvE2/YKS
X-Gm-Message-State: AOJu0YxNMs2OwJhK139Hl79s8H/gDp8Un2/AaMq4n8OhlhwIB01PIrhX
	udrWLVYZX0UqfO5VaZDhG0M0AJdCKzp4Af3FqAcPJvsP1uan9eId/9tSeOfePhc=
X-Google-Smtp-Source: AGHT+IF93pJf3fsZO9Cz38+5oDk04H6zyybzYGaLTAx0+X3UKBfPsvNRLN57uLUSrZZDtz+iwYbaYQ==
X-Received: by 2002:a17:906:689:b0:a3c:881c:8d9a with SMTP id u9-20020a170906068900b00a3c881c8d9amr409649ejb.22.1707861877786;
        Tue, 13 Feb 2024 14:04:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW43t3bZZI1FnIltuZYaHbFcglVT6xzDA0rwFgjVqRYuoHPcupWHGGPuTrMG4fO0EJNLA6kRIKDQsDcmFdXxxIUfDzKKDCSOay0AFq9SiDe82WsH0dd2oIc+q9G5bGgKtNEJaWO+3iYx29Bh6pqpcumZsWv2mr5enGyvWrJNENZGrmXLPTrPYK1iSV1Ii6+VN2ArjEXg/L4UHTWTidW3Sj1h+q32wqBKXv5N9vFdC9eORYxaLDwBKUB1TUW8nT/tTqQUvouPTVZCgLQERhcTaffCE5iPq98WcrNqlUM8XXoeXLYCeoDxrUSj6jC84m6CekM5Wy1GmuBNWKqmOZc/pKGF/BXFpGEPXkfGda+85YBLyVn2RWjd603NQXccXPd4PMW/OACFMDWIN6+Mk5rCd9DWeiNXnobh8JzWv19gCeRbuYsvpUIV99rf9v5vYJNmygnQujdBNO7Vw==
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id p12-20020a170906b20c00b00a3bdf8ae86asm1706800ejz.10.2024.02.13.14.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:04:37 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 00/15] net: dsa: vsc73xx: Make vsc73xx usable
Date: Tue, 13 Feb 2024 23:03:13 +0100
Message-Id: <20240213220331.239031-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series focuses on making vsc73xx usable.

The first patch was added in v2; it switches from a poll loop to
read_poll_timeout.

The second patch is a simple conversion to phylink because adjust_link
won't work anymore.

The third patch is preparation for future use. Using the
"phy_interface_mode_is_rgmii" macro allows for the proper recognition
of all RGMII modes.

Patches 4-5 involve some cleanup: The fourth patch introduces
a definition with the maximum number of ports to avoid using
magic numbers. The next one fills in documentation.

The sixth patch implements port state configuration, which is required
for bridge functionality. STP frames are not forwarded at this moment.
BPDU frames are only forwarded from/to the PI/SI interface.
For more information, see chapter 2.7.1 (CPU Forwarding) in the
datasheet.

Patches 7, 12-15 provide a basic implementation of tag8021q
functionality with QinQ support, without VLAN filtering in
the bridge and simple VLAN awareness in VLAN filtering mode.

Patches 8-11 came from Vladimir Oltean. They prepare for making
tag8021q more common. VSC73XX uses very similar tag recognition,
and some code from tag_sja1105 could be moved to tag8021q for
common use.

Pawel Dembicki (11):
  net: dsa: vsc73xx: use read_poll_timeout instead delay loop
  net: dsa: vsc73xx: convert to PHYLINK
  net: dsa: vsc73xx: use macros for rgmii recognition
  net: dsa: vsc73xx: Add define for max num of ports
  net: dsa: vsc73xx: add structure descriptions
  net: dsa: vsc73xx: add port_stp_state_set function
  net: dsa: vsc73xx: Add vlan filtering
  net: dsa: vsc73xx: introduce tag 8021q for vsc73xx
  net: dsa: vsc73xx: Implement vsc73xx 8021q tagger
  net: dsa: Define max num of bridges in tag8021q implementation
  net: dsa: vsc73xx: Add bridge support

Vladimir Oltean (4):
  net: dsa: tag_sja1105: absorb logic for not overwriting precise info
    into dsa_8021q_rcv()
  net: dsa: tag_sja1105: absorb entire sja1105_vlan_rcv() into
    dsa_8021q_rcv()
  net: dsa: tag_sja1105: prefer precise source port info on SJA1110 too
  net: dsa: tag_sja1105: refactor skb->dev assignment to
    dsa_tag_8021q_find_user()

 drivers/net/dsa/Kconfig                |   2 +-
 drivers/net/dsa/sja1105/sja1105_main.c |   3 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c | 837 +++++++++++++++++++++----
 drivers/net/dsa/vitesse-vsc73xx.h      |  53 +-
 include/linux/dsa/8021q.h              |   5 +
 include/linux/dsa/vsc73xx.h            |  20 +
 include/net/dsa.h                      |   2 +
 net/dsa/Kconfig                        |   6 +
 net/dsa/Makefile                       |   1 +
 net/dsa/tag_8021q.c                    |  81 ++-
 net/dsa/tag_8021q.h                    |   7 +-
 net/dsa/tag_ocelot_8021q.c             |   2 +-
 net/dsa/tag_sja1105.c                  |  72 +--
 net/dsa/tag_vsc73xx_8021q.c            |  69 ++
 14 files changed, 968 insertions(+), 192 deletions(-)
 create mode 100644 include/linux/dsa/vsc73xx.h
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c

-- 
2.34.1


