Return-Path: <linux-kernel+bounces-95659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FF88750DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875FE1C2117D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9438212D77D;
	Thu,  7 Mar 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TIjEvKBy"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71912AAFD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819461; cv=none; b=pLGoQX/pqxr8I8tpTVgSBM1VCMkjYprCVLigy1jG6oA/Y42CN9Gs/41DgJ3nWB/x0O5/JBr4FjLWw05p860RGGpRlfAHbDbxwzXnNE5hCWr9mmE8VWHa9xDUjPBUnbcmmg8kj5Cmx2AJLB6h6p7r/mvfqgF8aPk+FJVCcW9YhuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819461; c=relaxed/simple;
	bh=ZqhZpjRK4pnufBjyLUpagbr75YCJe+evkJ0qNwIsulM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjpR1uAo0SSkRLhwjAfDe/01LCuL84CREuXSu+DueiXBw6XJ4Pg0oY8b3IKpKr4R+OTq3RhecLwlPztoYB4tbi+05Y6xmUYGU8KxLlWZMS1j5XT4/mJxARVpcUo/ttKETSv+LSlUerfJXJmjJBwDyL5INsDxnD79FGNiPWjF0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TIjEvKBy; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-472746606b4so289128137.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 05:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709819459; x=1710424259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9torsYcPw28D62HkEM1CjpX6NkRuhOzElzYeBBfh75g=;
        b=TIjEvKBy08D4McpK1x2JYbmNHvcrmTfo5caYfBl649fXCl4ZExTqjJWgjxJQweOsJI
         j8yZ/0vLGo29l99qEN132Gjo81PKguMBFtzd7sPElr4mZKNcRtXUoLhQfWRSrmdNDGQc
         91KdbFcaaoY5B5NsIQDHVMmiNY+Q1bKK0n9Olr4WQjvWWJjgZh6YtkFKZ+UIJBpTgnS0
         JkbUV90KWpd4dt+SaEvidt0JTMPkIo2qTA5CxfF+XrycmVEfoZPlN6sqsKq7oWv8xdXB
         uKKTGMC+xhbcEyM6RLSXMy0xpEIdBW2VHfrsGeRUUF5QAUMa8wmXkQQa5wI8LCngwivi
         qzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709819459; x=1710424259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9torsYcPw28D62HkEM1CjpX6NkRuhOzElzYeBBfh75g=;
        b=WkVzt2I0UuIyKNsSNtmBZoXmmzaToRfGb0kgzMzDa6zON54jg3XsR4KqCdDyLLr6Si
         DkMvQ/ZWYIIIiiNXxPpgdj+x345ZRadGGQ/bMc6CirI+MPe5c6xmJ35IFIfvQeMI2Sl0
         xt6wB2Vt87/Ry0F+tO8dNu2waEMCMnFqkIx+a3RioNqSlxOlMNI3nEfI25EhB4yUUhoH
         5MjKlj3xbQ//OND6jj7inxqnggxvUQV7xSdu2SKPETtBf/eG2/wFD26/w5bDmW+CsHu/
         KMqJgOND9qzoZpOGjKWM+lj3AaKShwWDAy1BChT6Lf/VV980xzwNLraMx9CAu+iuSg4s
         1KrA==
X-Forwarded-Encrypted: i=1; AJvYcCUSUW3P0b+oIeXrnmUtydwkazO99Hif31iPKbLOQhQkjUhtQk72AcHrKsgY9NAbDOOhRcbG5ewuPy1qEmjlafN1UrQUcEFLbWnvgbpt
X-Gm-Message-State: AOJu0YxYCoDjhSNsQL+fAg9yDo2vjmu1NccBsrcCXzoi97PzQxrOMBr2
	CKE7tv7obOW4YZ5D7gEUDLr9O7pnt1N7v2JRoBz/Wr4UsmgT5B64uLZRs1As+gApVs62obmj0hs
	rwdaRuDMMF0we6o4Mvr+peBpyV7aOBscRiQ+NHg==
X-Google-Smtp-Source: AGHT+IF2jZ7wyg1CarUBxtXOtBYgdq/uCacVd62FUUCZun9pIW445yP9fKNJWPLnFKUEAHYOGkp0v4zFhqkAGif0eAI=
X-Received: by 2002:a67:ee41:0:b0:472:a246:9ba6 with SMTP id
 g1-20020a67ee41000000b00472a2469ba6mr7359586vsp.21.1709819457334; Thu, 07 Mar
 2024 05:50:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306200910.2732835-1-volodymyr_babchuk@epam.com>
 <CAA8EJppNopEF0DmgjCAJyxe8HRebD26Q8heKKLKbPstdfBOv6A@mail.gmail.com>
 <CAFA6WYMvtNbAMb5bAuH=as01wxACbjs5XcyPrvcSH4YpGGHhpA@mail.gmail.com> <87le6u18xl.fsf@epam.com>
In-Reply-To: <87le6u18xl.fsf@epam.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 7 Mar 2024 19:20:46 +0530
Message-ID: <CAFA6WYOWeBJ+1aT1mRZE_2mNUCBzGGY0qgc_ZTT0dOTAEseGjQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: add reset name for ethernet node
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 18:43, Volodymyr Babchuk
<Volodymyr_Babchuk@epam.com> wrote:
>
>
> Hello Linux Maintainers, Sumit
>
> First, I am terribly sorry about this half-assed patch. Generally I am
> doing all the required checks. But this change seemed so
> trivial... Anyways, lesson taken, this will not happen anymore.
>
> Sumit Garg <sumit.garg@linaro.org> writes:
>
> > On Thu, 7 Mar 2024 at 12:40, Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> >>
> >> On Thu, 7 Mar 2024 at 00:22, Volodymyr Babchuk
> >> <Volodymyr_Babchuk@epam.com> wrote:
> >> >
> >> > Add reset-names property to the ethernet@20000 node. This patch does
> >> > not change behavior on Linux, but it is needed for U-Boot, as it tries
> >> > to find the reset by name, not by index.
> >> >
> >> > Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> >> > ---
> >> >  arch/arm64/boot/dts/qcom/sm8150.dtsi | 1 +
> >> >  1 file changed, 1 insertion(+)
> >> >
> >> > diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> >> > index 761a6757dc26f..c2e65d6a2ac62 100644
> >> > --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> >> > +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> >> > @@ -951,6 +951,7 @@ ethernet: ethernet@20000 {
> >> >
> >> >                         power-domains = <&gcc EMAC_GDSC>;
> >> >                         resets = <&gcc GCC_EMAC_BCR>;
> >> > +                       resets-names = "emac";
> >>
> >> According to the snps,dwmac.yaml schema the "emac" is invalid here.
> >> Only "stmmaceth" and / or "ahb" are permitted here.
> >
> > Okay, it looks like earlier the Linux kernel on Qcom SoCs always
> > assumed that the EMAC reset signal is deserted by prior boot stages.
> > So I suppose we can reuse "stmmaceth" here instead of "emac" with a
> > corresponding change to U-Boot driver as well.
>
> Maybe it would be better to access reset in U-Boot by index, in the
> same way as linux kernel does? I am not sure that "stmmaceth" will be
> correct from the semantic point of view.

I can't see the Linux kernel driver accessing reset by index in this
case (see [1]). It worked for the Qcom case since the reset signal was
by default deserted. IMO, that's an incorrect assumption (you never
know what state the bootloader leaves the reset signal in) to start
with. This should be fixed via explicit MAC reset desertion in the
kernel driver. IOW, this patch would ideally be a fix for the Linux
kernel driver rather than replicating what U-Boot does.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c#n645

>
> As I understand, "stmmac" name is used due to historical reasons in
> Linux, as this driver was introduced for STM SoC initially. But the same
> IP block is being used in many different SoCs made by different vendors
> and there is nothing STM-specific left in it anymore. Especially taking
> into account that this IP-block was designed not by STM but by
> Synopsys/DesignWare.

As DT bindings are the ABI and we have no choice but to live with it.
"stmmaceth" is already being used for "reg-names" and "clock-names"
too.

-Sumit

>
> --
> WBR, Volodymyr

