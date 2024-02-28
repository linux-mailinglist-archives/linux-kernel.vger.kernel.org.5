Return-Path: <linux-kernel+bounces-85591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB9E86B814
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CC91F23722
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15AF74417;
	Wed, 28 Feb 2024 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MnkH5c2Y"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764134CDE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148244; cv=none; b=M1spQp6oeMCKQlYjVia51jus84pFB41uVuu7+CvjQeO0yTE1nwzEN16ZBEVXd3P3jp4qqNhXTU5NQKQA00UUaS+7I4KaoaTOROZ30kcKhZ6f1fW72kaBRA/3+/eSm2SZxFF76NuKQSSzvX6nOCEqfa00iJSsIXyXOljq/YDDYqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148244; c=relaxed/simple;
	bh=wDldj/L9sldGrmGC63Ask+odB9JANp2O8Lythy3yAt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oOciVfPpo0fG9Fzb2swayn4qw8ybmzQRAvxG0JlFqs8f2zpQtkXhYrQU3vBcRL1Gr474lOK/SGSHVvQIOBEJ1cEGm3MFy6z7yd/YtGA/9luUBOAakFJhGMeG7QBga7LvTZRWgnJXuptTt5fipn2LjTCKd11Rr6I2GqmkiHjOGR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MnkH5c2Y; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5dc8961f5a9so8690a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709148240; x=1709753040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DemoB3+IC+42EmKa1d98XsfOh62nKrZDSBCsbO4iPSc=;
        b=MnkH5c2Ysvxm41NiZuR56Xx9NrxpcwB/8Tc1nmpYsXprJz2RI2wi2DAai/HQTCz0mv
         oAZ3NMBCysa4vcyvu1dFb8CNPjFBLnVbyv9GXPkevaaTQdbxQ2eQVk24+9DnyJNREA+g
         M1jHMgpq4HSJfKxwTPO7VmL3V3S3y1WF0YiQ6IZKHOKmNcX2uw7HnC69g8KWPOE7ZW02
         W0expWhlScG/6fzc3Q24m5AoNqf+YT1HTUTdCSJaqSoZHfFQnMYMIuWoL+X7OCvonKrM
         lD0YBcYnAUh1MnOTgUQlwnfIiEX/znsd47Fr68mYvOgg08vrcLJDO/nlXyuQsjAQPhA5
         INoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709148240; x=1709753040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DemoB3+IC+42EmKa1d98XsfOh62nKrZDSBCsbO4iPSc=;
        b=lvVF2lfyXMpEwFCTyrAIZGdIqCpyMlT+fvI2c+ySkEdnxwqusPAi0HRHd/YvaYwDxs
         kfuiG8QG66W0cYTr1X2ePYVgv46WZm2QCcIDYTNKoUbMiYrSs9LO2G2TYAd+Mod1fMuB
         vITPz0Q8hJlhHkwGBZkjN2jigpCAo4+NfKRjXIVYcN0QHq5cq049I3OdTHaonpqdV+bx
         SYTS4cKmri3gWLQVg0hUKCjvgf97o+PWGdSvIavMDwbDOS6HB/ZAdyzSLB+pct7zYbdu
         AEbJ7118VBfmnpFV9Rt2MIResqXsnhDTbSskhexra/1gX02U7jcjHm9l5X+wGzpOHERT
         PcEQ==
X-Gm-Message-State: AOJu0Yy3az5A+Zo6+6evLULwcy/D/hw2eo733fFgmyuN70TPXw4bxHVX
	xgkkmkyyb9uOv/pf3QpuapiqIKCG7HXB7BAS3kAkfHC/jKZHgJ4//4EuIG7AyZWq5o63gIEMSBI
	L
X-Google-Smtp-Source: AGHT+IFzMSbFLYKI8r1963+D1i7PRMiM89/YPh6I6yMlja4PmocWiOS5BMIUjwchFI6TS97IHayB0A==
X-Received: by 2002:a17:90b:3906:b0:299:1ae1:51b2 with SMTP id ob6-20020a17090b390600b002991ae151b2mr79255pjb.4.1709148239799;
        Wed, 28 Feb 2024 11:23:59 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a550a00b00298f2ad430csm4230pji.0.2024.02.28.11.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 11:23:58 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com
Subject: [PATCHSET v3 0/2] Split iowait into two states
Date: Wed, 28 Feb 2024 12:16:55 -0700
Message-ID: <20240228192355.290114-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v3 of the patchset where the current in_iowait state is split
into two parts:

1) The "task is sleeping waiting on IO", and would like cpufreq goodness
   in terms of sleep and wakeup latencies.
2) The above, and also accounted as such in the iowait stats.

The current ->in_iowait covers both, with this series we have ->in_iowait
for step 1 above, and ->in_iowait_acct for step 2. You cannot be
->in_iowait_acct without also having ->in_iowait set.

Patch 1 is a prep patch, that turns rq->nr_iowait into an int rather than
an atomic_t. Reasons given in that patch. This patch can stand alone, as
it should not have any functional changes, outside of improving the
handling of iowait a bit.

Patch 2 adds the ->in_iowait_acct stage inside the current ->in_iowait
setting.

I wasn't super happy with the need to grab the rq lock for the one case
where we still need it, and woke up with a better idea of how to do this.
It's all in patch 1. Nice part here is that we get rid of atomics for
3 out of the 4 iowait inc/dec. Patch just follows the same principle.

Comments welcome! Peter, CC'ing you since I did on the previous posting,
feel free to ignore.

Since v2:
- Drop need for rq lock for the remote case by turning both nr_iowait
  and nr_iowait_acct into the difference between a remote atomic count
  and the local non-atomic one.

-- 
Jens Axboe


