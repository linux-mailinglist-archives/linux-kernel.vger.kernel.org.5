Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DE7810CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjLMIne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMInc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:43:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CC1A5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702457018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ypvU2CFpvjA4GuEgMA1XFzF02HXPcVncJHhzWckfAo=;
        b=A07qou8zhN6INiRcZo6Jts8WashAl5Jg07IQHHatmwFCJPqJWiHlCbGsya6DH2IBb0WvGX
        OoRfwAHiVD4WZCF+4VCQanrhJfEN8dRQmx1LJFzOcYXV4iWyTEX4eg2KZ+0ltjWEHAfcm4
        PAHkFbg8YdslPsD7iEErztnLy+zIgbM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-FF4Fc9isObm51ggMkN8Sbw-1; Wed, 13 Dec 2023 03:43:37 -0500
X-MC-Unique: FF4Fc9isObm51ggMkN8Sbw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33641bbc49dso67628f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702457016; x=1703061816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ypvU2CFpvjA4GuEgMA1XFzF02HXPcVncJHhzWckfAo=;
        b=uhgNezomL6n52OWoJbCR5K/523LTXQsyExxVZP4QaNfNkfzC6agxtudFfMQKOEhIp5
         XLxvC4UPh72mkXdWJMRoUYvZh4zjDJeeZ9Zawkl1EULdqX4AGZNz1RW7mXnwvZ1B86qB
         XyNGFk+eT62b0oibf/2m2FhRnJyHIjcMNgkY2Z7hvT+zqZgu8E3/Mut88aJUgMZD8aga
         +izcB4gp4UfNt69HnYzI4uoZCOX4Qkx/qUv8MoZhZ6wJ5eb/ZIKFn9d+AlVs52KH0nrC
         ejqZPqm42oozQCduXQFW3FohDKqpNj1UlrfSc9xZ5KpgHRYXmz3vddkEeadQSuKrTpal
         BeFQ==
X-Gm-Message-State: AOJu0Yxe4fJgCAxZ9XbkKbZ94usrQa0yMRte/gQx7RHsLT9DwjIhegck
        0+aIE2Ycv6bvAvchMvq3D8vGarKYarhS5xCp2jwz0w6tUQxtqYtkGLSSIZPZg0WdLk7RBttFemZ
        sVe6IVQFC1nv0pZAmpfWJNQnz
X-Received: by 2002:a05:600c:401:b0:40c:26ef:b24b with SMTP id q1-20020a05600c040100b0040c26efb24bmr3913393wmb.188.1702457015950;
        Wed, 13 Dec 2023 00:43:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1lQ4+EUeiLIk83v4dqAAgqvxh6iPVGvNgRE5vCofRk3mqgAvKUjUC7mCTX0q96Nl9r/GPpQ==
X-Received: by 2002:a05:600c:401:b0:40c:26ef:b24b with SMTP id q1-20020a05600c040100b0040c26efb24bmr3913382wmb.188.1702457015584;
        Wed, 13 Dec 2023 00:43:35 -0800 (PST)
Received: from sgarzare-redhat ([5.179.184.12])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0040b48690c49sm19575443wms.6.2023.12.13.00.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 00:43:35 -0800 (PST)
Date:   Wed, 13 Dec 2023 09:43:29 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH net-next v8 0/4] send credit update during setting
 SO_RCVLOWAT
Message-ID: <ucmekzurgt3zcaezzdkk6277ukjmwaoy6kdq6tzivbtqd4d32b@izqbcsixgngk>
References: <20231211211658.2904268-1-avkrasnov@salutedevices.com>
 <20231212105423-mutt-send-email-mst@kernel.org>
 <d27f22f0-0f1e-e1bb-5b13-a524dc6e94d7@salutedevices.com>
 <20231212111131-mutt-send-email-mst@kernel.org>
 <7b362aef-6774-0e08-81e9-0a6f7f616290@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7b362aef-6774-0e08-81e9-0a6f7f616290@salutedevices.com>
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

On Tue, Dec 12, 2023 at 08:43:07PM +0300, Arseniy Krasnov wrote:
>
>
>On 12.12.2023 19:12, Michael S. Tsirkin wrote:
>> On Tue, Dec 12, 2023 at 06:59:03PM +0300, Arseniy Krasnov wrote:
>>>
>>>
>>> On 12.12.2023 18:54, Michael S. Tsirkin wrote:
>>>> On Tue, Dec 12, 2023 at 12:16:54AM +0300, Arseniy Krasnov wrote:
>>>>> Hello,
>>>>>
>>>>>                                DESCRIPTION
>>>>>
>>>>> This patchset fixes old problem with hungup of both rx/tx sides and adds
>>>>> test for it. This happens due to non-default SO_RCVLOWAT value and
>>>>> deferred credit update in virtio/vsock. Link to previous old patchset:
>>>>> https://lore.kernel.org/netdev/39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru/
>>>>
>>>>
>>>> Patchset:
>>>>
>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>
>>> Thanks!
>>>
>>>>
>>>>
>>>> But I worry whether we actually need 3/8 in net not in net-next.
>>>
>>> Because of "Fixes" tag ? I think this problem is not critical and reproducible
>>> only in special cases, but i'm not familiar with netdev process so good, so I don't
>>> have strong opinion. I guess @Stefano knows better.
>>>
>>> Thanks, Arseniy
>>
>> Fixes means "if you have that other commit then you need this commit
>> too". I think as a minimum you need to rearrange patches to make the
>> fix go in first. We don't want a regression followed by a fix.
>
>I see, ok, @Stefano WDYT? I think rearrange doesn't break anything, 
>because this
>patch fixes problem that is not related with the new patches from this patchset.

I agree, patch 3 is for sure net material (I'm fine with both 
rearrangement or send it separately), but IMHO also patch 2 could be.
I think with the same fixes tag, since before commit b89d882dc9fc 
("vsock/virtio: reduce credit update messages") we sent a credit update
for every bytes we read, so we should not have this problem, right?

So, maybe all the series could be "net".

Thanks,
Stefano

