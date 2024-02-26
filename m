Return-Path: <linux-kernel+bounces-80742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B59DF866BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B02D1F23E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077DA1CA84;
	Mon, 26 Feb 2024 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P77BET42"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99871C686;
	Mon, 26 Feb 2024 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935452; cv=none; b=JYoWz9Ym2pD1Bf06x8W7qc0dygi5Be5RDPsK6JaHkiLvyVWfBcwDNO1cI+t8i9vscYZcrqi4uImSFGy2dGldwSAiKzyXjTf+KgZjeIKzAOqe+CYSbNlNlfWHvXDiwZu1G0WH5ppyZW8BUwe1TRQ1ZK6Vytu550qRZXqQ2tJBF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935452; c=relaxed/simple;
	bh=xFNrO3cRpxVX2q2vaPJgUCpJMYXc8VBae+MPtxz8abk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXZUVN3r7IEZxNa822ueRMV7d+PFduWe2A2XXG6hgXaifeOPX4Z/zNyrMxEz3KiTXBTiGBQd4JmJFN0QHS6F57E3eP9AlP1AqgGuS+Rqp9BemiYMxEuw78MA1IWnXTtGjkr0TgvGwIxym+EVDDuJzBiKdC+M/vRiGtLQeXWmsFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P77BET42; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708935450; x=1740471450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xFNrO3cRpxVX2q2vaPJgUCpJMYXc8VBae+MPtxz8abk=;
  b=P77BET42LrLtzyx42xrtCwF2QiOgED5vhSOSdZdLat2kMKRdyDOSrCMT
   POFBUq48L8wVcu/jaTOY4VxYc5dufjAeIDfo7exOZdXV0iCuUKf9few1u
   FH8M51Yj/MLkRlGLc68M6ycn3gRqJiThmgcbga85RpfHN2wRPcZ6Ouo0i
   REgMWheerKxIx3+oKnb3XX6CHxWyoSV5kXE38xfKSn+TXpeA2Lz8fWXGX
   ZQ9GB/WM/7F7LRPmSit5jCrOMrVGiach9mkOXXSY1KkUQem2QYBEkg5o0
   4k9W1EpypIhujZOs2ykbeOk0jrSWjqrRWh8D7Ox7m4SEzdtjihJjv2vRI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="6992206"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6992206"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 00:17:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029526"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029526"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Feb 2024 00:17:27 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Feb 2024 10:17:26 +0200
Date: Mon, 26 Feb 2024 10:17:26 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: gregkh@linuxfoundation.org, badhri@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: altmodes/displayport: send configure
 message on sop'
Message-ID: <ZdxJFuHnOnyNiWmn@kuha.fi.intel.com>
References: <20240223002302.3937235-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223002302.3937235-2-rdbabiera@google.com>

On Fri, Feb 23, 2024 at 12:23:03AM +0000, RD Babiera wrote:
> When the port is setting the pin configuration when no configuration is
> chosen, the DisplayPort driver will not send Configure to the cable plug
> if it's available. Add transition to DP_STATE_CONFIGURE_PRIME.
> 
> Fixes: 71ba4fe56656 ("usb: typec: altmodes/displayport: add SOP' support")
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/altmodes/displayport.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 5a80776c7255..867f9796f8a8 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -164,7 +164,8 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
>  	} else if (!(con & DP_CONF_CURRENTLY(dp->data.conf))) {
>  		ret = dp_altmode_configure(dp, con);
>  		if (!ret) {
> -			dp->state = DP_STATE_CONFIGURE;
> +			dp->state = dp->plug_prime ? DP_STATE_CONFIGURE_PRIME :
> +						     DP_STATE_CONFIGURE;
>  			if (dp->hpd != hpd) {
>  				dp->hpd = hpd;
>  				dp->pending_hpd = true;
> 
> base-commit: 3bf0514dc6f36f81ee11b1becd977cb87b4c90c6
> -- 
> 2.44.0.rc0.258.g7320e95886-goog

-- 
heikki

