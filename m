Return-Path: <linux-kernel+bounces-27733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6882F50A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B00285E68
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0D21D520;
	Tue, 16 Jan 2024 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCyFyKX0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64241CF9A;
	Tue, 16 Jan 2024 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432206; cv=none; b=oL7ymza18n/3I1uXuQOZ/p9Qkv2M8j4OSVAfkLqIRSS2bnO6xVUZuujZodNyqorRM0l33OP3E2ojG19jj0Fq8jkcquuTOwKgIbQQcEIv8WmZ9CkVV3sQpBlbVSmWvTzvD9/FM3pFk4Mzw2VJc21H1GrrnobIN2bBprz6nFCtVwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432206; c=relaxed/simple;
	bh=sZ+MCwU6oGGcQWQZQIrYoyGgx0lzP8uZ1STGNge7O7o=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TW3s7B6aI+8x/jDv7AZyRWowtvOoUQbNT9ik+YGfIq2MDoM0J1jaJfGuexTIlVumWsq1G7p/PMnvRZ/GDH1TjS86elGG0C2srVgWNTRJribKUQxdvB94I6Oxs4yrRlauBiEXZSgkjtuXSiGakmmB9fZVeoXg916/32udP23L+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCyFyKX0; arc=none smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705432205; x=1736968205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sZ+MCwU6oGGcQWQZQIrYoyGgx0lzP8uZ1STGNge7O7o=;
  b=DCyFyKX0lUmYZfZvrtWnfiIui47LRb/gAmD269Lq8Vfo+daixFwc0cOB
   oq7qOlw2pJvnD98UGIK9imoEe47zkzDMxVUCCMk8Q0gMAS5p960M9KU13
   2G/WRmMU6KVJ7/lOF8n73PhCyTrjIKdfXj/SLdvbcsS6vol/ArSuES1Y8
   Xvp2xGyh/IQhPl0b9eAcfFSPJWw8Krn5UA/15PDSh77gla0vZ1buGH4j7
   7bX9vQYh4cC9kzB6zWPGK4WegeQRR1FIiO2SJo9kr8iz06fQ8VgtrrI2v
   L4TcVtJ0721I0A1sOvOwf/KhupV7iQduGExgwOuYljqNbjm0HNObm3wAi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="13313317"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="13313317"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 11:10:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="1115399966"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="1115399966"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 11:10:02 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 13DE611F86A;
	Tue, 16 Jan 2024 21:09:59 +0200 (EET)
Date: Tue, 16 Jan 2024 19:09:59 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Vinay Varma <varmavinaym@gmail.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"open list:SONY IMX219 SENSOR DRIVER" <linux-media@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: i2c: imx219: implement the v4l2 selection api
Message-ID: <ZabUh0ozhQq-GtEC@kekkonen.localdomain>
References: <kv6yfyahbud474e75y4jaczg64pcowvlz7i52kikknuh6wje5o@4k2hikwcueoy>
 <ZZu2C_lu6TAh-LOf@kekkonen.localdomain>
 <3q6andka2su7i43xz2ok44ejvtb3hdjdn6xretyde7sdcvtd7l@lz2syngckivi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3q6andka2su7i43xz2ok44ejvtb3hdjdn6xretyde7sdcvtd7l@lz2syngckivi>

Hi Jacopo,

On Mon, Jan 08, 2024 at 10:19:35AM +0100, Jacopo Mondi wrote:
> Hi Sakari, Vinay,
> 
>    a more foundamental question is how this usage of the crop/compose
> API plays with the fact we enumerate only a limited set of frame
> sizes, and now you can get an arbitrary output size. We could get away
> by modifying enum_frame_sizes to return a size range (or ranges) but I
> wonder if it wouldn't be better to introduce an internal pad to
> represent the pixel array where to apply TGT_CROP in combination with
> a source pad where we could apply TGT_COMPOSE and an output format.

My earlier review wasn't focussed on the interface at all...

To depart from the current restrictions on single-subdev sensor drivers,
this is one option.

Sensors implement various steps in different orders and different drivers
have different capabilities, too. Mainly there are two classes: freely
configurable drivers such cas CCS and then register list based drivers
where virtually any dependencies between configurations are possible.

We probably can't support both classes with the same API semantics and due
to hardware differencies. The sensor UAPI will be less than uniform it has
been in the past but I don't think this should be an issue.

I wonder how much common understanding we have at this point on how this
API would look like. Probably not much?

-- 
Regards,

Sakari Ailus

