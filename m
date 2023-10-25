Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39AE7D6F96
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344643AbjJYOJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344597AbjJYOJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:09:23 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78261133;
        Wed, 25 Oct 2023 07:09:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507b9408c61so7837219e87.0;
        Wed, 25 Oct 2023 07:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698242959; x=1698847759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wmEvOZOZBOhclOxlPn09a+GCZzFmuG5NCdmw689iQU8=;
        b=eRPhSbEum2efFyRJsgKMGShGE3R7z/5EpI9qTfVvkk+gmh8vLfuyzJHOQu18qrjmYG
         IeXCOqa0eTdBxhPlCTRgepLi6Oe/KZAXU09+h/Einzj+okTwej/y0onp4HZIlZfQkFG/
         F3n8CxNfSDGBkFlhngrVQF54ouGqvydXSU+zQRfqk+VRAvc9ZFt/NXSZ+GMDEx+ZkHJz
         Xb1xKZRoSrMo37ssHyOJljs7SBGQVrJZhJY4e8slCqD3BhDsz97+IGJxDoHhMgMeCfC1
         TMNE4Nx8RDZCTdB/0eZNZHJ94MhoULtpyp+U+im5MHkNBdjrtQNsnGP4sPKSRltaZQ7E
         O3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242959; x=1698847759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmEvOZOZBOhclOxlPn09a+GCZzFmuG5NCdmw689iQU8=;
        b=hRHoaqQyKttM3vmZJAg6rL07j3slei3xsZ7RmSJtflwGmIFisZTGJoqfIAe6DQvUOk
         e6+lP4JITr5jkELAhoNjuAryIMdQEdViFdjgrgfo86Q+WRmYD66jhVfCbPjTy71I+2qI
         uRt/qZHCDUBXrTmTH2tPmHRv9qwb7nMJ64qCZqGd0XuxZho/korCgoHXBN/WqZWdPG99
         8JPiwzfrhbLF4GbRq3BFy28o9VAF8hXgXf6Jh5xwQtnkA0oJ415c0NGGH8l74iycTbBk
         zHc5HqoKGOv5rqmilyo9mIwbbfolY1+6VpWyIVdK19YqVaZ19FvdHzwKsMR/62GNeVPW
         EMjw==
X-Gm-Message-State: AOJu0YzvOL50ZV/D16ZYEOWRkyHVxxaZF719Qld2wBkDWZrTm8TBoh/C
        RuUlK4JQjqKGO2OkO+JDPHo=
X-Google-Smtp-Source: AGHT+IEx8rlub2pACfZdENkdmtdDFZnd+a/ebbeVKAXNHLNyyW+sVcoYmrefelECGF9yPq67dldxQw==
X-Received: by 2002:ac2:5470:0:b0:500:a6c1:36f7 with SMTP id e16-20020ac25470000000b00500a6c136f7mr11596559lfn.3.1698242958398;
        Wed, 25 Oct 2023 07:09:18 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id o8-20020ac24e88000000b00507977e9a38sm2555680lfr.35.2023.10.25.07.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:09:17 -0700 (PDT)
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
Subject: [PATCH 0/3] reduce latency of synchronize_rcu()
Date:   Wed, 25 Oct 2023 16:09:12 +0200
Message-Id: <20231025140915.590390-1-urezki@gmail.com>
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

Here is a small series that tends to reduce a waiting time of
synchronize_rcu() call. Please note, this is only limited to
a "normal" version.

As for performance figures, i used real test cases and a synthetic.
For example
 - camera app launch time on our Android device is reduced by 9-13 percent;
 - loading 100 kernel modules also get improved by 10-12 percent;
 - synthetic gives 30 and higher percentage of boost.

Uladzislau Rezki (Sony) (3):
  rcu: Reduce synchronize_rcu() waiting time
  rcu: Add a trace event for synchronize_rcu_normal()
  doc: Add rcutree.rcu_normal_wake_from_gp to kernel-parameters.txt

 .../admin-guide/kernel-parameters.txt         |  12 ++
 include/trace/events/rcu.h                    |  27 ++++
 kernel/rcu/tree.c                             | 152 +++++++++++++++++-
 kernel/rcu/tree_exp.h                         |   2 +-
 4 files changed, 191 insertions(+), 2 deletions(-)

-- 
2.30.2

