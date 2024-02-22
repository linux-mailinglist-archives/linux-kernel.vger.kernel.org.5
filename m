Return-Path: <linux-kernel+bounces-76720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7461B85FB81
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD571F2211F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17670148313;
	Thu, 22 Feb 2024 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T8/cdYtM"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39863DB9A;
	Thu, 22 Feb 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613091; cv=none; b=lq7Q4B8xuRMt2L3Z9bIwjpKvERwog0zUWj9yTW55ZXlyDHL8zuZW2cwqmMneermy/eZPYZXdddx8wHmgDHIsTnaiavi66Tto32LOIkO+G7MF9V4UMmJw87G7GJHypU7TZ84gi1FXyS0i4G6/Vj8wJPnPRWfhtEIl3fwKdfFnA40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613091; c=relaxed/simple;
	bh=FzE/fBdYuA85BtFDd1++ZSMm7MtcnuXSFkSaq0BKaBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oej08aWtDLHjnPY21Kz1zLnSTlsf0Q7PTgWaFgHDnSlHwRe3ZLFHc55fG84ipaMaMCx8xQlCn2aca6l/9+f78Wus358PVPQMIr7SEMorTbDGoRq+CdTP2HUSxnKWvE0cAehr4ftZnhpYQp0EWk24fABAyJ83kGj3Wo66Dqu3CsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T8/cdYtM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VbAxBwbjGLI4wU8LwT7+5yLezMXg9qM4ehC9Ieptg5E=; b=T8/cdYtMn9VEuCOp4VqHtoCvT9
	hfuTR5MIkJUrzpzi6md6Tqc9Oz8tg9ZheNk3zLnFv+ZuyrcgBQjZSQRtLKEAqcdEckdulWMP6/tvm
	hMPpTVmGAFFRTTWRKJSpAcmYLDx5EOd1wohrcd4onplhptCYpzBO+Sa6Ob7Idz0skHbU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rdAJh-008RyR-U9; Thu, 22 Feb 2024 15:44:53 +0100
Date: Thu, 22 Feb 2024 15:44:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"sre@kernel.org" <sre@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] power: reset: restart-poweroff: convert to module
Message-ID: <c9a36d9f-27c2-402a-9c19-77c22dac4859@lunn.ch>
References: <20240221174610.3560775-1-alexander.sverdlin@siemens.com>
 <6964c19f-6ffb-4d9a-bc02-ffaf52aa23b5@lunn.ch>
 <35e30e3260f6669b28dcdde6ea58f480eac3db91.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35e30e3260f6669b28dcdde6ea58f480eac3db91.camel@siemens.com>

> I also didn't understand what is so special about bootloader support
> for this functionality if no data is passed to the bootloader.
> After ARM-specifics was removed from the code quite some time ago
> any platform could re-use the code for the deployments which meant
> to be "always on".

If i'm remembering correctly....

When the box cold boots, the bootloader can see the boot reason, and
chains into Linux. When the user does a shutdown, we re-enter the
bootloader, and it sees it is a warm boot. It then spins, rather than
chaining into Linux. The process of getting into the bootloader, a
watchdog triggered reset, probably disables a lot of clocks and other
bits of hardware, so spinning in the bootloader consumes less power
than if Linux was to spin.

So bootloader needs this functionality, to either chain, or to spin.

   Andrew

