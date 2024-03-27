Return-Path: <linux-kernel+bounces-120670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3A788DB47
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659471F29C03
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384E04F1E1;
	Wed, 27 Mar 2024 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="UEV5VsL6"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF111BDE2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535499; cv=none; b=OT/N7nPBp3t4fICl9UKH9/7lR8RV/QQBH2BjJNdFVyGbLtny/o1Lx0G8Mpg2tOH80D3NEWeeaPsH0SqFmzjgJ/xU86YHe2Tl/AlxporRVkfMum9Qgp4c5YkPgKI7z0x2t4ZRTpgh4DY3Pzfnb5CK0hefEDu5vZKjX38yhlRB5o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535499; c=relaxed/simple;
	bh=5zk6kq3UFGadP+2Yq4Dm+tPe0GlFy4sAWp32ibDLS0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pymuWZCRxrVKJl062apC17B67G/Js0BVMQx0fyY9bg8W+ng3tQ7iVEDZw49kdzW2e5BEZPBthe2dL8bzVsdcIVpaiq5xCJ6hBvrR5I7+qXQ0LjDGJmEx0Kqdgu2ktwnPmYRQEuLM7ei4bhLKfV3hz1obVwD178hfVI1yf9od8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=UEV5VsL6; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so6259368a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1711535496; x=1712140296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSJ+UjWyV6VDqHK474kxHesTXDBqeer09Qi3VieNTqM=;
        b=UEV5VsL6Pzq6GZpzN/ArTyAtdDh5efa6ZSv4Rx6GhjNsLVDxDn/H7EVZW0hU+cRYHs
         RCGdSJYwxvPpA72S0PpdZL0ntDyxqaby37ZToyI8ntmJIwMdkP/kn7grSxF3zu1PVGcj
         1xl7OZpHGlr5w9sFd8OX+8sMi3JoFBXpsqnRf0L+hOPC/xGpi4POFMcxE197kmAnODJX
         7ua3WI2bslhLx2y6cgIfD3PAH9lU/whgOorvzz/1PLH7cjz5GvLXxzyeoUQkPB+2O9FA
         6A/0V+7bOaSyq5zAn163nyS7DsXDIlSV/3DieZRuANLeKCikq1oTZzvunpy/KDUFf+sP
         xIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711535496; x=1712140296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSJ+UjWyV6VDqHK474kxHesTXDBqeer09Qi3VieNTqM=;
        b=ZMPNceEQ6XOVAcdxwEN7EuBbcqcX0K/JTCrqyeSVlpnL/Q1l7ASJ7v4PGBWVJqHhZG
         q9E05eGUCmdTy6nDOWelGaWkyCormsYYcUmZkAut5iHZkxFoBR7VCK3GV9/n4PTyQs2s
         3lOqL03FyrWDac6cHtBSoAd3VLkUO8Y5dZ8zSDmN6SJEtd69Yy06AwAYAR55Nu2GbDHg
         w8kqj3tQZZ7jKVzb3KXUmny0oYUvGCVZY64GvcTLqBnG3Au6YtfjI4tXbCX6DMvRx+zE
         +CNZYXGS9Ui0oiKtVVXSHRBLMdTLkeqSQU76ulwE1vzefB1bfdXeRntyDvbLZjZc4CEb
         UCxg==
X-Forwarded-Encrypted: i=1; AJvYcCULBPfVj+XgpZdI7kMqSPIIsfsqv/cazSTyOowSxIKScrVetqtIErfWhWWmcrmly4h3IDJt0XGbwrK08hLAHsXhRfM2JQG0MWt6I40x
X-Gm-Message-State: AOJu0YwN/ox4fGgOq+rNJsDqDnOOsdub2GVws3x6O/+Yj4Ohb75YmOlD
	BSnEtWKb9LN/RVoF0y48WWTBWArgWgK3yr6g+7xBhbMeIz5wVAgv1YMJKB4vmhk=
X-Google-Smtp-Source: AGHT+IGVZKrHhMNC1CQHMp/4kkiEfUCOZuadD93YT7eU77ZwO7kZVT2ezcq9jl6faw5E8GtW+3460A==
X-Received: by 2002:a17:906:6b8e:b0:a46:e595:f357 with SMTP id l14-20020a1709066b8e00b00a46e595f357mr2781223ejr.9.1711535496207;
        Wed, 27 Mar 2024 03:31:36 -0700 (PDT)
Received: from antares.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id z15-20020a170906270f00b00a46b8cd9b51sm5294078ejc.185.2024.03.27.03.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 03:31:35 -0700 (PDT)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Cooper Qu <cooper.qu@linux.alibaba.com>,
	Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
	Huang Tao <eric.huang@linux.alibaba.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PATCH 2/2] riscv: T-Head: Test availability bit before enabling MAEE errata
Date: Wed, 27 Mar 2024 11:31:30 +0100
Message-ID: <20240327103130.3651950-3-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327103130.3651950-1-christoph.muellner@vrull.eu>
References: <20240327103130.3651950-1-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

T-Head's MAEE mechanism (non-compatible equivalent of RVI's Svpbmt)
is currently assumed for all T-Head harts. However, QEMU recently
decided to drop acceptance of guests that write reserved bits in PTEs.
As MAEE uses reserved bits in PTEs and Linux applies the MAEE errata
for all T-Head harts, this broke the Linux startup on QEMU emulations
of the C906 emulation.

This patch attempts to address this issue by testing the MAEE bit
in TH_MXSTATUS CSR. As the TH_MXSTATUS CSR is only accessible in M-mode
this patch depends on M-mode firmware that handles this for us
transparently.

As this patch breaks Linux bootup on all C9xx machines with MAEE,
which don't have M-mode firmware that handles the access to the
TH_MXSTATUS CSR, this patch is marked as RFC.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 arch/riscv/errata/thead/errata.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 8c8a8a4b0421..dd7bf6c62a35 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -19,6 +19,9 @@
 #include <asm/patch.h>
 #include <asm/vendorid_list.h>
 
+#define CSR_TH_MXSTATUS		0x7c0
+#define MXSTATUS_MAEE		_AC(0x200000, UL)
+
 static bool errata_probe_maee(unsigned int stage,
 			      unsigned long arch_id, unsigned long impid)
 {
@@ -28,11 +31,14 @@ static bool errata_probe_maee(unsigned int stage,
 	if (arch_id != 0 || impid != 0)
 		return false;
 
-	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT ||
-	    stage == RISCV_ALTERNATIVES_MODULE)
-		return true;
+	if (stage != RISCV_ALTERNATIVES_EARLY_BOOT &&
+	    stage != RISCV_ALTERNATIVES_MODULE)
+		return false;
 
-	return false;
+	if (!(csr_read(CSR_TH_MXSTATUS) & MXSTATUS_MAEE))
+		return false;
+
+	return true;
 }
 
 /*
-- 
2.44.0


