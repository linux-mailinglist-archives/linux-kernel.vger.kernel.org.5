Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37075793D61
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbjIFNFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjIFNFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47917CE2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694005461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQC3VLJzelpWuewrYwxP8K1faarkwBrEJnD7vO08AbM=;
        b=Rl89VUaGkl+XODX8e5oeQyZaAlPkI4Icoc96hssyvPAP8f6JB2U3k4nZWC74o++ISKutrw
        heaRwhpVrNPkGS1oYFEDFmGTYyFY2fgLT+rK8NsjNN69hWznhAydNdMmvanABmi5SBQA8s
        O7bDEiLn/JhKg1FFTPvdZH1E24rk21c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-iWQHcgS_MMKW5cO1YjWheA-1; Wed, 06 Sep 2023 09:04:20 -0400
X-MC-Unique: iWQHcgS_MMKW5cO1YjWheA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31c5c55fd70so413280f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 06:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694005459; x=1694610259;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQC3VLJzelpWuewrYwxP8K1faarkwBrEJnD7vO08AbM=;
        b=J7VJk8TkY6cRNrT0kaqlgQdElIs0R9n/15BEo2zn3uMbGNsDO0ATYzYybdi2hkZPLr
         jxPdVKC2Ne1vdvHGVpkpOHcuonrBtp9zDfgK1/edOicfWyuheZmigRMxKTbItAD04s31
         80Dxjne01JcfLMseLXr/AVKFcNNaslMuBHTFZaEf/UYPbTJVzL0kDmZYzpogMKLfy3Aj
         DF2jXWctJVxoFLBXVWo+gUw4jSUsITdH6FKmOBCYJiOWwPZC5vorSIM/AjpiTJOVf+tu
         OGC/mTF6B1LJP9+tSRTRLLZB8X6WskmnZ6Z1cU2n2TgDNmEpveW4c7ML2iFZ5ruOWu5Z
         ml0Q==
X-Gm-Message-State: AOJu0YzkpHmfSN/c7gPbFRyyudQQqXC6gvDQuVb3XcA9HcRQASmRwNqK
        4UusaWLSb10W68cdVJN9QltH2Y154PZmUBKQS8mhLVyrgVEb+QgGbgGdcIElxlm3re6SwhvV/pB
        nvYavcK76irl+b9wKHSbFjui+
X-Received: by 2002:a5d:5b07:0:b0:319:6997:9432 with SMTP id bx7-20020a5d5b07000000b0031969979432mr2735238wrb.1.1694005459150;
        Wed, 06 Sep 2023 06:04:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqGAlmieinZ1tupmHLodb0qLqsbi8aDyBGyUdUIauh7NwdJy4W2D9n0xTcf5thdTFqpjZBGg==
X-Received: by 2002:a5d:5b07:0:b0:319:6997:9432 with SMTP id bx7-20020a5d5b07000000b0031969979432mr2735212wrb.1.1694005458773;
        Wed, 06 Sep 2023 06:04:18 -0700 (PDT)
Received: from localhost.localdomain ([151.29.94.163])
        by smtp.gmail.com with ESMTPSA id l16-20020adfe9d0000000b00317e77106dbsm20350110wrn.48.2023.09.06.06.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:04:18 -0700 (PDT)
Date:   Wed, 6 Sep 2023 15:04:16 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: Question on tw_timer TIMER_PINNED
Message-ID: <ZPh40NCKfj9FJ7fy@localhost.localdomain>
References: <ZPhpfMjSiHVjQkTk@localhost.localdomain>
 <CANn89iJFyqckr3x=nwbExs3B1u=MXv9izL=2ByxOf20su2fhhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJFyqckr3x=nwbExs3B1u=MXv9izL=2ByxOf20su2fhhg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/23 14:10, Eric Dumazet wrote:
> On Wed, Sep 6, 2023 at 1:58 PM Juri Lelli <juri.lelli@redhat.com> wrote:
> >
> > Hi Eric,
> >
> > I'm bothering you with a question about timewait_sock tw_timer, as I
> > believe you are one of the last persons touching it sometime ago. Please
> > feel free to redirect if I failed to git blame it correctly.
> >
> > At my end, latency spikes (entering the kernel) have been reported when
> > running latency sensitive applications in the field (essentially a
> > polling userspace application that doesn't want any interruption at
> > all). I think I've been able to track down one of such interruptions to
> > the servicing of tw_timer_handler. This system isolates application CPUs
> > dynamically, so what I think it happens is that at some point tw_timer
> > is armed on a CPU, and it is PINNED to that CPU, meanwhile (before the
> > 60s timeout) such CPU is 'isolated' and the latency sensitive app
> > started on it. After 60s the timer fires and interrupts the app
> > generating a spike.
> >
> > I'm not very familiar with this part of the kernel and from staring
> > at code for a while I had mixed feeling about the need to keep tw_timer
> > as TIMER_PINNED. Could you please shed some light on it? Is it a strict
> > functional requirement or maybe a nice to have performance (locality I'd
> > guess) improvement? Could we in principle make it !PINNED (so that it
> > can be moved/queued away and prevent interruptions)?
> >
> 
> It is a functional requirement in current implementation.
> 
> cfac7f836a71 ("tcp/dccp: block bh before arming time_wait timer")
> changelog has some details about it.

Thanks for the reference.

> Can this be changed to non pinned ? Probably, but with some care.

I see. I will need to ponder about this.

> You could simply disable tw completely, it is a best effort mechanism.

But, first I think we are going to experiment with this route.

Thanks a lot for the super quick reply!

Best,
Juri

