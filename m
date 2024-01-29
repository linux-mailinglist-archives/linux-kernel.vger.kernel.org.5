Return-Path: <linux-kernel+bounces-43236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E35841147
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2AA1F29683
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676633F9D7;
	Mon, 29 Jan 2024 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AgG6AqIp"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5599976C8D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550500; cv=none; b=jkUZ/392wyi0WscgCzIDhYvuHgk83viKt3joO0PNI6HKf7t511tIDkgIQkFfxJGWRJjubYZ/EyH6prUIyrNZX4gD58Dzcuf4Om9/8J3BqcCfpY4y42WisGvcOoWB/k6LUeTpdeidyNufw+vy75fcZcmjVDr0sFLufauaA1cJexQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550500; c=relaxed/simple;
	bh=1OKdWWjsPuvXhemAMkjEw2hVw/EmzYYEOFN9BXfMKek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HI8uZ+m1eL2G42CyrITAKfj8+bgW/q2HIqSFXWhzbO9Vuxmn0GRdoaF6mGM1Kc0fwf7JThWnWv6h3VDjimoSdKPIO73QVKz3AJDrmLO/17sfPViNNv8/RgsDN3Rgv7R4M5/n7CKtvTCZXG9uGVvt6xYMBKym2Cw3D5xCqcpOQcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AgG6AqIp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tdBQCntCln6YjRTWw9J7laZp2yLZK0JmRkee2IDva5c=;
	t=1706550498; x=1707760098; b=AgG6AqIpvjZwER7KBEdt29px52ZsMdt2536oSRPKJkjTXcU
	LMw9ngBsApOoOcWGOIiIn4dJrMhlhgSxpEbbD133zmdi4GF6DwRj0fvkRH0BlThtsMvD102qntAmn
	6UiPUyR9Cvh3HYSBkHuRxIDbaYdXPR7KrVQIgYk4u4nxnSjamHj592uxs6P24Ptb/yWygdWD9mIZE
	7Ra0ahmF038h/BFDKRf/wj7WcjGP6GNxc8mtYWzO0dYv8LatGMw3vKeJLpyzgFhwayIY3fB6CjqHj
	sTa+tbODMfhfN152vRMUB3zHrAd1uEUJ97ce9ibOvv7Bcs9uO+oAcDmeBuFEHf5Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUVjx-00000004xoN-2z6f;
	Mon, 29 Jan 2024 18:48:13 +0100
Message-ID: <d57dc34fa8b0e25cec014b8001dcd0527d1c1013.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] devcoredump: Remove devcoredump device if failing
 device is gone
From: Johannes Berg <johannes@sipsolutions.net>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-kernel@vger.kernel.org
Cc: Jose Souza <jose.souza@intel.com>, Maarten Lankhorst
	 <maarten.lankhorst@linux.intel.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jan 2024 18:48:12 +0100
In-Reply-To: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
References: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-01-26 at 10:11 -0500, Rodrigo Vivi wrote:
> Make dev_coredumpm a real device managed helper, that not only
> frees the device after a scheduled delay (DEVCD_TIMEOUT), but
> also when the failing/crashed device is gone.
>=20
> The module remove for the drivers using devcoredump are currently
> broken if attempted between the crash and the DEVCD_TIMEOUT, since
> the symbolic sysfs link won't be deleted.

Hmm, is it a problem to remove a whole dev when it still has some link
here? Maybe we could just make the link be managed/auto-removed?

Probably regardless of that you should change the comment in
devcd_dev_release() since it's no longer a concern?

> On top of that, for PCI devices, the unbind of the device will
> call the pci .remove void function, that cannot fail. At that
> time, our device is pretty much gone, but the read and free
> functions are alive trough the devcoredump device and they
                      ^ through, I guess

> can get some NULL dereferences or use after free.

Not sure I understand this part, how's this related to PCI's .remove?

> So, if the failing-device is gone let's also request for the
> devcoredump-device removal using the same mod_delayed_work
> as when writing anything through data. The flush cannot be
> used since it is synchronous and the devcd would be surely
> gone right before the mutex_unlock on the next line.

Can we just decouple it instead and remove the symlink? Which is kind of
what the comment in devcd_dev_release() says but at the time I wasn't
aware of all the devm mechanics etc.

I'm thinking this might be annoying in certain recovery cases, e.g.
iwlwifi uses this but may sometimes unbind/rebind itself to recover from
certain errors, and that'd make the FW dumps disappear.

johannes

