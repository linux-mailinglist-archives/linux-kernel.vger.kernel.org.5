Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C257F7FAF6B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjK1BND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 20:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1BNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:13:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CA6C2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701133987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0GYsTvHILUE5bHf9jrteKEji3a+vWsZWsBd4N08Nob8=;
        b=J0gGABkIxY3mCO27qvq4zaw7WqJp0X9r89R/IJJzb29dBuKzzjlJEUaO3Bl0fC7rIayBxF
        Iw6UDFTgKkzAo29+fdvgE9Mq5EPPT5If1QVwBTfFTvFLr4Hg4MLjmtTWD4vmaqDRj6GY/S
        5jZpYoNqzMe9KRk2XsBr6crs6bd5EDM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-ks9P6tq8Mg6AnvtM5kdH-w-1; Mon, 27 Nov 2023 20:13:05 -0500
X-MC-Unique: ks9P6tq8Mg6AnvtM5kdH-w-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-54b7e11013bso848161a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701133984; x=1701738784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GYsTvHILUE5bHf9jrteKEji3a+vWsZWsBd4N08Nob8=;
        b=E2SR5fui5gNJSa62xHE3Yz8BpN3HmjYBwpjK2DYAl142q8+cUCfWiq3vrZfeJ59gRf
         23JnvaM/H9xgxEsw8skEO400h+1Yr+U2kN/B/2eP1LhprK35CQPWZrYWEOrPLUj2fdDY
         rH/6ix6Lpvf0wNSTKL22+xy7laXgClXDv1qvFQld7M2YVuEp4R6U0UMQ9+2sA5P1f2l4
         /wxyNvK/TmB5w8FLzeLgTmkzRO1rfN1UDh5pb7yM+DbPSh866fD4dB1zdyJ6/90wxJbT
         GXbxp9MpalaW9rvHbiFNoxSX707I4mG6rmTzUuSsNU/aNkyR7lQ99Z8G+DCIEbIDJt9c
         Guvw==
X-Gm-Message-State: AOJu0YzDx3S+Ir4UBQBUpATAhPUnsNruoWdd/zEC7EriVjhpOJCzukpQ
        +otePBkEWblBqBKUEtrtJdD78AMqDmPOUgmZzXq2nnLNnKaJw0HHHqpuCJ0pSGLAsDWfU2lPCza
        iyxYtMBfIYhP6F9GmAbdpYlDYG2ej0bBu5u4CM61z
X-Received: by 2002:a05:6402:2207:b0:54b:25e8:c009 with SMTP id cq7-20020a056402220700b0054b25e8c009mr5995539edb.0.1701133984408;
        Mon, 27 Nov 2023 17:13:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUqnXKYGGxsFvT8AZxKn2jiFS3BNX4VIv1K+twolV2C+MWmInyK2s0g5oqXOtZg/+VjKhtXpumHBxcw6dCMtQ=
X-Received: by 2002:a05:6402:2207:b0:54b:25e8:c009 with SMTP id
 cq7-20020a056402220700b0054b25e8c009mr5995533edb.0.1701133984173; Mon, 27 Nov
 2023 17:13:04 -0800 (PST)
MIME-Version: 1.0
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz> <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
In-Reply-To: <ZWJllXCN0SDIELrX@dwarf.suse.cz>
From:   Tao Liu <ltao@redhat.com>
Date:   Tue, 28 Nov 2023 09:12:28 +0800
Message-ID: <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
To:     Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, mhocko@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Sun, Nov 26, 2023 at 5:22=E2=80=AFAM Jiri Bohac <jbohac@suse.cz> wrote:
>
> Hi Tao,
>
> On Sat, Nov 25, 2023 at 09:51:54AM +0800, Tao Liu wrote:
> > Thanks for the idea of using CMA as part of memory for the 2nd kernel.
> > However I have a question:
> >
> > What if there is on-going DMA/RDMA access on the CMA range when 1st
> > kernel crash? There might be data corruption when 2nd kernel and
> > DMA/RDMA write to the same place, how to address such an issue?
>
> The crash kernel CMA area(s) registered via
> cma_declare_contiguous() are distinct from the
> dma_contiguous_default_area or device-specific CMA areas that
> dma_alloc_contiguous() would use to reserve memory for DMA.
>
> Kernel pages will not be allocated from the crash kernel CMA
> area(s), because they are not GFP_MOVABLE. The CMA area will only
> be used for user pages.
>
> User pages for RDMA, should be pinned with FOLL_LONGTERM and that
> would migrate them away from the CMA area.
>
> But you're right that DMA to user pages pinned without
> FOLL_LONGTERM would still be possible. Would this be a problem in
> practice? Do you see any way around it?
>

Thanks for the explanation! Sorry I don't have any ideas so far...

@Pingfan Liu @Baoquan He Hi, do you have any suggestions for it?

Thanks,
Tao Liu

> Thanks,
>
> --
> Jiri Bohac <jbohac@suse.cz>
> SUSE Labs, Prague, Czechia
>

