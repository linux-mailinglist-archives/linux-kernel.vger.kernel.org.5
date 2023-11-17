Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379A17EED8B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjKQIah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjKQIaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:30:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E3A1999
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700209831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ecl6gR/j9l4tmwy6aDtejNzjXal2h/loVpF3cjPsjz4=;
        b=J3T8gIx5h4eXV7W5ygkfhHYvo+8OYiggAlgoSiQ3BpaSnfyAFT1b3NvHmGSm0OmPpX6X6V
        EBFgdp2lCRZkMW2y95z4XtlG4a3JZ6zGEDYzGL4tUBqtfTSRIITLmZ/MueH2wVaHw8ObCr
        Q6OmLdyjbdsk813XsoLbCcsTgkCf52A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-LLiG_JKPObSQNwWgzPCDtw-1; Fri, 17 Nov 2023 03:30:29 -0500
X-MC-Unique: LLiG_JKPObSQNwWgzPCDtw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-54132059c6aso1476224a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700209828; x=1700814628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ecl6gR/j9l4tmwy6aDtejNzjXal2h/loVpF3cjPsjz4=;
        b=D7H1JhATpznXhGnu9jANrovQYGYcoJng0W7x2dSvkBM8kYlmpqYtJ/VM95UqSL0bIv
         LBZhH7mlFVfuZS4qukVwsKS+/PGtTU23oJ1w8hj6YQp2Xw0l/uSOrRRSOT9b6KO7lrsQ
         oAqw2KvTr7omG4FAx9Zi7UhMcZFtWCMpapJ+Lu5LVgJPRNbV/41KdO7LYk3mx0Oho0RP
         3uKGWPSFtFT13eO1KZSnu8CWSIwg1CDQZfaE3W71kUakR+V6EsRJ3feQ2uxIbKn1dRVP
         nm5ElH9SxdXsMpJ55F5eOT8va/fC6B7cB1YVhZEo9DgjGXm7DvhGBUZ4Mh0ctqVoDw1z
         ld0w==
X-Gm-Message-State: AOJu0Yzshqe8vQ28fWBBfkTCXJx5seUrQN3p3lgoSG3C22enyO+CWRHN
        Q9xGb4FkuGNSnEpOnDy6xwYFqJfYjz49ec2QvNKhXfyuW10nE4j7ToBMvjBtyd8X/kkgF8xXlzL
        voLocR2Si2N0/p6qA/ZxnwTSz
X-Received: by 2002:a17:907:b9c3:b0:9f3:18f8:475b with SMTP id xa3-20020a170907b9c300b009f318f8475bmr6952575ejc.62.1700209828355;
        Fri, 17 Nov 2023 00:30:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFPEAnGCm1WVzr07XAT0pN1kw24RqLiQT9EjkeoYuqTICFcy0cLcinJxwF//W1biZMt6dF0g==
X-Received: by 2002:a17:907:b9c3:b0:9f3:18f8:475b with SMTP id xa3-20020a170907b9c300b009f318f8475bmr6952555ejc.62.1700209828011;
        Fri, 17 Nov 2023 00:30:28 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-199.retail.telecomitalia.it. [79.46.200.199])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906b28200b009ad8acac02asm538543ejz.172.2023.11.17.00.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 00:30:27 -0800 (PST)
Date:   Fri, 17 Nov 2023 09:30:19 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v1 2/2] vsock/test: SO_RCVLOWAT + deferred credit
 update test
Message-ID: <tbvwohgvrc6kvlsyap3sk5zqww5q6schsu4szx7e23wgg7pvb3@e7xa5mg5inul>
References: <20231108072004.1045669-1-avkrasnov@salutedevices.com>
 <20231108072004.1045669-3-avkrasnov@salutedevices.com>
 <zukasb6k7ogta33c2wik6cgadg2rkacestat7pkexd45u53swh@ovso3hafta77>
 <923a6149-3bd5-c5b4-766d-8301f9e7484a@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <923a6149-3bd5-c5b4-766d-8301f9e7484a@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 10:12:38AM +0300, Arseniy Krasnov wrote:
>
>
>On 15.11.2023 14:11, Stefano Garzarella wrote:
>> On Wed, Nov 08, 2023 at 10:20:04AM +0300, Arseniy Krasnov wrote:
>>> This adds test which checks, that updating SO_RCVLOWAT value also sends
>>
>> You can avoid "This adds", and write just "Add test ...".
>>
>> See https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
>>
>>     Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
>>     instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>>     to do frotz", as if you are giving orders to the codebase to change
>>     its behaviour.
>>
>> Also in the other patch.
>>
>>> credit update message. Otherwise mutual hungup may happen when receiver
>>> didn't send credit update and then calls 'poll()' with non default
>>> SO_RCVLOWAT value (e.g. waiting enough bytes to read), while sender
>>> waits for free space at receiver's side.
>>>
>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>> ---
>>> tools/testing/vsock/vsock_test.c | 131 +++++++++++++++++++++++++++++++
>>> 1 file changed, 131 insertions(+)
>>>
>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>> index c1f7bc9abd22..c71b3875fd16 100644
>>> --- a/tools/testing/vsock/vsock_test.c
>>> +++ b/tools/testing/vsock/vsock_test.c
>>> @@ -1180,6 +1180,132 @@ static void test_stream_shutrd_server(const struct test_opts *opts)
>>>     close(fd);
>>> }
>>>
>>> +#define RCVLOWAT_CREDIT_UPD_BUF_SIZE    (1024 * 128)
>>> +#define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE    (1024 * 64)
>>
>> What about adding a comment like the one in the cover letter about
>> dependency with kernel values?
>>
>> Please add it also in the commit description.
>>
>> I'm thinking if we should move all the defines that depends on the
>> kernel in some special header.
>
>IIUC it will be new header file in tools/testing/vsock, which includes such defines. At
>this moment in will contain only VIRTIO_VSOCK_MAX_PKT_BUF_SIZE. Idea is that such defines

So this only works on the virtio transport though, not the other
transports, right? (but maybe the others don't have this problem, so
it's fine).

>are not supposed to use by user (so do not move it to uapi headers), but needed by tests
>to check kernel behaviour. Please correct me if i'm wrong.

Right!
Maybe if it's just one, we can leave it there for now, but with a
comment on top explaining where it comes.

Thanks,
Stefano

