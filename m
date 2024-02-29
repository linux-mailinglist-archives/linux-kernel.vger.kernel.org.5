Return-Path: <linux-kernel+bounces-87429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E57886D44D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1774528A3F9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD45C144048;
	Thu, 29 Feb 2024 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bNlkcPD/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C7414403D;
	Thu, 29 Feb 2024 20:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238870; cv=none; b=t5C+TkWbft88+xze58RdjPG9dSTgSVAhW1jd3xHrpZTRFj32vD8IsoEQwstWwP7mglSy2OHHJqEmHIXZnwOALlfzYY5kB5EAJOp53hCan6eKgHPujRAN6v5mHEmpmAwWt9b0awxmEDdXw+Xgeab4fO1M7ruaQGrJwHeEpnXEMqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238870; c=relaxed/simple;
	bh=IOKmOaZ3f+R9G99MWOPlPCNobJh93nKUWXF4w2ekTL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRgGf1w36Zh8aGsZ7ryLCei0U05RInZDpGufgPLRrg/l27F3spQQjEV/8XrA0i0F9pxzDiy0M807zvznJc+BdnjqhNhNVCa3YmWyh1nHMExvVqoKvMr2jjZ0oZ/scXIuU1HaYEPqg1JpVBkfVRFRpZzNjXcElqnQGmI5Ejo2DE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bNlkcPD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7A6C43390;
	Thu, 29 Feb 2024 20:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709238869;
	bh=IOKmOaZ3f+R9G99MWOPlPCNobJh93nKUWXF4w2ekTL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNlkcPD/X0lmlYMd78MNbai443tQVDwo9uKnP1hs+9G/zFsw+X3iFzIubktGbOZfV
	 n5qYc0N8U5x8JBE9oiHpvwYxHElib4be4iuMwUa1Mvrl2tPYHpCDallMK2n8k2ndu5
	 hlSolO3NEv/Abhu7oPhu7kdHtnhlerXDaw/TM4GU=
Date: Thu, 29 Feb 2024 21:34:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, rafael@kernel.org,
	pavel@ucw.cz, len.brown@intel.com,
	andriy.shevchenko@linux.intel.com, rdunlap@infradead.org,
	james@equiv.tech, broonie@kernel.org, james.clark@arm.com,
	masahiroy@kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
Message-ID: <2024022901-getaway-bacon-b805@gregkh>
References: <20240223143833.1509961-1-guanyulin@google.com>
 <a299118d-eeec-40b4-9a3d-48dc40f34e12@gmail.com>
 <CAOuDEK3wP6zhEwgUn5zSedtwTYVFaJeBfeXkSg897EhpGP9=ig@mail.gmail.com>
 <3208c5b9-5286-48d1-81ab-cc3b2bc4303e@gmail.com>
 <CAOuDEK39Bdru5wAbxW-g2c=POgRxZwdQzPO5uNXP96AfSyA6pw@mail.gmail.com>
 <7292dc5c-dff0-45f0-99b1-f1687451b23f@gmail.com>
 <CAOuDEK2OtAO7GqPzWkdC=SARkuHYGzqW4iPdFfMx8dyw4Cy+Lg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuDEK2OtAO7GqPzWkdC=SARkuHYGzqW4iPdFfMx8dyw4Cy+Lg@mail.gmail.com>

On Thu, Feb 29, 2024 at 05:08:00PM +0800, Guan-Yu Lin wrote:
> We want to introduce a mechanism that allows the Linux kernel to make
> power transitions for the peripheral based on whether the other
> operating system kernel is actively using it. To achieve this, we
> propose this patch that adds a sysfs attribute, providing the Linux
> kernel with the necessary information.

Don't create random user/kernel apis in sysfs for no good reason just
because it is "easy" :(

If the "other operating system is actively using it" isn't able to be
detected by Linux, then Linux shouldn't be able to change the PM state,
so this sounds like you need to fix your Linux driver to properly know
this information, just like any other device type (think about a sound
device that needs to know if it is being used or not, nothing different
here.)

So please post your Linux driver and we can see what needs to be done
there to get this to work properly, odds are you are just missing
something.  Have a pointer to the code anywhere?

Also, as you know, we can NOT add interfaces to the kernel without any
real user, so without a driver for your hardware, none of this is able
to go anywhere at all, sorry.

thanks,

greg k-h

