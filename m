Return-Path: <linux-kernel+bounces-82702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D757E86885C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3DA1F25BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0C85820C;
	Tue, 27 Feb 2024 04:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="QUmZVm4g"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5557870
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008945; cv=none; b=CjWcmjTbMsbBASsxGvqBA0FaorW4Z4K8YHF8pyoU55ebr6e4jRR+QnzwFWh43uH+9+2nqnZa89J1EGDyL4wxqDv5XzTQ8pps/FvhsOQbtugbiacUyuoCFbn5YWoyFMBma3sen9XtkDWPDWOkdJ4/k13pSUTe1ZXF9+X/QudCW1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008945; c=relaxed/simple;
	bh=2x3h9Zz+k71/dtUWPgZcEE0hufSyTRHoquJITrslrK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/NEzHLtlvd6RjqYH39bB+zR/9LMpdGSMPfI3O8fmKzTpErqm/Cw3/bqAAjEpXJbfifb/kVpTg+CKJX1JZ56padiOsuJbc4IQNENS5Bn6rbsasN3CYCRUr4o2a+ueQipIomQvtdRMSZKW+czX3fsOuaPdkd1HZOpO54NnUVKvbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=QUmZVm4g; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21eea6aab5eso2722611fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008943; x=1709613743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUsBKbDxqX+aAoY4bQ5ZPw9Nd6OhOWFvUHLj7z72e6s=;
        b=QUmZVm4g3WuuryGYGtIz7lgXBycoxLYckIu46DYykpbzG/LALQJghiiNhGemiAd8uV
         GCGF1+tJDN88FHq1z7PpHdk024sl67Azc7dK4/zmgYF1UnpdozVKDc58HJfaeBJhTPB8
         +EeYQJk81WGyiJXOK3XB7T6kvrpANXt3PJukloP24cgSdzf5I/x0VSuqsPG3DJrCVahD
         VrxtJcoMxrwtlF+B+zOGxbSCbSjVyXYtq9oIDn4BTcwNT/aEyc3uOANXIN8KeyHwbtcf
         8/gYVCZ50+JyLtZjikhxP4bUgnj/UtgS9R/4alRuBXNoDw5jmCm+NLJptzwLiW8UVdoR
         73rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008943; x=1709613743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUsBKbDxqX+aAoY4bQ5ZPw9Nd6OhOWFvUHLj7z72e6s=;
        b=nufLUrrdVwSocE01c1ljO+lVtnCjAdOxx6u3XH2oOCFTcPW+1PFg4SSu9wxI/j9JYO
         wkfq+0JYpWPK45YHQiwcRr10io8tXKIbvZW+Px2tCPv1zqm2qCc9QIqs9de7UWKOAtt5
         cB9iGfjbIvBjhQT1gY8h7k9vJ2MEyyqt9rb0qt+iSXDHvwMe1t+qi9fxgAo0ww9sOhxH
         j5GNL4Hq67VCHQv3m1NQ2buiK+Xh+0ENnP77Mswqyaub7EdkyXhWUl90yK1wbPgAalf1
         8HPCwc7YDZTOzSj+XhGPPwZszY9HG1vTrFpSOEyQ4FCZ3rfCELfwwnEOQumWJLvCvwGF
         yFkA==
X-Forwarded-Encrypted: i=1; AJvYcCXwaCdySKwHmYJ+3g/d2P+MdIZ+YGlsay8osCSJNJA29MSrnLfPp55wPZduvu4rJqL7hTlYl08aDO2SWaTl1mBfU6QVUismfSDJnZrD
X-Gm-Message-State: AOJu0YyPAe1etYQwW0z87KV1BuNDpuSdGAAJAXcH5OwmH0tq16oFsIKh
	16GBlRGg5WipWRDmvIttQUvUbQWzwyBoUrDkmNT0dAv9kMI/99xNaMWDMA03E/A=
X-Google-Smtp-Source: AGHT+IHa3byya7dIvQDMqOR4n54Cfq1D2QEr97DUOwPKNmDLsK6jgR2+BFqesK8mx+OEknImw3w/4Q==
X-Received: by 2002:a05:6870:e390:b0:21e:dd7a:2d3e with SMTP id x16-20020a056870e39000b0021edd7a2d3emr12450237oad.22.1709008943675;
        Mon, 26 Feb 2024 20:42:23 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:22 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 20/20] Staging: rtl8192e: Rename function MgntQuery_MgntFrameTxRate
Date: Mon, 26 Feb 2024 20:41:57 -0800
Message-Id: <20240227044157.407379-21-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227044157.407379-1-tdavies@darkphysics.net>
References: <20240227044157.407379-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename function MgntQuery_MgntFrameTxRate to mgnt_query_mgnt_frame_tx_rate
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index afa789fd1266..97fdca828da7 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -163,7 +163,7 @@ u8 mgnt_query_tx_rate_exclude_cck_rates(struct rtllib_device *ieee)
 	return query_rate;
 }
 
-static u8 MgntQuery_MgntFrameTxRate(struct rtllib_device *ieee)
+static u8 mgnt_query_mgnt_frame_tx_rate(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	u8 rate;
@@ -201,7 +201,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct rtllib_device *ieee)
 	if (ieee->disable_mgnt_queue)
 		tcb_desc->queue_index = HIGH_QUEUE;
 
-	tcb_desc->data_rate = MgntQuery_MgntFrameTxRate(ieee);
+	tcb_desc->data_rate = mgnt_query_mgnt_frame_tx_rate(ieee);
 	tcb_desc->ratr_index = 7;
 	tcb_desc->tx_dis_rate_fallback = 1;
 	tcb_desc->tx_use_drv_assinged_rate = 1;
@@ -277,7 +277,7 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb,
 	if (ieee->disable_mgnt_queue)
 		tcb_desc->queue_index = HIGH_QUEUE;
 
-	tcb_desc->data_rate = MgntQuery_MgntFrameTxRate(ieee);
+	tcb_desc->data_rate = mgnt_query_mgnt_frame_tx_rate(ieee);
 	tcb_desc->ratr_index = 7;
 	tcb_desc->tx_dis_rate_fallback = 1;
 	tcb_desc->tx_use_drv_assinged_rate = 1;
-- 
2.39.2


