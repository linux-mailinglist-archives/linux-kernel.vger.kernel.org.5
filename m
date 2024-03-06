Return-Path: <linux-kernel+bounces-93821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1EA873539
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F20B27A38
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755B078680;
	Wed,  6 Mar 2024 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iixSnPNA"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D84779F3;
	Wed,  6 Mar 2024 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722647; cv=none; b=dmW57ndzAueCmvW7qJSQvGff2yRpz8pKxMwE1VMF/8StuKAxptw4Xb87iILPt01PKTB9nBJqaFlgX53k8gdUOUxrTmcwhTNr/hzNIe4YXrfpHmeqqHYFZ7En+ovxoLsu4oTJBHuVBcweNYhZJUoiAoHOMa0PjhLQ/t2roCRBGY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722647; c=relaxed/simple;
	bh=3xeotuDCdQW1grDwcrF1sKKx1r0PdzuU7cowPj5kBKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uOcMaPTsXdVpUszPQDBxywNfE0MeMQx2fcfZPbu7Hy6K4hhoQvokYDDBpSMJudoTjLFN2JCbunqYUU68vMU6Vt7VGsThIpF5Sv5oc3c5hWxfOWtfqq2Jyvu4TPAL12DW0yFJNPvTNqpqA7jDiBL0YP6pKOiYW+xDuAopoE6COjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iixSnPNA; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so5084487b6e.2;
        Wed, 06 Mar 2024 02:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709722645; x=1710327445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi11Eg+aCzsA79R7LW/JZfX5SqkmL+m2Yfafruuq3ag=;
        b=iixSnPNAMd/wv2PLByJHVRPGXfjK0VdcNMGXWU8ObO9/9HqtHUulPTnvxwGuhl2veG
         ASJPTy8oSj3KGQ7QbWewNxnlyTtjVHMHaRjN7qtUw4evU3m6zGtJ5JEoFaGuzCFFeYdA
         P1qvEodaOPHmn4ASZv7WsCNQRSG0somcnMSYeOPRJ2P2r8VugyeicjRO03FQd/VStK++
         f9gHOIJTz6CzKmUN7FhqhSrKfveqXbc8mDm8xdKYY91gacNpwsIjyI4ZSKRTuqCbLvwl
         vF6jgE+a5x/Sne5pxjv30rDR3Egp5JvC1lMEoWTfPDz5cS0ZcqzxxmRyscST7BAu4YAy
         StmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709722645; x=1710327445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi11Eg+aCzsA79R7LW/JZfX5SqkmL+m2Yfafruuq3ag=;
        b=K9n/TgvUirSe5qIDOXSft4h1GtpWWqw4eRpgsUXynywVLe+S2/lQjHkzydq9zzAQ0R
         IaS8xfhoRvdNfol9rFqtEbaP2jYAQLjYawxcd5GcklF3f6WjaMGpM0jiOIeG3MIufZBb
         QeGNj7wLSBJ9yE6d/bkrhcJX+Me4yRbMjtGOLTpHyy000uB45JEhesuI/opxbx5l34fk
         VduGfd77EvMmej2gyW25PJ9FiSgitblx0VrbIexWYGDpQRm4x4MuFwM2pdio+Y+9qUNr
         un+xMK9o7gB2ldCbh93rKJd40pW2JJCYIGczVVshBFZ0mAYH9KEdJhFz1swjrTDhhTRy
         zwFw==
X-Forwarded-Encrypted: i=1; AJvYcCX/7XjJXlORc/Na9ChlObcsItaIwKD2REqX1Lw78q0dBIgB3VOhoPoESUo1GP9SGaJEeFwfu39XfJlfqDPqubD/Z/XDRJciJjdydYqP
X-Gm-Message-State: AOJu0YyTV0lf/XdO36bJYI82LpEO3Vdztfv0IApfl0Srq4jnKz9hjZR7
	mkZ2v0ukFuwxbHHePIyPoNF7m6daHdeg+AAmGUWn9DnAlMK0q5H2
X-Google-Smtp-Source: AGHT+IFVSukjVVH7mZHilwVRsN1EmJYXk6UjTSyCDZxNbuODfzqzL5aG5NrxO/WTKnVs7VWqmZlIng==
X-Received: by 2002:a05:6808:10c2:b0:3c1:ef95:c503 with SMTP id s2-20020a05680810c200b003c1ef95c503mr5974554ois.0.1709722645388;
        Wed, 06 Mar 2024 02:57:25 -0800 (PST)
Received: from VM-147-239-centos.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id bg1-20020a056a02010100b005dc9ab425c2sm9341531pgb.35.2024.03.06.02.57.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2024 02:57:24 -0800 (PST)
From: Yongzhi Liu <hyperlyzcs@gmail.com>
To: pabeni@redhat.com,
	shannon.nelson@amd.com,
	brett.creeley@amd.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jitxie@tencent.com,
	huntazhang@tencent.com,
	Yongzhi Liu <hyperlyzcs@gmail.com>
Subject: [PATCH net V3] net: pds_core: Fix possible double free in error handling path
Date: Wed,  6 Mar 2024 18:57:14 +0800
Message-Id: <20240306105714.20597-1-hyperlyzcs@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <9c4da99a83bceb4680aac9588151cc8190ff07e0.camel@redhat.com>
References: <9c4da99a83bceb4680aac9588151cc8190ff07e0.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When auxiliary_device_add() returns error and then calls
auxiliary_device_uninit(), Callback function pdsc_auxbus_dev_release
calls kfree(padev) to free memory. We shouldn't call kfree(padev)
again in the error handling path.

Fix this by cleaning up the redundant kfree() and putting
the error handling back to where the errors happened.

Fixes: 4569cce43bc6 ("pds_core: add auxiliary_bus devices")
Signed-off-by: Yongzhi Liu <hyperlyzcs@gmail.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 11c23a7f3172..fd1a5149c003 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -160,23 +160,19 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
 	if (err < 0) {
 		dev_warn(cf->dev, "auxiliary_device_init of %s failed: %pe\n",
 			 name, ERR_PTR(err));
-		goto err_out;
+		kfree(padev);
+		return ERR_PTR(err);
 	}
 
 	err = auxiliary_device_add(aux_dev);
 	if (err) {
 		dev_warn(cf->dev, "auxiliary_device_add of %s failed: %pe\n",
 			 name, ERR_PTR(err));
-		goto err_out_uninit;
+		auxiliary_device_uninit(aux_dev);
+		return ERR_PTR(err);
 	}
 
 	return padev;
-
-err_out_uninit:
-	auxiliary_device_uninit(aux_dev);
-err_out:
-	kfree(padev);
-	return ERR_PTR(err);
 }
 
 int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
-- 
2.36.1


