Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF047B4ECC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbjJBJPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbjJBJPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A0A93
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696238070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0daCeVV9L2XlnJGGlGMQM1Rz7XmHtwVIMxn3HkCL1/0=;
        b=Bk+GK0uWLxPJw/hOuH5TBXy7qMGIMCGnBbx1yKatusMuTc/lWMHReBasWG/AW7NePt3sJx
        7hU4q0FHVoMMAeuzGyCMVNemut7vQ0vL6REd05FX8460HNNgxpvHcZmr5ZQdLxPoZN43oT
        3z0Sbyhc0M4baQ3/EEJpB2XH1EYHlCg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-MIl3PtEJO9WRWb-GNh9LtA-1; Mon, 02 Oct 2023 05:14:29 -0400
X-MC-Unique: MIl3PtEJO9WRWb-GNh9LtA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ae42088b4bso108254966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 02:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696238068; x=1696842868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0daCeVV9L2XlnJGGlGMQM1Rz7XmHtwVIMxn3HkCL1/0=;
        b=NRVt4QFovRuDPRDfu07dcs1PfvDtVHXtFLXYO0dDJSm4MHb95EEiLCSN5FiK/VMQ5w
         NqSRFLwObJktIomKKukGPsqAr+PACbFBNsRHkUAOydrBVECDjgIh3sGLM9mqQkFepR30
         2aRtsII2nzhlm7KUWJN2YeA3qW3asf72R1nlxfkIeZPLgNsTWLbEJQ6UiiUyaXCiHeWR
         7WCq4D3q1PttSEHU1wErmetnZ87cJoLSbCxRWkG9pIsYVD4+0UKESTaH9glqiUhBHZXR
         WP1/Teq1iL0uGSo7nVEdeE6ZWmrgDBGz5IjLUvJ7aQtp1SwGuiWhaXB/kny9AMhWvo0u
         MpJA==
X-Gm-Message-State: AOJu0YyPVkQHylx9ZMAT99UVamIEF3ZuNFbVwNPSLG1ET7JC9Y0mfCWE
        fX4qHaPiLckpY9yQH5UgO7upjcqb7ciApvGDTt4/nLq/zK1fsmuCj8KZw0M0grCYJ38s82F4Fb1
        Du6l4k2v3LUADPqxkeEBK1trl
X-Received: by 2002:a17:906:21b:b0:9a1:cbe4:d029 with SMTP id 27-20020a170906021b00b009a1cbe4d029mr11160776ejd.74.1696238068277;
        Mon, 02 Oct 2023 02:14:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSkNPKqZPtszcyW9MNhzLZce25jGkwbWE1TNp0LSBFBlpfP5JneqEbvZl4JHP503nUeOTBbA==
X-Received: by 2002:a17:906:21b:b0:9a1:cbe4:d029 with SMTP id 27-20020a170906021b00b009a1cbe4d029mr11160758ejd.74.1696238067930;
        Mon, 02 Oct 2023 02:14:27 -0700 (PDT)
Received: from [192.168.0.224] (host-87-2-147-179.retail.telecomitalia.it. [87.2.147.179])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906140700b009829d2e892csm17074303ejc.15.2023.10.02.02.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 02:14:27 -0700 (PDT)
Message-ID: <cbb0cba9-e8d4-6ee0-6c7d-2ac635872432@redhat.com>
Date:   Mon, 2 Oct 2023 11:14:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] sched/deadline: Make dl_rq->pushable_dl_tasks updates
 drive dl_rq->overloaded
To:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230928150251.463109-1-vschneid@redhat.com>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20230928150251.463109-1-vschneid@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 17:02, Valentin Schneider wrote:
> dl_nr_migratory is increased whenever a DL entity is enqueued and it has
> nr_cpus_allowed > 1. Unlike the pushable_dl_tasks tree, dl_nr_migratory
> includes a dl_rq's current task. This means a dl_rq can have a migratable
> current, N non-migratable queued tasks, and be flagged as overloaded and have
> its CPU set in the dlo_mask, despite having an empty pushable_tasks tree.
> 
> Make an dl_rq's overload logic be driven by {enqueue,dequeue}_pushable_dl_task(),
> in other words make DL RQs only be flagged as overloaded if they have at
> least one runnable-but-not-current migratable task.
> 
> o push_dl_task() is unaffected, as it is a no-op if there are no pushable
>   tasks.
> o pull_dl_task() now no longer scans runqueues whose sole migratable task is
>   their current one, which it can't do anything about anyway.
>   It may also now pull tasks to a DL RQ with dl_nr_running > 1 if only its
>   current task is migratable.
> 
> Since dl_rq->dl_nr_migratory becomes unused, remove it.
> 
> RT had the exact same mechanism (rt_rq->rt_nr_migratory) which was dropped
> in favour of relying on rt_rq->pushable_tasks, see:
>   612f769edd06 ("sched/rt: Make rt_rq->pushable_tasks updates drive rto_mask")
> 
> Link: https://lore.kernel.org/all/20230811112044.3302588-1-vschneid@redhat.com/
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel

