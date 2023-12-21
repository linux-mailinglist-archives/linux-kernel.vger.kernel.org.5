Return-Path: <linux-kernel+bounces-8202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9542281B396
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA8A1C243D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38D965A87;
	Thu, 21 Dec 2023 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLwiDAot"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A146473E;
	Thu, 21 Dec 2023 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d9338bc11fso593102b3a.1;
        Thu, 21 Dec 2023 02:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703154710; x=1703759510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3txwa/c9776nsY8G7pkBt0algA+V8V5O9TtP4wNx04=;
        b=ZLwiDAotvzoSDw8CeJ+aYzx5p7fwCFSsUXce7Z7P+YvptOA10Bs1+/KME3fEVbZWd/
         aDn7szuXoRAGd1omZiFncn4QExlFvd6h0KVqKDeu7rmU5NQDrCx87tkId4gVhjiCXc+F
         yifBlKiLZcK9nfFA74d6H5TTqyHIgaTDksbEacmAcn4zgYGjbHbI0boMd8AdJ7N36Shw
         aJVMp6VDDoZDHqJO7vPQPHww6Qn7VnoeafUCpK+IlC3dbH8PtgpXvkpotIAErCPdqRwK
         FCsH9zYpVj7+w+ObaIL8W5FqoeuRo28W1e8GWOTOVXvoPvEASPpuXYmQ/a6/om6Q/fga
         UzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703154710; x=1703759510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3txwa/c9776nsY8G7pkBt0algA+V8V5O9TtP4wNx04=;
        b=SwJNv6MB851N4zANJ7iF5U76qdtMKqQjagvdlMjVU+0rnFM6iYpKcbxWVAtvq/I+w9
         P/XWKlgSzhaqi66Dx5xYAGgjpmMIq7Q1FEPK0DTKxdr/OsJIhbBBBijdp8AAPw4CV4bQ
         abgj8ydUgTs2AzvpKe4AQ+0JCPrlMJchIAbrP32q+y2k7LohCy5LHgsYM0ny7KMp37wd
         ULn9YBdkLXDUMvexIDcwbvM7NgJELhAUnaSW7ZW1sUQ4pQ2rG0cGCN5G7qo1yXQqqJeC
         2qo/szZTWGfYTD2Z233SidVfpb8w98x2mb1P3+9lNlvTTEdI6AgErx6wCnxF4wJ5LJhN
         AR5A==
X-Gm-Message-State: AOJu0YycVQvohwCRPvMGCj27XMb6pRBgJ26o4sGrZI9zE7vSDrDY/wkL
	TnSluDVMR0/7hXKx3fXdcy8=
X-Google-Smtp-Source: AGHT+IHqqsd5dS5VG1PZPadONMtL8cC5ZqjsRAgoLSdOgKER9eZKzkyU//MGHM71lYYtq/LyyRjmCw==
X-Received: by 2002:a05:6a20:5b12:b0:18b:e5f7:25c5 with SMTP id kl18-20020a056a205b1200b0018be5f725c5mr1146242pzb.11.1703154709613;
        Thu, 21 Dec 2023 02:31:49 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a25-20020a634d19000000b005c6617b52e6sm1274539pgb.5.2023.12.21.02.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:31:49 -0800 (PST)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	axboe@kernel.dk,
	ebiggers@kernel.org
Cc: zhiguo.niu@unisoc.com,
	ke.wang@unisoc.com,
	yibin.ding@unisoc.com,
	hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH v7 0/5] Fix I/O priority lost in device-mapper
Date: Thu, 21 Dec 2023 18:31:34 +0800
Message-Id: <20231221103139.15699-1-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220100333.107049-6-hongyu.jin.cn@gmail.com>
References: <20231220100333.107049-6-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Jin <hongyu.jin@unisoc.com>

High-priority tasks get data from dm-verity devices via RT IO priority,
I/O will lose RT priority when reading FEC and hash values via kworker
submission IO during verification, and the verification phase may be
blocked by low-priority IO.

Dm-crypt has the same problem in the data writing process.

This is because io_context and blkcg are missing.

Move bio_set_ioprio() into submit_bio():
1. Only call bio_set_ioprio() once to set the priority of original bio,
   the bio that cloned and splited from original bio will auto inherit
   the priority of original bio in clone process.

2. Make the IO priority of the original bio to be passed to dm,
   and the dm target inherits the IO priority as needed.

All changes are based on master branch commit 2cf4f94d8e86 ("Merge tag
'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi")

Changes in v7:
  - Modify patch 4: change dm-verity-fec.c
Changes in v6:
  - Rebase patch and resolve conflict for patch 1, 3, 4
  - Modify patch 4: fec_read_parity() follow the priority of original
    bio
  - Update commit message
Changes in v5:
  - Rewrite patch 2, add ioprio parameter in dm_io();
  - Modify dm_io() in patch 3 
Changes in v4:
  - Modify commit message by Suggestion
  - Modify patch for dm-crypt
Changes in v3:
  - Split patch for device-mapper
  - Add patch to fix dm-crypy I/O priority question
  - Add block patch to review together
  - Fix some error in v2 patch
Changes in v2:
  - Add ioprio field in struct dm_io_region
  - Initial struct dm_io_region::ioprio to IOPRIO_DEFAULT
  - Add two interface

Hongyu Jin (5):
  block: Fix bio IO priority setting
  dm: Support I/O priority for dm_io()
  dm-bufio: Support I/O priority
  dm verity: Fix I/O priority lost when read FEC and hash
  dm-crypt: Fix lost ioprio when queuing write bios

 block/blk-core.c                              | 10 +++++
 block/blk-mq.c                                | 11 -----
 drivers/md/dm-bufio.c                         | 43 +++++++++++--------
 drivers/md/dm-crypt.c                         |  1 +
 drivers/md/dm-ebs-target.c                    |  8 ++--
 drivers/md/dm-integrity.c                     | 12 +++---
 drivers/md/dm-io.c                            | 23 +++++-----
 drivers/md/dm-kcopyd.c                        |  4 +-
 drivers/md/dm-log.c                           |  4 +-
 drivers/md/dm-raid1.c                         |  6 +--
 drivers/md/dm-snap-persistent.c               |  8 ++--
 drivers/md/dm-verity-fec.c                    | 21 +++++----
 drivers/md/dm-verity-target.c                 | 13 ++++--
 drivers/md/dm-writecache.c                    |  8 ++--
 drivers/md/persistent-data/dm-block-manager.c |  6 +--
 include/linux/dm-bufio.h                      |  5 ++-
 include/linux/dm-io.h                         |  3 +-
 17 files changed, 102 insertions(+), 84 deletions(-)


base-commit: 2cf4f94d8e8646803f8fb0facf134b0cd7fb691a
-- 
2.34.1


