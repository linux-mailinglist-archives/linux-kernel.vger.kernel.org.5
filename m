Return-Path: <linux-kernel+bounces-107776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1FE88017F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE561C22D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FD181AAE;
	Tue, 19 Mar 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OC1QkiCv"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174C67C0A7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864629; cv=none; b=losdP/fSGxmrVW2qFy33hDJ4BkbuKhRoNqeL5oAJrt9Up5gPW3BnUrdvbOSJUl3fSzjUwhbO8tmW0dKTPQticRBJaadd00M7fH/kGS3jEYso25EE3oic1XloaUIlRwuwwZy0b9WGc5rp9PwA5uXcHq21dP92l4gkMmGkoIkvL3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864629; c=relaxed/simple;
	bh=FWs6LFKM/xcvvgakZ39skUFNVfNPQgC7Bo//2KPJp+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CP1SSMtanBS40x6dTgkFsusXmyIQ3LUoV7dDEesvOeJbNqRD1IZKLRSqQ3I7nEM11qhlnet8TVHehh+XBQlGntb4oEEf15m04BmX7budhwL/dwJG9BRijilMM1FHqRziYtbiJAbFnOYNGjGGnW9VN2gAuqdjSKwYc7pPvLfe5o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OC1QkiCv; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78a01a3012aso150856485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710864627; x=1711469427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Suh5QCHeNsdbI/6JZV91e5lppTR9YIcMyoALsn6PjZc=;
        b=OC1QkiCvf841xMG0qJiz9fHUOQ0aDpCXlNCuj3RuDl+cbtWdwNnVJ9AIsuoHdFMJmt
         msug8Yu4Qnt/n/jvDvQErD1qgYCKe5YUAuVf/vnAEXXqnIJUReNT6KVEf//dwEc2PJHE
         /iwsclNAVFoiUDKTlC4kFJrGBamAfoO8R3DLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864627; x=1711469427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Suh5QCHeNsdbI/6JZV91e5lppTR9YIcMyoALsn6PjZc=;
        b=pfx3/6OThhOimbOoytkpL5tjOIYiYXrLKW33WNxTp00ONxFaujp0oePTqeeEKfBBu+
         RfgGFWIbXy9BXvki3nONjhYGLhfoDh3o3OE13AA6Kt3FiY/qBUS9iQBuEfbmDYwwcNaj
         JVZs+t2Kk3EPulMI2bidnCLdzzJ5J/hh/XFM83dR181L+ZqjdOfgtdDVe8MaGXPTaCoY
         IKY7A3R7j4/+jLsOyfhK3mOZyF1TS8PUcPl5OPROB/LXrGL1HzLRDac3eALIw8N7QlMU
         juP4rxOd2Y+w3eO2NwQ0SpAuqsFFwbh8wN5yeOMYQgxZoQs1f+gUglAATWxhiIdGJtql
         ZbsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwyCtqVZMlBlJGeefzeTLAzUnAIXDNN9QDRFb9+Bf6LgyWcmzmR3y1zgIL2MXPqbDb15awwxiLM79wkHsfRJf2K4rJPsJsVhTHWDL3
X-Gm-Message-State: AOJu0YynTACqwiCGt1LrSueO2NwIGhfyeTFCz1tMavqmhd7vat0R7HrP
	1HQupiSLd7bpL78kP/ZXZdrNvx+9nJ0xrzMHqNcHdJDjfsfnmJJSZ+/bJ6BMGMMz5nCxMG729lk
	=
X-Google-Smtp-Source: AGHT+IGRR/WT7tJlFJsWt/M/AqkwKTGQSNVMLhrhKGixgyJkr09f2dwN1xNl/H33qo6nPgAtiODU4w==
X-Received: by 2002:a0c:f309:0:b0:691:3d90:15d8 with SMTP id j9-20020a0cf309000000b006913d9015d8mr16912101qvl.64.1710864627038;
        Tue, 19 Mar 2024 09:10:27 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id ke18-20020a056214301200b00690daede7f2sm6596981qvb.54.2024.03.19.09.10.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:10:26 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-428405a0205so373901cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:10:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0VxxFBl5h/FbUwW0XshOCNfvSy+DKrMnqIkvr79JYwiHwyk4G8quLc/H/xIbnLutsFzUphCxVFuvm9w42OsQYW2l4ISgslfq928d2
X-Received: by 2002:ac8:5991:0:b0:430:eb3e:d599 with SMTP id
 e17-20020ac85991000000b00430eb3ed599mr197066qte.28.1710864626281; Tue, 19 Mar
 2024 09:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org> <20240319152926.1288-2-johan+linaro@kernel.org>
In-Reply-To: <20240319152926.1288-2-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 09:10:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XJ+yAvDn5NyfCSJdg+DujPrWO+DZu=BmcqbJS-ugEGMg@mail.gmail.com>
Message-ID: <CAD=FV=XJ+yAvDn5NyfCSJdg+DujPrWO+DZu=BmcqbJS-ugEGMg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: bluetooth: add 'qcom,local-bd-address-broken'
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 8:29=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Several Qualcomm Bluetooth controllers lack persistent storage for the
> device address and instead one can be provided by the boot firmware
> using the 'local-bd-address' devicetree property.
>
> The Bluetooth bindings clearly states that the address should be
> specified in little-endian order, but due to a long-standing bug in the
> Qualcomm driver which reversed the address some boot firmware has been
> providing the address in big-endian order instead.
>
> The only device out there that should be affected by this is the WCN3991
> used in some Chromebooks.
>
> Add a 'qcom,local-bd-address-broken' property which can be set on these
> platforms to indicate that the boot firmware is using the wrong byte
> order.
>
> Note that ChromeOS always updates the kernel and devicetree in lockstep
> so that there is no need to handle backwards compatibility with older
> devicetrees.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml  | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-blu=
etooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-blue=
tooth.yaml
> index eba2f3026ab0..e099ef83e7b1 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.=
yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.=
yaml
> @@ -94,6 +94,9 @@ properties:
>
>    local-bd-address: true
>
> +  qcom,local-bd-address-broken: true
> +    description: >
> +      boot firmware is incorrectly passing the address in big-endian ord=
er

Personally, I feel like "qcom,local-bd-address-backwards" or
"qcom,local-bd-address-swapped" would be more documenting but I don't
feel super strongly about it. I guess "broken" makes it more obvious
that this is not just a normal variant that someone should use. If DT
binding folks are happy, I'm happy enough with this solution.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

