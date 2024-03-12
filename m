Return-Path: <linux-kernel+bounces-100116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4540C8791FB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2092835A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AF078B5E;
	Tue, 12 Mar 2024 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QaImXwUQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3848C7867A;
	Tue, 12 Mar 2024 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239107; cv=none; b=JriJRcfs5M4Ug0pjC+aet6z+Z/IbWKDB8suNfYFjdBJlN5KG6ym8FSCJt1kIf3IMPUM/VNO99zIis+QC17ps4ABfGiMzPN8iXx9wWlW4RwjkUSK2UUTTsK+8A1BVjD5qqztcQYM/N2oLM+6hxXeHeeVaP6ZVMMvhpCK+qV8svgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239107; c=relaxed/simple;
	bh=hotPCNb1kaQBw2oByCCBdxHBnXbzkoL5OpIfzNYHNgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5fNfvWQ96SKgaDt6gKcv4SQ6aEhlrWUhZbXGfV4VUuAszOXXqnNNLQyUG/cRzRf/dTgeI/JH178i2KMSSe4uL99DoRKs2NgBwVkDokJQxoUtwTgnr8pJcAfnXZHedElJ9kmSsjf3FJFLAN3c6lYbcqsb5HOOyAzZpSlFUvqqEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QaImXwUQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710239105; x=1741775105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hotPCNb1kaQBw2oByCCBdxHBnXbzkoL5OpIfzNYHNgg=;
  b=QaImXwUQzjhgxDLXzBR+OJpikrqARRWviTLI74F9Tl+DFz1e6j22XRjd
   WkJoN5+u1+z6CRK4YrbLyRwlD7gcPwvGEvJ+MmbKLuDGBGZOGbUAYu710
   LjfS4SxpyiAB880hG7+GnAlCIpZv80fTBy/asltHLBVoMAKDkWPxvYnQN
   i1E6HHccfKlVYasITTjPj4wkAeXFF8H5fpL+lY0mPwtaGfotwGsNBJ2yk
   39a2viBOpU9+4LiaA25q9QTwYget+vYW+nY24c2XOa6Y/OmBuVE2oBXQd
   XeMHYy1kH4yZaSu0PhJdasN5C/+60ZtASNNL3wZXGEdpXrd940SeioxZ/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4795312"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4795312"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 03:25:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="937051639"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="937051639"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Mar 2024 03:25:01 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Mar 2024 12:25:00 +0200
Date: Tue, 12 Mar 2024 12:25:00 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Kyle Tso <kyletso@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Correct port source pdo array in
 pd_set callback
Message-ID: <ZfAtfPciw8O6A+uS@kuha.fi.intel.com>
References: <20240311144500.3694849-1-kyletso@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311144500.3694849-1-kyletso@google.com>

On Mon, Mar 11, 2024 at 10:45:00PM +0800, Kyle Tso wrote:
> In tcpm_pd_set, the array of port source capabilities is port->src_pdo,
> not port->snk_pdo.
> 
> Fixes: cd099cde4ed2 ("usb: typec: tcpm: Support multiple capabilities")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Tso <kyletso@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3d505614bff1..9485f6373de4 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -6858,7 +6858,7 @@ static int tcpm_pd_set(struct typec_port *p, struct usb_power_delivery *pd)
>  
>  	if (data->source_desc.pdo[0]) {
>  		for (i = 0; i < PDO_MAX_OBJECTS && data->source_desc.pdo[i]; i++)
> -			port->snk_pdo[i] = data->source_desc.pdo[i];
> +			port->src_pdo[i] = data->source_desc.pdo[i];
>  		port->nr_src_pdo = i + 1;
>  	}
>  
> -- 
> 2.44.0.278.ge034bb2e1d-goog

-- 
heikki

