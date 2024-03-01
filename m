Return-Path: <linux-kernel+bounces-88771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA9E86E659
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6E128F8B7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E81010953;
	Fri,  1 Mar 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="GYTWwKDi"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24C7EADF;
	Fri,  1 Mar 2024 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311666; cv=none; b=uwJlghJsBeB5eTpezEBc8ofo5fw2XN9t4KmFAChh7r+oG+1XLABCJWnBJNd6IwNQLoFHK95AJJKzaQTJXj6VtiGQ5f+NyjVkqEl0v0VOpovzrpmwTerov4iDTh23tB/6F2NuTL4d+Wg889mH4F06XEt3srMB2atMkd5JbIxOHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311666; c=relaxed/simple;
	bh=GNxAIlesOWEc6ADQOe2bdHiQI5xZvX9zwAnqPAkPVmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4ctX0brlgPk7KbsgF1hwsfvDlkkRAhkM6+OFyEHVnbkvFVsvgcV4MRcsL6YdKIR7PM6XI17DkdShy0usuc8dLKkg9TfpvblBHJBvRYSk4h5mGivIeNGM5l8Wp6vbs97HdWFQalmuweU7a/CF8pxCTwWsszf7gRG97Ng5lJS+MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=GYTWwKDi; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 180A1284253;
	Fri,  1 Mar 2024 17:47:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1709311653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZKFkvBt1S5xU1bBrsZOUCamFfWJO3BsAN++Q3u8O0uo=;
	b=GYTWwKDi7F/is8Gnwp64ERodGYRvJqXDWCjBjYgy8iVsQOS2lkmNJw44F2q5Wzb93ifWFK
	TjSuu8znmBk3UZbFPXwX1V1PmOvLRtn2aYyqhRtx0qtadqFqPRiPBrXm+P6lxdD/w5ct63
	6eQQFjDe0+nnn/A62zSwcYhdeANpiIU=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id EA5234587C6;
	Fri,  1 Mar 2024 17:47:32 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Markuss Broks <markuss.broks@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	karelb@gimli.ms.mff.cuni.cz
Subject: [RESEND PATCH v5 0/5] input/touchscreen: imagis: add support for IST3032C
Date: Fri,  1 Mar 2024 17:40:59 +0100
Message-ID: <20240301164659.13240-1-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

Hello,

this patch series generalizes the Imagis touchscreen driver to support
other Imagis chips, namely IST3038B and IST3032C.

The motivation for IST3032C is the samsung,coreprimevelte smartphone
with which this series has been tested. However, the support for this
device is not yet in-tree, the effort is happening at [1]. Preliminary
version of the regulator driver needed to use the touchscreen on this
phone can be found here [2].

Note that this is a prerequisite for (at least a part of) this series
[3] which among other things implements support for touch keys for
Imagis touchscreens that have it.

[1] https://lore.kernel.org/all/20240110-pxa1908-lkml-v8-0-fea768a59474@skole.hr/
[2] https://lore.kernel.org/all/20240211094609.2223-1-karelb@gimli.ms.mff.cuni.cz/
[3] https://lore.kernel.org/all/20240120-b4-imagis-keys-v2-0-d7fc16f2e106@skole.hr/

Best regards,
K. B.
---
v5:
- Rebase to v6.8-rc3.
- v4: https://lore.kernel.org/all/20240120191940.3631-1-karelb@gimli.ms.mff.cuni.cz/
v4:
- Rebase to v6.7.
- v3: https://lore.kernel.org/all/20231202125948.10345-1-karelb@gimli.ms.mff.cuni.cz/
- Address feedback and add trailers.
v3:
- Rebase to v6.7-rc3.
- v2: https://lore.kernel.org/all/20231003133440.4696-1-karelb@gimli.ms.mff.cuni.cz/
v2:
- Do not rename the driver.
- Do not hardcode voltage required by the IST3032C.
- Use Markuss' series which generalizes the driver. Link to the original
  series: https://lore.kernel.org/all/20220504152406.8730-1-markuss.broks@gmail.com/
- Separate bindings into separate patch.
- v1: https://lore.kernel.org/all/20230926173531.18715-1-balejk@matfyz.cz/

Karel Balej (2):
  dt-bindings: input/touchscreen: imagis: add compatible for IST3032C
  input/touchscreen: imagis: add support for IST3032C

Markuss Broks (3):
  input/touchscreen: imagis: Correct the maximum touch area value
  dt-bindings: input/touchscreen: Add compatible for IST3038B
  input/touchscreen: imagis: Add support for Imagis IST3038B

 .../input/touchscreen/imagis,ist3038c.yaml    |  2 +
 drivers/input/touchscreen/imagis.c            | 70 +++++++++++++++----
 2 files changed, 60 insertions(+), 12 deletions(-)

-- 
2.44.0


