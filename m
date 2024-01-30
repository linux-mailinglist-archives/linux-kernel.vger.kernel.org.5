Return-Path: <linux-kernel+bounces-44972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C05858429D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63F75B22F79
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EEA12837D;
	Tue, 30 Jan 2024 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSSqBRKc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3884E823AA;
	Tue, 30 Jan 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633092; cv=none; b=NjWhqrliQoOlRYwObJBflE7fc7YiqGqTKuaxes8Hf0nD7Rx5ZOPkYdEv7iS5j/LzlzUv5m9uwDeZocTDuMFEcGNx7+zkFWf8WP2rQcw5e5FlwAaLxC+G9gp5VzNoNQBxPH7F6Njpr5KRsf7gJPLq1Ny9mRfcPQ5PeXOYaeXz+jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633092; c=relaxed/simple;
	bh=ApN6vGDoCBSa8a5eHek4leab/krN/aRtltgY7pXOlaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrdDPdB8XJSW4lYeeReIGfw7+87VVwUnDY6MJNZOjpGvhpgzbmiIRwzhhwkGrMKn/sC+IXp3VFIfoUCVmkXFVGfcR+ej1BN4Lak3UpBwefMMK+VkN1w6W4LsvT1ajsOY1OVmEY7JV/uNqfaSuolA74ChR+TsZfFwUoZng//tc1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSSqBRKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796B9C433F1;
	Tue, 30 Jan 2024 16:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706633091;
	bh=ApN6vGDoCBSa8a5eHek4leab/krN/aRtltgY7pXOlaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSSqBRKc7l50P3IqENRN3i8FnYccrqXf4wIpszO0ApgIw+XxPLTjNtyCyrpLoCx7V
	 llUAy5lxvX/BvGhDzIXLv8rtRagPqQx9XQTeLnaJASOuCZKe4aeVdfjiOdizFQ6Qj+
	 Ejb3Ujpgf/w18Xut6wj8w+tcUW9MjJJcTCW6JV7N99RMaFYqrIuLdhB9XPsd03GyS6
	 cGksaQ1iXg7Qmh2F79ORkwb7+QWpOq1Jv7iQiywybha6QWmzpGgHVF7aWrEAqkaWAB
	 mD2I2SQnW0mFKKgnZKazTZ7FTv+s5yH/rkiSrhoDwmJUwCpr21c1S9oAYlhmTd4HAl
	 8FQiIVtgQ433A==
Date: Tue, 30 Jan 2024 10:44:49 -0600
From: Rob Herring <robh@kernel.org>
To: William Qiu <william.qiu@starfivetech.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-can@vger.kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 1/4] dt-bindings: vendor-prefixes: Add cast vendor
 prefix
Message-ID: <20240130164449.GA1828286-robh@kernel.org>
References: <20240129031239.17037-1-william.qiu@starfivetech.com>
 <20240129031239.17037-2-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129031239.17037-2-william.qiu@starfivetech.com>

On Mon, Jan 29, 2024 at 11:12:36AM +0800, William Qiu wrote:
> Add prefix for Computer-Aided Software Technologies, Inc.

The diff tells me this. The commit message should say who Computer-Aided 
Software Technologies, Inc. is. What do they make? Website? etc.

> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 1a0dc04f1db4..b9c6ce99d24d 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -242,6 +242,8 @@ patternProperties:
>      description: Capella Microsystems, Inc
>    "^cascoda,.*":
>      description: Cascoda, Ltd.
> +  "^cast,.*":
> +    description: Computer-Aided Software Technologies, Inc.
>    "^catalyst,.*":
>      description: Catalyst Semiconductor, Inc.
>    "^cavium,.*":
> -- 
> 2.34.1
> 

