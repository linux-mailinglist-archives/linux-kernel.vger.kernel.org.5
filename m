Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A1C809282
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443903AbjLGUi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGUi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:38:56 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2631713
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:39:03 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso1437567276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 12:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701981542; x=1702586342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0nqkFu7e/a89gcQ+5bKDtMmMoDf4cXbjeDawa75MYo=;
        b=k8DXPu/a47RcjSNVg6zJu4tQtfglRyieZSADUTSV3apRwl7NArYMXEsVXtG+vyqtK1
         9IOoqSNgcFhqVLcS98QLbbfWNUw9eGd1biry/0pc7M7Zucy1+QlbD8qXo0LzCs37mBMG
         /keBWrhUCHfshacS4O4azIFZ3uQsrSQwovLgDycmVkqH+mo2zqXeVtuNKLXPmo6ixv3D
         4QyEs6PjERiQY6enw1kRSbgSS2YNA+enTeVh1Vac554qVjrNR1cyCcZKSOcSxn9I15QI
         oyNPQYAPIEw7KE/suEKNIzaAeI5jIrjqV4uUZ5UjInn7FQ2FIenkfsZKbu3dRPUxMDBt
         voUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701981542; x=1702586342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0nqkFu7e/a89gcQ+5bKDtMmMoDf4cXbjeDawa75MYo=;
        b=PGX6nuW1G0OQS06pK1RDBBhl1J9ZaXyDXGVdNu6UV5wPXLQNKGGliaNa0mwvOujF3O
         Jm5g1V/A78I9JyL24yRj9CwQ8bj1GtOmEOI1s+8yeVJoksLzMXPKj4YHDC6CLXJ1PqAc
         WGfSM7dMisSZKKy9CSG4+fxiOvfoJwTnNZXvWjM2lRnB3fC7v8f85DUXsITfrfEq/g83
         V71RtO5LqX7i8NdSCAh73lhHDR1tJ3Us5DXQTvGwA53fGqRpgJX/s5nlqRENg41htG2S
         CFAxZzX37YDPK4qeIIdxIpwSSkI30hnCFPTYs0hjxlcx+Zp2j0pFGPbeV0r4Cjm5olaD
         0mCA==
X-Gm-Message-State: AOJu0YwAPO1dusjXEUVxy2od06rU5/HESqL5NCEK3VNriT9p0WSPIDiS
        OkTrbSDT2eTn0JmTX/X7ei4=
X-Google-Smtp-Source: AGHT+IFnaQcVyYMMYmphChZydtsRUMu/k+z+cN9goYJ2Ko8K29V+/xvKjeO4fAYTCRKqK3GHjo7NOw==
X-Received: by 2002:a25:2541:0:b0:db7:6630:be4b with SMTP id l62-20020a252541000000b00db76630be4bmr2235384ybl.55.1701981542488;
        Thu, 07 Dec 2023 12:39:02 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:8f7f:efcd:5388:af4f])
        by smtp.gmail.com with ESMTPSA id e82-20020a25e755000000b00d9ab86bdaffsm146662ybh.12.2023.12.07.12.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:39:02 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 0/6] lib/group_cpus: rework grp_spread_init_one() and make it O(1)
Date:   Thu,  7 Dec 2023 12:38:54 -0800
Message-Id: <20231207203900.859776-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
v2: add few more optimizations (patches 5-6)

Yury Norov (6):
  cpumask: introduce for_each_cpu_and_from()
  lib/group_cpus: relax atomicity requirement in grp_spread_init_one()
  lib/group_cpus: optimize inner loop in grp_spread_init_one()
  lib/group_cpus: optimize outer loop in grp_spread_init_one()
  lib/cgroup_cpus.c: don't zero cpumasks in group_cpus_evenly() on
    allocation
  lib/group_cpus.c: drop unneeded cpumask_empty() call in
    __group_cpus_evenly()

 include/linux/cpumask.h | 11 ++++++++++
 include/linux/find.h    |  3 +++
 lib/group_cpus.c        | 47 +++++++++++++++++++----------------------
 3 files changed, 36 insertions(+), 25 deletions(-)

-- 
2.40.1

