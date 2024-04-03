Return-Path: <linux-kernel+bounces-128886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D78E89617B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D7F8B21D26
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E425A10940;
	Wed,  3 Apr 2024 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nlf0t3H9"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910DAD27D;
	Wed,  3 Apr 2024 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104407; cv=none; b=q5AZjwyxnGlpfiNvT9k016WIv8KdAQd8yrx1GRUkZGBjEBISjqIywn2pH8yq11Pob5scsFZHai8kP4kKcz6bDqJPSWs2zvx2tPSYS+gl6KOg3lXvAkvobSVQxgonZWXgRU3y9aH8WACSII0EFq3oiU/T652WE4NRaJIot4bOYWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104407; c=relaxed/simple;
	bh=wlqbS0iWcvDOtnH6Up89ddhadh8mmCeV/H+ekQX1rjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vi2sSDWtOsci+mllQVgKXqcc7DSumr0EClN1iPV49O2GJ7aXpiLB35NcOjloYEaqcll3JYczOUP56kIY+6zXA3G54r4iwF3oYi8jDcK6CsVHWjpO2AylNICVQzoTYcvV2FfzuI5i456aroxJbQ2HQLOBKEvgPkBz0KIim6ViIyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Nlf0t3H9; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4330WBTN012514;
	Tue, 2 Apr 2024 19:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712104331;
	bh=U5jePWUlmko66C4akO7oCc9+oDZxq85XB30Qa3gIcr4=;
	h=From:To:CC:Subject:Date;
	b=Nlf0t3H9Fndpe8T+m1xcyjwJbZa2dWKdi3WFrfvrZeGSj69Awth6+fvWwUq+ROQX/
	 CXTWTfuZO+zZr75w4Pf7AL0NPEaNzGxaekNGFJxJPXoA+1XucTqtGGSXyv19fwKFTm
	 1DlYt3mnEeLwJsCsg0DD1oAcpG4gIcUUIFl3/IPA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4330WBnk008565
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Apr 2024 19:32:11 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 19:32:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 19:32:11 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4330W2J9079729;
	Tue, 2 Apr 2024 19:32:03 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <13916275206@139.com>,
        <mohit.chawla@ti.com>, <soyer@irl.hu>, <jkhuang3@ti.com>,
        <tiwai@suse.de>, <pdjuandi@ti.com>, <manisha.agrawal@ti.com>,
        <aviel@ti.com>, <hnagalla@ti.com>, <praneeth@ti.com>,
        <Baojun.Xu@fpt.com>, Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [PATCH v8 0/4] ASoc: PCM6240: mixer-test report
Date: Wed, 3 Apr 2024 08:31:54 +0800
Message-ID: <20240403003159.389-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

mixer-test report:
 root@am335x-evm:/bin# mixer-test
 TAP version 13
 # Card 0 - TI BeagleBone Black (TI BeagleBone Black)
 1..7
 ok 1 get_value.0.0
 # 0.0 pcmd3180-i2c-2 Profile id
 ok 2 name.0.0
 ok 3 write_default.0.0
 ok 4 write_valid.0.0
 ok 5 write_invalid.0.0
 ok 6 event_missing.0.0
 ok 7 event_spurious.0.0
 # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
 root@am335x-evm:/bin#

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
Shenghao Ding (4):
  ASoc: PCM6240: Create PCM6240 Family driver code
  ASoc: PCM6240: Create header file for PCM6240 Family driver code
  ASoc: PCM6240: Add compile item for PCM6240 Family driver
  ASoc: dt-bindings: PCM6240: Add initial DT binding

 .../devicetree/bindings/sound/ti,pcm6240.yaml |  177 ++
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/pcm6240.c                    | 2070 +++++++++++++++++
 sound/soc/codecs/pcm6240.h                    |  236 ++
 5 files changed, 2495 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
 create mode 100644 sound/soc/codecs/pcm6240.c
 create mode 100644 sound/soc/codecs/pcm6240.h

-- 
2.34.1


