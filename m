Return-Path: <linux-kernel+bounces-99994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05555879072
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 668ACB21A27
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEC378261;
	Tue, 12 Mar 2024 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dbf/Ic9U"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9926997B;
	Tue, 12 Mar 2024 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234970; cv=none; b=RN3N+6y5RtzvPDFOqXPy7oR60btmhL52xxdDDOQh5aRPFsh9xyCRsarYf0CzHVem7Tufu3SjLvyskdTd7Nc65h4deqPy/3hYcIJTGtRpWNFXZWZ3IshPrCreLxaXCzeECcrInNaiWKMCVZ44f9QAROkUjePfw82DkuzHbGopUHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234970; c=relaxed/simple;
	bh=U8Bew2R19R1dmK0w/Sze3/oX4ouZZi6iE/VeohOzCF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfZXHjhxCXWIfSvahNC+fjo6ZiZm5qglVLDD4CdxeoGVX7z5M1oWogJhL/yu+IL6dYSW7ZIB/JYf/DgixsYEpphUSwSILMoGTNP6PUB8C8GvBMl/VNgQuiHbvXQnPhj2lujPSuCE3fxyY+LifJ1VqVZ5AuN3q+Ln699EF4mMVmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dbf/Ic9U; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710234969; x=1741770969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U8Bew2R19R1dmK0w/Sze3/oX4ouZZi6iE/VeohOzCF8=;
  b=Dbf/Ic9UR6y0LLmgEmxIW30CvRXOXElhoeJif8ble21pKJNSN1vQzZ3P
   kp5pqUxl3piSlN1PgSe40dlZDnzEzBxzWYnRtBSTClWZ6ju0B/pCg+tbn
   TcdbEIV+r2qtHnUB4Piv+gO8x8Kj03MIdxddH4rYE9mcrkhTJsyPTFvSi
   XtyU+6WIqfGVb1Ev/4EufMzDMsKR+di+mEweIKoR9rE2VWN5DjgP7kwf0
   9AsyYnabz0/Tl9N+JvCsDWpULk+9m4H9EzbW7bY5Rz8AL94xL0ej9D3By
   V1DLXa1KJQYTQQmz30VSK8gGkBDXjslSXsDrhTwI+FRuVV+iZWOd41Lw+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4784069"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4784069"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 02:16:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="937051535"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="937051535"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Mar 2024 02:16:03 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Mar 2024 11:16:02 +0200
Date: Tue, 12 Mar 2024 11:16:02 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Min-Hua Chen <minhuadotchen@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com,
	quic_wcheng@quicinc.com, quic_subbaram@quicinc.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix race between typec_switch and
 role_switch
Message-ID: <ZfAdUhbsVpMVFmYJ@kuha.fi.intel.com>
References: <20240301040914.458492-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301040914.458492-1-quic_kriskura@quicinc.com>

On Fri, Mar 01, 2024 at 09:39:14AM +0530, Krishna Kurapati wrote:
> When orientation switch is enabled in ucsi glink, there is a xhci
> probe failure seen when booting up in host mode in reverse
> orientation.
> 
> During bootup the following things happen in multiple drivers:
> 
> a) DWC3 controller driver initializes the core in device mode when the
> dr_mode is set to DRD. It relies on role_switch call to change role to
> host.
> 
> b) QMP driver initializes the lanes to TYPEC_ORIENTATION_NORMAL as a
> normal routine. It relies on the typec_switch_set call to get notified
> of orientation changes.
> 
> c) UCSI core reads the UCSI_GET_CONNECTOR_STATUS via the glink and
> provides initial role switch to dwc3 controller.
> 
> When booting up in host mode with orientation TYPEC_ORIENTATION_REVERSE,
> then we see the following things happening in order:
> 
> a) UCSI gives initial role as host to dwc3 controller ucsi_register_port.
> Upon receiving this notification, the dwc3 core needs to program GCTL from
> PRTCAP_DEVICE to PRTCAP_HOST and as part of this change, it asserts GCTL
> Core soft reset and waits for it to be  completed before shifting it to
> host. Only after the reset is done will the dwc3_host_init be invoked and
> xhci is probed. DWC3 controller expects that the usb phy's are stable
> during this process i.e., the phy init is already done.
> 
> b) During the 100ms wait for GCTL core soft reset, the actual notification
> from PPM is received by ucsi_glink via pmic glink for changing role to
> host. The pmic_glink_ucsi_notify routine first sends the orientation
> change to QMP and then sends role to dwc3 via ucsi framework. This is
> happening exactly at the time GCTL core soft reset is being processed.
> 
> c) When QMP driver receives typec switch to TYPEC_ORIENTATION_REVERSE, it
> then re-programs the phy at the instant GCTL core soft reset has been
> asserted by dwc3 controller due to which the QMP PLL lock fails in
> qmp_combo_usb_power_on.
> 
> d) After the 100ms of GCTL core soft reset is completed, the dwc3 core
> goes for initializing the host mode and invokes xhci probe. But at this
> point the QMP is non-responsive and as a result, the xhci plat probe fails
> during xhci_reset.
> 
> Fix this by passing orientation switch to available ucsi instances if
> their gpio configuration is available before ucsi_register is invoked so
> that by the time, the pmic_glink_ucsi_notify provides typec_switch to QMP,
> the lane is already configured and the call would be a NOP thus not racing
> with role switch.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: c6165ed2f425 ("usb: ucsi: glink: use the connector orientation GPIO to provide switch events")
> Suggested-by: Wesley Cheng <quic_wcheng@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 0bd3f6dee678..466df7b9f953 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -255,6 +255,20 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
>  static void pmic_glink_ucsi_register(struct work_struct *work)
>  {
>  	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
> +	int orientation;
> +	int i;
> +
> +	for (i = 0; i < PMIC_GLINK_MAX_PORTS; i++) {
> +		if (!ucsi->port_orientation[i])
> +			continue;
> +		orientation = gpiod_get_value(ucsi->port_orientation[i]);
> +
> +		if (orientation >= 0) {
> +			typec_switch_set(ucsi->port_switch[i],
> +					 orientation ? TYPEC_ORIENTATION_REVERSE
> +					     : TYPEC_ORIENTATION_NORMAL);
> +		}
> +	}
>  
>  	ucsi_register(ucsi->ucsi);
>  }
> -- 
> 2.34.1

-- 
heikki

