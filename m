Return-Path: <linux-kernel+bounces-106135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B518387E9A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A03B2828C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264AA38F96;
	Mon, 18 Mar 2024 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GV3Xzc05"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608F37711
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710766855; cv=none; b=WGW636P9omAEpE6IVJxunUrKfVCBNkIzJn3RLJgTUyIQsdeoBRG2KJ5uMIZVHUHCfGXjfnydhbYqfgOSAIN+tdLmZVMu2CUSdTU4NjPzCoQLzMkEtP2XHkftWOQvqszGV0sDwFyG42B/aMk0hfgjHdSN5EMatmYABdoqEAw4qz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710766855; c=relaxed/simple;
	bh=abNTLKYcLXIhe2eOSU6DyOpFwTK4BPqk/0FE1JzWnEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nE/RoqL9z0KzwVsnzJ6iMTy70QRAuEOQrRVRDBMqqNbdjwRaT1NzRXBT/98iOG0u+4nT5dgk5DggSv7iLHIwqhAYR4NXIfOm6EeYEsfUP4LB20YrTsMzgTv3RM6bWc61MBPZ6hd3/pZWstro6lV0xu2HXfBE7ehn8Z9MiQWkv6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GV3Xzc05; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60a068e26d8so49029067b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 06:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710766853; x=1711371653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=krtW4aUuwrjQ2jkX8A4jBdsmWsZ29REGKZPPhdTh9uc=;
        b=GV3Xzc051a+IMOxl64sp0+Adb7ZzyU1FIVoHo5+HwBYv+0OIlRetEhzjq+hGmRjyB4
         LkUQGdxYdPFargzSlW3uTltnpodcpqxSM1TDGijIBXdQcVNrBrfpuRRalsMycSYiXJfr
         2/B9L78ONJgANslHYrdDAyM+y3+GP2bOiggbIye2QvAN7ULCyF9DbDwN4vl6awoWIYpg
         MW/RaKIREjyeatA5usc7w/f9izGlkY4wNzXa0x3F2xLNIwLNUoHacWoqTvzE5UTC0lCQ
         VP6m1yvkxzLAIjs2Eci0eZOIsCmG6CwU65LicWQbjIyb1DpcjZwkpGv8C3ojzevR+tim
         MT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710766853; x=1711371653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krtW4aUuwrjQ2jkX8A4jBdsmWsZ29REGKZPPhdTh9uc=;
        b=NBSuFCkLpITYPZII2mmHHB7/xQFsmJcdep155yj7cIXtmCI9aRBOptyUx9nDVgY064
         Mo8fqq+KQt+SyskP3nR6W/QleaBALTfJbsNyLfx8QWgYAc3qYv9/yEnMH/J57zmpYoml
         s1bdTPSHhrdmxvlrT1l0NZCAnjViSjRhw2UgQlEW+o1dsjsX9xmEBzOCh8XvcZ9eTeLz
         lyI+rJoF4+Ed10S3jRNOGDwJ/DzpNhjsvRUn4Yo7HJmBMJA3TbxOqn1g3Bpk2Y+r9y9R
         9D38V1XUcmWUVbFLoJW+3gFoUPTzUAlmIAjYXtV8ihy//v7RoZO56CJAJif8dvYmpdrs
         95Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVhk0Qz4XSRpWsDaiQve01eGiuIfcrX/8wkwHqVHrZE6N90FtteFey9CMsuwDtWohK/YiS5UySLVX4Ldplb6s3wcKTNpLVxVtWHV/Uy
X-Gm-Message-State: AOJu0Yx3uXvgr91uKJJlEm/uj3VJNjgWBLPqK2Q8NfcFklDjRSHcHyTK
	r99HXpcqtQJ4y0WELRiOHaDc1zPwSPEJvnJvLc6zL3XXkdMh1/O/2voJeHlzQI1WGiBLOj4SE1D
	gDn33ChheZvD7sG47HxyDXl3Lg8t4F5FnaMC5ZA==
X-Google-Smtp-Source: AGHT+IHNIqyRYAx97Bsm8icZ7FibD5CfXZy6+AclCn9jOAbIEUGiVoB04TJFOEhgeti/W3RP6sRcFIurJfwvOEdKwzA=
X-Received: by 2002:a5b:845:0:b0:dcc:96db:fc0d with SMTP id
 v5-20020a5b0845000000b00dcc96dbfc0dmr6407441ybq.25.1710766851867; Mon, 18 Mar
 2024 06:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318110855.31954-1-johan+linaro@kernel.org> <20240318110855.31954-2-johan+linaro@kernel.org>
In-Reply-To: <20240318110855.31954-2-johan+linaro@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 18 Mar 2024 15:00:40 +0200
Message-ID: <CAA8EJprywWbdoyfAbys=0WzEdAkp0UK1fzzCPzxKRjyk9DrC6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: bluetooth: add new wcn3991 compatible
 to fix bd_addr
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Doug Anderson <dianders@google.com>, Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-bluetooth@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Mar 2024 at 13:09, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Several Qualcomm Bluetooth controllers lack persistent storage for the
> device address and instead one can be provided by the boot firmware
> using the 'local-bd-address' devicetree property.
>
> The Bluetooth bindings clearly says that the address should be specified
> in little-endian order, but due to a long-standing bug in the Qualcomm
> driver which reversed the address some bootloaders have been providing
> the address in big-endian order instead.
>
> The only device out there that should be affected by this is the WCN3991
> used in some Chromebooks. To maintain backwards compatibility, mark the
> current compatible string as deprecated and add a new
> 'qcom,wcn3991-bt-bdaddr-le' for firmware which conforms with the
> binding.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../net/bluetooth/qualcomm-bluetooth.yaml     | 29 +++++++++++--------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> index eba2f3026ab0..b6fce6d02138 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> @@ -15,18 +15,22 @@ description:
>
>  properties:
>    compatible:
> -    enum:
> -      - qcom,qca2066-bt
> -      - qcom,qca6174-bt
> -      - qcom,qca9377-bt
> -      - qcom,wcn3988-bt
> -      - qcom,wcn3990-bt
> -      - qcom,wcn3991-bt
> -      - qcom,wcn3998-bt
> -      - qcom,qca6390-bt
> -      - qcom,wcn6750-bt
> -      - qcom,wcn6855-bt
> -      - qcom,wcn7850-bt
> +    oneOf:
> +      - enum:
> +          - qcom,qca2066-bt
> +          - qcom,qca6174-bt
> +          - qcom,qca9377-bt
> +          - qcom,wcn3988-bt
> +          - qcom,wcn3990-bt
> +          - qcom,wcn3991-bt-bdaddr-le

This compatible doesn't describe new hardware kind. As such, I think,
the better way would be to continue using qcom,wcn3991-bt compatible
string + add some kind of qcom,bt-addr-le property.

> +          - qcom,wcn3998-bt
> +          - qcom,qca6390-bt
> +          - qcom,wcn6750-bt
> +          - qcom,wcn6855-bt
> +          - qcom,wcn7850-bt
> +      - enum:
> +          - qcom,wcn3991-bt
> +        deprecated: true
>
>    enable-gpios:
>      maxItems: 1
> @@ -122,6 +126,7 @@ allOf:
>                - qcom,wcn3988-bt
>                - qcom,wcn3990-bt
>                - qcom,wcn3991-bt
> +              - qcom,wcn3991-bt-bdaddr-le
>                - qcom,wcn3998-bt
>      then:
>        required:
> --
> 2.43.2
>
>


-- 
With best wishes
Dmitry

