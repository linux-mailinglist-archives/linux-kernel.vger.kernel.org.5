Return-Path: <linux-kernel+bounces-37023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FD083AA5E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77811C2298B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED77477653;
	Wed, 24 Jan 2024 12:56:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0F077642
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100989; cv=none; b=JX4F0CmzoAyB3XnoZ9flnfs5FFZ4JZ9UIMi0MMwVoVLJyCMhVqhzxdA5TbUFePTBDIM02rCpJev2AXA9K/PNbeDTRD6mJfqGtvOhA27jTzwwZp4pu5q+mkRI4dRRAdwHU3xAp/g1LJysXV13g884ulzWplkMASbsv27KI9yBtV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100989; c=relaxed/simple;
	bh=UTgGTB6lK4mod76UKu9bIx9yLmqPqk/Vo+rhgIwef1g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PM8uBynLDnqWMu+SlezmVLN4Hi2zgvooGUGJGoYuu0TMwnIK5K00SrzkE/tbV2SJIhkOgtcH4JusmaZot1JnCNUsM1VA3eeW0x4z3SvVggmJhLBfUp673RODvviIrLUKTHmEk+XNp+zzHWrdFKjuA1MIpC4FuLdUROM7UsRq1q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rScnk-0002cm-5F; Wed, 24 Jan 2024 13:56:20 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rScni-00243J-Sw; Wed, 24 Jan 2024 13:56:18 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rScni-000BSu-2g;
	Wed, 24 Jan 2024 13:56:18 +0100
Message-ID: <63a1bfa2acb84bc24b87a8dbd60b665c733d13cd.camel@pengutronix.de>
Subject: Re: [PATCH] usb: dwc3-of-simple: Stop using
 of_reset_control_array_get() directly
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>,  Felipe Balbi <balbi@kernel.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 24 Jan 2024 13:56:18 +0100
In-Reply-To: <2024012400-subtitle-magnitude-45ff@gregkh>
References: 
	<20240124-dwc3-of-simple-reset-control-array-fix-v1-1-808182cc3f0e@pengutronix.de>
	 <2024012400-subtitle-magnitude-45ff@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mi, 2024-01-24 at 04:39 -0800, Greg Kroah-Hartman wrote:
> On Wed, Jan 24, 2024 at 12:26:20PM +0100, Philipp Zabel wrote:
> > Use of_reset_control_array_get_optional_exclusive() instead, it is
> > implemented as:
> >=20
> >   static inline struct reset_control *
> >   of_reset_control_array_get_optional_exclusive(struct device_node *nod=
e)
> >   {
> >           return of_reset_control_array_get(node, false, true, true);
> >   }
> >=20
> > This makes the code easier to understand and removes the last remaining
> > direct use of of_reset_control_array_get(). No functional changes.
> >=20
> > Fixes: f4cc91ddd856 ("usb: dwc3: of-simple: remove Amlogic GXL and AXG =
compatibles")
>=20
> No functional change, but a Fixes: tag?  That doesn't make sense to me,
> sorry.

The referenced patch made the boolean parameters const but missed that
there is a static inline wrapper for this combination. I can drop the
Fixes: tag and describe this in the text.

regards
Philipp

