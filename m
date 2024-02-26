Return-Path: <linux-kernel+bounces-81363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4748C8674EC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 628C6B259DF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F283604D3;
	Mon, 26 Feb 2024 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Djy+2Vc6"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8305604DA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950468; cv=none; b=j3GZQXw9UEvhwteDtUDXk4v0Ndvq6JX4lQuoYmkB4ooLQABsOFWxMBbr128p7jy0MP1FN4J2cjQQCSLh9IbuF3YrCtF0CGmz1KDvVra8E+0h61w15914uDWpEEhMTMZcQyl32uD3+t1b6HKnvx7aU1Fg1d95aqQhy0clYD3UiQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950468; c=relaxed/simple;
	bh=BHKUodbD8Bj5QFPxPd50B2p1oIY5ll5UwHoPYKL3J7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BW+xfpQSoFpG6QL3kQ488KBAjGfN+0PbW+LVwEsHnkHTlwO4ZcNgDL2cTel2MHFa6E4Q7ngGynOlMDYS2cha+u/sA9GcCDC8YTLnDQbfi9vuBOvh690nIDERHEqgETLkfYE+1LdX/iwlr2q3hEIcEgXnWlC+XfzhQ1EAW84dmZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Djy+2Vc6; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c48fc56752so94554239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708950466; x=1709555266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/faix5We06aG7AM987K0dvt+ZyZCoD81fzNbsR727U=;
        b=Djy+2Vc60+NAKyfpSMm1C7AK5j8VqvBGvSNfTe/JtNXZ1ePe9a7IAVky79Ocgb+MPj
         ruDHDCHTzZ2sQ4x1glFaM2TP6pQTKCGnvUgOcUUB5E5BHF3PKbtIqIEUupBy8EgCccpj
         ug1mMbxgzcLO+g2Rj1OE4mLSaiX9OZx/DzHYO2Zwe2q2K8mlNEbL/h/HiRd9v7l9NmIA
         uD3An6A2Et8EvvnRyAhqq7Hq75/9glICzCkUpmoXj6qTx1PokVG2K+eqUuoUpwe/rljE
         s+XzdfjHsKZhC6KNrFtPVdDYV3XDed/w0ybbnoVc5eD8/I7PSwoNfq+2eSkM7mJSREyn
         bqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708950466; x=1709555266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/faix5We06aG7AM987K0dvt+ZyZCoD81fzNbsR727U=;
        b=hQMxqvMLgsXwuKAU7ETRl6gAxcQPmXaAh9ATBEGxrhly++h0PccKuH+WBil9oqfMhN
         zNZGJZc00Hsqbv3+dnZn+/Ce7RSuQBVcSuEPkl7sF0Z5EBSOcV+PoJEWFNbI1zH5kFiT
         kayX9z4lOOtgONZFPmgfZP5HBm2de92mTykiMkvjl8WmYshB/AFY91v5G/8sdQUT/Z8e
         H2LWzVFVM5/J8lmbx2joA7jErIrRJjvYFGYwYtOx1pGAO+LwjPcN5qq6NYKyO6QrSwnX
         asFKAQqSrRE7WZSjuZKwql5k+xYUuxjfx6dP2SaRHF1OCitthYYnLu7aeihV5tLv9JBB
         NYLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfiQrg4Jj2FPurShPl2LMsG0pWpjk9HWOg12TTCGUBK1ln0So9fngzbE3GgKO1DGm7zIAhSOCGnvSwGk7mXAKfsiHJegh3GRDls75d
X-Gm-Message-State: AOJu0YyRs9pTkFd6u+vVEJS3ZMuRDJWW/uF8da8SkFLF2CLrdZ5scSLy
	SoOOx8rLmz3qrta13iPPeUBai8T7o6ok5bvjYwqHZe2BkWAUCV2BFnaluxSHn2m19OFED2qI4o/
	lxjvtlJYNH/wimSI//sLVHgzBfhc7rXTYTvfN
X-Google-Smtp-Source: AGHT+IGbzgYpilRjkDEnKbvgS5UZhDNoI1XMbPezAG50YHRpmOYcGoysSkihTQvNaJRrC7lL2YXgrI5ogNuUIHDGx2E=
X-Received: by 2002:a05:6602:3413:b0:7c7:bbfd:d843 with SMTP id
 n19-20020a056602341300b007c7bbfdd843mr5675422ioz.19.1708950466041; Mon, 26
 Feb 2024 04:27:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221160215.484151-1-panikiel@google.com> <20240221160215.484151-10-panikiel@google.com>
 <310cefcb-a4d5-4f4f-a482-ba2ff08a57f6@linaro.org> <CAM5zL5rQsYuo3+rW9+YPmvUg9PtNiR0Dy59e8Kf787ranfLh3Q@mail.gmail.com>
 <e2ae7bfc-fb51-4a60-bb52-c6ccca7a4189@linaro.org>
In-Reply-To: <e2ae7bfc-fb51-4a60-bb52-c6ccca7a4189@linaro.org>
From: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Date: Mon, 26 Feb 2024 13:27:35 +0100
Message-ID: <CAM5zL5pz0K5ro4-UjiYojM4h9Lqo_af5ZmH1FoZ_ajde_3+Dcg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] ARM: dts: chameleonv3: Add video device nodes
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org, 
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl, 
	krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com, 
	mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org, 
	tzimmermann@suse.de, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, chromeos-krk-upstreaming@google.com, 
	ribalda@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 1:07=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/02/2024 12:09, Pawe=C5=82 Anikiel wrote:
> > On Mon, Feb 26, 2024 at 10:15=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 21/02/2024 17:02, Pawe=C5=82 Anikiel wrote:
> >>> Add device nodes for the video system present on the Chameleon v3.
> >>> It consists of six framebuffers and two Intel Displayport receivers.
> >>>
> >>> Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
> >>> ---
> >>
> >> ...
> >>
> >>> +             dprx_sst: dp-receiver@c0064000 {
> >>> +                     compatible =3D "intel,dprx-20.0.1";
> >>> +                     reg =3D <0xc0064000 0x800>;
> >>> +                     interrupt-parent =3D <&dprx_sst_irq>;
> >>> +                     interrupts =3D <0 IRQ_TYPE_EDGE_RISING>;
> >>> +                     intel,max-link-rate =3D <0x1e>;
> >>
> >> Rate is not in hex! Rate is in Hz, at least usually...
> >>
> >> Fix your bindings...
> >
> > This is the DisplayPort link rate, for which the allowed values are
> > 8.1 Gbps, 5.4 Gbps, 2.7 Gbps, or 1.62 Gbps. The standard way to encode
> > them (used in the DisplayPort DPCD registers and this device's
>
> Then it is in bps or some other units:
>
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pr=
operty-units.yaml
>
> > configuration) is by multiples of 0.27Gbps. This value (AFAIK) is
> > usually represented in hex, so 8.1Gbps would be 0x1e.
>
> No, the value is represented in logical units. Frequency in Hz. Rate in
> bps/kbps/etc. Voltage in volts.

Okay, thanks for the info. So if I understand correctly, the max link
rate should be represented in bps in the devicetree, and then be
converted to the per 0.27Gbps value by the driver?

One problem is that the values here are too large to be represented in
bps (since the datatype is uint32). Can the property be in Mbps
instead?

