Return-Path: <linux-kernel+bounces-146087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF3E8A6051
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7651C20C18
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078BD539C;
	Tue, 16 Apr 2024 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HEVVAzMy"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E2F5227
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713231106; cv=none; b=RSF8lnsxGzw51p6X3VkXhtSvjc+iOQFQil0Nrm0OcPNnF5CDYoSmtXsbqs9nMKyCZoSbuVhu7osX68UTavx6DfujpyYZiWZ3+/XS2pEAQLw3nI6kAgQgJKEZs/yjQQnUWFWXBCD8NvCpuFvZ8iqXdL1XmZid8ArBj9v066XvN80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713231106; c=relaxed/simple;
	bh=Lt5qa2tKJaXTFBi0w3EsYO6+uA+O9X5f7mwgjyL9enY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GmmumJfKTjdr68yUk98IQ1aLBlE5+f19QcjuyJmO/fMNZAnkWeIt/zJ4pCege9iJCHKHMUqMMFc4vfQntZH6Q2FDaDHN7A3w6q2VVnl26tnUquezCvdw2WFVcHHTQvvbYJl+6iapOo6X6iFaa9fi1zwGEJL34c9Asd7L6S8OmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=HEVVAzMy; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2331bef249eso1704474fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 18:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1713231104; x=1713835904; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQ1Fmu4Vn/bJTdN2f3Tpcx/PWLxgEkHvwqs2u4LlG6Q=;
        b=HEVVAzMyF1muehurD+wPHdccrFYjznQhek7Pj9Zo/xqr+DP3k0LlMxUawUtmMRIaP3
         J1dAOQdq4rAYIMuYeQWeXQdE3d/3peI9jBhuEkhy+/YFFG8ecl2N/u4BLjvedK6jIj5b
         A63gJpx12RAcwVEViQROHb4N3N92JBWQ9stjyv26upTh2sr23mqVbu4g1tVVuqIWycWQ
         epLc6hjOuoT6rYDpRNOuc/YPqzCqEFQMq6GS5C/+O2sCX01uZGZnPC2xpijEDrUI5sx5
         +dFDLglTqLuOiwScIH2dLPeUVha4tGy56l0rKdYt10zR+S2CHMSZi+grcKCB2nQfq1uz
         qvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713231104; x=1713835904;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQ1Fmu4Vn/bJTdN2f3Tpcx/PWLxgEkHvwqs2u4LlG6Q=;
        b=wZyOEijj/+zQ40+D3TbGmqbM0dYHPSw1o2gNd4gqGSm4gNtfpL7tCJ8osYlbJLcAI5
         AqOLn1rTW5cspcXsu1dXMIt7DFS2fVG03CdXawaL1+IeIDtaejIWgCE25xHaC60n/Sfi
         2gWB0xg+iVnPiZQtD6mHi2YJqrsg4h3vHqDFMqYQUja68ta3HqzxyLn9imL4pkVd+pzq
         IQyh0gvfhnhtcZuD0C7qUhzvwI8vfVkEqpPvg6JBsQdS1D5En3O0iY1AbdtSozWzPv96
         NqupDCIpavTUxQmI6e1+PbXY6SWEKNcVafejI/0tjXLB6861Q9PA/+hFxLdPhCRJUc2g
         tFCw==
X-Forwarded-Encrypted: i=1; AJvYcCV4kUUF3IZshjGc7tygQENhTkri5YzsIfCpiCVdvt7GvqJos2j2EzeMx/LQ9g9X56WoxVz9XKYW3BIKbSkR9Hdqcu2n4FMCF9slJdCV
X-Gm-Message-State: AOJu0Yw4+zOkNZLiiDTW3ZwBgb+2z6X1aBUi5JDIRJptTd0RnJZU7A8+
	xg+Yh3FXB6yGZFnaL7nkC5qps/VUYll0VmuCmQ3qz7MFl85gs39IiW+fHBgpiyE=
X-Google-Smtp-Source: AGHT+IGV28aTXnJZCsv5QTO9arJ7Mejc0+P37jlL8ec2Sy1TLly7UFcUuc2+Lugf+lCiR8bqSzVsfg==
X-Received: by 2002:a05:6870:f61d:b0:22e:8a2a:2497 with SMTP id ek29-20020a056870f61d00b0022e8a2a2497mr13497999oab.45.1713231103843;
        Mon, 15 Apr 2024 18:31:43 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b13-20020a630c0d000000b005dc4da2121fsm7642525pgl.6.2024.04.15.18.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 18:31:43 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	schwab@suse.de,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH] Revert "riscv: disable generation of unwind tables"
Date: Tue, 16 Apr 2024 09:31:38 +0800
Message-Id: <20240416013138.28760-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This reverts commit 2f394c0e7d1129a35156e492bc8f445fb20f43ac.

RISC-V has supported the complete relocation types in module loader by
'8fd6c5142395 ("riscv: Add remaining module relocations")'.
Now RISC-V port can enable unwind tables in case eh_frame parsing is
needed.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 5b3115a19852..9216bf8a2691 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -94,9 +94,6 @@ ifeq ($(CONFIG_CMODEL_MEDANY),y)
 	KBUILD_CFLAGS += -mcmodel=medany
 endif
 
-# Avoid generating .eh_frame sections.
-KBUILD_CFLAGS += -fno-asynchronous-unwind-tables -fno-unwind-tables
-
 # The RISC-V attributes frequently cause compatibility issues and provide no
 # information, so just turn them off.
 KBUILD_CFLAGS += $(call cc-option,-mno-riscv-attribute)
-- 
2.17.1


