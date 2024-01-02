Return-Path: <linux-kernel+bounces-13963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C9A821612
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF1E1C20E6F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 01:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76B439C;
	Tue,  2 Jan 2024 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/LT2nBB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD1F38F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704157211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hcc4pAQzd2rxMdXSsOBe+jhEr0wxx2GgMsJmhu64YE0=;
	b=f/LT2nBBYc2f8dbDJKRQEKFbdRpVbXvvsPzlvcCSsSNUYi49fqyIgTFzeZgfELTZHsFw3O
	gAiuXb9dWtPOy0FJXONJ+oogMeKtOFnc4oZnT40ZP4Jd3XSXjnczL54p0E31LcpbeO4GJA
	9+/aFWr4veEjGl3INuo2jkIYq2oePWQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1--VHgKJ6MOsW03mfA5PNa6w-1; Mon, 01 Jan 2024 20:00:05 -0500
X-MC-Unique: -VHgKJ6MOsW03mfA5PNa6w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C77E1807F6D;
	Tue,  2 Jan 2024 01:00:04 +0000 (UTC)
Received: from fedora (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2367F492BE6;
	Tue,  2 Jan 2024 01:00:00 +0000 (UTC)
Date: Tue, 2 Jan 2024 08:59:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 2/9] lib/group_cpus: optimize inner loop in
 grp_spread_init_one()
Message-ID: <ZZNgDb6bzOscrNmk@fedora>
References: <20231228200936.2475595-1-yury.norov@gmail.com>
 <20231228200936.2475595-3-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228200936.2475595-3-yury.norov@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Thu, Dec 28, 2023 at 12:09:29PM -0800, Yury Norov wrote:
> The loop starts from the beginning every time we switch to the next
> sibling mask. This is the Schlemiel the Painter's style of coding
> because we know for sure that nmsk is clear up to the current CPU,
> and we can just continue from the next CPU.
> 
> Also, we can do it nicer if leverage the dedicated for_each() iterator,
> and simplify the logic of clearing a bit in nmsk.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  lib/group_cpus.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index ee272c4cefcc..063ed9ae1b8d 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -30,14 +30,14 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
>  
>  		/* If the cpu has siblings, use them first */
>  		siblmsk = topology_sibling_cpumask(cpu);
> -		for (sibl = -1; cpus_per_grp > 0; ) {
> -			sibl = cpumask_next(sibl, siblmsk);
> -			if (sibl >= nr_cpu_ids)
> -				break;
> -			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
> -				continue;
> +		sibl = cpu + 1;
> +
> +		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
> +			if (cpus_per_grp-- == 0)
> +				return;
> +
> +			cpumask_clear_cpu(sibl, nmsk);
>  			cpumask_set_cpu(sibl, irqmsk);
> -			cpus_per_grp--;

Again, here it is simpler to use for_each_cpu_and() directly, see previous
comment:

https://lore.kernel.org/lkml/ZXgsDcM21H%2F2BTck@fedora/

Meantime patch 1 isn't needed, follows this easier proposal:

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index ee272c4cefcc..564d8e817f65 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -30,14 +30,11 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 
 		/* If the cpu has siblings, use them first */
 		siblmsk = topology_sibling_cpumask(cpu);
-		for (sibl = -1; cpus_per_grp > 0; ) {
-			sibl = cpumask_next(sibl, siblmsk);
-			if (sibl >= nr_cpu_ids)
-				break;
-			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
-				continue;
+		for_each_cpu_and(sibl, siblmsk, nmsk) {
+			cpumask_clear_cpu(sibl, nmsk);
 			cpumask_set_cpu(sibl, irqmsk);
-			cpus_per_grp--;
+			if (--cpus_per_grp == 0)
+				return;
 		}
 	}
 }

Thanks,
Ming


