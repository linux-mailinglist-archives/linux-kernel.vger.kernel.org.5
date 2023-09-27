Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8F87B03A8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjI0MNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjI0MNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF6CCD9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 05:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695816746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CxP1yuTUEp+02dovUMlVDBiyWThstH4vw04Sljh8/2M=;
        b=JPgll2/4REwrVIgi8gxUIKdBs2UAB1b9aTAQ38NE5Tyki1BFHlRp/BvaP8rkw04DTwUdJl
        s+xKBrayBJCC43Es9HL0fREJbCi0zPzQ9lHZ6rrltbSYrmFEJaC3JPrXyR3OU/jjsFSVhu
        vhr+lLx8kzQDSc7Nr2kJXjJetaBIA/w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-ztKu2Z9SNPCpTK5kJ19O1w-1; Wed, 27 Sep 2023 08:12:21 -0400
X-MC-Unique: ztKu2Z9SNPCpTK5kJ19O1w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FDA5811E7B;
        Wed, 27 Sep 2023 12:12:21 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFC44492B05;
        Wed, 27 Sep 2023 12:12:20 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
In-Reply-To: <20230927132536.4b19ab2f.pasic@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
 <20230926184158.4ca2c0c3.pasic@linux.ibm.com> <877coc2aj8.fsf@redhat.com>
 <20230927132536.4b19ab2f.pasic@linux.ibm.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date:   Wed, 27 Sep 2023 14:12:19 +0200
Message-ID: <874jjf3jdo.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27 2023, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 27 Sep 2023 12:08:43 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> > On the other hand virtio_airq_handler() calls vring_interrupt() with
>> > interrupts enabled. (While vring_interrupt() is called in a (read)
>> > critical section in virtio_airq_handler() we use read_lock() and
>> > not read_lock_irqsave() to grab the lock. Whether that is correct in
>> > it self (i.e. disregarding the crypto problem) or not I'm not sure right
>> > now. Will think some more about it tomorrow.) If the way to go forward
>> > is disabling interrupts in virtio-ccw before vring_interrupt() is
>> > called, I would be glad to spin a patch for that.  
>> 
>> virtio_airq_handler() is supposed to be an interrupt handler for an
>> adapter interrupt -- as such I would expect it to always run with
>> interrupts disabled (and I'd expect vring_interrupt() to be called
>> with interrupts disabled as well; if that's not the case, I think it
>> would need to run asynchronously.) At least that was my understanding at
>> the time I wrote the code.
>
> Thanks Connie! I don't quite understand what do you mean by "run with
> interrupts disabled" in this context.
>
> Do you mean that if I were to add the following warning:
>
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index ac67576301bf..2a9c73f5964f 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -211,6 +211,8 @@ static void virtio_airq_handler(struct airq_struct *airq,
>         struct airq_info *info = container_of(airq, struct airq_info, airq);
>         unsigned long ai;
>  
> +       WARN_ONCE(in_irq(), "irqs are ought to be disabled but are not\n");
> +
>         inc_irq_stat(IRQIO_VAI);
>
> it would/should never trigger, or do you mean something different?
>
> If yes, does that mean that you would expect the common airq code (i.e. something
> like do_airq_interrupt()) to disable interrupts, or call virtio_airq_handler()?
> asynchronously sort of as a bottom half (my understanding of bottom halves is currently
> not complete).
>
> If no what do you actually mean?

My understanding (at the time) was that we're coming from the low-level
interrupt handler (which disables interrupts via the NEW PSW);
interrupts will be re-enabled once the basic processing is done. This
might no longer be the case, but I currently don't have the time to dig
into the code -- it has been some time.

