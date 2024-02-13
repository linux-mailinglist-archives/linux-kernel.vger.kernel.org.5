Return-Path: <linux-kernel+bounces-64470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF6D853EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE411C265D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D292626B2;
	Tue, 13 Feb 2024 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G18JE+R3"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683546217C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863959; cv=none; b=FaOnZorGpN0Wu4SUaBStG3iXskMfnPgBq8yROECP4qXdc3fizU5vY8O4rgbGKjhZ/H2BiU697roN8KCj77LcyzyguXtLZjLOXTJPvLL7KexchY0Ob4COQJvJlVyJUgiaZccFVx8CGwqvIQbI2UDHSuhv2BESkAthf+uErJq8imo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863959; c=relaxed/simple;
	bh=aWCHLrMWvz1iEJxSs/erFmVp3j3FTeFvrovIT7n13eE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=McB6k9n44E+eZ8wLJhuBuaBfuYxLziQBrSqAWU3C1k1dTyYadxtG9DBltWiFE04wuVafP0tOG8cnA+0xdSUkyoRvKrYNIV3eTqiPqSF6QdXLy+n0V8qCudL6TGVe5T2femrX25f6S0Au4EZTqFUzK/hPg0tr2lw6wb6/jGYi+p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G18JE+R3; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5eba564eb3fso100321717b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707863957; x=1708468757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+XclenF7edwwSVr3OOR82CqqLoH3szu5C7L/BS0M2Y=;
        b=G18JE+R3YYn7/wNfvIUbr7NPgRykF7ZLwvWTu/Zg/adzboDasUPgZnasY9kec8kujP
         +gY4NVPZGRSbrRSR6hRS01b3BlVa1V4b0M5KQHhENxXhcoolXpKAKsWqASixGoA7Exbm
         m0cHm/A9CzECM5IdeCoZAiLgEAHZxamk0tdoBNmNSBeX2w+aitmAQWnKKuQ6GKMhEJJX
         Mbyahtv9JJKNbRYB2oC4pO/77iZsKNSj3dacoXRsoKO0s/HTz9NAaP+WQezAL3WPZsuF
         PepPw0x4d0NYEqWhhoqjztjomydBn7jCDY+/dTaYFVzyrLPvu/Od0p4WgZ5VS1kFgT44
         sMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707863957; x=1708468757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+XclenF7edwwSVr3OOR82CqqLoH3szu5C7L/BS0M2Y=;
        b=IzWWmOySB4rfPZfQ951P6MylKl+kahbF+IEyrJmbAbpmS5DgBrB4VYzQLiCGD7Rj6J
         K3KWAcS/1O2z3GC4Z2gydt4yJ/3J3Rxnl6tCPE7478Wvv69zmLIYBV3EsGFFAzlIE1lz
         PMpDPAt3AfKbvv894wdUKzJRgiHftmzj1SSwYY5wa9CofOJg66VCW0lq56BawjmQASVa
         tsuu0dJpUcx7ZeeaMWjhrSaLa4NVAcey9cbpNxQZiioSb+VYJINTmk0VKIqE2cO/gWlY
         3oiSef8suZSf52QxfCTHN1WMMNDn6C38+xHt+MyjgvyvvMROYlfjVsTLAbQmULlWGT/5
         RkEw==
X-Forwarded-Encrypted: i=1; AJvYcCWJB6s0uOWf/gL4yJ56gcBGsj937G41IEiLhVORwJ08yb2+9MSbW+R2yJ3Y0IBSTo4F7PbSyjxrafAEcRUQAK7Jn+lqXaYfaw+DW9ym
X-Gm-Message-State: AOJu0Ywrtu06hc3SiTfjSGmGtJH3xxOisP1Sb0VqChUdlNs8AAbhqKgG
	WeErNsb5Yw1oBF+qtMDxekerIwi0zhBxJf01cC6tBBVLd4/IdG/3BLQT5yr1yBxsddq8YloJt9c
	0ciyYuw4NoKvT/IPj4g==
X-Google-Smtp-Source: AGHT+IEcc9zr27PaqvdbS3eM06FWNElPCCH1CI70az8q5NCXA70g8DXiOv+Y8BsNy6nYj39BxKXFXZimf3THa0dX
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a25:d842:0:b0:dc6:e8a7:fdba with SMTP
 id p63-20020a25d842000000b00dc6e8a7fdbamr161224ybg.4.1707863957363; Tue, 13
 Feb 2024 14:39:17 -0800 (PST)
Date: Tue, 13 Feb 2024 22:39:09 +0000
In-Reply-To: <20240213223810.2595804-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213223810.2595804-1-ericchancf@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213223909.2596587-1-ericchancf@google.com>
Subject: [PATCH v5 1/4] riscv/barrier: Define __{mb,rmb,wmb}
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

Introduce __{mb,rmb,wmb}, and rely on the generic definitions for
{mb,rmb,wmb}. Although KCSAN is not yet support, it can be made more
consistent with generic instrumentation.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
 arch/riscv/include/asm/barrier.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index 110752594228..4c49a8ff2c68 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -20,9 +20,9 @@
 	__asm__ __volatile__ ("fence " #p "," #s : : : "memory")
 
 /* These barriers need to enforce ordering on both devices or memory. */
-#define mb()		RISCV_FENCE(iorw,iorw)
-#define rmb()		RISCV_FENCE(ir,ir)
-#define wmb()		RISCV_FENCE(ow,ow)
+#define __mb()		RISCV_FENCE(iorw,iorw)
+#define __rmb()		RISCV_FENCE(ir,ir)
+#define __wmb()		RISCV_FENCE(ow,ow)
 
 /* These barriers do not need to enforce ordering on devices, just memory. */
 #define __smp_mb()	RISCV_FENCE(rw,rw)
-- 
2.43.0.687.g38aa6559b0-goog


