Return-Path: <linux-kernel+bounces-108006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9718804BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4707C285252
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE2036AE1;
	Tue, 19 Mar 2024 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcXTYQ26"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178B2339BC;
	Tue, 19 Mar 2024 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872709; cv=none; b=mfhUN0nOwXRQN93/EHbaLM2xeiqt4Q/kqbVaAOg28bg4EvqPp73IWEij7Dg6DSUW6/nNpLAiZg82x+ODKB1G6nr4iZTT8WLRZ24euAYB4hSTESOZZZ5eQ4gXHo9lx+F/3wgRMknltzTgx44YWUPThfWKf+IvG994WmpfwXsqa3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872709; c=relaxed/simple;
	bh=VKrNllH2AFGJvg3hAc1HYUrygyZEZIltrFzYnyeojws=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mLQmmbygT1JL4rEqkqmNxByo/i2dvvsG66A3OtnArklvxdWipWHzxMfliXiQHaYg/TrPb5Rr85HWnTER5FRigM1uqtJY8/pFMYT5TCODSBY1680G+CGh3YMNwoYVutUMg80MnjSDr5HIgw5hv8gfDtrlWC5wpIjHNTrgwEphH/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcXTYQ26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87228C433F1;
	Tue, 19 Mar 2024 18:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710872708;
	bh=VKrNllH2AFGJvg3hAc1HYUrygyZEZIltrFzYnyeojws=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=RcXTYQ26zoSnkyq2mcJW3SH5SwcvRBL+n4CJCFpMqqdPq4t1vEEF9OXYuJBCRRFtv
	 DmbBurcetvx7dhcXbhDmzrgzttsy5jAtmopBxxueMavaRmnr3MVkFVl45yQUKSmFyo
	 nq5W+lbty+wyiSYbSHkMSfiWd2XfV73ZYB6GRfAr94mUSt508SKsPfrpIKkaaSpKse
	 V5FgawWk162CaDGdkBwa4ARSXlnCuasNhoKtjpY4I3KpKcU563RlwWimsEalMpVGIB
	 jqkESEtQMGz7zDZw2DdzZ41q3APenBmvCgNZie5BYHtR+sfCM0hVaZKjy+ejFDMwPx
	 PQOfXN6EKy+sA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Mar 2024 20:25:04 +0200
Message-Id: <CZXXRA9PVPXI.2X41IISN77CUV@kernel.org>
Cc: <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
 <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <bbhushan2@marvell.com>
Subject: Re: [PATCH v6 00/13] Add support for NIST P521 to ecdsa
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Stefan Berger"
 <stefanb@linux.ibm.com>, "Lukas Wunner" <lukas@wunner.de>, "Stefan Berger"
 <stefanb@linux.vnet.ibm.com>
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <ZfiMhi9D2Rhh89BI@wunner.de>
 <d02eda40-2d3a-43a2-a3a9-cb79055acda7@linux.ibm.com>
 <CZXXPKTAUUM9.35VZUFITJWF6A@kernel.org>
In-Reply-To: <CZXXPKTAUUM9.35VZUFITJWF6A@kernel.org>

On Tue Mar 19, 2024 at 8:22 PM EET, Jarkko Sakkinen wrote:
> On Tue Mar 19, 2024 at 12:42 AM EET, Stefan Berger wrote:
> >
> >
> > On 3/18/24 14:48, Lukas Wunner wrote:
> > > On Tue, Mar 12, 2024 at 02:36:05PM -0400, Stefan Berger wrote:
> > >> This series adds support for the NIST P521 curve to the ecdsa module
> > >> to enable signature verification with it.
> > >=20
> > > v6 of this series is still
> > >=20
> > > Tested-by: Lukas Wunner <lukas@wunner.de>
> >
> > Thanks.
>
> This has been discussed before in LKML but generally tested-by for
> series does not have semantical meaning.
>
> Please apply only for patches that were tested.

How to implement this in practice or place tested-by correctly?

I'd place the tested-by to the patch which contains the uapi trigger
to which for testing was done.

By having this granularity that also does help fixing bugs later on
so it is really not just "plain bureacracy".

BR, Jarkko

