Return-Path: <linux-kernel+bounces-134091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976CB89AD1A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 23:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5249B2822CF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 21:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEE84EB54;
	Sat,  6 Apr 2024 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQRn45Zl"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3506F4C7B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712439649; cv=none; b=cPdlof42yQb/mgAxih0O7CfzqiqoCpjMV3Ln6LySYGFazPj6Wki+fOoXivTGhf9nHm4kGJ/RAi2N/En+yx03xFmZ9Y00V6htRwW9vt/+1r+YDIUKCbar+M1uaxpMJuiOTwb2VjOADNF9eT2N7NJ2XJzuqwZGduRDnIHf9nrjN54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712439649; c=relaxed/simple;
	bh=WT0Lpk6DhnwYEOjwGkmSGzKWqJTDKx1+lSIGK7/TjPs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Uss3MKx27zTb2sFw+4FyL+sOHpdiD84SPI8PBVBT2yyqAWeP5CVaSOb58gPokJD2eVNWnuujBnHsdScgCVIP3qu1ETEhzpqsOROD8qClD0dxJlZnSoOdLIP5jJrbLPx8le71LDsScvk9Ilq6EszTF/Xb2x9Qqmi0mzqC4XkXCpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sQRn45Zl; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a4b60f8806so481282a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 14:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712439647; x=1713044447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gzw1CQLzEz+aDfQzLSCkUXr+Fy/FJWggtvJK4Br2lok=;
        b=sQRn45ZlCsMSJ1ctkLimAs4nrg2BHZvp/HwXjEgUTwCC/ufbSLnCZ9bDE6g5+Hy8JI
         ed/BuAeLFvawyeS9tv7ZsS96XYROlqdDo7VSi3YdPJoV87hjOlgZUUFm14eRfWTm4wSW
         YW9rlGbMqfaPX6Iee4jjArfl9k4HMPgYzQtVmI6jKD2rjcFwKMoycjsIbhjlt32bWFND
         e4XZeLF1fWFk4wO8Vc03sFGsOkfOCJsu+tJEws9hGvPE/L/PIlJYya56e2KPbPjVErzw
         logDGV+4SGuiCT1sMsQkiUATfdVbRIQmkFUGUbZst9CN1tGT8s5vEmGXbiXX9b/D7Qx7
         vTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712439647; x=1713044447;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gzw1CQLzEz+aDfQzLSCkUXr+Fy/FJWggtvJK4Br2lok=;
        b=SivjkeF7knBCTJIn1+/Ffk/L1buO0mXxJeweFK0PTRz/U4YwQ4V1qtkOjq/PPIBTMf
         8885lyMSbLXeDpqGc/oTWFd51gyQ0XCas/mUR6oG7yOv2F5K1skNjtUNjCG2kQ0JlNAg
         +w0NRP1onGMohk5CfcMwc1KgtmvBr+VPAkerj+3ryIRwOCTaTYlSYPT56Ha8AVKdYEQ5
         mrcLEPloUv9+GjRa9WmdKPSnMJvQdX/sQmVjzVcp4m4zcgyn8VOG5ihcUMVZdNENBaHg
         +AA3eSlq6EqMnqBAwF8y5Albcg4sYNOwBKUga785caqFRXfKS4qq4h4vZLDJLnXhRZP0
         Dzjg==
X-Forwarded-Encrypted: i=1; AJvYcCWFyzUwImEHOt949ZQy/EGgrLRpXWoeWxScHJ50NS1rfeGd0vKLeuHk+3YNEQMvLmh1XC/QrISpPcJ5Vdd2p+pIlboW9zR3WX5j3Zzz
X-Gm-Message-State: AOJu0YxTrsRMea/6Gpxc9/MCwoyULEQ+a0Q9XENMwkPl2rNEjnSIVV4T
	v1kqWNM6sHv6ty+Aymd7shTZx2mYO2edQEi8xbB0UP7UFTW14aSBymAD4U7dSNWjAIyAfyM05mJ
	+Zg==
X-Google-Smtp-Source: AGHT+IF4axCv/Y8VyLgScmc0G3dc3q7zEXs5J1sN3w3JrohbNqJUZEyft8VJodIQF5zQSpMQGH94DPYTSdA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:18ca:cd75:e3f2:694])
 (user=surenb job=sendgmr) by 2002:a17:903:228b:b0:1e3:cf83:af70 with SMTP id
 b11-20020a170903228b00b001e3cf83af70mr136646plh.13.1712439647507; Sat, 06 Apr
 2024 14:40:47 -0700 (PDT)
Date: Sat,  6 Apr 2024 14:40:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240406214044.1114406-1-surenb@google.com>
Subject: [PATCH 1/1] fixup! increase PERCPU_MODULE_RESERVE to accommodate
 allocation tags
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, klarasmodin@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

The increase of per-cpu reserved area for modules was not enough to
accommodate all allocation tags in certain use cases. Increase some
more to fix the issue.

Fixes: a11cb5c8e248 ("mm: percpu: increase PERCPU_MODULE_RESERVE to accommodate allocation tags")
Reported-by: Klara Modin <klarasmodin@gmail.com>
Tested-by: Klara Modin <klarasmodin@gmail.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/percpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index e54921c79c9a..13a82f11e4fd 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -17,7 +17,7 @@
 /* enough to cover all DEFINE_PER_CPUs in modules */
 #ifdef CONFIG_MODULES
 #ifdef CONFIG_MEM_ALLOC_PROFILING
-#define PERCPU_MODULE_RESERVE		(8 << 12)
+#define PERCPU_MODULE_RESERVE		(8 << 13)
 #else
 #define PERCPU_MODULE_RESERVE		(8 << 10)
 #endif

base-commit: f43b3aae94511d62174c3b29239da0dd22d0eeb3
-- 
2.44.0.478.gd926399ef9-goog


