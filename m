Return-Path: <linux-kernel+bounces-94259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024AB873C15
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B1C1F2278E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10108137924;
	Wed,  6 Mar 2024 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMFBK0Pn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50036135403;
	Wed,  6 Mar 2024 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742181; cv=none; b=CYOEEHl2VrnX31hK03LeSVoZZ2w97yMfqDqxeoSRvAZITha3wWU+BRROnRFzQR1CG6Gdhul9ksOm+ouIebPnAs6lcpRmrzVyYJDTWnIYTaWoOWk0Zqe2LAehvFui8w516iY2ZTQ72KmkHd8B83uPRxyquIPgKBuVuhEG1NZ5goM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742181; c=relaxed/simple;
	bh=24mhXff8LDVoMbm7CqvfvCGZksiGBKhKHIATyzFE2PA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Al0U9E+ihR7oF61I+oHsjNlhGHZxvh39z9HtrddKWS3elHUn+XsmRWkrUVQlUWgOJA9D6pPC9BRiLe543Lk3ffrzIgcwJEQBXCvIU9dmbXhJrdPR101qqK6+oOnyk2LwwKW+Vlbf3qb6uiK3Uf9Wp9s7+9sGj5ORDruNWUKAJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMFBK0Pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD6FC433C7;
	Wed,  6 Mar 2024 16:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709742180;
	bh=24mhXff8LDVoMbm7CqvfvCGZksiGBKhKHIATyzFE2PA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JMFBK0PnNMiwfUMScMG+NrwmxDyqseaiWtBJ5EZw+UjeFHPDlaJs3PFJ+qIU3ESG6
	 cpmueBKnRTCLMw0LKN0D0URc4gYNnDmgVmbCK11YilSR4cHlzgD4G3FnA1LUKDW0SJ
	 2z3qahBPYT4Sh24Xtxt/Y0LssSKwZpVx9Y6uoPwzyptI5ZJALkhmbn9NWW279W9TCa
	 BK1OM7R02Y242iRN2CscD0zmWvIcTc2aXQNmJ2+DIwmkqttNyqRF23bobGei0bknCP
	 9rOE8dOUqsUjExFwY1aO/M7iPvS8dbi61vs2aYuLWk2sbyn5ptXJvXpp/ISA98blwW
	 FJJgAql8v1eHw==
Date: Wed, 6 Mar 2024 08:22:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, Herve Codina
 <herve.codina@bootlin.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Andrew Lunn
 <andrew@lunn.ch>, Mark Brown <broonie@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 1/5] net: wan: Add support for QMC HDLC
Message-ID: <20240306082259.5a29a5aa@kernel.org>
In-Reply-To: <Zehxwo2wCLkZBQzc@smile.fi.intel.com>
References: <20240306080726.167338-1-herve.codina@bootlin.com>
	<20240306080726.167338-2-herve.codina@bootlin.com>
	<ZehvV6kCD3RCumAL@yury-ThinkPad>
	<Zehxwo2wCLkZBQzc@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 15:38:10 +0200 Andy Shevchenko wrote:
> > It's minor, but you can avoid conditionals doing something like:
> > 
> > 		netdev->stats.rx_over_errors += !!(flags & QMC_RX_FLAG_HDLC_OVF);  
> 
> This is harder to read. 

+1

