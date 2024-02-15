Return-Path: <linux-kernel+bounces-67084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846648565FF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62D71C23A22
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B581513246C;
	Thu, 15 Feb 2024 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJYTn6PL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDF712C559;
	Thu, 15 Feb 2024 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007560; cv=none; b=KznUtBt/yyZHWn7ZxtJTp7LOlXeVZaiIcQshhulvuoaJpxuNMTBHhErTqed8Lk8H25AQtg2QfjlhI/pVLxmXzt+0+r3ADFrmekFoP6q+k8aC2H4jJ1N4FcIlIr2WfeGRNVx+VNomXLYWZ0ixAmku3O9EAq3t/7t0DrHQmIL0Q+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007560; c=relaxed/simple;
	bh=RDEiGRf90Re3gTpyPNkzNOs5ZMS+5zS+B9IMjDdiEVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoRQb/xCDmQpPhm8gIKI2tveni78DvyMQLNSMDS3H+Xz9E/KhvNtNr96YiS5ul9kt26b3rJGUHPKRo0yuZfXPwf0v7Jml9ybw77WZsNjahFaa6nYsDkV3MacTo54VUZ0msvYhAFW8ACiEEQZ5wn2RrjHGfMMx5p0t59gdqNeqa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJYTn6PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA72C433C7;
	Thu, 15 Feb 2024 14:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708007559;
	bh=RDEiGRf90Re3gTpyPNkzNOs5ZMS+5zS+B9IMjDdiEVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJYTn6PLkujcFUnJvgg/0kGsJj7dNDW5rIMQtZCNHth4cnAzRs4d9XRGkR0BT704Q
	 8dUgAa+au0rcH43+3gpERDltdKtgKUK/PhaQd5VolFwjEPBW5erVWeofQO9LTXMKux
	 +eUYa0YRWM6vqSy408jHWgQCOd+9fNLgM1aTQpqJjNipiKKhg3Q+wrarJNVQEkwWpQ
	 Ei99Jalz/Te6GIOHmiqDQnAHieKA4wxjZrhzEhyMpzJVMx7d6PdPL4s9Qk6eHy5fZg
	 c41H+v4/p/NdPsickDYiPENZa57JL8o+QlYxag73ydYnaV7KbIq+d447C8a/Wq/n/x
	 /4+cbaWZUX+zQ==
Date: Thu, 15 Feb 2024 08:32:33 -0600
From: Rob Herring <robh@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Eugene Zaikonnikov <ez@norophonic.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, Nishanth Menon <nm@ti.com>,
	Michael Walle <mwalle@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH v6 4/7] dt-bindings: mtd: spi-nor: add optional
 interrupts property
Message-ID: <170800755249.11056.3790121633736757728.robh@kernel.org>
References: <20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com>
 <20240212-add-am64-som-v6-4-b59edb2bc8c3@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-add-am64-som-v6-4-b59edb2bc8c3@solid-run.com>


On Mon, 12 Feb 2024 18:38:11 +0100, Josua Mayer wrote:
> Some spi flash memories have an interrupt signal which can be used for
> signalling on-chip events such as busy status or ecc errors to the host.
> 
> Add binding for "interrupts" property so that boards wiring this signal
> may describe the connection.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


