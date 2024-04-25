Return-Path: <linux-kernel+bounces-158329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A208B1E71
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3B01F24115
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D7E86259;
	Thu, 25 Apr 2024 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kwOoN7TX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5777FBA3;
	Thu, 25 Apr 2024 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038609; cv=none; b=nmUQk9hYo5fsMQgIYZyzGl0THhCPriitYLRC8SG49ULDPG8I9dxiffLZYixi45BmJSbZQJ7oAR9N/A+nuHGn7tmfOfvEsqHdSktcm5dakNzk2DDNzt/KxPzoWD/JlsTUBflzebAwHS+QcgRAzrj4MSUrHfx9SwRHPVgLQPbDj5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038609; c=relaxed/simple;
	bh=lzhmnZABYJ6effJEoylHkGZWlmwXEDBc5x3OW9hKrtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HInOtoGVPdtQVyRdFlLBdM26ngnZY0QywNzyWG8w1ZIFXw8MmAtDAprjSmpZTABEVUj1V3avUyzKIBQj891VqDAY8+hQ7m9pKQHRRQ8QH3iXSgwMA4QVV1FBxKSdA8M7meMkl07xkoaEcVA7YHXi5TdsWneRbWCkJf2p9qoc3bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kwOoN7TX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714038608; x=1745574608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lzhmnZABYJ6effJEoylHkGZWlmwXEDBc5x3OW9hKrtM=;
  b=kwOoN7TX70vEj8wcQNDiwD/NvNkJM8OxZzuW5XMefbQ0UhxYjkmXS/LE
   bkMnfDT9OHhhfCjQ94HWRNGUc7WeR49Kd9c9eUxKL/ifzAE8WO8zpbeyH
   y7WupuBL+mCcyHBixGz4Sq38ClHM+d4Lk1vaKq+4P9ISKX+t1Z3w00cyz
   t6u9syvnD4Twjxu28C4iINaneIR8WpAwwZC0nfmYQOhLtJLw9gqVQfvUA
   6M6oUVDK0lmT2HUyigQXb9G640fJy1waLZD+naM1ZY5bWkOncU0uackba
   RIxw6TLYOJcSPKsS3eYm9Liom8COzaXwPK8+V6fOeXLILK8swtjV+g8v6
   Q==;
X-CSE-ConnectionGUID: UIfLH+Q1T/m3yyVjWVXHDw==
X-CSE-MsgGUID: piyhR/6OR7+xpcxw3ddMjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="13546842"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="13546842"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 02:50:07 -0700
X-CSE-ConnectionGUID: CJ8ivaOTSyWltEHO1/JLCA==
X-CSE-MsgGUID: ppOww40jTT+X4yUH+htYoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="29644066"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa003.jf.intel.com with SMTP; 25 Apr 2024 02:50:04 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 25 Apr 2024 12:50:03 +0300
Date: Thu, 25 Apr 2024 12:50:03 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: gregkh@linuxfoundation.org, badhri@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: queue correct sop type in
 tcpm_queue_vdm_unlocked
Message-ID: <ZionS22QrQrWS6S2@kuha.fi.intel.com>
References: <20240423202546.3374218-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423202546.3374218-2-rdbabiera@google.com>

On Tue, Apr 23, 2024 at 08:25:46PM +0000, RD Babiera wrote:
> tcpm_queue_vdm_unlocked queues VDMs over SOP regardless of input
> parameter tx_sop_type. Fix tcpm_queue_vdm() call.
> 
> Fixes: 7e7877c55eb1 ("usb: typec: tcpm: add alt mode enter/exit/vdm support for sop'")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Patch applies starting at 6.9 tree.
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index c26fb70c3ec6..3f38e7c7d13f 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1565,7 +1565,7 @@ static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
>  				    const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
>  {
>  	mutex_lock(&port->lock);
> -	tcpm_queue_vdm(port, header, data, cnt, TCPC_TX_SOP);
> +	tcpm_queue_vdm(port, header, data, cnt, tx_sop_type);
>  	mutex_unlock(&port->lock);
>  }
>  
> 
> base-commit: 684e9f5f97eb4b7831298ffad140d5c1d426ff27
> -- 
> 2.44.0.769.g3c40516874-goog

-- 
heikki

