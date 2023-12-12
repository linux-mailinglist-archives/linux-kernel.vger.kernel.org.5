Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF2780F396
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376336AbjLLQwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjLLQwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:52:09 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BFBCF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:52:16 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-dbcb66cdf87so1085033276.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702399935; x=1703004735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iB7faUxPOIljjBMh/VHLAZIKGCom3gnDztWcUHW1bf8=;
        b=f9xhygknzO0l3IDpH+LSa43pQGSRMrG8cQdW8HXUU1StWR9dl21+gTihdEmOYXmbFx
         HhgxlzSgXZ9tO3hdDiAvdI18IAYykLRDQRW/JASu6gn4DZ8pPEx9/vGECeOnUyQJaLDp
         wxxplygyF5LTacF7nK5C8teVPqyUlw6QDTFac1FPjF2KvJYAvxK8PFW0FoxluNHl2tjQ
         U8aGZNclIatONhGY8QSQ6LMOTX0zQJe5vwujNC5OlL265LZYnKJfyLVtDt5ZiKOL7TU4
         eRp6/p1VPDGxPBvxpjRVASuXWkh/Pw7Bwba74czap7DOG+jl7zXB6a9qADUyJCENlIcL
         qKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702399935; x=1703004735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iB7faUxPOIljjBMh/VHLAZIKGCom3gnDztWcUHW1bf8=;
        b=PEiSHHEt0EhY03pvhaEFd9sJGU5BAzbnCMnqZi+nVHu6cOaELT9WczU6TG2aQTe98O
         DtIBi7QnYGmq/y8rPHHKqZAygSKhfHBcltPIFw9/4ww+eEgfXhJyFufQLhESFeOCbrCo
         1BKAevcX3aEEaEYTfVvNFzHGeds8LM6/ImgOo3DsRJL6kAp3ZBCk/i24WnPPTWR9emIn
         ZwLB+NNRug+B4+ZsVeu8Fbz8S3jpszEWfv1RatYMtm2/hNAI2YQJxD5SeJUyUKQQHUtz
         t1Vk2OnE6YLWbsEcSz4p3iheFfAS0K1K8lcNp9WeEhAOE5K814hixvlqZv0Ml3WmX/Qa
         hiqQ==
X-Gm-Message-State: AOJu0Yz5KBRX8r6KwxDXeQ5Sv7fNXHZZhxlRzrKIfWY1LHIAl8tVIDWj
        +xB22B8vO6e0bn3hQlgpO1g=
X-Google-Smtp-Source: AGHT+IHhnxqn1gYcvR9PetE7ziKeKeS1ZL++QKkKCG404I9PRi337miaP/mGLzyJKjoPAB7ksLTc1A==
X-Received: by 2002:a05:6902:e01:b0:db5:3a74:a9ac with SMTP id df1-20020a0569020e0100b00db53a74a9acmr4903408ybb.18.1702399935560;
        Tue, 12 Dec 2023 08:52:15 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id 67-20020a251546000000b00d9caecd5c86sm3352834ybv.62.2023.12.12.08.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:52:15 -0800 (PST)
Date:   Tue, 12 Dec 2023 08:52:14 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 3/7] lib/group_cpus: relax atomicity requirement in
 grp_spread_init_one()
Message-ID: <ZXiPvgzZvXyWfarS@yury-ThinkPad>
References: <20231212042108.682072-1-yury.norov@gmail.com>
 <20231212042108.682072-4-yury.norov@gmail.com>
 <ZXgszD9tIKY1tC9r@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXgszD9tIKY1tC9r@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 05:50:04PM +0800, Ming Lei wrote:
> On Mon, Dec 11, 2023 at 08:21:03PM -0800, Yury Norov wrote:
> > Because nmsk and irqmsk are stable, extra atomicity is not required.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  lib/group_cpus.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> > index 10dead3ab0e0..7ac94664230f 100644
> > --- a/lib/group_cpus.c
> > +++ b/lib/group_cpus.c
> > @@ -24,8 +24,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> >  		if (cpu >= nr_cpu_ids)
> >  			return;
> >  
> > -		cpumask_clear_cpu(cpu, nmsk);
> > -		cpumask_set_cpu(cpu, irqmsk);
> > +		__cpumask_clear_cpu(cpu, nmsk);
> > +		__cpumask_set_cpu(cpu, irqmsk);
> >  		cpus_per_grp--;
> >  
> >  		/* If the cpu has siblings, use them first */
> > @@ -33,8 +33,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> >  		sibl = cpu + 1;
> >  
> >  		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
> > -			cpumask_clear_cpu(sibl, nmsk);
> > -			cpumask_set_cpu(sibl, irqmsk);
> > +			__cpumask_clear_cpu(sibl, nmsk);
> > +			__cpumask_set_cpu(sibl, irqmsk);
> 
> I think this kind of change should be avoided, here the code is
> absolutely in slow path, and we care code cleanness and readability
> much more than the saved cycle from non atomicity.

Atomic ops have special meaning and special function. This 'atomic' way
of moving a bit from one bitmap to another looks completely non-trivial
and puzzling to me.

A sequence of atomic ops is not atomic itself. Normally it's a sing of
a bug. But in this case, both masks are stable, and we don't need
atomicity at all.

It's not about performance, it's about readability.

Thanks,
Yury
