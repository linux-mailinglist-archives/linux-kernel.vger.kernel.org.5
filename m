Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4024775D8D9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 03:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjGVB5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 21:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGVB5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 21:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D990C3C03
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 18:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689991019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYv8A4iNWJLqBUsmWoE6MiO6/A7584+GM0NOMC65SjQ=;
        b=Q7or3ALLSJ7aPxEoG4la1pq4p8DbFdZz5EGHWjJlgf6nf1PHrkGZbrBaqgkouSt02HqOZ1
        uoXVRquWrlKK0qs4obVl0zG6bErET3G8aWKcSorvA0NyKdW1+qoTYNgUoFvxE1XgY8zjeV
        gZGnikXicBYNaLimdwu+XLQL3zpk8vE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-0_d3AoYJMze3FKf2Cz7xUA-1; Fri, 21 Jul 2023 21:56:55 -0400
X-MC-Unique: 0_d3AoYJMze3FKf2Cz7xUA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E378386F122;
        Sat, 22 Jul 2023 01:56:54 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C15E7492C13;
        Sat, 22 Jul 2023 01:56:53 +0000 (UTC)
Date:   Sat, 22 Jul 2023 09:56:50 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, tj@kernel.org, cl@linux.com,
        mawupeng1@huawei.com
Subject: Re: [PATCH 3/3] mm/percpu.c: print error message too if atomic alloc
 failed
Message-ID: <ZLs3YmR0UkTr+jSK@MiWiFi-R3L-srv>
References: <20230721131800.20003-1-bhe@redhat.com>
 <20230721131800.20003-4-bhe@redhat.com>
 <ZLryhIzyDUpEPUzT@snowbird>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLryhIzyDUpEPUzT@snowbird>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

On 07/21/23 at 02:03pm, Dennis Zhou wrote:
> On Fri, Jul 21, 2023 at 09:18:00PM +0800, Baoquan He wrote:
> > The variable 'err' is assgigned to an error message if atomic alloc
> > failed, while it has no chance to be printed if is_atomic is true.
> > 
> > Here change to print error message too if atomic alloc failed, while
> > avoid to call dump_stack() if that case.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/percpu.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index c25b058a46ad..74f75ef0ad58 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -1890,13 +1890,15 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
> >  fail:
> >  	trace_percpu_alloc_percpu_fail(reserved, is_atomic, size, align);
> >  
> > -	if (!is_atomic && do_warn && warn_limit) {
> > +	if (do_warn && warn_limit) {
> >  		pr_warn("allocation failed, size=%zu align=%zu atomic=%d, %s\n",
> >  			size, align, is_atomic, err);
> > -		dump_stack();
> > +		if (is_atomic)
> > +			dump_stack();
> 
> This should be (!is_atomic) to preserve the current logic?

You are quite right, I must be dizzy at the moment when making change.
Will fix this. Thanks for reviewing.

> 
> >  		if (!--warn_limit)
> >  			pr_info("limit reached, disable warning\n");
> >  	}
> > +
> >  	if (is_atomic) {
> >  		/* see the flag handling in pcpu_balance_workfn() */
> >  		pcpu_atomic_alloc_failed = true;
> > -- 
> > 2.34.1
> > 
> 
> Thanks,
> Dennis
> 

