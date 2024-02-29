Return-Path: <linux-kernel+bounces-87677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8643686D7A7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209511F22CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF2A143725;
	Thu, 29 Feb 2024 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="R4zqQOQx"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616D713E7DC
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248940; cv=none; b=M78XxQ+325ihQdQ90g+8gBZo5wiA+wANf8GCPsNliuLAZifhhBX+XiTO+sidDd+ucbcBCkyOMfrnkS4lHcY/g9a6gkoo57XHsoNbUfISB3GijbAEOJ6nMU6/4+YZzht09APRjnsHqbCzaD+kcOvT8xT++8RLwB/CZTjmURXOgJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248940; c=relaxed/simple;
	bh=a0/O/6KXaeNjvwFlcxHlcnSxOyEoC+55OmJ2xLa9M+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MiywI4aHJUicxdwDw9xi5QxPzx/mEHdM7PyHWQNBPArlbTkjHWBGXg5nKbHHpCPzjKbodsCaTZwMXppL0G9Y6kzR3CQ1s3NiIkQ8MUukcnvMKafAvEzJ/9s/dkYUx0nihPHa5NMgoKWlbpu61gbJn/aNyp8sXBg5hABWau2EXak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=R4zqQOQx; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbbc6bcc78so1082695b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709248938; x=1709853738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YO6O944kqWb4oNKtEMwGtpxpVk1nDXsHdzKgYw/NyE=;
        b=R4zqQOQxA6YWW/2eNFx52MOxRUF7TQJLI3sZyM+IQyqZRzS7REEFcHh9dk6lFH6MA4
         ijyUzDrxTfTfJswzq5E39MyjcK2Op4YmBvp0he30ds6rJgkHNMfE9qjFzmf5mJoYdFkA
         vD594eHOfPd+SYN4rNvn9eEIjOrSqOHjMq2A1uAMQ3r+ZjxNCYyrWD8nrnDBdX7kzBfX
         riS8VwaZRZ71UibaobFzpHksyB7OX+FbFygcuTx1nX7z70FBIQRwKpBlXkPFTrSZiz4o
         K4UVsRf6elLXWnwqf2cVY3K8RJun/kXoqKnsheqV7uSCQDV3bBjmNlNr2gL92hoqJgC6
         MaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248938; x=1709853738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YO6O944kqWb4oNKtEMwGtpxpVk1nDXsHdzKgYw/NyE=;
        b=szyYA0EenaxhV2SxejIepnW9SAHLfmgUAIdQNTvnBF9Resj7zhEnNvHJQPAnJ3rEC1
         Drd+8HVj3l8x7z20Ai/It+3b2OnGQaYNIUR5wkKLDarkdPotA2gjWkmWjPf9wDZmgtUv
         Y8eVXJflbdiBlDaHg3lIwGfPYXpmQPWaSh0UrPTHS6AoG8gtz2eCEIsw/cHd/5Xkf2F2
         vuRKQOMW/ZpVR00Oeu7eQs+gjQCwXPl2Owaa1v0YqV3uH576xFPNnnMMqMqQ6OVnvIqa
         +AGQZ3vWOCnPMnz0JZI5MQdbAVXq/wFOo6Dwvc8ZyrDh1mdAi/Zj5Mv8xty32Q3pwtgA
         hpxw==
X-Gm-Message-State: AOJu0YyHhq8oUtuCStsuajzFuTxE7f4nnYwGJ87eLdxMfF+Sfh3oYCrt
	b8HtGNPWnHIzU3/CfsFnZKTNUX4KFfCBhsQsYmmTqK9cXb+jqpyZSgled41hEKQ3MODl2wb1hvY
	v
X-Google-Smtp-Source: AGHT+IF/+PdA1OOJxMn23/EE1kPZ70u92KMkSqj19wYtg5glHTCWIaPOP2OtxcWfToq1z4V1DP9b6Q==
X-Received: by 2002:a05:6808:8f2:b0:3c1:c37b:1a71 with SMTP id d18-20020a05680808f200b003c1c37b1a71mr62346oic.57.1709248938472;
        Thu, 29 Feb 2024 15:22:18 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b006e55aa75d6csm1779719pfo.122.2024.02.29.15.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:22:17 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 05/13] riscv: Only send remote fences when some other CPU is online
Date: Thu, 29 Feb 2024 15:21:46 -0800
Message-ID: <20240229232211.161961-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240229232211.161961-1-samuel.holland@sifive.com>
References: <20240229232211.161961-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If no other CPU is online, a local cache or TLB flush is sufficient.
These checks can be constant-folded when SMP is disabled.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v4)

Changes in v4:
 - New patch for v4

 arch/riscv/mm/cacheflush.c | 4 +++-
 arch/riscv/mm/tlbflush.c   | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 47c485bc7df0..f7933ae88a55 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -21,7 +21,9 @@ void flush_icache_all(void)
 {
 	local_flush_icache_all();
 
-	if (riscv_use_sbi_for_rfence())
+	if (num_online_cpus() < 2)
+		return;
+	else if (riscv_use_sbi_for_rfence())
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 8cdb082f00ca..69402c260a89 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -78,7 +78,9 @@ static void __ipi_flush_tlb_all(void *info)
 
 void flush_tlb_all(void)
 {
-	if (riscv_use_sbi_for_rfence())
+	if (num_online_cpus() < 2)
+		local_flush_tlb_all();
+	else if (riscv_use_sbi_for_rfence())
 		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
 	else
 		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
-- 
2.43.1


