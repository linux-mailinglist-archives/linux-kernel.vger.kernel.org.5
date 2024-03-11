Return-Path: <linux-kernel+bounces-99552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 175408789E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CBE281BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A1556B76;
	Mon, 11 Mar 2024 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rP8rqt9Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43DB54FA9;
	Mon, 11 Mar 2024 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191511; cv=none; b=J/T82UW0ad2ucphizP+y1wWpYYqf/dAFO3KnccP+segHXZNE/EoiYONPx6HSCsZvYJJXlO8xu3pMsoSaz4MaEBe5Zlw+rdxurgRXYgZnqgRCnhxh7FJsQ05E+L0OXwYh/OyWu4eYXFuYQT1OD8hV2rrArWeVgdp1gGfrz27wup4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191511; c=relaxed/simple;
	bh=5KYeLP/Z7vfTMDvVH57E3WBbpcqd5Ed7Gv0l/gsgDTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=civ0Eg7cNlV2M58YaLcr2WESLrGw34vmlvdh6yoJbPoNeXF22b2IDlsZSVY96EIxii2KTMW/3nUxuZYBWa9jt/HY4wDEOb0+V3NZpnYlV03FO4Kz6YokRx+AasKaeNS2u92gxsU+c9gZLTKMW6bx5WWOirEOPkzDmHDggBVWTGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rP8rqt9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D47C433F1;
	Mon, 11 Mar 2024 21:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710191511;
	bh=5KYeLP/Z7vfTMDvVH57E3WBbpcqd5Ed7Gv0l/gsgDTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rP8rqt9ZaRKGisJCWcWgf4QTpH4FzeNOquAoSwpsM7HHH3LYm03hV9RhPhsNnG2tu
	 4cabvk9Ov2bxHHDzbp02RMzFMJHD+EH1Y0ulcQWG3VJlfQ2Zx0MMfAxIoxml7UbcQQ
	 43ghmZsFIqYvz/9gztBeeWfWMjK5HVvhrvU5Yy6n5/r6etTVqCwY0Vlq4kxZvEYa6f
	 dqIRKMXaZuC80pCqEvlsutSQtdy/DvI0bSwfi5cTtRruVb6usghq3xMLzPCcLsfrff
	 3YDaxB8KJok6zU6REckYq55AjwoZAnoux/OGr3Hea2S0Es5TaK6nIR0vjsdzAhaE0Q
	 S7oy89IkwYTuw==
Date: Mon, 11 Mar 2024 14:11:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Yury Norov <yury.norov@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Andrew Lunn
 <andrew@lunn.ch>, Mark Brown <broonie@kernel.org>, Ratheesh Kannoth
 <rkannoth@marvell.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 0/5] Add support for QMC HDLC
Message-ID: <20240311141150.4ebde44b@kernel.org>
In-Reply-To: <20240307113909.227375-1-herve.codina@bootlin.com>
References: <20240307113909.227375-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Mar 2024 12:39:03 +0100 Herve Codina wrote:
> This series introduces the QMC HDLC support.
> 
> Patches were previously sent as part of a full feature series and were
> previously reviewed in that context:
> "Add support for QMC HDLC, framer infrastructure and PEF2256 framer" [1]
> 
> In order to ease the merge, the full feature series has been split and
> needed parts were merged in v6.8-rc1:
>  - "Prepare the PowerQUICC QMC and TSA for the HDLC QMC driver" [2]
>  - "Add support for framer infrastructure and PEF2256 framer" [3]
> 
> This series contains patches related to the QMC HDLC part (QMC HDLC
> driver):
>  - Introduce the QMC HDLC driver (patches 1 and 2)
>  - Add timeslots change support in QMC HDLC (patch 3)
>  - Add framer support as a framer consumer in QMC HDLC (patch 4)
> 
> Compare to the original full feature series, a modification was done on
> patch 3 in order to use a coherent prefix in the commit title.
> 
> I kept the patches unsquashed as they were previously sent and reviewed.
> Of course, I can squash them if needed.

Applied, thank you!

