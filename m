Return-Path: <linux-kernel+bounces-80718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E726866BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCDA1C214AD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F6C1C6B4;
	Mon, 26 Feb 2024 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwQaRewp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1F1BF3F;
	Mon, 26 Feb 2024 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934569; cv=none; b=P2J0S9xGy26nZbb6ODCtoaZ/gTBuDL2yYS+bxx19KFfm4/MFT9TsC2XywGU73K/kZedKpwPgzA4E5PbzKgMn0GHytEpsyynOp1TGH1X3KyFQIEvy+dHhwCGlPskBqayOLcoX9ImtwqBGaaB9G0GpP8rPcngOo8cJLkiU20ER86k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934569; c=relaxed/simple;
	bh=3RsXCPynCAXkUlzpY690FgszqUcC+b/4S8OK/4W5w00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQaS1WHGkTsQ2KbGPjueeA08CcpI05kA31E50sEgg/SA7jwJmnEey1ramGCij8Ky+PiQgFMsqubzbNGqQBSdGdwxu0THuVVVsf5HgRaay1RiX7PfsOY1CX5+XflkbbCNJPZZLYMbVoGm44lJQtu+sM4q5RB2ITuhNa/WG19K2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwQaRewp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708934568; x=1740470568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3RsXCPynCAXkUlzpY690FgszqUcC+b/4S8OK/4W5w00=;
  b=jwQaRewpwV0ZzihadZ76RmW5jXPuHeln7DX9ulvoMvNPnZ06CC5BsgoF
   cC4izUqQxWZDqF7wlq5ga5fFC+NuFKl3kckNiJOoi/7Y/SrHipPrkLU+7
   oFwDZTu03tb8E2FMGyACFd49xrRe8bn7OkNai0czf54bd16QsPJat1ogh
   R8XuoS29r1FF0OE6VcLs7biZAUHXPtCS8dV1kTL5Ll8Xs1FO4CEoYTocX
   A2oTzq5mgg85cayawhJdOzEELceMgtxxaBSaukiPvq1oL/XshLYT4Uzvn
   NaK3Tjn0Fi76dcG/4eUW+vnr6IzfZ4HzoPlldhwolpWBkIf1RRBAvtbn9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14335789"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14335789"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 00:02:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029450"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029450"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Feb 2024 00:02:43 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Feb 2024 10:02:42 +0200
Date: Mon, 26 Feb 2024 10:02:42 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@roeck-us.net, jun.li@nxp.com, devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 2/4] usb: typec: tcpci: add generic tcpci fallback
 compatible
Message-ID: <ZdxFotyEjGN4APou@kuha.fi.intel.com>
References: <20240222210903.208901-1-m.felsch@pengutronix.de>
 <20240222210903.208901-3-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222210903.208901-3-m.felsch@pengutronix.de>

On Thu, Feb 22, 2024 at 10:09:01PM +0100, Marco Felsch wrote:
> The driver already support the tcpci binding for the i2c_device_id so
> add the support for the of_device_id too.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v3:
> - no changes
> v2:
> - no changes
> 
>  drivers/usb/typec/tcpm/tcpci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 0ee3e6e29bb1..7118551827f6 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -889,6 +889,7 @@ MODULE_DEVICE_TABLE(i2c, tcpci_id);
>  #ifdef CONFIG_OF
>  static const struct of_device_id tcpci_of_match[] = {
>  	{ .compatible = "nxp,ptn5110", },
> +	{ .compatible = "tcpci", },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, tcpci_of_match);
> -- 
> 2.39.2

-- 
heikki

