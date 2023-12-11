Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E5D80C3D2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjLKJA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbjLKJA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:00:26 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076BFDF;
        Mon, 11 Dec 2023 01:00:30 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7b70139d54cso135862439f.1;
        Mon, 11 Dec 2023 01:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702285229; x=1702890029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wju9poNbHmK4kTzadequgCrVsBMHqrILz+bPct1uH60=;
        b=Thmus4s4VYtAGAGWKx3d/GJPh/WkJ7pm/GAnowWwqr8EqKd0bC7ngS2xegcANthEWX
         hEH7O+p2W4APjEegT6cHpjIHekG+Ez2fq++QSrhLjTmhK8zgx48qYjjsWIVF4Xw4tfmr
         9ltqibSrlRLX2BGrhZm6yt3XIo9gPmCqLFgLDytOChhGsQs7i+ALnEp0K48u6em547jm
         ySVOtKHC86FZ+TcsWVfb5AftYFBPEb6l3wi73QOD0SRK/Gl8MhIyi1Tyf/eD1vdQT6gz
         2F5tde7JBWMEyGsm0mvInpYbiSPbTkzmFsyeV5IFTYwBTI12jd3wtQ3JfKTTtqbEfg8g
         fn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285229; x=1702890029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wju9poNbHmK4kTzadequgCrVsBMHqrILz+bPct1uH60=;
        b=jVI/8g4z7+cyUF2aorm7njBOtJziuoITk24MZR15Jw2Nv5RQIfQr9ZRPH7a4R9XtGi
         vTNhSWAGUCC1OEPfgLTQFvBYxDhqjd+b3zLjdiEzUcdzPGdJRz8mEBFJFY9YJSWwrDZv
         aPmxOuli21suY96E00rVZQ3OnG1M/rb+btZT9Fe3BaOGlu4E7CHZP2mSeWF1CT0ooats
         7cfueyqXb7yAFT955LcQt9gNzZEaFctjWdXLBwjd3Xn5uPN2xKQumMnZF68eGlbmliHD
         vpuz5fh2bSLow5GsDpyWxMaSIxk/UEddi3N5kg1qNChDVxjwzIJbWri6Gr/U3S36MAT/
         mTJg==
X-Gm-Message-State: AOJu0YzQjRT4w9k1CylRAd07A70SroTPyo6AionNqzY+nYfiUNQnPuha
        wYAuMSVHEsGsAQM8QV4e3t4=
X-Google-Smtp-Source: AGHT+IHIe+3rcfUvNTZxne5xKhXuPdaWNBjzuNkIH8cHvulBBZYJkOFjOqXZffDOmywwrKNKMPAmHA==
X-Received: by 2002:a05:6e02:1e04:b0:35d:6d3a:7818 with SMTP id g4-20020a056e021e0400b0035d6d3a7818mr4353004ila.9.1702285229286;
        Mon, 11 Dec 2023 01:00:29 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id f14-20020a056e020b4e00b0035b0b05189bsm2211216ilu.38.2023.12.11.01.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:00:28 -0800 (PST)
From:   Hongyu Jin <hongyu.jin.cn@gmail.com>
To:     agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        axboe@kernel.dk, ebiggers@kernel.org
Cc:     zhiguo.niu@unisoc.com, ke.wang@unisoc.com, yibin.ding@unisoc.com,
        hongyu.jin@unisoc.com, linux-kernel@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Subject: [PATCH v3 0/5] Fix I/O priority lost in device-mapper
Date:   Mon, 11 Dec 2023 16:59:55 +0800
Message-Id: <20231211090000.9578-1-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <df68c38e-3e38-eaf1-5c32-66e43d68cae3@ewheeler.net>
References: <df68c38e-3e38-eaf1-5c32-66e43d68cae3@ewheeler.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongyu Jin <hongyu.jin@unisoc.com>

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
  block: Optimize bio io priority setting
  dm: Support I/O priority for dm_io()
  dm-bufio: Support I/O priority
  dm verity: Fix I/O priority lost when read FEC and hash
  dm-crypt: Fix lost ioprio when queuing write bios

 block/blk-core.c                              | 10 ++++++
 block/blk-mq.c                                | 11 ------
 drivers/md/dm-bufio.c                         | 36 ++++++++++---------
 drivers/md/dm-crypt.c                         |  1 +
 drivers/md/dm-ebs-target.c                    |  8 ++---
 drivers/md/dm-integrity.c                     |  7 +++-
 drivers/md/dm-io.c                            |  1 +
 drivers/md/dm-log.c                           |  1 +
 drivers/md/dm-raid1.c                         |  2 ++
 drivers/md/dm-snap-persistent.c               |  5 +--
 drivers/md/dm-verity-fec.c                    |  5 +--
 drivers/md/dm-verity-target.c                 |  8 +++--
 drivers/md/dm-writecache.c                    |  4 +++
 drivers/md/persistent-data/dm-block-manager.c |  6 ++--
 include/linux/dm-bufio.h                      |  6 ++--
 include/linux/dm-io.h                         |  2 ++
 16 files changed, 69 insertions(+), 44 deletions(-)

-- 
2.34.1

