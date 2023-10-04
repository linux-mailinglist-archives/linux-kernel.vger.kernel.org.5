Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386967B858C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243446AbjJDQnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjJDQnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E16D8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696437747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQchYUvGxxsCc4djV8D5Ngra+tr0SbVapL0lFjxteFg=;
        b=ICQQ33f8i5/WbTN/tmhwPn30gv+38HliBOjldkkBt1vPQUfBA27tuJ4aN4ezgGA3vxmd31
        N8dYxtfH9Zd+uFa9m+cBSyl1cXtMtaIpMDKqwE4DKDk/18hGI63jL9gEwbUDORMj3WxnpE
        h1PeW963WbHY/aMKgoN7cqMgITuNI5M=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-fMhXrQMWPTGvRMPJESWjKQ-1; Wed, 04 Oct 2023 12:42:25 -0400
X-MC-Unique: fMhXrQMWPTGvRMPJESWjKQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7756d4d252cso303943485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696437745; x=1697042545;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQchYUvGxxsCc4djV8D5Ngra+tr0SbVapL0lFjxteFg=;
        b=Ov7cDkQRdhj0FPMe9kWqSOK+Q36Btn3KWBmbGk64D6Fzf9HQyRScV64vMN7x4Km4aA
         TTd4MPmKuhIELaRgcyZG6uKNjvoO2TbiS7vrv19MkVI6vjbFPztvLTmgJnK5TEYBMno9
         dBjI63j/MaRdMhyv4+/SlyA7d00OdRlN8+A3kc85aMrVcCP8nP9+9kZoBCnoHgA3Zo9Y
         FqGCRY2ZpxoYvAkp41gAXzqfT26uxSLBzzBl4FIJhrZm4StXEGZEggd6UPo0rFRj243t
         0FOKDUEm4BOr4Gh0vA1A4TZ3DVBYD9K1JkMFONfc45M0rYlxN4jTU5LbeA0+ZmGN+F+k
         ZuYg==
X-Gm-Message-State: AOJu0Yz28lff8HHxQ4fD/goVAW8kSqgL9BT1jPxS/LpJTFWJSZgT5j8J
        1sSgBkaGrFJySctfoe+h9+CTCKHlsci8ql3HRz2wbNB254tbeFYORnmZqeyebvUpnEhBsRg0c3C
        grAMdC9bIPHUbts2Kis5hhEfJ
X-Received: by 2002:a05:620a:258f:b0:767:1d7e:ec40 with SMTP id x15-20020a05620a258f00b007671d7eec40mr3175087qko.1.1696437745124;
        Wed, 04 Oct 2023 09:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt9ZzO3ODQL872WyKfk3Dg3TgfHXkRo+gA8ZChzf0rtqBB4Wiu+lGNy76VPmqz4kqAeDz51Q==
X-Received: by 2002:a05:620a:258f:b0:767:1d7e:ec40 with SMTP id x15-20020a05620a258f00b007671d7eec40mr3175068qko.1.1696437744855;
        Wed, 04 Oct 2023 09:42:24 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it. [82.57.51.114])
        by smtp.gmail.com with ESMTPSA id o15-20020ae9f50f000000b0076cb1eff83csm1387058qkg.5.2023.10.04.09.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 09:42:24 -0700 (PDT)
Date:   Wed, 4 Oct 2023 18:42:18 +0200
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
Subject: Re: [PATCH net-next v2 00/12] vsock/virtio: continue MSG_ZEROCOPY
 support
Message-ID: <zilryvqespe5k4d3xjer2fcrseqo3yu3lvairvobvop6shqvsz@gzdmzpujxzkx>
References: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
 <4nwo6nd2ihjqsoqnjdjhuucqyc4fhfhxk52q6ulrs6sd2fmf7z@24hi65hbpl4i>
 <aef9a438-3c61-44ec-688f-ed89eb886bfd@salutedevices.com>
 <5ae3b08d-bcbb-514c-856a-94c538796714@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ae3b08d-bcbb-514c-856a-94c538796714@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 07:22:04PM +0300, Arseniy Krasnov wrote:
>
>
>On 04.10.2023 08:25, Arseniy Krasnov wrote:
>>
>>
>> On 03.10.2023 19:26, Stefano Garzarella wrote:
>>> Hi Arseniy,
>>>
>>> On Sun, Oct 01, 2023 at 12:02:56AM +0300, Arseniy Krasnov wrote:
>>>> Hello,
>>>>
>>>> this patchset contains second and third parts of another big patchset
>>>> for MSG_ZEROCOPY flag support:
>>>> https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sberdevices.ru/
>>>>
>>>> During review of this series, Stefano Garzarella <sgarzare@redhat.com>
>>>> suggested to split it for three parts to simplify review and merging:
>>>>
>>>> 1) virtio and vhost updates (for fragged skbs) (merged to net-next, see
>>>>   link below)
>>>> 2) AF_VSOCK updates (allows to enable MSG_ZEROCOPY mode and read
>>>>   tx completions) and update for Documentation/. <-- this patchset
>>>> 3) Updates for tests and utils. <-- this patchset
>>>>
>>>> Part 1) was merged:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=71b263e79370348349553ecdf46f4a69eb436dc7
>>>>
>>>> Head for this patchset is:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=236f3873b517acfaf949c23bb2d5dec13bfd2da2
>>>>
>>>> Link to v1:
>>>> https://lore.kernel.org/netdev/20230922052428.4005676-1-avkrasnov@salutedevices.com/
>>>>
>>>> Changelog:
>>>> v1 -> v2:
>>>> * Patchset rebased and tested on new HEAD of net-next (see hash above).
>>>> * See per-patch changelog after ---.
>>>
>>> Thanks for this new version.
>>> I started to include vsock_uring_test in my test suite and tests are
>>> going well.
>>>
>>> I reviewed code patches, I still need to review the tests.
>>> I'll do that by the end of the week, but they looks good!
>>
>> Thanks for review! Ok, I'll wait for tests review, and then send next
>> version.
>
>Got your comments from review. I'll update patches by:
>1) Trying to avoid touching util.c/util.h

I mean, we can touch it ;-) but for this case it looks like we don't
need most of that functions to be there.

At least for now. If we need them to be used in more places, then it
makes sense.

>2) Add new header with functions shared between util vsock_perf and
>tests

We can do this also later in another PR as cleanup if you prefer.

Thanks,
Stefano

