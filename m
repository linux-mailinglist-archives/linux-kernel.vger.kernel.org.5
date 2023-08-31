Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5460778E3C1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345050AbjHaAKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344997AbjHaAKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:10:11 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57A3CCF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:10:08 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1bf5c314a57so1671555ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693440608; x=1694045408;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0ifgTXq+r2BeSdkqHGP0xQUpC4XvAwiwkMVFgeOVjg=;
        b=aA8gCMSrFcUN/AqPY7uJoigrl7AIDHDZ9PygqtPW5Us1q8dny6R0q4cHxCA/YEOmpW
         ECT40DbfLK8evPEfzx3J4bdYSw+R6mQhwIC0Tu6czYUaICvifHamXsjmpSz/CrU8n5JX
         xouTYaiI7lLCSaRUrimLqwdo9qradE+al196ueQL2mEJ03BkEyL0iRo1Gd8mwpexTbTB
         7okZepwe8S/krFNLSkKOY1X7rnpz6w9LlaSPf+C/e28cBcsvUfHDXmRkRUiW9VancBX9
         YhXoWoJU6/KkFeTR8Z0xZtm//AYdzCS3Op+41NzgYNdNuFwiP6cJqego8GsA4Drhq4Lc
         1yTA==
X-Gm-Message-State: AOJu0YwfQf5VUkk+HT4FfrxUQdf+dkSei4s36PxeqPzdMZWZFrkZtNXW
        SuElpSTOJW4RG0/lQkISMl4=
X-Google-Smtp-Source: AGHT+IEqI9QWZA2A4KOT8unleUiNW2sL2+SI9SHiSKYx3xYHKp4DwZtEpxLuVjX1aR6Ka/Vqyh4NfQ==
X-Received: by 2002:a17:902:a5c7:b0:1bf:13a7:d3ef with SMTP id t7-20020a170902a5c700b001bf13a7d3efmr2731095plq.66.1693440607918;
        Wed, 30 Aug 2023 17:10:07 -0700 (PDT)
Received: from snowbird ([199.73.127.3])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001b895a17429sm68225plq.280.2023.08.30.17.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 17:10:07 -0700 (PDT)
Date:   Wed, 30 Aug 2023 17:10:05 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu changes for v6.6-rc1
Message-ID: <ZO/aXSBuVRuqFHtz@snowbird>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

There is 1 bigger change to percpu_counter's api allowing for init and
destroy of multiple counters via percpu_counter_init_many() and
percpu_counter_destroy_many(). This is used to help begin remediating a
performance regression with percpu rss stats.

Additionally, it seems larger core count machines are feeling the burden
of the single threaded allocation of percpu. Mateusz is thinking about
it and I will spend some time on it too.

Thanks,
Dennis

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git tags/percpu-for-6.6

for you to fetch changes up to 14ef95be6f5558fb9e43aaf06ef9a1d6e0cae6c8:

  kernel/fork: group allocation/free of per-cpu counters for mm struct (2023-08-25 08:10:35 -0700)

----------------------------------------------------------------
percpu: changes for v6.6

percpu
* A couple cleanups by Baoquan He and Bibo Mao. The only behavior change
  is to start printing messages if we're under the warn limit for failed
  atomic allocations.

percpu_counter
* Shakeel introduced percpu counters into mm_struct which caused percpu
  allocations be on the hot path [1]. Originally I spent some time
  trying to improve the percpu allocator, but instead preferred what
  Mateusz Guzik proposed grouping at the allocation site,
  percpu_counter_init_many(). This allows a single percpu allocation to
  be shared by the counters. I like this approach because it creates a
  shared lifetime by the allocations. Additionally, I believe many inits
  have higher level synchronization requirements, like percpu_counter
  does against HOTPLUG_CPU. Therefore we can group these optimizations
  together.

[1] https://lore.kernel.org/linux-mm/20221024052841.3291983-1-shakeelb@google.com/

----------------------------------------------------------------
Baoquan He (3):
      mm/percpu.c: remove redundant check
      mm/percpu.c: optimize the code in pcpu_setup_first_chunk() a little bit
      mm/percpu.c: print error message too if atomic alloc failed

Bibo Mao (1):
      mm/percpu: Remove some local variables in pcpu_populate_pte

Mateusz Guzik (2):
      pcpcntr: add group allocation/free
      kernel/fork: group allocation/free of per-cpu counters for mm struct

 include/linux/percpu_counter.h | 41 ++++++++++++++++++++-----
 kernel/fork.c                  | 15 +++------
 lib/percpu_counter.c           | 62 +++++++++++++++++++++++++------------
 mm/percpu.c                    | 69 +++++++++++++++++-------------------------
 4 files changed, 109 insertions(+), 78 deletions(-)
