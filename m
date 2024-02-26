Return-Path: <linux-kernel+bounces-80515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C377B866913
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F6EB23C89
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5620487B4;
	Mon, 26 Feb 2024 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="P5EhRsZV"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A02033E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919965; cv=none; b=mX2430Zh4aTwnpM2NuYPahAUv6F3EK6ypLIvyPZCHrU+poNy3dkAKPgyYRVhuuvp6b9kH51aEsU230SgpUfLuGLC60dYzv4JCwGAK87NAlei77sZfeHMvWXwO51OR0p18/apYdTslS1fVRx5hgPHC1Nm/nAWY68v4gmhK18qigU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919965; c=relaxed/simple;
	bh=AiBuBvvwNpK/KQr77GSv+juzO6zdhF7q2Pdsy+hD1rU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kh620WJOYZEZ7nSc10Pc8Klok9Lt5tIb9zGeXxabD4SfdqfDE4N2qjcTIBU1APFn6NNU7k29PpNZlONMDzWwkmumtts8MN+VqDx+I+I9Z8VLg2V90PB5ftim4mvgC6u5rkj60e84hHzjxpa2fnt9gewov9XacqP6Pc/7/xIm1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=P5EhRsZV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d94b222a3aso27430955ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919964; x=1709524764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSSVxPrO4lCI0hg8jSsGiVWd0BRnv5gjYtDEYGTxDSc=;
        b=P5EhRsZVWb8BV7EFW2wcWyS1mbSQnGSF57yEfhXH1NAcnvFl2Q434h27kAbd4Sr5wV
         g1NV4JdUhSFO3NTkRpDVM6XeYrelVeDBeK13KfbigNwIy8sxO3xYCY1osKeW3woAGVOd
         fmvdkY+okm3pcEyGgVztbfgxpQYwdGCFGETazvjse9JoAABoWWXVODTdJWtw+/lVsDJl
         WqMqjXkAPQXo1wNTW4VOwAsMtxLBJxQhsywNgsYHt7uJId3wA1IA5hOXeIHlqLJfkq9B
         bbmFdZIxiYiBRbqcC7I+j0rCmV1NQTr7op31uMFdbaj3KUHug6ag8rYW/WrEV8nMtbrX
         rHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919964; x=1709524764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSSVxPrO4lCI0hg8jSsGiVWd0BRnv5gjYtDEYGTxDSc=;
        b=wKTTQGqo+GWOg/AyOSklgdPKcPb3Saiiw26gc7w6/klIfH12lJEicRHVWIAYS0O9To
         vqpGKf/kSdBjBdYeT2zyx2DJ0uh5aC+fJrWvtTvFYEZ4CphWfcbzn/YrBcsLMDIe2J5v
         j7Rp3n0HTX/yi+Uz+DdtsRcniP6mnuFhhB3Ws6D+xbWgmWELmmjymzeKGZUwgENscd39
         IHeIoVW5oo01LMr7r2M+sUnlj8h/XXyZ5mZnVWLLO4Vqg7qOSQSpYjGvoy58xDk0PyuU
         KPzktNuqGM7ibPbkJjTX2+9beL4ZQDmtvNQg4AIxYOUCMRDFpiv9pdXQUEM3NYW6STbL
         YNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1cosaGFESpJvaJ3bV54OvzciEsgNcBcixt1LjQLpooyQPG3oQzCCKzhs+ySE6NgkW3nmUqEzLGFLEHEbLbkCCj09XoLVzNAzMIpEE
X-Gm-Message-State: AOJu0YxIOg1wRtIducUCLN17bpiuPmRNvo/qHQaq/GRx6EofsdaMqdHG
	W8Y69RwT+YrwBxrhShKCHS91LWAZK2ewQB0jLBw78mM3eqZS2P6rmQ4xfs27KX8=
X-Google-Smtp-Source: AGHT+IEE0+s/vLr/q0NN1tnenYz0NlElT4D+tBNp8bPv1CrkD0oLPLrPE+b23zUP5NjJj0Q96LRZ9A==
X-Received: by 2002:a17:903:1212:b0:1d9:3bb5:2819 with SMTP id l18-20020a170903121200b001d93bb52819mr7600044plh.34.1708919963976;
        Sun, 25 Feb 2024 19:59:23 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id iy13-20020a170903130d00b001da105d6a83sm2893426plb.224.2024.02.25.19.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:59:23 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 4/8] Staging: rtl8192e: Rename function rtllib_send_ADDBARsp()
Date: Sun, 25 Feb 2024 19:59:11 -0800
Message-Id: <20240226035915.370478-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226035915.370478-1-tdavies@darkphysics.net>
References: <20240226035915.370478-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename function rtllib_send_ADDBARsp to rtllib_send_add_ba_rsp
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 1aa57f654b82..c0006daa75ec 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -186,8 +186,8 @@ static void rtllib_send_add_ba_req(struct rtllib_device *ieee, u8 *dst,
 		netdev_dbg(ieee->dev, "Failed to generate ADDBAReq packet.\n");
 }
 
-static void rtllib_send_ADDBARsp(struct rtllib_device *ieee, u8 *dst,
-				 struct ba_record *ba, u16 status_code)
+static void rtllib_send_add_ba_rsp(struct rtllib_device *ieee, u8 *dst,
+				   struct ba_record *ba, u16 status_code)
 {
 	struct sk_buff *skb;
 
@@ -283,7 +283,7 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 		ba->ba_param_set.field.buffer_size = 32;
 
 	activate_ba_entry(ba, 0);
-	rtllib_send_ADDBARsp(ieee, dst, ba, ADDBA_STATUS_SUCCESS);
+	rtllib_send_add_ba_rsp(ieee, dst, ba, ADDBA_STATUS_SUCCESS);
 
 	return 0;
 
@@ -295,7 +295,7 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 		BA.ba_timeout_value = *ba_timeout_value;
 		BA.dialog_token = *dialog_token;
 		BA.ba_param_set.field.ba_policy = BA_POLICY_IMMEDIATE;
-		rtllib_send_ADDBARsp(ieee, dst, &BA, rc);
+		rtllib_send_add_ba_rsp(ieee, dst, &BA, rc);
 		return 0;
 	}
 }
-- 
2.39.2


