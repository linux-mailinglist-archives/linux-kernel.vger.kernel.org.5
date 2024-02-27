Return-Path: <linux-kernel+bounces-83797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA96869E97
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050711F29219
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E906149011;
	Tue, 27 Feb 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IKWQ2uLt"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B781487E5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057239; cv=none; b=VP5lvxZNUmE2L1ONhFtVqjAPhLhu+oQ5PmC3fZfU2lfsEJFOGEGGmkB9cEeirxIdReBPUm8h1UXlHNmqawcfRbS3+PS3cTWN2ib7thcyn3pD1I7oH8yoqDVInnkJYmoDNlyC1FpxOqjzibZNCaGZ/SAq67QNK0chWCdczytNHfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057239; c=relaxed/simple;
	bh=B0ThNOh0lLLn+k0gXyPzhpIqqYghCNKgooGMa1SzMyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpjEoiAvCv2AWICwscbC0SzUVtPHp4xCxIhmn10Y/UFZPqWdU82VKM5hJ48C+ybTu5VN5olzbUi5luKoBADrNeW9XlKzYhnJBVzMbepkjmAyTxYh/zz2RkStkuTZDl9tCsBM1lHAdCtbOZRmjnmHyHfUE2NcVFYV9PRUU7/N6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IKWQ2uLt; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bb5fda069bso265051239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709057237; x=1709662037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6+MUuGb2zmEv5DAM4fS96IcXlW7pM5/kqGwRmxcUuE=;
        b=IKWQ2uLtsmg97kTcixNrXaFWyZFcsP2rWqgkhTn5fo/SuM5qV8j/5tUVGGROtwYrU5
         yVj7B9bFm6xotDhbV7pBKkSezQx5vmnSqT9XTPTS8RiZtNuKx3o6qazaXxpbzosUAAU+
         kJWk+cGyWVuXOwXQ9nG2sNBp1LfToBQZITGV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709057237; x=1709662037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6+MUuGb2zmEv5DAM4fS96IcXlW7pM5/kqGwRmxcUuE=;
        b=BJNpmyJOGg7bp6ivy3f9jPgi471iFNMo22qQVK82VqbHamy54GpA/45kzS9/l9eCv4
         /e+xY3ZIGhoj85TOchobuRYFfZp5UMGLTLrfoZRtiMftir/5+k6SMIbQlOPyPOCcKSFk
         pSQPpXiRAhvGMN8kcFiKqh+7uyhuJBFbDNtS/OGTF3l7AWnXGdvOGn00ZJAP3k3VPdd3
         G6cQPAxiocLPGyVJmCqmui4id3aIM08nW/t6R+HN0e2YrIkuX5chPn39CTYQqd2eQPgq
         QnGC6tFuuxYlbfyUGs86E8XXKkwgjw9RTp8eqrY1QFtHeb1F7Z9iIbPffIvNIUosr2Sc
         iraQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/Yvp3AbU+sacwrxt473T4XA+ijPqQU4MAharPveRtPPpP0IWBgWDICmUS1L8LzUWi4CF90/MskRx3DZOLv8TdTqYtKnb42m7YE18A
X-Gm-Message-State: AOJu0YxIrDIEEFgJOHPAprkJmhaebNyCpxNoE9TCBsl3W8xQllyHOJfF
	5ven5O7O/8q/Rbi7QMlhP6WZecoNy8Pnt86j1mE/4XHXiZXq9oDVMqPpJMVcJg==
X-Google-Smtp-Source: AGHT+IEQdgN+oxQVY2WhNXlBaGf5tUG6zmnED4R2Bd3ZjsSu6BIoJ+KVjm1A4HgbPn4YL/9IXDzhfA==
X-Received: by 2002:a05:6602:25d5:b0:7c7:c6fe:d216 with SMTP id d21-20020a05660225d500b007c7c6fed216mr6816933iop.15.1709057236921;
        Tue, 27 Feb 2024 10:07:16 -0800 (PST)
Received: from localhost (147.220.222.35.bc.googleusercontent.com. [35.222.220.147])
        by smtp.gmail.com with UTF8SMTPSA id b18-20020a026f52000000b0047477ee4899sm1878140jae.147.2024.02.27.10.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 10:07:16 -0800 (PST)
Date: Tue, 27 Feb 2024 18:07:16 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Yow-shin Liou <yow-shin.liou@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add binding for TI USB8020B hub
 controller
Message-ID: <Zd4k1BlWDz7nmc6o@google.com>
References: <20240227090228.22156-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240227090228.22156-1-macpaul.lin@mediatek.com>

On Tue, Feb 27, 2024 at 05:02:27PM +0800, Macpaul Lin wrote:
> The TI USB8020B is a USB 3.0 hub controller with 2 ports.
> 
> This initial version of the binding only describes USB related aspects
> of the USB8020B, it does not cover the option of connecting the controller
> as an i2c slave.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../devicetree/bindings/usb/ti,usb8020b.yaml  | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,usb8020b.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,usb8020b.yaml b/Documentation/devicetree/bindings/usb/ti,usb8020b.yaml
> new file mode 100644
> index 000000000000..8ef117793e11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ti,usb8020b.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ti,usb8020b.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI USB8020B USB 3.0 hub controller
> +
> +maintainers:
> +  - Macpaul Lin <macpaul.lin@mediatek.com>
> +
> +allOf:
> +  - $ref: usb-device.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - usb451,8025
> +      - usb451,8027
> +
> +  reg: true
> +
> +  reset-gpios:
> +    items:
> +      - description: GPIO specifier for GRST# pin.
> +
> +  vdd-supply:

There is currently a rework of the onboard_usb_hub driver ongoing to
support the actual names of the supplies, instead of the generic 'vdd-supply':

https://lore.kernel.org/linux-usb/20240220-onboard_xvf3500-v4-0-dc1617cc5dd4@wolfvision.net/

I think for new bindings we should wait until this rework is done and the binding
should have the hub specific supply name.

