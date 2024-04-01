Return-Path: <linux-kernel+bounces-127061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7908894651
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5381F21B41
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41A053E1E;
	Mon,  1 Apr 2024 20:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyjRwpYV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43152446AC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005005; cv=none; b=u8qkS3M/eHDpAHcn0xjHKEx46PxyPYdVxtPt+tGv8jik/d1yvYL0O68hWJT+XKKiSlBXyi5THDYWF2VUQrQswpNIwAqNycZb/JVPA2U5xRGb9XKNSsnZoCREzqBi2Necdv5l2nsezipzfuvR0m7s7Om5gq3GGj/cOIFfk8fWEs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005005; c=relaxed/simple;
	bh=Ccin4Icn1qgvopSjsv4m4lExPsGJNP2O5m4RYgv/XpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOA0kOa7Vg9tnCwar87zJrv4NJb3zT4yJf7DrTu5Znp6wFHTc4SdSrWCoJGbVLOtkLRlN+dRnDUZ+uJrXjsUCMB7EbihNmB6mvZaawMU1PyaUKbJHm+uETmETw5pjWqiTZvAEBlwagZOEhwE4KDjqs0Mqg8Og2pwaDlaN7vIFcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyjRwpYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DC7C433C7;
	Mon,  1 Apr 2024 20:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712005004;
	bh=Ccin4Icn1qgvopSjsv4m4lExPsGJNP2O5m4RYgv/XpE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OyjRwpYVxL1Qoxium4pjRPKV1qeSk1VTYusdbyPfm50oXs3WtHYb8hhjNfsuyZS/b
	 QgeWolFLXg8gVRDiZLaOBk1oI6HFYTKAYnBfFzlh6J0XBUZd+vaLP0SUonHxFR/3Rj
	 kwNeLznaLwGqHAXwPkWYJe0W6U+Gv+6l4qyMAs4AvMU2JIoi8g3/Xgu3OFwcEkftTI
	 LAX/DHJrYuOj70kZGycxz9Jd80OdCxo464FmMLNOfHAIDQbKpf2HzArz77ms+n7t5S
	 xgOFS1sxrSilAQzfcYwQ3bvOcEnUi+i/PWCrmjJjd9mN0pTueRmcycvO9ZVFJDNSfw
	 1jjMgtNlSgiAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7571FCE0738; Mon,  1 Apr 2024 13:56:44 -0700 (PDT)
Date: Mon, 1 Apr 2024 13:56:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: imran.f.khan@oracle.com, leobras@redhat.com,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	riel@surriel.com, tglx@linutronix.de
Subject: Re: [PATCH v2] smp: Use str_plural() to fix Coccinelle warnings
Message-ID: <4382b62a-7625-438e-8eaf-137bd88a499b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240327224216.54342-2-thorsten.blum@toblux.com>
 <20240401143117.171139-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401143117.171139-2-thorsten.blum@toblux.com>

On Mon, Apr 01, 2024 at 04:31:18PM +0200, Thorsten Blum wrote:
> Fixes the following two Coccinelle/coccicheck warnings reported by
> string_choices.cocci:
> 
> 	opportunity for str_plural(num_cpus)
> 	opportunity for str_plural(num_nodes)
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> Changes in v2:
> - Include missing header file
> ---
>  kernel/smp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index f085ebcdf9e7..28fee28174e0 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -25,6 +25,7 @@
>  #include <linux/nmi.h>
>  #include <linux/sched/debug.h>
>  #include <linux/jump_label.h>
> +#include <linux/string_choices.h>
>  
>  #include <trace/events/ipi.h>
>  #define CREATE_TRACE_POINTS
> @@ -982,8 +983,8 @@ void __init smp_init(void)
>  	num_nodes = num_online_nodes();
>  	num_cpus  = num_online_cpus();
>  	pr_info("Brought up %d node%s, %d CPU%s\n",
> -		num_nodes, (num_nodes > 1 ? "s" : ""),
> -		num_cpus,  (num_cpus  > 1 ? "s" : ""));
> +		num_nodes, str_plural(num_nodes),
> +		num_cpus,  str_plural(num_cpus));
>  
>  	/* Any cleanup work */
>  	smp_cpus_done(setup_max_cpus);
> -- 
> 2.44.0
> 

