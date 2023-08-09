Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACADD77561F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjHIJHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjHIJHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D9E1FD0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 02:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691571988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+ifxhNKhk14FO/57ss8DAi+XyDazgPuAzrxHmHxo+E=;
        b=hgEs1Iz9zF2p2X9dmPegZGE2dyiPzgqXDgoAEzX2ykwbeFNpdXSElCFPBgnI4ejijjPmdE
        6uBm+vnXHaJw62zlq5zfCnqIQKR6SpkMj2RsoAmvmcGJVC+y62X0RNyz7ia6bRrDIYlCrn
        Vcje9hcjiBEowL6F89rDpkAyP4aNDP8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-7T8r8f2wN0ajQEbwPD-vEQ-1; Wed, 09 Aug 2023 05:06:27 -0400
X-MC-Unique: 7T8r8f2wN0ajQEbwPD-vEQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-51866148986so4413426a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 02:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691571986; x=1692176786;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+ifxhNKhk14FO/57ss8DAi+XyDazgPuAzrxHmHxo+E=;
        b=k5T+eqEGlJHtezJti+YHgpPkm5O1/LfyRhE0KqNKH+scpS6+zi2cohLWgo84qhUlhd
         YBxMo7wXid72GjEfmGBpUZbsNDL4grwgdm03AQPPcEKkey47YzFHCY4VM2lkDLjkxvat
         vVXY2DaKwQGNWIbj41T3yCSkAuJ9B97/u95zpqLL3s+e2XzrXraJbNLvlYwpy43svSeq
         Qjrmht6JvR74gXAcrEf5s0Ya/fjOlhhs3yZ8tjeGewnE7V8HADkO2HkCxN48gn3OW/cl
         8kBFajwwk6ukpHPn5gDJXmElm9C+nLRnCYORzpxDxkC9KEP0mdgkksyo6Oz+ip0wxJIq
         Vl+Q==
X-Gm-Message-State: AOJu0Yz7kD4MVokcEPKHUYA6wb0S7tDjNEMiejjS5xGlf4+8N9I/PhI5
        MX9KCwA2rFkHEuQE1F83OSteVdSBUbfEofwfCJGkSoI/mstZTtLEHw1Y2ww0pVRXOQLyDE0mWiY
        9jikG2BIfNNKVqb1WlAOMccbl
X-Received: by 2002:aa7:d690:0:b0:523:1ce9:1f49 with SMTP id d16-20020aa7d690000000b005231ce91f49mr1373696edr.42.1691571986471;
        Wed, 09 Aug 2023 02:06:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqVbQ3DEm5V5ln3ovucAIdVoeJOsVSeoFvG4UKIvfJKCFuIw6wJnfpmnnUu0zIEpl21wlXrw==
X-Received: by 2002:aa7:d690:0:b0:523:1ce9:1f49 with SMTP id d16-20020aa7d690000000b005231ce91f49mr1373684edr.42.1691571985950;
        Wed, 09 Aug 2023 02:06:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id i12-20020a05640200cc00b00523653295f9sm485845edu.94.2023.08.09.02.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 02:06:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0DC13D3B5D7; Wed,  9 Aug 2023 11:06:24 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Gobert <richardbgobert@gmail.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: Re: [RFC v3 Optimizing veth xsk performance 0/9]
In-Reply-To: <CABKxMyNrwSOrzpq6mhqtU_kEk5B9nKPODtmfjJO5_NmGpw_Oag@mail.gmail.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
 <87v8dpbv5r.fsf@toke.dk>
 <CABKxMyNrwSOrzpq6mhqtU_kEk5B9nKPODtmfjJO5_NmGpw_Oag@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 09 Aug 2023 11:06:23 +0200
Message-ID: <87msz04mb4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E9=BB=84=E6=9D=B0 <huangjie.albert@bytedance.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> =E4=BA=8E2023=E5=B9=B4=
8=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C 20:01=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Albert Huang <huangjie.albert@bytedance.com> writes:
>>
>> > AF_XDP is a kernel bypass technology that can greatly improve performa=
nce.
>> > However,for virtual devices like veth,even with the use of AF_XDP sock=
ets,
>> > there are still many additional software paths that consume CPU resour=
ces.
>> > This patch series focuses on optimizing the performance of AF_XDP sock=
ets
>> > for veth virtual devices. Patches 1 to 4 mainly involve preparatory wo=
rk.
>> > Patch 5 introduces tx queue and tx napi for packet transmission, while
>> > patch 8 primarily implements batch sending for IPv4 UDP packets, and p=
atch 9
>> > add support for AF_XDP tx need_wakup feature. These optimizations sign=
ificantly
>> > reduce the software path and support checksum offload.
>> >
>> > I tested those feature with
>> > A typical topology is shown below:
>> > client(send):                                        server:(recv)
>> > veth<-->veth-peer                                    veth1-peer<--->ve=
th1
>> >   1       |                                                  |   7
>> >           |2                                                6|
>> >           |                                                  |
>> >         bridge<------->eth0(mlnx5)- switch -eth1(mlnx5)<--->bridge1
>> >                   3                    4                 5
>> >              (machine1)                              (machine2)
>>
>> I definitely applaud the effort to improve the performance of af_xdp
>> over veth, this is something we have flagged as in need of improvement
>> as well.
>>
>> However, looking through your patch series, I am less sure that the
>> approach you're taking here is the right one.
>>
>> AFAIU (speaking about the TX side here), the main difference between
>> AF_XDP ZC and the regular transmit mode is that in the regular TX mode
>> the stack will allocate an skb to hold the frame and push that down the
>> stack. Whereas in ZC mode, there's a driver NDO that gets called
>> directly, bypassing the skb allocation entirely.
>>
>> In this series, you're implementing the ZC mode for veth, but the driver
>> code ends up allocating an skb anyway. Which seems to be a bit of a
>> weird midpoint between the two modes, and adds a lot of complexity to
>> the driver that (at least conceptually) is mostly just a
>> reimplementation of what the stack does in non-ZC mode (allocate an skb
>> and push it through the stack).
>>
>> So my question is, why not optimise the non-zc path in the stack instead
>> of implementing the zc logic for veth? It seems to me that it would be
>> quite feasible to apply the same optimisations (bulking, and even GRO)
>> to that path and achieve the same benefits, without having to add all
>> this complexity to the veth driver?
>>
>> -Toke
>>
> thanks!
> This idea is really good indeed. You've reminded me, and that's
> something I overlooked. I will now consider implementing the solution
> you've proposed and test the performance enhancement.

Sounds good, thanks! :)

-Toke

