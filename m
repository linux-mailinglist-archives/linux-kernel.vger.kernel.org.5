Return-Path: <linux-kernel+bounces-44065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A15841CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2DC1C23740
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CCF55E64;
	Tue, 30 Jan 2024 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c1ISUHC/"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216AC53E26
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600878; cv=none; b=Imno02ox71/frM8TXinVxncAp0VAiFbU63Z401jhnLcKDQh5Ip4Slkv7XQGhgGrPHWiMuLXGPOE5BuzAbth+vuXsSdeIpqeWZFHL1Dou/5dQ9EHkOrrWB2R4uAh4BI+nVFJk6i7L62U72MJ40EzrilPCupN9BNqtzwWj0MRzpLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600878; c=relaxed/simple;
	bh=fe9RoJ7uIEL7hCMIEw33xQ4RK3TqAFvgh1skAFVlC+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RvlOm3x18k3j0tACfyKIqk5k5DIzsDsvKSuMMsIjjWRFDKPQMFdNBjI6WZCmAW254Fc058taJIK0tlbyhPWjNOuiuHi3WOTaPxfy/blcDrje0DxEBemNxoDXlOrMbKiZEjMDXCOHtEuvbVAaX7x0EednEAFyVg4NbpFx39TDioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c1ISUHC/; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d057003864so7588361fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706600875; x=1707205675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrrtCIWXL3eiBU/IKZjiGTOMDFzcQj7B56yYFQBrFdY=;
        b=c1ISUHC/CAOMlQULakPGmdjoDYkECksEWpDpMafZBc/2gDLcssChTWGTLpKqQoO0H3
         l7AG4z+4NKSSCwTN5rpfPrtP0oVCRWdA27+AZTQU10+mFDEZ3gUBn0T4fFmubkC8VGzZ
         BpSLVqfc6taYpXNLo+9meQOEVoEFCRpn/PxCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706600875; x=1707205675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrrtCIWXL3eiBU/IKZjiGTOMDFzcQj7B56yYFQBrFdY=;
        b=VBQJVgRL/nO/tYlLuONTBzqDgXocFtoefxeNxZpB7wOQtq46AjIjK2kuFWqUxj396E
         R4AQse42byGacm1OU2LAp4c7YxVJ7GXFvetfX5ahoZRU+FlwEp+qltX8LhCY06ww2UWE
         6UYN9bXmb3K9cT2u2ap35HWwCK2zuP61HN37J4t3W1pbC2LVVg65fWKBk/Fx4IOdJuui
         kKvKP+4KMJOF6DYe5sh4sJ9bJdKCQb66OGHA0QdYvmFSXfUEbakC91LA1bo/FDHWjbfI
         0yV/8DjpF3Q5XCBgfjn3VOUW86v4p1OeTRnpBmzGfdfL+hL1cSIcYsbgl8ccvSi0c5+p
         d9ew==
X-Gm-Message-State: AOJu0Yzcxj+2fPnoV1zZxXvU9tyVejwBBuhQm/W7YYOK1UQpEGMla1zl
	squhZauQOCZCnetUcFjxaQTneOhWAyhKFILenME1R6mcmpEoIErMlx13OEykraMeubLi9jAk2ho
	n1HBmEjVeMF7ICdiouPC4imAql1hqbPPcp3NM
X-Google-Smtp-Source: AGHT+IFXKjnS+us0d6V3OrZKd3SFgNJjm8Z8sdbBJxjxbvtvtuMmj6Rg5rbxK84S2bRJqhxRvRxcNPSPjSDkjD+diCE=
X-Received: by 2002:a05:651c:b07:b0:2cf:4c49:a8fc with SMTP id
 b7-20020a05651c0b0700b002cf4c49a8fcmr6437489ljr.22.1706600875032; Mon, 29 Jan
 2024 23:47:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126063500.2684087-1-wenst@chromium.org> <20240126063500.2684087-2-wenst@chromium.org>
 <74b9f249-fcb4-4338-bf7b-8477de6c935c@linaro.org> <CAGXv+5Hu+KsTBd1JtnKcaE3qUzPhHbunoVaH2++yfNopHtFf4g@mail.gmail.com>
 <21568334-b21f-429e-81cd-5ce77accaf3c@linaro.org> <CAGXv+5HxXzjigN3Bp96vkv71WfTJ1S2b7Wgafc4GxLmhu6+jMg@mail.gmail.com>
 <a4324473-e0c6-4d53-8de0-03b69480e40b@linaro.org>
In-Reply-To: <a4324473-e0c6-4d53-8de0-03b69480e40b@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 30 Jan 2024 15:47:43 +0800
Message-ID: <CAGXv+5HAqmUizXztMH_nY6e+6oQh01hCtxEJXKtCn3_74-sOsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 3:37=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/01/2024 04:32, Chen-Yu Tsai wrote:
> > On Mon, Jan 29, 2024 at 3:34=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 29/01/2024 04:38, Chen-Yu Tsai wrote:
> >>
> >>>>> +allOf:
> >>>>> +  - $ref: bluetooth-controller.yaml#
> >>>>> +
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    enum:
> >>>>> +      - mediatek,mt7921s-bluetooth
> >>>>
> >>>> Can it be also WiFi on separate bus? How many device nodes do you ne=
ed
> >>>> for this device?
> >>>
> >>> For the "S" variant, WiFi is also on SDIO. For the other two variants=
,
> >>> "U" and "E", WiFi goes over USB and PCIe respectively. On both those
> >>> variants, Bluetooth can either go over USB or UART. That is what I
> >>> gathered from the pinouts. There are a dozen GPIO pins which don't
> >>> have detailed descriptions though. If you want a comprehensive
> >>> binding of the whole chip and all its variants, I suggest we ask
> >>> MediaTek to provide it instead. My goal with the binding is to docume=
nt
> >>> existing usage and allow me to upstream new device trees.
> >>>
> >>> For now we only need the Bluetooth node. The WiFi part is perfectly
> >>> detectable, and the driver doesn't seem to need the WiFi reset pin.
> >>> The Bluetooth driver only uses its reset pin to reset a hung controll=
er.
> >>
> >> Then suffix "bluetooth" seems redundant.
> >
> > I think keeping the suffix makes more sense though. The chip is a two
> > function piece, and this only targets one of the functions. Also, the
>
> That's why I asked and you said there is only one interface: SDIO.

There's only one interface, SDIO, but two SDIO functions. The two
functions, if both were to be described in the device tree, would
be two separate nodes. We just don't have any use for the WiFi one
right now. Does that make sense to keep the suffix?

> > compatible string is already used in an existing driver [1] and
> > soon-to-be in-tree device tree [2].
>
> That's not the way to upstream compatible. You cannot send it bypassing
> bindings and review and later claim that's an ABI.

I get that. I can fix up the existing users where necessary. A proper
binding would make the driver lookup be more efficient as well.


Thanks
ChenYu

