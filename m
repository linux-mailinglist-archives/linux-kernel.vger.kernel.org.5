Return-Path: <linux-kernel+bounces-86676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7317C86C8E4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DDC1C22489
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872A37CF2B;
	Thu, 29 Feb 2024 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VNEjWVk9"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B885D7CF0E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208662; cv=none; b=U6UL7ZOuNnrKp0y4ce7eQfXB5k7nr6jnHM2FbTJkAF+cbJSBrQaDdjVo7kn8drJzRBdOLJO4A4iFQzfH5OtMlXfZ77PYki4QF0tc4+9ZbUw2T6+qfuzvOl6ozmjJF8hULC9fjQhwv5S2Yb9CpEjfB0czrL89FOKEtd8fXVfPci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208662; c=relaxed/simple;
	bh=hTxLvpIcL1UD2En8JiMErq12bbbWanA7jyd6JUa7mrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RLVEZlp+fd5AKhdM4hhPBuE6tHxMDTwOcK9XvZSB4GshVfXV6oja5V49yj4kKroqbIT6vSk2keogimiIuteFvoPXYd+FstGXKE+BoTE05WFV2R3t9ZILu2V3KyhzIQIRCvxICeuTWODkoFcKtDU/sIiWB71fDIN5XMcE2du6P8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VNEjWVk9; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d27184197cso9332011fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709208659; x=1709813459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3uSDH9PeEDZXjS7+X8GDOuU6r1LyJ3/UzSH+DzMzHV4=;
        b=VNEjWVk9BtR9F3sByRfEGnuL+xxwU9LhfJF5MSJNSWnvaKH+j1VMRDfURDAyxEZ8UU
         7K1DFizR55Sv0YGA39gvj/T9b0IkbxSH/erl5QQRchWDxQwJWuIxZrxpT57dvYKlTx2v
         w+Sz4lcKAxxcm+5PE2K1pxtPaBWjU3QFJLs4WqxOPc1ytes2C3Ac+pUKfIL7VhkmpmcF
         ZNdN2ZTinaOW9H2Dg3EC7G5R2RwNl0KOoTN375NL6Q1kVweMX+/l1j+5/GmWBno2+zuk
         F0L0K3kdRKoXto+i5NLvzhmunRwV8w24Yz9dTRYDKDtoacjNwG6SaFct+0TRp892KV1c
         fX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709208659; x=1709813459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uSDH9PeEDZXjS7+X8GDOuU6r1LyJ3/UzSH+DzMzHV4=;
        b=JfjEA6BZrqfQX/tG1KeSixOAw1cCU6eImUeDGVoMQNiJcLahCJVhabXaETdtHVnEQl
         3u43gJn/TLa0cXihVWjyRNB2GaFbg7WfiZonf2GKCrdQLXW4HDngwgZxnbhzkijJs9kA
         5RtceAo6qXHeM3ypNwDS5gBqWTXCzx06agUI0r2+uO6ynAReGc/fPtCJcb2mz3tcb4O+
         dO8hLk5hiIZpZxBQPwwBnRL5DpCCzCml+DEVLCgCM1CljS43RqBDZpoLhPXu7vkkc/Ub
         mmwNrmjqIJHG9hI6YugPkkW7XY0+P7oITdVMS0CDok26lhSRYMuQrEhBAK9XtUTQY/FB
         KJuw==
X-Forwarded-Encrypted: i=1; AJvYcCUBl02Wnyh0DAcMu/YuIJrTEReWDgfe/26SwEtb6rNTr1Zv92JGvcQak3pQGYyo8cJhOIgRRpqocma+WCuCK6tpo/7aAsAUJfu2vg2G
X-Gm-Message-State: AOJu0YwVddFZaldfYBwst9/ry80NPTBRIz3hfqiH1CbUipizVSClDuAa
	lcBwxG5OH8j5qkNfUzeGQD8tyF4izzA51RijmFSMebgNAORDbQ22+RWUyC1GKN0=
X-Google-Smtp-Source: AGHT+IFiP2+0+aXlKLINZxbd8+wcbG7KYr1oKHoklHZdOQh9SVwwVbbn9h4qAc5ttY+lg8ux9QWdxA==
X-Received: by 2002:a05:6512:acc:b0:512:e57d:c9c9 with SMTP id n12-20020a0565120acc00b00512e57dc9c9mr1885133lfu.13.1709208658724;
        Thu, 29 Feb 2024 04:10:58 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id i16-20020a5d55d0000000b0033cffd1a302sm1602795wrw.57.2024.02.29.04.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:10:58 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <andrea@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 0/2] riscv: fix patching with IPI
Date: Thu, 29 Feb 2024 13:10:54 +0100
Message-Id: <20240229121056.203419-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

patch 1 removes a useless memory barrier and patch 2 actually fixes the
issue with IPI in the patching code.

Changes in v3:
- Remove wrong cleanup as noted by Samuel
- Enhance comment about usage of release semantics as suggested by
  Andrea
- Add RBs from Andrea

Changes in v2:
- Add patch 1 and then remove the memory barrier from patch 2 as
  suggested by Andrea
- Convert atomic_inc into an atomic_inc with release semantics as
  suggested by Andrea

Alexandre Ghiti (2):
  riscv: Remove superfluous smp_mb()
  riscv: Fix text patching when IPI are used

 arch/riscv/include/asm/patch.h |  1 +
 arch/riscv/kernel/ftrace.c     | 44 ++++++++++++++++++++++++++++++----
 arch/riscv/kernel/patch.c      | 17 +++++++++----
 3 files changed, 53 insertions(+), 9 deletions(-)

-- 
2.39.2


