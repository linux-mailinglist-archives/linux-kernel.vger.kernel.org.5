Return-Path: <linux-kernel+bounces-52819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0698849D07
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA121F28DF8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8CA2C197;
	Mon,  5 Feb 2024 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U5DBarV1"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6EF28E09
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143286; cv=none; b=GLmyicr7Kf1ZJ6ld8QfWOkR5PDK6Sqt0EbywMCS5S3hUmT8ddvXktJzM9VvVFG2CBYblUEvjdzlzrVXTRzuuvOFDLHns++8ScsH4gmaVCJu874s0Q5cou+rExNjkmDckyJ4KqpOx7jZbcl2KlxCSh+3sV5qinW12mYhG3KLSj2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143286; c=relaxed/simple;
	bh=c6woLy2+EgbXcJiwHU3W4/j7iI+sLz3RGz/O8g5vcec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZRv5andhI6mUWoEeZ+ayEzc4OZ6anrF1EvTvSVUIBicGMYLuDJOD3/HSKjzPQqsaYHFpYwaX/z5XUnAMppODzgH16KoQZLv6fHkp1+qjkVIF5PLDNRnyLSbsSeEJSIOlWr659sxDNxTrRGWjM+WGHmbB84+JMv4jU5os8yvYUCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U5DBarV1; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32AFEE000E;
	Mon,  5 Feb 2024 14:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707143282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rr8qzPIYqM+HdXpoa3bzvlmyjnTmSf9J/CC9t8G0s0A=;
	b=U5DBarV1kWvF6kp6bsYh7pMLbNmHG365DTQi/YCihxMfxi3a94oiNCX0QoZem3hi/YJM1P
	Dgpo1S7r2d+8hybPIBGTKY4JK6pSTMP5lO+krI1U049Qt1oEsOgbSGzWeq3oMgjnbmcIAB
	AkOU7a9qwJnFbvgBqNAzSlEDe6HpQ8aLDX77UecgqHEZ8JgLcsv+xW8RWy+TBh/vpbwnyd
	L2OP+pTXjafmMZQWKYE33jVBYFKOQvjfNU1Z3fzPVHH83J6i6yxmEpIGmDzUWeeM5mSksI
	BrYJ07GDTL+HBVIaitm7ekLHQzHWm/jII1GAmQP2sA5bPybyv43/6h2mWEEWLA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ezra Buehler <ezra@easyb.ch>,
	linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Chuanhong Guo <gch981213@gmail.com>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>,
	Martin Kurbanov <mmkurbanov@sberdevices.ru>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Richard Weinberger <richard@nod.at>,
	Sridharan S N <quic_sridsn@quicinc.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mtd: spinand: esmt: Extend IDs to 5 bytes
Date: Mon,  5 Feb 2024 15:28:00 +0100
Message-Id: <20240205142800.466649-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125200108.24374-3-ezra@easyb.ch>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'4bd14b2fd8a83a2f5220ba4ef323f741e11bfdfd'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 2024-01-25 at 20:01:08 UTC, Ezra Buehler wrote:
> From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> 
> According to the datasheets, the ESMT chips in question will return a 5
> byte long identification code where the last 3 bytes are the JEDEC
> continuation codes (7Fh). Although, I would have expected 4 continuation
> codes as Powerchip Semiconductor (C8h, corresponding to the parameter
> page data) is located in bank 5 of the JEDEC database.
> 
> By matching the full 5 bytes we can avoid clashes with GigaDevice NAND
> flashes.
> 
> This fix allows the MT7688-based GARDENA smart Gateway to boot again.
> 
> Fixes: aa08bf187f32 ("mtd: spinand: esmt: add support for F50D2G41KA")
> Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> Reviewed-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> Tested-by: Martin Kurbanov <mmkurbanov@salutedevices.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

