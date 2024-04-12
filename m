Return-Path: <linux-kernel+bounces-142196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD948A28B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB861F22D00
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD3B4DA05;
	Fri, 12 Apr 2024 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSklixnt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF53250243
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908986; cv=none; b=A+cGMks2moahscZuFbhrz9l4KiFigrqa3gGX8bda5xYFsWN6qsFSsBO4ZAnNXMSCTiz1SEbIuQULF7GVNjPgCCJZyjUWVFPQxUEkbCk4F6BTqIld/4skzr/+mTJNIDYDM9A6S8D076pNeBRmBWKvndD5PNqlDKytpIpzWONRudg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908986; c=relaxed/simple;
	bh=OpO8oB2yCRllOLrXtydV1XjyFATr3uDCO6/EuRZx4a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtKlUtdznAc0vjNQEMXWEY9F2JxdogUDUmIIAc5fr1F2DA0CJmlblUGeHAx/jzf5UUA59sC4zhWFGRJMlgsaRFyVh0j/BEAsoODChAQjSy+vC+LUl09WqAx3l3JwfqPc8l1VxdQRrg0rsOXxkPlArfGRnyXazkoYduMIx/zwj74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WSklixnt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712908983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lECrQISwTyfiQuZfzhaacIj2l/HO/4HjKmgRSsbNnU4=;
	b=WSklixntNXbvHU3nK/qbaXUyQjf2NuAb6SYqL3vpxX0hS33DVo+o4VZNk4GMcgQhrJpvnU
	28HmSVeMeMPxy5ePh0L7GAcD0JulNyfV1Remds7iaKYKZekFbEIN2gVi81QjRUbEGYNANe
	Axuemh8/flyx+q9TMSbZ/samNL8yaCk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-ZqyXDCeONeGYIW77L6Zz2w-1; Fri, 12 Apr 2024 04:03:02 -0400
X-MC-Unique: ZqyXDCeONeGYIW77L6Zz2w-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a4a2cace80so563096a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712908979; x=1713513779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lECrQISwTyfiQuZfzhaacIj2l/HO/4HjKmgRSsbNnU4=;
        b=EL/My7JnJhvl8sjdO5StRa/nULnKospuENXbNtBna0qw250XltPG9wKqVwoJRMgQfU
         pZm5QSLXuN0JiPsAVkCIhF6Lu9fevTKfImggiifIIRH2+yA/bX7+G1UCzQkFTEogK2yG
         c7EeuIDxJxlzO+lKV7WPAb2L71V4ik7EMi/JeutdPrvgH/1JFNojA5jfqGmk45xk3Ftv
         2UT9aXiZzJzHnEO0IIKXqCirQSR7Hk4Kmzf8yGgiPR3t6r+gRqeo8LsI8hXga5UGlGjN
         crWAyJwMQ6CdcPF0SpBMfOZ311NLM9T6o6DXc3sQHYxYw7/qifY02SM+shzWHOaJkkyK
         Iirw==
X-Forwarded-Encrypted: i=1; AJvYcCUF0xwmO1wDpzUgvXVXDEsDlkCeWo8tJIJzwsfZCkokWrZOqGdn9rxkFH8th0Hf+mNhRKN+rHhMQPvMAHtiNyRHN/AVoLCyojbM6Ih4
X-Gm-Message-State: AOJu0YyE3NdCVqr1Cx2QM9sGkcHMYN5ooPHT0hjYKfJbGXoc65y3WHpX
	EPw5rwTp/FL3YxPJUSjGYLaXCVE3ZXUKElwWzBZAF/Q8hNOqLb+Jw2qvKTEjZsMVDwApil6l7hf
	hri1bYMcqNKqmWTFZZlTNMTqiNTrPq01nYtkhkovetnEBxtwKhHrX5XyZ0xptTA==
X-Received: by 2002:a17:90b:1001:b0:2a2:775:9830 with SMTP id gm1-20020a17090b100100b002a207759830mr1909388pjb.11.1712908978902;
        Fri, 12 Apr 2024 01:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF24h9XG4blfy/RFGcd4FjC17Unma1YbnMvxv8GsHe0ou75G0czKI/fwNaCpVH6a/ltnSojBg==
X-Received: by 2002:a17:90b:1001:b0:2a2:775:9830 with SMTP id gm1-20020a17090b100100b002a207759830mr1909371pjb.11.1712908978644;
        Fri, 12 Apr 2024 01:02:58 -0700 (PDT)
Received: from Samantha.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090abf0900b002a610ef880bsm2601514pjs.6.2024.04.12.01.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 01:02:58 -0700 (PDT)
From: wefu@redhat.com
To: jszhang@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	guoren@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Wei Fu <wefu@redhat.com>
Subject: [PATCH 3/5] drivers/rtc/rtc-xgene: Add "snps,dw-apb-rtc" into the "compatible"
Date: Fri, 12 Apr 2024 16:01:45 +0800
Message-ID: <20240412080238.134191-4-wefu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412080238.134191-1-wefu@redhat.com>
References: <20240412080238.134191-1-wefu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Fu <wefu@redhat.com>

This patch add "snps,dw-apb-rtc" into the "compatible".

Signed-off-by: Wei Fu <wefu@redhat.com>
---
 drivers/rtc/rtc-xgene.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
index 4d6f1629b973..5163682f9816 100644
--- a/drivers/rtc/rtc-xgene.c
+++ b/drivers/rtc/rtc-xgene.c
@@ -287,6 +287,7 @@ static SIMPLE_DEV_PM_OPS(xgene_rtc_pm_ops, xgene_rtc_suspend, xgene_rtc_resume);
 #ifdef CONFIG_OF
 static const struct of_device_id xgene_rtc_of_match[] = {
 	{.compatible = "apm,xgene-rtc" },
+	{.compatible = "snps,dw-apb-rtc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, xgene_rtc_of_match);
-- 
2.44.0


