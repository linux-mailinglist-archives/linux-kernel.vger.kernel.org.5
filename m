Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDF380E343
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 05:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjLLEVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 23:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjLLEVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 23:21:04 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EABBC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:21:11 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-db548da6e3bso5317018276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702354870; x=1702959670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ONh/p/Wi99jlyKQI5jrl4Ov3nhD2kEjeOlQ81xiWKPo=;
        b=ZBhL0dKdw9cui5WILcH68RM2IDfZzIPN6bdKXKffH2Yi8nRt5IHT23xcK5VGMCtsf0
         M4fT7CpaNlvpTSmvENyItXbjqmqpQ7+xcePt4ypEqrz+Z5TBymPQETv3tr4rHO98ncD9
         2QmtNo2yQ8Qc4+I8U6Wnl+5z22qts/wxXyEQTfZwT0sbMvNNAmPW/x9qboAjXzweI4ui
         02sFKAErcEYedid87aykVv2QgvcE/gHw+EWVNObvvTjkKPh+cGQHSPU3djY4gZGwgbxn
         oKwOtAoNAC6tNDw2MNkVQDmdtn9IK4jbZdAXmp5CEVs1BvksUMYI7I8IfdPPL9X5vXwc
         MKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702354870; x=1702959670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONh/p/Wi99jlyKQI5jrl4Ov3nhD2kEjeOlQ81xiWKPo=;
        b=u5rhIa387kAmzll8P6dqkJpDtsvnGykbESMdh6CKQ5pzkjyOx1eijKD8ylScKXH6Xw
         r3otABrrNq1DsbaHHO7Qhv3KQ7A2MFmJy7n3lQcriO8PWfgjvaxRs8bhv1COKePNzC0o
         0F5sfPD8WSb+UHo9EdFB1lC7zMc7LOpKnJIZ3mYH6A0FWJbhy5OgIjYMueYe5MM5r4no
         AWEIcWLbpHkD9dDrI9bqdmCLnprQuXyeSN/3OkcLx7qyl+Q0ZhN11iwDvCoZhlf8WHKm
         erqwJ30aDFSwVY4YDjb6Nf3og64PIkhlaAWSejlZaysZS44mvIJXvmGXxfibcmmM+GSx
         XL9w==
X-Gm-Message-State: AOJu0YwtrR7t8glNwUvFbeKkKAwepHZ0hgNorJfrRwFWf/PE0Ld8wa3o
        wX3XviOIEdSyiFN0ERVgkZvcjd24WrYDhA==
X-Google-Smtp-Source: AGHT+IEAall3TnzSbKofLzRfPjJ3scLkws+CwNJ8A2teJ4Up87GnbLcJQkPaB7CbALHqcuP/TIM+aw==
X-Received: by 2002:a25:9011:0:b0:dbc:af69:6210 with SMTP id s17-20020a259011000000b00dbcaf696210mr1222884ybl.65.1702354870379;
        Mon, 11 Dec 2023 20:21:10 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id a11-20020a5b0ecb000000b00db7dcc2ab76sm2943961ybs.34.2023.12.11.20.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 20:21:09 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 0/7] lib/group_cpus: rework grp_spread_init_one() and make it O(1)
Date:   Mon, 11 Dec 2023 20:21:00 -0800
Message-Id: <20231212042108.682072-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
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

grp_spread_init_one() implementation is sub-optimal because it
traverses bitmaps from the beginning, instead of picking from the
previous iteration.

Fix it and use find_bit API where appropriate. While here, optimize
cpumasks allocation and drop unneeded cpumask_empty() call.

---
v1: https://lore.kernel.org/all/ZW5MI3rKQueLM0Bz@yury-ThinkPad/T/
v2: https://lore.kernel.org/lkml/ZXKNVRu3AfvjaFhK@fedora/T/
v3:
 - swap patches #2 and #3 @ Ming Lei;
 - add patch #7, which simplifies the function further.


Yury Norov (7):
  cpumask: introduce for_each_cpu_and_from()
  lib/group_cpus: optimize inner loop in grp_spread_init_one()
  lib/group_cpus: relax atomicity requirement in grp_spread_init_one()
  lib/group_cpus: optimize outer loop in grp_spread_init_one()
  lib/cgroup_cpus.c: don't zero cpumasks in group_cpus_evenly() on
    allocation
  lib/group_cpus.c: drop unneeded cpumask_empty() call in
    __group_cpus_evenly()
  lib/group_cpus: simplify grp_spread_init_one() for more

 include/linux/cpumask.h | 11 ++++++++++
 include/linux/find.h    |  3 +++
 lib/group_cpus.c        | 47 +++++++++++++++++------------------------
 3 files changed, 33 insertions(+), 28 deletions(-)

-- 
2.40.1

