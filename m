Return-Path: <linux-kernel+bounces-89175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595DC86EBA1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A27F1C2145B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C205916C;
	Fri,  1 Mar 2024 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKBqTVSO"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D198058ACC;
	Fri,  1 Mar 2024 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331450; cv=none; b=Qp6mHXrfViAVi3HvpM9eUoT8sKhI6h38u8kEs5sAZ8etr79zaEfcqdvlPzyM4PFVoIclVh9th+EA2uQcSk50NE5S8nZsRn+0Spc2fsECWawpJtFk93DPH1I7QoJ77uY6L+aSU6w+rsMLarOCbOAgD/EL3t0G4s5qKFVM3lZQ2hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331450; c=relaxed/simple;
	bh=RtYnoBdgyTyGCAew4GI4ZQR1HjLse4QQTxlkOcvLYvw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m5BQQEYcaVKP1CqjtxMIYgxJJ9k33lo55y85/4cFBmxpmd6LRJLAtN7MvXDknNzLr5LD8ifZISN9lAMVPUj5gIJYn+iqgENQMeDFmnQ7yhXaTmMViR8cngzgT2pWY1bLunOYuvZRuEKCdlsFUk4wNppUmDlPiIdicdzJPp4FpDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKBqTVSO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a43f922b2c5so323524066b.3;
        Fri, 01 Mar 2024 14:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709331447; x=1709936247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eX7OuHGQJSKtF4cLUl19jdWhJJb2B/RbPr2UvRdYxsU=;
        b=NKBqTVSOasxbbaEp5yzItqo+ipLDlSAgUsHPIJqVcCdPxZ2Yz/hol7NDK28kV74p4y
         G22hinpRTFX19oi4Km5puogTRIVBqM/yhriN1VJlQqQ71vbv2NV1rGTEFJ7yY0X4Qz2s
         4egDaj313TyLWuc8dt1/fv2aH8xyhd3v3VH3Zs6gri3XoU+Ets6//VbtRflp2h1N6W9c
         WVpQXMcC5q70XtcAJ9q6Sm6JUeCBlH3L4g637WNTqmMMihTn3bPVFD020y6i9GBgadav
         7udWT47URUng65AHiJsRpsNrXa/fvFRxR7J2GEk1J42zyHQ+mLCP4NVLsdDCLVCERYUK
         kHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331447; x=1709936247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eX7OuHGQJSKtF4cLUl19jdWhJJb2B/RbPr2UvRdYxsU=;
        b=FZepK+9y72YCgKSuPEEQBM/ZKot7A7YXgAoHl+eyAdpZ9rl3nWzXJom8fhSEoXf4gA
         BKPi/dI3baibvtjG5VF30gSwnudsPlDojuAfw9nrx0GbnuglYZ6K947YWquz3CeQaMJT
         CaWeYk9gVMbR3TWOlD5626+Dc0S31Izn4YGW14is0vDYPTSZfwFnddSNhcrxTb/LZ5CA
         4p2kJ2ErpQcBqUwRm+jSuXhFJt+5da+uy9cT1Dfoxd0/ectMta0mtXDF/p4SRrzFT8re
         f/rFTd40IrkO+jCQMtjkCYDbbvL2wX3MEuC8D49vAWWF+1vbnuA0j5ftFX8ucvDQbYCq
         BVYg==
X-Forwarded-Encrypted: i=1; AJvYcCWdqCMEqDA8CFlaEQ7MlC7KZZficczWBc3ZoUFsK9HOjfmvVqJ1MtWx0euLFE2G+PPbFnDbEiOvV7Xp6M9KMhmfUK04LdJEIFtbAWfx
X-Gm-Message-State: AOJu0YwIH+ETlVmnEgKefYipw1pv0sPmjYSAFjkgMoU0NON3gEXeEDLD
	v6+LSud+v5yOJn4WHfqKS+LgGTRcLTYFGpUMklx4znSDwUCPYPzjGfIdgtdVyAs=
X-Google-Smtp-Source: AGHT+IEhfwJ+k4ldaSdMniNey18iTGJ31m0VO9/5iW+JDSR2e2XpNXHO1l9/eZ/qGJhhranoHMcckQ==
X-Received: by 2002:a17:906:a391:b0:a44:512e:9e44 with SMTP id k17-20020a170906a39100b00a44512e9e44mr2311542ejz.7.1709331446514;
        Fri, 01 Mar 2024 14:17:26 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g16-20020a17090613d000b00a3f480154a3sm2091122ejc.65.2024.03.01.14.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:17:26 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
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
Subject: [PATCH net-next v6 00/16] net: dsa: vsc73xx: Make vsc73xx usable
Date: Fri,  1 Mar 2024 23:16:22 +0100
Message-Id: <20240301221641.159542-1-paweldembicki@gmail.com>
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

Patch 16 is required to avoid problem with learning on standalone ports.

Pawel Dembicki (12):
  net: dsa: vsc73xx: use read_poll_timeout instead delay loop
  net: dsa: vsc73xx: convert to PHYLINK
  net: dsa: vsc73xx: use macros for rgmii recognition
  net: dsa: vsc73xx: Add define for max num of ports
  net: dsa: vsc73xx: add structure descriptions
  net: dsa: vsc73xx: add port_stp_state_set function
  net: dsa: vsc73xx: Add vlan filtering
  net: dsa: vsc73xx: introduce tag 8021q for vsc73xx
  net: dsa: vsc73xx: Implement the tag_8021q VLAN operations
  net: dsa: Define max num of bridges in tag8021q implementation
  net: dsa: vsc73xx: Add bridge support
  net: dsa: vsc73xx: start treating the BR_LEARNING flag

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
 drivers/net/dsa/vitesse-vsc73xx-core.c | 990 +++++++++++++++++++++----
 drivers/net/dsa/vitesse-vsc73xx.h      |  56 +-
 include/linux/dsa/8021q.h              |   5 +
 include/net/dsa.h                      |   2 +
 net/dsa/Kconfig                        |   6 +
 net/dsa/Makefile                       |   1 +
 net/dsa/tag_8021q.c                    |  81 +-
 net/dsa/tag_8021q.h                    |   7 +-
 net/dsa/tag_ocelot_8021q.c             |   2 +-
 net/dsa/tag_sja1105.c                  |  72 +-
 net/dsa/tag_vsc73xx_8021q.c            |  67 ++
 13 files changed, 1072 insertions(+), 222 deletions(-)
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c

-- 
2.34.1


