Return-Path: <linux-kernel+bounces-141340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1904E8A1CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4742A1C22204
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB517154857;
	Thu, 11 Apr 2024 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noOcEE8f"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33684652D;
	Thu, 11 Apr 2024 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853776; cv=none; b=JMJDW3lppWVnAByuzPTffPP8IkMib3KxTyEXaLOKbDFR6/OYjEX7sKgXhoNnV76Re8H2KqAg461wtJR4BU6Vjy+3Nh9+56YovUntndF9FLYiTQrUscxwedB1QayLtufjOHR5eApQuYXJSoKdde8/8+5IcECv4fss53VaVsXEpxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853776; c=relaxed/simple;
	bh=iWW/qCaP0P9tau2/wi1UmwH7bekDCUCjwopj3xWE5g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lI0em8jYi7TNy93Jk6AVVv2NB4IleCudbNuva4EO1hwmsxpimSSV98++enc9bEB7b7YKY8w0mHrq2IzKMT802mbIGMtpGq3wRARF80q8XNkqTCKfmKUv+PhAj7nzaCSdKMOwhSWcqkKLw3Avxj22lAcOLnGlxX5W9/I9/w2GutE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noOcEE8f; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-417c5aa361cso395285e9.1;
        Thu, 11 Apr 2024 09:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712853772; x=1713458572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZmEpr7qdrpveg9LiEZiAb+CNWkMrLC0rQ3S13EVdo0=;
        b=noOcEE8fyJg3arZ+WFgFsEGt8EMerdAEoG6Tq0c6LOmrU8XEVMbnknWdav9MUP1oQz
         mzwTvYkzoSq9WCmIzBRZwCH71Kz/nJW17cZX6jWfofl07Rx0BZhfDDkiqOvOFJr+9q9K
         EjJl1wWEjOfx+Bb7ZoNlIllxzHGnlfiixx56KgawNNhrdTcvw4xzQVqaNWpyV0Y/Zi9b
         P6GRQYcMF5wR04AKX0A2BImmiG3sjcocabPuFThxhb6ElR9ZUNTrx7uaoOmX+6sjAVFn
         XnZSFj42sNpySeYZAXV14rh6SkZVHpVUfVG7qXoPx7mOqD3B7SoTyY1CC9n+/tvFdbOp
         OWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712853772; x=1713458572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZmEpr7qdrpveg9LiEZiAb+CNWkMrLC0rQ3S13EVdo0=;
        b=rLric5Sjrh9LvLyPk3aH5alUblHKLMXa1DPnRIZxKuaYndNEh0IR3St9LCRHBefzX+
         O2mt2FOhrM6Uz/e7J61f/Iv0WT7t8kofKhGGCfCN6UEfoNDFF+DW2Yqyctg1aYDlGBzw
         VwTwqit0AU6a23/klp2/s3n1HHernIqb0IIPxPYUi+UkY3M0cK8U15FBbUOTyT3N77H6
         WkxJ1TOruTLwzOuCYreYgUBvzWzWE8BWBxROFmE+Bpsccu0r7TRAWTsjpUVGpHfYbqBa
         6FDvpEKmeHvnx/leMD6CSmo5/2QHHuTADjgIJYDMf3mIx/E54GzMdS9J6oWyq1hxR/sK
         yoow==
X-Gm-Message-State: AOJu0YzMZA7HQH+i/pYz7DTDEXC82KcplrGUP3M+RhgN7wZnh0AMO7MK
	p86pTrB6/Yj584d5oIioLB5Inaua8JeBCcHjc+A+V2kM+7JE7jyOszxQUA==
X-Google-Smtp-Source: AGHT+IE1nwZZGnCs9lN5mKQ9+e0avbIXauPOHN5tbzbqmoviyDEd3bg07vRozyPSakQKtuVq9FCARQ==
X-Received: by 2002:a05:600c:500f:b0:416:a8a7:9505 with SMTP id n15-20020a05600c500f00b00416a8a79505mr219018wmr.5.1712853771996;
        Thu, 11 Apr 2024 09:42:51 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0041665b6e111sm6025351wmb.12.2024.04.11.09.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 09:42:51 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH v2 2/2] openrisc: Add support for more module relocations
Date: Thu, 11 Apr 2024 17:42:32 +0100
Message-ID: <20240411164234.1997000-3-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411164234.1997000-1-shorne@gmail.com>
References: <20240411164234.1997000-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When testing modules in OpenRISC I found R_OR1K_AHI16 (signed adjusted
high 16-bit) and R_OR1K_SLO16 (split low 16-bit) relocations are used in
modules but not implemented yet.

This patch implements the relocations. I have tested with a few modules.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/module.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/openrisc/kernel/module.c b/arch/openrisc/kernel/module.c
index 292f0afe27b9..c9ff4c4a0b29 100644
--- a/arch/openrisc/kernel/module.c
+++ b/arch/openrisc/kernel/module.c
@@ -55,6 +55,16 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 			value |= *location & 0xfc000000;
 			*location = value;
 			break;
+		case R_OR1K_AHI16:
+			/* Adjust the operand to match with a signed LO16.  */
+			value += 0x8000;
+			*((uint16_t *)location + 1) = value >> 16;
+			break;
+		case R_OR1K_SLO16:
+			/* Split value lower 16-bits.  */
+			value = ((value & 0xf800) << 10) | (value & 0x7ff);
+			*location = (*location & ~0x3e007ff) | value;
+			break;
 		default:
 			pr_err("module %s: Unknown relocation: %u\n",
 			       me->name, ELF32_R_TYPE(rel[i].r_info));
-- 
2.44.0


