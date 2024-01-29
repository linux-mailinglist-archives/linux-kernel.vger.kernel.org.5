Return-Path: <linux-kernel+bounces-43536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3898841540
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85C3EB23954
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE50E158D87;
	Mon, 29 Jan 2024 21:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fVcN8qVi"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91AE657C7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706565106; cv=none; b=fTTpvjYzXzwi+jR6YSU1WDp7XDznBZkoPeTIkgCdGaJ/eEQ90oQ031dw7bQg45Ru5zSlAjXh3GcHqR1o48+8puZu7F+t+u/qp7cCzkj51hIH4TCwYRQdxatStfuVk6OwlkRCeyJTM4qx4SG2TKdWIx/2P3YlcMcM3z9nGi96Hx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706565106; c=relaxed/simple;
	bh=fckrnZTsRJZ5DuCkaRp8IJe1DM/0YVZkOrx9pNArYXk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IBRLYfbqtz8Bo9Bx2F53tJYa/szz6qHXJvdu8JhZKCTjmGsnZh+b0skQIzhM5P//zOZDYwor/zCK10Cv8+9e8YQEvWT+sn0C0Qwst2j4WYXmIlDFchTiDlnvXg7AGyiytmEPX2dmfwoqIvCuf0sTTzH+iLQ2A9GZBponT6RZ7OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fVcN8qVi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Tfd5xTsJcQukGIPq2o4aDW4fPhnhHq2OexIddMEq6LQ=;
	t=1706565103; x=1707774703; b=fVcN8qViaQNRsVmJXSmhDGdjaR3JjqV/2a0yRg85v/C1KXA
	l80SFm4Xm8qN/zFr+tN5h6+hB00DbYj/ijQaX+16aKcX2i8vdeZUh/s93KI0DQXZxwJKfEu5+tfFg
	SQk655X4EEsBQ8KThIbmoaINsHPg6S5hAn77jmhmk6AeoyJu6TM5WxXN9xegRnNcB9dh9r2ra1g75
	g0FHDEt7zywCBfoSB3K5p9YK5TRctqEwWZe3VkBr4tC0XOE/RCoOXLOU9WVkYTcvZENDNarfuFvMp
	0v8U2pQElDE12pDfZeh8+SQX6D28/fgNl9CVxt9axNjdnqMWnzSMtA1grDIcGX2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUZXY-000000054r7-1INa;
	Mon, 29 Jan 2024 22:51:40 +0100
Message-ID: <33df6c78c4c47a8f57a1c2bfe835065becb5a253.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] devcoredump: Remove devcoredump device if failing
 device is gone
From: Johannes Berg <johannes@sipsolutions.net>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: linux-kernel@vger.kernel.org, Jose Souza <jose.souza@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J . Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jan 2024 22:51:39 +0100
In-Reply-To: <ZbgYyra1Ypa0nf6u@intel.com>
References: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
	 <d57dc34fa8b0e25cec014b8001dcd0527d1c1013.camel@sipsolutions.net>
	 <ZbgYyra1Ypa0nf6u@intel.com>
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

On Mon, 2024-01-29 at 16:29 -0500, Rodrigo Vivi wrote:
> >=20
> > > On top of that, for PCI devices, the unbind of the device will
> > > call the pci .remove void function, that cannot fail. At that
> > > time, our device is pretty much gone, but the read and free
> > > functions are alive trough the devcoredump device and they
> >                       ^ through, I guess
> >=20
> > > can get some NULL dereferences or use after free.
> >=20
> > Not sure I understand this part, how's this related to PCI's .remove?
>=20
> Well, this is my secondary concern that the idea of the link_auto_removal
> doesn't cover.
>=20
> If the failing_device is gone, the 'data cookie' it used to register with
> dev_coredumpm(... void *data,...), is also likely gone on a clean removal=
.

That's on the user. You'll always be able to shoot yourself in the foot.

> And to be honest, we shouldn't even count that the registered *read()
> function pointer is valid anymore.

That's not true: the module cannot be removed, there's a reference to it
if you're using dev_coredumpm() correctly (which is to say: pass
THIS_MODULE to the struct module *owner argument).

> Well, we could indeed. And that would unblock our CI, but I'm afraid
> it wouldn't protect the final user from bad memory access on a direct
> $ cat /sys/class/devcoredump/devcd<n>/data
>=20
> Shouldn't we consider this critical itself to justify this entirely
> removal?

No? IMHO that's totally on the user. If you absolutely cannot make a
standalone dump 'data' pointer (why not?! you can always stick the
actual data into a vmalloc chunk and use dev_coredumpv()?) then maybe we
can offer ways of removing it when you need to? But I'd rather not, it
feels weird to have a need for it.

johannes

