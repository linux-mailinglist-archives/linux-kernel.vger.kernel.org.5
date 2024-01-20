Return-Path: <linux-kernel+bounces-31920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F433833662
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D472829C1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D1C14F9B;
	Sat, 20 Jan 2024 21:17:31 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1288CD271;
	Sat, 20 Jan 2024 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705785450; cv=none; b=i7UQpYRHj1GQAvsN0l3z0puI6BdILirN8OgcvwgrH4M0kiBvQW22110Q+3ycmIMhzI2v8QmcELXfa7a87GH73Z/MGdoCqeUL72x1vIpYTfPApFZ/4s3nw6mB4hMPFYp5W0FSpGcEQQiBcOfKvdQKiKoY3NRByvlrCrdCwWTgH54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705785450; c=relaxed/simple;
	bh=q7UK9lOJPCvczhT7DUtbVyl+7z3he5gbmXulJNOF1b4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CCyxn2z/25zPy/Ud5+SR24xu7gAvPx0hXtftl7fFLdmWF9ln4hDBQwPuc6H+VNkYa8RXQDGJH8PvI71i30WAErMCVhG5ZTyKKkHIn9AxzkvwwyVDJ6LzaWlQY03/UULeQ7qln0oj/H+cIEjl/4/csb+BpWnRP2oUcqpRUv5EYes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 9FB4B86C5E;
	Sat, 20 Jan 2024 22:17:18 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH v2 0/3] Imagis touch keys and FIELD_GET cleanup
Date: Sat, 20 Jan 2024 22:16:11 +0100
Message-Id: <20240120-b4-imagis-keys-v2-0-d7fc16f2e106@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABs4rGUC/x3MSwqAMAwA0atI1gZiLIheRVy0GjWIHxoQRby7x
 eVbzDxgElUMmuyBKKea7lsC5xn0s98mQR2SgYkdFUwYHOrqJzVc5Db05OuRQ1lUjiBFR5RRr3/
 Ydu/7AVlDOqpgAAAA
To: Markuss Broks <markuss.broks@gmail.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=q7UK9lOJPCvczhT7DUtbVyl+7z3he5gbmXulJNOF1b4=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlrDg6kYyT3GCT201jpoYoGmIY0VFivQCjLMraA
 kRMBHQZY3iJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZaw4OgAKCRCaEZ6wQi2W
 4TdMD/9+Qpx4LBKCyXivZZbvw4bDtLsmqkrRvjitOdRxAIoZYC3NOT4cfixuIM1z5fI+aBlBf+H
 7j2R8TUZVxSebLNmaYWtIQF64MfRr0d6fDkVSPZR7MpLbsE6VYcIQm6NVqhgalt6j3TGPf7JLnq
 ZklqDzdvGwAlUrcV4Ro0KlI+sXFm2q/1ZKR1VS4ZvVVMVR2SjVBjMQTIeUZ5ErPRbveL0G5jQk6
 bmD8T61rfuluhc0UcjjXdavijJ6AGDcxynLSgkrWip8PS4rvjP/GGxZiJ0i7ItLfnVpztWxl3hZ
 z6vroT0I7DvMKPaqdsfnYTwT1O7tY1vFREkd6zwD2kSLnzzY1Upd6BmfGSLRIo9bFNFwRJh5Fib
 PXQ66SUcxpNuVacWd9TBV8p7nshXaq/uB7Vr7VTe5LyE0JimgHgbupnIKbnggre1kfWuShX/xxR
 PXqfzRJgGNyvzpVErN8zFscle1Syi0ok5PXGxl3TlbwPswA5CM3Xgd2zPpWCmjGsCsnSO3YSpBI
 D4ks+XNPCeEtUmHzI9UW/X7LN4klL9RUfnCa1IjNrVyad2AzFjH3S18QyrIw1fTKjLbxub08rKM
 o9QQ1Hg4OeRAJX4R2cNVQwdsyzI0FEOmpeVP9iK561U/toJpvzmOOqxzHovEKYcyanT1QA+L4MZ
 Y//kUZgyKxFIR7Q==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Tiny series to clean up the field extraction and add touch key support.
Depends on the IST3032C series (at least the touch key patches, the
other one could be split up):
https://lore.kernel.org/20240120191940.3631-1-karelb@gimli.ms.mff.cuni.cz

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
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

 .../input/touchscreen/imagis,ist3038c.yaml         | 11 ++++++
 drivers/input/touchscreen/imagis.c                 | 42 +++++++++++++++-------
 2 files changed, 41 insertions(+), 12 deletions(-)
---
base-commit: 553f2a83ae97246be401ca9b313063f5fa879f12
change-id: 20240120-b4-imagis-keys-a0a9f2b31740

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



