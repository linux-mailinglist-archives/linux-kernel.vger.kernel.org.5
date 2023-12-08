Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA1680A106
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjLHKcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbjLHKbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:31:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7631819A2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702031486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tcu3WmbH0rDpAmwPqLlBrIXFmcIviRa8i1AFTtWd1Zs=;
        b=cOexIkcrsNZ589DDTxh3gqIixiNNnP8xZE8+B6motvcNQXDndK2I1SR5fFdBmJ6ybZ6CuJ
        i1akEtL/YYuLE4MhUbOys7qr1tjSk1fdFmV2cNwDkMMqG5O9ZhjLMv2HXP3FM5x4GZgb8W
        oLn11H78pl5gUO6HkzHXj45U0Qe+q7E=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-IgU449X2ORazq3drhx04Cw-1; Fri, 08 Dec 2023 05:31:25 -0500
X-MC-Unique: IgU449X2ORazq3drhx04Cw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ca30780a02so13255251fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702031483; x=1702636283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tcu3WmbH0rDpAmwPqLlBrIXFmcIviRa8i1AFTtWd1Zs=;
        b=YsecXL7B4gIxbqrMcbnCy6OWNIuQmJx3QPpj/+NUEpbrz2vGz/weo9BRXsK4a6MRhp
         /iFD5MLF1mOguBXWBnebGRITaoJT2YK/ALjETAhIYMh5Q85m0v89PSkzuJb426esNIKu
         JAl3fD/MbscgHXQh8Fu3pZ2UYMt2OnUhxeluXd+oJuuHI2NgFpqtCrFGbj0pJEvN5ZLG
         eyuYFdDtcNb5Xu2O/MBM35rx+M9myqm8b2eJXr1CCBmNKT11cLi6Klq7D82ta1hwECH9
         +JrUmMocB/3rcsqBrz0TrDpofChvT1GsQdszXmysakDh15F76JnQIuZ1XiGb+pn1pLaD
         3orw==
X-Gm-Message-State: AOJu0Yx5VzdgN463LlMUHeirfbFhQOysjgPC+qt6v+0gw0bq0Ecq0Q+R
        qwM9Q5eyK+Qs15iRlTf8ehN5nqnHKrTpSoV3SK8cufgBN42lDxY5ArODEKX9qeicil8hdcMhT72
        0CpwmWkUAAdmWjHqzwr7KLQUV
X-Received: by 2002:a2e:8884:0:b0:2ca:56:778f with SMTP id k4-20020a2e8884000000b002ca0056778fmr1257129lji.48.1702031483564;
        Fri, 08 Dec 2023 02:31:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKcY1LCS/VjPyEMeTLMNoGPvmPdJg2dsZtFpUis0zp6RJwZ5WMd0CWqzm2EoCROz7SrjQSKA==
X-Received: by 2002:a2e:8884:0:b0:2ca:56:778f with SMTP id k4-20020a2e8884000000b002ca0056778fmr1257123lji.48.1702031483207;
        Fri, 08 Dec 2023 02:31:23 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f0:7466:b10d:58c8:869f:7e91])
        by smtp.gmail.com with ESMTPSA id cu12-20020a170906ba8c00b00a10f3030e11sm829135ejd.1.2023.12.08.02.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:31:22 -0800 (PST)
Date:   Fri, 8 Dec 2023 05:31:18 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tobias Huschle <huschle@linux.ibm.com>
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, jasowang@redhat.com
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20231208052150-mutt-send-email-mst@kernel.org>
References: <ZVdbdSXg4qefTNtg@DESKTOP-2CCOB1S.>
 <20231117123759.GP8262@noisy.programming.kicks-ass.net>
 <46a997c2-5a38-4b60-b589-6073b1fac677@bytedance.com>
 <ZVyt4UU9+XxunIP7@DESKTOP-2CCOB1S.>
 <20231122100016.GO8262@noisy.programming.kicks-ass.net>
 <6564a012.c80a0220.adb78.f0e4SMTPIN_ADDED_BROKEN@mx.google.com>
 <d4110c79-d64f-49bd-9f69-0a94369b5e86@bytedance.com>
 <07513.123120701265800278@us-mta-474.us.mimecast.lan>
 <20231207014626-mutt-send-email-mst@kernel.org>
 <56082.123120804242300177@us-mta-137.us.mimecast.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56082.123120804242300177@us-mta-137.us.mimecast.lan>
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

On Fri, Dec 08, 2023 at 10:24:16AM +0100, Tobias Huschle wrote:
> On Thu, Dec 07, 2023 at 01:48:40AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Dec 07, 2023 at 07:22:12AM +0100, Tobias Huschle wrote:
> > > 3. vhost looping endlessly, waiting for kworker to be scheduled
> > > 
> > > I dug a little deeper on what the vhost is doing. I'm not an expert on
> > > virtio whatsoever, so these are just educated guesses that maybe
> > > someone can verify/correct. Please bear with me probably messing up 
> > > the terminology.
> > > 
> > > - vhost is looping through available queues.
> > > - vhost wants to wake up a kworker to process a found queue.
> > > - kworker does something with that queue and terminates quickly.
> > > 
> > > What I found by throwing in some very noisy trace statements was that,
> > > if the kworker is not woken up, the vhost just keeps looping accross
> > > all available queues (and seems to repeat itself). So it essentially
> > > relies on the scheduler to schedule the kworker fast enough. Otherwise
> > > it will just keep on looping until it is migrated off the CPU.
> > 
> > 
> > Normally it takes the buffers off the queue and is done with it.
> > I am guessing that at the same time guest is running on some other
> > CPU and keeps adding available buffers?
> > 
> 
> It seems to do just that, there are multiple other vhost instances
> involved which might keep filling up thoses queues. 
> 

No vhost is ever only draining queues. Guest is filling them.

> Unfortunately, this makes the problematic vhost instance to stay on
> the CPU and prevents said kworker to get scheduled. The kworker is
> explicitly woken up by vhost, so it wants it to do something.
> 
> At this point it seems that there is an assumption about the scheduler
> in place which is no longer fulfilled by EEVDF. From the discussion so
> far, it seems like EEVDF does what is intended to do.
> 
> Shouldn't there be a more explicit mechanism in use that allows the
> kworker to be scheduled in favor of the vhost?
> 
> It is also concerning that the vhost seems cannot be preempted by the
> scheduler while executing that loop.


Which loop is that, exactly?

-- 
MST

