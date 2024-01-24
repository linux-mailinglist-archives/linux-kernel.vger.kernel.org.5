Return-Path: <linux-kernel+bounces-37078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428F383AB2F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765AF1C28659
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E297A70A;
	Wed, 24 Jan 2024 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxsssozW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2952E604B2;
	Wed, 24 Jan 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104325; cv=none; b=RmlzDuyu65gc/qfEPpGA2aVznWZfr8SJj0meUTQ20WoflX1DFWdV5HZleztKS7iG09sTGS0lvoNEp1BMpFZ8SHfNvhyYU1rNWXwy4pNXsV7NrkAYuzslHl82fvaZ/acSI1pPyBtrZBGz4oz7BimhcxLgMKzoD09Vqf7YA8KDAaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104325; c=relaxed/simple;
	bh=rbpT+I5DAbw9inpKn+MsXkzmp0NlzvzL9aVI6prsA2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4S5go10PIB7YtdkC0ux7t6W/vI8MnVOVhqEMr0feXMdUhDzbTZnTnNEbogR24DcfwN4WiZBtKH2nLJbvmdISXaPyYv8r8E+U6ALzcSPCXizQMjISFo8vKvXj6Xbt4i9uT4f+rlCXKRVE1m96hKCRQQTUO1mjnuskiu1p8eRUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxsssozW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706104324; x=1737640324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rbpT+I5DAbw9inpKn+MsXkzmp0NlzvzL9aVI6prsA2s=;
  b=kxsssozWlxGeGLB/DLcnihnl7d6doOla+Quxm6NKC/Cuv3rYrKUW/g69
   +uRlrESMq1iQbyVBWFuaynba6G0fAp6cBKOQMJo+qyUjyz9t4BCVefeeE
   eoT6VWf7ph3hDDlRf+w6HwCw1USO/db43E4+fKB417iJkdHRCTAdRsUj/
   XafAvg74y/VdxXgXmwCnyRRmV5Y9Ugy3LYQ3/ahOYaVSKinXmXyf69yFx
   kWnt5H976yIWa+zfB/+UHOiWOUsY0LLKNgkb2juzTwiEBnpYfUfmjzjL0
   8cX2U+tpIUNDYKuoIdn/PydALeS2PN+Iw6aJuZIFYftxVdMTIuVzmBt7R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8519424"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8519424"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 05:52:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="929688219"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="929688219"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Jan 2024 05:51:59 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 24 Jan 2024 15:51:58 +0200
Date: Wed, 24 Jan 2024 15:51:58 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Prashant Malani <pmalani@chromium.org>
Cc: Abhishek Pandit-Subedi <abhishekpandit@google.com>,
	linux-usb@vger.kernel.org, jthies@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] usb: typec: ucsi: Limit read size on v1.2
Message-ID: <ZbEV/qp/EhUkHVhA@kuha.fi.intel.com>
References: <20240123223039.1471557-1-abhishekpandit@google.com>
 <20240123143026.v1.1.Iacf5570a66b82b73ef03daa6557e2fc0db10266a@changeid>
 <CACeCKaftJSGba3ebs58=cB5aRLuOnbvhQX2V6+5=t9GPC08_Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACeCKaftJSGba3ebs58=cB5aRLuOnbvhQX2V6+5=t9GPC08_Uw@mail.gmail.com>

On Wed, Jan 24, 2024 at 12:12:26AM -0800, Prashant Malani wrote:
> Hi Abhishek,
> 
> On Tue, Jan 23, 2024 at 2:30 PM Abhishek Pandit-Subedi
> <abhishekpandit@google.com> wrote:
> >
> > From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> >
> > Between UCSI 1.2 and UCSI 2.0, the size of the MESSAGE_IN region was
> > increased from 16 to 256. In order to avoid overflowing reads for older
> > systems, add a mechanism to use the read UCSI version to truncate read
> > sizes on UCSI v1.2.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> I have one nit (mentioned in side-band but reproducing here for consistency),
> but will defer to the maintainer on that.
> 
> The above notwithstanding, FWIW:
> Reviewed-by: Prashant Malani<pmalani@chromium.org>
> 
> > @@ -1556,6 +1569,15 @@ int ucsi_register(struct ucsi *ucsi)
> >         if (!ucsi->version)
> >                 return -ENODEV;
> >
> > +       /*
> > +        * Version format is JJ.M.N (JJ = Major version, M = Minor version,
> > +        * N = sub-minor version).
> > +        */
> > +       dev_info(ucsi->dev, "Registered UCSI interface with version %x.%x.%x",
> > +                UCSI_BCD_GET_MAJOR(ucsi->version),
> > +                UCSI_BCD_GET_MINOR(ucsi->version),
> > +                UCSI_BCD_GET_SUBMINOR(ucsi->version));
> 
> nit: I think this doesn't need to be dev_info() and can be just
> dev_dbg(), but will
> defer to the maintainer.

I think that's okay.

Reviewewd-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

-- 
heikki

