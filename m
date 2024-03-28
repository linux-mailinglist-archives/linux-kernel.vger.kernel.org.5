Return-Path: <linux-kernel+bounces-123422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC8D89086D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8034E1C233EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256D2136E1A;
	Thu, 28 Mar 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7B9Iped"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCDC1311B5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651229; cv=none; b=SMREwUDXdn2mC2R9jZytjAh4w74AjwHfEaHaoryOgrDaZdfkMTmt542hD85xDDmMqqD2d4hPPIdxgzmYa2Ohkpbiz1fwEUPq4/fliJZuFT0MVFE1IsVscG7W+HUePmXHOim6sSZ61fbZA6TJBf4eXpz7R15rDn8EIjzWtLCwkzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651229; c=relaxed/simple;
	bh=YBgjeXtKi8nPAuh1BvtTB+LoMePDjNYc13Weqi9w3k4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IVqp7zOho7XY/R0FL8B5gXni2cQgOJQ+XgwKL7t2jylc9F0RUSlQtcLqkVAOXnyXITyWmaSqrQ2QV7TK2MGdamT5spazajYq/cD6bzuo0gWnWVW169+w8BzaNh10blnJLyz7Spb3f4SoWX2dFC16CZEJzpyWiEz3JRiFosxUiEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7B9Iped; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4154bf94fe4so1028505e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711651226; x=1712256026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7vStwaJc8Jp1+8eAznQWoP1efcCvQ1C+LTuBFpDSFw=;
        b=m7B9IpedZyJ6zUNEB0J9I9ySaUHHtA3hqalHIUIKUBISpKkvf1Rukl3ex85TCUOXmY
         aAbAWR1N+a5eWCFkLDyoz2zKaUqNEadaHaBfE5XeQff7zRHTAJSAbM1nvFKtHPTqOsY+
         ZVXXb1yAIeoIH2xFU/0ZJq52JGlEhDISMiDeBblEHdHotf2F2xcFO509Qdcbjen/oLqa
         Z8ZCYE7d3DlUmGDVo0E4BFiRnGL3IRP1OZA2cFiX4t32ZwjeaPvUSzhPYbXfA8zMqYR8
         Np5xI4EGo3T0vJB4c+9dsm0MZ7mI5ffo4gzCoeZcolyDE3KTZOgBikldfGXvAQJXwrOg
         SLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711651226; x=1712256026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7vStwaJc8Jp1+8eAznQWoP1efcCvQ1C+LTuBFpDSFw=;
        b=BJB19a9axSqUWH/g9mxk/H0rbjzpQg8jhHqwsz8M3ZGC0UvH1HcQP6Icap05z9gVZ6
         9YI4CBa4mEzpDlVm+EFO+3NK87bN3zrukxCADLkhrNuoeMi3SSygFdaVJvvUKgrOAviO
         dXR02Cs1vd96dxGpQf+UgUyyzY6nJLl5fi1YqLw1NHo7/2ATmRbH08oUraafhEN7cQRe
         kjJObpwZxFyNdkisE1dV3sht4HFoPWGq4I9Sp/vz30ZQs1RF02WiKLr/Ag5vBcfLwqjv
         y6xewFQPL0BTMp4STZfY8Q+Ese/SbIAPZUTQjHLYpfnpgBP9xcoXyKSqNJdCRi3BUUUx
         cJTA==
X-Forwarded-Encrypted: i=1; AJvYcCV+YNIegD8wdV4QzJH2O2rulMN9FBy5Ej4yk1C8zgB9I685/s1F0jM8Ugg9m905J/e6C7WU8UPiX3OqIuG2HhzzDPNBI7S2KYMt4K2/
X-Gm-Message-State: AOJu0Yzh8qn5ky4vSgx90OscM2ZopaW53XkEgaNlj1fkEsYJDUOE3elj
	52PQs+BaI26dlKH4xdwsOBqx/q9qHf6iFCIXKZyXzuvtGsPUd8CrIqs9T9b7IgQ=
X-Google-Smtp-Source: AGHT+IH6hW+LdUDn61VIrLAIWqaZ4cJxyHJNY508rFj+R7RuB9lz0ukDrD1/hb7htO6wz+0Mk+GVww==
X-Received: by 2002:a05:600c:3c98:b0:414:6bda:4735 with SMTP id bg24-20020a05600c3c9800b004146bda4735mr135792wmb.3.1711651225829;
        Thu, 28 Mar 2024 11:40:25 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id fa5-20020a05600c518500b0041495df2268sm5168203wmb.2.2024.03.28.11.40.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 11:40:25 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Cc: puranjay12@gmail.com
Subject: [PATCH 0/2] riscv: ftrace: make stack walk more robust.
Date: Thu, 28 Mar 2024 18:40:18 +0000
Message-Id: <20240328184020.34278-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current stack walker in riscv implemented in walk_stackframe() provides
the PC to a callback function when it unwinds the stacks. This doesn't
allow implementing stack walkers that need access to more information like
the frame pointer, etc.

This series makes walk_stackframe() provide a unwinde_state structure to
callback functions. This structure has all the information that
walk_stackframe() can provide.

Currently, there are four users of walk_stackframe(): return_address(),
perf_callchain_kernel(), dump_backtrace(), and __get_wchan(). All of these
have been converted to use arch_stack_walk() rather than calling
walk_stackframe() directly.

We need this to implement arch_bpf_stack_walk() that provides a callback
that needs the FP, SP, and PC. This will be needed for implementing BFP
exceptions for RISCV.

There are no functional changes in this series.

I have tested this by crashing the kernel and looking at the stack trace
with and without CONFIG_FRAME_POINTER

Puranjay Mohan (2):
  riscv: stacktrace: use arch_stack_walk() in place of walk_stackframe
  riscv: stacktrace: make walk_stackframe() more robust

 arch/riscv/include/asm/stacktrace.h |  2 -
 arch/riscv/kernel/perf_callchain.c  |  2 +-
 arch/riscv/kernel/stacktrace.c      | 75 +++++++++++++++++++++++------
 3 files changed, 61 insertions(+), 18 deletions(-)

-- 
2.40.1


