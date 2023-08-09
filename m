Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED0277639D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjHIPWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHIPW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:22:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D55D1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691594501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRLJpwAQImdZYLqf6+rAi+eBbt4cPSvZ88BbNM5QqeY=;
        b=FPBP/Km483TeYSvVMUXRFVi5n7k3k3Gal6p8IOQqvuAH95sSAgmatC3Pvx47B2wrl0TjR3
        S/yhj689Y07HRVSOY1erPLKSEGo50/vhDOnmLqVux5rKBb7Qx8T8JrCmpm4UgLAsRfzcto
        uZSkHNUmxivUKnuj8Vwk2IN1Vgo9x2c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-3cdCFMemNKiz-_i2dRaBNQ-1; Wed, 09 Aug 2023 11:21:39 -0400
X-MC-Unique: 3cdCFMemNKiz-_i2dRaBNQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3178532c6c8so3488122f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691594498; x=1692199298;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRLJpwAQImdZYLqf6+rAi+eBbt4cPSvZ88BbNM5QqeY=;
        b=ehiXVjTJ0OZXn6ygAIO6FyT19h2bIBw4+S526IFjLqH2wX87va0DcfQA5oy1+HOLFq
         +19WhTiS8T69BMfVpHB2TyTg4xrgy0t0ErYSdBCD/7x8v3J8If9lP2hUdRYIgCK6vHr9
         joZ6mpjuwSjPDuWMTqcdDvLGpn4HTU4vNVXzi73vvpswLRiqXU+l9g8dgG3Ymw6Dl0dt
         xaKeafvPywCHQSqy38GrvfG3RQ5YWhiUR9psON8hnLOfrlg8IvPYJ46BNA9fZqQRhbRp
         xjSNl1qEjayqADA8Lr+kHHtw1bxlOZpl/l60vJlH+ICiQZiS4FO29fxjKsiAivwIN38Z
         6qrg==
X-Gm-Message-State: AOJu0Yw03ZCRgJbxk9DFK4BB9oia6xCMZysdKe9O3ldj2/NY7X8HgmuW
        Gt3+ZPgR+vcEglKUw2UG3puKEW7fVrkcDI4HOYfG4fDmlqSr2DfGp86Ey+r+gw3efwWmPYGyGLT
        +EVV7mbdfrPHQoTNBgesNSChnurlMynHKPcLzRzln08X21u6ajPWScGiyba2diSX4eoMzVCAccp
        Dv/C1/55DU
X-Received: by 2002:a5d:400a:0:b0:317:df3a:d030 with SMTP id n10-20020a5d400a000000b00317df3ad030mr1832528wrp.14.1691594498060;
        Wed, 09 Aug 2023 08:21:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ5OocP2Pv7SfIK1ucnKM27UrtTBpt4d6kaJHmI9cKjORA04ME3ujpoMomk5YvDcT4gPElcg==
X-Received: by 2002:a5d:400a:0:b0:317:df3a:d030 with SMTP id n10-20020a5d400a000000b00317df3ad030mr1832502wrp.14.1691594497683;
        Wed, 09 Aug 2023 08:21:37 -0700 (PDT)
Received: from vschneid.remote.csb ([93.186.150.163])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003fe1c332810sm2297841wmi.33.2023.08.09.08.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 08:21:37 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] sched: Simplify ttwu()
In-Reply-To: <20230801211812.101069260@infradead.org>
References: <20230801204121.929256934@infradead.org>
 <20230801211812.101069260@infradead.org>
Date:   Wed, 09 Aug 2023 16:21:36 +0100
Message-ID: <xhsmh4jl8ckcf.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/23 22:41, Peter Zijlstra wrote:
> Use guards to reduce gotos and simplify control flow.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c |  221 +++++++++++++++++++++++++---------------------------
>  1 file changed, 109 insertions(+), 112 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3706,14 +3706,14 @@ ttwu_stat(struct task_struct *p, int cpu
>               struct sched_domain *sd;
>
>               __schedstat_inc(p->stats.nr_wakeups_remote);
> -		rcu_read_lock();
> +
> +		guard(rcu)();

This isn't strictly equivalent, right? AFAICT that pushes the
rcu_read_unlock() further down than it currently is - not a big deal, but
indentation aside scoped_guard() would preserve that.

