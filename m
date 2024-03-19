Return-Path: <linux-kernel+bounces-107893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54FF88032B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE9A1C21D54
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218561BF2A;
	Tue, 19 Mar 2024 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EQI+Qp5J"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB1819BDC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868365; cv=none; b=L+Gui6YxMPLRwNVkDQj+lGpzMCvhzt/enEQUDpBcv+3/12astUr+NIIYyS74mb8WAJlPEZrd7VCWwGnRqLGZQJCTI9duvm7O8D5rLhsRHMBIcJdscJVYMs1cl+Z88NQzeN/sRQ9sK1Hq1Do80kCYodNkeAXCixX1Li5SGdFQ4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868365; c=relaxed/simple;
	bh=jL9kHyMM7c3nVEZ31ALav/nIxEz+OLnT9X61bJOp+Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCMnpprE9XSPBgKOIYQiGUNYBrtWkNBUgYJBIcsRyDBfRmQVTwVaa7KHgqKz1HPUHgIftQc/lhEYJ5H1QUhv1vrSWevtK21rkKVDmibaSKhPUOtXAEt2YVu75QJ+1xZeMx2ZrmhxF2/lLJ0p3wCFvp+2FopMJ3hC4Lan1B75uGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EQI+Qp5J; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-789e83637e0so249948685a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710868361; x=1711473161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy7T3S3KJOVX4N1q15sidzyEWWPC1Gkc2ooZN7wpRNo=;
        b=EQI+Qp5JVKZmJk6DktJjt4CjDhs2WbpdacenmXH3/C9sNBZKNPpU4EwHCCSkv5dKmp
         muKM8ETzSA2KuLLVyiuSaNCO9y8jv13MJSyb8EeW5qjd1Ft0Ef1SxJgPsApZALytc/Af
         7q9tAnpjqJIwR78kV+AeDcMZw6o/IApUSZFPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710868361; x=1711473161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xy7T3S3KJOVX4N1q15sidzyEWWPC1Gkc2ooZN7wpRNo=;
        b=KpT+wRcnxY6WVbU/MpGQh0fhR+nsRK3Hb4vwN+3N2mWje8K00PGbd82QAPcuMOdpTr
         pJmHcQKIMj9TXJSa09tvRGbNBjz2BY4C034+OM/6R2r8TAsExV9AtLbX8W9KlEzqzF2F
         bA5DGGzaYzDMSAlkk+/RzJn39+RtDu+2gfzPwy8MIO+lv87FiS5U0yWfAyzseEEH30h/
         vK3oLk3wxgqWxDlspUH0AgGBiK9hF9eQKMP30ysDOirCim5FzAx2lXtLGRk0VjYJKjr3
         tVYGVKfyuL87pFE5B/gnCK8UG6guPfP9qIGhZVwb97cbdHOE5UbXyZm5tou/TU0QprON
         VC3g==
X-Forwarded-Encrypted: i=1; AJvYcCXMquNG+hjmQcEV0mmxUPwUCOIg3Ppjb8fnKr1qjtNJQHl5vAX2orptXe5eiUOIuo8McM90lso/spywc7gOA0v5ofaLMayFHoBFUAxt
X-Gm-Message-State: AOJu0YwnVAC9H9cl1LL6GzVspoXeRhCilzGqxfpKrXrqy/mMoNhSnUIR
	6h5u7OR7i9gP9NhPuja6DKyo7vBKyIzqjKJF5+Wj6t+pznLG+kdK/yVQFg0GkUsBatwOYENKXak
	=
X-Google-Smtp-Source: AGHT+IGe6SOXp+Soqpd8WJSKhnmvPQC3X27paLXjnJKm66/NwCjX4p0j5TB1sYGjuSLT5F1aZ+5iWQ==
X-Received: by 2002:a05:620a:2945:b0:78a:18d6:e4eb with SMTP id n5-20020a05620a294500b0078a18d6e4ebmr1907116qkp.34.1710868361570;
        Tue, 19 Mar 2024 10:12:41 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id p15-20020a05620a22ef00b00789fa594de5sm2426056qki.80.2024.03.19.10.12.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 10:12:39 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42ee0c326e8so17361cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:12:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKiXbIsr5IXp28hciXPvu5K2ME80luOJaY6ReLNWyGc3Kdpjgyy0d5JOHno4MBmEQYLsLEhfBs1SGs0IEUSZ1qYrJ159dU0hP0sfi1
X-Received: by 2002:ac8:590c:0:b0:430:b7d0:59d4 with SMTP id
 12-20020ac8590c000000b00430b7d059d4mr1682qty.19.1710868359392; Tue, 19 Mar
 2024 10:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org>
 <20240319152926.1288-4-johan+linaro@kernel.org> <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>
 <Zfm_oFLNgPHqJKtG@hovoldconsulting.com>
In-Reply-To: <Zfm_oFLNgPHqJKtG@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 10:12:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UgCNmeWJiwWAGj_jm78eeTNoo-_bx7QrqLfyDMJwRNKA@mail.gmail.com>
Message-ID: <CAD=FV=UgCNmeWJiwWAGj_jm78eeTNoo-_bx7QrqLfyDMJwRNKA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] Bluetooth: qca: fix device-address endianness
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Nikita Travkin <nikita@trvn.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 9:38=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Tue, Mar 19, 2024 at 09:10:38AM -0700, Doug Anderson wrote:
> > On Tue, Mar 19, 2024 at 8:30=E2=80=AFAM Johan Hovold <johan+linaro@kern=
el.org> wrote:
> > >
> > > The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetoot=
h
> > > device address in big-endian order when setting it using the
> > > EDL_WRITE_BD_ADDR_OPCODE command.
> > >
> > > Presumably, this is the case for all non-ROME devices which all use t=
he
> > > EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices wh=
ich
> > > use a different command and expect the address in little-endian order=
).
> > >
> > > Reverse the little-endian address before setting it to make sure that
> > > the address can be configured using tools like btmgmt or using the
> > > 'local-bd-address' devicetree property.
> > >
> > > Note that this can potentially break systems with boot firmware which
> > > has started relying on the broken behaviour and is incorrectly passin=
g
> > > the address via devicetree in big-endian order.
> > >
> > > Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device ad=
dress")
> > > Cc: stable@vger.kernel.org      # 5.1
> > > Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> > > Cc: Matthias Kaehlcke <mka@chromium.org>
> > > Tested-by: Nikita Travkin <nikita@trvn.ru> # sc7180
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >  drivers/bluetooth/btqca.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > Personally, I'd prefer it if you didn't break bisectability with your
> > series. As it is, if someone applies just the first 3 patches they'll
> > end up with broken Bluetooth.
>
> It doesn't break the build, but yes, the device address would be
> reversed for Trogdor machines for two commits and possible break any
> previous pairings. That's hardly something to worry about.
>
> So I consider this to be acceptable for sake of clarity, and especially
> since these patches will be coming in from separate trees anyway.

I guess I have a different opinion on the matter. I often end up
cherry-picking stuff to older branches and I generally assume that
it's relatively safe to pick the beginning of a series without picking
later patches because I assume everyone has a goal of bisectability.
This breaks that assumption. IMO splitting up the Qualcomm Bluetooth
patch into two patches doesn't help enough with clarity to justify.


> > IMO the order should be:
> > 1. Binding (currently patch #1)
> > 2. Trogdor dt patch, which won't hurt on its own (currently patch #5)
> > 3. Bluetooth subsystem patch handling the quirk (currently patch #2)
> > 4. Qualcomm change to fix the endianness and handle the quirk squashed
> > into 1 patch (currently patch #3 + #4)
> >
> > ..and the patch that changes the Qualcomm driver should make it
> > obvious that it depends on the trogdor DT patch in the change
> > description.
> >
> > With patches #3 and #4 combined, feel free to add my Reviewed-by tag
> > as both patches look fine to me.
>
> I don't think it's worth spending more time and effort on this issue
> (which should have been caught and fixed years ago) for this.

Sure, that's your opinion and if the BT folks agree with you then they
are free to land the patches without my Reviewed-by on them. ;-) Mine
is not a strong Nak but I feel strongly enough that I'd prefer not to
have my Reviewed-by added without the re-organization.

-Doug

