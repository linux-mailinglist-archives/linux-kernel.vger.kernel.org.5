Return-Path: <linux-kernel+bounces-101191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F2787A3D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8462A282E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7FA171C9;
	Wed, 13 Mar 2024 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmYOzmEO"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1621BC44
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710316758; cv=none; b=Wa5iScMrKaeN6P3fW+cf+bh707vXJjg662OrgOocfnHydEjM3c1lK32eBmBqX0lUSRL4wQ0y2ognj66siqOfSolQFYr8SV8Bgt6f/uifGpB3ifoSY1gv+c7POsBnIKR9ucxTXkdy4MLugMEiAlMaLdgpMkCkAmHGI/WJJxOiWE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710316758; c=relaxed/simple;
	bh=1+DXzCnJVRzq9ikXnxmeY9e9axFtJowM0Dq90O4pxOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nqnwAM2gV4nK3/zjQJxSdUzUJs6jCvV7qIKF77mLU9wV5reBKlCDzpEEeGM0zJ8D4DDUc8mXC+QhRPp3SsMfNptyXSVBHnWl8MBjs5zLgzLB3YQzwTWyIVefIV0n6LnuVpx4j0yu5fTRl9OBKabtyBRMNJjPd52HoK6iQC95YQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmYOzmEO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3122b70439so806499466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 00:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710316755; x=1710921555; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lThlzUpTfw33GBSfE7OBF8oobbCjMuUfx5aiF03E7Bo=;
        b=ZmYOzmEOHvxPB3MC3sC5tPu0qN2vZdrj6ejRqF/tVIDJm8ZXwyZ9sEJT+qydcVnBcG
         4zDRtM5V4tCDncAoc7wtK21G1Q7cIIWnDuCdHLd1loMfgRiP5I0oHLlbFqlpg03bOHYb
         07QjYtaDttVwFEAvZS0IP1b29g8d8LRb+rf1Sl9L862VaQORltlTht5bxX/mC+/v3l7J
         qZ0SeCemzoPmLmyfDvruM9bGGcwnvCp3thiMEkUgnJugZAPP+uVhNVHLhDvJBDRtXDc/
         F2rdwPmF93yZ/PNV1BnyBYkrdGKEKzzyW9iM/tJbff/Z2MQzLgd0BJ4S81MPp/w16iUM
         0F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710316755; x=1710921555;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lThlzUpTfw33GBSfE7OBF8oobbCjMuUfx5aiF03E7Bo=;
        b=D0QzkpMdm5iQFedmzFgmklFOSTPCWHRWAO38ue9XVOFZHVblvHSJ56MUf/9tM9tptT
         1HRMKuet1N+WK+jh2kytMQqU1RDBL3VL4oUk47Dv0bsxZqlIZKgFvdzqNeYuwYlBgzAQ
         0u0UFMRYC8MiyeVD5+IHbWJoSybc6DYGcUyjO2ZY1hV1TCgWy1aeHEqBdvF4cyRmV2i2
         tGB7Y4D55ac9QhZgYkVWGna9SLQKG34lJM/G/RYq/xPUVdSZcZ2EBv9BNqV7Mx6PD0GZ
         5EqIOW3Hi8TMq+Jw6hpmBgQDedhMngNbhpX0Txejsj2OTzclVKLrWpwzJ2tWJ7jx2Kib
         RMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyA24JmsF7enKfAv6r2NoOMZnqk7kEKO8D3pTl8tq+EomntfRazVxZFVq9A5EF78MpxqJZT+jIphapInBWF0jkbsBOvi4DwqcgMcS9
X-Gm-Message-State: AOJu0Yx0WOV8QE/mfvUzi9ub40RUGUk2+n7LRe1VI9cnurT8j2yckqEf
	+K1RjOfc3l4QbHlUnTKM2j6GuSoee+zS9BisAsI2/KpzYbBvdrrx
X-Google-Smtp-Source: AGHT+IEeqKuY3XAEkXPH27B6NIkM/m36h7iNcF1+zcQNV8MpKZ1Mq5IagVQGz+FpzW91L7aa3fy2ng==
X-Received: by 2002:a17:907:7f04:b0:a46:50e8:2798 with SMTP id qf4-20020a1709077f0400b00a4650e82798mr1318403ejc.7.1710316755186;
        Wed, 13 Mar 2024 00:59:15 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id dk16-20020a170907941000b00a4660932864sm207189ejc.147.2024.03.13.00.59.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2024 00:59:14 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 4/4] x86/vmlinux.lds.S: take __START_KERNEL out conditional definition
Date: Wed, 13 Mar 2024 07:58:39 +0000
Message-Id: <20240313075839.8321-5-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240313075839.8321-1-richard.weiyang@gmail.com>
References: <20240313075839.8321-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

If CONFIG_X86_32, the section start address is defined to be
"LOAD_OFFSET + LOAD_PHYSICAL_ADDR", which is the same as
__START_KERNEL_map.

Let's take it out to remove the complexity.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 arch/x86/kernel/vmlinux.lds.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 88dcf9366949..a20409b0a3f2 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -110,11 +110,10 @@ PHDRS {
 
 SECTIONS
 {
+	. = __START_KERNEL;
 #ifdef CONFIG_X86_32
-	. = LOAD_OFFSET + LOAD_PHYSICAL_ADDR;
 	phys_startup_32 = ABSOLUTE(startup_32 - LOAD_OFFSET);
 #else
-	. = __START_KERNEL;
 	phys_startup_64 = ABSOLUTE(startup_64 - LOAD_OFFSET);
 #endif
 
-- 
2.34.1


