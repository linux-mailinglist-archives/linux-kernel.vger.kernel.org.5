Return-Path: <linux-kernel+bounces-105306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F81087DC00
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 00:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A373D1C20B14
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 23:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCC543ADA;
	Sat, 16 Mar 2024 23:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0zUzSmD"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0561CAAA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 23:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710631285; cv=none; b=MuGRGdWEUq6ZP6m0Fy4yW295nr86UBGOhS8EmFNO2LfuQrnG40KKkMYG+5mcDx/DDo8G1lcstGSt2+YxF/M1IXxBZiCAsGA7uRNNOTA8ynqaihUwFw/rGeK/eoXL+swRL3pPvFiOyH6fapZLvRkn4zMTR5RrgwRZHh8zJGH6mp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710631285; c=relaxed/simple;
	bh=8I+9Xh1B8ca2rFZocr4NbZZsAyhD5pZEaMy/G/2Cfmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWYLyHzaj27FYSEIEiwQPHri2hcxmVl2IA2eblSbYdJHZOukt5ULjvywW8+rVVonWarmt02bcM5hVFBPxckBa5Y4cT44dI3xw3RbS9wRBcIwRZQ9SVsXamwjB/hhV5H4zDy5QH8crhGim1spFQ5g54FhqK3tdfCv4JoRSt9M8FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0zUzSmD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41405d77c7bso8481915e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 16:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710631282; x=1711236082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmX3xpzhkH4xRY1ryBz8V2RojP635fvXqLUXYTnRCuU=;
        b=Y0zUzSmDbp23U6+gbyAEzzjOkgA9HTXsmo6rSLdqGNM3p6xvpUPVfSp/5DfTmykwIH
         sDJMCiG9af20tXdz54MYD/9w5ZN0vt94hag3OdY5d3fElXskFyHagLrG5Q8hmbrZxqzw
         OjiFD6QmilDlW7ydCSAVjMN1/rvQ0sp7R3xsUyGMJwm5eeq6cnVSBXq3F+Vb3bMK1p7o
         kssof3uct9MemvNTw+woVnEX2wvN4ANcanISqGUKyClyq1dLueMuaB68vcmkisJHqiz3
         QChf6hH9ZCt/Gkm9X5mdnFIbzbqc8fr1PvPWCYn2oATEslJcbPqeENptDgXn5QAQ+RRH
         asQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710631282; x=1711236082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmX3xpzhkH4xRY1ryBz8V2RojP635fvXqLUXYTnRCuU=;
        b=bwgCxlwIWR3WMcNUfiOsldKj7p78s2PZo+ekmjyt0Q4kLuIRWsz8ghws2yVHo5MMLK
         H56jojbOC/zfS8qgfE4UalSB9U5L+N4Kao0q4MGoydPyEMmIT23cN9QjZdDZLPZPeFCP
         p66EpzoZp6NDzx/z3g0CafVIEGIlreG0ygiWJ+U3ejw/NHBw2+7BNkWvi6K0TkScj3JO
         fSLy19WxPO54cZI+3biZ+fQbtvy3wvGagZ8jfN2k4gaMVkugfGVrby2JSyPXS/aT5Esv
         9d0pquOJWPwiU0XVnftIal0VNoyqMmJhHhMNuLgaf7GOo+3v+hfZ1EMVkqOZrxcxftus
         mhew==
X-Forwarded-Encrypted: i=1; AJvYcCXeoMC684aH0YpJLWr1mNz0+PPMGKwRZzodrxglhPfUHtbmCrS2ErhwfwNUtE5RXdjVOsKMoM3yZLTfV9eOJohQN2syb0VUEQVzzEpm
X-Gm-Message-State: AOJu0YzQEAgUwl8WrBs1SZkVxT0+9HZtNOTMLMfkLxdw3Zp8wccj+5fQ
	IYdyIB9LHgwy+i5Ce4uMIcMkTcN3mHy5GhSGhJxQ9EhlWvURY4jK
X-Google-Smtp-Source: AGHT+IGFwm9bPqWxJCgs8iwJ3DYOZlNg5oMSi29NqNYG0e739fpFWf1qV3fjQJrjPsh3Xva7P6OsCw==
X-Received: by 2002:a05:600c:5124:b0:412:ebde:8873 with SMTP id o36-20020a05600c512400b00412ebde8873mr6822309wms.30.1710631282256;
        Sat, 16 Mar 2024 16:21:22 -0700 (PDT)
Received: from solport.. (82.red-83-42-63.dynamicip.rima-tde.net. [83.42.63.82])
        by smtp.gmail.com with ESMTPSA id fm13-20020a05600c0c0d00b004140a13f998sm1597028wmb.11.2024.03.16.16.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 16:21:21 -0700 (PDT)
From: =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	=?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
Subject: [PATCH 1/2] x86/bpf: Fix IP after emitting call depth accounting
Date: Sat, 16 Mar 2024 23:21:03 +0000
Message-ID: <20240316232104.368561-2-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240316232104.368561-1-joanbrugueram@gmail.com>
References: <20240316232104.368561-1-joanbrugueram@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adjust the IP passed to `emit_patch` so it calculates the correct offset
for the CALL instruction if `x86_call_depth_emit_accounting` emits code.
Otherwise we will skip some instructions and most likely crash.

Fixes: b2e9dfe54be4 ("x86/bpf: Emit call depth accounting if required")
Link: https://lore.kernel.org/lkml/20230105214922.250473-1-joanbrugueram@gmail.com/
Signed-off-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a7ba8e178645..09f7dc9d4d65 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -479,9 +479,10 @@ static int emit_call(u8 **pprog, void *func, void *ip)
 
 static int emit_rsb_call(u8 **pprog, void *func, void *ip)
 {
+	void *adjusted_ip;
 	OPTIMIZER_HIDE_VAR(func);
-	x86_call_depth_emit_accounting(pprog, func);
-	return emit_patch(pprog, func, ip, 0xE8);
+	adjusted_ip = ip + x86_call_depth_emit_accounting(pprog, func);
+	return emit_patch(pprog, func, adjusted_ip, 0xE8);
 }
 
 static int emit_jump(u8 **pprog, void *func, void *ip)
-- 
2.44.0


