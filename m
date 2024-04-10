Return-Path: <linux-kernel+bounces-138116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB6789ECCD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35B61F22F69
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8915F13D602;
	Wed, 10 Apr 2024 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAz+0yn1"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241AB13D2AE;
	Wed, 10 Apr 2024 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735798; cv=none; b=uRdINKhjU+Q9t3rBDTweUGyzJPoqSnWwaPZlOIJuV+md2sCzHkEwVbFOAPNhnS9oQropPqSG5F6XqIBbV5anUXzi6wxFY9hCZB1h6VHkqhLNV7JNJ4E1saYk7g8PpuNuOfiuHul5Cg4goCBzILiYFM/pZ3H7ahMtvZ09n/vwIB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735798; c=relaxed/simple;
	bh=t+ibFC5CrdB6C1VL/7/HFQvZhDuFrbf79uNnxu//MYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uLmxkHP3spff+cdyg+kJBojcM5opN5hXLKzxI9PgpHeIPyBeVUgIpLWEkZPeT9uwjXdz01rR5T9TtGjwpxNMXjgFgGyzlm2h/MHwbZbl5wgTZDoX1UOkZ7j8CDN16G87IoOj9GgVOxt5HNWPkZ+JaV8EZqc/IxgVh7IC0MWwpKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAz+0yn1; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ea26393116so1075681a34.0;
        Wed, 10 Apr 2024 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712735796; x=1713340596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/m8KYpcNTjRGUsaWSrcyZKH4cHf0w68olhrHphmA+s=;
        b=BAz+0yn1eYs9NJlfLQs83JWlZlc46UWTeShE7VALIvqZRij4fHkey1RKEyu/uwGDzu
         Oc84RlQ869Jmehg55sdF2QuV5od+7Cnwj453xnBDha6sFwOwSPZ1BEkcXWaZqsuIG3Dk
         YPOJPSymD7acyQr/rwcY4HrRD2igwPytNJdJqQV+NeMAKqeco/D2jJuJm0qWsFbhnI3Q
         AXR8b9GIYVxzdDwWDCfbN91clVSxS24fmev1HXIJVZKLXQPHyyGbMo5uyya31E/1GI6M
         a1QeFhzNIcroVjyjQUmYpla2sR5qcj57RGa2vULcqkCXEfCaEKe8gPWbOFduVaCoSoeN
         kdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712735796; x=1713340596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/m8KYpcNTjRGUsaWSrcyZKH4cHf0w68olhrHphmA+s=;
        b=cBuae3AYxFjPnwFw21ayQAV+kC8/1uDsGLhkFe78Zprsd5a6toDpVEJ5npmcym4YQg
         Wr4xEuAlAJl2ASN/3X3Kofro8mYig5aXatVlLmkgtIHok4KKcsCRsuNlSeZhLGlXMd+m
         d3jQA9dc4zDnCmVXkWsfiSjMQPsEFXJ2kI2XoIQGAAVS2th2DO4vWUdrzfZfCxl1W8OP
         wnF0hzJgXaH/JMZtde9LXCP70eUl6V9AaknUwgQ2qOvm8/tmIXIvzcohi+VAOJ4ZvlrG
         rrpOGF4b8LoeolgM+WTzplV04rWEdjAXyHdV+Lln0kRY8U5ERJ2GP1qzQgasNTJyxqAz
         X7oA==
X-Forwarded-Encrypted: i=1; AJvYcCUheNvBOrl9eFbp9Dk/lZJH1Em6tSQRipCV5cd083u9kjAEk2oiD6jZkWnkTO7yqlbvkTG2k57mI11QhAQna/YrY3p/YC5Sm6e6jVcg
X-Gm-Message-State: AOJu0Yy52b7QprD8tWACDqQqUCCy2YMRrGeZ7nTFDKcyWnJ8oxV91HN1
	a5gdGZFvisz0REMmANagyt0m3/WuAHqq6BOUx9iOXHKOqu1Kd2ZOE2RRo4O6
X-Google-Smtp-Source: AGHT+IFMaWI2uNQeFyG6opUO21aPm8dNFxNLmSBuVP0zCosc/PyfhFAPti4y5g6ntKqpQ0NUNQjbrw==
X-Received: by 2002:a05:6830:12d3:b0:6ea:d36:1329 with SMTP id a19-20020a05683012d300b006ea0d361329mr2085719otq.3.1712735796123;
        Wed, 10 Apr 2024 00:56:36 -0700 (PDT)
Received: from carrot.. (i220-108-140-44.s42.a014.ap.plala.or.jp. [220.108.140.44])
        by smtp.gmail.com with ESMTPSA id 3-20020a631843000000b005e485fbd455sm9438001pgy.45.2024.04.10.00.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:56:35 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs <linux-nilfs@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] nilfs2: Add kernel-doc comments to nilfs_do_roll_forward()
Date: Wed, 10 Apr 2024 16:56:27 +0900
Message-Id: <20240410075629.3441-2-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410075629.3441-1-konishi.ryusuke@gmail.com>
References: <20240410075629.3441-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Li <yang.lee@linux.alibaba.com>

This commit adds kernel-doc style comments with complete parameter
descriptions for the function nilfs_do_roll_forward.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/recovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 49a70c68bf3c..e48372618ac4 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -563,6 +563,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
  * checkpoint
  * @nilfs: nilfs object
  * @sb: super block instance
+ * @root: NILFS root instance
  * @ri: pointer to a nilfs_recovery_info
  */
 static int nilfs_do_roll_forward(struct the_nilfs *nilfs,
-- 
2.34.1


