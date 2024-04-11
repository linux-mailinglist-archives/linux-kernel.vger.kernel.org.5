Return-Path: <linux-kernel+bounces-141521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF028A1F58
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362511C22C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2535012E7F;
	Thu, 11 Apr 2024 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0R7jhXq"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F3D205E29
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863124; cv=none; b=WnOu2IMpb8ztTUl0Btlpi3gD2xAeODtuxcvj8qpd9Xx/mWnN1jCSnEZUX4YujMFVEv1vXc5e4kJCMscSuV9h0RnRs9GuZav+igVEXQS30YXjWGMPyls42M/ez6N6InlwTEZY9YqtlPmY5ZNwSpXvGkI5TmoJ1ZEzm35rfKLAxkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863124; c=relaxed/simple;
	bh=kLkRhCgzl69ncTJ4dP8QZ5GkpKH50I0/svIbTDstrSc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ah4Ob/M+KcDwwHWd8u0rYyyd/qs6v0oG8pF0E0+GAl8GXr73Gvu8PCdRIcqQuuLk+Re6g+rs1MSbExZO+Zpnr81iLNEe7LdwlNy7kXLYlWyjX30SdpmahGweVdHD60Um6IIswRDnjsOI4K8QXKQACFuGjVtkpQhOsq7tkGkZsp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i0R7jhXq; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so121168276.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712863122; x=1713467922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gnx+Wh6mZm2zD93yijKpXlCXtlqxeyrEyl4n/ltYBHk=;
        b=i0R7jhXqknJar21ATxDqgfRXKIImg7p1muNuoVG2DFoVhBkCnxiFpfJs9wNu+His34
         eOH0u5T+xNm05ZkmD9j3AO1GuQ641IAIWoMFeem19JCzwfgpMAoGPigp/UodKk+C/+Ml
         6iW5eC0fLsLn9OIC/E9f0SOOaWC7iQ2XHIldTEzsKvnizmkJqgkKOlmkKp0PfM0QOu+n
         F7m0m29s5frIX5I8e6ChDXeJyRGy7pYGQK/G20v2G9JOnWixVjhjInvtkfFFHmS2evM3
         4KZB+/YvkfTJwdmv787JbAKkqk3Vxn2hY4paRB9v3RVAs2h/ToGyzQtt366wJvhozRGi
         DccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712863122; x=1713467922;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gnx+Wh6mZm2zD93yijKpXlCXtlqxeyrEyl4n/ltYBHk=;
        b=c/F/HK+LSD2Hi+Xtndi8id+p7AfnvISbWZ4JNUOy2Q8YzNn/8FyWe+EPasei+LW/Vx
         NNu0BTNA1YOIBjHiUhsv/vBnGqqF37a0q5pmSKikid81+fJUufoFwVPAkA++yxkn2DTG
         iXfyQA5PzTL/D+mgwcdkiRT9Th5x3jcry7Fg3t8PVq9Ce8GgS5b2i7zgKf/6xjIXqzSZ
         984M62JgwpoBDDJcehmp3MPwcibsQLK251juF7vOENTV3oZEDr48udVSVICXgZpPTXd2
         x2RE7CNp5XPacSdfBYsGh0HNJoqEycRBzJCQPPWU2RFIJf/GNrFcgGD5r1Ybs+IyZnN5
         rRIg==
X-Gm-Message-State: AOJu0Yw4xVOhdvzpQnVuF8wR4NDCxmMkF4j35n7xV+cAb6ljt7Frbpy2
	wYsM0mCB4hFUHV5i1R0DHv1QdZgmIbKiwBITHNeey70cq9aOcsfrfUUGqrkZLPODbdqICn4fOOl
	LGaiqhFVFcp9lPQ+5RNw9U4soy/l/LpW9r7sS7rgYUlxNLfhGek1uyzE=
X-Google-Smtp-Source: AGHT+IGwHVaFdqdjG/q9Ei/kAzML7ZY1M3xdauS0D/3tbBhX3B8TE51QbULjO2jN+O7dDYP+/cenpRV4eilHJRZuRA4=
X-Received: by 2002:a5b:40d:0:b0:dc6:bcb3:5d8e with SMTP id
 m13-20020a5b040d000000b00dc6bcb35d8emr475726ybp.20.1712863121771; Thu, 11 Apr
 2024 12:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: enh <enh@google.com>
Date: Thu, 11 Apr 2024 12:18:25 -0700
Message-ID: <CAJgzZorn5anPH8dVPqvjVWmLKqTi5bkLDR=FH-ZAcdXFnNe8Eg@mail.gmail.com>
Subject: [PATCH] Clarify risc-v hwprobe RISCV_HWPROBE_MISALIGNED_* docs.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

These only tell you about scalar accesses, not vector accesses.

Signed-off-by: Elliott Hughes <enh@google.com>
---
 Documentation/arch/riscv/hwprobe.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst
b/Documentation/arch/riscv/hwprobe.rst
index b2bcc9eed9aa..239be63f5089 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -192,21 +192,21 @@ The following keys are defined:
   information about the selected set of processors.

   * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
-    accesses is unknown.
+    scalar accesses is unknown.

-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned accesses are
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned scalar
accesses are
     emulated via software, either in or below the kernel.  These accesses are
     always extremely slow.

-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned accesses are slower
-    than equivalent byte accesses.  Misaligned accesses may be supported
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned scalar accesses are
+    slower than equivalent byte accesses.  Misaligned accesses may be supported
     directly in hardware, or trapped and emulated by software.

-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned accesses are faster
-    than equivalent byte accesses.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned scalar accesses are
+    faster than equivalent byte accesses.

-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned accesses are
-    not supported at all and will generate a misaligned address fault.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned scalar accesses
+    are not supported at all and will generate a misaligned address fault.

 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
-- 
2.44.0.478.gd926399ef9-goog

