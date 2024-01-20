Return-Path: <linux-kernel+bounces-31728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B984283330E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 08:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BA61C21BBC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94A6210B;
	Sat, 20 Jan 2024 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyEhgxwT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525291C30
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705734198; cv=none; b=DDBjoO2cPrArVMyJs/O4XtQmhmcw3FQXa+NLQu8mh1DJvdSK8AYp4T+qzPk5d1pnVyRJel5UwXmdWWGKeZBC7dkkOD8Oj6odLQ5lw6Uny1MoLVa7lwEp05ZYykl0MCDu2H59rT3LvUlOxHFWdkw8wtRjyP5fsEPI1Jq3dIc17DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705734198; c=relaxed/simple;
	bh=KQP8FxhKPCpe5JZ5hVMdfuALRDL0DVWgzNWH1zUBkks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSwO4Rj9rDm5N28SuX8juOl1dXPcWon8owBaOMvF6uRnoecsozFiiecbjjDulr+9k8gEkTySzzcIXPSB2xMxhswy27SFUF2pDFnYuo0kYQJaJ+nIYaUNgeRf+zgDPA5hHHyZBrULWzJMqeEq7lBxt4ifY2Me06XoUZdbuhTj5H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyEhgxwT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705734196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qu3Mqo9aXOL2kJf6F6pQtGtcu81YgdEqsQ0EhRW8UbU=;
	b=hyEhgxwTVbbV7zvYhyqZHgs+42znwjDRdGLXPe9KcmvSN0fRAOo0sL9VD2FYjr52z6Z8uj
	XoYkh23lSzlhb29pwKsnpA7Pyl1RD8kG5AS64ifIsdHReXOB0To77fFdMyz0akxc1xkYpS
	bX1GGjV3ehEO/phhGfbgTQBxDa4UteM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-O6tcrH4NOAWlkEMxBkq0QA-1; Sat,
 20 Jan 2024 02:03:11 -0500
X-MC-Unique: O6tcrH4NOAWlkEMxBkq0QA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AE681C05139;
	Sat, 20 Jan 2024 07:03:09 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 41458492BE2;
	Sat, 20 Jan 2024 07:03:03 +0000 (UTC)
Date: Sat, 20 Jan 2024 15:03:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH 2/9] lib/group_cpus: optimize inner loop in
 grp_spread_init_one()
Message-ID: <ZatwJE6d9Kp3GuBy@fedora>
References: <20240120025053.684838-1-yury.norov@gmail.com>
 <20240120025053.684838-3-yury.norov@gmail.com>
 <Zas7LI1v5Adk/VVP@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zas7LI1v5Adk/VVP@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Sat, Jan 20, 2024 at 11:17:00AM +0800, Ming Lei wrote:
> On Fri, Jan 19, 2024 at 06:50:46PM -0800, Yury Norov wrote:
> > The loop starts from the beginning every time we switch to the next
> > sibling mask. This is the Schlemiel the Painter's style of coding
> > because we know for sure that nmsk is clear up to current CPU, and we
> > can just continue from the next CPU.
> > 
> > Also, we can do it nicer if leverage the dedicated for_each() iterator,
> > and simplify the logic of clearing a bit in nmsk.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  lib/group_cpus.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> > index ee272c4cefcc..063ed9ae1b8d 100644
> > --- a/lib/group_cpus.c
> > +++ b/lib/group_cpus.c
> > @@ -30,14 +30,14 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> >  
> >  		/* If the cpu has siblings, use them first */
> >  		siblmsk = topology_sibling_cpumask(cpu);
> > -		for (sibl = -1; cpus_per_grp > 0; ) {
> > -			sibl = cpumask_next(sibl, siblmsk);
> > -			if (sibl >= nr_cpu_ids)
> > -				break;
> > -			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
> > -				continue;
> > +		sibl = cpu + 1;
> 
> No, it is silly to let 'sibl' point to 'cpu + 1', cause we just
> want to iterate over 'siblmsk & nmsk', and nothing to do with
> the next cpu('cpu + 1').
> 
> > +
> > +		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
> > +			if (cpus_per_grp-- == 0)
> > +				return;
> > +
> > +			cpumask_clear_cpu(sibl, nmsk);
> >  			cpumask_set_cpu(sibl, irqmsk);
> > -			cpus_per_grp--;
> 
> Andrew, please replace the 1st two patches with the following one:
> 
> From 7a983ee5e1b4f05e5ae26c025dffd801b909e2f3 Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Sat, 20 Jan 2024 11:07:26 +0800
> Subject: [PATCH] lib/group_cpus.c: simplify grp_spread_init_one()
> 
> What the inner loop needs to do is to iterate over `siblmsk & nmsk`, and
> clear the cpu in 'nmsk' and set it in 'irqmsk'.
> 
> Clean it by for_each_cpu_and().
> 
> This is based on Yury Norov's patch, which needs one extra
> for_each_cpu_and_from(), which is really not necessary.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  lib/group_cpus.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index ee272c4cefcc..564d8e817f65 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -30,14 +30,11 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
>  
>  		/* If the cpu has siblings, use them first */
>  		siblmsk = topology_sibling_cpumask(cpu);
> -		for (sibl = -1; cpus_per_grp > 0; ) {
> -			sibl = cpumask_next(sibl, siblmsk);
> -			if (sibl >= nr_cpu_ids)
> -				break;
> -			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
> -				continue;
> +		for_each_cpu_and(sibl, siblmsk, nmsk) {
> +			cpumask_clear_cpu(sibl, nmsk);
>  			cpumask_set_cpu(sibl, irqmsk);
> -			cpus_per_grp--;
> +			if (--cpus_per_grp == 0)
> +				return;

Iterator variable of 'nmsk' is updated inside loop, and it is still
tricky, so please ignore it, I just sent one formal & revised patch:

https://lkml.org/lkml/2024/1/20/43


Thanks,
Ming


