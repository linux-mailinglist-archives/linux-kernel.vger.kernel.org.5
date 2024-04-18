Return-Path: <linux-kernel+bounces-149645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836938A93E6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0E81C20C58
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54453E493;
	Thu, 18 Apr 2024 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5Ww6DWX"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35C10A0E;
	Thu, 18 Apr 2024 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424891; cv=none; b=nAh/0Wat+mGXrUzg+Pvf6mWedrIytXbVdrS8p3V05n2r3mOt5Nea0/JhddmFiyv/6FRgG+RlUS3HJZIR6DwEGMqtw2WOo5vf72WfSakNfgPpFh2JTDIeH0IPrk/lufpDrvl1482GMHf0kkWfSlfFVJrEphsvmqO6PtJl9fwHT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424891; c=relaxed/simple;
	bh=jPuh7FIgMr6qCmpmTA3bWFbfg8Zn9tHOOZ4RAcWeeQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lX+8jyh1KhcixwETZNoAlxon+/6Lr2AZfTjsVhwgXf0n1DPXB6zzi+EtqdEtTH2Q5hmycaEU6+vhyMwOZMGNONrCw2gAoP/9R0xe/MIqpyylAsPcXmxYHtXO9HNr61XJ6EySHCjH82063UOpgOjpCW1hwvJ0MSQUHcrxxAViIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5Ww6DWX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so4790425ad.1;
        Thu, 18 Apr 2024 00:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713424889; x=1714029689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TjH1GQTJUnKMbzxTuPWXa0AQF7LCmO+P2aRPeAVNROA=;
        b=A5Ww6DWXxJaHcvMnICp0zWmHqHJUA4Ht1xaO5ztUr9YokVzE3N/DACbb8s3tbwBILC
         kaUiUizPMa8Rki9rvZlRaYZriHT+CUPmM3ngvRqhoAAKSm9XNOyfA9pmDwe+QiKrDAjy
         2Adh1WFP5kl08y0WbOEO3h1iUqGpuzCW4Mx9NmJ7yg67QQGkkEdk2dOKbEfNxdbhD1Ca
         bbYJBv0SjIH4qG76xbp80uvX5O5QK0KqyJ17hPH/wiBZ+nXiqjDtj7p5jvowjnYxdgcD
         ZUDRhbIYL/kJEuc8ifg7UmkG08RpfT6+JLH92XK2kk4JesqFUNotYq7Ojdnt/Z9uLsei
         Ct7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713424889; x=1714029689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjH1GQTJUnKMbzxTuPWXa0AQF7LCmO+P2aRPeAVNROA=;
        b=oQiQBSggx8vgiZlVJVD7jLC+G2b4RjoaIH19hsNPXykztNviFI+sM2i56+vGxxuGnT
         Lu5nNIdqCgiZz+nkrT3jgeSxVqzBw3WkvTljp7XrD9ZbVaqEQgzQL3gCUv1KQkTSXn8n
         HAerohhuAWUiGjGcaeuye0taRQVCYIjiv1W9f8mfkAL6BJHzgZVCCIhX98zaQMMjrl7i
         pZVm2huWnWS6aBYuSNsnRI7+3q1tvUZI+kCR2tjFdfzqLbDTmXWyEHfyHiGZKFFIzCSX
         s13u2u9xKW2Sxuljotr8OHJ0chyRIhJds9sdPManDFLaumwfXLZ3W5nIHxqdvd8MFfRD
         fT6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWr9R//mDbVzijsiIodddYlI9oJgFaTdOFEiZa6fXv0UwQYf6+M6Hpu946RZjApW0KArUF7z0+DnV8ERQ+DtXqkZBHbVW8baxR4
X-Gm-Message-State: AOJu0YzeMYhVqfczWZKHEw+l55K3m51SDk+KCB833EsBAnNwHhEUB6Ij
	AhhcDJwIGQ7RxwAxEc/Pa8xvp4GkfPlm55BN7MAEDbe9epCS5kri0s+s7Q==
X-Google-Smtp-Source: AGHT+IFwFzVBkHDOthky42ZnPS32nMZlGjHJfFSO8uFal6Q5JsQRhUDs5cm+Od0cNpdI4dK6aM+l3w==
X-Received: by 2002:a17:902:fc8d:b0:1e4:425f:5795 with SMTP id mf13-20020a170902fc8d00b001e4425f5795mr2408473plb.58.1713424888915;
        Thu, 18 Apr 2024 00:21:28 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id ja19-20020a170902efd300b001e290af5ec9sm818909plb.115.2024.04.18.00.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 00:21:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 66E8918462BA7; Thu, 18 Apr 2024 14:21:22 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: workqueue: Inline WQ_* flag pattern
Date: Thu, 18 Apr 2024 14:21:01 +0700
Message-ID: <20240418072100.30670-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1773; i=bagasdotme@gmail.com; h=from:subject; bh=jPuh7FIgMr6qCmpmTA3bWFbfg8Zn9tHOOZ4RAcWeeQE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDGkKJyVWv8l5HmohmNvhXPN28s4nz00+84o8nLenpvqJ+ f/p/IUXO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRoN2MDFd+rM4/6XlUUKZU dfa61DMK/pnmuo8eJyxKfJP6x/HFkVWMDCttfTfwrVq4IPzYzHTZ2MApMdErJJqEmFSMa98Uu3V Z8AIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports htmldocs warning:

Documentation/core-api/workqueue:776: ./include/linux/workqueue.h:493: WARNING: Inline literal start-string without end-string.

The warning is caused by unescaped wildcard in the pattern that matches
all workqueue flags (WQ_*). The pattern is rendered as normal text
(with surrounding double backticks due to @argument syntax usage)
instead of inline text like in individual flag names as a result.

Inline the pattern to fix the warning.

Fixes: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/linux/workqueue.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 158784dd189ab2..c9fec74e130459 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -463,7 +463,7 @@ void workqueue_softirq_dead(unsigned int cpu);
 /**
  * alloc_workqueue - allocate a workqueue
  * @fmt: printf format for the name of the workqueue
- * @flags: WQ_* flags
+ * @flags: ``WQ_*`` flags
  * @max_active: max in-flight work items, 0 for default
  * remaining args: args for @fmt
  *
@@ -490,7 +490,7 @@ void workqueue_softirq_dead(unsigned int cpu);
  * min_active which is set to min(@max_active, %WQ_DFL_MIN_ACTIVE). This means
  * that the sum of per-node max_active's may be larger than @max_active.
  *
- * For detailed information on %WQ_* flags, please refer to
+ * For detailed information on ``WQ_*`` flags, please refer to
  * Documentation/core-api/workqueue.rst.
  *
  * RETURNS:

base-commit: a1d34930d1b3782307ef5d0636f4f6a9ac5028e5
-- 
An old man doll... just what I always wanted! - Clara


