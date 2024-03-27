Return-Path: <linux-kernel+bounces-120730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6601B88DC1C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983551C26BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BCA54BFF;
	Wed, 27 Mar 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdCXmf4G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C9B4EB4F;
	Wed, 27 Mar 2024 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537808; cv=none; b=DMH7bpG33pQw6ofjo/tRYyEn4v8EtEVP/CmPWLFfCdi+8dv9Ol1+zF3SmGNZgydfogHk0VGWDJMMqw0tOar4SjkswNJd/pmjyfArPkCgPBIDMHr0ak69MqzznhjwaPGuTqehwXC/5gGBom+KQPdxfnpsSwp8ZKZre6V7+PHoulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537808; c=relaxed/simple;
	bh=YQXxdHYf5ZUqRCsSk4Vy+9QKTvmMBfJYYDknysNlH7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiudNP0YXPfrhCQWwDus5eVUUDMKwEKWp/3VaWNvDeelzAVofYXZqmAcqqJ0zIy4VvFbmwdLFUdVdoVI5PbSdP0INF+oixQDEBLQsZQ1EPhMnMRe5ozVLXKSY8T3JEMsp78kWV0Xx4Aw7lYniEnOesO0TOUhCWPrXVt//aRg/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdCXmf4G; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711537807; x=1743073807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YQXxdHYf5ZUqRCsSk4Vy+9QKTvmMBfJYYDknysNlH7s=;
  b=ZdCXmf4GNAmD71F1ytlWlR6s4VkM626ZZyv5P8emTSkgf3A8Fx+sud/g
   tpEJvgHXG3GPsJgbCq5cBo4qd5QtbLMObyhii0QmYyKYhXy9/SjM5Dj05
   AV3W21rkLUdeHoaXrkksqkL9Mx595Qpv7jWQktEBWvcGQqBna7q6b8jm2
   8PhrgY7LZ3gQb3GMYdFZ5phn89FhCvvyqEsm42/r4sUD+S0IdbW8SBQfB
   ACFthNyVYNlxszLfgXXoDim2qPQuqvs3VKK39rKM8lLyMPRMNW2DJkQL+
   D0krrwz/aVNeUSWmNRXKEvgMHQ1N6Pg8hAKfAg3oqNzEO4KKbPt5ACIIv
   A==;
X-CSE-ConnectionGUID: mX/BMoAMSUG7edqLzVPoBA==
X-CSE-MsgGUID: cVSMfy1aRGmxTdCIwRzPzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17360782"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="17360782"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 04:10:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937074456"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="937074456"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 27 Mar 2024 04:10:02 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 27 Mar 2024 13:10:02 +0200
Date: Wed, 27 Mar 2024 13:10:02 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Kyle Tso <kyletso@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tcpm: Correct the PDO counting in pd_set
Message-ID: <ZgP+ih7CuXa2S2zb@kuha.fi.intel.com>
References: <20240326151909.440275-1-kyletso@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326151909.440275-1-kyletso@google.com>

On Tue, Mar 26, 2024 at 11:19:09PM +0800, Kyle Tso wrote:
> Off-by-one errors happen because nr_snk_pdo and nr_src_pdo are
> incorrectly added one. The index of the loop is equal to the number of
> PDOs to be updated when leaving the loop and it doesn't need to be added
> one.
> 
> When doing the power negotiation, TCPM relies on the "nr_snk_pdo" as
> the size of the local sink PDO array to match the Source capabilities
> of the partner port. If the off-by-one overflow occurs, a wrong RDO
> might be sent and unexpected power transfer might happen such as over
> voltage or over current (than expected).
> 
> "nr_src_pdo" is used to set the Rp level when the port is in Source
> role. It is also the array size of the local Source capabilities when
> filling up the buffer which will be sent as the Source PDOs (such as
> in Power Negotiation). If the off-by-one overflow occurs, a wrong Rp
> level might be set and wrong Source PDOs will be sent to the partner
> port. This could potentially cause over current or port resets.
> 
> Fixes: cd099cde4ed2 ("usb: typec: tcpm: Support multiple capabilities")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v1 -> v2:
> - update the commit message (adding the problems this patch solves)
> 
>  drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index ae2b6c94482d..2464710ea0c8 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -6855,14 +6855,14 @@ static int tcpm_pd_set(struct typec_port *p, struct usb_power_delivery *pd)
>  	if (data->sink_desc.pdo[0]) {
>  		for (i = 0; i < PDO_MAX_OBJECTS && data->sink_desc.pdo[i]; i++)
>  			port->snk_pdo[i] = data->sink_desc.pdo[i];
> -		port->nr_snk_pdo = i + 1;
> +		port->nr_snk_pdo = i;
>  		port->operating_snk_mw = data->operating_snk_mw;
>  	}
>  
>  	if (data->source_desc.pdo[0]) {
>  		for (i = 0; i < PDO_MAX_OBJECTS && data->source_desc.pdo[i]; i++)
>  			port->snk_pdo[i] = data->source_desc.pdo[i];
> -		port->nr_src_pdo = i + 1;
> +		port->nr_src_pdo = i;
>  	}
>  
>  	switch (port->state) {
> -- 
> 2.44.0.396.g6e790dbe36-goog

-- 
heikki

