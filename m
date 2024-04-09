Return-Path: <linux-kernel+bounces-137212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C14889E011
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48A97B26495
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495801369B1;
	Tue,  9 Apr 2024 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="P0t9ALNa"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE2E131180
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676283; cv=none; b=R3eVBp3gCyBp1aQAYEoYefGu3L0ja0/wo40MenMaPjEAcBwHAVETNo7HLYv084cFEG888TIz96DgGJSBsYclK9erFYmgc0/Ptk/EpZXabXZnUWJGVXTewOFw/BcvOfHtdVJ4NT8m9PE7ECxDnHL1ftsbV3gdxsULCxlvqMUrEmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676283; c=relaxed/simple;
	bh=7BLajVZFd0QKk5l7C4doy3ipUMapbfe/gYRUU4rDJQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EbOoa2oFYd7BiQ2CGipJEQt2T5o5hXRlQ9pHAjAQkSabVVL1e9fTztywtSXxSQ+CguQ6LTC1ZlUJMCqcmvTNqq+RGptU4k3KcIC3t+wg0jOi/ZFhEISSlO5wBYuXOfZoPb1FGMMorKGmsgT3q8rUyHf4WuYiOygRh1M3NZc3uO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=P0t9ALNa; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a52b2ed8c9so466682a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712676281; x=1713281081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qDJXJ51rzP1aYXUKz2+GObI2WIW0feKWF6cd4rFM5KU=;
        b=P0t9ALNazlqVqJ0zMCVjmhPIdSpBeIbh50qj9wozyG7+C15z40VnHBqtNfVraQ3ztm
         coJVNJBztLnUALHLDhevJ/2AwwwvtIZT7MDxuWRte3ZrWSUgfoqs3bYI31f/8qbK0uXk
         TQB/TN8YJ38dM5U5Yp4M1/bEbKRKeSSoDDUMrN1NMu915DvIPifBldA7YvYojm/gJlnn
         LczFaIVlIv5iilv4TL6Ofyhpy7Ml7sU2q5qvg5rPeVEpJZbBYqZYhQs6EBJgfFCXGV2W
         wDM/RWcsN5n3hK0DDnJugeqrhsRHXrGl4o7AkqZcqtrVkXzLvDYth3FRkJdwN1pRhR9M
         C18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676281; x=1713281081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDJXJ51rzP1aYXUKz2+GObI2WIW0feKWF6cd4rFM5KU=;
        b=Q/kya2Xo9nRNZUDDoFcWsBmWUye/Es0yL88sS4kf8diZPlzeDcVbPSaWoWfAi5LbxH
         whD1yJPEzPL+of+5kPO3qeQ0DxFthSqrz8he3tt8206XkvXhdHrETibefQlVJieGVjrZ
         C9AcVqxLNYVACTDvBENpAhvQlEHaK9W+SFKzrjh1jCH0QGe8guQdLW2Lv8g/UmK9HOBa
         xC0DtMiFeQmMUuKHmSFK4M4IuBzI8KJkZVyV7BPY0OVztGcb8XO463if+pojaj/CADmk
         +qS1X20Xkh0pwBax5C20x05uji18j5VgNPrERIpexbjVzUO8m+zEsAhvh2v8eJOws7my
         HTeA==
X-Forwarded-Encrypted: i=1; AJvYcCXzFhIAGiyNp5ywioGwPfsrFiPDFiaVeldkTF0CqOoGfHtZbRtp5J4BUjrzK78ZyOeZmqNYVryELBVYVkswJab0Lv4xti6LQ82aQ7lc
X-Gm-Message-State: AOJu0Yzj4i/xS6JVxd5PGhFmOvh9PKWje1880sQ74NttvLTJNwbdbN13
	92KhuIU1e3aJuCI+VUpfjL29xFYT5gebU0JqrZilFafKdVx62VrL5CkrpO4Zl08=
X-Google-Smtp-Source: AGHT+IGIP3a+pt+XzlPtW5+4qBhJEScnL/xM2e5DEQUmMepw7bO/QGd1541AD8a4Tz+W/drzk1SXuA==
X-Received: by 2002:a17:90a:c695:b0:2a4:949f:3220 with SMTP id n21-20020a17090ac69500b002a4949f3220mr9216053pjt.3.1712676280958;
        Tue, 09 Apr 2024 08:24:40 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id ev6-20020a17090aeac600b002a513cc466esm3945558pjb.45.2024.04.09.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:24:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCHSET v3 0/3] Convert fs drivers to ->read_iter()
Date: Tue,  9 Apr 2024 09:22:14 -0600
Message-ID: <20240409152438.77960-1-axboe@kernel.dk>
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
cases from ltp have been run.

Since v2:
- Pass appropriate flags to get_unused_fd() and anon_inode_getfile().
  Doesn't change anything, but it does convey more closely what each
  of them look at.
- Add copy_to_iter_full() helper and use it for all conversions

 fs/signalfd.c       | 44 ++++++++++++++++++++++++++++----------------
 fs/timerfd.c        | 33 +++++++++++++++++++++++----------
 fs/userfaultfd.c    | 44 ++++++++++++++++++++++++++++----------------
 include/linux/uio.h | 10 ++++++++++
 4 files changed, 89 insertions(+), 42 deletions(-)

-- 
Jens Axboe


