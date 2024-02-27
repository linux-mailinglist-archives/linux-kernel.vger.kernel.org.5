Return-Path: <linux-kernel+bounces-84016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4029386A160
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2336D1C23662
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DA014EFFD;
	Tue, 27 Feb 2024 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CEEvFTez"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D014EFDF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068321; cv=none; b=TVgkzTsmIefMiO0wkfu+s/enpIaFw8P2ihJImszhkSIMR0JpZPGs9sFzEbvxO6hSKOh/nmgEWngvaiRsXdRqS/1tp1lc/PuX3G+5riUbM4NAHUFZx4UxjlMfdmbkKhuCVQaLzbN2iSrRFmJo4F0Y3PR5ykve5CtLlNE44b6T4u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068321; c=relaxed/simple;
	bh=hEk9QDFeu1YKNa8wvXHA4VBVHU0myYC6K9alzCsgJxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=omOqh7DtWnaHUsL8p3oAjchMZyd7BFhWGli04K9ERyMERSG7/Kw7kg1O9KnJa1FogUd4FU/9yzhBsHOmZtmFXu31+DMZ7dGwf+r0rCMt33VtvgAZRNEzfPmftRTjwR1LtH18xJEsfLjsFxj9GV97t345xLUksNqcj5mVUmZ+gfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CEEvFTez; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so1830143a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709068317; x=1709673117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPE+oqeP/gO+8e/ieSDDfq6bOx9XZ+PWeSTcgAFWM9g=;
        b=CEEvFTezO13TATFk+aNsE9vWHxszrx/0ND8oGCoz2z6r9nc7o6Pd6Gdne8DKG9Dlzz
         +oBsOI8r45glX0rJqQ9CJ7CAhdlEFCWpEl7JGVMWu09xk082A+shih1KGHiu5NrOp+4g
         NBS7F4gEqEvvuWio0hMJjdm0pXGG2CNQlrtXTV9u6lfwpsUM3svkcsegx0mHZwrAkjBZ
         B6tYSWmFKFc8cu8hGrtWllfACxwJEw96btujcJs2DJqkK8TxDYrj8xlDI5QQGmDRZ8YU
         e0Mt6j03vfBE+hmHfvjMPTZaA+gbG88G/aiZkv1D47zPQ7PxetRWlHJb+iRIxNpeFl00
         msiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709068317; x=1709673117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPE+oqeP/gO+8e/ieSDDfq6bOx9XZ+PWeSTcgAFWM9g=;
        b=EoAxd4CWaaL87oMK3jfTQGpz9VEO8Uz12DcXwif8pJV0o48jqzcIZI+mH/fPh8IVKV
         fLPWqGYFwzzy6I38QdCEA+Yg9q4g/s0Zs2xXD3b3/hG2bADqgCFUlMq3AXX/1AAdW0MX
         Syw8hZOwjCQ6ZArvrDTxgANPifMh9sf67/1Ro1aAt+g1/gpdfe9gjBTwNxuwUbvJ7zk+
         oxt2VS62S8lSFsZFxgPDAQEZ4ZKeNIrDVkJmcIL/MSbEFA6qgquD+PwjfH0y9VX/j6kZ
         dsXVHn/GOijy0QSL8IZj+wbTxD5+9Fh1s7IogPZrWyU2gtPHp0WVLqGRY5Z+16trXdFV
         0FGg==
X-Gm-Message-State: AOJu0YzXvgmJaH8RyTl+6gqZmbrHDNRabghqycfBG2tOUsmG4gblA8s7
	O/dQM18CXyyeutSmRbHYp7cwfdkzWtBD+FtxTIjywO9OjuQe/QyD7YrWgQy0pRAmwItV/DVmHSp
	T
X-Google-Smtp-Source: AGHT+IEJhtqoL43ymbF+y0F4k/K7S8yFPVZI0cy2P12AZQXzF8mAHoPal6G9no2oFfdEgEPlFmqwzg==
X-Received: by 2002:a05:6a00:1384:b0:6e5:4abe:fd4c with SMTP id t4-20020a056a00138400b006e54abefd4cmr2833451pfg.3.1709068316753;
        Tue, 27 Feb 2024 13:11:56 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id u8-20020a056a00098800b006e5557128efsm735390pfg.133.2024.02.27.13.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 13:11:56 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com
Subject: [PATCHSET v2 0/2] Split iowait into two states
Date: Tue, 27 Feb 2024 14:06:01 -0700
Message-ID: <20240227211152.1099534-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v2 of the patch posted yesterday, where the current in_iowait
state is split into two parts:

1) The "task is sleeping waiting on IO", and would like cpufreq goodness
   in terms of sleep and wakeup latencies.
2) The above, and also accounted as such in the iowait stats.

The current ->in_iowait covers both, with this series we have ->in_iowait
for step 1 above, and ->in_iowait_acct for step 2. You cannot be
->in_iowait_acct without also having ->in_iowait set.

Patch 1 is a prep patch, that turns rq->nr_iowait into an unsigned int
rather than an atomic_t. Reasons given in that patch.

Patch 2 adds the ->in_iowait_acct stage inside the current ->in_iowait
setting.

I haven't been able to properly benchmark patch 1, as the atomics are
noise in any workloads that approximate normality. I can certainly
concoct a synthetic test case if folks are interested. My gut says that
we're trading 3 fast path atomics for none, and with the 4th case
_probably_ being way less likely. There we grab the rq lock.

Comments welcome! Peter, CC'ing you since I did in the previous, feel
free to ignore.

Since v1:
- Add prep patch 1, switching nr_iowait to an unsigned int
- Modify patch 2 to not use atomic_t as well, no changes otherwise

 arch/s390/appldata/appldata_base.c |  2 +-
 arch/s390/appldata/appldata_os.c   |  2 +-
 fs/proc/stat.c                     |  2 +-
 include/linux/sched.h              |  6 ++++
 include/linux/sched/stat.h         | 10 ++++--
 kernel/sched/core.c                | 55 +++++++++++++++++++++++-------
 kernel/sched/cputime.c             |  2 +-
 kernel/sched/sched.h               |  3 +-
 kernel/time/tick-sched.c           |  6 ++--
 9 files changed, 66 insertions(+), 22 deletions(-)

-- 
Jens Axboe


