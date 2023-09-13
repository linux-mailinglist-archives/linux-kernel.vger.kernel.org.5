Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E008F79EDA7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjIMPvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjIMPvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23653E3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694620217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=vnbXli9O54cjnvKYertbo84qIt8IuDe2j7srU/gO3RU=;
        b=Is6JeVhzL+jwrsKg7erhnTS3uJcNEnJQyrg8b8A2em81zoDbbqq2o9pj7DTDcDc78mdTpb
        iqHWY5j5im6A3LCM6EWEVuu5Dp3rg3BrZQ++DxDar14SmEVArTILBfFHZN7lGMl/CJ4xNl
        E1pvkeB30BWPDzD8AmFSJcdwEX2gK3k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-BQAvx5gjNTuCw8Bo4h2FcQ-1; Wed, 13 Sep 2023 11:50:11 -0400
X-MC-Unique: BQAvx5gjNTuCw8Bo4h2FcQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A2EC830FB1;
        Wed, 13 Sep 2023 15:50:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id 99E0D1054FC3;
        Wed, 13 Sep 2023 15:50:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 13 Sep 2023 17:49:10 +0200 (CEST)
Date:   Wed, 13 Sep 2023 17:49:07 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] turn signal_struct.stats_lock into seqcount_rwlock_t
Message-ID: <20230913154907.GA26210@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

RFC, not for inclusion yet. Please review, at least the intent.

In particular, can you look at the changelog from the last patch?
Am I right that currently thread_group_cputime() is not RT friendly?


During the (ongoing) s/while_each_thread/for_each_thread/ conversion
I noticed that some of these users can use signal->stats_lock instead
of lock_task_sighand(). And if we change them, we can try to avoid
stats_lock under siglock in wait_task_zombie() at least.

However, signal->stats_lock is seqlock_t but I think seqcount_rwlock_t
make more sense. So let me try to turn it into seqcount_rwlock_t first.

OTOH... I am not sure I understand the value of signal->stats_lock.
I mean, do we have any numbers which prove that seqlock_t is really
"better" than the plain rwlock_t ?

So far only compile tested, and I need to re-read these changes with
a clear head. In any case, it is not that I myself like this series
very much, and most probably I did something wrong...

Oleg.
---
 include/linux/sched/signal.h |   4 +-
 include/linux/seqlock.h      | 105 +++++++++++++++++++++++++++++++++++--------
 kernel/exit.c                |  12 +++--
 kernel/fork.c                |   3 +-
 kernel/sched/cputime.c       |  10 +++--
 5 files changed, 106 insertions(+), 28 deletions(-)

