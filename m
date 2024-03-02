Return-Path: <linux-kernel+bounces-89499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7F586F13F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917AB1C210E5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8F11B971;
	Sat,  2 Mar 2024 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SY38SJqn"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364020DDC
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709396610; cv=none; b=ZxnxRXfFiOIIOBMbKcQjk9rnqTcEkbLgQW3dfh39SeiTF6eQ5TeO0nxdcyeRo7hMhG9gufNIULZMtiIH/h17Q3GM4ANtyTVxUjeLlYdC3i9GE5zFz8Yh4hDg7ZxV4BDQ6Ifp5AsGA8KqZMCvlfE/qPPt2k8cgSI9jyHmFD/XFiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709396610; c=relaxed/simple;
	bh=HeK962owgEr5gMkWP6/gMw2kztUNpF+LAhcrRJ0fDso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfKqdLLougEkgxz7ZuUuDMhewgXFtlT8gFp9YMF5jD6OIbKiFMKpM/ria0tW/4ewS4YwzddOB1z6emZt9qMFrAAgf+srfPtx7rPQAbsqxFKPMh+qJs1p0bXz9ZLiEiePOqYSDVngJn7iPlQU6qTjSJrbpK/NEXAGk9HpfT9aBIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SY38SJqn; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so3271253276.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 08:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709396607; x=1710001407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4N39Dng4OFJ2jMjGUD2GFi4ncn9Y4hu2alPf+t9ajk=;
        b=SY38SJqnCBuQYWXCoFj78RFRLwW6i39RJugz9kpUsCb12dTTSIGSnSMn04KPPk7mKj
         EFM91NvCM+xUXNW+MM6XwmS0pwwNLAcRVGP5rjhRrniqzxbeCWUvdqB2FemM3aGpwxqK
         so8/5R6AZC2xEWZTW8EATdQMuxk+lD9V8MYhmIKbhnaGEuwU1YRVIOwL41fM4iqGCgH3
         v0lDHklNeoDII67hdJhEgYms+qQ/pGzJ8O98o5H7rjLPG2ds4gViF2d01xL1Xs5/Pj8r
         REbGL4aQvhPhKKNxYLsM3Yo+nwtXmuhC04vo26ObPWNSZAppg+HFUVyDCwGjJMHQC8/q
         rGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709396607; x=1710001407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4N39Dng4OFJ2jMjGUD2GFi4ncn9Y4hu2alPf+t9ajk=;
        b=M4CFNwWyZvKdGSPf2wS544HTgCG0oirJ4kyk5g/kcM6UdLQvktzmw5RAgOy/OqOjdB
         KKynzBD3lnOJY0qZ0PsTX5ffyPYQ9nSkgjt/YKSpNqokK+BLnhXi3C1+B/LQo7gWuB6D
         tLLGuquE27QEt2+FpggUWs56u1XLKXiHpXqdxmXRbTCoFCkFoiZHAE1q0niEjj+tLXzY
         wM18Vbc+B/mQmaOT8T2gtY999s73Gkjiu+dtn9aWv9U2AXeSHG3U7LRbTraMza+tr3zv
         6BQ0Uqc2p42OlkRWOhaGT0Ybde0niGYnErkOl1djrrCXx53FCsoeirC9zkks6dRsUrha
         vghA==
X-Forwarded-Encrypted: i=1; AJvYcCX8vF1U1Rwl+3AQw0NE9gCmtoh7DbbuaTENFVdcvcDZXIYd1bUSoiLuz27hbp8cqzl6MMFb5Bpk/a0bnIRD4jJY0Fs5ZuQjmJgG1mBf
X-Gm-Message-State: AOJu0YzDf8Ff6R8f8dLkd3bc+fv5nz8InvVq5CHcGcQZ8WQGUPQwc41x
	8XK0eOfkqpcMjIPqakIxZSxXrU/FzR3gRCbSvuqnOzNpjmXm7/4Yh83Vz6Y2Poqg0Ca/Cma/v4i
	7T6nA6m5paXdBf+dSznq4ZkHQ+O/L68KZXocQgw==
X-Google-Smtp-Source: AGHT+IHwPfAJNrFDiyJNjMPTqY7w+tCojW8hgGcejLkS5uxgdSqXMK5SnU/uV8lSyBxyKo6pnxcvgCc4jPSvS4agLu4=
X-Received: by 2002:a25:860b:0:b0:dc7:497a:fd63 with SMTP id
 y11-20020a25860b000000b00dc7497afd63mr3891595ybk.3.1709396607369; Sat, 02 Mar
 2024 08:23:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301115546.2266676-1-tudor.ambarus@linaro.org>
 <CAPLW+4=6oYcs0NPXo4ffLiCvtNQ-tY1s_isaxTX8dcPkV56xMw@mail.gmail.com>
 <cb426fb0-2f27-4c9b-89f5-7139354ea425@sirena.org.uk> <f06328e4-b283-4302-b9c1-6473aa3cfa25@linaro.org>
In-Reply-To: <f06328e4-b283-4302-b9c1-6473aa3cfa25@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sat, 2 Mar 2024 10:23:16 -0600
Message-ID: <CAPLW+4kjXK=EWx__h0bX0rJMrL33E=t4YDzSOfObmvtG9aS+jg@mail.gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: samsung: make dma properties not required
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, andi.shyti@kernel.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, willmcvicker@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 3:36=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
>
>
>
> On 01.03.2024 22:42, Mark Brown wrote:
> > On Fri, Mar 01, 2024 at 01:28:35PM -0600, Sam Protsenko wrote:
> >> On Fri, Mar 1, 2024 at 5:55=E2=80=AFAM Tudor Ambarus <tudor.ambarus@li=
naro.org> wrote:
> >
> >>> Since the addition of the driver in 2009, the driver selects between =
DMA
> >>> and polling mode depending on the transfer length - DMA mode for
> >>> transfers bigger than the FIFO depth, polling mode otherwise. All
> >>> versions of the IP support polling mode, make the dma properties not
> >>> required.
> >
> >> AFAIU, the device tree has nothing to do with drivers, it's about
> >> hardware description. Does making DMA properties not required here
>
> correct
>
> >> mean that there are some HW out there which doesn't integrate DMA in
>
> no, to me it means that the IP can work without DMA, only in PIO mode,
> regardless if DMA is integrated or not. Not required means that the
> property is not mandatory, which is what I'm trying to achieve here.
>
> >> SPI blocks? Even if this change is ok (I'm not sure), the
> >> argumentation doesn't look sound to me.
>
> switching to PIO mode in the driver for sizes smaller than FIFO depths
> in the driver guarantees that all existing compatibles support PIO mode.
>
> Are you saying that if there is a physical line between an IP and DMA
> controller, then the DMA properties must always be specified in dt? I
> thought they can be marked as optional in this case, and that's what I
> did with this patch.
>

No, I would wait for maintainers to clarify on that bit. Change itself
can be ok. But the commit message shouldn't mention the driver,
because the driver uses (depends on) device tree, not vice versa. The
device tree can be used in other projects as well (like U-Boot and
OP-TEE), so it should be designed to be universal and not depend on
kernel drivers. The commit message should be based on particular HW
layout features and how the patch makes the bindings describe that HW
better. It shouldn't rely on driver implementations.

Also, it may be beneficial for reviewers/maintainers if you mention
briefly (either in the commit message, patch #0, or under the "---"
stanza) what exactly problem are you trying to solve in your case with
this patch.

> >
> > I do remember there being some SoC which shipped a SPI controller in
> > that configuration for some reason.  Possibly one of the OEM ones rathe=
r
> > than one in a Samsung SoC?
>
> with DMA you mean?
>
> Thanks,
> ta

