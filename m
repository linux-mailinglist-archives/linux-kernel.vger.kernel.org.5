Return-Path: <linux-kernel+bounces-84448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBD386A6DF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA96281263
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D6C20327;
	Wed, 28 Feb 2024 02:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEmXryY2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D27621342;
	Wed, 28 Feb 2024 02:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088419; cv=none; b=gJZ2CyZNTE/1GLwRJ3NSWM96CiONyx9xI8lyyr87NBdzN+s36FMWfFjjLP10j4R6GZayMaqpAcJwQlKnl9oluPexHTam9gmClEeh9LxOPAjRGEchK2MuKJYHadITdQ2yuFA+mOTimU6dY77EOYhHS2keWuvW4LZBs7s6UvIbaD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088419; c=relaxed/simple;
	bh=Tnku9fdfb4RAYA9RXtUVS6U+UK5al6iZT05jrsPWoS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6WJ4KELXAZx72l11XULB/ruaFcaN3cWkgBDr9INKzBlrxNWintrNOPchMGHKIM2CFExZGZpSr646bgsX9cCG7wSXZiQtxoN5A+ZPW+hqQ+IsyZHws3sB4Vy2eU4oHBnst8g+5D2KTpzYSWlAhSA4nvdtY0fZIghQGiTPrZaqjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEmXryY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940E3C433F1;
	Wed, 28 Feb 2024 02:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709088419;
	bh=Tnku9fdfb4RAYA9RXtUVS6U+UK5al6iZT05jrsPWoS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dEmXryY25ebRwANbBUGtI6ksIrGC+yw6XPMwJUBMd6m2Gi30xmZVbqbY8Ko3brVrW
	 HJpbknBs/B7AblepqcptwN0rSZFglUjP7NgdHr+wqwY6c2Hmb2idx4tMhbz8TH+4u2
	 QZe4fXRNcgYAMqMGrSN5Wjf84Hd9E9QDtsn/gjyW1WSB/ZWDnwNbb5NgJoeLIU63VW
	 z4nEgV7p+Klt1JHkvDzOesqBietzTRZWD5sNC+UQO4t5k54lxYypBDajtyz6c0ZlUF
	 m8W4WTKn1hwFhbvx/9ROKNDaYy0A8aST1VFUd8LT9Qb231W7pPAtVIgKSt2r/dFiD3
	 ut8Px/Nuw/5Ng==
Date: Tue, 27 Feb 2024 18:46:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Madalin
 Bucur <madalin.bucur@nxp.com>, Paolo Abeni <pabeni@redhat.com>, Sean
 Anderson <sean.anderson@seco.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: fman: Use common error handling code in
 dtsec_init()
Message-ID: <20240227184657.76ec4e82@kernel.org>
In-Reply-To: <9b879c8d-4c28-4748-acf6-18dc69d8ebdf@web.de>
References: <9b879c8d-4c28-4748-acf6-18dc69d8ebdf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 14:14:52 +0100 Markus Elfring wrote:
> Adjust jump targets so that a bit of exception handling can be better
> reused at the end of this function implementation.

Okay, but..

>  .../net/ethernet/freescale/fman/fman_dtsec.c  | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)

.you've added more lines than you've removed so what's the point.
-- 
pw-bot: reject

