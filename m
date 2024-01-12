Return-Path: <linux-kernel+bounces-24405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE94882BC1D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35F21F22F97
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FE65D745;
	Fri, 12 Jan 2024 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwvZmfdc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67732812;
	Fri, 12 Jan 2024 07:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722DFC433F1;
	Fri, 12 Jan 2024 07:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705046313;
	bh=fZ2vS676hdgJy+L7T0B/4nKQXB3hkTnrLtIFZBx9/60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dwvZmfdcQJlvGab9ateNjc7FT47yJduv7igApmUMISm37PVKZgbPj1wCQhEDAVDoQ
	 1Unmbv/9wgNTiVzfHxRyz7ANRUdnHIJH7P3mONG02RYFr7w1X3OwWLTV7LBr0In0v6
	 P90t13blzz88t1F3i8Nk9ZO5JdM2A5hLzzOlSm/vawlOVsmA4J4CDrpmBsNv450cuF
	 m/D39KJye/CbX3eJQygnIIwnAQaPkuvfG1UXhpP8rHTSgIJoQiv+f4zFV/eRwVD/Qa
	 /YvRmaM72dkdwQKSIfROObtq3/JAuF89Va4a0e0WtxymirWZ72AMPaleWsmnzYHwNS
	 eQqLmqxbABUJw==
Date: Fri, 12 Jan 2024 07:58:28 +0000
From: Lee Jones <lee@kernel.org>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Karel Balej <balejk@matfyz.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] mfd: 88pm88x: differences with respect to the
 PMIC RFC series
Message-ID: <20240112075828.GI1920897@google.com>
References: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
 <20231228100208.2932-2-karelb@gimli.ms.mff.cuni.cz>
 <20240111105426.GA1678981@google.com>
 <CYBYXXCP3O1O.2M5YMCRW3SIMY@gimli.ms.mff.cuni.cz>
 <20240111152549.GL1678981@google.com>
 <CYBZKXR1F4QP.197Y9Y09Z1CLP@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CYBZKXR1F4QP.197Y9Y09Z1CLP@gimli.ms.mff.cuni.cz>

On Thu, 11 Jan 2024, Karel Balej wrote:

> On Thu Jan 11, 2024 at 4:25 PM CET, Lee Jones wrote:
> 
> [...]
> 
> > > > > diff --git a/include/linux/mfd/88pm88x.h b/include/linux/mfd/88pm88x.h
> > > > > index a34c57447827..9a335f6b9c07 100644
> > > > > --- a/include/linux/mfd/88pm88x.h
> > > > > +++ b/include/linux/mfd/88pm88x.h
> > > > > @@ -49,6 +49,8 @@ struct pm88x_data {
> > > > >  	unsigned int whoami;
> > > > >  	struct reg_sequence *presets;
> > > > >  	unsigned int num_presets;
> > > > > +	struct mfd_cell *devs;
> > > > > +	unsigned int num_devs;
> > > >
> > > > Why are you adding extra abstraction?
> > > 
> > > Right, this is probably not necessary now since I'm only implementing
> > > support for one of the chips - it's just that I keep thinking about it
> > > as a driver for both of them and thus tend to write it a bit more
> > > abstractly. Shall I then drop this and also the `presets` member which
> > > is also chip-specific?
> >
> > Even if you were to support multiple devices, this strategy is unusual
> > and isn't likely to be accepted.
> 
> May I please ask what the recommended strategy is then? `switch`ing on
> the chip ID? I have taken this approach because it seemed to produce a
> cleaner/more straightforward code in comparison to that. Or are you only
> talking about the chip cells/subdevices in particular?

I'd have to see the implementation, but the general exception I'm taking
here is storing the use-once MFD cell data inside a data structure.  If
you were to match on device ID it's *sometimes* acceptable to store the
pointers in local variables.

-- 
Lee Jones [李琼斯]

