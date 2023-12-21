Return-Path: <linux-kernel+bounces-9059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E3D81BFBB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D217C1C219B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1685776915;
	Thu, 21 Dec 2023 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThAR0Zp2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F3A760B8;
	Thu, 21 Dec 2023 20:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B51C433C8;
	Thu, 21 Dec 2023 20:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703191483;
	bh=C4ND45O9VtPdCGNJbKtbMUJR3Ewk4KrDe0AszFJgI1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ThAR0Zp2s0BlXasxoqe33EdMx7uI1VwY7bMLPoQWjvgdLlZLx6FC7vKTSQ36Oweg7
	 FwHF1Egu0a+Sbchnw8lN6yK1zN3YTNdreVvWzLygo8ZSP9iJL4T1E0Kz1xi+mlXgxq
	 3ydHgZM6fQhaWXwO4leH2bLvTcjbv1s1F1mRFqNWP/mceguB7ZPUvrNiCDfuHI8uR0
	 IVbjUjlXGqG0GtvJfQwMn04i+djj0nxNNpfyzG1mOYa7y05GCjOfjplLrKrelHqF8j
	 amA3kEgvreefhUeG/sEBnHg0sUqp2cufG8hZZBBY5Jrn6iM56koQtUpr+k/O9McPfZ
	 Yjqx5JudQPJ/A==
Received: (nullmailer pid 62496 invoked by uid 1000);
	Thu, 21 Dec 2023 20:44:41 -0000
Date: Thu, 21 Dec 2023 14:44:41 -0600
From: Rob Herring <robh@kernel.org>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Raul Rangel <rrangel@chromium.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, Tzung-Bi Shih <tzungbi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 17/22] of: irq: add wake capable bit to
 of_irq_resource()
Message-ID: <170319148087.62439.16254774276035197827.robh@kernel.org>
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.17.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220165423.v2.17.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid>


On Wed, 20 Dec 2023 16:54:31 -0700, Mark Hasemeyer wrote:
> Add wake capability information to the IRQ resource. Wake capability is
> assumed based on conventions provided in the devicetree wakeup-source
> binding documentation. An interrupt is considered wake capable if the
> following are true:
> 1. A wakeup-source property exits in the same device node as the
>    interrupt.
> 2. The IRQ is marked as dedicated by setting its interrupt-name to
>    "wakeup".
> 
> The wakeup-source documentation states that dedicated interrupts can use
> device specific interrupt names and device drivers are still welcome to
> use their own naming schemes. This API is provided as a helper if one is
> willing to conform to the above conventions.
> 
> The ACPI subsystems already provides similar APIs that allow one to
> query the wake capability of an IRQ. This brings closer feature parity
> to the devicetree.
> 
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> ---
> 
> Changes in v2:
> -Update logic to return true only if wakeup-source property and
>  "wakeup" interrupt-name are defined
> -irq->IRQ, api->API
> 
>  drivers/of/irq.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


