Return-Path: <linux-kernel+bounces-154590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BD98ADE07
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545B81C218FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1863A8CE;
	Tue, 23 Apr 2024 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Rp5fpjlN"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14422C1AE;
	Tue, 23 Apr 2024 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856279; cv=none; b=Q5kFuELBnA14UxWSokDNqtK2QMSNwYI7Cr1W/vnfexbGHIC4Kg4jlHfmSpOmTniXMj23VnnwypLaFzEJn04MpZOwjQVZz5Y7K5ajaklsR1jEPc6m2kdqv5Q0AfL5OnjXAwQm4b4v8gYick4FeTfve6toye0NX7tzgo1gL4iyzvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856279; c=relaxed/simple;
	bh=nLaGBHamuhtzaalMmDBdLqxZF1juSecJx5/vJnANln8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GSutYpGHZK1Nv2M+tfmUM8eygzkbS7e3LEuPVnBmhz/ul2JhUYTJwkrXL7GJeoHeDf/QTAq6MZet7Yedjj7vH41hSK5jA2O34JQPhXtSZZ1H/MG1bz8PiWpCwHTPhQ22ysgoS4hg/X3sqUzQVxliYIVm+j0d3SsUhp2x0K8TaTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Rp5fpjlN; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kVygBsNtcrP1nWUhXC/dyte0z5MenHlyUiOgHcNUvQg=;
  b=Rp5fpjlNZQhd10e7B1pmmHySpUMks7ZNk3HFDqjKa7D5wPq3TofILbFD
   gGWYIVbxQ/7lqe+1KF0RxaxUUsXLdy5cPFM7NBcC36wraxS06M1xPVR/t
   tZlM70P2I2fLagsUhJlE6OG8cheLxe51OhS+4x6EXEFyverbGDU5JjibJ
   Q=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,222,1708383600"; 
   d="scan'208";a="85487077"
Received: from dmz02.dagstuhl.de (HELO hadrien) ([192.76.146.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:11:08 +0200
Date: Tue, 23 Apr 2024 09:11:07 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Shivani Gupta <shivani07g@gmail.com>
cc: "Rafael J . Wysocki" <rafael@kernel.org>, 
    Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
    linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
    javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] cpufreq: ti: Implement scope-based cleanup in
 ti_cpufreq_match_node()
In-Reply-To: <20240423020727.776360-1-shivani07g@gmail.com>
Message-ID: <aa2bd3b6-7bb9-98ae-b762-6060f828170@inria.fr>
References: <20240423020727.776360-1-shivani07g@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 23 Apr 2024, Shivani Gupta wrote:

> This patch modifies the ti_cpufreq_match_node() function to utilize the
> __free() cleanup handler for automatically releasing the device
> node when it goes out of scope.
>
> By moving the declaration to the initialization, the patch ensures that
> the device node is properly managed throughout the function's scope,
> thus eliminating the need for manual invocation of of_node_put().
> This approach reduces the potential for memory leaks.

The code is fine.  The log message is a bit verbose.  Try to avoid
referring to the patch.  It's obvious that you are talking about the
patch.  Try to favor the imperative, so "Modify..." instead of "This patch
modifies".

julia


>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Shivani Gupta <shivani07g@gmail.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 46c41e2ca727..714ed53753fa 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -347,12 +347,10 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
>
>  static const struct of_device_id *ti_cpufreq_match_node(void)
>  {
> -	struct device_node *np;
> +	struct device_node *np __free(device_node) = of_find_node_by_path("/");
>  	const struct of_device_id *match;
>
> -	np = of_find_node_by_path("/");
>  	match = of_match_node(ti_cpufreq_of_match, np);
> -	of_node_put(np);
>
>  	return match;
>  }
> --
> 2.34.1
>
>

