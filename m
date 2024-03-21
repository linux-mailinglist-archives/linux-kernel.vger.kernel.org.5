Return-Path: <linux-kernel+bounces-110687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D570E886274
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137311C21CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5543135A6D;
	Thu, 21 Mar 2024 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU/o2jYA"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5585265
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055934; cv=none; b=MPUIbqBBd/mrX/MWQfPYiq8/rQqXTDkD/9T3zxHHK8TWrkr9kzPjEw9lzq/U87wPhHUiDQkrm5ixA0WO/T+vsRuV5lRkot9wTIiCIupcA1a+SmEZvFkU2Q8wapxUSyzLAokMr5UPC1z/9N2gghKVjIy3MOCVSlI8qhgMiS/ke0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055934; c=relaxed/simple;
	bh=RqOEIU1chkUNCdFpglMl34NF9rWup/Cr8zoHuTW7GUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozDcvihQNP9n50trkymsiuD4NzftlvyW5JO2WzTrzQPg4SGQLFbOX6FnE3HIJW258HmiZguJrUP98r4+hX2fksGG2NPsuYsuKY0G1iW+ltpsBKoAgphTvaCcn4tMhkqUVCV+m1Z2fvzqPoxhdoiR+sgDHElBBRoKOaxDGABzWIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU/o2jYA; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-789dbd9a6f1so109089385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711055930; x=1711660730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d/xrVPE0M2R/YwF5NJ38nRoL+cEPLuaBYPcpn1lI26c=;
        b=jU/o2jYAK732W90czglHbUbfMMI1DjdRTzO09c+VrpQPRHbKataNyUxgJGo8jecgDA
         9iWOdcEdlKObxBMatziBaQKb2mpgK/L9uPD8C0uVE52WbHq9mFC+fSyisMG6LKipcB+B
         qAvPy/o8LudoUdQ3dSg/lGCdshGCkao6GcDQSKGBNbGRAV7K9E/L80r+FFheCWYcIhci
         AdusFSUvAXB64B1riaYFqabTnTC1t1jpFciN4hUxV8TgcSSY73qibRMAGQBDqAlB9jwE
         RUPc5s+OdbntHM6MQDE93D9crxiQ70rcssW/8azvpqM/RLAV2yFyZYkjEbfdsxQxkNa9
         lXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711055930; x=1711660730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/xrVPE0M2R/YwF5NJ38nRoL+cEPLuaBYPcpn1lI26c=;
        b=qx5ViSJEcvKTLFFZYVCQrIa+wlVtJwZ8hd/txXlyimXy189Hsw+Jal6dRNbLP5MtCr
         LGpclTfUrrm+v1zaMRulvrSC/a03rhdGJhuyWJuliNjRFuH/KghahpjyC+ryi707suk/
         8zOdrzc8hzjFmmRso+rdkAdpzx5y6+dXwjxDvH81SgUfdJrHzSwcDytnuqRfFZZZqJuv
         yCcAABBVY4u3xmLZpzXVWCUYlI7KUt66s+Eyo3utmHQs5N5rNAtMlejQb7BeC5vnBU9e
         XlXClhgh1qNma2KmcI6Rnts9Jun7Sce/7TNFhtrpdTc0WMDvPoH6bZIppWYxd562dG2h
         TVdQ==
X-Gm-Message-State: AOJu0Yy7JF6IuyisCloEOu2FYrocDp7VPTf7UaJ1EzuaVAOPOJtrXdBC
	4uHgEsPTmCFKiFPlUZgYQfpm38R3xzEvyKDhXXhW3sctUB/kpxQeeZp2HDI=
X-Google-Smtp-Source: AGHT+IE+tt+HMbbBqv2XNUxxWpV+WU0JHpGtjcWNZtbWcdasPgO6j5m+jhRSZz72MiZUFF+lxekaMw==
X-Received: by 2002:a05:6214:202c:b0:690:7928:87bf with SMTP id 12-20020a056214202c00b00690792887bfmr389545qvf.22.1711055930709;
        Thu, 21 Mar 2024 14:18:50 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id gs7-20020a056214226700b006961cdc3f7csm304903qvb.85.2024.03.21.14.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 14:18:50 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 0/2] x86: Remove ia32_unistd.h
Date: Thu, 21 Mar 2024 17:18:45 -0400
Message-ID: <20240321211847.132473-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Besides containing one unused macro, ia32_unistd.h is simply a leftover
wrapper for unistd_32_ia32.h.  Remove it.

Brian Gerst (2):
  x86/syscall/compat: Remove unused macro __SYSCALL_ia32_NR
  x86/syscall/compat: Remove ia32_unistd.h

 arch/x86/entry/entry_64_compat.S   |  1 -
 arch/x86/include/asm/ia32_unistd.h | 12 ------------
 arch/x86/include/asm/seccomp.h     |  2 +-
 arch/x86/kernel/signal_32.c        |  2 +-
 4 files changed, 2 insertions(+), 15 deletions(-)
 delete mode 100644 arch/x86/include/asm/ia32_unistd.h


base-commit: 93387dba36cc9033724d8b874a5cf6779ef084ab
-- 
2.44.0


