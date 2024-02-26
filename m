Return-Path: <linux-kernel+bounces-81073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB4B866FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCA3288B14
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806F85BADF;
	Mon, 26 Feb 2024 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FZ+k0Plf"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540C5219ED
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940474; cv=none; b=BF+UF+C2bJJuI2OCa+43exJCcYPC1towCWd627sNYruxH2lNPGeKnXNFH/Jhe2NlinceD0T+adMXskOs737RtRblZqolrcNW6sX/I6v6w+1jU/OjldhKFwf1bqdFfxDK6D5kyvqSML3dMzt/z8erJ+1a9YH/8V8iwvhKvwRgmEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940474; c=relaxed/simple;
	bh=oMwEwBsS9LpqWFkXQJGn/wGr2D2RG9J1+84Vl1zgefc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MvxL21mMvv/MhRckUjaA2GR5LR/DaV6EP1sgLBJe8e+mIHWneuw1GEnKjq9cdKbZo3PkrFlecBD7ZCbuesgITrL5UXFrTF5egfvzAymBETRrfof9/nZOV+JLan1s7DAWNRSJzQj0ZBKQ9z9F7/5IlkYk0hXfhCMRih+IwxL9ris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FZ+k0Plf; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c1993331a7so1236114b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708940472; x=1709545272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gbQaXGx202MYUih537vCjMC9neGAB2aCaE4Hy7lgplw=;
        b=FZ+k0PlfQr/3MUCxf1HI2tCXfYUNfM4j2ibM+rAe+4EhJ5Y6L5v7UPDJCfaMv7Qgfm
         YcB88ozct7BzujyhYsmaMgCgskNhIbq2hSdAM4zbpcGvKmhcxjfApD/6xtN+x+Onm/sg
         Jwe1l4e6K9ACiiTKmgngausbIwjXmW1T5kn6h1bQeauigU3ZwFGYZf5zTpLgEeJ+je1u
         9ch35GuqfqRM3HKx0gPSuW5ZzRjfHUrg/NP5K8/ZyMgMfUZxJI0AQ3rSwX8xuBx8je9q
         LJqPWnqHAVHKRty8QHN0IypurVLDMCYO6TsL/ZXPXv+H4txObnRfcHIUeriiYqHWmcc2
         z96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940472; x=1709545272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbQaXGx202MYUih537vCjMC9neGAB2aCaE4Hy7lgplw=;
        b=FLtBMQ/t9dzhye2FSrWhmL/iqGjEkdl6jteYSu+KTox6n4GOzsH7SA/jQt6+DJDXFm
         BXXQTLLYhobxIwvJjMKogI179uwJArCFio9UbrimWftr4m+3GaYvs3SEAopRTycL6oDd
         G1JSeOa0mk4W3ZVT1UIJv3nE/eRxLwW76ZOnznm2619q9mCJVL5D0ggNi9J+94xw6/JH
         iMtnUDeAmQDRlOL90li+Vgshih/gG1mYswBtfQuVGK8ju49Ov4CBVbPG7NdQ++NbSMrI
         bgvyMkZu4vltGk/V2HP3flX9135iYi8YvVIVqq9FR7d7lqTbFaeQYAZrY0gQxwNwGfe/
         tdMw==
X-Forwarded-Encrypted: i=1; AJvYcCXgvPpO5xNzmRokvV5pMOpEl3e4oXC3zIwjaKJIB2fNybpB4T8Y+ACrom76f76VMpb0nu1fXGiFTMcPFNFnQHqumzJZLzL17zRq6fk5
X-Gm-Message-State: AOJu0YyHFrpjO8TZ2+LMlfWM1DCPGvu9/PkWkDlCq1Y8OYpoFEQDYsj6
	10EAvD1+b1OYPW6rxMdhzpOI2lgEuijlcLySlOMM65ctpP2ih4MM0E0vMz7rDEzzrE7c/7FGsc4
	B0P+C516TKke3tw==
X-Google-Smtp-Source: AGHT+IGb4DMDY2Ls9t80jorxvIX8b6cha77RpNYr/L3xSKnLlr3PO0LB+jlhLLtVQjC0FZnq8x4suA==
X-Received: by 2002:a05:6808:1644:b0:3bd:cdec:ba04 with SMTP id az4-20020a056808164400b003bdcdecba04mr7266464oib.58.1708940472482;
        Mon, 26 Feb 2024 01:41:12 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([203.208.189.6])
        by smtp.gmail.com with ESMTPSA id ls22-20020a056a00741600b006e533caee00sm949194pfb.155.2024.02.26.01.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:41:12 -0800 (PST)
From: "$(name)" <qirui.001@bytedance.com>
X-Google-Original-From: "$(name)" <$(mail address)>
To: bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	jpoimboe@redhat.com,
	peterz@infradead.org,
	mbenes@suse.cz,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	alexandre.chartre@oracle.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	qirui.001@bytedance.com
Subject: [PATCH 0/3] Support intra-function call validation
Date: Mon, 26 Feb 2024 17:40:58 +0800
Message-Id: <20240226094101.95544-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rui Qi <qirui.001@bytedance.com>

Since kernel version 5.4.250 LTS, there has been an issue with the kernel live patching feature becoming unavailable. When compiling the sample code for kernel live patching, the following message is displayed when enabled:

livepatch: klp_check_stack: kworker/u256:6:23490 has an unreliable stack

After investigation, it was found that this is due to objtool not supporting intra-function calls, resulting in incorrect orc entry generation.

This patchset adds support for intra-function calls, allowing the kernel live patching feature to work correctly.

Alexandre Chartre (2):
  objtool: is_fentry_call() crashes if call has no destination
  objtool: Add support for intra-function calls

Rui Qi (1):
  x86/speculation: Support intra-function call validation

 arch/x86/include/asm/nospec-branch.h          |  7 ++
 include/linux/frame.h                         | 11 ++++
 .../Documentation/stack-validation.txt        |  8 +++
 tools/objtool/arch/x86/decode.c               |  6 ++
 tools/objtool/check.c                         | 64 +++++++++++++++++--
 5 files changed, 91 insertions(+), 5 deletions(-)

-- 
2.39.2 (Apple Git-143)


