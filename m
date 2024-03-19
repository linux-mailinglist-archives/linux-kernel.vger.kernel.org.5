Return-Path: <linux-kernel+bounces-108004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FDB8804B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E39CB23233
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8AC2E62B;
	Tue, 19 Mar 2024 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfj7fYwt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7CB2D057;
	Tue, 19 Mar 2024 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872575; cv=none; b=K6isjFeKEBlETcfjTklpECOrSczm3RSoeOWeUR8KinWb0cH/wWuE6ROd/M92PR17Oqb/ePYP+uU1dGaDWx73S/6aqZrrwcxBrdKzlVh1f/NE69WexdsVxSOUDhbocP4/oEKSC8YStCZiwLSM0AVBFobc2VKwPwiNiJ1IX4TRWBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872575; c=relaxed/simple;
	bh=juBnuniA9yajO1DOk7FH88boKK9ZBvrpw9aQ3lq3Qu8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JWWpzheGlD7tHLzK0JltWVjJ59jAa0ABFEdtenMDOhutEwDEnFauMjvdrth8dOjD//mY7etGpSieJltNA0Vm/40CDR2IR6qM5Zw2CNdxpgprAdH9xpRd6cW8CX4a+x72EaOMdBwsdZubmPeGaNKLxwfLMe6UoReKuXuTa0qzc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfj7fYwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1836C433C7;
	Tue, 19 Mar 2024 18:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710872574;
	bh=juBnuniA9yajO1DOk7FH88boKK9ZBvrpw9aQ3lq3Qu8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=rfj7fYwtzJbablHoWtMImT8M6gZDPiGDvqign+J4OFXuqEbP8Ml6RZk/WetNVvbpm
	 ofyhYvospIqLGTBSFz9AsatvqH+26M6ApJq2XwEDttcfGSrstK9FOoL4NwgkSw3DvV
	 5zchzz6monwJxPCVm8/jBUkgR0ijWxiF5VvaeZWJdJehyunopwOE+bQhD5pRYWiHhk
	 E3qm8NgYYmuecnvD3VbM//a208IE8RtJJqwGmGia1XU2I+J7CreVC+6WQaTdewIZyf
	 BLsN8sQZZk6P0VVl38wcrk/uxyrSjImi5PKFtfoGM21j9jFKmS0fItIQ11VXYMKQ9+
	 6oYI0MOvtODxA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Mar 2024 20:22:51 +0200
Message-Id: <CZXXPKTAUUM9.35VZUFITJWF6A@kernel.org>
Cc: <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
 <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <bbhushan2@marvell.com>
Subject: Re: [PATCH v6 00/13] Add support for NIST P521 to ecdsa
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, "Lukas Wunner"
 <lukas@wunner.de>, "Stefan Berger" <stefanb@linux.vnet.ibm.com>
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <ZfiMhi9D2Rhh89BI@wunner.de>
 <d02eda40-2d3a-43a2-a3a9-cb79055acda7@linux.ibm.com>
In-Reply-To: <d02eda40-2d3a-43a2-a3a9-cb79055acda7@linux.ibm.com>

On Tue Mar 19, 2024 at 12:42 AM EET, Stefan Berger wrote:
>
>
> On 3/18/24 14:48, Lukas Wunner wrote:
> > On Tue, Mar 12, 2024 at 02:36:05PM -0400, Stefan Berger wrote:
> >> This series adds support for the NIST P521 curve to the ecdsa module
> >> to enable signature verification with it.
> >=20
> > v6 of this series is still
> >=20
> > Tested-by: Lukas Wunner <lukas@wunner.de>
>
> Thanks.

This has been discussed before in LKML but generally tested-by for
series does not have semantical meaning.

Please apply only for patches that were tested.

BR, Jarkko

