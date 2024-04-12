Return-Path: <linux-kernel+bounces-141835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038E08A2417
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F491C22042
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491BF14006;
	Fri, 12 Apr 2024 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMpeuc2J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC712E47;
	Fri, 12 Apr 2024 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890789; cv=none; b=ZHFlK7D8klSNw7w5ICborAP6kM0+7BFRT4jm3mzcLPE/qFuVN4argTYk4gQ5eaHUur4iSGVQnDVK7wckqwC2523o+lCQtb57hgQThlVRXEyIaWDSlXvMAH32fg+YreRfrsHwCJ+QeQn9PWkIeVWTrqvOhGv/ZHGYSN+bXtoV1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890789; c=relaxed/simple;
	bh=CFZaFCrJieMfmiSIS7l4iilS77dVFCNCF7uZCA3nIgA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dtjgyntogtsci2go2FmugK+W6dEq/UkwGBYydo2Y4FJyWEM+lHhHvws1k8qqibSdSULph1C8jUelP8c2EzD5gXVQFGH7+kgzC4rzuJzuPKzqSwS01oPQuWU4HJZs7I+91+foOyp9kiKFUMrKMkGYUSzsxtTQiQwb33WOWiu4iRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMpeuc2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1624C072AA;
	Fri, 12 Apr 2024 02:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712890789;
	bh=CFZaFCrJieMfmiSIS7l4iilS77dVFCNCF7uZCA3nIgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lMpeuc2JQPTZiBO9qPCoSE6ZmTVuDm0pxFg/viacar5nFMKWj56IfYQ1zrprahMpi
	 /PkZdxBkgOqY4RkQHwg0z2b1s9NGtCqWVZV5o8gksVLY2g8m4kRiTJjnnWz2IrJaeA
	 GZDfCrubo2R9UA75u+RSnqI+nSi2CgW4GxcbT4N8Rxy9v0fLMpy1KkKUoa/r35C5OB
	 PQ7YMKIL+7JX32FP1WSqGnR3sR6qXBjD3ebyMk1N34TsEQZ6yYUvPWmipCVUY5nhK4
	 /pDKicZOmWVJn+hpRPMvGzW9S11HDIrorEs6wcdruL9Qx/7XaIy9bXhl/+YeXtgWCy
	 r8T4yEuFz1elw==
Date: Thu, 11 Apr 2024 19:59:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suman Ghosh <sumang@marvell.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>
Cc: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>
Subject: Re: [PATCH net] octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT
 implementation
Message-ID: <20240411195947.54e9cebc@kernel.org>
In-Reply-To: <20240410134303.21560-1-ast@fiberby.net>
References: <20240410134303.21560-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Apr 2024 13:43:01 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Upon reviewing the flower control flags handling in
> this driver, I notice that the key wasn't being used,
> only the mask.
>=20
> Ie. `tc flower ... ip_flags nofrag` was hardware
> offloaded as `... ip_flags frag`.
>=20
> Only compile tested, no access to HW.
>=20
> Fixes: c672e3727989 ("octeontx2-pf: Add support to filter packet based on=
 IP fragment")
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Marvell folks, please provide timely review.
It is your duty as documented in
Documentation/maintainer/feature-and-driver-maintainers.rst

