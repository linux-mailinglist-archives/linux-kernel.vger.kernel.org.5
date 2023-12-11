Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A820C80CEDB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343819AbjLKOwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbjLKOwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:52:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5700C5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702306340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F4/c63W81BvM+O6zUBO7sErfAtzEOW/v1l60Jys6Kxg=;
        b=DdsHRedLtWXpOE6ShgV72mFW2HnCUBNJku8NK/pWoFgEE3OuaN+2cwoRuowfjFL55ZHwQ3
        PP1gVlvFDtFQ/jZMgrAnf0cwJ99PlU8TocevrKH4W7UZCo4ckGwjhf1I2VQCRVR9OAdo3j
        OS7Ynp91M8OGPjG/Um6EL8BFGIQA1B4=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-qmYNzR6kMaqxO3K05DD8cQ-1; Mon, 11 Dec 2023 09:52:11 -0500
X-MC-Unique: qmYNzR6kMaqxO3K05DD8cQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b9ed87a1fcso4178512b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702306323; x=1702911123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4/c63W81BvM+O6zUBO7sErfAtzEOW/v1l60Jys6Kxg=;
        b=n+fNTSvY1m3+zu9IwH1mdbu84IV7vqssuabYjuW1VQqUuLRJkQa6fG8YIBEVj15dAG
         AHWbTDTw3mmaFt6xmUFpNY8fHkG3p8nJKXCVuxSPfqJ6JNXQH1CMGwVplN6fq4GlTFf8
         sFZHOXmnF/sHmhOXMw/K9fgw2EsKPioumgmC+66qHimNyGL5NXZBznHEPpa/wZNo33tk
         BzuljpkrsCO4z8danm7RfW4AmYwFZmQKo8Y03pwLM5VEMZLpgGyDVw2vzf+AjaOc6CqA
         QsYrPpG5+oQ1FkLrgtf4Xxu86Tq0j+MIK3/3OU36RrnCgtR4quEKgOvDKlC5Sqf6FOT5
         zFDA==
X-Gm-Message-State: AOJu0YwXhhfYsNEursShbjpXg6xXyBILVIKuWLApGIvLyPD7FJXYGxfC
        wvEY1GMGGrZsaru2pjNISbJwZqhQEigExzrwID9NEZOxB0hGru8YNhtrSPWrHTiMvSdXWttd70H
        3b0T4GrB/dywwboKaYdxv5fii
X-Received: by 2002:a05:6808:2e4e:b0:3ba:b1f:f48f with SMTP id gp14-20020a0568082e4e00b003ba0b1ff48fmr2386138oib.63.1702306322408;
        Mon, 11 Dec 2023 06:52:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUsKr7+wo4TT4MpYp349e0mIdQ+GWyEGBAV+aGvA8URjLu0QzaDOCd5D4O8Hse16+Cf4Mwpw==
X-Received: by 2002:a05:6808:2e4e:b0:3ba:b1f:f48f with SMTP id gp14-20020a0568082e4e00b003ba0b1ff48fmr2386102oib.63.1702306321367;
        Mon, 11 Dec 2023 06:52:01 -0800 (PST)
Received: from localhost.localdomain ([151.29.78.8])
        by smtp.gmail.com with ESMTPSA id tr24-20020a05620a2d9800b0077d797676a4sm2970705qkn.122.2023.12.11.06.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:52:01 -0800 (PST)
Date:   Mon, 11 Dec 2023 15:51:57 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Aaron Tomlin <atomlin@atomlin.com>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        jiangshanlai@gmail.com, peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <um77hym4t6zyypfbhwbaeqxpfdzc657oa7vgowdfah7cuctjak@pexots3mfb24>
References: <20230729135334.566138-1-atomlin@atomlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729135334.566138-1-atomlin@atomlin.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just stumbled upon this series while looking into rescuers myself. :)

On 29/07/23 14:53, Aaron Tomlin wrote:
> The Linux kernel does not provide a way to differentiate between a
> kworker and a rescue kworker for user-mode.
> From user-mode, one can establish if a task is a kworker by testing for
> PF_WQ_WORKER in a specified task's flags bit mask (or bitmap) via
> /proc/[PID]/stat. Indeed, one can examine /proc/[PID]/stack and search
> for the function namely "rescuer_thread". This is only available to the
> root user.
> 
> It can be useful to identify a rescue kworker since their CPU affinity
> cannot be modified and their initial CPU assignment can be safely ignored.
> Furthermore, a workqueue that was created with WQ_MEM_RECLAIM and
> WQ_SYSFS the cpumask file is not applicable to the rescue kworker.
> By design a rescue kworker should run anywhere.

Guess this is a requirement because, if workqueue processing is stuck
for some reason, getting rescuers to run on the same set of cpus
workqueues have been restricted to already doesn't really have good
chances of making any progress?

Wonder if we still might need some sort of fail hard/warn mode in case
strict isolation is in place? Or maybe we have that already?

Thanks!
Juri

