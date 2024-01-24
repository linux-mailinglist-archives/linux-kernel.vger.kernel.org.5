Return-Path: <linux-kernel+bounces-37050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF58183AAA4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1C81F2B2EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE7877F05;
	Wed, 24 Jan 2024 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RN2ZUfo7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9167977640;
	Wed, 24 Jan 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101717; cv=none; b=ijxhzKGtlm9GgY76aw5QQJ2nCZr/+3WWol4CpZxcTrEVaeeub8meABzxNkmveo8ykID+1BNiQdgGGbw1Xtp0xGuocpAeGPGbLVxCPfOcei67Z9RLpipPQ1ohxO3GU8irzWF5EDRjFdXVw4eThbK9KsVMK3mpMU1wToIO9mNLhIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101717; c=relaxed/simple;
	bh=LRKdvEQWoCEx4ySV7N81w6fG9TXYEayrBjmBpv5mIUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/pFWPKkgr7kTq1wkEexq1d6jkj8BpLgqd1ytYXUZclYyUaHxQdBesqe1HBKT9KY0iWGv32kUvz9zClTPWAFGFiMsyih/RvqtfilEwWTFZB2sNnlwC98QQGB4h95uFNmffKftLGCaUciIuW6nBA3x2hRIWkHrMslicYxSEbjp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RN2ZUfo7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706101715; x=1737637715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LRKdvEQWoCEx4ySV7N81w6fG9TXYEayrBjmBpv5mIUM=;
  b=RN2ZUfo7PHjrnmDobH2GtdPWshoIE815A9QbeAygdNbFFifOur2Z6xs9
   rAo8Nj/3ES4xnHDrst+hU5acZv/D29zLyH8H8yjzoaPs+Qs9992uZMg4f
   qABxPxN+pL5SvJ39pxygq3o9+Xm+drTPL+Tcv78H0f746u9xpsXkZIXo/
   BqpzCYlvyrsMMt1/PnMLOZl7ED5/N7Ic7SjLeer++zTpbHj0BJITOvpf7
   IBfq5iWanP8EmyA1s4qcyjGEzMks79+REgeBWrzLNGxWfwetadyIeU8gR
   JKjrTX89DX3Fe06n4fPyoaFgK0X6zWIdOykU73iyrL+ov9HQ8ri6nIQwv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15361425"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15361425"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 05:08:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="929680051"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="929680051"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Jan 2024 05:08:30 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 24 Jan 2024 15:08:30 +0200
Date: Wed, 24 Jan 2024 15:08:30 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-usb@vger.kernel.org, Dell.Client.Kernel@dell.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jack Pham <quic_jackp@quicinc.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] usb: ucsi: Add missing ppm_lock
Message-ID: <ZbELzi94Z+eyPUKL@kuha.fi.intel.com>
References: <20240121204123.275441-1-lk@c--e.de>
 <20240121204123.275441-2-lk@c--e.de>
 <ZbDFoGL1GnxZAXER@kuha.fi.intel.com>
 <ZbD8toNjyjiLp8an@cae.in-ulm.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbD8toNjyjiLp8an@cae.in-ulm.de>

On Wed, Jan 24, 2024 at 01:04:06PM +0100, Christian A. Ehrhardt wrote:
> 
> Hi Heikki,
> 
> Thanks for looking into this.
> 
> On Wed, Jan 24, 2024 at 10:09:04AM +0200, Heikki Krogerus wrote:
> > On Sun, Jan 21, 2024 at 09:41:21PM +0100, Christian A. Ehrhardt wrote:
> > > Calling ->sync_write must be done while holding the PPM lock as
> > > the mailbox logic does not support concurrent commands.
> > > 
> > > At least since the addition of partner task this means that
> > > ucsi_acknowledge_connector_change should be called with the
> > > PPM lock held as it calls ->sync_write.
> > > 
> > > Thus protect the only call to ucsi_acknowledge_connector_change
> > > with the PPM. All other calls to ->sync_write already happen
> > > under the PPM lock.
> > > 
> > > Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner tasks like alt mode checking")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > > ---
> > >  drivers/usb/typec/ucsi/ucsi.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > > index 61b64558f96c..8f9dff993b3d 100644
> > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > @@ -935,7 +935,9 @@ static void ucsi_handle_connector_change(struct work_struct *work)
> > >  
> > >  	clear_bit(EVENT_PENDING, &con->ucsi->flags);
> > >  
> > > +	mutex_lock(&ucsi->ppm_lock);
> > >  	ret = ucsi_acknowledge_connector_change(ucsi);
> > > +	mutex_unlock(&ucsi->ppm_lock);
> > >  	if (ret)
> > >  		dev_err(ucsi->dev, "%s: ACK failed (%d)", __func__, ret);
> > 
> > Is this really actually fixing some issue? The function has already
> > taken the connector lock, so what exactly could happen without this?
> 
> I've definitely _seen_ issues with the quirk from PATCH 3/3 if the
> lock is missing. I'm pretty sure from looking at the code that races
> with other connectors can happen without the quirk, too.
> 
> The PPM lock protects the Mailbox and the ACK_PENDING/COMMAND_PENDING
> bits and I could observe cases where ucsi_acpi_sync_write() was entered
> with the COMMAND_PENDING bit already set. One possible sequence is this:
> 
> ucsi_connector_change() for connector #1
> 	=> schedules partner tasks
> 	=> Acks the connector change
> 	=> Releases locks
> ucsi_connecotr_change() for connector #2
> 	=> acquire con lock for #2
> 	=> Start to process connector state change
> 	=> Processing reaches the point right before 
> 	   ucsi_acknowledge_connector_change()
> Connector #1 workqueue starts to process one of the partner tasks
> 	=> Acquire con lock for connector #1
> 	=> Acquire ppm lock
> 	=> Enter ucsi_exec_command()
> 	=> ->sync_write() starts to use the mailbox and sets
> 	   COMMAND_PENDING
> 	=> ->sync_write blocks waiting for the command completion
> 	   with wait_for_completion_timeout().
> ucsi_connector_change() for connector #2 continues
> 	=> execute ucsi_acknowledge_connector_change() and start using
> 	   the mailbox that is still in use.
> 	=> BOOM
> 
> There is a simpler an much more likely sequence with the dell quirk active.

Okay.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

-- 
heikki

