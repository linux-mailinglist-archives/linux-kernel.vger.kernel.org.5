Return-Path: <linux-kernel+bounces-92866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15407872733
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8451F2A3BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6E124B29;
	Tue,  5 Mar 2024 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="gRrr9dbp"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AD222F08
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665253; cv=none; b=f7oorbtWQbGjhjZLWT4YmMEn6gLmUPEExZp6Y4lczeiqiXfULWGOx4++Hn85W7iDFiLgrlAUnb7kVp6z3LkccWir1rOdZMWxRJcBNgFA/mZVOvdChPy0RONk2VfMeQOrLzzs6sHRoYtr+gJV7vMmIkRE4XWIxZshvkXATRACHVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665253; c=relaxed/simple;
	bh=QmTdKB4yOOP06NCtmMTaOrvl1jIYlU/8JoRLnoB7sjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ILKjwH8CGOsc4Jog8Swi6pAmsOB+MGmq0TbqBMHQAXorrCdBC4+rz+/BM+smHPSXtqLx1xOpnv/sx5Oph6QFyHyBiQ7kWBgnEHB884HQ/cg7wpRYzSK2F4Ex9kGELg9psf+QHWr49echNKRK3dM9KObsG24fNWJaMYCIpdkhrj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=gRrr9dbp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dd2c8f1204so7752125ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 11:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709665251; x=1710270051;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hb1L1swpsjGv/VB4NPLiOOHq1jOcwD0LdASNCD5R9Tk=;
        b=G1pwK1M1TgK8ZM/PjXqIi4xcJny3E3EVZXlyGi2vLE3XPqoYzgRMj0bpuJulBiOPUF
         Yhv0sYEnmaIC9mTpk9sOaMTiTXWHJehAdLxgbG08q+UaEB7UqOtmyjrjxlRdQfFNLeUY
         V3DMFdXfbUOnApmUE9k/9t9vkaZZZjycFBwfKw0BQDEaEIzwByI+iB02mKzOy+dc6nWr
         Exb8OQ+zy1EVqXHqP33zY2N+9YwjgeRMVsIw0bv9tVyc12DmdrotzHKGOmBNZhiajjq1
         N7ACp7AP4OhxpZxEvGPxNHizOFdZmlNzzqxqI11fh0ESPTF5ObEBLIomskrM/njXWUcD
         KfJw==
X-Gm-Message-State: AOJu0YwVmnZJoc3NQkh/ztOi+dK7owmze09ASwlnNdBk85zGu9ah2VGr
	d+2bTjTDfGse53rxd7Vf1yQGHypR1ZSbhwGKksvjbhiYpGaTb9QlZ22oYD4X6a5ZHg==
X-Google-Smtp-Source: AGHT+IH14lFh41CaEWdmhT0/PfazQV3MRkIfnWt8OiZXC7PbYKe1GDvhF/eW0AJpU3J+uC+yDy5ujQ==
X-Received: by 2002:a17:903:48d:b0:1db:65a3:e17f with SMTP id jj13-20020a170903048d00b001db65a3e17fmr2613491plb.6.1709665250875;
        Tue, 05 Mar 2024 11:00:50 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id k23-20020a170902ba9700b001da105d6a83sm10853308pls.224.2024.03.05.11.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 11:00:50 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709665248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hb1L1swpsjGv/VB4NPLiOOHq1jOcwD0LdASNCD5R9Tk=;
	b=gRrr9dbpul4rQkW7C/XTiqMquWY4H/uL+0wn4GngPgYn9QqiHcAao+0a9qhcJIyC7PyE5w
	6Y/i6CGnQzYp07+29OoeEo2JRPaa/DrylvJV9U7nx86HRS6uC/ogfN6Rwcggdj/YfBNd5Z
	JKTwS1lH/ZPjZWrLCjy0PtcRZ8ZPVK9fiRslavgsjPKIstqdJaeF5/ZdQtHvtU6qmmUkV/
	Yp7GZ/OmOCO0s8qtKV3oGXXk0exks6EIl/94UxxM2zLfjuroiP7tk8o7jozunWOJiORPfr
	DIp9j4Nn0hw6Z+27fA3PQ8bMRCCx03gIrOrjfBjIMca4oMQgzwpnEdzFThUUaA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 16:00:45 -0300
Subject: [PATCH] regulator: core: make regulator_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-regulator-v1-1-4950345d6d8f@marliere.net>
X-B4-Tracking: v=1; b=H4sIANxr52UC/x3MWwqDMBBG4a3IPBtIvZZuRUqJ8dcOhCgzphTEv
 Rt8/B7OOUghDKVXcZDgx8przHiUBfmviwsMT9lU2aqxtW2ND0714wNcTJsRLCm4fRUzPXuMfVt
 3gKdcb4KZ//d5eJ/nBUeEtCxpAAAA
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=QmTdKB4yOOP06NCtmMTaOrvl1jIYlU/8JoRLnoB7sjo=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl52vevnP5k+C9Pa0GCSYAZQNRL4nBl8BjZI5xC
 Q9dInjSJH6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZedr3gAKCRDJC4p8Y4ZY
 pmzMEACJgA0pzHRnv2tLDi7p0fcfQ4WgKK00XToLpKd697di9QN5iHmZMkr3pPgbdPREFpBeJ4u
 IrtRD9tX4k9+/Qw6M3iWzDPyNEUQnU1ne8DkvLays/YLmtDyVKT7A1k6LWPRSEWiuZtDspXVsKQ
 dKV4vx+er6nm5LqU8bzuSqT14DizR9Gju2MCcYhPyecnHayhOVshvA29Ib7yy1QhIO0BChWsocG
 dUg0KGyObLKX8U+CBNh/tnS2dGmivIkK/sCxhBzxPHMwFRp2rZ3t1wZkvQ/YZ96MzCDPoooMOvj
 vnuWyQtsw/q2JjbyG2s0Kta3gM/ea+84arI5biHA6WB8ZrkUK429i9/0qgf/qSNyuLhuWhwQCU9
 TAL5dceEkUKDoZ9eBNCDN12PhwLk0lkSBmZM5b9af+1SAqrIinTyBs2WUUgK+kT+lSuU3HLdv7p
 peoanxbjEPOjLZ1Tzymei8LDRpT5PtPi5BHJ517PtEETcS3i7jbT0gGAihc66tPGR+AKrjjFIx+
 fQjfbBNrn+COilk2nmJViWdZG/o26ucBLvhBr9xKoZAp7r+RB3VRrvc1s9A/te5hxjJTw3T88NT
 dML22cRvBxZ605Eg2Ms1LljT0WnIY6Ob+1PmZtf682zMDqcIGcisYeNwnkizYeiqTosNmF5XPFJ
 1Ub2NE2itKKoRfw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the regulator_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/regulator/core.c     | 2 +-
 drivers/regulator/internal.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 17c98c5fa45f..d019ca6dee9b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5890,7 +5890,7 @@ static const struct dev_pm_ops __maybe_unused regulator_pm_ops = {
 };
 #endif
 
-struct class regulator_class = {
+const struct class regulator_class = {
 	.name = "regulator",
 	.dev_release = regulator_dev_release,
 	.dev_groups = regulator_dev_groups,
diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index fb4433068d29..77a502141089 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -58,7 +58,7 @@ struct regulator {
 	struct dentry *debugfs;
 };
 
-extern struct class regulator_class;
+extern const struct class regulator_class;
 
 static inline struct regulator_dev *dev_to_rdev(struct device *dev)
 {

---
base-commit: 996e1c6b09f70cdc37d55896f283d35501fb1ab1
change-id: 20240305-class_cleanup-regulator-d87eb7536eec

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


