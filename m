Return-Path: <linux-kernel+bounces-64559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58B3854046
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF0C1B275AB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D5D63130;
	Tue, 13 Feb 2024 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1VK8fVP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E1363104;
	Tue, 13 Feb 2024 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867761; cv=none; b=C+hFnpbsijzYCqbN9lBgZJX4JodWDjxX3T05w1u2HM9/uFJ23EGEwX0f8kwj6N1yeldZX8T2y7rnK7AONM0QXeKknvAu0vK0r996NPb8mF+URwctbaZfzsx1GatJdPL2TxUh59hM6fuk/jEjqQgKid+x0JRRSkbHNnAp44Thb9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867761; c=relaxed/simple;
	bh=keTfhYWfDumZULNouernfe44OalbE1v686VA8nHWu8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgROZRvvYVUtlYkFJ0G3D66h5Jcmu6Zx1syB2I5RIr/+pcezPD2/HW6m6K2bKkUfzEeOnRRp6gKXSi3IVcZL8+dGESp/kaAMv7oLKMZR9pIWqm4sgADaUjEXdr9CCX0zkMj0TQDCTD7rQM1srFVDFKxBrc4iKFnpBNzl00FYQ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1VK8fVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FE1C433F1;
	Tue, 13 Feb 2024 23:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707867761;
	bh=keTfhYWfDumZULNouernfe44OalbE1v686VA8nHWu8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1VK8fVPNIZAxBS9+qbK3mAicGGVwtixJT6PrfNbxpk041lB2yzodyOaCzzaE7saS
	 MWGpvVLt0YIbGnIvYaGhaCZcCwZ/O8sznAj9/G7i4dBXWJTJOeuA0WJFIlfDwLn6pO
	 Dxw+DpWUBudKqsJz22AlCXbWlakPlLZL8bKR0Ysw40wNa8e1nu23aojUhQrK/mf6KJ
	 9Qy6EX0aS3P+QAyAx4UibdnTbdgxMu68w8mVGpkVJbIHV9UYRXoRom4edwU0J2GfwI
	 Ek/vokfTN1TL7NkXXA4DDHfVZLHvcD1LUvHP5Zp9ewAf4e6SJ58Yfl5qsUB6tw82y0
	 EDyxrnPvTIjqA==
Received: by mercury (Postfix, from userid 1000)
	id 185E51061C38; Wed, 14 Feb 2024 00:42:38 +0100 (CET)
Date: Wed, 14 Feb 2024 00:42:38 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	NXP Linux Team <linux-imx@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/17] dt-bindings: soc: imx: fsl,imx-anatop: add
 binding
Message-ID: <22pec37ketr2pgcqwz4nd5lm55ohv7jvtxw2l7piosbnx3sw7e@gewljn5veatn>
References: <20240213010347.1075251-1-sre@kernel.org>
 <20240213010347.1075251-6-sre@kernel.org>
 <eaf37a1e-58e2-4cc7-85f9-8cb81537b3b9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaf37a1e-58e2-4cc7-85f9-8cb81537b3b9@linaro.org>

Hi Krzysztof,

On Tue, Feb 13, 2024 at 01:27:09PM +0100, Krzysztof Kozlowski wrote:
> [...]
> > +  tempmon:
> > +    type: object
> > +    unevaluatedProperties: false
> > +    $ref: /schemas/thermal/imx-thermal.yaml
> 
> So you just ignored my comment?
> I did not receive any response from you on this.

I had mentioned it in the cover letter next to the changelog:

Unadressed feedback from PATCHv1:
 - anatop phandle vs parent: technically it makes sense to just use the
   parent, but this driver is only used by i.MX6. The current code makes
   use of the phandle, so we cannot drop it because of backwards
   compatibility. So I don't see a point in deprecating this property.

(reading it again: s/driver/binding/ and s/code/Linux kernel driver/)

Greetings,

-- Sebastian

