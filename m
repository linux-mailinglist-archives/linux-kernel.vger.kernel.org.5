Return-Path: <linux-kernel+bounces-139914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D238A0918
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C79B282936
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50B413DDB0;
	Thu, 11 Apr 2024 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qiu8HGyu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D9713CAB3;
	Thu, 11 Apr 2024 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819166; cv=none; b=odZv3LkCeRmM1sbe/X+yvGXU+0rM4zVHv1oA0NJI8Rt0SSzU/ucsDelpBy8CFGOKXTtxK/DcIS+CXsQOCiNdYEwm7hRpp7b4Ld65g+/2Rd3h4UKDFzKb+oRAANH0RitHdexsgANo6/UHYnY6ddIrUJUE+cWAyKYCPFLp9UaIqvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819166; c=relaxed/simple;
	bh=Ms7MWhYSgoVLEWFhl7RcDsGUnMu4a3jpqyQRCc+1JyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pvsQirx0KDYcGRSUUOKu1gYjTs3oXCMOwXmiLB22H06ojOyAy/bow2vSkIFeWiG50YqHcGm7m6jarj57pMULBj6ZGwvB75dscwes41mJHhVRZNPBZLNkyZBNAfbBaMh6x+Y7kuiR1gsWfMv88YbfLqSUDU0HIQORYfCxhErVXz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qiu8HGyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA075C433F1;
	Thu, 11 Apr 2024 07:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712819165;
	bh=Ms7MWhYSgoVLEWFhl7RcDsGUnMu4a3jpqyQRCc+1JyY=;
	h=From:Date:Subject:To:Cc:From;
	b=Qiu8HGyuTMrzRYWC4zn1orwGBCW2MIpxyIuhmWW0E2KHCxu88kduNIZn9AHWMhbLM
	 1rtMlBldX8rH2qJ2DwGchWjArr1tNrrH+9fJaV92hIM1vHUn1LMNjBJ3itBdWCoEgZ
	 YL2i/Jfq1UABuZx4SxntZUBKAceTozQfGOY9pzC4lQPOZ3PWnFn8vSwV+kCVBsaLQK
	 ZTFSYdo3SjiBita1Iz58OUJYtZu1YkRXqzt3byR1Hx3+0U4Y2nl6/4M5QxbWr6LBPM
	 7ly0xVltPjVQGezwtWTP/aQ6Px4ULZTCwEiDPgYJZnh43u43nxW/zyBxrDccj8c6sT
	 +stP4P7ToFjTw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 11 Apr 2024 09:05:56 +0200
Subject: [PATCH] HID: bpf: fix hid_bpf_input_report() when hid-core is not
 ready
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-fix-hid-bpf-v1-1-4ae913031a8c@kernel.org>
X-B4-Tracking: v=1; b=H4sIANOLF2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0ND3bTMCt2MzBTdpII03bQkM3OgWGKymamBElBHQVEqUBpsWnRsbS0
 ANYJovl0AAAA=
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712819164; l=1376;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Ms7MWhYSgoVLEWFhl7RcDsGUnMu4a3jpqyQRCc+1JyY=;
 b=tLc066LRWOxZye4PVz2dESDMT6CmvYLPRXg7AV5V7wdt1ZyReiZsy3iLPsDz+F2G0j3jgiNP3
 XyO3H/qDj6oA1L6putW3JnjQdIq6EextwtUn48ibUFZ5B0T8aYira7q
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Reported by linux-next:
After merging the hid tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

x86_64-linux-gnu-ld: vmlinux.o: in function `hid_bpf_input_report':
(.text+0x1c75181): undefined reference to `hid_input_report'

Caused by commit 9be50ac30a83 ("HID: bpf: allow to inject HID event
from BPF")

I just forgot to put the indirection in place.

Link: https://lore.kernel.org/linux-kernel/20240411105131.7830f966@canb.auug.org.au/
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Seems like an overlook in my patch.
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 79ece3d1b9e2..10289f44d0cc 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -534,7 +534,7 @@ hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *buf
 
 	hdev = (struct hid_device *)ctx->hid; /* discard const */
 
-	return hid_input_report(hdev, type, buf, size, 0);
+	return hid_bpf_ops->hid_input_report(hdev, type, buf, size, 0);
 }
 __bpf_kfunc_end_defs();
 

---
base-commit: 685dadafbde29dc3d6b7a13be284d684b06d4d4f
change-id: 20240411-fix-hid-bpf-fb67411ac650

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


