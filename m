Return-Path: <linux-kernel+bounces-166736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847F78B9EB7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8EC61C23779
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF9716D4FC;
	Thu,  2 May 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxRP799+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7797E578;
	Thu,  2 May 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667826; cv=none; b=q2WIxJkPEG3qtjWOC/ODad9l26aUCvcUv9GX47L2quHk8VOjtdeDutwDyFOONbMomz3pQW5KgC6dv358N0Ftk9FYmojd1KUkbBgZ7qCGp6wU4nbAYsDHs5qiv1hSk1JhrTyffinSWJ5ita51S9jyADOXVTcIQcUou7CkyBjQzac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667826; c=relaxed/simple;
	bh=elIj2maOPCIQ9r6zUCBezHlRHkxdKHhoo2W0GlqZyBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6qTHzcWPUtNNNb6ojgUl2frqQOzPf7RRz5YuHYHy5Qqe/DXD3eCnaQEFX+azJxcJzdi/RqV0jzgEJJDhge4vYiu7iHzG3z/6qyUlvcy6HUu6ce+qRQ7P29yHyjj5KgDUnUNA+zcvGUqPVMwFPv/DgKqlG/ghjh1xxkfIoWjefw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxRP799+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D95DC4AF18;
	Thu,  2 May 2024 16:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714667825;
	bh=elIj2maOPCIQ9r6zUCBezHlRHkxdKHhoo2W0GlqZyBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxRP799+NKBOnBmJSVVkzJV2QPQxCkVIYNJcjkfAJ75fLz2G/4x69DOChbxxDKWu0
	 phwy483uBgXYWJ2E22vdf7f1iwHB799cpMVZmS7PJVmR3Z9Zm7SEKPh1aZYmCBcjxw
	 AoYPhvEL47d/IquhZvRLTpsWUxzgzjZYTG0XC5T7UEPncG37oy7HWEP8uXsv+QTVaq
	 qf8/7iUARN3BKNveOCo34fVoY/zqHyrN0J0yYiNIy4uxUEOMcdnCDiqCKe0dGIbBrn
	 j1rxYOE+TyDcrsUhK1wqTh1kCbY96IoasRh/WYKZNkxMrtg0LrKkF2q0Ih0OoZIDO6
	 4y9PT+rJxos9w==
Date: Thu, 2 May 2024 17:37:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, bhelgaas@google.com,
	james.morse@arm.com, jhugo@codeaurora.org, jeremy.linton@arm.com,
	john.garry@huawei.com, Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com, sudeep.holla@arm.com, tiantao6@huawei.com
Subject: Re: [PATCH v4 2/3] riscv: cacheinfo: initialize cacheinfo's level
 and type from ACPI PPTT
Message-ID: <20240502-herald-catty-a03eafc4e6b1@spud>
References: <20240418034330.84721-1-cuiyunhui@bytedance.com>
 <20240418034330.84721-2-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yO7HUsK9PhhdPt6D"
Content-Disposition: inline
In-Reply-To: <20240418034330.84721-2-cuiyunhui@bytedance.com>


--yO7HUsK9PhhdPt6D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 11:43:29AM +0800, Yunhui Cui wrote:
> Before cacheinfo can be built correctly, we need to initialize level
> and type. Since RSIC-V currently does not have a register group that
> describes cache-related attributes like ARM64, we cannot obtain them
> directly, so now we obtain cache leaves from the ACPI PPTT table
> (acpi_get_cache_info()) and set the cache type through split_levels.
>=20
> Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
: Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

I'm not an ACPI head, so whether or not the table is valid on RISC-V or
w/e I do not know, but the code here looks sane to me, so
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--yO7HUsK9PhhdPt6D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjPBLAAKCRB4tDGHoIJi
0u7BAQDbJjVUjdxBuIPXpCPVp0rGN0S1orbltdlb/onG2hq2YgD+PpvigMyAnAWw
3yi6hMJHbgpBnXDIv2UKS2a6xsBjxAI=
=LkPp
-----END PGP SIGNATURE-----

--yO7HUsK9PhhdPt6D--

