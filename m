Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB4B7A25D0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbjIOSbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbjIOSbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:31:38 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80246210A;
        Fri, 15 Sep 2023 11:31:33 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso378761fac.0;
        Fri, 15 Sep 2023 11:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694802693; x=1695407493;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+RgYCzFpl6DzKu9Fze9sl7wbETYZX6GdWsejgca91oM=;
        b=abn/NDPM7ucaLRj5kSjyVq3w2Z7nO6Hg0QNtae6KmJpINEA5MhAW8Vc8YsFAL6UrJk
         V17DPN7aG9xR9DWAwjpVng3EPwP9F/rQtwiLTvWYp2JO+oj0opyf2Pz8+loGwadrfjE5
         ZKW6hcmLHVAt4I60zfR0KWkyWyhMdF8AUwwxlL5SN50BZj8drEjpAydLMJEiDV0d/6rD
         JlF7hIvVyRa/6Dg0H6UzzXNpgmyT0jwks2BvlmGd9nhoebulsJyeadwMldDOTjfQ1aza
         aoEHDG1S6i4qLEP4Awim/IqoPIViQjO3q35RheEZqGVm7hL3JZ53+2/IfGrkJuOncTFK
         YBCw==
X-Gm-Message-State: AOJu0YxEoVZhTiLcschkgu0owquex1CTnkbBJulC2h6p4ujBGpDBg6pP
        0WZRlbTO+nzU70zog0lhNMfX0+cT61WcRv1/JfI=
X-Google-Smtp-Source: AGHT+IH0z5TeQlSLJyYiHcsKw5LugzfwbV7Mem0ZGYRa6hbzNsCnfaaIkdZb6q3zjat9j3l+CU1Fnmm84htOZKgTcx0=
X-Received: by 2002:a05:6871:686:b0:1d5:f814:56a3 with SMTP id
 l6-20020a056871068600b001d5f81456a3mr2676714oao.2.1694802692675; Fri, 15 Sep
 2023 11:31:32 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Sep 2023 20:31:21 +0200
Message-ID: <CAJZ5v0i4qvW-4=erNtMn=awuzHZM9YhUmuEuCiD9OOqNrA3Y4w@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.6-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.6-rc2

with top-most commit fb2c10245f201278804a6f28e196e95436059d6d

 thermal: core: Fix disabled trip point check in handle_thermal_trip()

on top of commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d

 Linux 6.6-rc1

to receive thermal control updates for 6.6-rc2.

These fix a thermal core breakage introduced by one of the recent
changes, amend those changes by adding 'const' to a new callback
argument and fix 2 memory leaks.

Specifics:

 - Unbreak disabled trip point check in handle_thermal_trip() that may
   cause it to skip enabled trip points (Rafael Wysocki).

 - Add missing of_node_put() to of_find_trip_id() and
   thermal_of_for_each_cooling_maps() that each break out of a
   for_each_child_of_node() loop without dropping the reference to
   the child object (Julia Lawall).

 - Constify the recently added trip argument of the .get_trend() thermal
   zone callback (Rafael Wysocki).

Thanks!


---------------

Julia Lawall (1):
      thermal/of: add missing of_node_put()

Rafael J. Wysocki (2):
      thermal: Constify the trip argument of the .get_trend() zone callback
      thermal: core: Fix disabled trip point check in handle_thermal_trip()

---------------

 drivers/acpi/thermal.c                             | 2 +-
 drivers/thermal/thermal_core.c                     | 6 ++++--
 drivers/thermal/thermal_of.c                       | 8 ++++++--
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 3 ++-
 include/linux/thermal.h                            | 4 ++--
 5 files changed, 15 insertions(+), 8 deletions(-)
