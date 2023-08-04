Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A9E7703D3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjHDPDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjHDPDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98EF49CB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691161339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oAWIlYpJLnUymxT3pJEp6AXLP821uJJ5c8Qht/hXEKc=;
        b=IhAi8CR2++lvrfTF0BA57ZDNrg0NfpGXCZJ7X/byYdJTHoCK2+QMlDGx16E073YjvmeT0R
        qhjI8ROrld8gZY7Lm07+mXJqMNYK0TvAF0xwq1hvKpA+OTVEsuenNq7l+xjRctuN/P7Yzw
        qrwnhCucHhjMC/tumFA5hhUyK+PlGvk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-uaoaeaAKNfa0-X-aI4Yaaw-1; Fri, 04 Aug 2023 11:02:17 -0400
X-MC-Unique: uaoaeaAKNfa0-X-aI4Yaaw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99bebfada8cso142930866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 08:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691161336; x=1691766136;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAWIlYpJLnUymxT3pJEp6AXLP821uJJ5c8Qht/hXEKc=;
        b=Cuj6vlwJRzdT2VmTjzsZggFlcGHQ+/7bhmB/iCnrikc8AbKkkQRW2r3QTIaYF4yEjT
         LVr/NjbviP+OE6nqZAgzc6ISazaq8JzLYTV5KBuYkCp3ERmDJXW9Y3fk16SVtvgYjmlh
         Kbwn4STYrZgXOZ607y0u4j8HM7biN+W37JnEOZpylFWPAiwkWMU3Y50MG+aJDTJBKnT+
         pA3Jp0nQrbfxoSSyo6XjY+KCixnWaQBBYsLwSfRJEsNCjfWWwUnf2dkD/5mAP+juUjKh
         xIYx8t76Y+dUd11uyHWXkuM7Oz7kR0SgRKyt9QOcwSUBUaH9Qg8Nq7ump1N4vvrq0TyQ
         Covg==
X-Gm-Message-State: AOJu0YzIZJ/cnRxzTPk2yUQIqFA3X9Xodiv5GAFpRUUj5825dJi07Inw
        A+MDsgH6GYlOwNUEg2iqHTCw9ys3Hzxo7C4kfSy7x38cuQyUhd3H2LepktANo42ak8UI8zGAg3F
        akMHBtpluOGUzG0f3K7guA+q/
X-Received: by 2002:a17:906:308d:b0:99c:5708:496f with SMTP id 13-20020a170906308d00b0099c5708496fmr1476062ejv.47.1691161336694;
        Fri, 04 Aug 2023 08:02:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4buQlfj5+z9A6xIc2zcmROIFoujfZijSLwc66A0Da2XFPINrE4kSVfdcb8SyEajwJi0yrCg==
X-Received: by 2002:a17:906:308d:b0:99c:5708:496f with SMTP id 13-20020a170906308d00b0099c5708496fmr1476035ejv.47.1691161336276;
        Fri, 04 Aug 2023 08:02:16 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-214.retail.telecomitalia.it. [82.57.51.214])
        by smtp.gmail.com with ESMTPSA id lc21-20020a170906f91500b00992b510089asm1414920ejb.84.2023.08.04.08.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 08:02:15 -0700 (PDT)
Date:   Fri, 4 Aug 2023 17:02:12 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <oxffffaa@gmail.com>
Cc:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
Subject: Re: [RFC PATCH v1 1/2] vsock: send SIGPIPE on write to shutdowned
 socket
Message-ID: <e2ytj5asmxnyb7oebxpzfuithtidwzcwxki7aao2q344sg3yru@ezqk5iezf3i4>
References: <20230801141727.481156-1-AVKrasnov@sberdevices.ru>
 <20230801141727.481156-2-AVKrasnov@sberdevices.ru>
 <qgn26mgfotc7qxzp6ad7ezkdex6aqniv32c5tvehxh4hljsnvs@x7wvyvptizxx>
 <44fef482-579a-fed6-6e8c-d400546285fc@gmail.com>
 <bzkwqp26joyzgvqyoypyv43wv7t3b6rzs3v5hkch45yggmrzp6@25byvzqwiztb>
 <140bb8ec-f443-79f9-662b-0c4e972c8dd6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <140bb8ec-f443-79f9-662b-0c4e972c8dd6@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 05:34:20PM +0300, Arseniy Krasnov wrote:
>
>
>On 04.08.2023 17:28, Stefano Garzarella wrote:
>> On Fri, Aug 04, 2023 at 03:46:47PM +0300, Arseniy Krasnov wrote:
>>> Hi Stefano,
>>>
>>> On 02.08.2023 10:46, Stefano Garzarella wrote:
>>>> On Tue, Aug 01, 2023 at 05:17:26PM +0300, Arseniy Krasnov wrote:
>>>>> POSIX requires to send SIGPIPE on write to SOCK_STREAM socket which was
>>>>> shutdowned with SHUT_WR flag or its peer was shutdowned with SHUT_RD
>>>>> flag. Also we must not send SIGPIPE if MSG_NOSIGNAL flag is set.
>>>>>
>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>> ---
>>>>> net/vmw_vsock/af_vsock.c | 3 +++
>>>>> 1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>>> index 020cf17ab7e4..013b65241b65 100644
>>>>> --- a/net/vmw_vsock/af_vsock.c
>>>>> +++ b/net/vmw_vsock/af_vsock.c
>>>>> @@ -1921,6 +1921,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
>>>>>             err = total_written;
>>>>>     }
>>>>> out:
>>>>> +    if (sk->sk_type == SOCK_STREAM)
>>>>> +        err = sk_stream_error(sk, msg->msg_flags, err);
>>>>
>>>> Do you know why we don't need this for SOCK_SEQPACKET and SOCK_DGRAM?
>>>
>>> Yes, here is my explanation:
>>>
>>> This function checks that input error is SIGPIPE, and if so it sends SIGPIPE to the 'current' thread
>>> (except case when MSG_NOSIGNAL flag is set). This behaviour is described in POSIX:
>>>
>>> Page 367 (description of defines from sys/socket.h):
>>> MSG_NOSIGNAL: No SIGPIPE generated when an attempt to send is made on a stream-
>>> oriented socket that is no longer connected.
>>>
>>> Page 497 (description of SOCK_STREAM):
>>> A SIGPIPE signal is raised if a thread sends on a broken stream (one that is
>>> no longer connected).
>>
>> Okay, but I think we should do also for SEQPACKET:
>>
>> https://pubs.opengroup.org/onlinepubs/009696699/functions/xsh_chap02_10.html
>>
>> In 2.10.6 Socket Types:
>>
>> "The SOCK_SEQPACKET socket type is similar to the SOCK_STREAM type, and
>> is also connection-oriented. The only difference between these types is
>> that record boundaries ..."
>>
>> Then in  2.10.14 Signals:
>>
>> "The SIGPIPE signal shall be sent to a thread that attempts to send data
>> on a socket that is no longer able to send. In addition, the send
>> operation fails with the error [EPIPE]."
>>
>> It's honestly not super clear, but I assume the problem is similar with
>> seqpacket since it's connection-oriented, or did I miss something?
>>
>> For example in sctp_sendmsg() IIUC we raise a SIGPIPE regardless of
>> whether the socket is STREAM or SEQPACKET.
>
>Hm, yes, you're right. Seems check for socket type is not needed in this case,
>as this function is only for connection oriented sockets.

Ack!

>
>>
>>>
>>> Page 1802 (description of 'send()' call):
>>> MSG_NOSIGNAL
>>>
>>> Requests not to send the SIGPIPE signal if an attempt to
>>> send is made on a stream-oriented socket that is no
>>> longer connected. The [EPIPE] error shall still be
>>> returned
>>>
>>> And the same for 'sendto()' and 'sendmsg()'
>>>
>>> Link to the POSIX document:
>>> https://www.open-std.org/jtc1/sc22/open/n4217.pdf
>>>
>>> TCP (I think we must rely on it), KCM, SMC sockets (all of them are stream) work in the same
>>> way by calling this function. AF_UNIX also works in the same way, but it implements SIGPIPE handling
>>> without this function.
>>
>> I'm okay calling this function.
>>
>>>
>>> The only thing that confused me a little bit, that sockets above returns EPIPE when
>>> we have only SEND_SHUTDOWN set, but for AF_VSOCK EPIPE is returned for RCV_SHUTDOWN
>>> also, but I think it is related to this patchset.
>>
>> Do you mean that it is NOT related to this patchset?
>
>Yes, **NOT**

Got it, so if you have time when you're back, let's check also that
(not for this series as you mentioned).

Thanks,
Stefano

