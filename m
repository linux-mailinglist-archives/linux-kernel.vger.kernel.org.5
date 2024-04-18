Return-Path: <linux-kernel+bounces-149480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E208A91A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E869528358D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41B15465C;
	Thu, 18 Apr 2024 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BKnvbXR3"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED252537FC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713411866; cv=none; b=Js69Q3xCZyCwLI28ggCvqrQUwGOMC2BcrXWx17gb0K4keDB+CL/Jmf+WRz7mTALAZDOjjYt/FkwjpXDdjIv0ALcgyqPHS9ma5OJf5xM4F0VDz6E+7vB5kG26gVoYsoON92N91sFCBKAFDbZFCHvpF5IQ/hbn6V+iAyz+kCzZLoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713411866; c=relaxed/simple;
	bh=QNVH3MIBJcQmxrWe2ac9gxarQYaj//Q6x262C7JK6dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XQ40x6vdvMtN3BXWJ1qkLgjuJNgjQW55/t8a+qbgxQAWrvvBCSZiNNVq5OdLYsei6SXebZGsPogfxTgHjtLJXsCeIM8VJoYmzH1LictVUo+cs1odRRDdFherjtIbweHY/3+hM6dtggFLh4jW4L50mgBVKe+WCkfwtowD7jyjsjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BKnvbXR3; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so290103a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713411864; x=1714016664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJMTHk2ffl+E4VuUN8SIjJ1xv6FPsnu6lwF/hE1PNxY=;
        b=BKnvbXR3CRK7oIzwDQaqPgTamslDw9XFjEk1hkb9FUZ3jJA4dGbctHo57DC32AMi5q
         CxAoI+D7L0SKwtZ7m2YiaV7ahkhl/7IgUGraJmBSYhER/WEJlOSmhjmi1JiUEsd8vkMt
         OsFt2wQ6KjdiWBXs7cP20KOdS002krRXVv4dgZDOzBAEpnW5Ayq7cZyyCHmxlFa6Vp3Y
         ICH4b61h/KdlXNdZAjxWZ+lL2Kct5J0hpF3kkIb3s20kcIT6ILvi6DMdnqI9xENCvZpG
         pwlAjRUHpWICl6YjXSwFF5JZhmWiTdWOEnnZwnmKlGLSf4TMTPaLOLiEk8duQWv1Lag3
         Epbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713411864; x=1714016664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJMTHk2ffl+E4VuUN8SIjJ1xv6FPsnu6lwF/hE1PNxY=;
        b=vuVZhMmSl+nz94pgYI3NYDLIaN44bvfp0ZGvTxzDwupneQ5tOPB8vMaNkIXa6AYZE9
         Qg+k0j+42CZTuU5czL3oVIp1NexPsuiHxppZdp8sr/hniCr6sXLVPI2RFBU8rZM9TiuG
         vYlPQnKU1mvog8NGYI1gsqlugGMIEbvPlGarg8R5jpCXus5GsdzbY7gb7eB4fDyRDqLz
         zsZ61TNVrFqNHDWF3W91wAxv1iiXh7AHsdjg6Nn4RobxnhjW02Qh1OEW7mhTHy8YvTUC
         dTIDVpfCJ0eKbQGoTdB7iabK9IS+yNgTs4ZKz8bKfC6lI1tNiqkBqVc+a8kr84pFsuwA
         5pJg==
X-Forwarded-Encrypted: i=1; AJvYcCUss3xXR+BQ9usYl8jPz/zt3j994Otoyk0Bbxkk26rk+Y67v0MI+nFqKgrfbAB52V/+p4gpdtDG3lGjM0MuPH6su0rS5CroLUnEgXpP
X-Gm-Message-State: AOJu0Yy84MmCuusQXvWmHSCZOoCqfifh7KAKkXnGLTraQSsc+D1tC6rU
	FSdZkhXJqF4na+0bSiItg3h5P5uCuMz7UAF65MYynMNwHT+i4zpZN2ff2y7jCYiVHyFwJQskT3N
	Wpo4=
X-Google-Smtp-Source: AGHT+IGNfSaOuVzuIVb16fk0/zNgAN8yvRyFpld65Vh6hV1yYO9gxMq2J7SgUz5g6XQxK1IMaY0L7g==
X-Received: by 2002:a05:6a21:398c:b0:1a7:4a23:69b5 with SMTP id ad12-20020a056a21398c00b001a74a2369b5mr2083909pzc.8.1713411864354;
        Wed, 17 Apr 2024 20:44:24 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id lb4-20020a170902fa4400b001e88a4ebeb2sm109880plb.152.2024.04.17.20.44.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Apr 2024 20:44:24 -0700 (PDT)
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
Subject: [PATCH v4 3/3] RISC-V: Select ACPI PPTT drivers
Date: Thu, 18 Apr 2024 11:43:30 +0800
Message-Id: <20240418034330.84721-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240418034330.84721-1-cuiyunhui@bytedance.com>
References: <20240418034330.84721-1-cuiyunhui@bytedance.com>
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
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
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


