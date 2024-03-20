Return-Path: <linux-kernel+bounces-108936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE1D881238
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2907E1F23C56
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562ED42079;
	Wed, 20 Mar 2024 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK3dsLlX"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF99C41C86
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940766; cv=none; b=juDqgWC+S7ftnTEZAXhq7Mum9jIr/zW12paygV4BErwRK6zVr29AvcyB/eeiZalhWB5WanTAmEAtAoADiTVEe32iDANOGGYQ7NQC85RMQ9qdTeVuKouou/gBmkrIPi0yuVmpkn7TkDZKWtK4AKqA8oWg6QoTSPbY2OOvuQoQ8ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940766; c=relaxed/simple;
	bh=46dNB/AFBsS+m6jYDD1tTDQYOLBdYupp4znM+rbsSCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qC8v+7yZ/9ykXjvQXWrl3Bna29ehuV/iDdDjPlL8c5ZDlnZ/sJH4gf3ZxSuYDVZ6uT4vYeiY0jmV5dw/0XmaJRCKhNpkiySNfq6bEZzXbTM5iKwVb/sKJS7Hdvc3Q1uMaHNhzpNbWXYSkjHhn7OU//a0RMMgrJ88nOIS1Scm4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lK3dsLlX; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d46dd8b0b8so88694611fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710940763; x=1711545563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Vdmni8v/fiLq2S38Vs7HUTQOMeaRwPQFb6CJwmyxdo4=;
        b=lK3dsLlXwuoXXU8FxUsbmx9lIoI7vUnDR2Yp1OyYCXrYg2sK45xRfYLJQ/bfkPoseK
         t3aJRcZ85ajlkp4PYEzYNUK6pOmfkNz4ZFjuSax1Kv7i/6BGRdWZl5AS8nVq4zwXLvCE
         d/Rn7T0hDKn5+f6/+XPPqaBjPNg+2BbsyPw/suGm28Pz9+nERjnnTIsyI+VHufV4S1m6
         1r30BAEXqYSIYj6zTA4rvNfjl8yFWwDG+AHXqB8H5AF0iKbkH6Aa/O3Pa8CWrd9sNVhq
         7pYJXBdyQNSlhv7UKO3tuSmGdU0x7wLiCZAszoWkSoGCnKXh1J9rpGqpYNN0uZRzEQ4o
         z4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710940763; x=1711545563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vdmni8v/fiLq2S38Vs7HUTQOMeaRwPQFb6CJwmyxdo4=;
        b=s5AbmnYeJXgGq9ZFCtypMNnqgEgSagWj/rzemXxYcahM43qoiCA1O0fTm2sEr2Icb2
         oZiP2zL/9YPMexPz375l5QKCerC/vsQaGzIJ6uuMfqLJczHBuFgbBnVtkr3alDz97GDT
         /wGjIHgN7NMZRHOsSk1vJFNxB9eAn3TviqMAZUGNsRTpMmLhTYwcNSlK2r5oX1Pb/0Lf
         YIFMk/YQwmwwia3rzOfk6LzEfEUxJhqzefTxpahwsDFRFewzQZ09/IUrQniSA77rujwY
         UNkuWYmK8aX84c+UmD+NnSreezT0LTW/xJtmWzoMxZwi1y+hzV5MUsFbSYgH/yvOwrTl
         DuQg==
X-Gm-Message-State: AOJu0Yyafd2CKfI1SuLKSfJH5l6dUD9w/GOFAg96xWvCWB3ddc8dLF9B
	HPqScz9KudCa+qFCXmbGAnV/pw32W1vvxrDUcJuaeVjxkFUyp4up98q35O8Yu/I=
X-Google-Smtp-Source: AGHT+IHyY2goIAolrzwmAmncl2glE7mWYpX4ZL5Ski56TxoEEnjEhyWfKondsnzwZ+EIhjUM3YCS9g==
X-Received: by 2002:a05:651c:10c9:b0:2d2:2ce1:1196 with SMTP id l9-20020a05651c10c900b002d22ce11196mr11973803ljn.53.1710940762412;
        Wed, 20 Mar 2024 06:19:22 -0700 (PDT)
Received: from kepler.redhat.com (1F2EF04C.nat.pool.telekom.hu. [31.46.240.76])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00414621c77f9sm2247072wmq.1.2024.03.20.06.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 06:19:22 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 0/1] Fast headers: Make task_struct::thread constant size
Date: Wed, 20 Mar 2024 14:19:07 +0100
Message-Id: <20240320131908.2708438-1-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turn thread.fpu into a pointer. Since most FPU code internals work by passing
around the FPU pointer already, the code generation impact is small.

This allows us to remove the old kludge of task_struct being variable size:

  struct task_struct {

       ...
       /*
        * New fields for task_struct should be added above here, so that
        * they are included in the randomized portion of task_struct.
        */
       randomized_struct_fields_end

       /* CPU-specific state of this task: */
       struct thread_struct            thread;

       /*
        * WARNING: on x86, 'thread_struct' contains a variable-sized
        * structure.  It *MUST* be at the end of 'task_struct'.
        *
        * Do not put anything below here!
        */
  };

.. which creates a number of problems, such as requiring thread_struct to be
the last member of the struct - not allowing it to be struct-randomized, etc.

But the primary motivation is to allow the decoupling of task_struct from
hardware details (<asm/processor.h> in particular), and to eventually allow
the per-task infrastructure:

   DECLARE_PER_TASK(type, name);
   ...
   per_task(current, name) = val;

.. which requires task_struct to be a constant size struct.

The fpu_thread_struct_whitelist() quirk to hardened usercopy can be removed,
now that the FPU structure is not embedded in the task struct anymore, which
reduces text footprint a bit.

Ingo Molnar (1):
  headers/deps: x86/fpu: Make task_struct::thread constant size

 arch/x86/include/asm/fpu/sched.h |  2 +-
 arch/x86/include/asm/processor.h | 14 ++++++--------
 arch/x86/kernel/fpu/context.h    |  4 ++--
 arch/x86/kernel/fpu/core.c       | 51 ++++++++++++++++++++++++++-------------------------
 arch/x86/kernel/fpu/init.c       | 28 ++++++++++++++++++----------
 arch/x86/kernel/fpu/regset.c     | 22 +++++++++++-----------
 arch/x86/kernel/fpu/signal.c     | 18 +++++++++---------
 arch/x86/kernel/fpu/xstate.c     | 22 +++++++++++-----------
 arch/x86/kernel/fpu/xstate.h     |  6 +++---
 arch/x86/kernel/process.c        |  6 +++---
 arch/x86/kernel/signal.c         |  6 +++---
 arch/x86/kernel/traps.c          |  2 +-
 arch/x86/math-emu/fpu_aux.c      |  2 +-
 arch/x86/math-emu/fpu_entry.c    |  4 ++--
 arch/x86/math-emu/fpu_system.h   |  2 +-
 arch/x86/mm/extable.c            |  2 +-
 include/linux/sched.h            | 13 +++----------
 17 files changed, 102 insertions(+), 102 deletions(-)

-- 
2.40.1


