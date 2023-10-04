Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DE17B7F33
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjJDMfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjJDMfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D39A9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696422863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5lyJf1Hv4hv6C8ZVFsoigSry+owH8jvWsNbreqE7P5Y=;
        b=MYBWfG2cyZKCLjtBJ+TOyJJitO2becdd3/HpfTIpA3Tc9wNIaKJfkqJqRIHvsqDBI7SKIU
        byrQXUoukIpQjpWYN7QLRyn8zcfv1HmlYNGH6fZ7A61+oFkF/+mLHFV51nKV0q54KPB991
        EGkhOTPASdDcSAqrmlsFg40O+Fr5Zmw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-b7jI9xI-OuWVapZq8-AtNQ-1; Wed, 04 Oct 2023 08:34:19 -0400
X-MC-Unique: b7jI9xI-OuWVapZq8-AtNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C06B811E7B;
        Wed,  4 Oct 2023 12:34:19 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE73A40C2015;
        Wed,  4 Oct 2023 12:34:16 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>
Subject: Re: [PATCH v4] sched/core: Use zero length to reset cpumasks in
 sched_setaffinity()
References: <20231003205735.2921964-1-longman@redhat.com>
        <20231004083648.GI27267@noisy.programming.kicks-ass.net>
Date:   Wed, 04 Oct 2023 14:34:15 +0200
In-Reply-To: <20231004083648.GI27267@noisy.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Wed, 4 Oct 2023 10:36:48 +0200")
Message-ID: <871qeaefco.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra:

> Subject: sched: Add CPU_FILL()
>
> Add the CPU_FILL() macros to easily create an all-set cpumask.
>
> FreeBSD also provides this macro with this semantic.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

My main concer is that obtaining the size of the mask, or at least an
approximiation is not exactly easy.  If there's an expectation that
applications reset the mask more often than they do today (I don't have
the full context here), then we'd some decent interface to get the
approriate size.

Thanks,
Florian

