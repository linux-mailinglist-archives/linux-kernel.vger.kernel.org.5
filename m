Return-Path: <linux-kernel+bounces-146149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CAA8A6156
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E35AB21B50
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED0017BD9;
	Tue, 16 Apr 2024 03:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="POaODImO"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1A1219E1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237302; cv=none; b=juHR7lWarRalqH0NPcfG1KgfjyVc/hOBh49FfJTQ8np1w8g791HWoC6GJ2BstyPZpEE8Hcu351AhIjDAMphuuwWl3aBDczJNZz3TESboE+e5QEw+CbN4woG/o5gU8p0nXuh6vU5xD09g86t3PVAvn3fGVsKgWWa1W3Fqv8/cFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237302; c=relaxed/simple;
	bh=74/j8ENughgKXArfiTJjMj2qv/FhTXWLGElJJX5xuq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A7rQQtVx3cfbIEnoodpp6GQ5vCu46CGRc7LUKE5hXbiUscCo/mL5zK40Yx6wEg4yywTAxicGhVuMCTZGHVJ0W+VpZTRGhTf1/afpTqJc0gZriDHjjV1g3I6u3OSHxZj9Cx2tsTZ44UGf9JvIsblSPvR9sopdCE0lpLm4bvxnDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=POaODImO; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-22efc6b8dc5so2739915fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713237300; x=1713842100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hheiXqV+1wPbN2r8XTJ5OPePJHFHtIdLdr/kVMTR0TE=;
        b=POaODImOE0GrDhMkCrPC5b1c4UeZhlUiLUyBc69bAN153de2BSJpaBjAJsiN7gLb0+
         JpOAJSyHB+qPQxST5KrPf0UGSDMckVHBUmc9EMq06Meat5WOuD1eHDFb6Nhj9LV3Quqp
         dugLoXjofPWEz+6pmL0jqFgR94aJId6PXKfEXLezqi3n+y7LRhqXAuDurXp8v9+tYVRh
         tET2GyVPDQOhGwd+QPgkM2dnGI/+rbDTeZZa5Ebk7wa57aVZueKw5u9IXcOGeKho5qgq
         xnu+0mr4WurKgAF9GLNOL1xJgCzY9HyzAIPFeT0rlJU50k4n+YZ56rAjSfwAsdrtWrmb
         xlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713237300; x=1713842100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hheiXqV+1wPbN2r8XTJ5OPePJHFHtIdLdr/kVMTR0TE=;
        b=PztQbdnXYslz8Te3PSg8B9awIkbNXG/T0KMWEbAZRUv3cgiuaaZPzWHttI7TPnGkU2
         xXsn9nI9IKBX+34p0U5vGgfxLcM/bgjOObQW3nF4YOtqPFHaQXYinyi3apw2HJ1naqYB
         rp10jUPRkVTv+TfT/yo8wYW6AUUVcd/MuQBULfDqwYGiDvmZ24U8rzZmrLRTuqtn/B5O
         fdr4mYbcAnCUQ3TDHA/JyHYysl+uITFnm4cejIxj34Lkb87me2C3lX8T4QQDcz+QBN8/
         8OgrkgGz1DRRqs5Jvm5VBVSpFJcJrESzn++FZMSb8PrisIQNw+npMjEa/g6LfjH5c1Mv
         e0AA==
X-Forwarded-Encrypted: i=1; AJvYcCX3x/dsbh13DHk+LKp1EcaxjCbOZvMVL7DowNSeH++X5Bh7lP5/1NArCqXcpHjEhiWrfVn2XHKcnyFNLR9ATaVFqoleCVYahuIyOC/F
X-Gm-Message-State: AOJu0Yz9uwyfLL2rWzQdYEiqb6P9h3b7eNCIayUPK9yOg7yGfOVFkkXB
	8N1oCqs7wLCkO3/sZJDJa7vU2ihv5QH03q8DfPOWH3fk5gYNEJKqOIamFsCTgM8=
X-Google-Smtp-Source: AGHT+IGHqrx1cBNmqnGC6ynZDle54CpzgsuaxouCGoQwD7AV+L407iMBlKY6fL1a8Ib2gQlJQspleg==
X-Received: by 2002:a05:6871:553:b0:22e:a970:a2ba with SMTP id t19-20020a056871055300b0022ea970a2bamr13356803oal.8.1713237300386;
        Mon, 15 Apr 2024 20:15:00 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d20-20020aa78694000000b006e6adfb8897sm7907983pfo.156.2024.04.15.20.14.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Apr 2024 20:15:00 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	bhelgaas@google.com,
	james.morse@arm.com,
	jhugo@codeaurora.org,
	jeremy.linton@arm.com,
	john.garry@huawei.com,
	Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com,
	sudeep.holla@arm.com,
	tiantao6@huawei.com
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v3 3/3] RISC-V: Select ACPI PPTT drivers
Date: Tue, 16 Apr 2024 11:14:38 +0800
Message-Id: <20240416031438.7637-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240416031438.7637-1-cuiyunhui@bytedance.com>
References: <20240416031438.7637-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After adding ACPI support to populate_cache_leaves(), RISC-V can build
cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
configuration.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6d64888134ba..5d73fcaf9136 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -14,6 +14,7 @@ config RISCV
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ACPI_PPTT if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
-- 
2.20.1


