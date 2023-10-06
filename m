Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AEC7BB512
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjJFKZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjJFKZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:25:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D8DEA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:25:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b2cee55056so361701566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 03:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696587924; x=1697192724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x/ev5yLrXAepyxhZiRn5Ggul3RGwvDj2k1s+IdnZNsU=;
        b=ZvRd4Q74IWlfeJTvMd1KnAzu0CkfcDrpUhfR4u4iF1K77F25iJkjqvRUPNk7QPEGCB
         Nr7HpdpVoqsMrxaycbaqNtvKfrCrV9+y7vEJZh4DuqMziHEkxT3UCE70uNmJaKQHZQAJ
         sx8YqLfbv02WMHShmlVdvGR/zzfB0fHELY5EonfEXEXUfW7fxmGldc3Pe0ueVuliKKMY
         IA8LwzO534GSDL1ozMj99ScGz3q/K+Z9CXpw7NiFnkDxLzOUaypgJuBNr5y2N6No2dU6
         Am+3yBi+4LEOuZANDsEK8yEEyq90q8DcbV9h4Apuq1dN0JiWW16/j1nzUdbHgjzQUYHQ
         36Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696587924; x=1697192724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/ev5yLrXAepyxhZiRn5Ggul3RGwvDj2k1s+IdnZNsU=;
        b=ek3iAhpgqI4bOdt2f1Q44FsrwbQWqqJJsXn7PHXeWteC02yGWN3kkXaPYgix1ZRd89
         yhxNLD57uOcK15GMbf7Zdj90ToTBLd2pCIJ/xNFt0pn80i0lj7j/SgN+rtzdmP10UmZA
         Lg43kNNuCONAQ/k+BbyH4xC6JNMSin0EdHFmqesbCuLkaOsPgTMOCF4YxScf6y1iHFKm
         H9USdera3g7i9alQ55xG6lSKwWothLv79543Ntzpf+hJQrHSeTtAtOBMhD7tCDUo3mId
         TPUmyMWNEF0XGQgx0jx3TVhVQhptjVm3svzN/nerSEJkFgjpdgkuBJwQ3ngY2PYiXQve
         5R8w==
X-Gm-Message-State: AOJu0YyLiUgn1tRoxvFNjtTfQhIXcpLqrqtrIR7HKIBje+DNXBFsmfKD
        94GUqiEVUT3/MbkR0Oo58+Mw8nktoeQ=
X-Google-Smtp-Source: AGHT+IHz7mgyukALzUqWP+5cu0JH5iKke/E6K/dnIWf3ZAdIg8u/PirwEoG34oYwJt7YgSQE/nXVqw==
X-Received: by 2002:a17:907:77d3:b0:9ad:f87c:57a8 with SMTP id kz19-20020a17090777d300b009adf87c57a8mr7101755ejc.3.1696587924275;
        Fri, 06 Oct 2023 03:25:24 -0700 (PDT)
Received: from kepler.redhat.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906379100b009b957d5237asm2613502ejc.80.2023.10.06.03.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:25:23 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/3] sched/nohz: Misc minor cleanups to the NOHZ idle balancing code
Date:   Fri,  6 Oct 2023 12:25:15 +0200
Message-Id: <20231006102518.2452758-1-mingo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed a few minor details while I was reading this code:

Ingo Molnar (3):
  sched/nohz: Update idle load-balancing (ILB) comments
  sched/nohz: Use consistent variable names in find_new_ilb() and kick_ilb()
  sched/nohz: Remove weird error handling from find_new_ilb()

 kernel/sched/fair.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

-- 
2.39.2

