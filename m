Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4257782BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjHJVcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjHJVcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2DA26A0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691703092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jJUeSyBk0QzKVoHZ1k1R68zenjdqRpACqyBw+UPefPY=;
        b=gnlAbOGiOGML/1KvbxouvSCM4/QmGgx4h8mPcPC6fFlXD8wVG2Ulv436ODj6oEsKaW8X8X
        hH9Nby+p+YtHhwx0ra3fnBFPWSNYWV3/2ixEqadAYigVl8LLjmWA2u90B36W7d34ccng11
        YP0BbAhtz2YkFu6W9CY8gG4N9fRbDEs=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-FT4Tus8aMEqUkIAtnNAAeQ-1; Thu, 10 Aug 2023 17:31:28 -0400
X-MC-Unique: FT4Tus8aMEqUkIAtnNAAeQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73A981C0898F;
        Thu, 10 Aug 2023 21:31:21 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E9D5492B11;
        Thu, 10 Aug 2023 21:31:21 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 292FD40504A7B; Tue,  8 Aug 2023 16:39:29 -0300 (-03)
Date:   Tue, 8 Aug 2023 16:39:29 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] swap: apply new local_schedule_work_on()
 interface
Message-ID: <ZNKZ8Vc/LE9lVAjN@tpad>
References: <20230729083737.38699-2-leobras@redhat.com>
 <20230729083737.38699-4-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729083737.38699-4-leobras@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 05:37:33AM -0300, Leonardo Bras wrote:
> Make use of the new local_*lock_n*() and local_schedule_work_on() interface
> to improve performance & latency on PREEMTP_RT kernels.
> 
> For functions that may be scheduled in a different cpu, replace
> local_*lock*() by local_lock_n*(), and replace schedule_work_on() by
> local_schedule_work_on(). The same happens for flush_work() and
> local_flush_work().
> 
> This should bring no relevant performance impact on non-RT kernels:
> For functions that may be scheduled in a different cpu, the local_*lock's
> this_cpu_ptr() becomes a per_cpu_ptr(smp_processor_id()).
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  mm/swap.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Leo,

I think the interruptions should rather be removed for both
CONFIG_PREEMPT_RT AND !CONFIG_PREEMPT_RT.

The impact of grabbing locks must be properly analyzed and not
"rejected blindly".

Example:

commit 01b44456a7aa7c3b24fa9db7d1714b208b8ef3d8
Author: Mel Gorman <mgorman@techsingularity.net>
Date:   Fri Jun 24 13:54:23 2022 +0100

    mm/page_alloc: replace local_lock with normal spinlock
    
    struct per_cpu_pages is no longer strictly local as PCP lists can be
    drained remotely using a lock for protection.  While the use of local_lock
    works, it goes against the intent of local_lock which is for "pure CPU
    local concurrency control mechanisms and not suited for inter-CPU
    concurrency control" (Documentation/locking/locktypes.rst)
    
    local_lock protects against migration between when the percpu pointer is
    accessed and the pcp->lock acquired.  The lock acquisition is a preemption
    point so in the worst case, a task could migrate to another NUMA node and
    accidentally allocate remote memory.  The main requirement is to pin the
    task to a CPU that is suitable for PREEMPT_RT and !PREEMPT_RT.

