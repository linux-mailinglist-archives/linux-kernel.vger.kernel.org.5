Return-Path: <linux-kernel+bounces-144687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350CD8A4938
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC6B1F219E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B6128DD0;
	Mon, 15 Apr 2024 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KpfzGIGS"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF524A06;
	Mon, 15 Apr 2024 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166820; cv=none; b=KTADe0tK7Lm0nLgBC/QHKWTqn19ud+btyAZQKGT3gsihntM1D2xwVEWfwn1awc81NpOc3zFrDBKpP0WlbvjJ44I5JizLsA4sDOP1ONr0oPwc3JBPTQJqcdIO+8xpYHcCoIvNHMlRCcZ2lTf5MdxPUZkdYra//4Xtl/ugrCPe5OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166820; c=relaxed/simple;
	bh=PlR27jb6Mjd4OFt0+j9zaTy8C+fkjO+qwksXbuA01ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErWsgOMARL+Ez781T/JN998N/sWWhGVe8+AyR85hmUpLrmdN8KaHLRJVSsr0Qfqn2GMR2oUPKSLW6EkV/QFrFdTPpdEqvwGIFzpKTnYFO96PCHoqvoRrLCmO9UJ+3PHm1J539qjirh9wSOAByt7JjVQQvR2q06UOXX70hqNfD7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KpfzGIGS; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6BFF05B2;
	Mon, 15 Apr 2024 09:39:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713166771;
	bh=PlR27jb6Mjd4OFt0+j9zaTy8C+fkjO+qwksXbuA01ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KpfzGIGSZO4W8WuLKAgTSmR7t+++/vMbKSS3wMYRFHfdzaP0i4WCBYbBp1se/JmqM
	 Dst4oDmK5huyBoU57DBwWjaYZcEs2g32tqH3+jW/gARBHIVgAFh3WPd0GCosr8NU/I
	 W0QryhhQQmxJ1XPlWGITSqU5tHlPdUZZ1V5nCw6E=
Date: Mon, 15 Apr 2024 10:40:08 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
	Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] media: v4l: Don't turn on privacy LED if streamon
 fails
Message-ID: <20240415074008.GB25078@pendragon.ideasonboard.com>
References: <20240410114712.661186-1-sakari.ailus@linux.intel.com>
 <20240412174621.GA5444@pendragon.ideasonboard.com>
 <ZhzUHs7lpdeMa22l@kekkonen.localdomain>
 <20240415071812.GA25078@pendragon.ideasonboard.com>
 <ZhzXZUyY4Rc4z71y@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhzXZUyY4Rc4z71y@kekkonen.localdomain>

On Mon, Apr 15, 2024 at 07:29:41AM +0000, Sakari Ailus wrote:
> On Mon, Apr 15, 2024 at 10:18:12AM +0300, Laurent Pinchart wrote:
> > > Maybe because a large majority is GPIO-controlled?
> > 
> > GPIOs can fail, in particular when they're on I2C GPIO expanders.
> 
> Sure, but gpiod_set_value() return type is also void.

I know, so there's nothing we can do short term.

> It just works... right?

Until it doesn't :-)

-- 
Regards,

Laurent Pinchart

