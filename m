Return-Path: <linux-kernel+bounces-37910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA0283B78A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4FE1C2439D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933FD63D1;
	Thu, 25 Jan 2024 03:08:57 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562B71FB2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152137; cv=none; b=WpcJYqsvmDoMCcZDSFUDz3BipdneWnQ8xzOaEa4h6f8QN+Kat72PnocH/YvJEcSi+lzNKPxCgBQHZ2Xkv1ipfK5v7qUSquSkEAqhNvhz72B6Sy3/N5FUEoV+6QxIq272CQ+fav2mVlHQOjZw+GVSo30hb23ZGpuJ6VIN7CRsGF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152137; c=relaxed/simple;
	bh=n/DGsSIprR6XGAQ6RgUSyszmBIaUb47hbAeYspfQ4mg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mQVJrk17Sm2QFuD+U75AhLYq+oI1NZWTTXtJOAXf3APKCAG5qRYHOuP6wHyA2h44kG3yA68MijjdD1+b3fzJI3eaIRnLiRzUJpM9aTS5i7GflEpu6Jfnwk1kIduYxwzQTQ1fWgpbyzx61EOuG3iGJS6Ra35DKP1xWRkc7fGTZ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40P38asi061327;
	Thu, 25 Jan 2024 11:08:36 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TL5F31L4pz2Rq2lq;
	Thu, 25 Jan 2024 11:01:11 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 25 Jan
 2024 11:08:34 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Wenhua
 Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
        zhaochen
 su <zhaochen.su29@gmail.com>,
        Zhaochen Su <Zhaochen.Su@unisoc.com>,
        Xiaolong
 Wang <Xiaolong.Wang@unisoc.com>
Subject: [PATCH V2 0/6] pwm: sprd: Modification of UNISOC Platform PWM Driver
Date: Thu, 25 Jan 2024 10:55:27 +0800
Message-ID: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 40P38asi061327

Due to new usage scenarios, some upgrades are made to unisoc's pwm driver.
Patch 1 supports the change of channel offset on UMS9620.
Patch 2 supports more brightness levels (duty cycle) for backlight control.
Patch 3 optimizes the calculation method of duty.
Patch 4 converts dt-binding file from txt to yaml
Patch 5-6 update pwm-sprd.yaml according to patch 1 and patch 2.

Change in V2:

-Change dev_err to dev_info in PATCH 2/6.
-Add maintainer to gitconfig.

Wenhua Lin (6):
  pwm: sprd: Add support for UMS9620
  pwm: sprd: Improve the pwm backlight control function
  pwm: sprd: Optimize the calculation method of duty
  dt-bindings: pwm: sprd: Convert to YAML
  pwm: sprd: Add sprd,ums9620-pwm compatible
  dt-bindings: pwm: sprd: Add sprd,mod attribute

 .../devicetree/bindings/pwm/pwm-sprd.txt      |  40 -------
 .../devicetree/bindings/pwm/pwm-sprd.yaml     | 106 ++++++++++++++++++
 drivers/pwm/pwm-sprd.c                        |  71 ++++++++++--
 3 files changed, 165 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.yaml

-- 
2.17.1


