Return-Path: <linux-kernel+bounces-81034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA94866F46
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ECDB1C22FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BA74CB30;
	Mon, 26 Feb 2024 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXu9YeOJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AF4481AD;
	Mon, 26 Feb 2024 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939040; cv=none; b=JqmoZgZgfS+ixqVvLnpNo8QnpyOfk1wakUQAmhScPe1Ztg/BE726PS0jDynIp+9zRs80KRcMXiVRGRZwNKrjI6Zxx2zOFnJNHcF4CiuS0Kzgz9MZEjTOLjXAWj2UlHqe9aucCbengxkYHJk7wZ8xtUAy6BXdFY/8WofzYzL6NtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939040; c=relaxed/simple;
	bh=TDPshTEB2YgsSzMjFOliwieaa4N3m+QIe+o0VAqCL30=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=GAXBXatlOrAZXkL/tWrRUW82HMHz3nbagFVQPcsyirRRohAoU0d4FgoamT8AmCSuWvIkaodjKEWbIp7iMqVyn4QDdTkP9ACtUZwCk5EnuXxpYQMOwcHNvDtmwABMJ3xp08zDqIp/v/xlgCDW5DQFZHBzRl69gyv1ppLt/tdjDI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXu9YeOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB87C433F1;
	Mon, 26 Feb 2024 09:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708939040;
	bh=TDPshTEB2YgsSzMjFOliwieaa4N3m+QIe+o0VAqCL30=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=HXu9YeOJLt1Yvf8NXTZ1efm0443uX2U1V2DLHVLDjanw7eFOgW7x2+1m103AC/PZK
	 WXamFGx2xgSh7mVv/kXFnpgIE9Ch3mU5XP+4HQ02nLndcsNVMiSm9vuUANAHNQbjM7
	 aNRDSIORRFc3AdpzsAw+aQzpxyQzkjg/OuOEe2AicvH/xDk71DkEKXiNOEUtyGgcU2
	 5DpSDGRzkIpDdtqF7BzdhFkBJaizksaEHqsoj4PbPCeYLLJ31diCmfAV27euPJvF4M
	 hqsBUHxgrjvyCxzCRVR+V2KdU3tVlT26TPFhxLyoiAkCsMSOHhPibfQyZ7iWb69/lR
	 T8Taz6GzuK1OQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Feb 2024 11:17:11 +0200
Message-Id: <CZEWBSXM7LHU.15UW6P0T61VBN@suppilovahvero>
Subject: Re: [PATCH v5 0/6] DCP as trusted keys backend
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Richard Weinberger" <richard@sigma-star.at>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "James Bottomley" <jejb@linux.ibm.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 <upstream@sigma-star.at>, "David Howells" <dhowells@redhat.com>
Cc: "Shawn Guo" <shawnguo@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Sascha Hauer" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "NXP Linux
 Team" <linux-imx@nxp.com>, "Ahmad Fatoum" <a.fatoum@pengutronix.de>, "sigma
 star Kernel Team" <upstream+dcp@sigma-star.at>, "Li Yang"
 <leoyang.li@nxp.com>, "Paul Moore" <paul@paul-moore.com>, "James Morris"
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, "Tejun Heo" <tj@kernel.org>, "Steven Rostedt
 (Google)" <rostedt@goodmis.org>, <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "David Gstir"
 <david@sigma-star.at>
X-Mailer: aerc 0.15.2
References: <20231215110639.45522-1-david@sigma-star.at>
 <7AED262F-9387-446D-B11A-C549C02542F9@sigma-star.at>
 <47439997.XUcTiDjVJD@somecomputer> <1733761.uacIGzncQW@somecomputer>
In-Reply-To: <1733761.uacIGzncQW@somecomputer>

On Mon Feb 26, 2024 at 12:20 AM EET, Richard Weinberger wrote:
> Mimi, James, Jarkko, David,
>
> you remained silent for a whole release cycle.
> Is there anything we can do to get this forward?
>
> Thanks,
> //richard

Thanks for reminding.

From my side, I've had pretty busy month as I've adapted to a new work
project: https://sochub.fi/

I exported the thread [1] and will look into it within this or next week
in detail (thus the large'ish time window).

[1] https://lore.kernel.org/linux-integrity/1733761.uacIGzncQW@somecomputer=
/t.mbox.gz

BR, Jarkko

