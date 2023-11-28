Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A204D7FB372
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjK1IAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343948AbjK1IAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:00:32 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E90398;
        Tue, 28 Nov 2023 00:00:38 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507bd19eac8so7027545e87.0;
        Tue, 28 Nov 2023 00:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701158436; x=1701763236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sXgkabWPWWrKEjUt/Yjs0Jzo4D39WGJcrPl/SCiu+wc=;
        b=Zw6ht3lus9WVxj4EReCZmfDJqDM4ooR9PKj7RnPPBmWPHgooU8vWxpfJU9pEsnjnSb
         zcAX319/wVETTECjWlp4/yR6GBkwoF/vPkGNep6BRVy+0awCCtVbr0GiLtu/SigDUKvB
         1oQ2uAQskQFESmkXUZ02x6cTZ1mLRxC8H35gMM5LfOiTOk2x3ThNAEnYpX3mjaD+XpDQ
         3FJhl2X/Ga9Z64ONSF/TNATX+qqj/19mtLyASWjvxJlTAt/yZzNbLhMguDnVJgyTLujx
         MZUt11p1nSuVgNpugOJUyfodKeQB7qPj4qynRp36Kcw+qbW5tTbkO6L6KQyXK7GZ2kJE
         S36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158436; x=1701763236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXgkabWPWWrKEjUt/Yjs0Jzo4D39WGJcrPl/SCiu+wc=;
        b=n63toIpkWwNc0QadVMd88oLXYoR6/tmldWv+czfifj2WqHCUcsxdlQNrC7aOEMkgQw
         mW9J7Ijxkat1sPInilLCE+useYSdeFNW+I+sRqZg0aKisNOcoCgc1EmFa3yLaSRIlV7T
         O1GKHC88D3Yl1iFkl6X6EK+Ol4j2+HN6ri3UKtLwjxBua7ijNUwS6YcgNrl4FTaohbtV
         dZSHe3nNLhFVCeLvcssFF6fx41M/4x6VNKTrl4CZ/wnA/UF1u4ltdTc7tT/sXqiBXsNw
         xpJxvIY/6O/Hm3ugOx+soropJZPMo/qDBNo7e9QfnFpAE0H8GMk9TdJb1mYLXcY6bhJd
         tnPw==
X-Gm-Message-State: AOJu0YwkZr5W8pEUCS0d+Fc06iIgK5AD5d4qW7fK7AhRXPcbVYmfC157
        dX/ljUMe+5T5ksM1RnIse+4=
X-Google-Smtp-Source: AGHT+IFPGqGXyxIsJsMGqCg5E9k06g+0nGsGq4x6FZaIx6u8EFCe6tESJcWwYAbvyBgGi4rwwvES4A==
X-Received: by 2002:ac2:44b2:0:b0:50b:c027:70f with SMTP id c18-20020ac244b2000000b0050bc027070fmr7lfm.21.1701158435942;
        Tue, 28 Nov 2023 00:00:35 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id o16-20020ac24bd0000000b004fe202a5c7csm1765501lfq.135.2023.11.28.00.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:00:35 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v3 0/7] Reduce synchronize_rcu() latency(V3)
Date:   Tue, 28 Nov 2023 09:00:26 +0100
Message-Id: <20231128080033.288050-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This is V3.

V2 -> V3:
 - use dummy wait node to eliminate cache misses during a full llist
   scan to obtain a tail node;
 - add CONFIG_RCU_SR_NORMAL_DEBUG_GP Kconfig for a GP incomplete debug;
 - move synchronize_rcu()'s main control data under the rcu_state struct;
 - add rcutree.rcu_normal_wake_from_gp parameter description to the
   kernel-parameters.txt file;
 - split functionality into several patches.

V2: https://lore.kernel.org/all/20231030131254.488186-1-urezki@gmail.com/T/
V1: https://lore.kernel.org/lkml/20231025140915.590390-1-urezki@gmail.com/T/

Neeraj Upadhyay (1):
  rcu: Improve handling of synchronize_rcu() users

Uladzislau Rezki (Sony) (6):
  rcu: Reduce synchronize_rcu() latency
  rcu: Add a trace event for synchronize_rcu_normal()
  doc: Add rcutree.rcu_normal_wake_from_gp to kernel-parameters.txt
  rcu: Support direct wake-up of synchronize_rcu() users
  rcu: Move sync related data to rcu_state structure
  rcu: Add CONFIG_RCU_SR_NORMAL_DEBUG_GP

 .../admin-guide/kernel-parameters.txt         |  14 +
 include/trace/events/rcu.h                    |  27 ++
 kernel/rcu/Kconfig.debug                      |  12 +
 kernel/rcu/tree.c                             | 354 +++++++++++++++++-
 kernel/rcu/tree.h                             |  19 +
 kernel/rcu/tree_exp.h                         |   2 +-
 6 files changed, 426 insertions(+), 2 deletions(-)

-- 
2.39.2

