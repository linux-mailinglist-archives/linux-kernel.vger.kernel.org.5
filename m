Return-Path: <linux-kernel+bounces-60854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E016850A2C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776621F23767
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1D85B697;
	Sun, 11 Feb 2024 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="WGr4kqiA"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E4A5B5D3;
	Sun, 11 Feb 2024 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666998; cv=none; b=aXqWR0eHzuT85tkoHQgxazMRQDg5seElezOvx1c/G5ej8nV/vAWqoJA7EGeS8fGrDlBuHhrM94fKbofb6N3bMJCCGCzqCED32321N3l4CwLeMyagJMVOu6g3/KEoPwe5a6lm2T43dOh24nXXe+11JcI0WsYHTUPN+NAk11k3jKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666998; c=relaxed/simple;
	bh=JL7wM1V7zi48q2tm3KhTIyENAubtfNi2N8isyzcuzH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bvxWNIFK5unVzHA/YWgZaALZK88G9ZdXJUTB98bBGOwelgwEfqTHvgshVi0VkrzlkwSs4qyKefiU1iN9mHSaKeTSBRTF5ypjFlg3SDIcLl9TRlWuK+vZjpHD11nbHBk+nC01P+s7cTLjnWIeMMxOrwivIOZXoLDmgcLjF2qG6QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=WGr4kqiA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d958e0d73dso16689785ad.1;
        Sun, 11 Feb 2024 07:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707666996; x=1708271796;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=911kXH4ufHtqEqUf7Y7+h9ODYaLzmiao4LnKiF6mOcg=;
        b=XgrAeHON5A8bsYqYXEcgnQTr4uekmtsOzHzmUwKJJQRFDRUOfr5U9A67EDpKiLIvJ2
         5hCtHZtB58Tyjp9upbjiO5sucLYf1RimHrIgeKCvC5Sr+wGABgHK9dmwNutrHxUOVkD1
         Hr8h+cTSHHe8sPmTrDgm1weGy+uvelrob0vdOMuTk9bvhYzcXdz2Lt8piCkAb/TZm8qa
         DMBarIwbusfmwP2US+j/yGDT3a7QimV9YtES1IB6dsZuozo0/IPf8iwJEM6t+Xj0N/gn
         yGr+nSB8npD+erXKeZYak/sDX2oPwiBtSWIk/9UIQUL+R29WZNZzxlTpfScpE1eTPo+V
         ph4g==
X-Forwarded-Encrypted: i=1; AJvYcCUAuQ4IGo7mu2oldx2hNATD1hk6e0bH4yVR4E3Y5VXh9lT+8O1QVjJqaxwVl5h9DzVJBT0Y+s+T/DCIJnLz2bdqxeOnSoWCbJtJhFUUNMRzL/7DuX48pAQqmDRRzOLv5/tJ8dGtLNpcpqqR3xVMqok=
X-Gm-Message-State: AOJu0YyTGk6VwuxD2jAd99+RbvYvskiewBXyBxdJO8X8BIG58rFYOVdY
	Ga8Yyn2l2Wv8HcTMYzMISaGnoP8pfTVv9F3X/+yR9PJ3gCBD+xiO
X-Google-Smtp-Source: AGHT+IHbbOE2f+MVZKuK8zEihQ0jBBEHixQhYe2gxKyR16KoP235HaoQgl/akaWRUv5Fi7mLSUTzRQ==
X-Received: by 2002:a17:902:d3cd:b0:1d9:65e6:4af7 with SMTP id w13-20020a170902d3cd00b001d965e64af7mr5077571plb.30.1707666995850;
        Sun, 11 Feb 2024 07:56:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvZ0cfdSs7HN0afcmxNPCzh8FFNpAkX0vG5Pa9ByrNyckv/49cDVCA3E3/2E76Jrk4FRYfox8ASYMQXIXuPR2AlGwiPLQVZK1xgfyl2rxjnocsIaIuLV1/W6Rv+s9sq0iBBW8xAJaauJZwz8gh9XbbJzgb0EesA2amSS8ufht7tpi+G6BXCm/p7b7aE2xDk0hojFbrEUYfIxLf+2X64lkxEWG0b+mY99J2/7Ixwjb1cHAlCJxhaLRfsmjl
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id q11-20020a17090311cb00b001da2fdd4cdesm382064plh.36.2024.02.11.07.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 07:56:35 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707666993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=911kXH4ufHtqEqUf7Y7+h9ODYaLzmiao4LnKiF6mOcg=;
	b=WGr4kqiAxicDTFPSP4TLYKFD6G5W+om/ZVQ9Aim8XUK4x2gZf0y9EpMGGdTykvKvLg2Dqc
	tR+V/WAXzMsaKnHdqmD4GsKeSWTrHExhXDCSQOqu7LPctlcyPAXkqVJv5MbHS1Sefgsqzq
	YBbip/C9JBqbfSxHb3qrV0vUaGdwj1cn0U//o25gUQrVZkkLH+3c9hHlgtP8G7DGYwfycY
	fah+8PS24SUjBvUaIj6wFyTKLf/pw39M3pxDiYLSgUQGg1c8JYP0zthfgMnQ3mimsVuczn
	zzOEbtAk2V96GhW3moNxIYKCzNak/vmcBZ5/xdVhmgkPEAKmXLOz2A+FXF6+Jg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 11 Feb 2024 12:57:09 -0300
Subject: [PATCH v2] ARM: s3c64xx: make s3c6410_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240211-bus_cleanup-arm-v2-1-3de9e8af7cbd@marliere.net>
X-B4-Tracking: v=1; b=H4sIAFTuyGUC/3WNywqDMBBFf0Vm3ZQkGChd9T+KSB5jHdAoEw0tk
 n9v6r7Lc+Cee0BCJkxwbw5gzJRoiRX0pQE/2vhCQaEyaKlbqZUSbk+9n9DGfRWWZxGsHLQx0tv
 2BnW1Mg70PovPrvJIaVv4cx5k9bP/W1kJJYyXSmpXuy48ZssTIeM14gZdKeULNyN8urEAAAA=
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1816; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=JL7wM1V7zi48q2tm3KhTIyENAubtfNi2N8isyzcuzH8=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlyO5XnZHv5b2f8/C1CrZ/CQ/xR5XfxSFsC6ctQ
 DRLdfRIhjCJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcjuVwAKCRDJC4p8Y4ZY
 psC5EACIcACY8NFjRlUc+Ac83fBdxJGOdlb4wcheBAf+p6myyYifsA1cK/sh6PDznQaB5tYB8Od
 T+SiTn7VSWTxIehbTArgxR+C1CrQWqZbyPe4IsMBX9g7jlkJS97dw78CWVlUz2JqCVP6C9j6MkM
 hPFvLs5GIPlYlbOyjNvHsX3iLC3QRr+dODlJKoWIIz5Z30cOOzRItASOrbq5ZyCrTI6bTlPlEin
 OKWy3pCk+5eArCBvti6IpVR4W4IDCWhHTkJ/qRlbZZnj0mFv1Cip0maAiSp57dFk7JQjy3NWJG9
 eyqWLc+OXg5DW3qq9S6k/gGfzq0SNk9l4YHKvx+q3vz4cUZcG/QGiHx5stvjgWA6ZRgzer2bEdb
 9zC4oTxLBBkBpEGea7oB0M2mIm/xbP+7QGJCJu/5sVFdt35Mzrbf1a6sOft8QzRwIUty5eS2moo
 stY7GHNHpqzHmQMpxM8JK8lm0P4LSm671h7dzutQ5Myn6QiXrBEEB7pubn/aCyZyggiMc02aZ1J
 9wrX7jQtkGO1fcPPMrA9W8ZS4AXi6Ln8ygdEewchcXc5fh6vn6PgXoemj3A6abgNs2xE75WIwhb
 EcqAEwAk1eCdlXmzuAChU1bHHeEANUA/MVIMmnryTmJGK+XfMgAnMj2Gz0AHOlEzsxo37ceWdpQ
 2AnV+/HcYNaxZug==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
a const *"), the driver core can properly handle constant struct
bus_type, move the s3c6410_subsys variable to be a constant structure as
well, placing it into read-only memory which can not be modified at
runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Changes in v2:
- Instead of "Now", defined a specific commit in the changelog.
- Link to v1: https://lore.kernel.org/r/20240211-bus_cleanup-arm-v1-1-5c0102bda0bd@marliere.net
---
 arch/arm/mach-s3c/cpu.h     | 2 +-
 arch/arm/mach-s3c/s3c6410.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c/cpu.h b/arch/arm/mach-s3c/cpu.h
index d0adc9b40e25..a0187606b999 100644
--- a/arch/arm/mach-s3c/cpu.h
+++ b/arch/arm/mach-s3c/cpu.h
@@ -76,6 +76,6 @@ extern void s3c24xx_init_uartdevs(char *name,
 				  struct s3c24xx_uart_resources *res,
 				  struct s3c2410_uartcfg *cfg, int no);
 
-extern struct bus_type s3c6410_subsys;
+extern const struct bus_type s3c6410_subsys;
 
 #endif
diff --git a/arch/arm/mach-s3c/s3c6410.c b/arch/arm/mach-s3c/s3c6410.c
index e79f18d0ca81..a29276a4fde5 100644
--- a/arch/arm/mach-s3c/s3c6410.c
+++ b/arch/arm/mach-s3c/s3c6410.c
@@ -57,7 +57,7 @@ void __init s3c6410_init_irq(void)
 	s3c64xx_init_irq(~0 & ~(1 << 7), ~0);
 }
 
-struct bus_type s3c6410_subsys = {
+const struct bus_type s3c6410_subsys = {
 	.name		= "s3c6410-core",
 	.dev_name	= "s3c6410-core",
 };

---
base-commit: fee3a71dc8d26629e5d87e20cff08763f522633f
change-id: 20240211-bus_cleanup-arm-da0f2550ca48

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


