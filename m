Return-Path: <linux-kernel+bounces-95736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9398751E5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9021F26554
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8477412E1FF;
	Thu,  7 Mar 2024 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gd3VD6pP"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992912D775
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821845; cv=none; b=Ln7F+dSPcNy6R3Tffyr80ZnDQkt/QRvVwOnAO87s0iDGOn6AdjD4w3fXtPe3VbPRY50Yyqdg/M0jhUqeGpEX0tYyJJQk20XMWK5ZWrGqIlv45LU5v+J+beKstHVgwm/5YCf/RFDLFdi7EMj3HzhY3viU72qkAp8Eg2yOx3aaQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821845; c=relaxed/simple;
	bh=UTuLmMTS04YQv+1kV2RLF+kAKJaw1Twbwpr8WP2B/6U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vBFXLjz01BiPzzQBhAvkReV7Ase/Z6PRF+wviqeHpVzd9sfjvc0YijLobaOnvS6txfumHnOYS5zwkNQV1O6uRGPaBCLU2CjEtt5LQcz6vYqZXfJmhN6fl24lHWJwjMisZxU7BAJCbJPAhNqc/FPfb0Kz+/8QM/dksKlXYrp3ytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gd3VD6pP; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-412fb99c892so5594385e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709821842; x=1710426642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+6SKyQ7N12OXHoPi73bVvaX3Vl8PL50OxbEZ/LFW1I=;
        b=gd3VD6pPxFroOyhxv8HFLwkgdqh5eEjWy9Om+VnTQAFsEKnVlB0okS8IU2v4rtBJsD
         vafnRwBKK/dgyxsuqyiwaNtAo8iPlMAWXAl4ewBVcGir+6O4R5vr/SPDa929/+SH5QcD
         7gwak5Ayoat1vuyYRu9cU4LdhIxSkrm1Nf+5jB3OUg2tD8jXB1LJj1bbKmm7x1g8D7fJ
         5DZl7n6Khr5b6FjFaxjoNKFDGCoY3vzgarESETT3GXBJTDHPS2eRVc/V3JFH6N8IAi6W
         fX0tWmPWteprDKmDROYnXUHAgWmN+MNIo/gwNyz8UxbnRHyDtDVJ77vD9gD8D3og3bmP
         D0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709821842; x=1710426642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+6SKyQ7N12OXHoPi73bVvaX3Vl8PL50OxbEZ/LFW1I=;
        b=CN8C1apwh96rBC9NEZiv5mdHmFlcFFthqruIh/nJIHv0mjw9huEAzGL1/FgaCk6BK4
         1qoxKOTKE7YgzmsoDFM5kn3fysb1ZBwLrv0ZykpZJ8yk2Y7I53y4hJ8xBZDXLX6pq+iU
         6CSTOFSzqz1ZRqE17z+KDxgRobppqiFf1So7x63orIB2TsGPmtCSeJaOCSeHXtWMC5N6
         zzQBVzQMxMWjYWOA81Z729uM4ta/VictvnPS9L8dLYNnzQFtEDWB9pkmnzz8k4i9kM/5
         FoTkDf2pOhRlxXtNgslCxQILVc8RgaoiRpBJtYVXDFL9i8Rz08E+RwzyvCHwY5DwYHVF
         21wA==
X-Forwarded-Encrypted: i=1; AJvYcCXqG4WPHzlxcxn16FjMxD5NBAf16b/XAq2LZhfsS5wuB+OrStAWJAItAwak44tpsg5AnONTU67NT1euNLhV0bI4DizaqKzDITWJLgmj
X-Gm-Message-State: AOJu0Yxp4DZhgQ22rA5b60nbvPsvFiZuSTMam/R7gYbk8rtvUi9dWvR5
	EhDiO3P3XqjA9wzxCYCHLVyTj3brgu1RnoIUsXlqHC+kL8LT7tv1fcE5QqmRTmfrqnaryA==
X-Google-Smtp-Source: AGHT+IE7pcpr7iz1gBjbn1Sj0jFxBgifp6Ey5+tcCZTkHm3IsJ29QxU5gm/5VT0PM/vDNBjeUSij0YeR
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1c92:b0:413:1:d3d0 with SMTP id
 k18-20020a05600c1c9200b004130001d3d0mr65437wms.8.1709821841046; Thu, 07 Mar
 2024 06:30:41 -0800 (PST)
Date: Thu,  7 Mar 2024 15:30:30 +0100
In-Reply-To: <20240307143027.206179-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307143027.206179-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=ardb@kernel.org;
 h=from:subject; bh=1Qx3edR+eJlGvR23RsXAVTdVDicMghSti/wS9GzIfSQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXl+bbuAoMXr7hmHdxZx/IqM9J3b2ftuks3BAz7vwUKb
 /+wdWN+RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIhiZGhjc5Wx2kxF/rL3o6
 U0m2/m+aPYeKrHm/4prT9/T2RPmo7mP477bsrmV2p17uQ8azh0NmP+bOMdiZaKyxWH3C/EfeUVM ceQE=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307143027.206179-8-ardb+git@google.com>
Subject: [RFC PATCH v6.10 2/4] x86/xen/pvh: Move startup code into .ref.text
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@google.com
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The Xen PVH startup code does not need to live in .head.text, given that
its entry point is not at a fixed offset, and is communicated to the
host/VMM via an ELF note.

So move it out of .head.text into another code section. To avoid
spurious warnings about references to .init code, move it into .ref.text
rather than .text. (Note that the ELF note itself is not .init and so
moving this code into .init.text would result in warnings as well)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/pvh/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index f7235ef87bc3..0cf6008e834b 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -20,7 +20,7 @@
 #include <asm/nospec-branch.h>
 #include <xen/interface/elfnote.h>
 
-	__HEAD
+	__REF
 
 /*
  * Entry point for PVH guests.
-- 
2.44.0.278.ge034bb2e1d-goog


