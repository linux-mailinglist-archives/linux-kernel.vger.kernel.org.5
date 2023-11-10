Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33237E80E8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345352AbjKJSTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346350AbjKJSRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:17:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977EC37AD9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 05:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699623512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhGFfybuff2Qmeqe9devpGi45Zd/ojFhI6kY0snP7e8=;
        b=ftcw7rqwm0tZbdiXdrs03R6ortIcFo5d+9SVtCO0G/8+f5RxG2nVp14mf9kKDu6kHKuU0y
        NJjx2Tcqw3y6s4bpy1ZolRF4Z+3VIM7BMfc8QrMHsB70+kRB8mMMe8UVxK0hXbMMehNRCk
        W4zUywATwtyGxQEBAU8uPpDiM3A0Ais=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-kQrp9cnPPi2u2Y9Na177AQ-1; Fri,
 10 Nov 2023 08:38:26 -0500
X-MC-Unique: kQrp9cnPPi2u2Y9Na177AQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39A8E2806680;
        Fri, 10 Nov 2023 13:38:26 +0000 (UTC)
Received: from [10.22.17.86] (unknown [10.22.17.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D87BFC15881;
        Fri, 10 Nov 2023 13:38:25 +0000 (UTC)
Message-ID: <5e221be7-b97c-41a4-e118-128a570befdc@redhat.com>
Date:   Fri, 10 Nov 2023 08:38:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] locking/rwsem: Remove unnessary check in
 rwsem_down_read_slowpath()
Content-Language: en-US
To:     Haifeng Xu <haifeng.xu@shopee.com>,
        Tang Yizhou <yizhou.tang@shopee.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org
References: <20231108105639.70088-1-haifeng.xu@shopee.com>
 <6da49b39-653a-1eda-2d21-1f1b50cb14f0@redhat.com>
 <5086cd5b-a832-4250-9927-4b300d2f611e@shopee.com>
 <CACuPKxnSKQuyWWCtjmmNWP0apja28jWpdYWaKWouArsQA02axQ@mail.gmail.com>
 <bc934b85-9371-4758-b595-814b98f9c595@shopee.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <bc934b85-9371-4758-b595-814b98f9c595@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/10/23 05:29, Haifeng Xu wrote:
>
> On 2023/11/10 14:54, Tang Yizhou wrote:
>> On Thu, Nov 9, 2023 at 11:17 AM Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>> reader          writer                                  reader
>>>
>>> acquire
>>> release
>>>                  rwsem_write_trylock
>>>                          set RWSEM_WRITER_LOCKED
>>>                                                          rwsem_down_read_slowpath
>>>                          set owner
>>>
>>> If prev lock holder is a reader, when it releases the lock, the owner isn't cleared(CONFIG_DEBUG_RWSEMS isn't enabled).
>>> A writer comes and can set the RWSEM_WRITER_LOCKED bit succsessfully, then a new reader run into slow path, before
>>> the writer set the owner, the new reader will see that both the RWSEM_READER_OWNED bit and RWSEM_WRITER_LOCKED bit are
>>> set.
>>>
>> For the above example, it won't cause a problem. When the writer
>> successfully sets RWSEM_WRITER_LOCKED, the reader, when reading rcnt
>> through rwsem_down_read_slowpath(), will see that rcnt is 0 and will
>> jump to the queue label.
>>
>> Thanks,
>> Tang
> Yes, so if rcnt > 1, the RWSEM_WRITER_LOCKED bit couldn't be set?

No. The way readers acquire the lock is via 
atomic_long_add_return_acquire() without looking at current state of the 
rwsem (write-locked or not). So rcnt can be greater than 0 and the rwsem 
is still writer-owned.

Because of that atomic_long_add_return_acquire() primitive, rcnt 
includes its reader count. The lock may be read-locked if only if there 
is at least one other reader present. So rcnt must be bigger than 1.

Cheers,
Longman

