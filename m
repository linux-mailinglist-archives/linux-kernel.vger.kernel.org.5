Return-Path: <linux-kernel+bounces-88297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0387A86DFD6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9881C226AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75C26BFDA;
	Fri,  1 Mar 2024 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCedi0fD"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BC16BFC2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291400; cv=none; b=mFiCVBGcFUc0nr0O+fT9FOVKiu/i3wkwEnmfI5YYL+oSOoEdw4cZthviB4V8hUu+8EpzBMPbJSt7xw8snPLebHFDh1whlfko71td/W7q4JMwTUJ1brfkqUNlU6s4Jufs5iLy6LP5he0GQL2blqi1gvInWbyoHTnx+1zMbIZYLss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291400; c=relaxed/simple;
	bh=cIU2x/9cSdQPhUeeSvr7Kzw26igIgSSco/cPO4o5rn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qCiLvTFKT1Qp8jOCbRolnbA3u6ZTtucoHDCb0Vw32RnrO7KQeTKMlSKDPXIo9nzlaRKmsHU1nTcL6Rqg342Ejq21aBCv0IM3FVtyF5GiCXO+UnL6OR+3+kbIs8djWy5RH6Kcm/EuaQB8Ey3WfPdOsCKL/7tRMA8BCBduK81PCYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCedi0fD; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d09cf00214so22319931fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709291396; x=1709896196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=inEwXSSczXs7mM8CKQWguv/JU1JLS/a7ijcZ6Yyg+2k=;
        b=kCedi0fDb0TpkCq06bfYCzw4dHhd2OxwAM3CL8kmHaqmIRywBEQgEQQ+zSOnNp8wL5
         gY3gWUmIwo8q4QVe/7ZnZI8Ij0cMimGtO6A1raOkDN410MjduoaCRxNABSIae74UIhFl
         Nlw8Ux0wO++aAxn/4MDlHAJc2XGluTUzXy4MfvU8e1DrumkamLjEiVK6k9Y29RE9j7i6
         eynQJdMAdaJ5EbpUD/1rKO0ZgV6mHooG2RtK7p2qdph3P0Uv9n/cP8sOBXw5IN1OcY7d
         blTHMCWO6LGAiHnD61JWKkVrzCtWy9aP3QFDNDrvXrr8wardyU0Bz8QDyaSV29ybwIFs
         Tgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291396; x=1709896196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inEwXSSczXs7mM8CKQWguv/JU1JLS/a7ijcZ6Yyg+2k=;
        b=pHZ9lO+20UN3MtXe4uwuIbbUrT0sE0zzjsKN5Ps7rgyN9kGYfwBXwPe3vNVHbxIZ5j
         SKXJqaybjePzrCMRrW2I0xQelGvZRJAsp5pFDLj/t3HNOkroRmx73FZGfK2tAmXNBs0T
         Ls3PFJp4/0xIImHrtvKFpqiiUrDIRBzlbgT2cBDP+7Ced48Rjc3NKgH8hKfT9iFq9uQL
         kh/S+b1cRVx9j2dkisOw+BXM24hvRWoZ4o99EMKqhDtzsYiVLzcL9HlD0skYtvjjtPkP
         RJwrpQ2Ae+zHW4tR1tuEFWRI7WcbMWkmD99JTKJLQqkZWYuOdiRS+ViJfVjQgjQcvAE1
         7AUA==
X-Gm-Message-State: AOJu0YyNsaRK3f9dosFa3etWEUs4Xco5pf/VoosHuGvsSW94EMUMyAYM
	s2b3/vXQgIcEjI/+TkypOHcCOwE4qdxefPe9DTuVT4aP0gLrgVlwb81wCyQjaIE=
X-Google-Smtp-Source: AGHT+IHTC8at8iAznM4DfGxo7vffl746rAA2WbcRpMdSMjljALoUgtzjhqr8pMbVElskzTvMz7q32w==
X-Received: by 2002:a05:651c:33b:b0:2d2:29c2:e7ea with SMTP id b27-20020a05651c033b00b002d229c2e7eamr924831ljp.24.1709291396199;
        Fri, 01 Mar 2024 03:09:56 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id b20-20020a05600c4e1400b00412cad66f8fsm490264wmq.44.2024.03.01.03.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:09:55 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 0/7] sched/balancing: Misc updates & cleanups
Date: Fri,  1 Mar 2024 12:09:44 +0100
Message-Id: <20240301110951.3707367-1-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve a handful of things I noticed while looking through the
scheduler balancing code. No change in functionality intended.

Ingo Molnar (7):
  sched/balancing: Switch the 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t sched_balance_running' flag
  sched/balancing: Change 'enum cpu_idle_type' to have more natural definitions
  sched/balancing: Change comment formatting to not overlap Git conflict marker lines
  sched/balancing: Fix comments (trying to) refer to NOHZ_BALANCE_KICK
  sched/balancing: Update run_rebalance_domains() comments
  sched/balancing: Vertically align the comments of 'struct sg_lb_stats' and 'struct sd_lb_stats'
  sched/balancing: Update comments in 'struct sg_lb_stats' and 'struct sd_lb_stats'

 include/linux/sched/idle.h |   3 +-
 kernel/sched/fair.c        | 104 +++++++++++++++++++++++++++++++++++++----------------------------
 2 files changed, 60 insertions(+), 47 deletions(-)

-- 
2.40.1


