Return-Path: <linux-kernel+bounces-14580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4601B821F1F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFA4284A39
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580A114F68;
	Tue,  2 Jan 2024 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWW+ktHL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87C514F62;
	Tue,  2 Jan 2024 16:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0D1C433C8;
	Tue,  2 Jan 2024 16:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704211309;
	bh=EKxAVuaNMTNcXkXewVpa9TOANWnXDrtM+9hkMCPMgdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OWW+ktHLreDhaySNF6kc2W2X19bMnX5W/x4xA3aAqn+n1Lu/WvK3axum8q75CfhaP
	 d+dat0RsiBA/JDB74ZmHmXpEXBVFW+o9iAhltvwvJm/vxvR8eSFIZqc07GrLrtjajC
	 M51+uK1zT+xXefXgslZ9jQoKHdYBEIYs3kWd4cK6lG05ufhNkdiO5je23SmMTsAnM5
	 4Bd2X3wNw+zay0gfgcZH3YHgiklyj53AHC2iA/1PQMTmrmBuMkNgdg8R3w/pTqsa7d
	 6eQiSMAvzswZgRZsgbgwPl+WZK3oOCeQCd6m0bcd9byWe37qPVzntC5+A8CK1G9R9i
	 5SzO2FRWSZ9Eg==
Received: (nullmailer pid 2924825 invoked by uid 1000);
	Tue, 02 Jan 2024 16:01:46 -0000
Date: Tue, 2 Jan 2024 09:01:46 -0700
From: Rob Herring <robh@kernel.org>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Raul Rangel <rrangel@chromium.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Frank Rowand <frowand.list@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v3 18/24] of: irq: add wake capable bit to
 of_irq_resource()
Message-ID: <170421130510.2924738.11783263909956971432.robh@kernel.org>
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.18.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226122113.v3.18.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid>


On Tue, 26 Dec 2023 12:21:22 -0700, Mark Hasemeyer wrote:
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
> Changes in v3:
> -Use DEFINE_RES_IRQ_NAMED_FLAGS macro
> 
> Changes in v2:
> -Update logic to return true only if wakeup-source property and
>  "wakeup" interrupt-name are defined
> -irq->IRQ, api->API
> 
>  drivers/of/irq.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


