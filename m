Return-Path: <linux-kernel+bounces-94087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B72ED8739BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5755B1F21EEE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A9D1353FE;
	Wed,  6 Mar 2024 14:48:30 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057C91350CF;
	Wed,  6 Mar 2024 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736509; cv=none; b=PMFsBBcPvwtHGbdZJeHFNT5HiwwRbB1Q8rYL8/XilpGusxLkAhnBVHu/tRihD9nSWrzQHP4CegwCgMyK8DtjGbwHusLA3yYSCHyQSTekBiPs+C1nPAAte4EEkme14XlQGKHPd4I+HQqJLHkBXiURDLgNBAaaaw5bawCIogtdxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736509; c=relaxed/simple;
	bh=ZLIrWSqEXHYmOYdkocwfkmctpEs2Bp0z62za8bv5iG0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fxtEbz16OGI0eDu7bQmXxf0Zk2Tdpg0CG7TBRYPG4sqo/B1/VmArh2Dqa0hsTCgdiKH1NCPLmmj3r05wvLFXKt70n1//2f1XGnc7Xh8sUa+Ty28fxwiVeTJHfEQLLdWHXeskh9IfL5LO9TBGNhbvA8JIIe7RN2+eaEG9/3U99/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 4F9878599B;
	Wed,  6 Mar 2024 15:40:22 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH v3 0/3] Imagis touch keys and FIELD_GET cleanup
Date: Wed, 06 Mar 2024 15:40:05 +0100
Message-Id: <20240306-b4-imagis-keys-v3-0-2c429afa8420@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEWA6GUC/3XMQQ6CQAyF4auQrq3pFALRlfcwLAboQIOCmRoiI
 dzdkb3L/yXv28Akqhhcsw2iLGo6TynyUwbt4KdeULvUwMQFOSZsCtSn79VwlNXQk78EbnJXFQT
 p9IoS9HOA9zr1oPae43r4C//Wv9TCSNhVoXVlYHFU3mycH3IeItT7vn8BJSgzoasAAAA=
To: Markuss Broks <markuss.broks@gmail.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=ZLIrWSqEXHYmOYdkocwfkmctpEs2Bp0z62za8bv5iG0=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBl6IBOA8pYvWBd6TxKPBPS9Jo/htCHJ15FkBRiP
 NNWJ1fGRN6JAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZeiATgAKCRCaEZ6wQi2W
 4TKBD/9yycbRdRR4C8NOOzvq1cQl8hdTemeI/6Ki+1H7RCX+Mn2gMui1chIP6nfGOPffsBjJ7dg
 3cJXjDrd7qkaoB5SckuM/FuaiNOdnABT/q+eyzeYAY7m9yQLQaw7zVPkfubJyQikFU/xfAXrC1Q
 hM5jzIiFu8Q+RX1+mizoc/b0BU0a6b/edDGukiWVLTvPDO68xMoUrZi4/F5JaBUUIOBeDPmb+P3
 CcPCR+DEfnpOraSyVY8J/smsPK55Mo8Jy8rsM8u7vWHylbI0zqk2XkFG9XFeqw/v6QJsk6vR5Ue
 VK8N8jjiT9NrHjbt8EKpp8nNXcl/3ia6lEEX2Nd+AXDdwPjtCVuuiIFt/G3woeVU5PennkFmou+
 AZRK7vlOAPTRyQPt7I5xqYMaW2zdOH+lT8UOpg787pskcy6TJCogabhMMOrGrpaj+Xy0IHh7daV
 46oPe992nY565aZOD7vc9KnpVYIXAg3EdVUs+LuamDaW6x/iQXtvrPkXgv0Dqf/XYz8JsaO3p7x
 7JbmgeoovbJopsdkR6+oQRcA6VseTa7WG5fsg/egw0ekPiBd2Vya21F1Cl23emQimXEqw75q8dj
 zHc40XRaNYIbYe9NC6//8AgO2TBLlk/9ZNNe4pGM7UgciGCo2LMTB17/TOLSjcIUD45xlYiuSbU
 ddmIZAPkkpJ8fAw==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Tiny series to clean up the field extraction and add touch key support.
This version is based on the next branch of Dmitry's input tree.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v3:
- Rebase on input/next
- Add changelog to binding patch
- Fix binding constraint
- Allow changing keycodes in userspace as in 872e57abd171 ("Input:
  tm2-touchkey - allow changing keycodes from userspace")
- Allow up to 5 keycodes (the key status field has 5 bits)
- Link to v2: https://lore.kernel.org/r/20240120-b4-imagis-keys-v2-0-d7fc16f2e106@skole.hr

Changes in v2:
- Fix compile error
- Add FIELD_GET patch
- Allow specifying custom keycodes
- Link to v1: https://lore.kernel.org/20231112194124.24916-1-duje.mihanovic@skole.hr

---
Duje Mihanović (3):
      input: touchscreen: imagis: use FIELD_GET where applicable
      dt-bindings: input: imagis: Document touch keys
      input: touchscreen: imagis: Add touch key support

 .../input/touchscreen/imagis,ist3038c.yaml         | 19 +++++++--
 drivers/input/touchscreen/imagis.c                 | 46 ++++++++++++++++------
 2 files changed, 50 insertions(+), 15 deletions(-)
---
base-commit: b0f3f9ab419c243389da6c0dd6a9db0eea560146
change-id: 20240120-b4-imagis-keys-a0a9f2b31740

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



