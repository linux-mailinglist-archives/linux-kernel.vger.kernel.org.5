Return-Path: <linux-kernel+bounces-31334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B305B832CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 434DDB2446E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F16B54F87;
	Fri, 19 Jan 2024 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcJYriy7"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FEE54BEF;
	Fri, 19 Jan 2024 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680153; cv=none; b=LgZY6eqqbxsYq+JdlWTU8i+A6xHdMPyBKpbIpOJDDSFED+sHtuGbDPrUIBOqVw6OBRubibnuUXhy6URQT1eB8izGBKrjtRPdyW7m356LTN5F1+w7qMoIbgeYdC/wJL72vsOPpzd+Rs0/JwwTEtA8rSOUOHwX7lMtVbQItU6Bhw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680153; c=relaxed/simple;
	bh=OBALHD6dMCTH8DfGXAMz3ycEswsgVRPYGo911qlJ3vI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pqEv/LbQOAt9FyK2dt2ZhbNhBb3HxTgzOe1H+Ho12GOQjjBPcRhIDuh7ydCWeCA9DFxvwn/REFMB9GuujGHsJUNE0/LkOibuq7RPDbCfOR992siA75V4dP98KWwBCXAtW7CDOFnDJgvWJVJp298AI36atJyaEe3V6HaH8yp5RYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcJYriy7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ea045f29eso5066915e9.1;
        Fri, 19 Jan 2024 08:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705680150; x=1706284950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PNhgjieyuAkb21sM/cZK8/j108ZNnyV1mN/DwFWKB88=;
        b=NcJYriy7rWffU/IOtM/6RyBtYT0cq2dFtzIb6E/GOsifM4+fQGyNpIQWo+LmIVO+AY
         /jctU+Jn5+RKH7kkXckNRQkp7xQ/EEb2SOXEWFkxix726IyqP1IAxAV8yUp+UzpYC235
         u0XpEJLkSi0uAVkdNQV55xSQd+U5YT9v60Oi5TDoHQNCaSmBX5tAMQzBXmG+eBqzRNjt
         H5KnXgOeQWqZAuDspIi9h9urX69yqQ6ECIj/7kf6z2gYgCTsIUbuZNNWo5IVHqc4ggww
         S2AL+eLKHjmtrIo771tZ+IxJKBWCAxZ07zIxFg6f840+lPSeaI3WKAAC+mXes9Ejr5fT
         kwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705680150; x=1706284950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNhgjieyuAkb21sM/cZK8/j108ZNnyV1mN/DwFWKB88=;
        b=FI/RigAhauFLsmd1UnbEB+EXQtMRmYZOSPlu22fw6RQ6EtuM6u8ci3pEfwNxWsLUEq
         Wx/PbLyT2pYxeAI9OO45FErPMV4ZSUCTxPRq6RX4BM47qRQalNgNOgjd6tg3lu2wiinP
         qDdvoJQT8iULEqn8O42V79A+siqTbjjvJCI8Lav+P7qTgiXVKwHGt/vU7+erb1QG+qc5
         4xBbvYuXbfgjI006dyd+EZavUzLc422kh7vnyc1rSDCioM4t/aHHElPSWYnIzNakS6wE
         rpRarwtZhZw1vpnRdKf5GfipIpzIAwRyxYbgyOWrK6OAn570EZqjxcbFRFqsVq7WEvTW
         YiBQ==
X-Gm-Message-State: AOJu0YwF2saWOPny6EijwXfaYAHArcm9FD1M5JhC8nE9JDZF+QycSjhi
	YqbiZE8OiyXGVs3yBMRSBFkdGz0cbKI2qFm9TAEUlRJEUZ2sC5jv8RSuveff
X-Google-Smtp-Source: AGHT+IH17xwS+VX7IP2KqqJdqwz/V7lQvx/CZzlQo7ZH6AJMSviV4KcM64dg3YVsL3j85kegIeTPUg==
X-Received: by 2002:a05:600c:6988:b0:40e:632d:d6c with SMTP id fp8-20020a05600c698800b0040e632d0d6cmr1652628wmb.113.1705680150367;
        Fri, 19 Jan 2024 08:02:30 -0800 (PST)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c3b9200b0040e4ca7fcb4sm29631823wms.37.2024.01.19.08.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 08:02:29 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.8-rc1
Date: Fri, 19 Jan 2024 17:02:08 +0100
Message-ID: <20240119160212.1466841-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:

  Linux 6.7 (2024-01-07 12:18:38 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc1

for you to fetch changes up to 2a965d1b15d28065b35ab4ebd1e51558fcd91aa5:

  ceph: get rid of passing callbacks in __dentry_leases_walk() (2024-01-15 15:54:54 +0100)

----------------------------------------------------------------
Assorted CephFS fixes and cleanups with nothing standing out.

----------------------------------------------------------------
Al Viro (2):
      ceph: d_obtain_{alias,root}(ERR_PTR(...)) will do the right thing
      ceph: get rid of passing callbacks in __dentry_leases_walk()

Eric Biggers (1):
      ceph: select FS_ENCRYPTION_ALGS if FS_ENCRYPTION

Venky Shankar (1):
      ceph: reinitialize mds feature bit even when session in open

Wenchao Hao (1):
      ceph: fix invalid pointer access if get_quota_realm return ERR_PTR

Xiubo Li (7):
      ceph: skip reconnecting if MDS is not ready
      libceph: remove MAX_EXTENTS check for sparse reads
      ceph: try to allocate a smaller extent map for sparse read
      ceph: fix deadlock or deadcode of misusing dget()
      ceph: rename create_session_open_msg() to create_session_full_msg()
      ceph: send oldest_client_tid when renewing caps
      ceph: remove duplicated code in ceph_netfs_issue_read()

 fs/ceph/Kconfig                 |  1 +
 fs/ceph/addr.c                  |  8 +++++---
 fs/ceph/caps.c                  |  9 +++------
 fs/ceph/dir.c                   | 21 +++++++++++++--------
 fs/ceph/export.c                |  2 --
 fs/ceph/file.c                  |  8 ++++++--
 fs/ceph/mds_client.c            | 35 +++++++++++++++++++++++++----------
 fs/ceph/quota.c                 | 39 ++++++++++++++++++++++-----------------
 fs/ceph/super.h                 | 14 ++++++++++++++
 include/linux/ceph/osd_client.h |  7 +++++--
 net/ceph/osd_client.c           | 17 ++++-------------
 11 files changed, 98 insertions(+), 63 deletions(-)

