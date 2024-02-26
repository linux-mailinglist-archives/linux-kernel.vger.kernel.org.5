Return-Path: <linux-kernel+bounces-81092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA606867015
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1777F1C25DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B70200CB;
	Mon, 26 Feb 2024 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="glzpOUSo"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5013208A3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940980; cv=none; b=KxQXI7eJmbq9VKQpyfhmlXjvZmtFxdHCRD6ucvxlEBkrNHMygR4pN6mvhP+G3hgC0Gac3s19pXw42uzkiQzNjr+lIwl1UoM6i7mC94B6wVpa3e/EJ9f+AFDtx7qO5dMr+PGiXguTqkUJSh2F24m+krrG9eNrxM+A6UtG+i7LWm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940980; c=relaxed/simple;
	bh=Fwm8S8Vb+z4RwJL7/WDN7b9qb2t2HZ9vae8gSBT44uE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mcIvtwNlsqm1UaDNEVm8l4Ah0aa6qaaB4cMRSUSfzISAVhoUADc5zQ/FPrGqM/6yWHgMnI9LFmbO8cRXj9mkNJi6EoZZxuYGDZat4+MT+YFqvpMFf8Uka2k1s3Pd4DRyiTPStnmGu46mAO408trSTVFhrOYeDSHWM+KzMkYOFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=glzpOUSo; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so1495580a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708940976; x=1709545776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5d69Z1hSg4N+Xx0zsmQeCV2rcSQlkCkO33X0RouPP+g=;
        b=glzpOUSoJgz/9ISO9ub1FrCf9qJ97TOvWpBA7tXcNw7IpUPPc3f2oKgurqtY3VuQM2
         aUsxG7ZVU+TSbWvSFate/XYq08iexAv0u39N4Ra8AF0p/PPaWyAk6VZUwTAzo3/Btlbe
         j1SrfHjkdchw+k9xAw4VdgrDPIB68eQCjkI4WVdIRH2LsHIKhRK+ogMo8JCBc4y/gGEt
         5TU+gwlIcFIXjM8U2KHWxR0nNTu5AZQvN6JlHcudcxD3hGhJPODKDkzY6fOJDEXjwBrf
         tpyPs52OYnVU7pbPDjebp35A/AGbcoEEdN9LGXxBfw3dQ0PNoaYnQ2NUARM/p4S0uVrD
         /H+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940976; x=1709545776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5d69Z1hSg4N+Xx0zsmQeCV2rcSQlkCkO33X0RouPP+g=;
        b=rWiQlZVcGB4CpM6F8HzpuROvTjF83Sxonghbb+3UB8sLTh+vZcqrM4SGIMmF939qjE
         YkyW6zl8uZ2jldbqXy4Rgk4IO81SrIPCBsZ4aF7N9/A9fxtkRmohtFK1z6EBtLQtNEgE
         mp40FF8Eg4s5Pr20ieBSFCVQ0OKh7CCAj2UqCwMR4gAGjd7y+m+seKXDWV6M8HZOJ3lU
         1nhA9S76pDOhIQQMFmLheApSadgemHPZ7yzGj8LNICt3DIveMg8hz1Ubw8lMoqvTi0aV
         snAlZZs9b4EOSEpaYy2ohU/bPGBq5EDZ8nywe2G6SbXCF9g9BYmclWFAYbBbWn6ScKRt
         DCRA==
X-Forwarded-Encrypted: i=1; AJvYcCW3VaF/jYNJ2CjOeHLsnWA+tRKyOZcPmv/Ft14XmqtWxnhfScLcJ84vCOrVvU1inGFijafzvCpp/cCkhcdJERlltHfYAvF1MTYSoeOh
X-Gm-Message-State: AOJu0YwvQ96yKqGF2ynD8Xq0UOIeHH1Mbst1nQ/HdGlVUUXHLkKSA3sO
	UXxcJ2wZOR4kAzL6uicGGyA45mk2ckLNt2sukuZn7kn5lCGJwGCII6GE8Y+hJLo=
X-Google-Smtp-Source: AGHT+IHQlCKe1gWPQWI8gLJq36L4Evc2tMwIj+p6bpMpgWSjgjrhDFw53mUfU9ROkT7T+2g0RMH8+w==
X-Received: by 2002:a17:90a:fd8c:b0:296:e8e3:13c7 with SMTP id cx12-20020a17090afd8c00b00296e8e313c7mr8665219pjb.10.1708940976196;
        Mon, 26 Feb 2024 01:49:36 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id x19-20020a17090ab01300b002990d91d31dsm5934779pjq.15.2024.02.26.01.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:49:35 -0800 (PST)
From: Rui Qi <qirui.001@bytedance.com>
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
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH 0/3] Support intra-function call validation
Date: Mon, 26 Feb 2024 17:49:22 +0800
Message-Id: <20240226094925.95835-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


