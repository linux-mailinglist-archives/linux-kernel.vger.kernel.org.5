Return-Path: <linux-kernel+bounces-5112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904658186AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66761C23EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBD715EBA;
	Tue, 19 Dec 2023 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfLaMZjk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D487A18629;
	Tue, 19 Dec 2023 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702986721; x=1734522721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M2pLPbJFA0BRzGzcj7zUHtvY6vO14MPKUj+G4zRU83Y=;
  b=kfLaMZjkcidGLiAmrhyJzD43UyfY7obUWJ0+Grx2LxFsyjRJAahoZnUq
   Yf94SNKDtzEwRdNMIq42S8DPxZZYMeNKiAP4PLbo+lZQuwQTx2aNm/VxC
   EA1NPqjGuyAW4aL6ed6J8EC2dHLQM215hHbXDH5V44aHP57gh3CAFX2wS
   H6aUl5b2OIpiuqEfxnNHRD4/EIbr1ArzTZ02GFvoupzJxSE1l0ssx3rlO
   aQnCr4DZBgph7497SIsbYAE6S5qHX84JrLOaXZBnS7zPawOPTYg1GZOZN
   3eP8X55Vig3Jy9Lvoz9qYSlZNp7yDrHop197cEUTKDRhVp35ynE4JhiTS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459988851"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="459988851"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 03:52:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="894264381"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="894264381"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga002.fm.intel.com with SMTP; 19 Dec 2023 03:51:58 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Dec 2023 13:51:58 +0200
Date: Tue, 19 Dec 2023 13:51:58 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] usb: typec: tipd: declare in_data in as const in
 exec_cmd functions
Message-ID: <ZYGD3h1/il9hmdL0@kuha.fi.intel.com>
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <20231207-tps6598x_update-v2-3-f3cfcde6d890@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-tps6598x_update-v2-3-f3cfcde6d890@wolfvision.net>

On Thu, Dec 14, 2023 at 05:29:11PM +0100, Javier Carrasco wrote:
> The input data passed to execute commands with tps6598x_exec_cmd()
> is not supposed to be modified by the function. Moreover, this data is
> passed to tps6598x_exec_cmd_tmo() and finally to tps6598x_block_write(),
> which expects a const pointer.
> 
> The current implementation does not produce any bugs, but it discards
> const qualifiers from the pointers passed as arguments. This leads to
> compile issues if 'discarded-qualifiers' is active and a const pointer
> is passed to the function, which is the case if data from a firmware
> structure is passed to execute update commands. Adding the const
> modifier to in_data prevents such issues and provides code consistency.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 83e5eeecdf5c..7f4bbc0629b0 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -330,7 +330,7 @@ static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
>  }
>  
>  static int tps6598x_exec_cmd_tmo(struct tps6598x *tps, const char *cmd,
> -			     size_t in_len, u8 *in_data,
> +			     size_t in_len, const u8 *in_data,
>  			     size_t out_len, u8 *out_data,
>  			     u32 cmd_timeout_ms, u32 res_delay_ms)
>  {
> @@ -396,7 +396,7 @@ static int tps6598x_exec_cmd_tmo(struct tps6598x *tps, const char *cmd,
>  }
>  
>  static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
> -			     size_t in_len, u8 *in_data,
> +			     size_t in_len, const u8 *in_data,
>  			     size_t out_len, u8 *out_data)
>  {
>  	return tps6598x_exec_cmd_tmo(tps, cmd, in_len, in_data,
> 
> -- 
> 2.39.2

-- 
heikki

