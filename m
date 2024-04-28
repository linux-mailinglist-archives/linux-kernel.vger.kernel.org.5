Return-Path: <linux-kernel+bounces-161472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 250448B4C74
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B3AEB212EB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932F16F07E;
	Sun, 28 Apr 2024 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7C82mvs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D893C3BBCA;
	Sun, 28 Apr 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714319024; cv=none; b=aAPwGq/B0nvMkDyg49ZBPSMFEsTKwpnsjHpQn8T2hC68jkes2+UiodJU99RHErzyUHxfiMJrDePxDzlhBSoQA8lPvr6JF516CxKuLw+uLSdRwazj+8fDuzn8Gk5Sc/0HQRWIEWHgMUWKH/3m5+FyAdXswapQR92y8JvbgCneP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714319024; c=relaxed/simple;
	bh=Jc9hxCsTuRCuhN9FbsFCtUu6V07pGh5HyxRYkBqVg5I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4Fy2wnMzuaWSWRxv/VDxt+Uf3riFy4ghsM+W6RQrIS0qVtfesAyE7W8cMrgFA+bXjl3iMDxMV5kRTv6j6KCuSaP9b6myv8WCJ6LLQvOo000r8Wi7kwas+GxtRuP1bA0tiF/K7g9AJh1nqgoIRmp6qTO7xU500GRMUi2u9QP2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7C82mvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A22C113CC;
	Sun, 28 Apr 2024 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714319024;
	bh=Jc9hxCsTuRCuhN9FbsFCtUu6V07pGh5HyxRYkBqVg5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K7C82mvshYb1ZO49gJgloaPenU7sUujp1dfX7pEYvrp0dqYf008VkZlsgiKU3LFMI
	 k9qyLgUwtzPFVolUymztFi6rZeSEgBy5AIXNsBJv4p3eEmVch8ASklG5+keKA2ZEoG
	 qKVDfJLrTuSMEWZEvH1tGyndTe2OtxY0q94HWhXQwnX/uJ9sPRkRhsfZ2dsBKLHT4/
	 tEgroJbvYeVpyzL+QAdEVrRdmnEnQ7OuqN04QoKCjR5rk46xA0enTBHkHWchoCDZnd
	 wQ6gtuwrpnHCBAm77ZYAiKHXw+kP6pVGjUo4+7RjlCVoq6Sr4qvgo19P8UUavqwzM8
	 oedxQUCMJIliw==
Date: Sun, 28 Apr 2024 16:43:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Martijn Braam <martijn@brixit.nl>
Subject: Re: [PATCH v1 1/1] iio: light: stk3310: Drop most likely fake ACPI
 ID
Message-ID: <20240428164333.44a7f8f3@jic23-huawei>
In-Reply-To: <ZiZEqDCqc01Cx3oq@smile.fi.intel.com>
References: <20240415141852.853490-1-andriy.shevchenko@linux.intel.com>
	<20240420122633.79b4185b@jic23-huawei>
	<ZiZEN807oywU-MAx@smile.fi.intel.com>
	<ZiZEqDCqc01Cx3oq@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Apr 2024 14:06:16 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Apr 22, 2024 at 02:04:23PM +0300, Andy Shevchenko wrote:
> > On Sat, Apr 20, 2024 at 12:26:33PM +0100, Jonathan Cameron wrote:  
> > > On Mon, 15 Apr 2024 17:18:52 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >   
> > > > The commit in question does not proove that ACPI ID exists.
> > > > Quite likely it was a cargo cult addition while doint that
> > > > for DT-based enumeration.  Drop most likely fake ACPI ID.
> > > > 
> > > > Googling for STK3335 gives no useful results in regard to DSDT.
> > > > 
> > > > Fixes: 677f16813a92 ("iio: light: stk3310: Add support for stk3335")
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > > Hi Andy,
> > > 
> > > It's been there quite a while (5 years) so whilst I agree it should
> > > never have gone in without a known DSDT in the wild, I'm not sure we
> > > should remove it at this point.
> > > 
> > > Definitely not with a fixes tag as I don't want to see this picked up
> > > for stable and breaking some old consumer device we don't know about.
> > > 
> > > If there is a good maintenance reason to scrap these I'm in favour,
> > > but if it's just tidying up errors from the past that have no
> > > real impact then I'm not so sure.
> > > 
> > > Maybe we need a 'deprecated' marking for acpi ids that always prints
> > > a message telling people not to make them up.  Mind you what would that
> > > do beyond make us feel better?  
> > 
> > I prefer to find the actual users by removing these IDs. It's the best approach
> > to limiting the presence of wrong ID in time and at the same time harvesting
> > the actual (ab)users of it. Warning or other "soft" approaches makes rottening
> > just longer and _increases_ the chance of mis-use/abuse of these fake IDs.
> > 
> > I understand your position as a maintainer who can be blamed by mere user in
> > case we are (I am) mistaken, but I consider it the least harm than by
> > continuing "supporting" them. Feel free to NAK this patch, but for the record
> > I won't like this :-)
> > 
> > TL;DR: I do not buy 5 / 10 / etc years in the Linux kernel as an argument,
> > sorry.  
> 
> P.S>  
> What I may agree on is to drop Fixes tag.
> 
That's a compromise I'm fine with. As long as we've done due diligence on
whether there are known cases we can take the risk of breaking someone (briefly)
if these turn out to be in use.


Applied,



