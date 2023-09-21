Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C397AA255
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjIUVQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjIUVOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8472372B4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695316209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sH2Au38KmbTnTNDhV42LM6c+rwj2Unx3F/lqiD2xBaQ=;
        b=EoJHK0XzBL4jzWGsdBeueUDHPt+Mpb62X4czreIMBVd+NhNB+qGuWEqWrn6sK7Mzr2qnKv
        iABNIF1QNrHMQcUqIZZZ5bAOU16PFKyfr7IvWs5+d2kZ6cxy6Iw9q8RGjUhnFQqDGOH7YJ
        VaoMtUWVa8TM975eOgo41NAvSWYCfsY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-7kUKXnSAP5qdBh17szvjUA-1; Thu, 21 Sep 2023 07:49:23 -0400
X-MC-Unique: 7kUKXnSAP5qdBh17szvjUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 586D0185A78E;
        Thu, 21 Sep 2023 11:49:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.156])
        by smtp.corp.redhat.com (Postfix) with SMTP id D7792140E964;
        Thu, 21 Sep 2023 11:49:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 21 Sep 2023 13:48:29 +0200 (CEST)
Date:   Thu, 21 Sep 2023 13:48:26 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] seqlock: simplify SEQCOUNT_LOCKNAME()
Message-ID: <20230921114826.GA20728@redhat.com>
References: <20230913154907.GA26210@redhat.com>
 <20230913154953.GA26242@redhat.com>
 <20230916085117.GA35156@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916085117.GA35156@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/16, Peter Zijlstra wrote:
>
> On Wed, Sep 13, 2023 at 05:49:53PM +0200, Oleg Nesterov wrote:
> > 1. Kill the "lockmember" argument. It is always s->lock plus
> >    __seqprop_##lockname##_sequence() already uses s->lock and
> >    ignores "lockmember".
> >
> > 2. Kill the "lock_acquire" argument. __seqprop_##lockname##_sequence()
> >    can use the same "lockbase" prefix for _lock and _unlock.
> >
> > Apart from line numbers, gcc -E outputs the same code.
>
> With seqlock_ww_mutex gone, yes this is a nice cleanup.

Thanks.

Can you look at 2/5? To me it looks like a good cleanup too.
I am going to resend 1/5 and 2/5, as no one is interested in
stats_lock change.

Oleg.

