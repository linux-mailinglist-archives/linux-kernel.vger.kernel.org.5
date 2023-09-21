Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B027A9A32
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjIUShH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjIUSgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:36:37 -0400
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB91DAFC3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:32:10 -0700 (PDT)
Received: by mail-ot1-x34a.google.com with SMTP id 46e09a7af769-6bdb30c45f6so1610644a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695321130; x=1695925930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mOW1s/LOhiEKmGFQGGQ/gb7iNiCsFWbcKv8d4ZT/dpI=;
        b=kOux8/8V0qi3LikJmeyi+kgFW4/Yi2d5zbrDwEGQJO45KZK7qlfg5m1hF8N7Cgs8x/
         5aiJdkf+1GwnY4NZROjohnVZVFfS7hjws6FFv9ml5s/HT7h7AxNQGkLI8d9XXDT4RKYH
         C04uH/JIQpzo/IxM6w63tZuJNU/L7dWeYMBcjkQjlIQ7rzJTe99ZYK8OXiQQ15Rzwn0f
         CM0I+Q6nazKSdBMgBzkssnBvH+vXBs27mjn89eSPUWqOe8GETrie03zqoif9VCaq6g4P
         cUeJW4dXt1HBWllPcgMLu8PkjR1vZGKqdcFgL3PYM3jZLIwlGBQQe2ORnlRZMB5Q8IAS
         JBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321130; x=1695925930;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mOW1s/LOhiEKmGFQGGQ/gb7iNiCsFWbcKv8d4ZT/dpI=;
        b=TeWsW8iMuIflpav8N2sgNKsk0AM0e3kYf7ObA6jS67lm/rDxO77efQ4EIflSfa7v7m
         MfrcRbcdnCCA7ebo69g8N+eDeKsWqVMslG0kcey0Z2VV0yndshnWpJ9B8R1vZm3wc37w
         MHAUR/VVHBO0EfIfqYpbLOXfmv/xjem1y1T8E3ocK/SANDb3/cSMtIcPKByuqkxzVnzp
         U+/0cGYPZIhw8Nqq0SnBCHAoidzyc8RgUn15WKTDV6Qx0rCn4AmeD85mo52avAXvTRPN
         z1ZjRKNNAInE9l+k7WIWhluZqIXUoa4w4E9I9M5G3F6ANlVCTzsF6K2Kt00mRCJMIz6p
         dRvg==
X-Gm-Message-State: AOJu0Yzk+KWoOKnETZDebOA5Kpl6ON+XBWIChNmXXs7tbCnMzMRo6NV/
        AuNUi3xY9uKRHy84mDl8noTsCKG5+yElESWR
X-Google-Smtp-Source: AGHT+IFTPKV8hb5qPNKFt3PlKNQhm1PDDliL803lQAuNf6oYVsKA/DfLdwy4CO7/lb7z+piXyQB3c4gswMGqoV1s
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:ae59:0:b0:59b:ebe0:9fcd with SMTP
 id g25-20020a81ae59000000b0059bebe09fcdmr73922ywk.7.1695283861434; Thu, 21
 Sep 2023 01:11:01 -0700 (PDT)
Date:   Thu, 21 Sep 2023 08:10:52 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921081057.3440885-1-yosryahmed@google.com>
Subject: [PATCH 0/5] mm: memcg: subtree stats flushing and thresholds
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to address shortages in today's approach for memcg
stats flushing, namely occasionally stale or expensive stat reads. The
series does so by changing the threshold that we use to decide whether
to trigger a flush to be per memcg instead of global (patch 3), and then
changing flushing to be per memcg (i.e. subtree flushes) instead of
global (patch 5).

Patch 3 & 5 are the core of the series, and they include more details
and testing results. The rest are either cleanups or prep work.

This series replaces the "memcg: more sophisticated stats flushing"
series [1], which also replaces another series, in a long list of
attempts to improve memcg stats flushing. It is not a v2 as it is a
completely different approach. This is based on collected feedback from
discussions on lkml in all previous attempts. Hopefully, this is the
final attempt.

[1]https://lore.kernel.org/lkml/20230913073846.1528938-1-yosryahmed@google.com/

Yosry Ahmed (5):
  mm: memcg: change flush_next_time to flush_last_time
  mm: memcg: move vmstats structs definition above flushing code
  mm: memcg: make stats flushing threshold per-memcg
  mm: workingset: move the stats flush into workingset_test_recent()
  mm: memcg: restore subtree stats flushing

 include/linux/memcontrol.h |   8 +-
 mm/memcontrol.c            | 269 +++++++++++++++++++++----------------
 mm/vmscan.c                |   2 +-
 mm/workingset.c            |  37 +++--
 4 files changed, 181 insertions(+), 135 deletions(-)

-- 
2.42.0.459.ge4e396fd5e-goog

