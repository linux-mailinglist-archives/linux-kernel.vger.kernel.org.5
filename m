Return-Path: <linux-kernel+bounces-155216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 716548AE6F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4441F23F90
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FBB13443E;
	Tue, 23 Apr 2024 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="f3qLH8hl"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0FD130E5B;
	Tue, 23 Apr 2024 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876567; cv=none; b=qoCHst8zlRGNu8MRjPsdQ9roIeLfcSGHoANQm3kaPjZeNWAggHBG0QRnauzg6LmISzg6BISbLUkWhj5kGuXjmN6sEcQVmMCIQQ4ISkp6Cmzm4REekbYH7FVd/Pc3aaSwvtwAHeHRLu5ZmoZxb9wDSKfeq6mIb5J6QAF6MbBtZjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876567; c=relaxed/simple;
	bh=oM/QClw0lexR1wRtj45iY1WsJDpcigmQopGhpEoonR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TYpbPsN2Tbwa03jZxqjiKNMqFleC7EPeAMgFCx+0kzUmYTlPcL9iqBh2ruH140aoXDVmecPU06sQbvTUGUWAYRd0DEz9Yvzf6vhQLdclOzTh8gBL9IDkuK5rXViY9awD1CGbVdB0TmWRww+5btIRYOW6AzGh2NkzdWuJxKeCR3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=f3qLH8hl; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 90B1C88371;
	Tue, 23 Apr 2024 14:49:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713876563;
	bh=uMJafPMhykroFDvF8uV6g/GGANywMwLnnHnVCVXHuiI=;
	h=From:To:Cc:Subject:Date:From;
	b=f3qLH8hldPTSc+kj/7KNmqs0Yk8q7qRO3mJ0Z13M+axQuNBLNxAxPFLO16L6ffA2m
	 WJobjHCIka3nMbzvnVmRSUsfVTUbqJEdkNv5ed4MVkCttqQnbRY7H2Opsi8aFWdo3b
	 kj2HxUIODJQS4iWaS+5LSybssGHdqn68vb22CcV7Vp5rtqdDPU6+tjGi8Ro3zWp7XG
	 MzIVzR/cDEcDe6HpdBOuFSb7DD+uFCSyaf61EABbWoUyNqEIQIgMy/pyh4OTV/kno4
	 nEdXqABKnTUzoAeg37DgvZIvFP4BbvDYfjndlO416udtii/kV9xGvDb1EYDweeGwlX
	 ZmZ6u+Bo26+fQ==
From: Lukasz Majewski <lukma@denx.de>
To: netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Casper Andersson <casper.casan@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [net-next PATCH v6 0/5] net: hsr: Add support for HSR-SAN (RedBOX)
Date: Tue, 23 Apr 2024 14:49:03 +0200
Message-Id: <20240423124908.2073400-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This patch set provides v6 of HSR-SAN (RedBOX) as well as hsr_redbox.sh
test script.

The most straightforward way to test those patches is to use buildroot
(2024.02.01) to create rootfs and QEMU based environment to run x86_64
Linux.

Then one shall run hsr_redbox.sh and hsr_ping.sh from
tools/testing/selftests/net/hsr.

Lukasz Majewski (5):
  net: hsr: Provide RedBox support (HSR-SAN)
  test: hsr: Remove script code already implemented in lib.sh
  test: hsr: Move common code to hsr_common.sh file
  test: hsr: Extract version agnostic information from ping command
    output
  test: hsr: Add test for HSR RedBOX (HSR-SAN) mode of operation

 include/uapi/linux/if_link.h                  |   1 +
 net/hsr/hsr_device.c                          |  36 +++++-
 net/hsr/hsr_device.h                          |   4 +-
 net/hsr/hsr_forward.c                         |  85 ++++++++++++--
 net/hsr/hsr_framereg.c                        |  52 +++++++++
 net/hsr/hsr_framereg.h                        |   4 +
 net/hsr/hsr_main.h                            |   7 ++
 net/hsr/hsr_netlink.c                         |  30 ++++-
 net/hsr/hsr_slave.c                           |   1 +
 tools/testing/selftests/net/hsr/Makefile      |   3 +-
 tools/testing/selftests/net/hsr/hsr_common.sh |  84 ++++++++++++++
 tools/testing/selftests/net/hsr/hsr_ping.sh   | 106 +-----------------
 tools/testing/selftests/net/hsr/hsr_redbox.sh |  92 +++++++++++++++
 13 files changed, 387 insertions(+), 118 deletions(-)
 create mode 100644 tools/testing/selftests/net/hsr/hsr_common.sh
 create mode 100755 tools/testing/selftests/net/hsr/hsr_redbox.sh

-- 
2.20.1


