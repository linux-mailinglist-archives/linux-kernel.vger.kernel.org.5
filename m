Return-Path: <linux-kernel+bounces-89529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD8886F19B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62851F210CC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC1B376F9;
	Sat,  2 Mar 2024 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="HB34JzSy"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ACD3717A;
	Sat,  2 Mar 2024 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709399178; cv=none; b=mUyOixlSuiaA6LZ6NoF+JeH9jAP5oi+UPuI82cRvFf0yOTZtf7o/hiiKPTLm9CWsx4OZ/eZLfS/RQrj+Aer2YaWMjKvNDuoTj878ojMqWtcRFflL5M5CTpum26j06bKoGTNUG/7o3I6RmZHgAYlGK/KKqpTuqOKBtI3Lc4bTsJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709399178; c=relaxed/simple;
	bh=T5RHgTXkjqfFzaWYcAqOoCPHNlVX677Ll7gcmiR/4d4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bLkS2ssAdqAY7fUzQdT/DDhXj+WY+f7s2sKROis84mD6YaZOv0nXR6Hsoi03C4aSzXvHnC7YH8thqdBJ1YgJdGEhrWnRCAOcJ1LMkjcsHKyKSToJM9QDYKrYRw3LDTxIHrjuP1i7pn2wf1Q0G+EGJFEn+nw54pDHeMsH81QqdVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=HB34JzSy; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c7ee7fa1d8so140411139f.1;
        Sat, 02 Mar 2024 09:06:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709399176; x=1710003976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b8KHE2YH607pBREjJO3u7sJ6tDIBnjDyXQnIFsVTeqY=;
        b=LfbuZZeQeGJ5d9wkcCPBL0Oq6zsRLn01b7r6Tc48hYZ8Zkf5/+RSqDaDTMtLLVGquq
         RltPWchQ0RIIKdhxz0wH7KJFDIMdjG0Q22SNeMq7U48I8PF54/0LI9FkYRXRDxic8wh6
         JmdyG4OQNiNNm7+SRvoMKR+RPk5EqrlRhh8/pHGMRR21D4QRZjOzyRcClMUTidqV7v/E
         C2HyVCazfFihm2ED/M2Qb/ODbMmml5cDBpMLyGfysZ2ODF3bBJaXUM4MZQwe4E7+qYkN
         J12Y/FntkNdclSjf37NZRKMFeJwTula+sfOTatfYoru3PEg9MJIulilWJ2QnmOJ1pDcm
         uk5A==
X-Forwarded-Encrypted: i=1; AJvYcCXAljaP6nM3Oc+7If+J4aDqgksihDh1WQO2jgEn1E0Yk/K/ZzeOHHltedrdbsOxiCeMA6/OBjVWDjfUux+H2ag45WohrHCnvqXkTO93KDnsvK+0Ew9Ohsmv6gJRpGokSkiCOxJVXBSAaifh0YRaf0aX6VBwxUUkvlULhjq0xUHX
X-Gm-Message-State: AOJu0YwQ6D5cT9Xxtw4blUzuK4ehqAbPaMIZD3intGV0Vhp0+1VAz85y
	XmQtuF3iMR5qML+lRyoskxUke8/KASaZ6dsjSitoy9uDe5IKBg8D
X-Google-Smtp-Source: AGHT+IGVpHlEAfc56PmD4qt6WtuhWaH3SeIK+MD+sx+501qtfzHvsBRUKn8NzTidX1rkmcc4roOfiQ==
X-Received: by 2002:a5e:8a0c:0:b0:7c8:3580:a484 with SMTP id d12-20020a5e8a0c000000b007c83580a484mr1816606iok.5.1709399176188;
        Sat, 02 Mar 2024 09:06:16 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id t11-20020a056638348b00b00474d0d15c8esm794499jal.151.2024.03.02.09.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 09:06:15 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709399174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8KHE2YH607pBREjJO3u7sJ6tDIBnjDyXQnIFsVTeqY=;
	b=HB34JzSyq2N83bfG+mR604/U75HzFPLqDySYvjvgLfkPpe2z/Tf5PfC8d0zTcIpYT2+vYj
	2QLTibjmLNhd0u1SDYAHGSyTGlCSzSRTe+Kgzj12dC2olzgPHLTxaQ2hSbXfuDtHG/+trI
	04Fr+RfLszvAUB9KqUQvuUp22znJOh9X2Cl1jkiTYSbv9o3j7ZY0jHU+OmMkSO1DiC2wp3
	iqNmPjr7a4G0o1PcEDHVPujywpbLR9hZPNHmyroSy2m3LG1IERq4nFa6UqBHc1bfmKWzgT
	3krpFy1JfA/aniBvVi7L0alRZHvp9GHrJ0rzFEZyJpXYsjzIGLbZzlPCb3uFEg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 02 Mar 2024 14:05:59 -0300
Subject: [PATCH net-next 3/6] net: ppp: make ppp_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-class_cleanup-net-next-v1-3-8fa378595b93@marliere.net>
References: <20240302-class_cleanup-net-next-v1-0-8fa378595b93@marliere.net>
In-Reply-To: <20240302-class_cleanup-net-next-v1-0-8fa378595b93@marliere.net>
To: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2263; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=T5RHgTXkjqfFzaWYcAqOoCPHNlVX677Ll7gcmiR/4d4=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl41x6r2Q+NxH/tGuFTIUpuCbT5vFEjCgvKhnle
 OTiQs5XXR6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeNcegAKCRDJC4p8Y4ZY
 pjcAD/9Ocxcjd9VCBOdPx2sCmFRHlXr5EkMe1h+E54GC5DKLQVjEEaGe9WMHvHK6QAZY/wBTAnO
 CygXOsLNmbDxU3n/0oD6NH2VQVOzXjHAcZQvPzIaN+f4iWrELfIGUJUHJH8P6wPHXjaMDpsLZkq
 S4zhcFvvGmNIXfsUifj7JaIEZL7MkSQQMHbBROzJmy5M4x8IvlqZCpS9iT9WCpEY5TV66BLRACT
 rp+67mwLveb6mV37ST+5jPiMhmQfQv7RAftuBTg98KXJ1ERF1jwaWZ7QRJsh/NP3O124KfJa4hx
 VRdRQCEI9cBbUPfbKhevhOS+Ybq8nRab3wljyZQD2AQN+n/jVd23VKVwJldz9peTnJet7+/rNE+
 S58ee2JieVFMvv3G7A2GQVi+h94Zp5gxr8IotiSCIK1aUpAIfMLNM9Ld6fbh01vT5eL+KdoQfzM
 ylm1EvPEB6dsH3uC68Dp4972IVtfzUv/+jFIvTsvA9OGU8e/F82isGAg8A1fgQ8a19Isrog2zd5
 0BhPcsvq0i7aqv0o/J3uMGiatLDoXKdzAHglougN5mTchCwY9IjgOmNLMcrSx00DHl39KHiqnNd
 DirBsWhuuxr5tfn3OFD29Y2fEVL8AxDzw8NcJ9yqUiJiJpNdYQtzUbiQ1hlqF8VIvh0e3dTTMOR
 AnhbHzf7P3W2L3Q==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the ppp_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/net/ppp/ppp_generic.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index db1d11ae817b..fe380fe196e7 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -295,7 +295,9 @@ static void ppp_setup(struct net_device *dev);
 
 static const struct net_device_ops ppp_netdev_ops;
 
-static struct class *ppp_class;
+static const struct class ppp_class = {
+	.name = "ppp",
+};
 
 /* per net-namespace data */
 static inline struct ppp_net *ppp_pernet(struct net *net)
@@ -1394,11 +1396,9 @@ static int __init ppp_init(void)
 		goto out_net;
 	}
 
-	ppp_class = class_create("ppp");
-	if (IS_ERR(ppp_class)) {
-		err = PTR_ERR(ppp_class);
+	err = class_register(&ppp_class);
+	if (err)
 		goto out_chrdev;
-	}
 
 	err = rtnl_link_register(&ppp_link_ops);
 	if (err) {
@@ -1407,12 +1407,12 @@ static int __init ppp_init(void)
 	}
 
 	/* not a big deal if we fail here :-) */
-	device_create(ppp_class, NULL, MKDEV(PPP_MAJOR, 0), NULL, "ppp");
+	device_create(&ppp_class, NULL, MKDEV(PPP_MAJOR, 0), NULL, "ppp");
 
 	return 0;
 
 out_class:
-	class_destroy(ppp_class);
+	class_unregister(&ppp_class);
 out_chrdev:
 	unregister_chrdev(PPP_MAJOR, "ppp");
 out_net:
@@ -3549,8 +3549,8 @@ static void __exit ppp_cleanup(void)
 		pr_err("PPP: removing module but units remain!\n");
 	rtnl_link_unregister(&ppp_link_ops);
 	unregister_chrdev(PPP_MAJOR, "ppp");
-	device_destroy(ppp_class, MKDEV(PPP_MAJOR, 0));
-	class_destroy(ppp_class);
+	device_destroy(&ppp_class, MKDEV(PPP_MAJOR, 0));
+	class_unregister(&ppp_class);
 	unregister_pernet_device(&ppp_net_ops);
 }
 

-- 
2.43.0


