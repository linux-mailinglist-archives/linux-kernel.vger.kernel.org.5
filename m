Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E9D76DEEC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjHCDYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjHCDYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:24:18 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0305826B2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 20:24:16 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso488439276.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 20:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691033055; x=1691637855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMHqujoTuT0RsHzRdVhgkyPvYcb4Kgnj2rbEthA3RMM=;
        b=jmOMCg3aY1NdBWQ0E/xfB3w00lqf6WPH+O3dT/+EXyF79Cpvo08Pb1daWoPjBSPZT6
         bqocWqfWMdrhrDRwxYzLemMLfNLaTPpNFlqm6gyTOU4N5ITwyrd3vSnmCCD0lcK8XGzR
         5WD5DZc70Rq0qy8ulzg0neW+ZH1ryoSqFeF8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691033055; x=1691637855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMHqujoTuT0RsHzRdVhgkyPvYcb4Kgnj2rbEthA3RMM=;
        b=UOJXTidWeqLqqUy2WqXoPDiXuokPSipCU/pq63EYnLEw7pcNezNX87SAZAHpb0kR44
         TcFDdjDh7B9TF7RKoRLFX1GVKjd+w7veyl2x6htFy/oPkxSt1icbY/TJoxV0lzfACvlD
         0jwSlCJPTpGPNMt83qBjxI4TzzFx9HPcV10AEokTT0f0rCCRuVjWb0YSp2dO0fYeRlle
         xoCZpURvqXE0CZDEU4XyOxmcByh+Xz5HxNeeut+MgUKJCjWA0TgYnUI3oS+c2FVrWjSb
         9ZHCQBehWIvEk6d2kmr1pCjHFUL3MB+NwNEwkNCBkYpRt79x6uAgWyJlkLpZoA2rmI3q
         1HFw==
X-Gm-Message-State: ABy/qLYAPWAK6/GSKgVyLzthoqVjEHjLSbuKwZmbN+rbmA78+5qFU7ko
        SQgeNDiVOhZ1K0aatCI7BZxYvELhM92wkEAKHNs=
X-Google-Smtp-Source: APBJJlH4GRD9/jRuKtgSZb05B9hoqbfTLgpOFvSbSSnZQlEtSIPmV07jQp3NDVVXj0pcInCGMYURSg==
X-Received: by 2002:a25:d401:0:b0:d15:a265:4c43 with SMTP id m1-20020a25d401000000b00d15a2654c43mr18622880ybf.61.1691033054767;
        Wed, 02 Aug 2023 20:24:14 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id a14-20020a02ac0e000000b0042b67b12363sm4535176jao.37.2023.08.02.20.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 20:24:13 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/2] docs: memory-barriers: Add note on plain-accesses to address-dependency barriers
Date:   Thu,  3 Aug 2023 03:24:07 +0000
Message-ID: <20230803032408.2514989-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230803032408.2514989-1-joel@joelfernandes.org>
References: <20230803032408.2514989-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler has the ability to cause misordering by destroying
address-dependency barriers if comparison operations are used. Add a
note about this to memory-barriers.txt and point to rcu-dereference.rst
for more information.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/memory-barriers.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 06e14efd8662..acc8ec5ce563 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -435,6 +435,11 @@ Memory barriers come in four basic varieties:
      variables such as READ_ONCE() and rcu_dereference() provide implicit
      address-dependency barriers.
 
+     [!] Note that address dependency barriers can be destroyed by comparison
+     of a pointer obtained by a marked accessor such as READ_ONCE() or
+     rcu_dereference() with some value.  For an example of this, see
+     rcu_dereference.rst (part where the comparison of pointers is discussed).
+
  (3) Read (or load) memory barriers.
 
      A read barrier is an address-dependency barrier plus a guarantee that all
-- 
2.41.0.585.gd2178a4bd4-goog

