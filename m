Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC36B7D3BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjJWQLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWQLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A815E9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698077446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uM6IGtTXgNreBRSdHRcyHDWS2q1BSGKyDG55d0zg7uE=;
        b=WJwCcHOwItbT+Ps4H76g//bpTGELOewJv0+XNXwc9LPXL93EwbIHNctWHwol9uF7+xbRiz
        oVU2SY1tD4KbhuR1oVW3ek1f7zyu29qyo1T99864XvmRCBtQD3ulLvGa0Zuq/RISt1zUC8
        eNQmi6sNfG84/Cu/WxYNcdrV25kJnqk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-pVWEboj6MBKGGZL8R9URWg-1; Mon, 23 Oct 2023 12:10:35 -0400
X-MC-Unique: pVWEboj6MBKGGZL8R9URWg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-66da680f422so28437526d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698077434; x=1698682234;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uM6IGtTXgNreBRSdHRcyHDWS2q1BSGKyDG55d0zg7uE=;
        b=lmipJzUWsRUmP5B0rVBMvYub61AvViiU9JI9TR7zZ8o9T3bhIY9JzgpANLMuoR4d+t
         Z1eHMgTapBzkIgqYtaRNQZn6+F9Eumui6W2I2MNYRuhBAQFba1ewMLKRDnTeJDh2Lu7+
         hmIj9WhsaJoXGEakMlFWUaQ4MeHZM/39RmrGRbLtf0wgTQXklvATlsvl7wp/QWvhgj/V
         d1GiX//f0DSO84edxhGL6uIkcweeZXSwcXeYGLm0RpwdzJN2tLxA2FA7ERqKJzQhpq8r
         H0DXKKqN8dSl2jwrjm9lnE059P3b1k8SxcUgZeedqv9LO4Gwy1Xm0/H6HxzE7zM+i4Ky
         zeqg==
X-Gm-Message-State: AOJu0Yyf13S+0c55FDT/hjpbDIoXBM1q5AG2JRtgkARptX55qdCgpItg
        +wb5tjLQxPB2RIefyNg5TMYIhh9MohkoqaflqkGpjx9oYsHXIdRSMlLcp5Q/8CzG8ofuvEbqsTR
        +vcRj5tUi5yggiINIqL1N0+NP
X-Received: by 2002:a05:6214:c2a:b0:66d:818f:a483 with SMTP id a10-20020a0562140c2a00b0066d818fa483mr10587090qvd.32.1698077434687;
        Mon, 23 Oct 2023 09:10:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXvJRhDKCA/YN/pdkU/PNM0UdgNdRiMmQ0LK/XFZjxqjKVtJ/tiIKHk5iR/BGmtnOfa3u01A==
X-Received: by 2002:a05:6214:c2a:b0:66d:818f:a483 with SMTP id a10-20020a0562140c2a00b0066d818fa483mr10587070qvd.32.1698077434403;
        Mon, 23 Oct 2023 09:10:34 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it. [87.12.185.56])
        by smtp.gmail.com with ESMTPSA id bz18-20020ad44c12000000b0065b29403540sm2960253qvb.127.2023.10.23.09.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 09:10:34 -0700 (PDT)
Date:   Mon, 23 Oct 2023 18:10:23 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Alexandru Matei <alexandru.matei@uipath.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mihai Petrisor <mihai.petrisor@uipath.com>,
        Viorel Canja <viorel.canja@uipath.com>
Subject: Re: [PATCH v2] vsock/virtio: initialize the_virtio_vsock before
 using VQs
Message-ID: <jyjfsjvfmmr7ucf53v6p57scdxah64bgvd2lj7l4hbjwiyd2ct@lj3ejlseqvog>
References: <20231023140833.11206-1-alexandru.matei@uipath.com>
 <2tc56vwgs5xwqzfqbv5vud346uzagwtygdhkngdt3wjqaslbmh@zauky5czyfkg>
 <0624137c-85cf-4086-8256-af2b8405f434@uipath.com>
 <632465d0-e04c-4e10-abb9-a740d6e3dc30@uipath.com>
 <dynlbzmgtr35byn5etbar33ufhweii6gk2pct5wpqxpqubchce@cltop4aar7r6>
 <01ad7d00-9a53-445b-8916-3342047112a0@uipath.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01ad7d00-9a53-445b-8916-3342047112a0@uipath.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 06:36:21PM +0300, Alexandru Matei wrote:
>On 10/23/2023 6:13 PM, Stefano Garzarella wrote:
>> On Mon, Oct 23, 2023 at 05:59:45PM +0300, Alexandru Matei wrote:
>>> On 10/23/2023 5:52 PM, Alexandru Matei wrote:
>>>> On 10/23/2023 5:29 PM, Stefano Garzarella wrote:
>>>>> On Mon, Oct 23, 2023 at 05:08:33PM +0300, Alexandru Matei wrote:
>>>>>> Once VQs are filled with empty buffers and we kick the host,
>>>>>> it can send connection requests.  If 'the_virtio_vsock' is not
>>>>>> initialized before, replies are silently dropped and do not reach the host.
>>>>>>
>>>>>> Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
>>>>>> Signed-off-by: Alexandru Matei <alexandru.matei@uipath.com>
>>>>>> ---
>>>>>> v2:
>>>>>> - split virtio_vsock_vqs_init in vqs_init and vqs_fill and moved
>>>>>>  the_virtio_vsock initialization after vqs_init
>>>>>>
>>>>>> net/vmw_vsock/virtio_transport.c | 9 +++++++--
>>>>>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>>>>>> index e95df847176b..92738d1697c1 100644
>>>>>> --- a/net/vmw_vsock/virtio_transport.c
>>>>>> +++ b/net/vmw_vsock/virtio_transport.c
>>>>>> @@ -559,6 +559,11 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
>>>>>>     vsock->tx_run = true;
>>>>>>     mutex_unlock(&vsock->tx_lock);
>>>>>>
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static void virtio_vsock_vqs_fill(struct virtio_vsock *vsock)
>>>>>
>>>>> What about renaming this function in virtio_vsock_vqs_start() and move also the setting of `tx_run` here?
>>>>
>>>> It works but in this case we also need to move rcu_assign_pointer in virtio_vsock_vqs_start(),
>>>> the assignment needs to be right after setting tx_run to true and before filling the VQs.
>>
>> Why?
>>
>> If `rx_run` is false, we shouldn't need to send replies to the host IIUC.
>>
>> If we need this instead, please add a comment in the code, but also in the commit, because it's not clear why.
>>
>
>We need rcu_assign_pointer after setting tx_run to true for connections 
>that are initiated from the guest -> host.
>virtio_transport_connect() calls virtio_transport_send_pkt().  Once 
>'the_virtio_vsock' is initialized, virtio_transport_send_pkt() will 
>queue the packet,
>but virtio_transport_send_pkt_work() will exit if tx_run is false.

Okay, but in this case we could safely queue &vsock->send_pkt_work after 
finishing initialization to send those packets queued earlier.

In the meantime I'll try to see if we can leave the initialization of 
`the_virtio_vsock` as the ulitmate step and maybe go out first in the 
workers if it's not set.

That way just queue all the workers after everything is done and we 
should be fine.

>
>>>>
>>>
>>> And if we move rcu_assign_pointer then there is no need to split the function in two,
>>> We can move rcu_assign_pointer() directly inside virtio_vsock_vqs_init() after setting tx_run.
>>
>> Yep, this could be another option, but we need to change the name of that function in this case.
>>
>
>OK, how does virtio_vsock_vqs_setup() sound?

Or virtio_vsock_start() (without vqs)

Stefano

>
>> Stefano
>>
>>>
>>>>>
>>>>> Thanks,
>>>>> Stefano
>>>>>
>>>>>> +{
>>>>>>     mutex_lock(&vsock->rx_lock);
>>>>>>     virtio_vsock_rx_fill(vsock);
>>>>>>     vsock->rx_run = true;
>>>>>> @@ -568,8 +573,6 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
>>>>>>     virtio_vsock_event_fill(vsock);
>>>>>>     vsock->event_run = true;
>>>>>>     mutex_unlock(&vsock->event_lock);
>>>>>> -
>>>>>> -    return 0;
>>>>>> }
>>>>>>
>>>>>> static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>>>>>> @@ -664,6 +667,7 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>>>>>>         goto out;
>>>>>>
>>>>>>     rcu_assign_pointer(the_virtio_vsock, vsock);
>>>>>> +    virtio_vsock_vqs_fill(vsock);
>>>>>>
>>>>>>     mutex_unlock(&the_virtio_vsock_mutex);
>>>>>>
>>>>>> @@ -736,6 +740,7 @@ static int virtio_vsock_restore(struct virtio_device *vdev)
>>>>>>         goto out;
>>>>>>
>>>>>>     rcu_assign_pointer(the_virtio_vsock, vsock);
>>>>>> +    virtio_vsock_vqs_fill(vsock);
>>>>>>
>>>>>> out:
>>>>>>     mutex_unlock(&the_virtio_vsock_mutex);
>>>>>> -- 
>>>>>> 2.34.1
>>>>>>
>>>>>
>>>
>>
>

