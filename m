Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79697A268E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbjIOStH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbjIOSsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:48:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E33549EC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694803477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MwVI1h9XW7NmsAuoRyGJpmcokT8a2hAbZHWcQnSBgf4=;
        b=Og7PbJaoUC71HDGUq6nnuTA7fRNZ/iquT5sQGYLtthQzAXFHOuUttNkEKavtfxLprqWA5o
        Of6qOBcYW3DAr+F5HfWkJxbZG81RAoSno56NJIK1H8XeWYe7lysaldYDql8aq1/Wo1Etyh
        YNZopI7zJ5xNhmtOfiB4uDNQvdbq5uk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-Ga2I0f1QNDGO_jiltzFOcQ-1; Fri, 15 Sep 2023 14:44:33 -0400
X-MC-Unique: Ga2I0f1QNDGO_jiltzFOcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 291A681652C;
        Fri, 15 Sep 2023 18:44:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.37])
        by smtp.corp.redhat.com (Postfix) with SMTP id 753E540C6EC0;
        Fri, 15 Sep 2023 18:44:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 15 Sep 2023 20:43:38 +0200 (CEST)
Date:   Fri, 15 Sep 2023 20:43:35 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] seqlock: introduce seqprop_lock/unlock
Message-ID: <20230915184334.GA1650@redhat.com>
References: <20230913154907.GA26210@redhat.com>
 <20230913155000.GA26248@redhat.com>
 <ZQShm4QAeAtjR8EK@example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQShm4QAeAtjR8EK@example.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/15, Alexey Gladkov wrote:
>
> On Wed, Sep 13, 2023 at 05:50:00PM +0200, Oleg Nesterov wrote:
> > +									\
> > +static __always_inline void						\
> > +__seqprop_##lockname##_lock(seqcount_##lockname##_t *s,			\
> > +				locktype *lock)				\
> > +{									\
> > +	__SEQ_LOCK(WARN_ON_ONCE(s->lock != lock));			\
> > +	lockbase##_lock(lock);						\
> > +}									\
> > +									\
> > +static __always_inline void						\
> > +__seqprop_##lockname##_unlock(seqcount_##lockname##_t *s,		\
> > +				locktype *lock)				\
> > +{									\
> > +	lockbase##_unlock(lock); 					\
> >  }
>
> Why are you creating a new method with an unused argument s ?

To make it consistent/symmetrical with _lock() which does
__SEQ_LOCK(WARN_ON_ONCE(s->lock != lock)). _unlock() could do the
same check as well, but somehow I decided it would be too much.

And with other "methods". Say, __seqprop_##lockname##_preemptible(s)
doesn't use 's' too.

Otherwise they both do not need the 1st seqcount_##lockname##_t *s
argument.

Oleg.

