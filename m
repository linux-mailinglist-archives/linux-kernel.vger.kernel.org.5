Return-Path: <linux-kernel+bounces-31700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D728332A4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 04:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2701F22730
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08458110F;
	Sat, 20 Jan 2024 03:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUafH5AE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C538110E1
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 03:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705722736; cv=none; b=XkCNcnTxeVB80SJM72EXqgngIQTofA/MtFEFcunqfnqjX0WqGmXBcCd5YaK5dWdgr6+nnpVmw4ABvNJ5yq0l4+/voqzsFvJ0WkKLOy4qxdYdLNM+mpeuSV4VpIYOr0XhdntBx7TH0xmE10I/aVvtMWVXbH9rYJWyAtzsqba6RzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705722736; c=relaxed/simple;
	bh=mJkTNRzDBZqU10kWG6Ct9fboRldQz/A2W0T4puxRyKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqhZa5kRcFgwh4EJl1KWJotI7c5HgwikZyas4pgpoXM57L/dN2XQa+PzuIgjEctaXdiU7nGVoddD3jMGLhaB/EzbGr4ik++qu/NeueDz83SyQ7CATGG3i45YdQXXouPihLO5f2mJnbkGvAew6Muo9pbYW5QgomBZUwEYzNr9nsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RUafH5AE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705722733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fRDWoFpeQXxzTxwHVNQuyihaKBvu135bEPvcbfLZPLM=;
	b=RUafH5AEWfuWuZXXLAKTST1DVwCr+rQa9TQ+h43Y83A0N/DlN8rpKHfnotDK5BSGlhcIFV
	vnZEJxenNiJplUpZsmw4MrnU4EwDAOXWUUeOA3k7jlOFtcRax6ECAO0H1Sil4XwqympjeI
	Z1CfA0Jxaf0OGsE9Bmtyg7X//wybtL0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-qyodwol7PEGw8YyGIV_oiw-1; Fri,
 19 Jan 2024 22:52:07 -0500
X-MC-Unique: qyodwol7PEGw8YyGIV_oiw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA8C929AC02E;
	Sat, 20 Jan 2024 03:52:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BA74492BE2;
	Sat, 20 Jan 2024 03:52:01 +0000 (UTC)
Date: Sat, 20 Jan 2024 11:51:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Zi Yan <ziy@nvidia.com>, ming.lei@redhat.com
Subject: Re: [PATCH 4/9] lib/group_cpus: optimize outer loop in
 grp_spread_init_one()
Message-ID: <ZatDXvhvt0mLTi2m@fedora>
References: <20240120025053.684838-1-yury.norov@gmail.com>
 <20240120025053.684838-5-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120025053.684838-5-yury.norov@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Fri, Jan 19, 2024 at 06:50:48PM -0800, Yury Norov wrote:
> Similarly to the inner loop, in the outer loop we can use for_each_cpu()
> macro, and skip CPUs that have been moved.
> 
> With this patch, the function becomes O(1), despite that it's a
> double-loop.
> 
> While here, add a comment why we can't merge outer logic into the inner
> loop.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  lib/group_cpus.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index 0a8ac7cb1a5d..952aac9eaa81 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -17,16 +17,17 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
>  	const struct cpumask *siblmsk;
>  	int cpu, sibl;
>  
> -	for ( ; cpus_per_grp > 0; ) {
> -		cpu = cpumask_first(nmsk);
> -
> -		/* Should not happen, but I'm too lazy to think about it */
> -		if (cpu >= nr_cpu_ids)
> +	for_each_cpu(cpu, nmsk) {
> +		if (cpus_per_grp-- == 0)
>  			return;
>  
> +		/*
> +		 * If a caller wants to spread IRQa on offline CPUs, we need to
> +		 * take care of it explicitly because those offline CPUS are not
> +		 * included in siblings cpumask.
> +		 */
>  		__cpumask_clear_cpu(cpu, nmsk);
>  		__cpumask_set_cpu(cpu, irqmsk);
> -		cpus_per_grp--;
>  
>  		/* If the cpu has siblings, use them first */
>  		siblmsk = topology_sibling_cpumask(cpu);
> @@ -38,6 +39,7 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
>  
>  			__cpumask_clear_cpu(sibl, nmsk);
>  			__cpumask_set_cpu(sibl, irqmsk);
> +			cpu = sibl + 1;

It has been tricky enough to update condition variable of for_each_cpu()
(such kind of pattern can't build in Rust at all), and the above line could
be more tricky actually.

You can get O(1)(not sure it matters here) by using cpumask_next(), which
is more readable, isn't it?

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 564d8e817f65..e0ce878ac4c4 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -15,10 +15,10 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 				unsigned int cpus_per_grp)
 {
 	const struct cpumask *siblmsk;
-	int cpu, sibl;
+	int cpu = -1;
 
-	for ( ; cpus_per_grp > 0; ) {
-		cpu = cpumask_first(nmsk);
+	while (cpus_per_grp > 0) {
+		cpu = cpumask_next(cpu, nmsk);
 
 		/* Should not happen, but I'm too lazy to think about it */
 		if (cpu >= nr_cpu_ids)
@@ -30,9 +30,9 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 
 		/* If the cpu has siblings, use them first */
 		siblmsk = topology_sibling_cpumask(cpu);
-		for_each_cpu_and(sibl, siblmsk, nmsk) {
-			cpumask_clear_cpu(sibl, nmsk);
-			cpumask_set_cpu(sibl, irqmsk);
+		for_each_cpu_and(cpu, siblmsk, nmsk) {
+			cpumask_clear_cpu(cpu, nmsk);
+			cpumask_set_cpu(cpu, irqmsk);
 			if (--cpus_per_grp == 0)
 				return;
 		}




Thanks,
Ming


