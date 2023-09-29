Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631B17B2A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 04:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjI2Chl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 22:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI2Chk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 22:37:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A30D1A1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:37:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f8134eb83so175896687b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695955057; x=1696559857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9fNDjspVJr/ayAsGgaCrOKgIRYGYktlfH6pYdojDtfM=;
        b=Ivy32hzc7tk2DJzZdXEwSSE2BDnFOTDq6lZ66bkwVa0cQZF9iiBYAm3nX5maIB7ZuX
         0eWyuEjhKkRVKLTY9FP9FVv/oSuEmYUm8RhhmYzyXo3EwiAhcQsnh2muGt4q4O9Yb2f5
         dZnht03OSMLY9SwkICuba+hdKh6yKvHD8klLsA+ad3WAgWyutwdKsx8tIHhlP5c3SrR+
         PrHAZoPdbpY1eVzY0GkrQWolhkjgMp69/PFql3m2trLYaDPfPCA1RACKThl//D/mY2Vv
         UAdHDlT7uP1LyyttJ13APKcGsy5l6VbZ8JJ2cIacXsrLPZOB7nghY8/nq1PY0YiZLFwy
         34sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695955057; x=1696559857;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9fNDjspVJr/ayAsGgaCrOKgIRYGYktlfH6pYdojDtfM=;
        b=GQWJAGhHTQWgq9a7tgGpgTjM7MHGkyQsIikYIlSzG1/TyzUDYD12LKipMAmDoW07LB
         c6aJ5VkvAOMce45QL2Cto/wcqnhxy0mh0VH0ws0m/CK+2pvmcHw+yBXJmFMGMX+AuYUp
         8PNz7D8nGTV8tKfQqA2GYtKCbeMpqlau/yuk+CbUrvugz3dvVF/QqtO1nxd0m5f/bwaX
         UNcYbITGOvlHkfEBKhvPmvy/z3PBlzVQWVb+EGbg6By6pM1KYY0WKYGNNCki/a/fCvoV
         5wj4cwqkA2093fKn02fm592f4Qxf9/huxMS6WaJ+xb1C/7lixOh0EjR3fFnHIsK8JZAU
         2GUQ==
X-Gm-Message-State: AOJu0Yza5/hwlwREwimG4GquobV1yv318mNtTYTlhp0zaQLBezFaMfK5
        GSF/XpTdp1VukkgjwYEcloftCti3Vtp0
X-Google-Smtp-Source: AGHT+IH244p4A7/TsBZIkhUS1BEg573rPjXKPmFYA0OVVgZdwGCpQAo30ChlwRAAxjtbecMcVXZ8/tGwPX5e
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a81:ac0e:0:b0:59b:f138:c845 with SMTP id
 k14-20020a81ac0e000000b0059bf138c845mr39421ywh.2.1695955056958; Thu, 28 Sep
 2023 19:37:36 -0700 (PDT)
Date:   Thu, 28 Sep 2023 19:37:21 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230929023721.1610484-1-maheshb@google.com>
Subject: [PATCH 0/4] add ptp_gettimex64any() API
From:   Mahesh Bandewar <maheshb@google.com>
To:     Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>,
        Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current API to get the sandwich TS for the master-PTP clock read
supports only the sys-time sandwich. This is not really suitable for
all the use cases of sandwich TS needs. Ideally it should
allow a choice of a timebase to use for ts-sandwich need. Updating
the existing API [gettimex64()] is not an option since it would
break compatibility.

About the name - This is a superset of current gettimex64. Since 
the timebase for gettimex64 is fixed and is only 'sys-time / real-time'. 
I'm appending "any" to add the choice factor. so gettimex64any() would
give you eXtended time with sandwitch TS of a timebase of your choice.
If there is a better name, I won't mind changing.

The timebase options are -
   CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW, & RAW_CYCLES

Since the ioctl() returns 'stuct ptp_clock_time *', the RAW_CYCLES are
converted into sec = 10^9 cycles, nsec = remainder-cycles basically
ns_to_timespec64. Caller can convert the value into raw-cycles
by using calculations similar to timespec64_to_ns()

The CLOCK_REALTIME option is equivalent of using current gettimex64()
method.

The first patch adds the ktime_get_cycles64() method to support
RAW-CYCLES option. The other timebases already have supporting
methods available.

The second patch adds this new PTP method while the third patch adds the
ioctl support for this method.

The last patch in the series updates the selftest to exercise this new
method.

Mahesh Bandewar (4):
  time: add ktime_get_cycles64() api
  ptp: add ptp_gettimex64any() support
  ptp: add ioctl interface for ptp_gettimex64any()
  selftes/ptp: extend test to include ptp_gettimex64any()

 drivers/ptp/ptp_chardev.c             | 34 ++++++++++++
 include/linux/ptp_clock_kernel.h      | 57 +++++++++++++++++++
 include/linux/timekeeping.h           |  1 +
 include/uapi/linux/ptp_clock.h        | 22 ++++++++
 kernel/time/timekeeping.c             | 24 ++++++++
 tools/testing/selftests/Makefile      |  1 +
 tools/testing/selftests/ptp/testptp.c | 79 ++++++++++++++++++++++++++-
 7 files changed, 216 insertions(+), 2 deletions(-)

-- 
2.42.0.582.g8ccd20d70d-goog

