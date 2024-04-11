Return-Path: <linux-kernel+bounces-140451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CBB8A14D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6321F23BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2849D383A5;
	Thu, 11 Apr 2024 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GQceUHJq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0EE1E516;
	Thu, 11 Apr 2024 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839354; cv=none; b=Iwf54MilFVDD/A9S2KpR0rS+VfZgumTqCNtIJdrJPrUmdL5kMTT4Hv6ZxL6f8qeyMXGrGYUpfY/c30VsnGc6CraQo+KYyldRNwbwkaC+4jbRNICt4OxUfIRpv8foUC7cJRzZeYadxkEGszOsvOIiUn0gr4RlarXL6a5OiG8LRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839354; c=relaxed/simple;
	bh=WSM6gnND1FVp3qPuNl33Edn2hp3BLAP7Hq+mlVeX2LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JysK6LwFW4ChY2IUA40+6o9xYXrrRxnjD68XpxA40mbz2s576UKDUp+WSfyY4QRhCfvPFlYsiketqUiutdegnSaolzMAfqVmKoxOFneteVkd0dRYC3FD9baHOEDsVmSYqdCqthpkqCS6ZNShs0foCjeKbbtf89jvF/yIy8fYbmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GQceUHJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE52C43390;
	Thu, 11 Apr 2024 12:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712839353;
	bh=WSM6gnND1FVp3qPuNl33Edn2hp3BLAP7Hq+mlVeX2LM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQceUHJqIZnw2nnOrTYt2hTP25pAEjigLaTKWTMmkNTEqckWgj0lkXYEokZYXg9X2
	 mLE20L/sgv79uQ5BgsiVzcUC8uHtlHW3Zg0UT+sg7V230+yB5BQFZoTBSYefxKWuq4
	 Vj6Tgg55ExqMwyS7SojwElrWgNIN2rSOsidBWTk8=
Date: Thu, 11 Apr 2024 14:42:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-modules@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v4] module: don't ignore sysfs_create_link() failures
Message-ID: <2024041121-dab-battalion-e3e1@gregkh>
References: <20240408080616.3911573-1-arnd@kernel.org>
 <ZhQUhvSCpz48f6tw@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhQUhvSCpz48f6tw@bombadil.infradead.org>

On Mon, Apr 08, 2024 at 09:00:06AM -0700, Luis Chamberlain wrote:
> On Mon, Apr 08, 2024 at 10:05:58AM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The sysfs_create_link() return code is marked as __must_check, but the
> > module_add_driver() function tries hard to not care, by assigning the
> > return code to a variable. When building with 'make W=1', gcc still
> > warns because this variable is only assigned but not used:
> > 
> > drivers/base/module.c: In function 'module_add_driver':
> > drivers/base/module.c:36:6: warning: variable 'no_warn' set but not used [-Wunused-but-set-variable]
> > 
> > Rework the code to properly unwind and return the error code to the
> > caller. My reading of the original code was that it tries to
> > not fail when the links already exist, so keep ignoring -EEXIST
> > errors.
> > 
> > Fixes: e17e0f51aeea ("Driver core: show drivers in /sys/module/")
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Oh right, I should apply this, sorry about that, will go do that now...

