Return-Path: <linux-kernel+bounces-158196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD00B8B1CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1AE3B232DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BA678C8E;
	Thu, 25 Apr 2024 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VNqPIQD8"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2C1DFE1;
	Thu, 25 Apr 2024 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714033878; cv=none; b=VuJB+SExQDbBMP1LiVi7IEcb2V+h70TKyl8TtbhagP57ovnU8UpDKWWzzoDnKv5kkG9OfDDeMy8/pQOb+ZRF5ccEU0hucIsubmmGrt2TCgpEj8s0zIPNhEPhRgMn9bOQz8rmUz8xHNlVN0Bi8Uohz99ZJiXo8cWJ9pZ5APEHyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714033878; c=relaxed/simple;
	bh=iTQ/OD8mW8TxR8YVoQ+2dbzcc6uWkOuUNgQ+ksnKPlA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1yQb5ptgKzRfRubEKe9ZimGFNSNSdLFAT/JsTARIyvXJWQKGPYazLpge4fm+QfG2HvEDh+7ZwZ05CqdlllgzqqKqhMSqLJNZyGcUm9uUzFlkCywi+YRjAr3jqKPINNml4inyJykIM/D60oiOSYF7OpFrtrrPWuXZQ2JpcC5tms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VNqPIQD8; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E812240002;
	Thu, 25 Apr 2024 08:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714033873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTQ/OD8mW8TxR8YVoQ+2dbzcc6uWkOuUNgQ+ksnKPlA=;
	b=VNqPIQD8K8bA2pLFG7GbrmGWu5xC0UBu4EHqWHos8sPXc3u9ilCbpFUR33e1YeZNBSGGb1
	2kFDnEpoC7Q164yzNB9x758Bfpga6Mo2TqPDIpRnAlZYdz/dCVG0wX8OKZ8LpMRFvoFMB4
	jdAdOHOjDvnCNH2t5aKimbGNqeZAzVzRg2F6Syro6YlilQqp/EqRwkeQZOfaWmGTBA5dd4
	YjQ3HMwH+miS7tkd4ufYa+sEjosvEDALlXkescCxO4q1xZWRJhVJKuX7/YXCbZh9rQsxcZ
	qSp4Ui06To1uvDdrICiL9krggjsKEawsEKs/Er76uayfQeokhUtWNX8Ykn0z/w==
Date: Thu, 25 Apr 2024 10:31:10 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v3 0/3] net: pse-pd: Fixes for few small issues
Message-ID: <20240425103110.33c02857@kmaincent-XPS-13-7390>
In-Reply-To: <ZiebQLdu9dOh1v-T@nanopsycho>
References: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
	<ZiebQLdu9dOh1v-T@nanopsycho>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 23 Apr 2024 13:28:00 +0200
Jiri Pirko <jiri@resnulli.us> wrote:

> Tue, Apr 23, 2024 at 11:21:09AM CEST, kory.maincent@bootlin.com wrote:
> >From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >
> >This patch series fix few issues in PSE net subsystem like Regulator
> >dependency, PSE regulator type and kernel Documentation.
> >
> >Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> set-
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Your reviewed-by tag has not been taken in the commit merged.
It seems patchwork does not take the cover letter tag reply into
account, I think only b4 does.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

