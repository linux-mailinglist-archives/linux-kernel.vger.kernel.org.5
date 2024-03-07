Return-Path: <linux-kernel+bounces-96264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF4C875976
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49317287E67
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988E713B797;
	Thu,  7 Mar 2024 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EFElUopV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE780634E4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847570; cv=none; b=V2oJaEGBR7uCnYnfU8nVB3SsY24PErhZ1XjBD4dT1+mzhkj3uO9/A3S3Uw3qYVOvjYWHm+qwjvYjLSbZ1QiPxAF6Tc8NNmNlMgEMxVIaUmujvIJVIp6SfZHp93qSYtST71OquNpHDBPIX1Ep00wOyKGtRVZrW5FTdTB9HfwQaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847570; c=relaxed/simple;
	bh=ZpdiJ/sHAU7UYJfeL4YOTYjxPWde8J9YeLVF9YbExFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Phj2SA6/nVi/Dvni+1LYYmWy2qCoZhYIz3JUelbpyZXJlgkMCysuicF5Nu908nmicONP64NImQU5723CGlKwgnnhLTJfMDjhgBhBol/DGOl23CI5NJocYEDYL22dcUC6ccdU6p0AyL1K1q6XhsPUeRUmBsSqG7rKDvm8gKat4r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EFElUopV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92A9C433F1;
	Thu,  7 Mar 2024 21:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709847570;
	bh=ZpdiJ/sHAU7UYJfeL4YOTYjxPWde8J9YeLVF9YbExFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFElUopVweKc9y+fagcMEr553mKX7cx26sPzJzpulDVemWcjZJ83VqbCwwm2ByNII
	 NWufjEE0ZZZASBQAtxPbdbYnR4dXDn8RVT0m14xq7uut6BatBR0q8+or3SJp7Dz9LJ
	 8U0cYoBwzk3n1z6kYJEw9/OEWrKonFIBGLMRhiog=
Date: Thu, 7 Mar 2024 21:39:27 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, javier@dowhile0.org,
	Andrew Halaney <ahalaney@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] driver core: Don't set a deferred probe timeout if
 modules are disabled
Message-ID: <2024030722-explicit-juror-9ba7@gregkh>
References: <20240227231001.648698-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227231001.648698-1-javierm@redhat.com>

On Wed, Feb 28, 2024 at 12:09:02AM +0100, Javier Martinez Canillas wrote:
> There is no point to schedule the workqueue to timeout the deferred probe,
> if all the initcalls are done and modules are not enabled. The default for
> this case is already 0 but can be overridden by the deferred_probe_timeout
> parameter. Let's just skip this and avoid queuing work that is not needed.

As the option is already there to set the timeout to 0, why confuse
things by trying to tie this to if modules are enabled or not?  And even
if you do want to do that, where did you now document this new system
behavior?

thanks,

greg k-h

