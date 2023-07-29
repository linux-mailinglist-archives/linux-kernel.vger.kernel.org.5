Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D480767D30
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 10:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjG2Ij3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 04:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjG2IjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 04:39:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718612682
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 01:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690619915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/qMxeacLd+wncSJssn22/qE06k6UGGyQmigi4emef7E=;
        b=dyEmmnX5sBtD8g3yb+wRXm2y6bpGxjrIMBjRf3QFlyWO5NovSaRXC8/JlvBCuPCBcDfSHH
        b1sW4pnuSB4asmW283ApvIoVpRPS1z8m1q/diJp7VW/kVgQ9Akrs5nzrjn9fs2uBDKEK89
        LqWdo+QnTJ2uRA4Dj9Uf6YzPnqKMohU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-JLsJF1ShPSWoMJT-wBSMMQ-1; Sat, 29 Jul 2023 04:38:34 -0400
X-MC-Unique: JLsJF1ShPSWoMJT-wBSMMQ-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b9efedaeebso5345358a34.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 01:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690619913; x=1691224713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qMxeacLd+wncSJssn22/qE06k6UGGyQmigi4emef7E=;
        b=O3t/jDSbu7BQvACp6xTLaaIr23IkoPG6E8qwlmnSs0ntbgeYnAZFzC+p2iDWmOf8Qw
         Gu3suKb8KQQ1zr0U3SEA61eHuCfmUOm1qwvZTJm++ql8LN5S0lXmtLLKpR4kEEd+/CyL
         z/2oh1CmC+Zs8D1XMwZ0XjUitzxPSQbW7OpsYuOsHGJ2BxUzUhH6dwmVB7v6QZi9E4Qh
         JwKQZItDUNMvP+rHOokAaqbFbVklS9Q9aLIStZ9DEnMDu6ElGEe3opN0KG2X4xT6OKj9
         KCg18sBMreSIifAsvSopnEZoN+qHaFiBmTxKDfbDaQemKlMJJFgpJUpnw4I57mUl7/Qm
         SZ2g==
X-Gm-Message-State: ABy/qLZ+FApPFYhrvP7Mk5eVjOb06RXnqBtnXHXZ4BNpT4POUk9angnw
        HVBcR9CakZAGmHGhaZd/HympHkIg1aMq8wgdXxi0CWlMXeBgDsI/8R1xi7htHFPgC0j8t77s3c7
        W3P7u2U7fpU2CGiSA5BHZ+28rT0+QmEeK
X-Received: by 2002:a05:6808:21a3:b0:3a3:94f4:adca with SMTP id be35-20020a05680821a300b003a394f4adcamr6211803oib.2.1690619913150;
        Sat, 29 Jul 2023 01:38:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHnc9jTM50g7D0XmpFu/DicElhf/9ym3VqLGlU71GcM06SWbZBYGpKp408hIgXrwxYNnYNmCQ==
X-Received: by 2002:a05:6808:21a3:b0:3a3:94f4:adca with SMTP id be35-20020a05680821a300b003a394f4adcamr6211794oib.2.1690619912891;
        Sat, 29 Jul 2023 01:38:32 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:93ca:d713:4eb3:968e:3b54])
        by smtp.gmail.com with ESMTPSA id be24-20020a056808219800b003a3f922207asm2467184oib.1.2023.07.29.01.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 01:38:32 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Leonardo Bras <leobras@redhat.com>
Subject: [RFC PATCH 0/4] Improve RT performance & latency w/ local_lock_t()
Date:   Sat, 29 Jul 2023 05:37:31 -0300
Message-ID: <20230729083737.38699-2-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem:
We have a few scenarios in mm that make use of local_locks() + 
schedule_work_on() due to reduced overhead on the most common local 
references. This scenario is not ideal for RT workloads though: even on 
isolated cpus, those tasks will schedule-out the sensitive RT workloads to 
perform those jobs, and usually cause missing deadlines with this.

The idea:
In PREEMPT_RT, local_locks() end up becoming spinlocks(), so there should 
be no harm in just getting another cpu's spinlock to perform the work 
on the per-cpu structure: the cacheline invalidation will already happen 
due to the usage by schedule_work_on(), and on local functions the locking 
already happens anyway.

This will avoid schedule_work_on(), and thus avoid scheduling-out an 
RT workload. Given the usually brief nature of those scheduled tasks, their 
execution end up being faster than doing their scheduling.

======

While I really belive the solution, there are problems with this patchset, 
which I need your suggestions for improvement:

1) Naming is horrible: I could not think on a good name for the new lock 
functions, so I lazely named it local_lock_n(). 
The naming should have been making clear that we are in fact dealing 
with a local_lock but it can in some scenarios be addressing another cpu's 
local_lock, and thus we need the extra cpu parameter. 

Dealing with this local & remote duality, all I thought was:
mostly_local_lock(), (or local_mostly_lock())
local_maybe_remote_lock()  <- LOL
remote_local_lock()
per_cpu_local_lock()
local_lock_cpu()

Please help !


2) Maybe naming is this hard because the interface is not the best.
My idea was to create a simple interface to easily replace functions 
already in use, but maybe there is something better I could not see.

Please contribute!

3) I am lazely setting work->data without atomic operations, which may 
be bad in some scenario. If so, even thought it can be costly, since it 
happens outside of the hotpath (local per-cpu areas) it should be no 
problem adding the atomic operation for non-RT kernels.

For RT kernels, since the whole operation hapens locally, there should be 
no need of using the atomic set.

Please let me know of any idea, or suggestion that can improve this RFC.

Thanks a lot!
Leo

Leonardo Bras (4):
  Introducing local_lock_n() and local queue & flush
  swap: apply new local_schedule_work_on() interface
  memcontrol: apply new local_schedule_work_on() interface
  slub: apply new local_schedule_work_on() interface

 include/linux/local_lock.h          | 18 ++++++++++
 include/linux/local_lock_internal.h | 52 +++++++++++++++++++++++++++++
 mm/memcontrol.c                     | 17 ++++++----
 mm/slub.c                           | 17 ++++++----
 mm/swap.c                           | 18 +++++-----
 5 files changed, 100 insertions(+), 22 deletions(-)

-- 
2.41.0

