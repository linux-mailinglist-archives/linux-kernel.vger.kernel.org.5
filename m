Return-Path: <linux-kernel+bounces-129909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5188971EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F59D1F2704A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DD8148FEC;
	Wed,  3 Apr 2024 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B6KC+At7"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30A14830F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153092; cv=none; b=hMj54UjMcGbTcomRoE4sy6GecVR2BZrtL2QV14c6nho2Qh34XjfoGf5tlwoyHg0cKZdkMndm2v4if0zNt8j9+fbnQgp30XkRiAvKZp0Vu+WIe3wYVG9yc7NcC4pHd52jApf1QfifbJgyviuHucPLu/7mmVfmkUVfxssdUMmFAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153092; c=relaxed/simple;
	bh=9bR9uidFJljssUBEjRj7U4HEyVV6DCBDCUm4+7Tk/SA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRKS2qJJcDyg7Z96EJEfvcJL/YrgiBmBKVfz9y2WJ/yTXutESqN0d8mvCPvFPb1Cwz/SCoV+nyVhIIKMIkhX6MOqc3Fwn/JwdFXjH4Nx/9tDZt+D34hw61IwCWhHu6q6UKqkAWyDgUdh/8NQ+DdeoHSW3gi3+KISqAG4Y8LfKw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=B6KC+At7; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d341f3dc33so17599539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712153090; x=1712757890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=60D2dsRaBW+2mEAkcXZIgJC7Rr7l0v2bYCjZOQO3Yxc=;
        b=B6KC+At7WF3OJYZKD5L4LqM9GCBQCJAZ7c9gcn0fHiffiJw2S0oT0xgIXd24gnpFyK
         +MaxDfKGYLviqGtoQGd/BOU2pMuh/hvjVEoyqHrBXxmFZ9dGU7tAq3fgC0xwzdagws5+
         D00u1Elv3rOgZOisvudoVllEt8i6/FHTEflvZL8nDTyl6xifRY50WO4i2y3dciusNi2i
         6i7lVocnnwmGwczdCDWg83kBS2MuQ6TFeho0m5uFsTQOKL+ka1kWgo5wRFyghHvIO2mX
         onr1ta5QBPni7FvP9soqjTG0isJTzb1IGVV+eeyGwax1x8SL9ltpvQjXxpI9sarkcQqQ
         ysOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153090; x=1712757890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60D2dsRaBW+2mEAkcXZIgJC7Rr7l0v2bYCjZOQO3Yxc=;
        b=bzxeJ7MnVAtJ/WPKpCo5DfGOUpcbKmd2MV1txcOeHC/MEwkhcsziLRcYRJw8SA5+w8
         wgy9DZMl2AaBJeaz4wQHlZamGqXZReGWakGs0QMj043zV4ZgWEsFgzgOFuBGGu++OCxS
         IfJ3dSZJERcnHjSOKbgymr54xaFAP0IkSMHtDuREeWgp79H43u24sbsCkbwf0DBoMiQp
         S7CRG7X/FXRS1VCCwWklUvOIF69L2rDz1ZiaLO4vxevtqJu///7LxDbsOur79l4TVUGo
         NZd1cnRXBU0RIvbWkWkWpivwGiQ4JERwDtZb6GKMju8LK7xzEwNiSspBadN+ROLxEQf4
         MAkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5JSKsczm5FnEBXMdw4mYh0m9ebih5qBhce/givRacPF5FegggG9Kmj+xbjiXbrxDVacx5HsnV505nN6jeXLDzjioULDiaVLhy3i0s
X-Gm-Message-State: AOJu0YzL3HseYYPpXYZm6YP30fHnd7IfZ1n5sdvWWCoQoUqUFGA4qzoA
	05evlJwVOLOPbVGUxHH2vkeIrp1e9IpW+dT/AmY+iYTiG7M8FjUdc+9Std4CyLM=
X-Google-Smtp-Source: AGHT+IFgJ/+EiGZcRaKBxWwIWI7fnIcJtk2PXn3ayYcARmzBtHy0Hs+SNVDALrGNmm4YHf2VTf3zxg==
X-Received: by 2002:a92:6503:0:b0:368:8d92:3262 with SMTP id z3-20020a926503000000b003688d923262mr14486682ilb.2.1712153089710;
        Wed, 03 Apr 2024 07:04:49 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a3-20020a056638164300b0047ef3ea2bdfsm2027098jat.78.2024.04.03.07.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:04:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v2 0/3] Convert fs drivers to ->read_iter()
Date: Wed,  3 Apr 2024 08:02:51 -0600
Message-ID: <20240403140446.1623931-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

There are still a few users of fops->read() in the core parts of the
fs stack. Which is a shame, since it'd be nice to get rid of the
non-iterator parts of down the line, and reclaim that part of the
file_operations struct.

Outside of moving in that direction as a cleanup, using ->read_iter()
enables us to mark them with FMODE_NOWAIT. This is important for users
like io_uring, where per-IO nonblocking hints make a difference in how
efficiently IO can be done.

Those two things are my main motivation for starting this work, with
hopefully more to come down the line.

All patches have been booted and tested, and the corresponding test
cases been run. The timerfd one was sent separately previously, figured
I'd do a few more and make a smaller series out of it.

Since v1:
- Include uio.h in userfaultfd, or it fails to see iov_iter_count()
  on some configs
- Drop (now) unused siginfo pointer in signalfd and the incrementing of
  it, we don't use it anymore
- Add missing put_unused_fd() for userfaultfd error path

 fs/signalfd.c    | 46 ++++++++++++++++++++++++++++------------------
 fs/timerfd.c     | 31 ++++++++++++++++++++++---------
 fs/userfaultfd.c | 44 ++++++++++++++++++++++++++++----------------
 3 files changed, 78 insertions(+), 43 deletions(-)

-- 
Jens Axboe


