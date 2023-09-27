Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755847AFA65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjI0FxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0FwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:52:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6368A5F2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 21:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695790313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lyI0l5tbqlD5kO6vNFEufMqdn2npnXDiZ3ZzE86goJU=;
        b=c0EOYi9j9mnpn3jIBtCPCt39hWwYSn5Fz0wygqGGz2XMkaqNuPjQGV2UXNKYD5eFB7bpY8
        IUbrhR1ee+vt850mguJHgC4XLNW8/0vrp6ilCL55QcawQKeuZQPEqSNdkKu5PZtAyLaooN
        JIutRQWIkj/7pZZUwXJs2x7J0Cz+FUw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-Pkjxo7nMNCCOJNXGT7GyJw-1; Wed, 27 Sep 2023 00:51:47 -0400
X-MC-Unique: Pkjxo7nMNCCOJNXGT7GyJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CB1A2815E39;
        Wed, 27 Sep 2023 04:51:46 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A77040C2064;
        Wed, 27 Sep 2023 04:51:39 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     mathieu.desnoyers@efficios.com, David.Laight@aculab.com,
        alexander@mihalicyn.com, andrealmeid@igalia.com,
        boqun.feng@gmail.com, brauner@kernel.org, carlos@redhat.com,
        ckennelly@google.com, corbet@lwn.net, dave@stgolabs.net,
        dvhart@infradead.org, goldstein.w.n@gmail.com, hpa@zytor.com,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com, mingo@redhat.com,
        paulmck@kernel.org, peterz@infradead.org, pjt@google.com,
        posk@posk.io, rostedt@goodmis.org, tglx@linutronix.de
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
References: <2c421e36-a749-7dc3-3562-7a8cf256df3c@efficios.com>
        <20230926205215.472650-1-dvyukov@google.com>
        <CACT4Y+beLh1qnHF9bxhMUcva8KyuvZs7Mg_31SGK5xSoR=3m1A@mail.gmail.com>
Date:   Wed, 27 Sep 2023 06:51:37 +0200
In-Reply-To: <CACT4Y+beLh1qnHF9bxhMUcva8KyuvZs7Mg_31SGK5xSoR=3m1A@mail.gmail.com>
        (Dmitry Vyukov's message of "Tue, 26 Sep 2023 16:49:32 -0700")
Message-ID: <875y3wp6au.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dmitry Vyukov:

> In reality it's a bit more involved since the field is actually 8
> bytes and only partially overlaps with rseq.cpu_id_start (it's an
> 8-byte pointer with high 4 bytes overlap rseq.cpu_id_start):
>
> https://github.com/google/tcmalloc/blob/229908285e216cca8b844c1781bf16b838128d1b/tcmalloc/internal/percpu.h#L101-L165

This does not compose with other rseq users, as noted in the sources:

  // Note: this makes __rseq_abi.cpu_id_start unusable for its original purpose.

For a core library such a malloc replacement, that is a very bad trap.

Thanks,
Florian

