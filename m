Return-Path: <linux-kernel+bounces-145129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCCA8A4FED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4B5283E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B2286AC4;
	Mon, 15 Apr 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="t7rbZXZn"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BA6745E7;
	Mon, 15 Apr 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185410; cv=none; b=RGtw/cyPhNjBe9k313d0wCe9r/q/V39AjA2HU8Tdk8KfizgwfxWHOid7ZM/E5ZSE4fcPAmRcfpXfdAFCKA9+VUn/vxK1U7vSYQ5QIl9YfHt76DGIOxvCiks+d/u5Ktwa+aJrpfeMBNmWsz/ohf7+9pDszyEWZU6Gm+kk2fQrzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185410; c=relaxed/simple;
	bh=RZViYOBc/68KZHjbxFjl/qF8BNCvvMPMaLqjwnNT1cQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ORgd+ENgck9aMYXi0anVyokS1rcB8TkB9CAB9qgfI4T+gSjuxO4K+bwESMqxlg/06g3Pe/ePp9heN15SsSlkdG9rLZpoImr2TVOxvvTeZ/QBf4uSMyhvPbB2ykoXczSy11X2JFLqp3p/7p+Lo89nb//opCZ8V0/6aHaJimx28Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=t7rbZXZn; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 012BD8801F;
	Mon, 15 Apr 2024 14:50:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713185402;
	bh=zyHbMiyALYbzRNSRQ3bVjd+xXWkKyPH62uQ6mMp3z34=;
	h=From:To:Cc:Subject:Date:From;
	b=t7rbZXZnhhOiPAMBAd3KnAFH2Y/JIUtt2kInK9KgJfVnug9MAK1S/Jj1LvY+oxT3W
	 xsIU8rzqkCkG88fq4MCy6ZUIYaJUZyf2QIOWjXjNCo52Yt0TndKFT4h3LjFvRjjMWz
	 gjMmmc1QaKIzPpK0NDRq4jaVYL2+8EEUYIt6sdiPYLIuBIYIS/k1mffCPoXu+PStlA
	 bjU7KLxDn55bT5wY/RHaYgOhOisEDtcZkLrKQk3q65G1t8nVdq9dicYzkb5vDp6pDa
	 w7GvMW+Hzr9E3gZj3aDKU/2NqdTuEJjcZsEY2g9xRPGO48ImPGaIQ72Z8HuHelXjwC
	 ujxFYu9WCLC4w==
From: Lukasz Majewski <lukma@denx.de>
To: netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
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
Subject: [net-next PATCH v5 0/4] net: hsr: Add support for HSR-SAN (RedBOX)
Date: Mon, 15 Apr 2024 14:49:24 +0200
Message-Id: <20240415124928.1263240-1-lukma@denx.de>
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

This patch set provides v5 of HSR-SAN (RedBOX) as well as hsr_redbox.sh
test script.

Applied on top of:
Branch: net-next/main
SHA1: 50aee97d1511

Runs inside: Buildroot (2024.02.1+):
SHA1: b31443e09cb7bb67b97ae6fb7614fe3a22889d50

Lukasz Majewski (4):
  net: hsr: Provide RedBox support (HSR-SAN)
  test: hsr: Move common code to hsr_common.sh file
  test: hsr: Extract version agnostic information from ping command
    output
  test: hsr: Add test for HSR RedBOX (HSR-SAN) mode of operation

 include/uapi/linux/if_link.h                  |  1 +
 net/hsr/hsr_device.c                          | 36 ++++++-
 net/hsr/hsr_device.h                          |  4 +-
 net/hsr/hsr_forward.c                         | 85 ++++++++++++++--
 net/hsr/hsr_framereg.c                        | 52 ++++++++++
 net/hsr/hsr_framereg.h                        |  6 ++
 net/hsr/hsr_main.h                            |  7 ++
 net/hsr/hsr_netlink.c                         | 30 +++++-
 net/hsr/hsr_slave.c                           |  1 +
 tools/testing/selftests/net/hsr/hsr_common.sh | 97 +++++++++++++++++++
 tools/testing/selftests/net/hsr/hsr_ping.sh   | 93 +-----------------
 tools/testing/selftests/net/hsr/hsr_redbox.sh | 97 +++++++++++++++++++
 12 files changed, 403 insertions(+), 106 deletions(-)
 create mode 100644 tools/testing/selftests/net/hsr/hsr_common.sh
 create mode 100755 tools/testing/selftests/net/hsr/hsr_redbox.sh

-- 
2.20.1


