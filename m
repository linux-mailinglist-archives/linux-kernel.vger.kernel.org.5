Return-Path: <linux-kernel+bounces-89141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E750786EB14
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9524C282442
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10A057336;
	Fri,  1 Mar 2024 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="o3EQfbtt"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9C3A1D1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328116; cv=none; b=bLHOf1c/xLu3CPPBIWT9GGsg98b0utMqDg8860cUj0o7XNOE54PWSmWS7/cdqTU9m8ML7X257PSBFy7VC2xIHpuMj0zP2tz1nrdwvtfNVft+TJlK+Jbok21Bc3Di/q0F1C83GOc3gKVr8vDGbdz9fd7PQ4RHH/ftZP6wkv6wM+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328116; c=relaxed/simple;
	bh=eMX9lL1CM4JCPZjgVhFpZok2LOHX9u+EYOu3IYUUZ2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Dii6bZLmHQkUe/c40sR3K0sjQVgCoSk1iB75AcZV2MKQMqjrFHmbYb+8D6a+pghkF3MuQfuqV1Rhv11FTM8u0edgJcjWhk+t07MilxbZBvcvg/OtdYIPu1jp2A5J90po+SmaXGB5qXb2Sy7BwoMcOxdq/ExLOVamzJBLDFQqAnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=o3EQfbtt; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e571666829so1669277b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 13:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709328114; x=1709932914;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdabNmDOuU81oGyUuyFWNojMT76Q7ijYDGABFFrEAaU=;
        b=HUXgRAkbYT6THGYkgIa1nJJrUuy0LVDNerX48M67ejn3bM2rB/dgrtvYV3lsd18OwC
         sT6xy0mBgaUq/hlER0vAcczbad+U2MkvnXL2oSWp9XpJUddPxqLGCv7pQe7YBc+RwP72
         7nF56DdQRhHl7zXBi8IPCnLYV/gSgQEWNPoWJDk+zGFica+3H+dTV+prs05+QeT/Ttzi
         gQIcsCLudinF+mETX47DTEXYKHk5xdSCekyMojzaXxLIcB2xW16QliUWJQdjmmtGMWyI
         F6MxEm4WhqcU69qpZN6J7dN1MyDBiNziADwcJgT25HZ+DlLuu/auUFTji9RMi45ZijmL
         Lvdw==
X-Gm-Message-State: AOJu0YwveNmPgmfNMvL6A9TwPH1dnX6zsmLqGO/IZvGDjw8dbQo7YOzS
	hXHCCLCmmmiEr1AKYxF58FEQohN4ZvfoRGP5UKyufVfBcEQqa0efxydZuk7i01asNw==
X-Google-Smtp-Source: AGHT+IFMK0yHzagDC5JRLkoD8uRQcBY2Ugjk03AIaQq+3LzkEOuFnK+5lkkazQpmnLuRqeKpfwjnyg==
X-Received: by 2002:a05:6a00:23c2:b0:6e1:3d21:bacf with SMTP id g2-20020a056a0023c200b006e13d21bacfmr3353359pfc.19.1709328113977;
        Fri, 01 Mar 2024 13:21:53 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id n21-20020a63f815000000b005dbd0facb4dsm3446526pgh.61.2024.03.01.13.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 13:21:53 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709328112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EdabNmDOuU81oGyUuyFWNojMT76Q7ijYDGABFFrEAaU=;
	b=o3EQfbttqXWbjb+v8hNsKqymFZ2jF6iga7n+CkQlHxWPQT8zvHKdFydGg8JtUWOcnJXVu9
	m59BuDMAFq9crYV/vKFIu/N5hKd/D+RVrG2dr3TlLMij5JOvAJWMHyPspyipRfq1lbmhtY
	J8i8yb48cBWu2KDQGvLFZoxifYR2pBWDNUkLQBl7Rjxze9jp2hZfu57LlQ9wNwxLnAklrD
	KTuf6ghjp4FCqwNl+HJkyRV+638C/U2j8mzk7UhK3OwWY8GKemE5mkBFZsl5JMLVJ9IAhW
	fN/uxZuk3DM6C+mLYZrmgkzfr4PXE69bjteMFBHO2wI8rl2qdtIcmODRGOMCWA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Fri, 01 Mar 2024 18:21:38 -0300
Subject: [PATCH] tifm: make tifm_adapter_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-class_cleanup-char-misc-v1-1-4e2a41bef8cc@marliere.net>
X-B4-Tracking: v=1; b=H4sIAOFG4mUC/x2M0QpAQBAAf0X7bOscRX5F0tlbbHF0Gyn5d5fHq
 Zl5QDkKK7TZA5EvUdlDgiLPgBYXZkbxicEaW5nSFEirUx1oZRfOA5MTcRMldJYt+7HxNNWQ6iP
 yJPd/7vr3/QCjXH/OaQAAAA==
To: Alex Dubov <oakad@yahoo.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=eMX9lL1CM4JCPZjgVhFpZok2LOHX9u+EYOu3IYUUZ2E=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl4kbvbuy+IQ9eVAAi07Y7CGsga/QLUxpS/E6dr
 D93JAhvuFaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeJG7wAKCRDJC4p8Y4ZY
 piezEACOMGLe4aQGPj6BbGlTYMfS+rvB13/BNcwU6gUP99SJoOxUCEXNSeyowkuUHG0Rhjlxdpu
 Wrb+yU7rESBUQEUFxiSg1fgPHJ3ss2PGzl0vryKbH7kTqG9y1DKY7OBTBZTqsqeaGhWoxK+sNwn
 U6uy+04wxe/Jo2myjHz8tbUdpkj7q2DBOpkGaX3S+6xnD/rb8byAVJsKwQH5oSFGorxtn64MHUg
 ENdpcjupsmc8GZNSVIGd9aT+kdsIK/+Ay6v9psAwjVIsgYLtOxe2hPQcKhocmrCsF4aZCmoor16
 fCph0Ykqm9ZGmNiZzovRTAa2CPbZbAc5pbWKs8W+elH/gfcNgGv8SItvKnrU3TXe/ZTK5MWjaEe
 +2ap0zMpvNSDx06LMi/Y2kpRUQUHrbMJLr7+AAp6iaQ0NXFU53PAyugU9EyI28RIAV5e8Aa31b6
 khe2S5fUdu2DK4VvM8Jx21u9ap4VOxQiyXzzOfnQL2qbeK11ZJ/zy4vKBO5ADzslVBhi71AT5cs
 +iai4DRWTp8r0//LimCYdJ3tL9ngllpXniD+eLXSLXR+S2Zj2o2uZ9eMtc32GynmX6vnVneNLxO
 M1XMpjsV1Wx4uwsxEjJmbwxNXFikMouRG/MejuLZbRY0XIrF0eZw5kmeTTXnLZlfJ4ceTtnrcX9
 VZOeTmLPkZNHATw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the tifm_adapter_class structure to be declared at build
time placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/misc/tifm_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/tifm_core.c b/drivers/misc/tifm_core.c
index eee9b6581604..d2eb31f39aa7 100644
--- a/drivers/misc/tifm_core.c
+++ b/drivers/misc/tifm_core.c
@@ -166,7 +166,7 @@ static void tifm_free(struct device *dev)
 	kfree(fm);
 }
 
-static struct class tifm_adapter_class = {
+static const struct class tifm_adapter_class = {
 	.name    = "tifm_adapter",
 	.dev_release = tifm_free
 };

---
base-commit: d4551c189d6e6a3fcf7f625bd4b273e770fad35a
change-id: 20240301-class_cleanup-char-misc-a2e2edb8dcf7

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


