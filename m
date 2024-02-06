Return-Path: <linux-kernel+bounces-54432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C9884AF28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEDE01C2283C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6978E1292CF;
	Tue,  6 Feb 2024 07:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wz/p+2IG"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2E83CCC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205482; cv=none; b=K93/WYNcinFXIhxk14+50V6VTZ3+g+Qtf/Ol6aWoSgMOl7CwIo7dDrh0GUwT43OfL4W2gdff0nMq/vRE6cWNqBAh0KaK2NT7RIieVKFLJCECxjFF/07oKRNWWnT8AtaZxTmctspEYTMThs8P4GRFMNZOjEG7lWpgZj/HfbMJSFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205482; c=relaxed/simple;
	bh=MMO0nb+mhIpXzBxch5rO6Rnf9Jsp7Xz4SS0UvLbFdto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2wB/jc+Jo5HkffaPTxSyMSkDWbVuhhQt33wcDmLF35eLoH7WSKKutdqcGpDGCKPUeDV2t9PNmVDJno2uE/1xaI9EyL3xYx619zW4CkE8ncD7u1ekwjgMFSPorjDOXSrswi+Sb+xiLGeq1rvSQyabpLubfxioynIhSzGs1xmKRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wz/p+2IG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fe59b22dbso1193235e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 23:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707205479; x=1707810279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0WeCVc3Xy5LzBxQFmFZkkebGxkvRIyxLO65flM/+HY=;
        b=wz/p+2IGiq6Ul6KVx+bimiM0T/2FK191XxEzqUIZhu+wD9JKd4ChC60Kqt8pDJrSya
         bxNO+nzK1d9jg+vhzvr4Mc/REI7qJQPLG5Sbd315mJDHgns18no4/dXzQ0yvJjdjXzYu
         IpQJ4A5Dk5Q9L//NS0ulwdlDnhyslDXv4eGeh8zO11v2IaCxudMlbTJmznLJXdeIx9t+
         AkwQwXCBQl/LMEvdDN/PsiPW2XMgOUsqQ3d0lhXwBqiaTGKu7D451X4EORKE9uKq6ULh
         gw5qNZpwipDYPlPy3LCutanqwUJrjj4NPsC23dDPJDS6BlvkIvfoNI6o3B3uY3ETK1Hg
         8V0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707205479; x=1707810279;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0WeCVc3Xy5LzBxQFmFZkkebGxkvRIyxLO65flM/+HY=;
        b=a+fcEgTvF1aduOGF9m35/Uz55Q9JkQ+nogbmkaR02GxNKhuwaNYtnsu4cfkyJOlF6d
         ilYTVVdEXqWsalWiikIwLWSnaVXQRQSE+T4hU+zKbo0tiXmLYLfDzZEpjkRVM3GIkv/h
         NnIvusT26aRbPfEChYR1tY+p37nz5KKQK2IRjK2NT/gaw5f0o2Azz/UgQjQJDESrSLUt
         eYMCk1qB+NB+J803EgZg0WYVHQQ6VLQ20LRAkD+CEQcWmmGc1Pf+iw9MnoisffpKjvma
         QkdP208OIvVMGqkzNxXe8WHMqOHXeWBG0+oRYz3+4s97pmdYLDQtYGW1t9y3XW3mDpBV
         A2SA==
X-Gm-Message-State: AOJu0Yx5mq3gHMdBHUk48bd6B7ywvbOFbyNtv8rgV1zE5brbn+uvCYnB
	u12ICGLGrnetAynBwf9/dEgFYbM+LvOEX4T0A3f+ZK8IkMnxvEH870sO2ixyqpI=
X-Google-Smtp-Source: AGHT+IFqpptrgMpOkgJOP7OKq/xbJEByKZA+9K3FDINH4OupJjGXuLho3TynRA/pIW+iWO20AuoZKg==
X-Received: by 2002:a05:600c:a48:b0:40f:d3d8:c8d5 with SMTP id c8-20020a05600c0a4800b0040fd3d8c8d5mr1661548wmq.9.1707205479020;
        Mon, 05 Feb 2024 23:44:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXYDKhFyiut2Pe7qsRdpBWZ74QP796Z1DdDdmMR/ki+VcijOmk6bMcX89boUG35kqAiadIdArUcIZHHByJbtRAmWqCRoqdXQ4LnqiPPgHGY8c6l0JTzTCddO2xBS0XLpgy53rRdn44h92p4B9kyftE/MvdKOh/ob8WzHwiLtrdi2m3+iXW0WzKQ9ofWIuwH/CJKHoM6JnH38RJ1OpJTh+EvNGDAa746qDfA8B+ikDRL2LpMn08TjSDY+bn/G329Wxt+Ju9KrD1WAVrmsDITh0JVrS39arlUBtUzJw+eECONvBGS2kO5QwA+RRyiDCqIt5QmxlffAjbjjNyb/QDoemPkjsM9uZWKaea0eVYSJ+Xk7bB1WsP3R1J60XSiF8wyzINe4USULqT5f2yByhwnQa4vYZ7DHSu8sD63ZPfSvx0w7BcN5scezkNxGhjUNTcLxyvaRj8wXtgc83Irue+5N35RbWFQRwDaGYafZ9M9M31mvdrh39ynw9XJiEiy6G3eONixFw==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c1d8400b0040fe930b52esm432456wms.9.2024.02.05.23.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 23:44:38 -0800 (PST)
Message-ID: <fb9767e0-c5a8-448f-b3f7-e6f81ef008e6@linaro.org>
Date: Tue, 6 Feb 2024 08:44:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Add qca,spidev
Content-Language: en-US
To: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>,
 Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Naresh Solanki <Naresh.Solanki@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Yin <peteryin.openbmc@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Michal Simek <michal.simek@amd.com>, Lakshmi Yadlapati
 <lakshmiy@us.ibm.com>, Lukas Wunner <lukas@wunner.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Fabio Estevam <festevam@denx.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240205191828.998783-1-frut3k7@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240205191828.998783-1-frut3k7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/02/2024 20:18, Paweł Owoc wrote:
> Add Qualcomm QCA4024 to trivial devices.
> 
> Signed-off-by: Paweł Owoc <frut3k7@gmail.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 79dcd92c4a43..50efbdf2a735 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -309,6 +309,8 @@ properties:
>            - plx,pex8648
>              # Pulsedlight LIDAR range-finding sensor
>            - pulsedlight,lidar-lite-v2
> +            # Qualcomm QCA4024 Multi-mode Bluetooth and 802.15.4 SoC
> +          - qca,spidev

There is no such hardware as spidev and you even mentioned it is called
QCA4024, not spidev. Please don't use that name but a real name.

Also, I have doubts that Bluetooth is a trivial device. Such devices
need supplies, have reset/powerdown GPIOs.

Best regards,
Krzysztof


