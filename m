Return-Path: <linux-kernel+bounces-45516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE45C8431D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D23D1C2508A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA455523B;
	Wed, 31 Jan 2024 00:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AsqL/+PA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90B4C9D;
	Wed, 31 Jan 2024 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706660584; cv=none; b=tRLvkHWrNECR72p8NGagKHUAiHQZPoUOjcrdgUburJa63PMY4bFSeWNdGwKWSPx0o5emhUUdactJ0qN4KpsHjCoR49RoDzaxlA3Q270RH3qROD7EhU8FSfk+ZQbVK4Z631fpz0qGk0Gp7obnGpA3whraIFO1US4ELlzq5pGzwb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706660584; c=relaxed/simple;
	bh=iO+w0RdJHmRY+dn5TzHr1cclWbvfDkfjTwE6P1yaT30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwpdB88jKM7I43wo+yI+gpfDSGfJgzAu5ckOmYvP72YyEJU6J7VzPyQXxRchYchjDUhzL2fBCrM13YghBNqBTEvgHaohNqVpk2Gs/ucxfUtGc3bdgcOqQUUg16hUdWz/f3o4zhI2ErKS/h6W93Nuo1n2DGaoIt6HXagIh0s2Xvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AsqL/+PA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C43C433F1;
	Wed, 31 Jan 2024 00:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706660583;
	bh=iO+w0RdJHmRY+dn5TzHr1cclWbvfDkfjTwE6P1yaT30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AsqL/+PA/zQQ9IUFUjtgRceCUPdohwOnUH/zx4Xf+kR5BRt1oGUd1c6FQc37M5ydH
	 IqRFjv2qERUCrJbxQC+BmmCp/prbTgN/AjDD8BZymYuuqx5IUpZnzzgH7JKXfGIwMf
	 ifEbnOzqRn2DRpWB0U9jtXQaumonHRVhYoOT5hp4=
Date: Tue, 30 Jan 2024 16:23:02 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chrome-platform@lists.linux.dev,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] firmware: coreboot: Generate aliases for coreboot
 modules
Message-ID: <2024013012-gully-goofy-2a55@gregkh>
References: <20240112131857.900734-1-nfraprado@collabora.com>
 <20240112131857.900734-3-nfraprado@collabora.com>
 <ZaQVScQ2AYquG-Zr@smile.fi.intel.com>
 <ZbA4VthTMPT7BSRo@google.com>
 <2024013059-poison-equation-81d1@gregkh>
 <CA+ASDXM-m6U+JFvBSSHMxAf8Ct-T-pL8tmcHxHQjepdRFR-s1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+ASDXM-m6U+JFvBSSHMxAf8Ct-T-pL8tmcHxHQjepdRFR-s1w@mail.gmail.com>

On Tue, Jan 30, 2024 at 04:01:57PM -0800, Brian Norris wrote:
> On Tue, Jan 30, 2024 at 3:51 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Jan 23, 2024 at 02:06:14PM -0800, Brian Norris wrote:
> > > "Don't you want to have a driver data or so associated with this?"
> ...
> > But why limit yourself to 32bits now?  Why not make it 64?  It is going
> > to be sent to userspace, so you have to be very careful about it.
> 
> Is that question related to the question I pasted/replied to, about
> driver data? Or a new topic? Sorry if I'm misunderstanding.

Same question, driver data, you make it 32 bits.

> Anyway, for the size of the tag field: I don't have a strong opinion.
> But FWIW, they're coming from this project:
> 
> https://review.coreboot.org/plugins/gitiles/coreboot/+/269b23280f928510bcadd23182294e5b9dad11ec/payloads/libpayload/include/coreboot_tables.h#36
> 
> As you can see there, we're extremely far from exhausting 16 bits, let alone 32.

We've run into running out of bits in other subsystems before, it's
"free" now, just be safe and make it 64 like I think Andy is suggesting.

thanks,

greg k-h

