Return-Path: <linux-kernel+bounces-74223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E3785D14B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EDD1F21622
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459CA3C48A;
	Wed, 21 Feb 2024 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RCsgoIja"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B153BB55
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500365; cv=none; b=a9r5wryGRfyhuY0SYSWR+Pp7ZabG8tPmW00+nVkRDDOBxNRJ7QxvJaHvHwiDuuqYpLZaKh6LeKHRNyN6Lt9etZtKSmVpl4BW6ubUEh/c4K3xoVOmtx+EsUrmRQQVJR39P+5Auki5V+Tg6Sc2zYrrtuY8UHCRmJ97rj6JdfXddVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500365; c=relaxed/simple;
	bh=Eal+RK83X0qlcGcNEk7z0E4RBKeo7UGh4/zIqBRmhh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMZP2r/WF4WWeGHCnFKLWYvjv8jTkel/+EvOD+i+HEmFSJL2KkUGgQHY30GTNmmjU19Q6OZstVfEi2XfOv5T99RW1Z/qLygmIJyA/C2GXwf4vLRv+kbdq/a8OF6ck0s9pPu3Y8DSn0gndfZJu1hy2LAa5DkRQGUBHQ2Mae97v7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RCsgoIja; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dba6b9b060so33097685ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708500363; x=1709105163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLOffij4aJB+MGCya8s97VNV+p1K3jV5QIE+Q+bz00I=;
        b=RCsgoIjaY4LMlPmm2Edxq6CXzr9Xcd52w12tT2X5R7mBMwfY47Qh5R5XGbqdxgeIUX
         2+zCD8Zsd1zSlF2xVDzwYDam/c/qSDKc2CacnFlNrV3eLXw12JxfEIdmDc5viedNOhu1
         if/aBKnA7SxfDewu8Q/5sdckYA6yqJJ/g4h/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708500363; x=1709105163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLOffij4aJB+MGCya8s97VNV+p1K3jV5QIE+Q+bz00I=;
        b=Dspw12b4yWzeQ+LvKU3CPC5FU4+0qYUgLXb0s9dHOYsPW2qxHFpomJ2UIuWlRt+yuo
         3h3edH0vH7pBDoAxvj9RwdcP9gPowcoIQRQ1M+S9e6PrK1O4HPUjh58E/OjQYqOYu1Mc
         0GYQ+yBNqQz88GArQXKMWP/KTP+Z6ExpL1Hm5oimVJDKRvxJ/Wy1KFlDIScCNLv0W63d
         1BFtLRpKgO12vWQHlkVz26RvOWZh3q5yejgUVstDvgAnsYQu1Dw7KjFdoRklzBVqtOJ7
         lCsr7JS4Z42CrN5kz9JUFYjvH9AKzs71yd1Hcwgv8ryYHIpdAkzcj71KElF0hErhF9Mq
         uHoA==
X-Forwarded-Encrypted: i=1; AJvYcCVteE0C2GhJQ7/guN/raB/6qhUT7PlgRxFnaSzvjtXAT6LSah2+RWJCSdBtz36i358gXWJMg4Q6lvhXe3OOu3VXXLTvxtm8Yayo/+Gd
X-Gm-Message-State: AOJu0YygVNCQTtQx0g/CClgHyUHAvZwubGUKrsRvS/25nh0Z0TPgN5Zy
	tNdnaS7MNziJ+njfPt3etK+S0hlxvvtp0jEX/LPAnkF4H3uVeVDYxI/igW8tow==
X-Google-Smtp-Source: AGHT+IGuByzcDeNqa0h3/F4p6FUZXddbiOGTGnCFrf3ufIz55abOi6o/JeNcHuNQgDfA/CeMO+SZRQ==
X-Received: by 2002:a17:903:2282:b0:1db:b5be:5981 with SMTP id b2-20020a170903228200b001dbb5be5981mr17305270plh.31.1708500363442;
        Tue, 20 Feb 2024 23:26:03 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:b417:5d09:c226:a19c])
        by smtp.gmail.com with UTF8SMTPSA id t11-20020a170902d28b00b001db40e91beesm7415349plc.285.2024.02.20.23.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 23:26:03 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v10 2/8] KVM: Relax BUG_ON argument validation
Date: Wed, 21 Feb 2024 16:25:20 +0900
Message-ID: <20240221072528.2702048-3-stevensd@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240221072528.2702048-1-stevensd@google.com>
References: <20240221072528.2702048-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Stevens <stevensd@chromium.org>

hva_to_pfn() includes a check that KVM isn't trying to do an async page
fault in a situation where it can't sleep. Downgrade this check from a
BUG_ON() to a WARN_ON_ONCE(), since DoS'ing the guest (at worst) is
better than bringing down the host.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c5e4bf7c48f9..6f37d56fb2fc 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2979,7 +2979,7 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool interruptible,
 	int npages, r;
 
 	/* we can do it either atomically or asynchronously, not both */
-	BUG_ON(atomic && async);
+	WARN_ON_ONCE(atomic && async);
 
 	if (hva_to_pfn_fast(addr, write_fault, writable, &pfn))
 		return pfn;
-- 
2.44.0.rc0.258.g7320e95886-goog


