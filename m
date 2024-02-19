Return-Path: <linux-kernel+bounces-71138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A216485A132
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4267BB216D7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221CC2C6BD;
	Mon, 19 Feb 2024 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2emhPP4+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EAA2C6B0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339247; cv=none; b=QdS4gO4xD1RBKaBq1ZI0mdhMtk3YS5t02kPBlnt8zF4oKC1X4l4o8Q/sFVnrZgkKBiOezu/OxCrKlXTn34BZo7nMY6gOSiure1kozqe3NjgKE1T0qEkhi/GkWozBY0poHHXdMS7KuYLsQ219GmyXuO3DgY27LA3mauJkGU5Jdww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339247; c=relaxed/simple;
	bh=3Jd/WJlLK0V3Y9M5Q07+MY83X6KduYhEq+78j7CvRZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IA7nT41rG07msxS1RT+ceWs12PYPQenUUlKDc8ZSLnyGXUk6JJc7Y6OvKaGTLUcB5LO84HAe+n/yyexGwXi76SUkrhKOZcqe+Z96nG2Omr59G7uA6rILQ836eQ1RuwACe34eoxHITzBAPIlerrEQp/AWGD838CFexUa49jZBYT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2emhPP4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825EDC433C7;
	Mon, 19 Feb 2024 10:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708339247;
	bh=3Jd/WJlLK0V3Y9M5Q07+MY83X6KduYhEq+78j7CvRZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2emhPP4+JnhM04+8AEf+DF8onVkfio1d1XOpBNZ0FLYng3AgglYiIloqQMkV1LVfI
	 tySFwKKdOTAAHVaIISz1kattdSkhlnhjb7Vse18j19HAxFmTPvL4Pu+O10e1/GoGK5
	 fP7EjLlua3R4A40Q1e8yxBKyrFskVSRAovyUL38I=
Date: Mon, 19 Feb 2024 11:40:43 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Wu, Wentong" <wentong.wu@intel.com>
Cc: "Winkler, Tomas" <tomas.winkler@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mei: Add Meteor Lake support for IVSC device
Message-ID: <2024021924-mashed-hankering-348a@gregkh>
References: <20240207004304.31862-1-wentong.wu@intel.com>
 <ZcMmg1f8975whpno@kekkonen.localdomain>
 <PH7PR11MB760526EBCB4CFCDB19A03E40E5452@PH7PR11MB7605.namprd11.prod.outlook.com>
 <MW5PR11MB5787BC32B9E7C3F818B6B9D98D522@MW5PR11MB5787.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB5787BC32B9E7C3F818B6B9D98D522@MW5PR11MB5787.namprd11.prod.outlook.com>

On Sun, Feb 18, 2024 at 08:44:58AM +0000, Wu, Wentong wrote:
> > From: Winkler, Tomas <tomas.winkler@intel.com>
> > > On Wed, Feb 07, 2024 at 08:43:04AM +0800, Wentong Wu wrote:
> > > > Add IVSC device support on Meteor Lake platform.
> > > >
> > > > Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> > >
> > > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Acked-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> Thanks, Sakari and Tomas. 
> 
> Greg, could you please help take a look this patch? Thanks

To help make patch review quicker, please help out in reviewing patches
for others.

thanks,

greg k-h

