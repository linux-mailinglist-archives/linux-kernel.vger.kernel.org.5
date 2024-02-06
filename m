Return-Path: <linux-kernel+bounces-54746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8226484B321
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4451F24B72
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F2F127B7B;
	Tue,  6 Feb 2024 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="FX8xyvqm"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A5512F597
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217670; cv=none; b=X8FP8cAYWcCNFDFlDdZ2A627cVfR0mEdgOd5dx6LP47QcidJsNDND+jiDND+YJK3VnAL/6kWXuaMwwlwiBvJ4z+jnZFOGhGiVr5icNZlhDdMfNvmxdsVhgLXWb3jmrp2Abuhou4WqMveCKukrfQitRvneJaN+KrhLY6OCETwcLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217670; c=relaxed/simple;
	bh=8/7/Ul6T013u2OeyvCYLEwwDnMuWRIvwJhMTD+afto4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxmxX5GaGVds8DDXv5Y0VxaYW6j8v8Rel0I1iC40Z5A+u29eHwYNusH27xhSL1bbv8YLFx0oIsNjir6CFJX5LKi1JtMJ3RBLKvnfeywD182lar5JXE0IGX7C2I0/Fq1+gNDvO2I5oXUp8mG9OwIefw6XIhKiSCGkOiFEAVPy+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=FX8xyvqm; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-595aa5b1fe0so3673563eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 03:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1707217668; x=1707822468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8/7/Ul6T013u2OeyvCYLEwwDnMuWRIvwJhMTD+afto4=;
        b=FX8xyvqmFAMYiEyG+Pplw3FGahoFMwNC8M7k6tQHzoSL4s1O56wuK0+K9z56VBWGi3
         hf/jFUDdjUaJK8AZ9IbQ5D06/dNk2XNIMIXmqZRtcX0fdnUtFfHn/MqMZFEXdpO/3lxP
         ZYNvZZXuz6cdKNwlGvX7Xk2iR3x8R4Naze5B3F9DWI4x8BZgeU9GMpV4CQBOsc75232c
         hE/sQsUJPJliBVJI7ePEnsGFZP6qImbJxREKwdffdxxnPVukl1FqkybWldMV2ZVHSg2T
         s4gqpZmNvxUs+0wJuOauEjip3O11nOdHT8PwpOMiYgARZYB8UrLVbSJHjo0XIqj7XUNo
         5G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707217668; x=1707822468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/7/Ul6T013u2OeyvCYLEwwDnMuWRIvwJhMTD+afto4=;
        b=aoostQJ0tmi4XephGHKFmX131hA/4fMHEw4C0AmqGslJvDAwDMrDht3qHazvb93IT5
         /jjYZN6dddisHdan8J+cWYKTZSpfWMSnn/b6vtrejGukGjNXFUd/Q/YdZRHJc2ZiMwLU
         S2XRsALOuKcKiragxko058yvMGVLxu/ovfNJmvo9qx+oPjhoSMyS/usPMtMxWwrj8w5z
         ZJ3mL3xXJ8Y9nouPpOlSEEQ2X78QNjCYtk/Jd+S9XhNeStQzpgclytyFgRfFVZkY+R9d
         k59Fy1zY6JJY57Xu+ImzRNtsglLQZLrlKV3Pg8jrmj14EI4sfCGYh+drQWxM8FH4WxIn
         TTNg==
X-Gm-Message-State: AOJu0YwKY//26g3isy8s+phOdgzhetd8A5U+sPipT5IghV3nIi9mt58U
	jz008YakEk7BTVsWoSERxS0DfPqea1v6+56SyVorXicOHTRZIAplCWSWgoB0OG0jFLdOb63V28y
	J3sRdnK5wjjhI650Mub5kBpaB0kxEjsb3OF4YtQ==
X-Google-Smtp-Source: AGHT+IF4G29Y+8AnjcLbEBuZRqeZSEJq+1vFu4+EaVRdUP0HG5g61OCSI7ogKgMlsx++Tqmt9RAvLTcJt1RhMMe4wI0=
X-Received: by 2002:a05:6358:340f:b0:176:a01d:7889 with SMTP id
 h15-20020a056358340f00b00176a01d7889mr1695785rwd.30.1707217667871; Tue, 06
 Feb 2024 03:07:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205110244.676779-1-naresh.solanki@9elements.com>
 <8714b420-58b9-4d5b-a489-31670c8d325f@linaro.org> <CABqG17jfHpi5oDt+=E925Fp6DN2OftmDEjpmvb5=3nxMt+d2iw@mail.gmail.com>
 <47d66b4a-5608-4fc9-88bc-911f74d62819@linaro.org>
In-Reply-To: <47d66b4a-5608-4fc9-88bc-911f74d62819@linaro.org>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Tue, 6 Feb 2024 16:37:37 +0530
Message-ID: <CABqG17gS6kdXKdVOc-CFEQp_BGJBANdCmEhUvQ1t=Tx=vw-9pg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mfd: Update pattern property case
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, mazziesaccount@gmail.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,


On Tue, 6 Feb 2024 at 13:06, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/02/2024 15:00, Naresh Solanki wrote:
> > Hi Krzysztof,
> >
> >
> > On Mon, 5 Feb 2024 at 18:38, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 05/02/2024 12:02, Naresh Solanki wrote:
> >>> Driver expects regulator child node in upper case.
> >>> Hence align with the same.
> >>
> >> Did the driver have DT support before? I think no, so why aligning that
> >> way? I would argue that driver should be aligned with bindings, the
> >> moment you add DT for the first time.
> > Yes the driver has DT support already.
> > This patch is to align with driver:
> > https://github.com/torvalds/linux/blob/master/drivers/regulator/max5970-regulator.c#L381
>
> That's not support for DT, but just naming regulators.
I'm not sure if I get your perspective right & please correct me if I'm wrong,
I'm just trying to adjust the dt binding of max5970 because found
errors related to
regulator child node SW0/SW1.
Regulator driver expects to have regulators child nodes as SW0/1(upper case)
But dt binding expects it to be lower case.
Thus there is misalignment & due to which, when running CHECK_DTBS for my
mainboard DTS, I see some errors.

>
> >
> > It was aligned but I missed on case sensitivity.
>
> I don't see the alignment. Where did you align it? Which commit?
The current patch is to address the regulators child node name with driver.

Regards,
Naresh
>
> > Driver expects it to be SW0/SW1
> > but DT had it as sw0/sw1.
>
>
> Best regards,
> Krzysztof
>

