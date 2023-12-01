Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE99801156
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378036AbjLAQQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjLAQQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:16:53 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0723210FA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:17:00 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50abbb23122so3252059e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 08:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701447418; x=1702052218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8T3cy8rgEEZrjRntl2zyuqB35X2El/CC72UZNbzDOsY=;
        b=AFR8IualhTZYllj1HacTULlVpbMWXZzIOjQJ8PzT2YaTPnwra6Djlj1nm6f55hnWBA
         cbIhvsTn9M1paNXwg0FhlpNlhffWOey5OfaS1+lSFrVQEKb+9Zw9fCoQeywSoopHkL7d
         lbku44pKhlBKiGIOdjxJvtPERlpqbRgNsovd3ZZqL6QOfeMbdoQcNbOg9yrNwh3SI/xB
         ioza7u6woO9Ib4bKW8Xfl/w0cHuiaHLvdxdmr1UKFoSN6L9NrEA191bVmi24m95Gpb+2
         D0eRcnaV1FIIEALntP6NSGjKT8EP249CHl1SD12xoizsZqKLvN9awHfKzsuNbuDv+fih
         q9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701447418; x=1702052218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8T3cy8rgEEZrjRntl2zyuqB35X2El/CC72UZNbzDOsY=;
        b=XWegOLoTpuoaIBP8uLqESxR5c5lGWh89urB2rJDAFFn7ckenIKH4oVWEZqteL5AJ+s
         0TsuFpv6J/ptJ/CMCX3DlOIegvW5OfH+8zlDsHK/GmXJnI7IxdCQGMs5WnFYbiPVjqP4
         YZj9GayUdOzE740kevn6Cs4XcZW268cjjMPByol8KIm7RTn97/VwNURqr2da9C4Gwk/+
         cw4Ye9r/r4B+qu6R9ersjW8qHKVevtsT4ZCFFRam9A2zg3DsQ3r/HL6RZrpnx74d90yO
         sZq5wI7ew5TpBHCq+CrLCt+q+C3gzUA7wDKAoD3hb4VmVw5g2Dp9c8Vaqzcxiw7xVK1p
         6qWg==
X-Gm-Message-State: AOJu0Yx8+HVdDvA9jGmo9x766QMowbx2D+itpJ45yQFxF6vCySbYi512
        0Gagf/Tial92yyHmzZRzbMUErA==
X-Google-Smtp-Source: AGHT+IHWa6yiW4yOdMoPcmQOVRGPAzzuzOf0mQzGDIhx0xKQxBPgvRsyWwzyP0AnS2rdrwxJMGzn1A==
X-Received: by 2002:a05:6512:239a:b0:509:44bc:8596 with SMTP id c26-20020a056512239a00b0050944bc8596mr1310221lfv.58.1701447418251;
        Fri, 01 Dec 2023 08:16:58 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:6db5:f04:fbd5:88e1])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b003feae747ff2sm9591398wms.35.2023.12.01.08.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 08:16:57 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn,
        qyousef@layalina.io, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     lukasz.luba@arm.com, hongyan.xia2@arm.com, yizhou.tang@shopee.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 0/2] Simplify Util_est
Date:   Fri,  1 Dec 2023 17:16:50 +0100
Message-Id: <20231201161652.1241695-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following comment in [1], I prepared a patch to remove UTIL_EST_FASTUP.
This enables us to simplify util_est behavior as proposed in patch 2.

Changes since v2:
- Add Chinese translation
- Add Tag
- Remove remaining ref to ue.enqueued and move some defines

[1] https://lore.kernel.org/lkml/CAKfTPtCAZWp7tRgTpwJmyEAkyN65acmYrfu9naEUpBZVWNTcQA@mail.gmail.com/

Vincent Guittot (2):
  sched/fair: Remove SCHED_FEAT(UTIL_EST_FASTUP, true)
  sched/fair: Simplify util_est

 Documentation/scheduler/schedutil.rst         |  7 +-
 .../zh_CN/scheduler/schedutil.rst             |  7 +-
 include/linux/sched.h                         | 49 +++--------
 kernel/sched/debug.c                          |  7 +-
 kernel/sched/fair.c                           | 86 +++++++------------
 kernel/sched/features.h                       |  1 -
 kernel/sched/pelt.h                           |  4 +-
 7 files changed, 55 insertions(+), 106 deletions(-)

-- 
2.34.1

