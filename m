Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B8C7BCDDD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 12:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344637AbjJHKtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 06:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344623AbjJHKtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 06:49:46 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3E9AC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 03:49:42 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-57f02eeabcaso1576782eaf.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696762182; x=1697366982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhJ/rEdOQNad9gQ5ZZe+v6z7516MUe0+k6HQcuGth6w=;
        b=Zkkbo9w6Da4TWgzf45+FxX4JHPYqOvZcbh2s6GFx3B6wIkerdoWKHVjyxsOJy1eMtB
         syUwvIW1EcTF5xXMiuVmYg8dFJWRUbIL4DzpvdPis08KraouhikPWQN2Ts/XM/FgZPtx
         tV4F6IFH3NIvwDwutvjFIRa9Hphj5Z9+rsoeIyEs4kB9yUsBzEzLbZIQ20OnWVGeORbE
         Vdm/hCGZX7qN2K174tAnenu+FSm58H8wnhLsqFDvbJqsYTsqEd1Ur2iHNFRWtXoXAyBD
         a1clXiy7gXtt8vQ3KRn3w52PpzuKSmM1uEmKW9I3h0rnM8vwMGWnIW/3znsSU4xIoN9A
         MI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696762182; x=1697366982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhJ/rEdOQNad9gQ5ZZe+v6z7516MUe0+k6HQcuGth6w=;
        b=ehVRVZf8y7mIyo/wvg6d0RZvOAOnOm1ZZ7QVfTIR2sQi3q0MmvYSzmMw9KA7LQ6Xau
         0tMenM4DsrOABtgak7BgIOZIFVC/4AKCVj0WTte9MayEfWMBcRn/KI82hYAXPJgram5k
         GyUn4quUTqMSzxIRiU0zGeRC25ZiUmF02WQCJkJocnPoNVTRn2Tc1uCTKIEjr7d2foBV
         04JD68f+KO5u/yu6Z7C6m4ih5B2X70cPfvnlLzk6PDv3QMV6xMRHdKhr4AeTRiHJSVhK
         jHD+QBmwnEMY59JKli2ZVWPwrQGyzL7+3DVYEw1gq6E4Uw7XwyKYfpt/tSx8u371HGrf
         m78A==
X-Gm-Message-State: AOJu0YxY+1gB3nP4N1M66qzOBLG1+r/J3IiQVMDsVr/HYJ55J6zN9V0q
        ieWT/cD8kTzrxc9oTU9XOzw=
X-Google-Smtp-Source: AGHT+IH0k3o7eVVocm+wQYHKdofKzOgocVo4eWc3SU0COBkD7TDfcQ13RGggK5ScCk/ZLWvDQsl1Eg==
X-Received: by 2002:a05:6358:9218:b0:142:fd2b:d30c with SMTP id d24-20020a056358921800b00142fd2bd30cmr14630846rwb.23.1696762181939;
        Sun, 08 Oct 2023 03:49:41 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id z11-20020a17090acb0b00b002630c9d78aasm6311517pjt.5.2023.10.08.03.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 03:49:41 -0700 (PDT)
From:   "brookxu.cn" <brookxu.cn@gmail.com>
To:     bsingharora@gmail.com, juri.lelli@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] delayacct: optimization & code simplify 
Date:   Sun,  8 Oct 2023 18:49:35 +0800
Message-Id: <cover.1696761522.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
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

From: Chunguang Xu <chunguang.xu@shopee.com>

Since in some scenarios we still want to get the task delayacct
through taskstats, so commit <0cd7c741f01de> introduces a sysctl to
enable it dynamically. However, since task->delays is allocated
during fork(), task->delays will not be reallocated when delayacct
is enabled later. This will make we cannot get the delayacct of old
tasks, but the new tasks cans. This can easily lead to confusion.
Therefore, try to workaround this issue by convert task->delays to
an object, just like sched_statistics. Besides, try to simplify the
code of delayacct.

Chunguang Xu (3):
  delayacct: introduce delayacct_enabled() to simplify implement
  delayacct: convert task->delays to a object
  delayacct: remove delayacct_on to simplify the code

 include/linux/delayacct.h |  83 +++++-------------------
 include/linux/sched.h     |   3 +-
 kernel/delayacct.c        | 129 ++++++++++++++++++--------------------
 kernel/fork.c             |   7 +--
 4 files changed, 81 insertions(+), 141 deletions(-)

-- 
2.25.1

