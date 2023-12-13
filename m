Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D47811C94
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjLMScN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjLMScL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:32:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D458CB9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702492337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dJhCQPbtOQfgKm8z4OfKiUr7HEqaHFUnnxRgNKGT468=;
        b=Vy+jNB5Zn6rN8xcAVmNnRtVMHmDQKyDjAI28+bl7GyDirpZWKOufjR3iq1bvWD9wpwK6PX
        b/c3icbcXYQ3CQb/Ct/HcpesspOQzbbOAEONfxLKVcuvfMQm3TzgzWAgeRjmBLJiFIVG+D
        yk8QDQIsy3NOfSRg/pRghBeidvrv35M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-3jyEvenuOSeCZRjXHIITDA-1; Wed, 13 Dec 2023 13:32:15 -0500
X-MC-Unique: 3jyEvenuOSeCZRjXHIITDA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77f515c2a5fso742314485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:32:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492335; x=1703097135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJhCQPbtOQfgKm8z4OfKiUr7HEqaHFUnnxRgNKGT468=;
        b=PTk29oXlfgp1/sXf4vu8lE503ILHDOmnpx2V0m5wGztB5Er1ZEvyxC4vv3YgvjWMsC
         VLFn2kiYdmG0ZaEtuTROvCbSv+vCPfGNkguGF7QaK2pMMLdu4FwNi4Pgt7yG9LVQ3nFc
         +qNtuP3WUCnTpKmXNRz778jpNXbwo7IIQo5ReJU6rA7TV5dH02fVXakksPNZu1TmYeA5
         txXxaIrR2dF927pFEIitalO91QnRV331/0TVHwbxjQEfV1Gi+YxZrwiGJNcefRV+4BT8
         kEfFV1w0qgxWlxd8tOCHG5pJVN7WpLHsEKAE5ARRdwR46xBpkrHevN2llF/H2Sxu/48O
         dzUw==
X-Gm-Message-State: AOJu0Yz4JttO3EiJeganOtW2oLYRWKpPFjQZoWQfZvMbWtTY0mFdO5Ma
        nhS1y1A581OT4jwi5vR6w+PQGz49yZ+nrlMk+zcPtbxqKW4oLuwwr0Mdf7iAy7Wjt5dWvPEQbSR
        lp5REEhODB5tiVIEkq0la+IfI
X-Received: by 2002:a05:620a:839b:b0:77f:3bc0:4be0 with SMTP id pb27-20020a05620a839b00b0077f3bc04be0mr10510564qkn.63.1702492334899;
        Wed, 13 Dec 2023 10:32:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESFoDoQ7hf4ltxCiuxXv1SL4DQdY0uyjdMI86HCCGd+JMnuPhPootCPLYF1jHsRRedJikYvA==
X-Received: by 2002:a05:620a:839b:b0:77f:3bc0:4be0 with SMTP id pb27-20020a05620a839b00b0077f3bc04be0mr10510555qkn.63.1702492334583;
        Wed, 13 Dec 2023 10:32:14 -0800 (PST)
Received: from localhost.localdomain ([151.29.78.8])
        by smtp.gmail.com with ESMTPSA id g3-20020a05620a278300b0077f435ed844sm4674999qkp.112.2023.12.13.10.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:32:14 -0800 (PST)
Date:   Wed, 13 Dec 2023 19:32:10 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <ZXn4qiMetd7zY1sb@localhost.localdomain>
References: <20230729135334.566138-1-atomlin@atomlin.com>
 <um77hym4t6zyypfbhwbaeqxpfdzc657oa7vgowdfah7cuctjak@pexots3mfb24>
 <ZXdXdBzvbkI4Y4fL@slm.duckdns.org>
 <ZXguMgcKLCLn16T4@localhost.localdomain>
 <ZXiVCOKk90Fjpmhw@slm.duckdns.org>
 <ZXlyfjDsFGbYcMU6@localhost.localdomain>
 <ZXnPVtISKQ2JFDNn@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXnPVtISKQ2JFDNn@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/23 05:35, Tejun Heo wrote:
> Hello,
> 
> On Wed, Dec 13, 2023 at 09:59:42AM +0100, Juri Lelli wrote:
> > Something like the following then maybe?
> > 
> > ---
> >  kernel/workqueue.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 2989b57e154a7..ed73f7f80d57d 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -4405,6 +4405,12 @@ static void apply_wqattrs_commit(struct apply_wqattrs_ctx *ctx)
> >         link_pwq(ctx->dfl_pwq);
> >         swap(ctx->wq->dfl_pwq, ctx->dfl_pwq);
> > 
> > +       /* rescuer needs to respect wq cpumask changes */
> > +       if (ctx->wq->rescuer) {
> > +               kthread_bind_mask(ctx->wq->rescuer->task, ctx->attrs->cpumask);
> > +               wake_up_process(ctx->wq->rescuer->task);
> > +       }
> > +
> >         mutex_unlock(&ctx->wq->mutex);
> >  }
> 
> I'm not sure kthread_bind_mask() would be safe here. The rescuer might be
> running a work item. wait_task_inactive() might fail and we don't want to
> change cpumask while the rescuer is active anyway.
> 
> Maybe the easiest way to do this is making rescuer_thread() restore the wq's
> cpumask right before going to sleep, and making apply_wqattrs_commit() just
> wake up the rescuer.

Hummm, don't think we can call that either while the rescuer is actually
running. Maybe we can simply s/kthread_bind_mask/set_cpus_allowed_ptr/
in the above?

Thanks,
Juri

