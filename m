Return-Path: <linux-kernel+bounces-20481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 439EC827F85
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE8FB2454F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1670947A;
	Tue,  9 Jan 2024 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Okic1hZF"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD181944D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D68EBFF806;
	Tue,  9 Jan 2024 07:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704785708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4dJB2jrYpwd2emaRyG+9ezzrTSheoF2q2JvQuIR+aI=;
	b=Okic1hZFBhRED0jVi5a/v1nlbL5qAeWosYPSGQ0PoUP5NaEgToPwxWNwPa/JFVhjfujpGq
	OXU0Hx+x3SuKWMp5/fHmBBJ2lIvnqUgdhF51VuHs0LnbroBE4tYpg8td/nUOznMtHWETzl
	EGuh4hkC/LtN/apG3z5CydTwscAGAtkfeUzk2ePP0prJkuTmbg/WzYEXnbqAbrDpKQi8ah
	sOlbNVOFaBDLk1+92X3Hd3AzvqdEXj6cynnJxfJGwq3Yxt7L7JDHqHnEJYQpx1X1NLltbZ
	WIsf5Puyqzh5sl8S9Gerb/YSSTfnKwDMD2FQxZvjDPzyuMrFAtK4etiFSVwbuQ==
Date: Tue, 9 Jan 2024 08:35:07 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
	imx@lists.linux.dev, joe@perches.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, zbigniew.lukwinski@linux.intel.com
Subject: Re: (subset) [v5 resend 0/6] i3c: master: some improvment for i3c
 master
Message-ID: <2024010907350708773e04@mail.local>
References: <20231201222532.2431484-1-Frank.Li@nxp.com>
 <170467220283.558820.13886846242749418731.b4-ty@bootlin.com>
 <ZZyfL/wWSW1oMOec@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZyfL/wWSW1oMOec@lizhi-Precision-Tower-5810>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 08/01/2024 20:19:43-0500, Frank Li wrote:
> On Mon, Jan 08, 2024 at 01:03:50AM +0100, Alexandre Belloni wrote:
> > 
> > On Fri, 01 Dec 2023 17:25:26 -0500, Frank Li wrote:
> > > There are three major improvement
> > > 
> > > 1. Add actual size in i3c_transfer because i3c allow target early termiate
> > > transfer.
> > > 2. Add API for i3c_dev_gettstatus_format1 for i3c comand GET_STATUS.
> > > 3. svc master support hotjoin
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/6] i3c: master: add enable(disable) hot join in sys entry
> >       commit: 317bacf960a4879af22d12175f47d284930b3273
> > [2/6] i3c: master: svc: add hot join support
> >       commit: 05b26c31a4859af9e75b7de77458e99358364fe1
> > [3/6] i3c: add actual_len in i3c_priv_xfer
> >       commit: e5e3df06ac98d15cfb10bb5c12356709365e91b2
> > [4/6] i3c: master: svc: rename read_len as actual_len
> >       commit: 6fb61734a74eaa307a5b6a0bee770e736d8acf89
> > [5/6] i3c: master: svc: return actual transfer data len
> >       commit: 6d1a19d34e2cc07ca9cdad8892da94e716e9d15f
> 
> Why not pckup 6/6: 
>  i3c: add API i3c_dev_gettstatus_format1() to get target device status
> 

As it was discussed, it doesn't have any users.

> Frank
> 
> > 
> > Best regards,
> > 
> > -- 
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

