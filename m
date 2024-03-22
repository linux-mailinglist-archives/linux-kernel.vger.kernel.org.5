Return-Path: <linux-kernel+bounces-110862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EF48864E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13006B228B0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F6823AD;
	Fri, 22 Mar 2024 01:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuYk7s2U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5F65C;
	Fri, 22 Mar 2024 01:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711072113; cv=none; b=misYYZLdtM5Jo7wnqv6xnEnH+ip8bKXUX1RFanYZnJUsRuoOt4YAalJ+fMIphcjtqWBILQcS/Up0MDsN00t01EowlgUTeL87M+V4Vs+ELuu8YF/JepvcGDq/X7JjJ0M12laSKlKYTBL5MZBfz3ztEFm6X2xuG1lSbRHVRkGyzoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711072113; c=relaxed/simple;
	bh=xEs+nxPabscqfZYnqP1XSpV1Ny+o8wv2NPvfwWpfoJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKfqR6jzs/NkuNmuPqQjP0+YSiAzDF5kxUDFqWcpE2d8aEo7PGIUYzpgBVfJpxsFoZn6cvLBbgEIccHw7VXKUpKGsmIyLQWKJsvqpjv9lmR7/MiV/KCLkqrln4I2t8+iuaEomyVJmLRxIfb3s8hPfNicod40/648teEL+o1sX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuYk7s2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC36C43390;
	Fri, 22 Mar 2024 01:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711072110;
	bh=xEs+nxPabscqfZYnqP1XSpV1Ny+o8wv2NPvfwWpfoJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SuYk7s2UjAWtsP6/F+h81BmUN58VCzNgEdB/VXdXyezkhoLn6Lqz+ITt0UJdCIcfc
	 MiXw6aa2rxAKAjEikmm/XzpOegE/dWexDUa7SrwVZVVEyfwTMPigrjfeLC+u/6G91E
	 jBraP1oU9V17rWifPfU6wXvsHCGENphUzV0qbInwg+d38pnyh8NBpVfuXFxZsbYLhF
	 yJzOiZWaMrBi0k7B5AA+IfOfUa1BN4GJYeg7J0M0hUJoS4m5WR9ZgGj8++Y8oYmU+y
	 tyBk7Yb4Q0wEoxrpcBbdi+zKXgP3dg6BFGK8x57EMhjLsLiEMhWO6yq8+Aas3hui6I
	 m+Va6UdQhsoPw==
Date: Thu, 21 Mar 2024 18:48:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, <kernel-janitors@vger.kernel.org>,
 <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, David Laight <David.Laight@aculab.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jiri Pirko <jiri@resnulli.us>, "Jonathan Cameron"
 <jic23@kernel.org>, Kees Cook <keescook@chromium.org>, Lukasz Czapnik
 <lukasz.czapnik@intel.com>, Paolo Abeni <pabeni@redhat.com>, "Pucha
 Himasekhar Reddy" <himasekharx.reddy.pucha@intel.com>, Dan Williams
 <dan.j.williams@intel.com>
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
Message-ID: <20240321184828.3e22c698@kernel.org>
In-Reply-To: <b9dc2c7a-2688-4a7b-8482-1e762c39449c@intel.com>
References: <e5172afb-427b-423e-877a-10352cf4a007@web.de>
	<F2FBADE8-EDF9-4987-A97B-CF4D2D1452E0@inria.fr>
	<b9dc2c7a-2688-4a7b-8482-1e762c39449c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Mar 2024 15:27:47 -0700 Jesse Brandeburg wrote:
> The gist of it is that we should instead be using inline declarations,=20
> which I also agree is a reasonable style for this. It more clearly shows=
=20
> the __free(kfree) and the allocation (kzalloc, kcalloc, etc) on the same=
=20
> (or virtually the same) line of code.
>=20
> I'm curious if Jakub would dislike this less? Accept?

At present I find this construct unreadable.
I may get used to it, hard to say.

Also I don't see the benefit of the auto-freeing construct,
I'd venture a guess that all the bugs it may prevent would
have been caught by smatch. But I'm an old curmudgeon stuck
in my ways. Feel free to experiment in Intel drivers, and we'll
see how it works out =F0=9F=A4=B7=EF=B8=8F

