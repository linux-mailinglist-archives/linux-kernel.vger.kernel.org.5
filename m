Return-Path: <linux-kernel+bounces-156751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20018B07AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AD01F23725
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B4B1598EF;
	Wed, 24 Apr 2024 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmQj/zoo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482D215A480
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955872; cv=none; b=FNLmJ8L8KgR+rwwKAylsRqnylPkGj/AcyYNx5tav3KJu/F45eXpUqnSqnrdmetQlVrDnbf1ANDo5/DCFl5r0b2Xc83801XFXPdcFG2fJsZXm+T70SySlai9897tyHNrgCbazR0XLYWSg7i1Lr+R4tOk8W8CvgNSBPF1bKlr14Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955872; c=relaxed/simple;
	bh=obSGRI92SvTZ9PO94qPHWzuYNKWRL1pDAIG/iGUyOTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zeks9DuTrRS3Rq4rcXseQzqAfteLeapIHxfGiqrOpRWbJq3qklU/BnCSwPBSca9x7qmoiRyWDqoi615QqlhmLjVnckef6g21I0IMYkSDA8hrCORm8eBaklgZ+2sTRT/PsnrsKIal3RhJdqE292ib30zZFsS/coBSik1Rhxkq3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmQj/zoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FA2C2BD10;
	Wed, 24 Apr 2024 10:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713955871;
	bh=obSGRI92SvTZ9PO94qPHWzuYNKWRL1pDAIG/iGUyOTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmQj/zooWZ3PBfCr/1PBC1YPwq9c0rnN0W2XFl9j/zySAGvGQpdlq9r69sPyzHzYn
	 xlmKYW1J/nLcItRS5T8Xe1TPuP4PHkYQW9MPzvA5Llt6ZBDLxwxwEp26o7WNdrUI3c
	 oHmolzPn72EBmNKFsdU3v2+hfUxVJzNiE+SvMziHdVWOWP9bjC8GYl0CgDyHubp4ke
	 tojqxBdUeAIMQE2CowL6ilXQKFC4E9NL+53jt2KMfLn5HdOL7RT9d/v4YvgTbp4aGD
	 bT/xE6XjUMqOBYYqOZbe58ri4VvMKtF0B7gsAX+jZD9voORGTI6YYYDD9ujLARuUjg
	 yhUlSvLz2skZw==
Date: Wed, 24 Apr 2024 11:51:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] riscv: Use offset_in_page() in text patching
 functions
Message-ID: <20240424-unthread-pelican-93629280bf14@spud>
References: <20240327160520.791322-1-samuel.holland@sifive.com>
 <20240327160520.791322-7-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x/oSwXS7Hv3e0hQM"
Content-Disposition: inline
In-Reply-To: <20240327160520.791322-7-samuel.holland@sifive.com>


--x/oSwXS7Hv3e0hQM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2024 at 09:04:45AM -0700, Samuel Holland wrote:
> This is a bit easier to parse than the equivalent bit manipulation.

And it is used elsewhere in patch.c too, so makes things more consistent
to boot.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--x/oSwXS7Hv3e0hQM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZijkHAAKCRB4tDGHoIJi
0jqeAP9xB3Z24T1JfUA6sc27uXaYJ+OXu4Vo19lKXI8bvBIi+wD/ZuREtm4j6NZz
VPyLYewtekIG4sVePf3T4wcv4gmxkwM=
=YSu0
-----END PGP SIGNATURE-----

--x/oSwXS7Hv3e0hQM--

