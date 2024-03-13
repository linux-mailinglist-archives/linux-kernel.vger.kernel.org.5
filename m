Return-Path: <linux-kernel+bounces-101190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718D587A3D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E36A1F21D29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C321CF87;
	Wed, 13 Mar 2024 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQQJn8Ig"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCCA1AAD4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710316757; cv=none; b=sFTM3nZAYc4vSNMOQKpkcPn3tSh87Pf4WxJow+RXUV0uXXMLCQ41fyp0LqzGViHI49Nr94sED5nHTIwD00PYXxqLbeg+hs8vwG/rNwCNNItN45H+erH0D94CNyyjShpgOnN+FrGTb9d9waBvaF41xurAK60yauqaEcLAvehwD0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710316757; c=relaxed/simple;
	bh=obXivfF7E+Qg8Iznsw6G79d73R/MUgaLs32PvM0qVFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nXabxbfkWGjC7cvk1W9ruybC1MWVAEeFSmkVqhOH8EpWf3GWMy9KHPsE5vwu9Ko6jAijJlGcHszlFj58NSdoZ3HYBLXEwFk3yPtVylJV0kLUGOzaheMDcjZQkghKyBMDQQEohXPFC2+aE/jc1DlLMg/E4PUt1KSfOAu3RiyOTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQQJn8Ig; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56877761303so1697752a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 00:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710316754; x=1710921554; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wrnm8nAMmPhT5umInNW1PAAnG9V/dud8dEQbqU6dbpM=;
        b=UQQJn8IgVzKySajSjoK1l2ZpmB04brKXJ9nXFjQGse9QpzuRbGreBBmaeZEzy7R20S
         Bq0BZ9qa2vTxgJc/2u5mzy9O6tWs3RvN0PE3YOvpDxJrLHKuS7yGGZnnx3ihMw7ljU/a
         Sp+OiW3yMOcBvhfqiyDTnsLXyBO6rI7To+SrR7fNiEWsuKgjraJDcZ6KjW12KS6Q2pcw
         9ZArcz+m+F+4F+qxbk/Y139diAQCgJFl3VEi2YIJ373kqs9bE8lc9/+JcZDfVWpDVvXf
         XnxrG4bGa724C3LsnujxwJ+FJvDGkU9edNa6diWxpXLr2vkLY1T63nNpWfL/KXs9q5dv
         Rz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710316754; x=1710921554;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wrnm8nAMmPhT5umInNW1PAAnG9V/dud8dEQbqU6dbpM=;
        b=k55LyqmJCmWSoDcTCr1LG1pt7s/EPszzNEbwcYvNNK2cjc/Sg1sEB6ogryVDhtr712
         /wEXyl+bq57Ix2GkhBT0qDDCYjetWXngUM3p2qFOpXnJjPtBEf3XgZe66XWk8p9Q5Xjz
         BCMzIX46GsOIJ8/PXfcipuHUbIxoH6p5FeePS1dIy8otGWIB0A8rQn4O/h/WaOiwuaMK
         PAHGDctFjoVw1S+CEcqacOUJbnSctiHV6hjiJvcTl8k8UOquMHU0d9S27bnVk7ceVMX2
         OLqgIWobZgF0ISXST4mn7aPCJp/pJaK5414LbiNjK63+JUe9qqt6dhSfzejWlsQVbY4G
         EsTw==
X-Forwarded-Encrypted: i=1; AJvYcCVeZHu6eGQ9UkT8uFFs1+ZqdNp9qUEV4U1PoAMFZIiNcpFcwn4RtQIIJ/eCVu7mfo3b/1xjwfYMJ8gkQ35DQDdLAct6cJzGpXAhIC35
X-Gm-Message-State: AOJu0YwG+XaXOaJ0C7+P7R8xn11HeLfBYI0szk4AbBe25wN3xROgBf0K
	6ISDXc82iTWGSsQELReY+pvT+24i42E2y3JbvKX2cloY0Lx1a7H3
X-Google-Smtp-Source: AGHT+IHfcNH1IR7eAO+6tj1I7o0filQpt97iIoZFKXVns+GITmlG2JVBGhf+s3v7yyuLvy7iFEbQAw==
X-Received: by 2002:a50:d71b:0:b0:567:504e:e779 with SMTP id t27-20020a50d71b000000b00567504ee779mr2644679edi.25.1710316753549;
        Wed, 13 Mar 2024 00:59:13 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id ij12-20020a056402158c00b00562d908daf4sm4703669edb.84.2024.03.13.00.59.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2024 00:59:12 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 3/4] x86/vmlinux.lds.S: remove conditional definition of LOAD_OFFSET
Date: Wed, 13 Mar 2024 07:58:38 +0000
Message-Id: <20240313075839.8321-4-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240313075839.8321-1-richard.weiyang@gmail.com>
References: <20240313075839.8321-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In vmlinux.lds.S, we define LOAD_OFFSET conditionally to __PAGE_OFFSET
or __START_KERNEL_map. While __START_KERNEL_map is already defined to
the same value with the same condition.

So it is fine to define LOAD_OFFSET to __START_KERNEL_map directly.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 arch/x86/kernel/vmlinux.lds.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 56451fd2099e..88dcf9366949 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -15,11 +15,7 @@
  * put it inside the section definition.
  */
 
-#ifdef CONFIG_X86_32
-#define LOAD_OFFSET __PAGE_OFFSET
-#else
 #define LOAD_OFFSET __START_KERNEL_map
-#endif
 
 #define RUNTIME_DISCARD_EXIT
 #define EMITS_PT_NOTE
-- 
2.34.1


