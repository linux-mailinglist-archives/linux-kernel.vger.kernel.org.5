Return-Path: <linux-kernel+bounces-93615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454BE873262
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B571C2234F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AA55C5E9;
	Wed,  6 Mar 2024 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gUGI+jie"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBA05C05F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716799; cv=none; b=EiArhd379I8GFgowjboOCzMcFHZOpiaVWCczmaHhnwsL5wt22d1bAzJIy5Ng6QFaIuhW9KonW8qtb/yUCXET5hGToXR91XYFKfaYs6zWKIu/CCprTzruNdbAdmDKKXHnwORslIA4kd/bv9WLDuYK3mDoWEfkpopnbqGHHAti+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716799; c=relaxed/simple;
	bh=wnA4PSgiocDkaO9a9fgbw4GvaFZtLsr3ns0/Zd4EM9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kURnju0crKtqzfYN1HpDK6MIdhdhJT8kZWX26M2WJclLMmn5wzf493H/PozSqxw0uA5ymzhxcKtm6oEKf/roQv2dE5PAY7DRB051ukJdPiEAOtNGZWCHRVqqOc99Bi7IYb1KXfEH56d440nCxl9VwfzQE8ARkNyJCJQCU5H+yh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gUGI+jie; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6096ab005c0so62488267b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 01:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709716797; x=1710321597; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aiSYTBBix3pZDJn7hX0hlhePaaHKbsR/+LCZ9GmLewo=;
        b=gUGI+jieFYCwkisnrcpYvaN1JhmccfRORCE2xKGr8QWipN+Cz/gl2MMHhuYtIW1gIt
         gqDr4W/d18XnBLY6nW85KhlyxMLb11m1X9roYK+KlgGwCF446cjE9VeEGkV/rz0appLJ
         MKrKLRjDLjDz5UzpizsTJWVUNhvpBMU5OZbhJJTlYsfZkNRF2OU7/ax7wQZrDZUoQcys
         sSP7m8gBHJpWLy1ixNieTeRFLiZQTc5hBn7nUecObxXENwTrqoDmRGCON8sD3l6SoDp7
         mJ/0u0ZGjzY6RYHb+ZAZqqQeo4B4aR5esijQmCMz5JN1L+bB/KW+mKDyCZ4b6esXsWkV
         e0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709716797; x=1710321597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiSYTBBix3pZDJn7hX0hlhePaaHKbsR/+LCZ9GmLewo=;
        b=WLCwVlnpB0WPhEzsrgTL3l+LhpbqN+yB2XED6ED7d9rHhl42ASPOwo+P5UCxFWDDhI
         ScPtpbonvjjPWSdejhS0dxS2UaD0Kdbs8VGhXPxzwyGOrzq5dPuOjncW4/eA7MV3jlCr
         a30zRh4gJKRqC4vp9G+HD4KAlj5MhpnbOXfP1lOqjXV1+GbgYkNPBYtBfiionWg5/vMI
         104jZiaETaBgPSyUO2Zg2ZH1afax5qh0DFo10wmDE2tpRa0YtvVY3I4cDSNDhxsEYutL
         RH+BHH1V1piOffe/Z3xne7w4rBYip0NBTVg3i1WzGv77aJlY141DJd+s6jnQTONDUZLG
         Y3rw==
X-Forwarded-Encrypted: i=1; AJvYcCUVjgLc6+K1ERLv6bazN39Y5Wb57vBBJCEuU2kq6QRhZeVPa9eze/ombjCVeKaDnNcCHhxLcuM1C10IPRT6bNzik6qwNPJ0oNkx5/nU
X-Gm-Message-State: AOJu0Yw57DHpZ3yhymJyw3biyYPMp6sCs1kFXlL14BGc36QnXumCDI5N
	zK03aYTEcL2s6vRehOBpxZm4YSfZz4sqlp+IzV2AJ40yVGI6XCmMoQK94dEFijHCQyflfUAcJ8S
	JkF8hrKTvfaY7Go/xWND67Z0jcZk54rez9R/gMOtdOE6P1GJM
X-Google-Smtp-Source: AGHT+IHyeYsmYRCqKOcgrD9TZYmlyF8yBHb/OxI5zro2IrJ1SSYv3q/VJtz9XdZp/Tg8ip3W3ePtZ58gw3pMgY9V8Yw=
X-Received: by 2002:a81:83ce:0:b0:608:4e7a:abc7 with SMTP id
 t197-20020a8183ce000000b006084e7aabc7mr14193190ywf.29.1709716797169; Wed, 06
 Mar 2024 01:19:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305081105.11912-1-johan+linaro@kernel.org>
 <20240306063302.GA4129@thinkpad> <ZegZMNWxCnLbHDxP@hovoldconsulting.com>
 <20240306083925.GB4129@thinkpad> <CAA8EJppsbX=YXf1Z6Ud+YMnp2XnutN1hcb1T0KdAAWXFREVxXg@mail.gmail.com>
 <Zegzf_QKbr8yA6Vw@hovoldconsulting.com>
In-Reply-To: <Zegzf_QKbr8yA6Vw@hovoldconsulting.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 6 Mar 2024 11:19:45 +0200
Message-ID: <CAA8EJprsZz08Otk8hUxu3tQLXen2a3xeW58HLbNSSm=d2OAWkQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] arm64: dts: qcom: sc8280xp: PCIe fixes and GICv3
 ITS enable
To: Johan Hovold <johan@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 11:12, Johan Hovold <johan@kernel.org> wrote:
>
> On Wed, Mar 06, 2024 at 10:48:30AM +0200, Dmitry Baryshkov wrote:
> > On Wed, 6 Mar 2024 at 10:39, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > > On Wed, Mar 06, 2024 at 08:20:16AM +0100, Johan Hovold wrote:
> > > > On Wed, Mar 06, 2024 at 12:03:02PM +0530, Manivannan Sadhasivam wrote:
>
> > > > > Just received confirmation from Qcom that L0s is not supported for any of the
> > > > > PCIe instances in sc8280xp (and its derivatives). Please move the property to
> > > > > SoC dtsi.
>
> > > > Ok, thanks for confirming. But then the devicetree property is not the
> > > > right way to handle this, and we should disable L0s based on the
> > > > compatible string instead.
>
> > > Hmm. I checked further and got the info that there is no change in the IP, but
> > > the PHY sequence is not tuned correctly for L0s (as I suspected earlier). So
> > > there will be AERs when L0s is enabled on any controller instance. And there
> > > will be no updated PHY sequence in the future also for this chipset.
> >
> > Why? If it is a bug in the PHY driver, it should be fixed there
> > instead of adding workarounds.
>
> ASPM L0s is currently broken on these platforms and, as far as I
> understand, both under Windows and Linux. Since Qualcomm hasn't been
> able to come up with the necessary PHY init sequences for these
> platforms yet, I doubt they will suddenly appear in the near future.

I see. Ok, I retract my comment.

>
> So we need to disable L0s for now. If an updated PHY init sequence later
> appears, we can always enable it again.
>
> > > So yeah, let's disable it in the driver instead.
>
> Johan



-- 
With best wishes
Dmitry

