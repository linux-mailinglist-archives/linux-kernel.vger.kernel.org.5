Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434268110AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbjLMMA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjLMMAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:00:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82201E8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702468860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nTPYpZwAOhjAyPYYnK4hzvfKTahVi5tJRBmZC1f6ZW8=;
        b=CQQLAnqQbHtNxnvHZKenqqaLoMBpGtsGjUdN5n8Vuij2pIw8JWexDOZkm0zu1xCG2MGzds
        XghIj5cVWodhXCZ+KW3XjK+19BycSenweQVduJz3AWEm3mhmI3iBw8QP0XwnSbktNuyXQB
        PwdmXL6EsZgTxqr2W80t/eSnVbkO+i8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-KvlukhJOO-GNfbsRE7S8Jw-1; Wed, 13 Dec 2023 07:00:58 -0500
X-MC-Unique: KvlukhJOO-GNfbsRE7S8Jw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-55223c5b428so273797a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:00:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702468858; x=1703073658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTPYpZwAOhjAyPYYnK4hzvfKTahVi5tJRBmZC1f6ZW8=;
        b=pzUxTUIr7FPIgSr99a8donHyLj0r2vBDZKAEkRLdk9IRNyqy4BcRgvzu2IzjpY2BgD
         SpphGrlwPLdZxCyVnZeTfyhKAfOXl/NSgov83G2UvhSqX3DGJ9vJpQirTiaIlsB1l39t
         LkSC8fGu7ZahPXwdcU+QnmuXVFLb7Br1unmgXLF2exduAHpkdqTg7RtJP/SzZ7WRkbJE
         YKGgvAorUr/xeRg/vf+9I9XcCnjsRRryR9fcLHizl3IaTnYtsFrxQFZgtWRatmCo58Ev
         JPLeJS+kdZZDbMIYpZxfwN6RfMETKLetKxXSm182JrY/6P+p+zohkeW50DWRKaSoAzrc
         6WUw==
X-Gm-Message-State: AOJu0YxD8VoPh3xu/g1MANU3ET6v7BvadDideu0/rmPgAjdliMDUjVcD
        QaXsskAYQGzEs36Bjk68pP4Z34/dn2LrlhHP8Cf9k/vlSlEJsb06j9PfL8cdEJgDXp2QHJ0cLu7
        ZAFctSUI42xCPDFzSI7B68gnX
X-Received: by 2002:a50:858d:0:b0:551:1775:207 with SMTP id a13-20020a50858d000000b0055117750207mr2984147edh.17.1702468857820;
        Wed, 13 Dec 2023 04:00:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0c9/lpfdtIRoYWRQu0pmj/b0D4R6L9UEAHj8W7P/aMFmYE+jvnwxBab8G5vMGQjvYkS/yKg==
X-Received: by 2002:a50:858d:0:b0:551:1775:207 with SMTP id a13-20020a50858d000000b0055117750207mr2984133edh.17.1702468857417;
        Wed, 13 Dec 2023 04:00:57 -0800 (PST)
Received: from redhat.com ([2a02:14f:16d:d414:dc39:9ae8:919b:572d])
        by smtp.gmail.com with ESMTPSA id c63-20020a509fc5000000b0054c738b6c31sm5913003edf.55.2023.12.13.04.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 04:00:56 -0800 (PST)
Date:   Wed, 13 Dec 2023 07:00:53 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tobias Huschle <huschle@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20231213061719-mutt-send-email-mst@kernel.org>
References: <20231207014626-mutt-send-email-mst@kernel.org>
 <56082.123120804242300177@us-mta-137.us.mimecast.lan>
 <20231208052150-mutt-send-email-mst@kernel.org>
 <53044.123120806415900549@us-mta-342.us.mimecast.lan>
 <20231209053443-mutt-send-email-mst@kernel.org>
 <CACGkMEuSGT-e-i-8U7hum-N_xEnsEKL+_07Mipf6gMLFFhj2Aw@mail.gmail.com>
 <20231211115329-mutt-send-email-mst@kernel.org>
 <CACGkMEudZnF7hUajgt0wtNPCxH8j6A3L1DgJj2ayJWhv9Bh1WA@mail.gmail.com>
 <20231212111433-mutt-send-email-mst@kernel.org>
 <42870.123121305373200110@us-mta-641.us.mimecast.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42870.123121305373200110@us-mta-641.us.mimecast.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:37:23AM +0100, Tobias Huschle wrote:
> On Tue, Dec 12, 2023 at 11:15:01AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Dec 12, 2023 at 11:00:12AM +0800, Jason Wang wrote:
> > > On Tue, Dec 12, 2023 at 12:54 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> We played around with the suggestions and some other ideas.
> I would like to share some initial results.
> 
> We tried the following:
> 
> 1. Call uncondtional schedule in the vhost_worker function
> 2. Change the HZ value from 100 to 1000
> 3. Reverting 05bfb338fa8d vhost: Fix livepatch timeouts in vhost_worker()
> 4. Adding a cond_resched to translate_desc
> 5. Reducing VHOST_NET_WEIGHT to 25% of its original value
> 
> Please find the diffs below.
> 
> Summary:
> 
> Option 1 is very very hacky but resolved the regression.
> Option 2 reduces the regression by ~20%.
> Options 3-5 do not help unfortunately.
> 
> Potential explanation:
> 
> While the vhost is executing, the need_resched flag is not set (observable
> in the traces). Therefore cond_resched and alike will do nothing. vhost
> will continue executing until the need_resched flag is set by an external
> party, e.g. by a request to migrate the vhost.
> 
> Calling schedule unconditionally forces the scheduler to re-evaluate all 
> tasks and their vruntime/deadline/vlag values. The scheduler comes to the
> correct conclusion, that the kworker should be executed and from there it
> is smooth sailing. I will have to verify that sequence by collecting more
> traces, but this seems rather plausible.
> This hack might of course introduce all kinds of side effects but might
> provide an indicator that this is the actual problem.
> The big question would be how to solve this conceptually, and, first
> things first, whether you think this is a viable hypothesis.
> 
> Increasing the HZ value helps most likely because the other CPUs take 
> scheduling/load balancing decisions more often as well and therefore
> trigger the migration faster.
> 
> Bringing down VHOST_NET_WEIGHT even more might also help to shorten the
> vhost loop. But I have no intuition how low we can/should go here.
> 
> 
> We also changed vq_err to print error messages, but did not encounter any.
> 
> Diffs:
> --------------------------------------------------------------------------
> 
> 1. Call uncondtional schedule in the vhost_worker function
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index e0c181ad17e3..16d73fd28831 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -414,6 +414,7 @@ static bool vhost_worker(void *data)
>                 }
>         }
>  
> +       schedule();
>         return !!node;
>  }


So, this helps.
But this is very surprising!


static int vhost_task_fn(void *data)
{
        struct vhost_task *vtsk = data;
        bool dead = false;

        for (;;) {
                bool did_work;

                if (!dead && signal_pending(current)) {
                        struct ksignal ksig;
                        /*
                         * Calling get_signal will block in SIGSTOP,
                         * or clear fatal_signal_pending, but remember
                         * what was set.
                         *
                         * This thread won't actually exit until all
                         * of the file descriptors are closed, and
                         * the release function is called.
                         */
                        dead = get_signal(&ksig);
                        if (dead)
                                clear_thread_flag(TIF_SIGPENDING);
                }

                /* mb paired w/ vhost_task_stop */
                set_current_state(TASK_INTERRUPTIBLE);

                if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
                        __set_current_state(TASK_RUNNING);
                        break;
                }

                did_work = vtsk->fn(vtsk->data);
                if (!did_work)
                        schedule();
        }

        complete(&vtsk->exited);
        do_exit(0);

}

Apparently schedule is already called?


-- 
MST

