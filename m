Return-Path: <linux-kernel+bounces-120738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA19388DC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D721F25202
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7034D59159;
	Wed, 27 Mar 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYesbyzq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061F858ABE;
	Wed, 27 Mar 2024 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538329; cv=none; b=T6RLCjcrwi/v+MQP7v0+WVPTbqjhAzvjSYqD2cRvhmMM+wZJJ7SwUwu04nEBFxNHJfRcrqd8fZka9wGENt9ebpmhBOLs5+WEBAL1WJjSPHYQ0fyS+BNRd5fIjbRf7dyK9H+bJKj1a0pqS+DgxBfd9m+pUH3Zutf/VkKM3zvmWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538329; c=relaxed/simple;
	bh=wiPPdBsBFUiXtICeR6NKWNIx1iXLtSYSRyrtf2Di2BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bfn4LS3vJTEtKOdC1ePUtOIKReGww1rO2nIPAJ6nUBpv0ANsLmTj5jMsPYPxVnZpELE6w314PbNxb6rOMBrHm8oy1uoz9Dooy27/HIR11/yYucAut6yOP9T7jkIMABnz4GnZKd5fQ9OUgRFsgT2ahI8J+FpmZwpMcMwW4x5peNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYesbyzq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711538328; x=1743074328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wiPPdBsBFUiXtICeR6NKWNIx1iXLtSYSRyrtf2Di2BQ=;
  b=EYesbyzqz9mVl3Ukb7a3EZv+aWzLqljv1nQPDXQji1lNrVhD/kWsMsGn
   y2QLqz67lUxllBFzQAh+vF5XNipMzeITZGMx+0cuA6QTPa4q6HfCbj+Sy
   5F2qs9u1hWFnNkvzV2CVrpbJr84lzmRPEkXK4RZhFmSaynGIAmSelLvtu
   SlhZZ8qb2auBZah6gKUSVjCm5TuZCxvIFKmkBxgOf/0Jr4mAHOkQ0DQ60
   Z5AUNj+RH8R2mI8oQYNQyPn/eovp5wz+exn8ZZwueCmomkNwxvE9S4VHK
   lbVB7QYs1lf/GV5qd3esYfrbZJmjKP0ntv3ed2Q9GTtJeSLSlUG4mFChI
   A==;
X-CSE-ConnectionGUID: POu0qQjKRcqRz44bmoHryw==
X-CSE-MsgGUID: t7r2rF7ySHakkqHbAt0eww==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17361630"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="17361630"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 04:18:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937074466"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="937074466"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 27 Mar 2024 04:18:43 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 27 Mar 2024 13:18:42 +0200
Date: Wed, 27 Mar 2024 13:18:42 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Prashant Malani <pmalani@chromium.org>
Cc: Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org,
	bleung@google.com, abhishekpandit@chromium.org,
	andersson@kernel.org, dmitry.baryshkov@linaro.org,
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org,
	hdegoede@redhat.com, neil.armstrong@linaro.org,
	rajaram.regupathy@intel.com, saranya.gopal@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] usb: typec: ucsi: Register SOP/SOP' Discover
 Identity Responses
Message-ID: <ZgQAknSUfBxK7PcH@kuha.fi.intel.com>
References: <20240305025804.1290919-1-jthies@google.com>
 <20240305025804.1290919-4-jthies@google.com>
 <Zedqb6_fe0GoUR9U@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zedqb6_fe0GoUR9U@chromium.org>

On Tue, Mar 05, 2024 at 06:54:39PM +0000, Prashant Malani wrote:
> On Mar 05 02:58, Jameson Thies wrote:
> > Register SOP and SOP' Discover Identity responses with the USB Type-C
> > Connector Class as partner and cable identities, respectively. Discover
> > Identity responses are requested from the PPM using the GET_PD_MESSAGE
> > UCSI command.
> > 
> > Signed-off-by: Jameson Thies <jthies@google.com>
> 
> Mostly line splitting nits (which I have listed below). Once those are
> addressed, please feel free to add:
> Reviewed-by: Prashant Malani <pmalani@chromium.org>

After you've fixed those add also my:
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > index 7c84687b5d1a3..3b64a0f51041c 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -646,6 +646,108 @@ static int ucsi_get_src_pdos(struct ucsi_connector *con)
> >  	return ret;
> >  }
> >  
> > +static int ucsi_read_identity(struct ucsi_connector *con, u8 recipient,
> > +			      u8 offset, u8 bytes, void *resp)
> > +{
> > +	struct ucsi *ucsi = con->ucsi;
> > +	u64 command;
> > +	int ret;
> > +
> > +	command = UCSI_COMMAND(UCSI_GET_PD_MESSAGE) |
> > +	    UCSI_CONNECTOR_NUMBER(con->num);
> > +	command |= UCSI_GET_PD_MESSAGE_RECIPIENT(recipient);
> > +	command |= UCSI_GET_PD_MESSAGE_OFFSET(offset);
> > +	command |= UCSI_GET_PD_MESSAGE_BYTES(bytes);
> > +	command |= UCSI_GET_PD_MESSAGE_TYPE(UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);
> > +
> > +	ret = ucsi_send_command(ucsi, command, resp, bytes);
> > +	if (ret < 0)
> > +		dev_err(ucsi->dev, "UCSI_GET_PD_MESSAGE failed (%d)\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int ucsi_get_identity(struct ucsi_connector *con, u8 recipient,
> > +			      struct usb_pd_identity *id)
> 
> nit: Line limits are 100 now [1], so this can fit on one line.
> 
> > +{
> > +	struct ucsi *ucsi = con->ucsi;
> > +	struct ucsi_pd_message_disc_id resp = {};
> > +	int ret;
> > +
> > +	if (ucsi->version < UCSI_VERSION_2_0) {
> > +		/*
> > +		 * Before UCSI v2.0, MESSAGE_IN is 16 bytes which cannot fit
> > +		 * the 28 byte identity response including the VDM header.
> > +		 * First request the VDM header, ID Header VDO, Cert Stat VDO
> > +		 * and Product VDO.
> > +		 */
> > +		ret = ucsi_read_identity(con, recipient, 0, 0x10, &resp);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +
> > +		/* Then request Product Type VDO1 through Product Type VDO3. */
> > +		ret = ucsi_read_identity(con, recipient, 0x10, 0xc,
> > +					 &resp.vdo[0]);
> 
> nit: Can fit on one line.
> 
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +	} else {
> > +		/*
> > +		 * In UCSI v2.0 and after, MESSAGE_IN is large enough to request
> > +		 * the large enough to request the full Discover Identity
> > +		 * response at once.
> > +		 */
> > +		ret = ucsi_read_identity(con, recipient, 0x0, 0x1c, &resp);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	id->id_header = resp.id_header;
> > +	id->cert_stat = resp.cert_stat;
> > +	id->product = resp.product;
> > +	id->vdo[0] = resp.vdo[0];
> > +	id->vdo[1] = resp.vdo[1];
> > +	id->vdo[2] = resp.vdo[2];
> > +	return 0;
> > +}
> > +
> > +static int ucsi_get_partner_identity(struct ucsi_connector *con)
> > +{
> > +	int ret;
> > +
> > +	ret = ucsi_get_identity(con, UCSI_RECIPIENT_SOP,
> > +				 &con->partner_identity);
> 
> nit: One line please.
> 
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = typec_partner_set_identity(con->partner);
> > +	if (ret < 0) {
> > +		dev_err(con->ucsi->dev, "Failed to set partner identity (%d)\n",
> > +			ret);
> 
> nit: One line (100 is the limit now).
> 
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int ucsi_get_cable_identity(struct ucsi_connector *con)
> > +{
> > +	int ret;
> > +
> > +	ret = ucsi_get_identity(con, UCSI_RECIPIENT_SOP_P,
> > +				 &con->cable_identity);
> 
> nit: One line.
> 
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = typec_cable_set_identity(con->cable);
> > +	if (ret < 0) {
> > +		dev_err(con->ucsi->dev, "Failed to set cable identity (%d)\n",
> > +			ret);
> 
> nit: One line.
> 
> Best regards,
> 
> -Prashant
> 
> [1] https://github.com/torvalds/linux/blob/master/scripts/checkpatch.pl#L59

-- 
heikki

