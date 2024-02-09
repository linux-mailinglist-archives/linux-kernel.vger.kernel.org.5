Return-Path: <linux-kernel+bounces-59539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6992684F893
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FED2281E67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9064F69DE5;
	Fri,  9 Feb 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lzceSyQ4"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339C07319C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492617; cv=none; b=jealmkVkDM53Y5Vp9SsD4uPcGhrcgLRGWLU6/LIs25LFkNdnp4rtw8mgj9BlP2ZV0rHG8QRXB1zNR906oqUzZfCVFdbzH98E+T8e3mBHrBa+Iut8os3z1sH7JHOSQ8ZBkBmKXoPPYx3VjBwtpzspMDgWjM7zXoGXa0BRl3oe0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492617; c=relaxed/simple;
	bh=UqDosga1xC4Eo58FYnE3NbWtCialyNbi3wKAbIbdzRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWBTeQUmHrLyDKRP834qjcMp+a3hJzdxLVXgCXR9lgfHCZvY/JxB6t1pdPO3h2JRplzxwZx9L3ouriTXgc3ON8azEbteitOIE7aKbJzBgHNUgOoQ1tLn3Q4DdBrqwCTjUIvXVoWtUFApQ7HsvJrzoFV3U9jvAV0KF2ANN1E7EOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lzceSyQ4; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60491b1fdeaso12072367b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 07:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707492615; x=1708097415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DwPyne/Srr/E0bqYu1xMZ7k+F7q7JB1awfFG2iwj5SM=;
        b=lzceSyQ4FApxjhpXFcUKulGr2Bg+YaO4RooXHeWRKmqQcPfXMxbzBTt4Lu93vNQ+HE
         H0mwuz/zHHcBysPPuT1p4E/HsE+YZ9cE0xw4Skb2YTkS2tBSk8JcXvxZ6BPxwI0o4fkN
         Txd2DpyBpVBne8pYj/+WDsVO7qO6lknBNCUndx6vv2IQQZE2ogO/CMyF9HdaX1U7ZPIo
         q0Q/cFn1M9NwBGoEgubnILbRQwDnPcGfX3YfAh8eX0fSKka0cthSAs3cYJ76Qz2yv+Xh
         qM3ydZEHcKLHo4thBSoFDlgSukvKrOAkv3axTOqBZvmmfBPBYeoHa9bZ9rTLUFynkWD4
         a0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707492615; x=1708097415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwPyne/Srr/E0bqYu1xMZ7k+F7q7JB1awfFG2iwj5SM=;
        b=dHILOtq1clMZPdvtLcmSdWkc+wMJQBLWuFa47Qt8IcW+IgAXNWc5+5IrS91zp5t8I8
         WOk/U9ssGZq5IYadBan92YzJiR6y9Ag0JVWr5DsjnH+4MbBtokXpCVOzzpNNyYOiw1VZ
         U29WZZ4k9HwzZwQGGSJc4Z9WtIgyvstRNfQ3FpHFVrxdsaZXyHpeJj4ZUXTcsmNYCidn
         0XVLZUFSpitSmupc+2x5yrWajSvxJ8bpIPWtdYH2H8BJLQjVQmrJDVeT3HvnJBkSP1eV
         hBcQuo62v15UdYHVHYYNVXd3l8O4mepkWzmDQ7JxLbvH6D5IQuhR14e0LFq+DHeDboBK
         8BmA==
X-Gm-Message-State: AOJu0Yyg9BWBWIoFSGnWkPCxRq9W03NyR2LOHO/skiALldfSsO7xXZwK
	HCwoSbSJXIvaW71wF9RJOncTOD3eJp72OeO7PQLhXGZMDT54MLk4NDr8j15t52CLpgA3n8Ta+Zt
	dhvZs3qAaO2iUc38YpqpecGDQYfFUIP/jNrDNjg==
X-Google-Smtp-Source: AGHT+IHKpJlDohaMbxRWC+5/t8hSxuj+YTX27ZF5QMSJPTcosnKN65Lc9QOWzjA950A7MwAeqivc87GvLixD28RNDbI=
X-Received: by 2002:a05:690c:2711:b0:604:cb07:b37 with SMTP id
 dy17-20020a05690c271100b00604cb070b37mr958456ywb.33.1707492613963; Fri, 09
 Feb 2024 07:30:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-phy-qualcomm-eusb2-repeater-smb2360-v1-0-af2ca4d95a67@linaro.org>
 <20240209-phy-qualcomm-eusb2-repeater-smb2360-v1-2-af2ca4d95a67@linaro.org>
In-Reply-To: <20240209-phy-qualcomm-eusb2-repeater-smb2360-v1-2-af2ca4d95a67@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 9 Feb 2024 17:30:02 +0200
Message-ID: <CAA8EJppwOjKaRJXj2Re0mugcguAcTZnvEqp_6x-FANrJ__PRTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] phy: qualcomm: phy-qcom-eusb2-repeater: Add support
 for SMB2360
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 17:14, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The SMB2360 PMICs contain the same eUSB2 repeater as the PM8550B,
> so add dedicated compatible for SMB82360.

"...same repeater as the PM8550B, but requiring different settings..."

With that fixed:
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> index a43e20abb10d..68cc8e24f383 100644
> --- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> +++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> @@ -88,6 +88,12 @@ static const u32 pm8550b_init_tbl[NUM_TUNE_FIELDS] = {
>         [TUNE_USB2_PREEM] = 0x5,
>  };
>
> +static const u32 smb2360_init_tbl[NUM_TUNE_FIELDS] = {
> +       [TUNE_IUSB2] = 0x5,
> +       [TUNE_SQUELCH_U] = 0x3,
> +       [TUNE_USB2_PREEM] = 0x2,
> +};
> +
>  static const struct eusb2_repeater_cfg pm8550b_eusb2_cfg = {
>         .init_tbl       = pm8550b_init_tbl,
>         .init_tbl_num   = ARRAY_SIZE(pm8550b_init_tbl),
> @@ -95,6 +101,13 @@ static const struct eusb2_repeater_cfg pm8550b_eusb2_cfg = {
>         .num_vregs      = ARRAY_SIZE(pm8550b_vreg_l),
>  };
>
> +static const struct eusb2_repeater_cfg smb2360_eusb2_cfg = {
> +       .init_tbl       = smb2360_init_tbl,
> +       .init_tbl_num   = ARRAY_SIZE(smb2360_init_tbl),
> +       .vreg_list      = pm8550b_vreg_l,
> +       .num_vregs      = ARRAY_SIZE(pm8550b_vreg_l),
> +};
> +
>  static int eusb2_repeater_init_vregs(struct eusb2_repeater *rptr)
>  {
>         int num = rptr->cfg->num_vregs;
> @@ -271,6 +284,10 @@ static const struct of_device_id eusb2_repeater_of_match_table[] = {
>                 .compatible = "qcom,pm8550b-eusb2-repeater",
>                 .data = &pm8550b_eusb2_cfg,
>         },
> +       {
> +               .compatible = "qcom,smb2360-eusb2-repeater",
> +               .data = &smb2360_eusb2_cfg,
> +       },
>         { },
>  };
>  MODULE_DEVICE_TABLE(of, eusb2_repeater_of_match_table);
>
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry

