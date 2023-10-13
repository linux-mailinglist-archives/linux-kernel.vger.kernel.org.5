Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0947C8866
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjJMPPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjJMPPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:15:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D73BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:15:01 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32d9effe314so514599f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697210100; x=1697814900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qauQemRz+p3E7tr87M6W/VhyApDmNqnJ8cEHBICLbIw=;
        b=EqFtvMbh3iWPWf8WgQ9kD0MdgVDn+zBYj8U9O9E+7X5h0V5OCE7fnHbyBdEZ4Q1G2e
         RvWD/k7chZ1Oe5pX4dOJS+9YewMtQHUB2ADayd6MMB6ZSoStp2VbzjiUg0nMi6mTnpYj
         /of/X351FOg0oujOGpce0gGnhjq+x4GlNFXRZwQGpHm8NGUCXDHqkwa4gq4cvXgj4Pc/
         FDhS/1X7Us/nIEMvuHI1YujyiYGB0lb9TkfyYFjAVitlGOwggf4+4Fn7X5KOwkGMwM+0
         3JqW6L2OOpZ0CxOBk9oSUa20NAJ4dvB6aqOM5u7wF4hbhzGn4QyL12pzt6X+a2IXoHHE
         GRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697210100; x=1697814900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qauQemRz+p3E7tr87M6W/VhyApDmNqnJ8cEHBICLbIw=;
        b=lp/AGdNlpt0S0oyIR5P3IwSoX68vzOFCr/BVuiE2Y1gA+YKtFwqxckjS8huz2qtzOs
         J74IiY26s2xps9a9TFR2Bk93TUDPnWcqAhSYsIVuvYRgsnkR09QyS9/QhYrHXGSYAaDl
         aWET0LSNxmzYxCn8N8MNFZt/Jo1IZLqFxBv8CHOehLB6pRYdruQc5nfAmYVgbXEL9Mg2
         gJUWOaNkHAK4ISuQdDXQ7fSA8axv0hrf8i15IeOsCV0u+n+AHouBUNnaEGphwtDSpaJD
         fack2LH9XpyGR/CXDXS+GW//gG2uNRnxTtWUs7hh11KxLCC6H3CQ+vtclMdFOi9CQixf
         fUrw==
X-Gm-Message-State: AOJu0Yw3xeUSoPSfxvv5nomEewHaZmjmRh1TvpaVu9hVolSq1ioplfnK
        Psovs8rsveGt/8/X8PP//w+64w==
X-Google-Smtp-Source: AGHT+IEl7I8bpoE6w8Uw1PgkaExikkqcv63bCQ+Gqnnpsi2uI7xQqhbk+e2MVOA1zriJmg+UfRzn1Q==
X-Received: by 2002:a05:6000:3c1:b0:329:6bdc:5a60 with SMTP id b1-20020a05600003c100b003296bdc5a60mr19080036wrg.12.1697210099841;
        Fri, 13 Oct 2023 08:14:59 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:38a9:4647:7a2a:5b13])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d6dc9000000b00327b5ca093dsm20814975wrz.117.2023.10.13.08.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:14:59 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     lukasz.luba@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/2] Rework interface between scheduler and schedutil governor
Date:   Fri, 13 Oct 2023 17:14:48 +0200
Message-Id: <20231013151450.257891-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the discussion with Qais [1] about how to handle uclamp
requirements and after syncing with him, we agreed that I should move
forward on the patchset to rework the interface between scheduler and
schedutil governor to provide more information to the latter. Scheduler
(and EAS in particular) doesn't need anymore to guess estimate which
headroom the governor wants to apply and will directly ask for the target
freq. Then the governor directly gets the actual utilization and new
minimum and maximum boundaries to select this target frequency and
doesn't have to deal anymore with scheduler internals like uclamp when
including iowait boost.

[1] https://lore.kernel.org/lkml/CAKfTPtA5JqNCauG-rP3wGfq+p8EEVx9Tvwj6ksM3SYCwRmfCTg@mail.gmail.com/

Vincent Guittot (2):
  sched/schedutil: rework performance estimation
  sched/schedutil: rework iowait boost

 include/linux/energy_model.h     |  1 -
 kernel/sched/core.c              | 85 ++++++++++++--------------------
 kernel/sched/cpufreq_schedutil.c | 72 +++++++++++++++++----------
 kernel/sched/fair.c              | 22 +++++++--
 kernel/sched/sched.h             | 84 +++----------------------------
 5 files changed, 105 insertions(+), 159 deletions(-)

-- 
2.34.1

