Return-Path: <linux-kernel+bounces-107777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD55E880187
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7311C22CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA25823B8;
	Tue, 19 Mar 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ES9j3iV2"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDD281AAA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864643; cv=none; b=dQbiH9cQF7g1kUTo75d1J/BhWcS1vxC41oZNHGge4WWN0kEVPQHmaHeWG/QqWcGERZBMAmpI3RD2iONLEGfYZ1rOCWDpYbamFOO2SAOWNvpwMW8yAh/+ekqrLGmt6KVeeD/e5syjPp7VvmcKgu4gu41vMs6sMfEOPLa7LyzJ2aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864643; c=relaxed/simple;
	bh=4BDyA1fp80l7JzPfJ1e9Vcia9HkvY/RtUdxfuRXBrig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQthsZmLCDD+ixrtOkGGrNDy9PODWRlFnn7LTgnUpKfTxynv9vTP+8Salu3Bw0xp2+xLuwZ6IhED879h3lQPf0munZ7+LWyDgfU1QV3gEc1xqUvb772mA+L1Qn5R9E23jx8NEt5SuNooXCj0D/2QaijLC5PiJqp2ILl+0Gwq+3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ES9j3iV2; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-69629b4ae2bso11166566d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710864640; x=1711469440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L6WBF/yO8q1qFXY+u+U+qwB52PYKW+UCvdVhNRdhUs=;
        b=ES9j3iV2JBRMkvAan48pxSiBUveza/4c9K0/dDfwc09aOzmZdkhz1smErukihYnfuj
         NOoc4XxH9Je0U6HtJWckEac3HeoMmqKcVDGP9CEe2H5MT1YtM1IJyksu6P377sGaEXrh
         GRfCrPYB1a+6U9elDBRxvJS3okcwMc4hdktyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864640; x=1711469440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/L6WBF/yO8q1qFXY+u+U+qwB52PYKW+UCvdVhNRdhUs=;
        b=CqU9UH+G3OTYHxxNDJoARq11fRelS3f/RyrcrbMH2S/XfOUtV+8ZMZ3Kp5/4rsrdrN
         YCoC0RQxc1kzjsl/AhIZA4sCC7weINAS+76eAFu8HBKYwWgn4YwG18Tr9kBZPDOI1m2+
         CWrRwG92UO/LEY3NgtjzLChOQQZ5qV8y1fACNRhg6ZYfcvM9fhZVwtMwotIyYfB0/P04
         DrE1gXU8H+Nq9BTiXWudg9a+GvMB+Eg+d1Ghw56CYBJh5mu8wTmGGYajonb5/n5yL2MO
         XFGJGn81ky1hY6XpT6nqfUEmmT+JvNUvy1vsn6Ll5n6blEyHZ3j6j5u0KiC/FTLud2WJ
         AfjA==
X-Forwarded-Encrypted: i=1; AJvYcCVth5bf6Y3b+7LXRVQdMZ+2LQpQFxLQDYKeIiFt0ljnVVOyGMWsI5svYa7LTFubMIEyU+Cnso1JHPxzAIhlPz8xqRGs/AC4Cu3UVU/0
X-Gm-Message-State: AOJu0Yxcz92cjrSZHkqv9Vb0PKSpD3CrjBdk/ecMVUVylSex+Bxn1FnL
	bQWYtW2lOo5RJkdfV+KTrWUc5s4hmU91Os1r9yHrxHSmsh4qfdTQKJXlvMNG92x6IsujzgDcnH8
	=
X-Google-Smtp-Source: AGHT+IEGJ4tvnECaFLRPDRGEXL+SLBm1FuFO6nGn3IBhDdr/yXapv6s8hXx4ga5c/gxiw8WbF9nOuQ==
X-Received: by 2002:ad4:4bcc:0:b0:696:31ad:e6e2 with SMTP id l12-20020ad44bcc000000b0069631ade6e2mr2731264qvw.49.1710864640558;
        Tue, 19 Mar 2024 09:10:40 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id x8-20020a0c8e88000000b006915f47090dsm6482520qvb.68.2024.03.19.09.10.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:10:40 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-430e1e06e75so434781cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:10:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4xYTF9sqGrNGG3hWEoWeoig2dag+5Q8zeBMU+EHvr8mgS9fyutDIOdbL1DuUtQFPkkEJz6cCqLAfKTRo0rkDyRl9SkbfXuaHrMVAv
X-Received: by 2002:a05:622a:11d5:b0:42f:3b05:dc8f with SMTP id
 n21-20020a05622a11d500b0042f3b05dc8fmr390619qtk.8.1710864639829; Tue, 19 Mar
 2024 09:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org> <20240319152926.1288-3-johan+linaro@kernel.org>
In-Reply-To: <20240319152926.1288-3-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 09:10:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VUFodCAXEJgfpSqZZdtQaw5-8n_-sX_2p6LuQ2ixLRpQ@mail.gmail.com>
Message-ID: <CAD=FV=VUFodCAXEJgfpSqZZdtQaw5-8n_-sX_2p6LuQ2ixLRpQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] Bluetooth: add quirk for broken address properties
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
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 8:29=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Some Bluetooth controllers lack persistent storage for the device
> address and instead one can be provided by the boot firmware using the
> 'local-bd-address' devicetree property.
>
> The Bluetooth devicetree bindings clearly states that the address should
> be specified in little-endian order, but due to a long-standing bug in
> the Qualcomm driver which reversed the address some boot firmware has
> been providing the address in big-endian order instead.
>
> Add a new quirk that can be set on platforms with broken firmware and
> use it to reverse the address when parsing the property so that the
> underlying driver bug can be fixed.
>
> Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device addres=
s")
> Cc: stable@vger.kernel.org      # 5.1
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  include/net/bluetooth/hci.h | 9 +++++++++
>  net/bluetooth/hci_sync.c    | 5 ++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index bdee5d649cc6..191077d8d578 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -176,6 +176,15 @@ enum {
>          */
>         HCI_QUIRK_USE_BDADDR_PROPERTY,
>
> +       /* When this quirk is set, the Bluetooth Device Address provided =
by
> +        * the 'local-bd-address' fwnode property is incorrectly specifie=
d in
> +        * big-endian order.
> +        *
> +        * This quirk can be set before hci_register_dev is called or
> +        * during the hdev->setup vendor callback.
> +        */
> +       HCI_QUIRK_BDADDR_PROPERTY_BROKEN,

Like with the binding, I feel like
"HCI_QUIRK_BDADDR_PROPERTY_BACKWARDS" or
"HCI_QUIRK_BDADDR_PROPERTY_SWAPPED" would be more documenting but I
don't feel strongly.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

