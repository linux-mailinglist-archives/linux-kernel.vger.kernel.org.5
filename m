Return-Path: <linux-kernel+bounces-17775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF7B825277
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DA21B22C8B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4547C28E17;
	Fri,  5 Jan 2024 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WmmgmU6W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074FA28DD7;
	Fri,  5 Jan 2024 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704452242; x=1735988242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bWLA9uHAE4XhP297Hf+kKUGZ6XNNGd0zX30Q+EHU8bg=;
  b=WmmgmU6W6dLVdZWLfGY03Xz+MtZHYa/Fa8vMj1REMG9vz5o2OyOiQGCw
   Hqjub23kInip7e/f6e1ZFhlgq5bCcFzoxecmlaxbhbIp5w2JLGmuXhx97
   b65gpZ4SGjPQvoxhK+3/81CfbDClzghC/1d6XCMlWBLouh1m6ujII3EYZ
   HGmpuLYhYNPpRjsD8QnPgadVSw51twL8XbshCP3WeVvJeCFWVxmOX2Asx
   SdDyER6fOhUUChvdvTt6Ke+9HQwhbg1j148DuAUOD6d2okpUUsWtWyPcf
   VykMjN38H5aiFDG0mnmDn9ViTjC26jQXbcqHFZOqcinO2LyUu11FmFgc8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="401271564"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="401271564"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 02:57:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="730443114"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="730443114"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga003.jf.intel.com with SMTP; 05 Jan 2024 02:57:17 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 05 Jan 2024 12:57:16 +0200
Date: Fri, 5 Jan 2024 12:57:16 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jai Luthra <j-luthra@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	rogerq@kernel.org, r-gunasekaran@ti.com, vigneshr@ti.com,
	d-gole@ti.com
Subject: Re: [PATCH] usb: typec: tipd: Separate reset for TPS6598x
Message-ID: <ZZfSwGokdjD1YdPX@kuha.fi.intel.com>
References: <20240105-next-tps-fix-v1-1-158cabaec168@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105-next-tps-fix-v1-1-158cabaec168@ti.com>

On Fri, Jan 05, 2024 at 02:36:54PM +0530, Jai Luthra wrote:
> Some platforms like SK-AM62, SK-AM62A cannot boot up to prompt if
> TPS6598x is cold-reset during unconditionally on probe failures by
> sending "GAID" sequence.
> 
> The probe can fail initially because USB0 remote-endpoint may not be
> probed yet, which defines the usb-role-switch property.
> 
> Fixes: d49f90822015 ("usb: typec: tipd: add init and reset functions to tipd_data")
> Closes: https://lore.kernel.org/linux-usb/vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws/
> Signed-off-by: Jai Luthra <j-luthra@ti.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Boot-logs with this patch applied:
> https://gist.github.com/jailuthra/b66d5722090ce1fbc2886986e53640f7
> ---
>  drivers/usb/typec/tipd/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index a956eb976906..8ba2aa05db51 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1223,11 +1223,16 @@ static int cd321x_reset(struct tps6598x *tps)
>  	return 0;
>  }
>  
> -static int tps6598x_reset(struct tps6598x *tps)
> +static int tps25750_reset(struct tps6598x *tps)
>  {
>  	return tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
>  }
>  
> +static int tps6598x_reset(struct tps6598x *tps)
> +{
> +	return 0;
> +}
> +
>  static int
>  tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>  {
> @@ -1545,7 +1550,7 @@ static const struct tipd_data tps25750_data = {
>  	.trace_status = trace_tps25750_status,
>  	.apply_patch = tps25750_apply_patch,
>  	.init = tps25750_init,
> -	.reset = tps6598x_reset,
> +	.reset = tps25750_reset,
>  };
>  
>  static const struct of_device_id tps6598x_of_match[] = {
> 
> ---
> base-commit: e2425464bc87159274879ab30f9d4fe624b9fcd2
> change-id: 20240105-next-tps-fix-904ed92bc1cc
> 
> Best regards,
> -- 
> Jai Luthra <j-luthra@ti.com>

-- 
heikki

