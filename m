Return-Path: <linux-kernel+bounces-106747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3D087F309
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746581F217BC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A025A11C;
	Mon, 18 Mar 2024 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REvq95K6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5766159B6D;
	Mon, 18 Mar 2024 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710800346; cv=none; b=FnJwzCTG6vjRNdmOl3dX2GEV/wQr0vLV7c+021kdzNRSgF/29OqpJBWMWxMO3TdW/VykiBF/eulx1I9/ojAq+W+7o+NxVa1EtFAFswkxdMc5V/ffmkr8eGyKI+sebBgXIfpfxhP7nrp4fVOlG8yEl+Alr6MCq9TJO/WfLVTac8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710800346; c=relaxed/simple;
	bh=bBUdjSqAYdT3A5Fi0UHHxuEbnI27V0nxpNkqe+gPutg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=LNRmna9APNXZE6c9B6Bou8srhqAOKe0dTCtz5MdcAJjSiJLzkBmmb2QJEwicKrVfOhk+LuhVVSK+TjZJXktJxzWEu8AOJdqEyDTYfkAFiu9Rh8pATWriT8cZKXazTqKTmpbdfzgIP39+0KcD/H+/avrwC3S7v4vzMtNYgxHMqbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REvq95K6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C04C433C7;
	Mon, 18 Mar 2024 22:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710800345;
	bh=bBUdjSqAYdT3A5Fi0UHHxuEbnI27V0nxpNkqe+gPutg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=REvq95K6gh9vgQXGpO8my+dqQwJp56Hd8M4yJKDMoK6gryKTdlUJ5SMg4qUXNme/Y
	 T9Vk4oanJQ8NJ7N0vw+HNNgCKweengGZIKvctyUYuO4/anoh9UvzRFv20HXlOK7vAW
	 axiD+V7AZy9ghpASkVVx+B4cZZU6bWXhk7+noQTDWr3Ho3mE7o7NAFs6R6fRwIcJuO
	 S3ityzFzwq7+SiFS87zDrrH+G77OH6cs42Hg9Hq/VDkoqyfpEnOvfgwp5a25gPdraw
	 qfWDgb6kgse6gb5nawFkzAfv0ZFZ2NJS2Ld09MixUvrRqz0IrcBY22EfytIiA9MoZv
	 yBL3d1R0+5eJA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Mar 2024 00:19:01 +0200
Message-Id: <CZX83UT326IV.3KOKLZ23UH9EZ@kernel.org>
Subject: Re: [PATCH v6 04/13] crypto: ecdsa - Extend res.x mod n calculation
 for NIST P521
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lukas Wunner" <lukas@wunner.de>
Cc: "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
 <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <bbhushan2@marvell.com>, "Stefan Berger" <stefanb@linux.ibm.com>
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-5-stefanb@linux.vnet.ibm.com>
 <CZX5VA5Q4NYY.34VCD8R3ND3KL@kernel.org> <ZfimcDtBNQ42UEqB@wunner.de>
In-Reply-To: <ZfimcDtBNQ42UEqB@wunner.de>

On Mon Mar 18, 2024 at 10:39 PM EET, Lukas Wunner wrote:
> On Mon, Mar 18, 2024 at 10:33:47PM +0200, Jarkko Sakkinen wrote:
> > On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Tested-by: Lukas Wunner <lukas@wunner.de>
> >=20
> > What was there to test in this anyway? I see only comment change below.
>
> The full series was tested, irrespective of the content of the individual
> patches.

Tested-by's should be per patch, and in this patch tested-by has no
meaning at all.

In order to determine which patches tested-by is applicable it can
be derived on what was actually tested.

This looks as tested-by was used in place of acked/reviewed-by, which
is not how it should be used.

BR, Jarkko

