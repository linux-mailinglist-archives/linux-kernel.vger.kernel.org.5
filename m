Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3677A9032
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjIUAiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIUAiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D32A3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 17:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695256634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sIeT6oKFPwWhpIqsPUhn38LsLAfdBKRDItzRW8BwkBk=;
        b=HsoEgtlcS+FPW9tzuntTISr7O8u1C0eJ/Bh3/JEcc4pmM1DVTWUDFfPxfxc2dW6bLyI5Or
        GLDDRG0IGVpyyZnia9GXS/HjmlTQTn6p2Opr+hxLiG9W1WTFucgcT4mv7JeAtlniTpWlEN
        jX++TEW7iOwsambyvTKAzJaEDJ9CkVQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-Ou0F_-LkNcyYakAVjaCckg-1; Wed, 20 Sep 2023 20:37:10 -0400
X-MC-Unique: Ou0F_-LkNcyYakAVjaCckg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 133F3811E92;
        Thu, 21 Sep 2023 00:37:10 +0000 (UTC)
Received: from [10.22.33.160] (unknown [10.22.33.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD66640C6EC0;
        Thu, 21 Sep 2023 00:37:09 +0000 (UTC)
Message-ID: <75c8dce2-0b66-0d5a-3e95-fb6e0a248597@redhat.com>
Date:   Wed, 20 Sep 2023 20:37:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] locking/semaphore: Use wake_q to wake up processes
 outside lock critical section
Content-Language: en-US
To:     John Stultz <jstultz@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20220909192848.963982-1-longman@redhat.com>
 <CANDhNCpsDbz9ZT+h4Zcq-7QMJ-uqs3rW+MXCVcbi2A2hnTjBpQ@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CANDhNCpsDbz9ZT+h4Zcq-7QMJ-uqs3rW+MXCVcbi2A2hnTjBpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 20:05, John Stultz wrote:
> On Fri, Sep 9, 2022 at 12:28 PM Waiman Long <longman@redhat.com> wrote:
>> It was found that a circular lock dependency can happen with the
>> following locking sequence:
>>
>>     +--> (console_sem).lock --> &p->pi_lock --> &rq->__lock --+
>>     |                                                         |
>>     +---------------------------------------------------------+
>>
>> The &p->pi_lock --> &rq->__lock sequence is very common in all the
>> task_rq_lock() calls.
> Thanks for sending this out! I've been hitting these lockdep warningns
> a lot recently, particularly if I have any debug printks/WARN_ONs in
> the scheduler that trip, so I'm eager to get a fix for this!
>
> That said, running with your patch, I'm seeing bootup hang pretty
> close to where init starts when I've had a fair amount of debug
> printks go off. It's odd because the lockup detectors don't seem to
> fire.
> I'll try to debug further, but wanted to give you a heads up. Let me
> know if you have any suggestions.

Thanks for testing this patch. This was not merged because Peter thought 
the merging of atomic console would probably make this not an issue at 
all. We are close to getting the atomic console merged. Let's see if 
this is really the case.

Cheers,
Longman

