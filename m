Return-Path: <linux-kernel+bounces-63712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B01853388
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26AABB27A67
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C9658108;
	Tue, 13 Feb 2024 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Jy1Dv3en"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D1057872;
	Tue, 13 Feb 2024 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835731; cv=none; b=CkP0tpAqYvIp3o0La3Z2QyEom15+pUc5DHvOLZu5BeWGnrdEBwyiE5IDnC4ShyYeS1/jNo5qHj5kdB9D7C41KUNHaXu7AFRXLkNWSP+TPJYq/7oNg3SlwExvQfGS+dyqMbEdJ/CnJHq2syp4fq79A42CaCXyPIZ/+bIOpShAVO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835731; c=relaxed/simple;
	bh=Hp8mvyt+VjxYExGMlG76pKzOl25D9A5JxlR9WjTxw1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EQGl5NHu02F9cwP2pX42N14Cb00LVPFDsvd8tnHWei6hdU775rNkmj9LisqwhfKa9PZKhLOCxOe/Gl90Yn37qGQUmMl8jGsR4ny0tNQVTJrUtXO4422PHQn8sdgOU35ilxLeXVUuEV4ZRHhzQiinP1YrAVKh2fBfQkJ85lzirRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Jy1Dv3en; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e104a8e3f7so161570b3a.1;
        Tue, 13 Feb 2024 06:48:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835729; x=1708440529;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcJ/4XXUkmIs/AxBEZqPBBYbK4WSWW8zJOWwCs/sCOw=;
        b=wp+mXHQG7UuIq5dxoQI2cXmIL+VJ7njQp725Mzqge9+1NPJmJAq5L1U7uQgNPw1nOl
         pTWevcTX6tftDkHtJFvi6IA0hI1TB2h9CQKlv9fG8C7960Mx8sn34XnGEs46sBm0tnAV
         JoDFJpyxYhkNrVvTY0gkkdCe0lDNsLd3Ufvsa51G14JgwWqaERrX0zrqRIAMPI5Y8Rr+
         5AQ9qz6eJ8nirqAsAswRR1LPira1LDxlB2u6shw4kI+ZyPhHBooklo3wmX5QpQJh8cTJ
         a86GdUji1IZVC9oHylCQ4SzZE/Lzp5ODR29p4RNZ/em8m61peg0U/12I4tMhGdYsySwv
         wyhw==
X-Forwarded-Encrypted: i=1; AJvYcCUFYj2Ig+7j5a+q9Ec8m7jPG2zLr6vlaDj6pnM5NaT++fZLJr45ZQl6xZNTzT+AMGZ+9nWZtWWl12k+sytRDyKGx9Ol2f7ukrx4SFDb
X-Gm-Message-State: AOJu0YzNSrluNOl/o/1d4VGlJiM4AQNkIYPIuebP1vtrKb2YgMFiulGV
	4eTHOxH8kGVTSTp69tFO5QTsnNX0pP49sF5Gyi0w4cgj6BGqAA8R
X-Google-Smtp-Source: AGHT+IFdKAp/l+QJiHd7DU1vKBwpmkWa9PJT7uuc5kWaQKkeGGLYKQnLdT6alrJ9ZOmpAWsrtLoQLg==
X-Received: by 2002:a05:6a21:594:b0:19e:987c:78a7 with SMTP id lw20-20020a056a21059400b0019e987c78a7mr12685032pzb.32.1707835729212;
        Tue, 13 Feb 2024 06:48:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSS93rruFCgfejHPRye9WMl0t1diTlcC4E/ZVv+0fIjOYr7U7XTtqv4sLW+8UNu4rRtai9TKWW3uSsahlmHakrvSWZHL6lTaFlXlJ6m/TgDa8JHTA91ZuJrccIAwHc1rfUSLJ57pk0076KWybmwgc0ZRVOHqtknS7oekQvUQ6HOs4=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id kr3-20020a056a004b4300b006e050c8f22bsm7453104pfb.207.2024.02.13.06.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:48:45 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707835725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WcJ/4XXUkmIs/AxBEZqPBBYbK4WSWW8zJOWwCs/sCOw=;
	b=Jy1Dv3enl2hRHQ3cIKkzxS5cfKynKEySlXDaqxCIRtX7oiZNAKK62jim/SIfg2exgwfbnS
	OvXm1TNkIWsWpHCZz9ovmgZ1tGYLMqktt3ZzoUkeu9b/OEsEfFU0e4qGCige5JDtg5N5ra
	IO/z7h1/NVJ0p0UiZeHqFd2ajwtorDoqOCGeshcFPG6gS46oc9hOQ40Kt8ph2AkrM9UEsm
	1F2Abtqmleos/+IasgP+4xOFFLQOlZvvM/06VI7+qZgnHMUXF789qTpyHVRudKvtVFeW+y
	umxxLFRz9FL3kEZfmO6GllYIGmzELS2sSeXg/5M2Pd8mEV2soKZ6dZqsUY+q8A==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 13 Feb 2024 11:49:24 -0300
Subject: [PATCH] mips: bus: make mips_cdmm_bustype const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-bus_cleanup-mips2-v1-1-9c0e3d4a1852@marliere.net>
X-B4-Tracking: v=1; b=H4sIAHOBy2UC/x3MQQqAIBBA0avErBPKpKKrRETqVANl4mAE0t2Tl
 m/xfwLGQMgwFAkC3sR0uYy6LMDsi9tQkM0GWUlVyboROvJsDlxc9OIkz1KoRhnT2n7ttIXc+YA
 rPf9znN73AwdBXSljAAAA
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Serge Semin <fancer.lancer@gmail.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1685; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=Hp8mvyt+VjxYExGMlG76pKzOl25D9A5JxlR9WjTxw1A=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBly4F0gttmp3dOtWiELtmIr2hBM46211iPuY9W/
 XEjeGhlyeiJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcuBdAAKCRDJC4p8Y4ZY
 pqMRD/9Q6Cg3cgKT+ztsti5Q3Hfbsev0Lu2bQZDH3sTVwh7dbnRtlbUQ5gZfLkBsTNGEJ4zhsOp
 4pBAMV7ekmPMK6kk9cZxax4JrHt/aGSaA1L2ozEvYTbuyEN9BfxNDIYdC4xGEGKz+Nojk+rzsG9
 zNfB8Eitlr4jlqT4KMtNUoGFHrRxDtn7TJVVeOg+ulQNe8fBvEhO6lSeUjqW+Gy/obOU+ughqiE
 Bs2IslNpNtCcUMPrxNoUPmw6B3oCKnTr614Chp6Y1xI1HUwzVVydtcFwUzfOAiDaWA0zSiaMT9s
 qNvKawsv5kRXtvCWkNx8avkyGfruxlHAISnfiDXjrWKJa7Xkco6Fd72GkTNMEdGoRLBBEVOKQ6J
 ZoKga6Df9FmPAcQKmj2xfKmDYvYS2UJVQcQLFUTLYGxEY4lsjabvUZscLH4ZTU90yL6+z7ceYGX
 ipftsLNpp3wdAqQjrJyrNEFA6osA+mwnXtRvS2rY/ksAN1ZuvRgP52c7swmsYX9xPXruBTnfAtD
 N/T6aNzfhGe0aJ/+ASCzsPxKEtujcdwzOHASjbO3gZVyBdFZ1Dj6X4DRst8e7h6sywQnDnTqcc0
 Mk8o2Qm0ab0TDGE5B9ueau6WPklZ3D0PKNXC2AR9/cCqH6tCm4LHrRK5Cdce1RsbGk4jmv6cAU5
 avXsg4IGOQ0VzYA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the mips_cdmm_bustype variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/mips/include/asm/cdmm.h | 2 +-
 drivers/bus/mips_cdmm.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cdmm.h b/arch/mips/include/asm/cdmm.h
index c06dbf8ba937..81fa99084178 100644
--- a/arch/mips/include/asm/cdmm.h
+++ b/arch/mips/include/asm/cdmm.h
@@ -63,7 +63,7 @@ struct mips_cdmm_driver {
  */
 phys_addr_t mips_cdmm_phys_base(void);
 
-extern struct bus_type mips_cdmm_bustype;
+extern const struct bus_type mips_cdmm_bustype;
 void __iomem *mips_cdmm_early_probe(unsigned int dev_type);
 
 #define to_mips_cdmm_device(d)	container_of(d, struct mips_cdmm_device, dev)
diff --git a/drivers/bus/mips_cdmm.c b/drivers/bus/mips_cdmm.c
index 554e1992edd4..8baf14bd5eff 100644
--- a/drivers/bus/mips_cdmm.c
+++ b/drivers/bus/mips_cdmm.c
@@ -118,7 +118,7 @@ static struct attribute *mips_cdmm_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(mips_cdmm_dev);
 
-struct bus_type mips_cdmm_bustype = {
+const struct bus_type mips_cdmm_bustype = {
 	.name		= "cdmm",
 	.dev_groups	= mips_cdmm_dev_groups,
 	.match		= mips_cdmm_match,

---
base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
change-id: 20240213-bus_cleanup-mips2-434cc6d8f7bd

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


