Return-Path: <linux-kernel+bounces-71170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1131E85A195
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BED5283B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FCA2C18E;
	Mon, 19 Feb 2024 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DuDL9T4P"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822B11C10;
	Mon, 19 Feb 2024 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340530; cv=none; b=qILJLwyQQlipZGZSw34Q4jzxRSMqR7latsTKvUaKBYaCqwOyP8A9hivuuBNTnXcfs5DzqV6m+XnC/dJvHGhW89Aa/sKsjZKOFwas6nMOU4J9/Ynmb1h4CpyhH9b2ybhsmEfxP820Y0YZbJctpva68SPU4vWCxKcYazIKfBRG0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340530; c=relaxed/simple;
	bh=t27JD9vQCz4yHAU/sc6tVJAOHfeKNbWcnRVeUVWIkwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAsfY5rzBE25g4QLHewxzik0J50ve6tC6WqQ/CvW6ePccqlNOYAdQ52QZILOYVKs/aCHw05PKChFmfKY8h3hZJmEunxKavEDiTXE6IMMUc4tCl2lXTM81o4UVe5nYPr5C4Zhk8wQ/liM+CewiyrIKZ6KJ3ql61OpSVFl4n+ZHTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DuDL9T4P; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03DBD6000B;
	Mon, 19 Feb 2024 11:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708340521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t27JD9vQCz4yHAU/sc6tVJAOHfeKNbWcnRVeUVWIkwo=;
	b=DuDL9T4PLsVeV0kVRHxYLvPzuYAWVBMrTHo2L0Wu2eWSHJaUcjDjbEbS5GFPVPrPrAsJao
	rSOpMgBXJx8FjeTaygqPpElW0w3H54qnBjtsPFP26NI9LOg45Pwcdtnh6RCc4+scAjjfHK
	skgFCaMrGvql4KtLksBIx0aeP1NBf/4Vs3hvHB0K6UAbU+eAeozXjygMQ3I5Kq1rMGeFUU
	PTEkS3kvfY/MmbwpXqO8W8xbIjkZzDPRPrJnN3G49JW+K4A1a3f/YcK0+V3huDvHsHylQi
	qMqCqT3fDV8K9MBJzXBSZGxdyBdTBK9rhisMHVrNTBE5aPticJxmnVmugWmLwQ==
Date: Mon, 19 Feb 2024 12:01:56 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 7/7] mtd: ubi: provide NVMEM layer over UBI volumes
Message-ID: <20240219120156.383a1427@xps-13>
In-Reply-To: <82ceb13954f7e701bf47c112333e7b15a57fc360.1702952891.git.daniel@makrotopia.org>
References: <cover.1702952891.git.daniel@makrotopia.org>
	<82ceb13954f7e701bf47c112333e7b15a57fc360.1702952891.git.daniel@makrotopia.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Daniel,

daniel@makrotopia.org wrote on Tue, 19 Dec 2023 02:33:48 +0000:

> In an ideal world we would like UBI to be used where ever possible on a
> NAND chip. And with UBI support in ARM Trusted Firmware and U-Boot it
> is possible to achieve an (almost-)all-UBI flash layout. Hence the need
> for a way to also use UBI volumes to store board-level constants, such
> as MAC addresses and calibration data of wireless interfaces.
>=20
> Add UBI volume NVMEM driver module exposing UBI volumes as NVMEM
> providers. Allow UBI devices to have a "volumes" firmware subnode with
> volumes which may be compatible with "nvmem-cells".
> Access to UBI volumes via the NVMEM interface at this point is
> read-only, and it is slow, opening and closing the UBI volume for each
> access due to limitations of the NVMEM provider API.

I don't feel qualified enough to review the other patches, however this
one looks good to me.

Thanks,
Miqu=C3=A8l

