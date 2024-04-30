Return-Path: <linux-kernel+bounces-163729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025C38B6EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294DBB20C05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59E21292CE;
	Tue, 30 Apr 2024 09:58:51 +0000 (UTC)
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5F9524D9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471131; cv=none; b=hwWOEasb6LqnXC5P2Tu4l8f9RSoW/ANLteM4G5lTxNoQu06jDgKZWFFvc9pVioYkmZl7s0EOgs7d04ZX+ABYsrpChRnqJ+NnDLgc4RvM4j1AxH0sxDxTdUXZcuVm8U9zAU2tNmD6tgwfRPN+vOONYBU2n6nH77NnNuYSzSgWdNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471131; c=relaxed/simple;
	bh=/KiparKJcGssaSXcaY9DhuXObnYmcgTksV2FalgHiHI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hueh2izcaKBkc0Smiotpdwh45nFgxWDPpwc20IaAeVtcEdjp0dRBi+Spv1p2YsbtUa4yBMBs+3Vwnf8NSyHQ7iqF74Bo2aWM/GAextfiIEAdhFj/hPchmnWdqZTfiLcZpRiryfwmlv4YPulU3n2fMpK9qOFH5G79P++LN28C92A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3367349:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 30 Apr 2024 17:58:29 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Apr
 2024 17:58:28 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Apr 2024 17:58:28 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <alina_yu@richtek.com>,
	<johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH v2 0/4] Fix rtq2208 BUCK ramp_delay and LDO dvs setting
Date: Tue, 30 Apr 2024 17:58:23 +0800
Message-ID: <cover.1714467553.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

This series patches is for hardware modification of RTQ2208.
ramp_delay range of BUCK is changed.
The maximum ramp up and down range of BUCK are shorten
from 64mVstep/us to 16mVstep/us.
The LDO's Vout is adjustable if the hardware setting allow it,
and it can be set either 1800mv or 3300mv.
Additionally, the discharge register has been moved to another position.
In this version, a software bug has been fixed.
rtq2208_ldo_match is no longer a local variable.
It prevents invalid memory access when devm_of_regulator_put_matches is called.

Alina Yu (4):
  regulator: rtq2208: Fix LDO discharge register and add vsel setting
  regulator: rtq2208: Fix LDO to be compatible with both fixed and
    adjustable vout
  regulator: rtq2208: Fix invalid memory access when
    devm_of_regulator_put_matches is called
  regulator: rtq2208: Fix the BUCK ramp_delay range to maximum of
    16mVstep/us

 drivers/regulator/rtq2208-regulator.c | 166 ++++++++++++++++++++++------------
 1 file changed, 106 insertions(+), 60 deletions(-)

-- 
2.7.4


