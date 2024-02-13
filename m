Return-Path: <linux-kernel+bounces-63916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC8585365A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D707286BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1172C2919;
	Tue, 13 Feb 2024 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="BWJHHRiv"
Received: from o1.ptr2625.egauge.net (o1.ptr2625.egauge.net [167.89.112.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B5A5FB8D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.112.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842527; cv=none; b=cH/tq1oO58FFWXnHF0vypeacdO6DPr/AMqnd879SrCX6aamjTCIsnDDq8u2EcjAc7A48iFzL7ESjrvoCoHvGJ4vX2LELLa2DJvJcXHQX98Y8TP1y/yQIFbHzVZ4NpSnKMAuwhBy4+ehE7QDD74JCy2dDh6VLxKp3oMIreu8p2vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842527; c=relaxed/simple;
	bh=Y/UupydjZkCsKy+XYz3hkD5vQQH7kxYjO/3+h7Oq6c4=;
	h=Message-ID:Subject:From:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:To:Cc; b=PmRYcRrR0TnYCfc2dT8B4BhkSR2+1eRYNleAPNM8PouMKp4+L61cvkBaZvn/k4sjt7+TKFfJ6HpU4ePO4acDBzydmKWYFNhgOyCeAjoDLKQFpJcUYE5yjQMa2MhLCM4b94Pa5em5mi0gCCNyjhFiMWgse+vt8kaIVx+q7/ZqpuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=em1190.egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=BWJHHRiv; arc=none smtp.client-ip=167.89.112.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1190.egauge.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
	h=subject:from:in-reply-to:references:content-type:
	content-transfer-encoding:mime-version:to:cc:cc:content-type:from:subject:to;
	s=sgd; bh=SbEx3+52qykIFgi4OiKNomUjhhjVPXlEFaoROoWvpCo=;
	b=BWJHHRivKGKkid0AikM/VMRsm6Ph/g8zbO3tyvZKUBdN8NKquQHICMQbt78dHLwH/CFv
	61NSj37LoiakN6Ffaz8uVmn/ofIqo+/DX6GlzNoKc/bKVmJ1XiYNZ87xmejOd3ipaTqYND
	2cMCZ0qyCljeLwSpKcnBBRHHydEWAUVxU4nGOATpY3wQPBUZM5pQjADS+wuQFD1wMYfTyL
	c/yPTQ6mOu8PNeASE6NgkTInEFxoF1l6053ibAffHXVXe4vC3Whe4ARWVDhP95Cs7quBpE
	sYlO97j4K/Ij2lIkaIz0zrPbGpMpoWkdGsi8svrcltagJXjHcA3yUTlUH8XzD/kA==
Received: by filterdrecv-58bfc74dd6-v8vxl with SMTP id filterdrecv-58bfc74dd6-v8vxl-1-65CB9BDC-D
        2024-02-13 16:42:04.378922078 +0000 UTC m=+1650313.084825101
Received: from bixby.lan (unknown)
	by geopod-ismtpd-5 (SG) with ESMTP
	id Cmn7aDI6Qu--YqIDC9LoWA
	Tue, 13 Feb 2024 16:42:04.165 +0000 (UTC)
Message-ID: <2ff1c701f3443e1c612a81f4077b0280850f57c6.camel@egauge.net>
Subject: Re: [PATCH RFC] wifi: wilc1000: fix reset line assert/deassert
 polarity
From: David Mosberger-Tang <davidm@egauge.net>
Date: Tue, 13 Feb 2024 16:42:04 +0000 (UTC)
In-Reply-To: <20240213-wilc_1000_reset_line-v1-1-e01da2b23fed@bootlin.com>
References: <20240213-wilc_1000_reset_line-v1-1-e01da2b23fed@bootlin.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvEYPI4g=2FHcYSL=2FUCt?=
 =?us-ascii?Q?d1TpeB+0HHeUqLs7izP2tqeU+uw9UOPglVSAV3I?=
 =?us-ascii?Q?T=2FK4mH1NKB=2Fwn2TqMHPCc0neITr6hIe97yPgd1Q?=
 =?us-ascii?Q?jVmDRkQv9gk6gW8twnzPGlM73dRaAaXOwO0z09O?=
 =?us-ascii?Q?2CXDTNzi8Wg1O8QtHFcOAfjF9IpcdcFmxJ58ugA?=
 =?us-ascii?Q?56kxcOAmzs=2FyPNXDUvz0w=3D=3D?=
To: Alexis =?iso-8859-1?q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==

On Tue, 2024-02-13 at 16:22 +0100, Alexis Lothor=E9 wrote:
> When using a wilc1000 chip over a spi bus, users can optionally define a
> reset gpio and a chip enable gpio. The reset line of wilc1000 is active
> low, so to hold the chip in reset, a low (physical) value must be applied=
.
>=20
> The corresponding device tree binding documentation was introduced by
> commit f31ee3c0a555 ("wilc1000: Document enable-gpios and reset-gpios
> properties") and correctly indicates that the reset line is an active-low
> signal. However, the corresponding driver part, brought by commit
> ec031ac4792c ("wilc1000: Add reset/enable GPIO support to SPI driver"), i=
s
> misusing the gpiod APIs and apply an inverted logic when powering up/down
> the chip (for example, setting the reset line to a logic "1" during power
> up, which in fact asserts the reset line when device tree describes the
> reset line as GPIO_ACTIVE_LOW).

Note that commit ec031ac4792c is doing the right thing in regards to an
ACTIVE_LOW RESET pin and the binding documentation is consistent with that =
code.

It was later on that commit fcf690b0 flipped the RESET line polarity to tre=
at it
as GPIO_ACTIVE_HIGH.  I never understood why that was done and, as you note=
d, it
introduced in inconsistency with the binding documentation.

On our platform, we never merged commit fcf690b0 and hence our DTS already
defines the RESET pin as GPIO_ACTIVE_LOW.  So, I don't have any issues at a=
ll
with your patch! :-)

  --david
                                                                           =
   gi

