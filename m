Return-Path: <linux-kernel+bounces-100016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9A08790CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4D81C21DEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A0D77F34;
	Tue, 12 Mar 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3BSQa/l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0890A77F2C;
	Tue, 12 Mar 2024 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235161; cv=none; b=WRiO9jRBCVcntQ94Evjx53A95Rsx2ln+kaUJ9857/bof7Ib9jQMB9nb3uRxdfSN+oNfHGRkjshWVABNHGH9HmAk/FaA4S5aYPwu6CJJmBboYxSfUeJhBPjLdb/4OAyEl5ckPpbbcZ40FkDUPSJcC4Unl0cOY/J8bTZLg+GJQuRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235161; c=relaxed/simple;
	bh=8TtpUkIMGq597Pi0vWyKqN1BsRfaLDNjqAC1V4fg2xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J16AC2HTRTCUlr68yhM2ZjFfoPim04//AoBbkiut3I9eYEdtL8vwTgCuVtLyoGsrKoPuLVgrQQiF6HHK0KHrYOUt5pDSPrJCqMyhyNXUWuQvnHF3uJs3K60VGSBYhxY5xGrzzfkP3eWHiCDVc4yJf79JJCtf9LhBC6Vmsf2mSd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3BSQa/l; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710235160; x=1741771160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8TtpUkIMGq597Pi0vWyKqN1BsRfaLDNjqAC1V4fg2xo=;
  b=F3BSQa/lfbMOle5XCjPo2XIwytH75egiQG+MBidLxak8hANj5P8QDtCb
   CnzMlzYWxmsHuxJfYsGYXSw1f3LHACivky2HIlcH8G8UgLp2Ahwjgix31
   oVk+cv7ZMexVfjsVM4ecDTGx5EZKM4yA/OberB/HXwuAaoPjKHqSG9icP
   OIS17h67D8aXpJprkQwtr2RmOdjWmjyMmBA06rZoJJY+5i4yhKdcoTiOK
   mSatYqbgEWfwU2k+3odusMV4YlfGxFAlWY5VwQGMgRzmaLs5t0XvAVl4g
   MLJmhk39Wb5uOcdvWoOTDHDtOcfv96ZQAoytuF3xSxXpeBMtvYTn1Fyap
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4784322"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4784322"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 02:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="937051558"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="937051558"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Mar 2024 02:19:17 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Mar 2024 11:19:16 +0200
Date: Tue, 12 Mar 2024 11:19:16 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: constify struct class usage
Message-ID: <ZfAeFIQTi4iQP/FU@kuha.fi.intel.com>
References: <20240301-class_cleanup-usb-v1-1-50309e325095@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-class_cleanup-usb-v1-1-50309e325095@marliere.net>

On Fri, Mar 01, 2024 at 06:19:28PM -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the structures typec_mux_class, retimer_class and
> typec_class to be declared at build time placing them into read-only
> memory, instead of having to be dynamically allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/class.c   | 2 +-
>  drivers/usb/typec/class.h   | 6 +++---
>  drivers/usb/typec/mux.c     | 2 +-
>  drivers/usb/typec/retimer.c | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index caea2b829980..389c7f0b8d93 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -21,7 +21,7 @@
>  
>  static DEFINE_IDA(typec_index_ida);
>  
> -struct class typec_class = {
> +const struct class typec_class = {
>  	.name = "typec",
>  };
>  
> diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> index 759b98355eeb..7485cdb9dd20 100644
> --- a/drivers/usb/typec/class.h
> +++ b/drivers/usb/typec/class.h
> @@ -93,9 +93,9 @@ extern const struct device_type typec_port_dev_type;
>  #define is_typec_plug(dev) ((dev)->type == &typec_plug_dev_type)
>  #define is_typec_port(dev) ((dev)->type == &typec_port_dev_type)
>  
> -extern struct class typec_mux_class;
> -extern struct class retimer_class;
> -extern struct class typec_class;
> +extern const struct class typec_mux_class;
> +extern const struct class retimer_class;
> +extern const struct class typec_class;
>  
>  #if defined(CONFIG_ACPI)
>  int typec_link_ports(struct typec_port *connector);
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index 80dd91938d96..49926d6e72c7 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -469,6 +469,6 @@ void *typec_mux_get_drvdata(struct typec_mux_dev *mux_dev)
>  }
>  EXPORT_SYMBOL_GPL(typec_mux_get_drvdata);
>  
> -struct class typec_mux_class = {
> +const struct class typec_mux_class = {
>  	.name = "typec_mux",
>  };
> diff --git a/drivers/usb/typec/retimer.c b/drivers/usb/typec/retimer.c
> index 4a7d1b5c4d86..b519fcf358ca 100644
> --- a/drivers/usb/typec/retimer.c
> +++ b/drivers/usb/typec/retimer.c
> @@ -155,6 +155,6 @@ void *typec_retimer_get_drvdata(struct typec_retimer *retimer)
>  }
>  EXPORT_SYMBOL_GPL(typec_retimer_get_drvdata);
>  
> -struct class retimer_class = {
> +const struct class retimer_class = {
>  	.name = "retimer",
>  };
> 
> ---
> base-commit: a560a5672826fc1e057068bda93b3d4c98d037a2
> change-id: 20240301-class_cleanup-usb-4c3cef5bb0ca
> 
> Best regards,
> -- 
> Ricardo B. Marliere <ricardo@marliere.net>

-- 
heikki

