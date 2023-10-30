Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8294C7DBA56
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjJ3NNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjJ3NNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:13:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15288C2;
        Mon, 30 Oct 2023 06:12:59 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5090cc340a3so2974192e87.2;
        Mon, 30 Oct 2023 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698671577; x=1699276377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s4Pi+7ZSljwaGLX14je8j3CR4U+NnbeoJUamT2Tf16E=;
        b=QnkCBvl0N4dt2T4TihkSGdW+vL0z6EaxVR5pXYYwDn+G+OJbfDskxcq16vGPCdVASg
         Q+RLfkBXKXZMXAM8mULbOfly2KhR3UHVXYfonSFYqFyeXbtxrBNPSxGFlM5+4KvwaInp
         xp7L2r8nVlmYTra7JiUQreRu0yDf73mocF5WeFB8npbuSLVd1iuJ+CH4kKZMNv2VoXCq
         fkDS/roqKjBSezTccjmZBl+xPQn99/neYkYLjGNkvJRhlWjx9LHoxGqHjAIItqeZXaQt
         b5vC3T1GId1PFL81/HpTjnzPKZIrFLniDPQIkuMtL253TQMqTRSeMZg0tz7Zw5C2fxPc
         Xnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698671577; x=1699276377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4Pi+7ZSljwaGLX14je8j3CR4U+NnbeoJUamT2Tf16E=;
        b=VEPu+8o3PniqpCukQfvf+B542GZ0VkPBRNMCmvJTf+Mm1xZlSNYh9pmC4SfmJj7H90
         ahnymWOrhCKtmbt4Nh5pUEBWcak6BuXW5BabmgGhQJQsPxqm2uzQauaCGEkoA81sgT9H
         g+qbVVoIeF1JSHytAKB7bqUYPGyHTo1H0ZAFMmuEG9FINAN/eNtVDEA/1b7qoPXcNxg+
         0FHluHPrn6LE+VxEj1QkkhjFz8z0RjOGqPg174F0139hhcejWYF6De/Ls+JySxIeCMj6
         QmLIggYJStKw7DtVQx2i0KW4IZYjJRHc4WrcKBm8wbqQVOWP43WAo3O9sV9S9hGy60Kf
         PM4g==
X-Gm-Message-State: AOJu0YyPDwXYqclVFaPs13Ce8FaBVZZSfbXWfon+iS9gvpmbCBOZzaqM
        qOtDYTfQTEwCMLmftOa7I7UmQYasSH8=
X-Google-Smtp-Source: AGHT+IH3to0MuEjxmaHZTv664Kkk0XYYFkt76exPdvz0hLEVxlslVIimWj9wWqHKEih0nzmhx+cNwQ==
X-Received: by 2002:a05:6512:709:b0:503:3281:2ffd with SMTP id b9-20020a056512070900b0050332812ffdmr6618321lfs.41.1698671576878;
        Mon, 30 Oct 2023 06:12:56 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id q11-20020ac2510b000000b005079691360csm1431887lfb.49.2023.10.30.06.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 06:12:56 -0700 (PDT)
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
Subject: [PATCH v2 0/3] reduce latency of normal synchronize_rcu() v2
Date:   Mon, 30 Oct 2023 14:12:51 +0100
Message-Id: <20231030131254.488186-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 is here https://lore.kernel.org/lkml/20231025140915.590390-1-urezki@gmail.com/T/

The delta v1 -> v2:
- rework a commit message;
- use non-ordered __llist* API for a wait list manipulation.

The aim of this series is to reduce a latency, make synchronize_rcu()
more generic, unify it. Because currently a behavior depends much on
RCU kconfig combinations, like, CONFIG_RCU_NOCB_CPU, CONFIG_RCU_LAZY.
For example we have a soft-irq/ksoftirqd context or a regular kthread. 

Uladzislau Rezki (Sony) (3):
  rcu: Reduce synchronize_rcu() latency
  rcu: Add a trace event for synchronize_rcu_normal()
  doc: Add rcutree.rcu_normal_wake_from_gp to kernel-parameters.txt

 .../admin-guide/kernel-parameters.txt         |  14 ++
 include/trace/events/rcu.h                    |  27 +++
 kernel/rcu/tree.c                             | 156 +++++++++++++++++-
 kernel/rcu/tree_exp.h                         |   2 +-
 4 files changed, 197 insertions(+), 2 deletions(-)

-- 
2.30.2

