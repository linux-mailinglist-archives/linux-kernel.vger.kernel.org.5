Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3A27B0191
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjI0KKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjI0KKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:10:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C701B6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 03:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695809329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iuruE1nulZgndw+cQHO0vj1TexCC3+sKU/XFHVoq3fQ=;
        b=bbbAi4MZTEGmpfStSCmsegtoVKFjJm6d738RTx52LcyREL8AgUjLRrab79oump1tbfYYya
        cxsM52sJZtLCxoMCEg1+yUkP8TmGHXCCc3AFSdo4brX+3sG5bXMzki2roLbS0Bk/d8g9Kr
        +VvsesakLsbbZuyfuvZDsxZGVlujpps=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-H03athJJOsSVs1ir8KZCwg-1; Wed, 27 Sep 2023 06:08:46 -0400
X-MC-Unique: H03athJJOsSVs1ir8KZCwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 761551C06E14;
        Wed, 27 Sep 2023 10:08:45 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7773214026F7;
        Wed, 27 Sep 2023 10:08:44 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
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
In-Reply-To: <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
 <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date:   Wed, 27 Sep 2023 12:08:43 +0200
Message-ID: <877coc2aj8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26 2023, Halil Pasic <pasic@linux.ibm.com> wrote:

> [..]
>> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>> @@ -61,8 +61,9 @@ static void virtio_crypto_akcipher_finalize_req(
>>  	vc_akcipher_req->src_buf = NULL;
>>  	vc_akcipher_req->dst_buf = NULL;
>>  	virtcrypto_clear_request(&vc_akcipher_req->base);
>> -
>> +	local_bh_disable();
>>  	crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine, req, err);
>> +	local_bh_enable();
>
> Thanks Gonglei!
>
> I did this a quick spin, and it does not seem to be sufficient on s390x.
> Which does not come as a surprise to me, because 
>
> #define lockdep_assert_in_softirq()                                     \
> do {                                                                    \
>         WARN_ON_ONCE(__lockdep_enabled                  &&              \
>                      (!in_softirq() || in_irq() || in_nmi()));          \
> } while (0)
>
> will still warn because  in_irq() still evaluates to true (your patch
> addresses the !in_softirq() part).
>
> I don't have any results on x86 yet. My current understanding is that the
> virtio-pci transport code disables interrupts locally somewhere in the
> call chain (actually in vp_vring_interrupt() via spin_lock_irqsave())
> and then x86 would be fine. But I will get that verified.
>
> On the other hand virtio_airq_handler() calls vring_interrupt() with
> interrupts enabled. (While vring_interrupt() is called in a (read)
> critical section in virtio_airq_handler() we use read_lock() and
> not read_lock_irqsave() to grab the lock. Whether that is correct in
> it self (i.e. disregarding the crypto problem) or not I'm not sure right
> now. Will think some more about it tomorrow.) If the way to go forward
> is disabling interrupts in virtio-ccw before vring_interrupt() is
> called, I would be glad to spin a patch for that.

virtio_airq_handler() is supposed to be an interrupt handler for an
adapter interrupt -- as such I would expect it to always run with
interrupts disabled (and I'd expect vring_interrupt() to be called
with interrupts disabled as well; if that's not the case, I think it
would need to run asynchronously.) At least that was my understanding at
the time I wrote the code.

>
> Copying Conny, as she may have an opinion on this (if I'm not wrong she
> authored that code).
>
> Regards,
> Halil

