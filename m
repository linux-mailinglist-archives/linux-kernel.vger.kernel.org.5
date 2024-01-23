Return-Path: <linux-kernel+bounces-35598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB53D8393D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C20F1C27362
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5C76086F;
	Tue, 23 Jan 2024 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faCoNNLB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754850A61;
	Tue, 23 Jan 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025242; cv=none; b=ld/RgPhxzLJSlHdEil74kvVdBPHulDlaXzGOS2/TMux5SA7lMvRB3IEUqP7w2Wq4Old9NKTIBEtXoV0UBembWAZfJtrT1i9Jw4tRQLWcvWP1KH6vSIVxpAZOi8Sob/ez7sxWdPPM9e5S9mzaJqusJLli1WBHKLmZiJLm86w4VEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025242; c=relaxed/simple;
	bh=MHunYJlSW0xkpBskC5UuarTnjKz+9CaefumWRC8LlQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOIdKttG70zaJa4EeNcsZYsRMPnO3nNui+1EMHt8q8lLsX0xgtQXuwEg+8vuVFC6fgJkZXRm+KDiNGjTgnfjzvf29Bhi3uWAOWtYU/CROQBi/0+MyMRHGuiuH1sxcinSl3JF1oV9nLSguDvmHZ7q8LEkjjbs+cjbOyRsWVz3mEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faCoNNLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10C8C433C7;
	Tue, 23 Jan 2024 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706025241;
	bh=MHunYJlSW0xkpBskC5UuarTnjKz+9CaefumWRC8LlQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=faCoNNLBFV5XfXtR+8ZOEu/t+q8LVdInwpjQ39aqoyj9O4YRDBWSl2269MfaUqbRm
	 smCSJBa/YZOgRaDlR3XsV0VZUxmeDAdjeR8ZC060toABprkH0AqQlHyLIbO6KVWNJD
	 5+lPEBY2kemrCcz2FostODercaQr23BVNACUQZ+nEpzsoZshGIGxablCGuAQU098vM
	 zkYcrRFVkzAl/vrgjWbFXVjPkdN8YNOIffLpEwZ+gS+3vN2VTz1gzxIDKpodu22/1K
	 ZzO2glca/9BvqCkZwtrRbPhQY9KCoysUEAtbLyEOhDYIDxHXxONDr3QZ2wfGfYIlCz
	 r0BI5DiKLYjFQ==
Date: Tue, 23 Jan 2024 07:53:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sdf@google.com"
 <sdf@google.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
 "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
 "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
 "paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, mlxsw <mlxsw@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [RFC PATCH net-next 3/9] ethtool: Add an interface for flashing
 transceiver modules' firmware
Message-ID: <20240123075359.4c502c79@kernel.org>
In-Reply-To: <DM6PR12MB4516C97E6EC715DB78466FD3D8742@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
	<20240122084530.32451-4-danieller@nvidia.com>
	<20240122205046.5bb0ffe7@kernel.org>
	<DM6PR12MB4516C97E6EC715DB78466FD3D8742@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2024 13:34:18 +0000 Danielle Ratson wrote:
> > > +The firmware update process can take several minutes to complete.
> > > +Therefore, during the update process notifications are emitted from
> > > +the kernel to user space updating it about the status and progress. =
=20
> >=20
> > We should state more explicitly that the op just starts the process, an=
d does
> > not block. Looks like cable test already uses _ACT as a suffix, is it b=
ased on
> > some standard? Doesn't seem all that intuitive to me (or at least less =
intuitive
> > than calling it _START...) =20
>=20
> From Documentation/networking/ethtool-netlink.rst:
> "
> List of message types
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> All constants identifying message types use ``ETHTOOL_CMD_`` prefix and s=
uffix
> according to message purpose:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> ``_GET``          userspace request to retrieve data
> ``_SET``          userspace request to set data
> ``_ACT``          userspace request to perform an action
> ``_GET_REPLY``    kernel reply to a ``GET`` request
> ``_SET_REPLY``    kernel reply to a ``SET`` request
> ``_ACT_REPLY``    kernel reply to an ``ACT`` request
> ``_NTF``          kernel notification
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> "
>=20
> So, it looks suitable to me.

True, didn't see that. It's fine as a distinction of "doing something"
vs "setting configuration" but it doesn't express the fact that the
action is async. AFAIU cable test is also async, so that's fine.
We'll worry about it when some tries to add _ACT which isn't async.. =F0=9F=
=A4=B7=EF=B8=8F

