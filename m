Return-Path: <linux-kernel+bounces-3990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 949F381765F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270131C248B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AFD4239C;
	Mon, 18 Dec 2023 15:53:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116FC3D566;
	Mon, 18 Dec 2023 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C60E92F4;
	Mon, 18 Dec 2023 07:54:37 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B004F3F5A1;
	Mon, 18 Dec 2023 07:53:50 -0800 (PST)
Date: Mon, 18 Dec 2023 15:53:45 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Conor Dooley <conor@kernel.org>
Cc: Brandon Cheo Fusi <fusibrandon13@gmail.com>, Yangtao Li
 <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon
 <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>, Maxime
 Ripard <mripard@kernel.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/5] cpufreq: sun50i: Add D1 support
Message-ID: <20231218155345.476e71ea@donnerap.manchester.arm.com>
In-Reply-To: <20231218-blabber-slapstick-ab7ae45af019@spud>
References: <20231218110543.64044-1-fusibrandon13@gmail.com>
	<20231218110543.64044-4-fusibrandon13@gmail.com>
	<20231218-blabber-slapstick-ab7ae45af019@spud>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 14:55:30 +0000
Conor Dooley <conor@kernel.org> wrote:

Hi,

> On Mon, Dec 18, 2023 at 12:05:41PM +0100, Brandon Cheo Fusi wrote:
> > Add support for D1 based devices to the Allwinner H6 cpufreq
> > driver
> > 
> > Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > ---
> >  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > index 32a9c88f8..ccf83780f 100644
> > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > @@ -160,6 +160,7 @@ static struct platform_driver sun50i_cpufreq_driver = {
> >  
> >  static const struct of_device_id sun50i_cpufreq_match_list[] = {
> >  	{ .compatible = "allwinner,sun50i-h6" },
> > +	{ .compatible = "allwinner,sun20i-d1" },  
> 
> I thought the feedback in v2 was to drop this change, since the
> devicetree has the sun50i-h6 as a fallback compatible?

Well, this is the *board* (fallback) compatible string, so we cannot assign
it as we like. The whole (existing) scheme is admittedly somewhat weird,
because we not only match on a particular device compatible
(like allwinner,sun20i-d1-operating-points), but also need to blocklist and
re-match some parts against the *board compatible*, owing to the
cpufreq-dt driver. The board name is basically used as a placeholder to
find out the SoC, because there is (or was?) no other good way - the
CPU DT nodes don't work for this. Back when this was introduced, this was
the "least worst" solution.

I don't remember all the details, and didn't find time yet to look into
this in more detail, but fixing this is non-trivial. If this isn't 6.8
material, I might have a look at this later this week/month.

Cheers,
Andre

