Return-Path: <linux-kernel+bounces-104212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06FC87CAC2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6EC1C22204
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8398317C70;
	Fri, 15 Mar 2024 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cps2RsU+"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2617C6C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710495103; cv=none; b=awCeKkrj/u1s33CdGh7QbvONboRH2iXt8sH4l1oA5D8OM68Cqg6ohTVhPxVEXCAOGP3+uv4E2piglINXtzKPYUyQ+OXdp3L5wXR4RJvVYI8WgbrqJqTf9OAnzYla2wmSlIEDDh4OVnOvgq+yTgDK3eo2GVrSGYsR3cJ4X3ab49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710495103; c=relaxed/simple;
	bh=wKEW1rXXeX+2+0FZCZcmMKdT8S2KJyJy6N936Rnnq1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fnu0WOqxjnAyS1JqMh1cilrcbBjSJ8ncgtNONHU6QibzkPpfJwPp2M6Gaj4fCVZQYy/ij20iWiH7UkdHzeMvH6eX7HsuW0FE+3dtrmZmDbcRvaR+G2oz09ckbesTA9J16Z9XpFn5dGVrhrCd0tDUKdWVP9Y3Kr2cXRqNDZEXc38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cps2RsU+; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7dfacd39b9eso88844241.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 02:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710495099; x=1711099899; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4n3K5fB4Q6ZdxH2TmCXh/YokpYNn7Qm173oXHneXpP4=;
        b=cps2RsU+8Y644Yq/wfZCe5+5+9MHEVQDcjCGPg85oD34DLgdMvgmwCvbzJTiZvEkLz
         D4Ff3lNq6/wHX/8QsVXmHoFgjlyvzffcUg+yxpVW/STKr98f2YlOEdOLAVZUK5NHk4Cg
         g7aJHiyFlByJUN67cP9akHX6SUyUgkSG/J0fvTwXb0sowLogNfdQb9isGGAKtno6FTpT
         /9KWt0MnL5qLCSXYUbLVK5MOWzDB8UJqwlE2Gb0wRrUOIAK0tGZuMd2wIa8lGwydoGXF
         CDFRrt+9HTzU3VWcGcol7j+2XzGHmwaoBbx9KeLGk1tHWl9lXDn0/Qx4BRGo4RybiDE1
         /70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710495099; x=1711099899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4n3K5fB4Q6ZdxH2TmCXh/YokpYNn7Qm173oXHneXpP4=;
        b=JD+YGQynnIe2M621eWuv2VMjRrut5V3RIdmit+dR8kQUtd6QQxjkd1D00UsuMsqVKU
         /BKgMdX6jBwhV4CLuvwnoUANHSxqOKkLVje3v9T0EiH0g/vGuLkisENkVGYTpDdzvySc
         jmWCF2bWZYdabvsfOhpAMWhhQRM1Y6mo1cJzkNtFlXCeyxRY6AQGfXG7qIxTvVBqRLdw
         nXB6KEF5TfQ3gzSh6JqSrBQ54VQtyvJBVO5UDANA4MbUIZ98LMxiYHFRJaoBL9ZauZjD
         IoDj3VNbgLQkEU/ZehaJNBhvpPB1OUqhM/0k2gLjlhS4FRyPGzFI6TZyutujlQCwZtAj
         PlOA==
X-Forwarded-Encrypted: i=1; AJvYcCWOSnOP97K80hSmLsGpWBxwmKJT8GxphZLoIuhEHcDrnQ5pbIe48U+OoCQ8Yc12z4We7YUtZSykrCFIZ989qdND37fJN666P1R5784J
X-Gm-Message-State: AOJu0YwNusVn94whFCm0QNjnMhC/3/bnmas7T/coBnni6p9Xq99PTvsP
	Wk19rhVF7PWKVM/0Y/eNuT0urCTgjugwXDzehbQQBVaVWEA4gtjH8Wd+gjEwrxJUHI0m37Cruoq
	lIvafQPKvTwaxJ43wmw67l95fPBAVgS89wcvKvw==
X-Google-Smtp-Source: AGHT+IG0ULaZsxmFehQ06UxEqE9PR91qErbbaT9Qyaco2mCuBunM7DMFrIqLIA7KcR7d9umvhHrblyrGagFAhkgI/l8=
X-Received: by 2002:a05:6102:2837:b0:473:34fc:d9c2 with SMTP id
 ba23-20020a056102283700b0047334fcd9c2mr4364954vsb.11.1710495099324; Fri, 15
 Mar 2024 02:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313123017.362570-1-sumit.garg@linaro.org>
 <20240313123017.362570-4-sumit.garg@linaro.org> <c0e10cbf-c6f3-4b0c-8616-983da2a40236@linaro.org>
 <CAFA6WYNMjCaa0FKjNv6a8VFkco3=GBfgWNDuckGZdiZ9dGmHgg@mail.gmail.com>
 <d82ab1f8-e677-485f-9a6b-4115acfd7239@linaro.org> <CAFA6WYNSumyScax=GkN42GJOG56T3odF5Ed9A2i1nk_exCyGtA@mail.gmail.com>
 <ZfLUu6_Vq7MvG2G3@gerhold.net> <CAFA6WYPN2Bt7zvDyd+02jrsZJz0sFhkD_o4W+PvU=-VC4W5k=A@mail.gmail.com>
 <ZfL6hi0kfp9MXQ0H@gerhold.net> <CAFA6WYMa_0OMkjUdvhYtWZ9SvQx5bB8+YrBZN08BaDXXOtPPNQ@mail.gmail.com>
 <fb20d921-dabd-41dc-9f91-bde90e3b87be@linaro.org> <9b614c61-276d-45bf-8320-44b7358a3e19@linaro.org>
In-Reply-To: <9b614c61-276d-45bf-8320-44b7358a3e19@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 15 Mar 2024 15:01:27 +0530
Message-ID: <CAFA6WYMHA2M1LLjaog17f83Cu_wH4MAvxhuwAQH0c7j4XTM3XA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
To: Caleb Connolly <caleb.connolly@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Stephan Gerhold <stephan@gerhold.net>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, andersson@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	neil.armstrong@linaro.org, laetitia.mariottini@se.com, pascal.eberhard@se.com, 
	abdou.saker@se.com, jimmy.lalande@se.com, benjamin.missey@non.se.com, 
	daniel.thompson@linaro.org, linux-kernel@vger.kernel.org, 
	Jagdish Gediya <jagdish.gediya@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 21:07, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 14/03/2024 15:20, Konrad Dybcio wrote:
> >
> >
> > On 3/14/24 14:50, Sumit Garg wrote:
> >> On Thu, 14 Mar 2024 at 18:54, Stephan Gerhold <stephan@gerhold.net>
> >> wrote:
> >>>
> >>> On Thu, Mar 14, 2024 at 05:26:27PM +0530, Sumit Garg wrote:
> >>>> On Thu, 14 Mar 2024 at 16:13, Stephan Gerhold <stephan@gerhold.net>
> >>>> wrote:
> >>>>> On Thu, Mar 14, 2024 at 03:02:31PM +0530, Sumit Garg wrote:
> >>>>>> On Thu, 14 Mar 2024 at 14:48, Konrad Dybcio
> >>>>>> <konrad.dybcio@linaro.org> wrote:
> >>>>>>> On 3/14/24 10:04, Sumit Garg wrote:
> >>>>>>>> On Wed, 13 Mar 2024 at 18:34, Konrad Dybcio
> >>>>>>>> <konrad.dybcio@linaro.org> wrote:
> >>>>>>>>> On 3/13/24 13:30, Sumit Garg wrote:
> >>>>>>>>>> Add Schneider Electric HMIBSC board DTS. The HMIBSC board is
> >>>>>>>>>> an IIoT Edge
> >>>>>>>>>> Box Core board based on the Qualcomm APQ8016E SoC.
> >>>>>>>>>>
> >>>>>>>>>> Support for Schneider Electric HMIBSC. Features:
> >>>>>>>>>> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno
> >>>>>>>>>> 306)
> >>>>>>>>>> - 1GiB RAM
> >>>>>>>>>> - 8GiB eMMC, SD slot
> >>>>>>>>>> - WiFi and Bluetooth
> >>>>>>>>>> - 2x Host, 1x Device USB port
> >>>>>>>>>> - HDMI
> >>>>>>>>>> - Discrete TPM2 chip over SPI
> >>>>>>>>>> - USB ethernet adaptors (soldered)
> >>>>>>>>>>
> >>>>>>>>>> Co-developed-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> >>>>>>>>>> Signed-off-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> >>>>>>>>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >>>>>>>>>> ---
> >>>>>>>>>
> >>>>>>>>> [...]
> >>>>>>>>>
> >>>>>>>>>> +     memory@80000000 {
> >>>>>>>>>> +             reg = <0 0x80000000 0 0x40000000>;
> >>>>>>>>>> +     };
> >>>>>>>>>
> >>>>>>>>> I'm not sure the entirety of DRAM is accessible..
> >>>>>>>>>
> >>>>>>>>> This override should be unnecessary, as bootloaders generally
> >>>>>>>>> update
> >>>>>>>>> the size field anyway.
> >>>>>>>>
> >>>>>>>> On this board, U-Boot is used as the first stage bootloader
> >>>>>>>> (replacing
> >>>>>>>> Little Kernel (LK), thanks to Stephan's work). And U-Boot consumes
> >>>>>>>> memory range from DT as Linux does but doesn't require any
> >>>>>>>> memory to
> >>>>>>>> be reserved for U-Boot itself. So apart from reserved memory nodes
> >>>>>>>> explicitly described in DT all the other DRAM regions are
> >>>>>>>> accessible.
> >>>>>>>
> >>>>>>> Still, u-boot has code to fetch the size dynamically, no?
> >>>>>>>
> >>>>>>
> >>>>>> No U-Boot being the first stage bootloader fetches size from DT which
> >>>>>> is bundled into U-Boot binary.
> >>>>>>
> >>>>>
> >>>>> Back when I added support for using U-Boot as first stage
> >>>>> bootloader on
> >>>>> DB410c the way it worked is that U-Boot used a fixed amount of DRAM
> >>>>> (originally 968 MiB, later 1 GiB since I fixed this in commit
> >>>>> 1d667227ea51 ("board: dragonboard410c: Fix PHYS_SDRAM_1_SIZE") [1]).
> >>>>> When booting Linux, the Linux DT was dynamically patched with the
> >>>>> right
> >>>>> amount of DRAM (obtained from SMEM). So if you had e.g. a Geniatech
> >>>>> DB4
> >>>>> board with 2 GiB DRAM, U-Boot was only using 1 GiB of DRAM, but Linux
> >>>>> later got the full 2 GiB patched into its DTB.
> >>>>>
> >>>>> I didn't have much time for testing U-Boot myself lately but a quick
> >>>>> look at the recent changes suggest that Caleb accidentally removed
> >>>>> that
> >>>>> functionality in the recent cleanup. Specifically, the SMEM-based DRAM
> >>>>> size detection was removed in commit 14868845db54 ("board:
> >>>>> dragonboard410c: import board code from mach-snapdragon" [2]), the
> >>>>> msm_fixup_memory() function does not seem to exist anymore now. :')
> >>>>
> >>>> Ah now I see the reasoning for that particular piece of code. Is SMEM
> >>>> based approach the standardized way used by early stage boot-loaders
> >>>> on other Qcom SoCs too?
> >>>>
> >>>
> >>> It is definitely used on all the SoCs that were deployed with LK. I am
> >>> not entirely sure about the newer ABL/UEFI-based ones. A quick look at
> >>> the ABL source code suggests it is abstracted through an EFI protocol
> >>> there (so we cannot see where the information comes from with just the
> >>> open-source code). However, in my experience SMEM data structures are
> >>> usually kept quite stable (or properly versioned), so it is quite likely
> >>> that we could use this approach for all Qualcomm SoCs.
> >>>
> >>
> >> If the SoCs which support this standardized way to dynamic discover
> >> DRAM size via SMEM then why do we need to rely on DT at all for those
> >> SoCs? Can't U-Boot and Linux have the same driver to fetch DRAM size
> >> via SMEM? I am not sure if it's an appropriate way for U-Boot to fixup
> >> DT when that information can be discovered dynamically.
>
> "standardized" I'm not so sure... But yes, smem does offer this. The
> definition in DT here is for U-Boot,

We should move away from that thinking that U-Boot has its own DT and
Linux kernel has its own. IMO, that's just the opposite of the true DT
definition.

> ABL will always clobber it, and so
> does U-Boot before handing over to the kernel. Linux should never see
> this without a bootloader having looked at it.

Where does U-Boot clobber SMEM? I would be interested to see if ABL
clobbers it too?

>
> The reason I decided to hardcode this in DT for U-Boot is because SMEM
> currently relies on the driver model and isn't available early enough.
>
> Also admittedly I just wasn't that familiar with the U-Boot codebase. I
> just wanted to avoid hardcoding this in C code, and given that this was
> already supported for the "chainloading from ABL" usecase, just
> hardcoding the values was the obvious solution.
>
> I would definitely be open to revisiting this in U-Boot, having an SMEM
> framework that we could use without the driver model which would just
> take a base address and then let us interact with SMEM and populate the
> dram bank data would be a good improvement, and would let us avoid
> hardcoding the memory layout in DT. We'd just need to manually find the
> SMEM base address in the FDT as part of "dram_init_banksize()" and
> retrieve the data there.

These are the similar problems Linux has to deal with too but on Qcom
platforms it is rather offloaded to bootloaders to rather implement
this. It leads to custom DT modification or board code in U-Boot which
is hard to maintain. If we want to implement it properly then
corresponding bindings should be upstreamed too regarding how DRAM
range is to be discovered via SMEM.

>
> That all being said, I don't see any reason not to define the memory
> layout in DT, it's a hardware feature, DT describes the hardware. The
> whole "bootloader will fill this in" implies that the bootloader isn't
> also using DT as the source of truth, but now with U-Boot it actually
> is, so it's all the more important that DT be accurate ;P

I agree DT should be accurate and not a fan of DT fixups. However,
when it comes to some hardware configuration being discoverable then
IMHO DT isn't the appropriate place for that. For the time being I am
fine with the DRAM range to be specified in DT.

> >
> > You're mixing two things. Linux expects a devicetree where
> > /memory/reg[size]
> > is valid. Such driver should indeed be (re)implemented in u-boot to provide
> > this information.

No, I don't think so. We should rather start thinking about the
overall stack rather than just being Linux kernel centric. Do you have
a generic solution for U-Boot regarding how this should be
implemented?

-Sumit

> >
> > As for linux, I am working on making Linux aware of the DDR capabilities
> > on Snapdragons, for other reasons, but it's on the back burner, as it
> > still needs some broad thinking about integrating it with the interested
> > consumers.. Bottom line is, Linux should be fed a devicetree with DRAM size
> > filled.
> >
> > Konrad
>
> --
> // Caleb (they/them)

