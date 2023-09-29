Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E6E7B2CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjI2HGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjI2HGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C34C1A5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 00:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695971153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHxqmj3tSTy2G5LiN/2ZAZO5W2ttNXDNevrvKcCTecU=;
        b=N8G2TtEnRHv0Kau5+gSU3ofyBlq6R9PXJABzbInkHVXVgap+VFvG3D/LMD/xTOFIZ77i3T
        zwekzWgEczVBgEgFgOH/XMpjsw8RUZkATPogjPwBjlONDGfxr5uZyl2+jYqcSpcNaG7SHQ
        PHIKE2HAJ6S/6CrK7RFCxqGvBTqNwM8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-6kJq8elIOiuJ43qDq9b96Q-1; Fri, 29 Sep 2023 03:05:51 -0400
X-MC-Unique: 6kJq8elIOiuJ43qDq9b96Q-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-65afd7515aaso185079206d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 00:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695971151; x=1696575951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHxqmj3tSTy2G5LiN/2ZAZO5W2ttNXDNevrvKcCTecU=;
        b=lW/Pny0q3dSsg6F1OaTcBfQWB+Bcx7YZd0+OLKzfZUcLHZy1d+Y9vC4SHnMeERpBiN
         TxoIq1MjNZaehOCgZGuwi5NBSqHrYV4lQJwoZ8FNtCO5UsPuAhMw2Cp3JroU4/rh3QxT
         nbXPGYWWXlT4DD82HvsgA1EAQPO3JV7GfRwDgKyVaODJcrqmaxo4bV9PPkyqEq18Znvx
         bxbeIukD8oLhQEeNdWsnxXij4p2UHeUaSh3BqwvXFvnWxUF2ZIstXYg7McNOx3thKjbw
         Uz14ORi5fmLrFPWZ5TeBnP0991HAF5+PUYXA/oHtE0fxXSXAzH3m9SryQ4wd6af8lj66
         ggpA==
X-Gm-Message-State: AOJu0YzV5z6ZTd8HmmftZKvHKwUyra/FSqLypjUC9Pr9dUkwoWfWPd8f
        rxns6SUUdUsFnhUpxmFWM//s5oaKdHNMAZubXx5soCRGavJ4Ny0XmtUgsEd8AU3cJgQR2FXJJdy
        MYRTHln3fcnK791IBcSRdPpID
X-Received: by 2002:a0c:f5d0:0:b0:64f:82d2:26fe with SMTP id q16-20020a0cf5d0000000b0064f82d226femr3261805qvm.39.1695971151123;
        Fri, 29 Sep 2023 00:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpV34uuOwiqDHtRCy3NjMAqXIe8eDV4uS1J+UKz288VBSl5u5Qgf1gsxsy1aN+idzMTNWtZw==
X-Received: by 2002:a0c:f5d0:0:b0:64f:82d2:26fe with SMTP id q16-20020a0cf5d0000000b0064f82d226femr3261792qvm.39.1695971150846;
        Fri, 29 Sep 2023 00:05:50 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c6:4a2f:8e01:cdb2:e442:d239:3933])
        by smtp.gmail.com with ESMTPSA id a12-20020a0ce34c000000b0065b24c08994sm2786830qvm.128.2023.09.29.00.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 00:05:50 -0700 (PDT)
Date:   Fri, 29 Sep 2023 08:05:46 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched/deadline: Make dl_rq->pushable_dl_tasks updates
 drive dl_rq->overloaded
Message-ID: <ZRZ3SpS4MRWeSIrr@localhost.localdomain>
References: <20230928150251.463109-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928150251.463109-1-vschneid@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/09/23 17:02, Valentin Schneider wrote:
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

This looks good thanks!

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

