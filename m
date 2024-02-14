Return-Path: <linux-kernel+bounces-65105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC058547D5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29011C218CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0771946C;
	Wed, 14 Feb 2024 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CkOhCRQ1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1317818EA2;
	Wed, 14 Feb 2024 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909282; cv=none; b=R8yJQYlrAgUCP7xFAIUX5qHtHuvmclvI0zV0OBpfhh7xHAjKLYflEcQCe9sEVxYBZx1kM08thwhD5ZUYB2QEaS0RzaeIguHZNi7fHIShN8dSjTgZ5pQOoOIxemAVGgeBxiS+uqoH7+Eke29P0U3bmv+bQiKArgYBEeKib1fs32g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909282; c=relaxed/simple;
	bh=/zBV41EcCG6K/uokJf/6APSOmXZDKRrKNCSzt+OXz+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7wGZqGq2rMSLPYJdVynYTPLKiGacoSS6YhWatrS223LI2W7HbXxr9mv7B819PJGTQs0asZ1xJ3uwmHv4F5vP28I+tkWA6cjlLOuKmbb1ri/ftM+J2g08LnNK/5WkipDBRZk5yPTqrFoxP+1nS1zFQNZLSJPHyKm4559FZcFwUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CkOhCRQ1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707909281; x=1739445281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/zBV41EcCG6K/uokJf/6APSOmXZDKRrKNCSzt+OXz+4=;
  b=CkOhCRQ1Ox2wDwjQElorh73rLyVhbNa9mpwDOY9ZlbscHRgdl4kktEET
   SfI28oLSxMIIuqg5E3AdtALaLRDQmKu60Xs3OsBDUROY1V9uQJtbCB020
   A0WLCx9+BRopy+Rnc1ZINQr8MoroH+fs71buAN3LIQuepLbnF8UGqM1gm
   cEqe7RXcxFWC8UvgVqImYokb+WvJP7P2/kp6LMp/AZWR/1qNLHqSFje8d
   GjS5KZLOHYeqFVjwFtYK3hLxkBR71NdyeUp7J+bYOHukz8iaOhszf9EM6
   0QJVAmnzY9C7t4EzaFLNBeP1CT1JjaA0jynbEqJt8oA7EL5tPk6M7XWxI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="2091795"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="2091795"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 03:14:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3067801"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 03:14:38 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 878CB11F86A;
	Wed, 14 Feb 2024 13:14:35 +0200 (EET)
Date: Wed, 14 Feb 2024 11:14:35 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linuxfancy@googlegroups.com, martin.hecht@avnet.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] media: i2c: alvium: fix req_fr check into
 alvium_s_frame_interval()
Message-ID: <ZcygmyT1ZaKsbSxX@kekkonen.localdomain>
References: <20231220124023.2801417-1-tomm.merciai@gmail.com>
 <20231220124023.2801417-6-tomm.merciai@gmail.com>
 <20231220130236.GN29638@pendragon.ideasonboard.com>
 <ZYLxtTRQF0sWJLiu@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYLxtTRQF0sWJLiu@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>

Hi Tommaso,

On Wed, Dec 20, 2023 at 02:52:53PM +0100, Tommaso Merciai wrote:
> Hi Laurent,
> 
> On Wed, Dec 20, 2023 at 03:02:36PM +0200, Laurent Pinchart wrote:
> > Hi Tommaso,
> > 
> > Thank you for the patch.
> > 
> > On Wed, Dec 20, 2023 at 01:40:23PM +0100, Tommaso Merciai wrote:
> > > Actually req_fr check into alvium_s_frame_interval() is wrong.
> > > In particular req_fr can't be >=max and <= min at the same time.
> > > Fix this using clamp and remove dft_fr parameter from
> > > alvium_get_frame_interval() not more used.
> > 
> > The commit message should have explained why clamping is better than
> > picking a default value, as that's a functional change. If you propose
> > an updated commit message in a reply, I think Sakari can update the
> > patch when applying the series to his tree, there's no need for a v4.
> 
> What about:
> 
> Actually req_fr check into alvium_s_frame_interval() is wrong.
> In particular req_fr can't be >=max and <= min at the same time.
> Fix this using clamp and remove dft_fr parameter from
> alvium_get_frame_interval() not more used.
> 
> Clamp function make sure that if the setted value exceeds the limits is
> replaced with min_fr/max_fr instead of setting the value readed back
> from the hw.
> 
> What do you think?

I used this, hopefully it's ok:

media: i2c: alvium: fix req_fr check in alvium_s_frame_interval()

req_fr check in alvium_s_frame_interval() is incorrect. In particular
req_fr can't be >=max and <= min at the same time. Ensure the requested
frame rate remains within the supported range between min_fr and max_fr by
clamping it.

Also remove the unused dft_fr argument of alvium_get_frame_interval().

-- 
Kind regards,

Sakari Ailus

