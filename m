Return-Path: <linux-kernel+bounces-92936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4646B872851
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FBE2918C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C00127B4A;
	Tue,  5 Mar 2024 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Gq/jDbBn"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F986654
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 20:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669381; cv=none; b=c2fU0zM/3zkMw33cXSqh1IiO1u8pAK1WgQzKIgEU1+t+hnDi0BvGwmUWV1ezWYyeMmWiU3Uk7sJYjd+BPH1ulEqG70ZmqmcAMpWUN9BmV+uBOMNbRe/zOlMS2W7HeMfK80kLsVdtg36iPkVzd2OCiKmX74Ly1VDlDTGMQDxQXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669381; c=relaxed/simple;
	bh=+3nVpBzErzDLiUue1NbXRvD5Hn3zBjYNCdIpGK4jnOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GtRLHonqhKVSi+AlDuHXWgI3D5c9LajjeqLeNHVfOpKrJ4AOfqJx+gQL+CF0HGpCtw4SlT4hyNjoM2HJyLo7r4es98PpkiHqKNvgyCe9wEFIEzYdUhf/OA5Gv1lDiOnlO26NFh50nogkkZZnTOZzgMjj4jiPJAYuE7AYr6cfbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Gq/jDbBn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e09143c7bdso4169583b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 12:09:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709669379; x=1710274179;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OF4+x4t/5OhKil500hfn30c97fp8qVGh34U5LRHRPk=;
        b=dVJ0Npm1G+7gO6NW+DKrs464KvEzKCvcjHcxFE8V8ScdFRFb+rnlUlee6KJKsb1d6g
         hrrnbUA+cch+OvFCpc4GyV0DllIFxFR+uaCgcbQ1Uy86eT/Bo8Tvz2c2BaxZ9UJbm8p7
         DxlTMhVfEnsoHqX5vKNTBFo90Anu+QlCoAXEALkPZKtayzGs+E6d9C2pPPzps2DAdU1T
         W5JAyM9H8xA9Dxdg0YnjOXwy4u7giCiNfEyd1bDzcEWDe4TjJO6IigjEPDjheMa43L0N
         UEHaSzQ/udJma+08j6h6lwg8POZ9QALZC/7faS1VSY4K+/xlotMEnmMVfNcAXd9YtXDk
         WCXQ==
X-Gm-Message-State: AOJu0Yz0LUMaA+RZoNd7RAL7AfDeICc2Wu+tVScNHn9jMUQ/ScQa7zhm
	Pq/Tu4gBd1Y3qOKkVCwlVddcyHfukBp4OXQ5CIN1n2OqjwrY8A8+AeEHJz/9itul9Q==
X-Google-Smtp-Source: AGHT+IGyLUMzcU7cgKXO3JPkmXOhcAOpM4bCnug0oCXy657JOJeTOW3X1YiZju7weEKySZ467QmL9Q==
X-Received: by 2002:a05:6a20:258a:b0:1a1:165c:bd8a with SMTP id k10-20020a056a20258a00b001a1165cbd8amr3286809pzd.31.1709669379542;
        Tue, 05 Mar 2024 12:09:39 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id y3-20020aa793c3000000b006e572883344sm9353685pff.153.2024.03.05.12.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 12:09:39 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709669377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6OF4+x4t/5OhKil500hfn30c97fp8qVGh34U5LRHRPk=;
	b=Gq/jDbBnZbS98fIRFkQw91rqROg0KYtZ7jmg4vqjxzttZYHTZCBchnOmJwfJ+uGCVFOR9w
	9oblwDRR1bOn1+/stlMC/mdMM+fUK+a+UO3nsNA5kkPEDOPWTAQovmAp9M8x4kzkNDZ0d+
	LiRRMJIpHf3/3sFjyMiCkDN8BEg9RrvuiaW1Hf7ne/jAdIPGIqfdL0KKv9bamWFhs3z+3F
	ZqN5wv8kryFLfYSrKaTRZAXgQs5tj1lmu+BuvBteT03vTwhw1Foa+SbLGc6Jt9fKGSu1ci
	4lRAwjX2I5D3TCmHWTZDBzXGrER8G1ny5ih0G/iYiVNwKRwCF4Nb2amh8fnARw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 17:09:35 -0300
Subject: [PATCH] pps: make pps_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-pps-v1-1-d1a1d9f66695@marliere.net>
X-B4-Tracking: v=1; b=H4sIAP5752UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwNT3YKCYt0041STlOQkE7NEi1QloMqCotS0zAqwKdGxtbUAuS/2NlU
 AAAA=
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2615; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=+3nVpBzErzDLiUue1NbXRvD5Hn3zBjYNCdIpGK4jnOA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl53v/ouxjAEBUyXXAfckrtHYHTgmP1rqAVqA9a
 wewoaAtHeqJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZed7/wAKCRDJC4p8Y4ZY
 ppIUD/9przao6zHlDTIGZWTpu8fv+06IXMwWR0pLxEb+Wix3PZLJNByy+r0RODXuFBYwldUI/4w
 tPt6u9h8DzZNXZ+YCs0E/gJOgj1Iz3FqGVUA15JTwsZUwrLdLs0xsVUkkMGDmqtiDaWRhq9DNi9
 yDsFO+gZEg1qXgKFFYSZW5tjTs3KzeaRfYL0Rp7Yac/Ygn8t8KPTcPvN9xDRp4vqZ9Olez/9lDI
 u/iAu/h4stfwtbmjbHZLQWJloJ9TnA3ys7jHecDF+qX/zr7ibonWiSX+CG4GpQinzaIZ2fP63Gk
 HuQNkNkunScdIkY46UsDPF3UABU4W6oF5BE1YUinuuIpAjFICwbAsvcapG5MZsS5KaoWW1OXFjm
 BRgUdKnNDh0X0uBi9pafeCmPxH42jY/ArX5W9VesXRYQE+njIMJtwX7CS4F1HDAPGzbwaY7xDLQ
 Ywyk3puHxChkTmovDb7Q0Uv/kFLT1JlxUvOU3LbiqqFPapov2hq2pstF9muV3QFw4VKaGo47mr5
 Qwwqgc1YcHAGg0iotbgeiGYwyfeWOvGJMAYDU426DDxvdUntoheXpci1zegRin9ZVvQjI7RmVon
 /znwpv88P/oMloZpB+sD6nk6bwra0Cy8lUs/FNTlD0+0YknOjanPbNaJYb9OzqJXAFvQCr5hOu2
 9tjzijHvFe5yQcg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the pps_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/pps/pps.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 5d19baae6a38..b902f4c66c10 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -26,7 +26,10 @@
  */
 
 static dev_t pps_devt;
-static struct class *pps_class;
+static const struct class pps_class = {
+	.name = "pps",
+	.dev_groups = pps_groups,
+};
 
 static DEFINE_MUTEX(pps_idr_lock);
 static DEFINE_IDR(pps_idr);
@@ -377,7 +380,7 @@ int pps_register_cdev(struct pps_device *pps)
 				pps->info.name, MAJOR(pps_devt), pps->id);
 		goto free_idr;
 	}
-	pps->dev = device_create(pps_class, pps->info.dev, devt, pps,
+	pps->dev = device_create(&pps_class, pps->info.dev, devt, pps,
 							"pps%d", pps->id);
 	if (IS_ERR(pps->dev)) {
 		err = PTR_ERR(pps->dev);
@@ -407,7 +410,7 @@ void pps_unregister_cdev(struct pps_device *pps)
 {
 	pr_debug("unregistering pps%d\n", pps->id);
 	pps->lookup_cookie = NULL;
-	device_destroy(pps_class, pps->dev->devt);
+	device_destroy(&pps_class, pps->dev->devt);
 }
 
 /*
@@ -448,7 +451,7 @@ EXPORT_SYMBOL(pps_lookup_dev);
 
 static void __exit pps_exit(void)
 {
-	class_destroy(pps_class);
+	class_unregister(&pps_class);
 	unregister_chrdev_region(pps_devt, PPS_MAX_SOURCES);
 }
 
@@ -456,12 +459,11 @@ static int __init pps_init(void)
 {
 	int err;
 
-	pps_class = class_create("pps");
-	if (IS_ERR(pps_class)) {
-		pr_err("failed to allocate class\n");
-		return PTR_ERR(pps_class);
+	err = class_register(&pps_class);
+	if (err) {
+		pr_err("failed to register class\n");
+		return err;
 	}
-	pps_class->dev_groups = pps_groups;
 
 	err = alloc_chrdev_region(&pps_devt, 0, PPS_MAX_SOURCES, "pps");
 	if (err < 0) {
@@ -476,7 +478,7 @@ static int __init pps_init(void)
 	return 0;
 
 remove_class:
-	class_destroy(pps_class);
+	class_unregister(&pps_class);
 
 	return err;
 }

---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240305-pps-f3e4dcb46a8e

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


