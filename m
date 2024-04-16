Return-Path: <linux-kernel+bounces-147327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81E98A7291
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D5D1C20F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7AD133435;
	Tue, 16 Apr 2024 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VguIuLX/"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21166131737
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289419; cv=none; b=Wlunv5LVhuxc5U08+R9qKN0qdveoMERrIojdbwNcTjoNr5shKVfutwWpABW95O39aDqEp45bO3/7bJ6BhfpBSpEpyhJyfG7Thq0I0v5vL2g+fY1bftooITyzWWNOW8Yr3hl8y7CUGBH0VF3QSZBWO2wCsEaKed1XZQL/OYnX2Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289419; c=relaxed/simple;
	bh=6dBR7/U90ulcku8SAcSbBXZb2GmWWXMQ7JiRkQprz9Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jnAQuShx+p/lfYPAB54ehx3e+ng8ZmC+yp/D4dHLOs+fCwpxb2R1mLN15Yb3i3zg+YOXKWHEnNKpmGP4Yr26wTm4VQ/ex4OAXNUtYHQaUPAPGV2SojpIqVW/uiPVE5/61iuhpKBvrLe4XVeE44BT3DJG/9hPYkUa2RnGS+RcXgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VguIuLX/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ece8991654so4229897b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713289417; x=1713894217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUEau/pEpt9AkOO4LFO9sGSkzJlYdG9OShqBDzpNMbY=;
        b=VguIuLX/nA9Nz1vWtjUDhv2rgYjxF3XnrJgZdvfbavfhtNaWu47OnJxxKR1shAjnx9
         0ieZ1/hP0YGk3q3MRNpU+eaPycgDlA9bf0paD2VYvkn4tO6DCyzHJUDIViynXvf9JGnJ
         hlZW+0XK23+bGh3XsxHgYOsZueGngC5N9FbmeMoes2Q0eyxBG8rHtqiMdCIc+5aRT4xP
         X7AsuahYXfcqN+7wnmJr6t4FyUT8wWCmudFhbD6wWLgJyGCxwj7J7FeJrj9xXNE3vpk5
         iNeXFmRENBI8dvQHH1TfxbQ2K6LLh1eoNS34ieA4VTbNzLBIS4iIs6z4DfNqzmAlIAv4
         +mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713289417; x=1713894217;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eUEau/pEpt9AkOO4LFO9sGSkzJlYdG9OShqBDzpNMbY=;
        b=Ao2ap0X2Nnusc8OSKXRbbDOd22ZxMUhaEQvss3JlT8bAy+xs4SMtY8Twq3vdQparLr
         UGxFJXaLiLeQdNvsXNPGr8MmMeVSTD6m7N/M3PIuaUkiIZIg6Fchu9DgLaGa1CRAtmsZ
         nf3XRGbWSP3levkDkVNmxWHPSPyPzxIHDyOBkb1JHu3gESWfmsuclPGaddmBgns9AlC8
         j2O9OAjwePLZsHeTBuXElhi2ko+V27/5/2GfRWGq1KfJ4fH5BxsUSZ1F6rUL4EdcPSG1
         rgphtnDGeJ5A4sFYNMlAs9x5T2sVfBJPRVhoyl0RwwF1YWbNvlU74t29yeFKExxuRVMe
         hcVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlE74YjRx9uDoAWsySKD6duuD9Eg/rN1FSDXUbpkRfJ77AfcGzrmr3YqBzBlPflc9gC92/ngbiw+HpJLuq2XZ8GW7OgQEnNdQpkz78
X-Gm-Message-State: AOJu0YwggQGWzp0DUCaiZBRSOTY6IsMDVUCn7kSusw7Ofwni15rrY+Bw
	SFX7D62bsL67/MOBWNEoGprqHwvltIA69lz9aZQ++YzLxjh4/AnzsoQ8t7k7G/Q=
X-Google-Smtp-Source: AGHT+IFRHoGMcojV7sRgDp2sh67vGhlINTD73jHd6Lrwp10g0HQj6Lso/F+xzibAylchEXJh5urGzg==
X-Received: by 2002:a05:6a21:2791:b0:1a8:4266:3d02 with SMTP id rn17-20020a056a21279100b001a842663d02mr15369692pzb.30.1713289417249;
        Tue, 16 Apr 2024 10:43:37 -0700 (PDT)
Received: from [10.36.52.145] ([24.75.208.156])
        by smtp.gmail.com with ESMTPSA id gx13-20020a056a001e0d00b006ecf25d0b8dsm9284521pfb.184.2024.04.16.10.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 10:43:36 -0700 (PDT)
Message-ID: <6a05d4ff-1f27-4b7d-88f2-050288d8dc7b@linaro.org>
Date: Tue, 16 Apr 2024 19:43:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 8/9] drm/panel: novatek-nt35950: Don't log an error
 when DSI host can't be found
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 owen <qwt9588@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Adrien Grassein <adrien.grassein@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Sam Ravnborg <sam@ravnborg.org>, Bjorn Andersson <andersson@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Vinay Simha BN <simhavcs@gmail.com>,
 Christopher Vollo <chris@renewoutreach.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
References: <20240415-anx7625-defer-log-no-dsi-host-v3-0-619a28148e5c@collabora.com>
 <20240415-anx7625-defer-log-no-dsi-host-v3-8-619a28148e5c@collabora.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240415-anx7625-defer-log-no-dsi-host-v3-8-619a28148e5c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/04/2024 23:49, Nícolas F. R. A. Prado wrote:
> Given that failing to find a DSI host causes the driver to defer probe,
> make use of dev_err_probe() to log the reason. This makes the defer
> probe reason available and avoids alerting userspace about something
> that is not necessarily an error.
> 
> Fixes: 623a3531e9cf ("drm/panel: Add driver for Novatek NT35950 DSI DriverIC panels")
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt35950.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> index 648ce9201426..028fdac293f7 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> @@ -556,10 +556,8 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
>   		}
>   		dsi_r_host = of_find_mipi_dsi_host_by_node(dsi_r);
>   		of_node_put(dsi_r);
> -		if (!dsi_r_host) {
> -			dev_err(dev, "Cannot get secondary DSI host\n");
> -			return -EPROBE_DEFER;
> -		}
> +		if (!dsi_r_host)
> +			return dev_err_probe(dev, -EPROBE_DEFER, "Cannot get secondary DSI host\n");
>   
>   		nt->dsi[1] = mipi_dsi_device_register_full(dsi_r_host, info);
>   		if (!nt->dsi[1]) {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

