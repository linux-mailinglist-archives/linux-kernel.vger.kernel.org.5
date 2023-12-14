Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF2E812A98
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbjLNIpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjLNIpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:45:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689D8112
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702543541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uecrAR2SvWDsLJrH3uSpDFiFSpzellwPNoFaP7Q0oHU=;
        b=QlZoOgmCrZmBFJs1x86L/yJ+EQUdnf6QIyRTtV4t94XoAP1Abopi3teYt3UD0JW2oFYGA3
        q0qZcKovP1+BxmuuXhVz6pjCVIlj6akneYJQ8RpX4tLpfc9NqmCUnDZ4GwgFzM0BpBEEVs
        rm6S+T26HI+IIjxcdk3Y40UVCxJhKPg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-KfTRiyvJOqC0mwO2hJ4Hvg-1; Thu, 14 Dec 2023 03:45:39 -0500
X-MC-Unique: KfTRiyvJOqC0mwO2hJ4Hvg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c3f0f88e3so35407435e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702543538; x=1703148338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uecrAR2SvWDsLJrH3uSpDFiFSpzellwPNoFaP7Q0oHU=;
        b=l76zKw/JI0kYHEBsyV5lJuz/G6QSGrOSQLSWiafTv3G7rbqGM0lC/RM2BwhHtbytq1
         9qA/B0VZeeG5qn5H5mZB8ZpPrPHt4Tb+Ylls81miTyVH4vVmzxzvOzvwFJ1yBpW0qMG1
         YUu54XepqFQQ+L11YHsAPStW5FXzekvGEYudwFdyCQa+7MnQqK9ztKFusdtt0NdNMLu5
         orXStQZxnNE/lzuDaZ8I9YVmXIvCBdovKnCeKTgD6sp5LAjGo2bCPmlFH7ctdtom9MyS
         ZG2D9im1c792FblbViWX93afQDSkaLpCZ3fO/VpDyW7kME/epmSLgvekLXWEzuQsfoy2
         dzhA==
X-Gm-Message-State: AOJu0Yw/cvT8wgNITqzwBZAuCoH5WZwjZn6AsyC+zgcYYtFUEZ3nzvVk
        tcOfYoCT64Q51VAUJh1pxTusG3ULddK0q71aE1q9DB0Av7UfHvoUZHsKr5Kt+z5thgfLnxnfx0h
        AJcX60+/T9AHj3JSjXBauReFX
X-Received: by 2002:a05:600c:246:b0:409:637b:890d with SMTP id 6-20020a05600c024600b00409637b890dmr4662211wmj.2.1702543538715;
        Thu, 14 Dec 2023 00:45:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEd9LpPd9LlR4EdQvDKYuR630GgNDCt0NG+pjD6dcylIDtVJwCEubGxS9oHa85KaPw5yjKlKA==
X-Received: by 2002:a05:600c:246:b0:409:637b:890d with SMTP id 6-20020a05600c024600b00409637b890dmr4662193wmj.2.1702543538360;
        Thu, 14 Dec 2023 00:45:38 -0800 (PST)
Received: from sgarzare-redhat ([5.11.101.217])
        by smtp.gmail.com with ESMTPSA id dd14-20020a0560001e8e00b003364277e714sm2802139wrb.89.2023.12.14.00.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 00:45:37 -0800 (PST)
Date:   Thu, 14 Dec 2023 09:45:33 +0100
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
Message-ID: <gu2yvaqqgrfnffnh67fodsoob4cdpcw4zaifncku3qvadtuq5j@6unpf5ifdmtd>
References: <20231211211658.2904268-1-avkrasnov@salutedevices.com>
 <20231212105423-mutt-send-email-mst@kernel.org>
 <d27f22f0-0f1e-e1bb-5b13-a524dc6e94d7@salutedevices.com>
 <20231212111131-mutt-send-email-mst@kernel.org>
 <7b362aef-6774-0e08-81e9-0a6f7f616290@salutedevices.com>
 <ucmekzurgt3zcaezzdkk6277ukjmwaoy6kdq6tzivbtqd4d32b@izqbcsixgngk>
 <402ea723-d154-45c9-1efe-b0022d9ea95a@salutedevices.com>
 <20231213100518-mutt-send-email-mst@kernel.org>
 <20231213100957-mutt-send-email-mst@kernel.org>
 <8e6b06a5-eeb3-84c8-c6df-a8b81b596295@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e6b06a5-eeb3-84c8-c6df-a8b81b596295@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 08:11:57PM +0300, Arseniy Krasnov wrote:
>
>
>On 13.12.2023 18:13, Michael S. Tsirkin wrote:
>> On Wed, Dec 13, 2023 at 10:05:44AM -0500, Michael S. Tsirkin wrote:
>>> On Wed, Dec 13, 2023 at 12:08:27PM +0300, Arseniy Krasnov wrote:
>>>>
>>>>
>>>> On 13.12.2023 11:43, Stefano Garzarella wrote:
>>>>> On Tue, Dec 12, 2023 at 08:43:07PM +0300, Arseniy Krasnov wrote:
>>>>>>
>>>>>>
>>>>>> On 12.12.2023 19:12, Michael S. Tsirkin wrote:
>>>>>>> On Tue, Dec 12, 2023 at 06:59:03PM +0300, Arseniy Krasnov wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 12.12.2023 18:54, Michael S. Tsirkin wrote:
>>>>>>>>> On Tue, Dec 12, 2023 at 12:16:54AM +0300, Arseniy Krasnov wrote:
>>>>>>>>>> Hello,
>>>>>>>>>>
>>>>>>>>>>                                DESCRIPTION
>>>>>>>>>>
>>>>>>>>>> This patchset fixes old problem with hungup of both rx/tx sides and adds
>>>>>>>>>> test for it. This happens due to non-default SO_RCVLOWAT value and
>>>>>>>>>> deferred credit update in virtio/vsock. Link to previous old patchset:
>>>>>>>>>> https://lore.kernel.org/netdev/39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru/
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Patchset:
>>>>>>>>>
>>>>>>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>>>>
>>>>>>>> Thanks!
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> But I worry whether we actually need 3/8 in net not in net-next.
>>>>>>>>
>>>>>>>> Because of "Fixes" tag ? I think this problem is not critical and reproducible
>>>>>>>> only in special cases, but i'm not familiar with netdev process so good, so I don't
>>>>>>>> have strong opinion. I guess @Stefano knows better.
>>>>>>>>
>>>>>>>> Thanks, Arseniy
>>>>>>>
>>>>>>> Fixes means "if you have that other commit then you need this commit
>>>>>>> too". I think as a minimum you need to rearrange patches to make the
>>>>>>> fix go in first. We don't want a regression followed by a fix.
>>>>>>
>>>>>> I see, ok, @Stefano WDYT? I think rearrange doesn't break anything, because this
>>>>>> patch fixes problem that is not related with the new patches from this patchset.
>>>>>
>>>>> I agree, patch 3 is for sure net material (I'm fine with both rearrangement or send it separately), but IMHO also patch 2 could be.
>>>>> I think with the same fixes tag, since before commit b89d882dc9fc ("vsock/virtio: reduce credit update messages") we sent a credit update
>>>>> for every bytes we read, so we should not have this problem, right?
>>>>
>>>> Agree for 2, so I think I can rearrange: two fixes go first, then current 0001, and then tests. And send it as V9 for 'net' only ?
>>>>
>>>> Thanks, Arseniy
>>>
>>>
>>> hmm why not net-next?
>>
>> Oh I missed your previous discussion. I think everything in net-next is
>> safer.  Having said that, I won't nack it net, either.
>
>So, summarizing all above:
>1) This patchset entirely goes to net-next as v9
>2) I reorder patches like 3 - 2 - 1 - 4, e.g. two fixes goes first with Fixes tag
>3) Add Acked-by: Michael S. Tsirkin <mst@redhat.com> to each patch
>
>@Michael, @Stefano ?

Okay, let's do that ;-)

Stefano

