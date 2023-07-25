Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF11762750
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjGYX3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjGYX32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:29:28 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851A01BDA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:29:27 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7835ffc53bfso11236539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690327766; x=1690932566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XskhyFxausVEKDa69mPrTba2xx/2UiRzs2iaafcHW9Y=;
        b=bxd6mWv0jxIK0mSMvOs0QEkrssoJdAQb9LD2SIJNiQajQ7TI6uSw1o4RpnrZno2+bh
         QhYknwTfmiLZTA1bkJZnjl8LU8KdgSUklfgZkYzXf4GjMJexjyvOwMHom7xXHHcJw1bc
         HcLwaEMCdFJj0zKfzgnAN7didRVNwCr4OhE6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690327766; x=1690932566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XskhyFxausVEKDa69mPrTba2xx/2UiRzs2iaafcHW9Y=;
        b=Xz0GHPw8yyCUMog3Wd7EqbSWlTgw9vSKIXkjGdGGW8ixJp1F9G7cFIMyQCYc0jqmBW
         7A+Vdf4MO7Ak43vILHl5duw4IgxcmAGyaSiKE7BZMEsxYwvcK+JO1SVTmPS0KZWnrMke
         Run3zmBMqMbMHfJMV7fQQ3K9TgXLUJ66tCFHz/T+vDLSeCa/2k8fsXvBMdr6SDlbZ985
         dpzRQcdEukuUh/uus8p7pmZK7DNGUOM7iGo0jMOITf7ImzmrR9Bze6hC76NMVGisajUp
         B7AkBgwueeGkeWBP947H7CX9nYiGeYpcpsWe129E+OBbkc0p7KKJjrBzC0jrc62WWGw9
         LcqQ==
X-Gm-Message-State: ABy/qLaL93OgbbPhUL1mpqz/mhlasRq1vmuSVptXW2YUuLB7fyqzUUz9
        wh98DcDyo+VRHQ7XH1cBPnJTH+s3Yq4ezEQ5vfo=
X-Google-Smtp-Source: APBJJlEXrYsv1laOOOPXu57nHWmEe+B61bHLj+F3QYQrE4VSub6WJkN4PCPEuF++v8DZgNOFsHfxKA==
X-Received: by 2002:a05:6602:164b:b0:785:cac9:2d49 with SMTP id y11-20020a056602164b00b00785cac92d49mr2740006iow.1.1690327766107;
        Tue, 25 Jul 2023 16:29:26 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id m18-20020a02c892000000b0041d859c5721sm3932053jao.64.2023.07.25.16.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 16:29:25 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     rcu@vger.kernel.org, paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 0/5] misc RCU fixes and cleanups
Date:   Tue, 25 Jul 2023 23:29:05 +0000
Message-ID: <20230725232913.2981357-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some RCU fixes and cleanups. The main one is the TREE07 stuttering fix
which makes the test pass now. I am continuing to test these but I am sending
it out for review in advance. Thanks.

Joel Fernandes (Google) (5):
  rcutorture: Fix stuttering races and other issues
  srcu: Fix error handling in init_srcu_struct_fields()
  tree/nocb: Adjust RCU_NOCB_WAKE_* macros from weaker to stronger
  tree/nocb: Improve readability of nocb_gp_wait()
  Revert "checkpatch: Error out if deprecated RCU API used"

 kernel/rcu/srcutree.c  |  31 ++++++-----
 kernel/rcu/tree.h      |   4 +-
 kernel/rcu/tree_nocb.h | 113 ++++++++++++++++++++++++-----------------
 kernel/torture.c       |  46 +++++------------
 scripts/checkpatch.pl  |   9 ----
 5 files changed, 98 insertions(+), 105 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog

