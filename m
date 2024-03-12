Return-Path: <linux-kernel+bounces-100175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799298792FF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9CEFB214E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1CC79B8E;
	Tue, 12 Mar 2024 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnACpH3g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE09079B61;
	Tue, 12 Mar 2024 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710242915; cv=none; b=KjdYOdSW9lm52cr+PMaiRwXan2fxm366QKxkQPfNlky+mXR1yUhvo8ejtU19+XODyWLmSfO/D1x+y1B6kgyxxBBiO93GZq2VEsNTOfVEZDDPO+Uzm9PpDt03uWh0D2/uSYgVJuPGzkt57Fm/05V5NIRFG1pVn0/KxQAhDSaFTXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710242915; c=relaxed/simple;
	bh=cXypA3APX2BFWvWLBS1HpCb0BSeDV93Je21rLtntvNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwY+J8Q3VRN8ZifkNsp+pRDggky/a26hbwh3BGmLyBwGtUBo/xiF0Fz/DV2ickY1aYMJjTqo3CF8Wuc1WvL/+oK0NI0YtM/DFK7OJi/tgKmn/X/2XeZrmooR36IwYn/eyE2APh2tEVEVlLRtnhY08Q0YH8RF1vjQClfz2ZUXP0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnACpH3g; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710242914; x=1741778914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cXypA3APX2BFWvWLBS1HpCb0BSeDV93Je21rLtntvNg=;
  b=LnACpH3gViqjz/XkegVrXE5HVH7kuGWUUz3uN7CQcahTjZD1A8l9zxnJ
   WGSTnorz1Vcaf9/JTX29vvzjdLC+2Y1K4daYZOlU84SwUcW08bzyVeNbp
   cUWIxT0Le2iKdIoG91nKtkEqTZM38Rn5sKuQNFYv1NkR4BRtlQ5wpDqr+
   dcVZFBPRIcAlshLTXAKBHJtXy6OCVff2XlmRDI13h6ZjSzE5kIzNSvqCf
   cTc4s+0ZpeY+Hifj7E4Jw5Koc8oQ8w/dFFBf11adaQ9dzKaOBok2FplHZ
   0rjgqvJVYUbBfYe0CiLaXGXw4+4k4peXRKJn2tuPCFDBGh3Fq36vO/mvZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="30383709"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="30383709"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 04:28:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="937051688"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="937051688"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Mar 2024 04:28:29 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Mar 2024 13:28:28 +0200
Date: Tue, 12 Mar 2024 13:28:28 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@roeck-us.net, jun.li@nxp.com, devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 4/4] usb: typec: tcpci: add support to set connector
 orientation
Message-ID: <ZfA8XHyxzPePwzV6@kuha.fi.intel.com>
References: <20240222210903.208901-1-m.felsch@pengutronix.de>
 <20240222210903.208901-5-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222210903.208901-5-m.felsch@pengutronix.de>

On Thu, Feb 22, 2024 at 10:09:03PM +0100, Marco Felsch wrote:
> This add the support to set the optional connector orientation bit which
> is part of the optional CONFIG_STANDARD_OUTPUT register 0x18 [1]. This
> allows system designers to connect the tcpc orientation pin directly to
> the 2:1 ss-mux.
> 
> [1] https://www.usb.org/sites/default/files/documents/usb-port_controller_specification_rev2.0_v1.0_0.pdf
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


-- 
heikki

