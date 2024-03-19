Return-Path: <linux-kernel+bounces-107918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A95880382
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE542845F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D38F22EE8;
	Tue, 19 Mar 2024 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ATTPn10o"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8D1B812
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869637; cv=none; b=SfjjprpGruDxmeYzDzZaxLVSCpJWUD1QeA2g5zN5vUnLZUAW1zcvUmgh0D/pqhPJw2388sQnWRXNJ+U9+b2v25VUy3XCIdtqipPenueqqoU2z/Nt9S8NdjmY8deGBg0kqy7UAW5TXayZ34btWLIzlWC03X4rP2GeQUqFMxXkohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869637; c=relaxed/simple;
	bh=2cv+uOgViz5td2LtyB9BpL841aRXxlirwrFqlMFbk68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ila02+a1PRhqdXUrBizjPTekEC41JFLzMRKaodZRm1gBBB/0Hjk+MQm9zusLpSUXaDDQ7TvYRhw8supFsN6jYtHPX4h6S45ZrOag8OETVsZ5eRDOqUKGRbLopaiy0eSsIMt4k1zT/pv/LNmLEsYwjaarBBZ0A366InsEwoMOxi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ATTPn10o; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-690c1747c3cso1018026d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710869634; x=1711474434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cv+uOgViz5td2LtyB9BpL841aRXxlirwrFqlMFbk68=;
        b=ATTPn10oFMffKo8COwMCkwI4iSVvIiFJ6nFwhIaYRC8Y3oyioRBmPl+MYGsSsaYqBd
         aa9CZ1JKnaiZjVNN+yAxAge66H19Ww+dmreI84LTi27sFyBpdNcw99y1rid9Iu/KdnD2
         LXov1Shr0evoKK6m66BIaTGXCI64HZS34UZaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710869634; x=1711474434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cv+uOgViz5td2LtyB9BpL841aRXxlirwrFqlMFbk68=;
        b=dLOufniTw6KWYPSBHN6E0XLSeAQnkK+aBXxcHtKcQokAmbjsoaKKSTE9Mlnyq1Fp6m
         8qx2J/iHXxQBcHcQwIls4sTLqmjWOXUNuqFxhBhwr+SmY9/1tuk4Kzwh1kv8ZxxQHYs4
         E9YYLZj0pxjVJZFRQ2PQcI2atE+MqD85unE1Y3H7BS15CAYjAwGO1XIEEaVuhLamL+Jx
         ZAOT9+w/aG9zCBTIQkd0lzUbSCG3enaRVwcXJl0hpkX4SsWMk3AojhEy/84OUTzItu1H
         Nae4CUdM2vWJItj6TM4Oou+Hyr/GN1ARMXFOG+G3yQonvsoD85ow7PRaSS2vG/5ZIPRe
         5oVg==
X-Forwarded-Encrypted: i=1; AJvYcCVLZozHE4VFdLxfwNDzKWP5i0IfcCnHeWAVxysxyX8ghhCDjJK5XdMp+XedlUe6x/dvmtOR0giwpo9nzyRxsVFADBMP/XP2jb2LLrlO
X-Gm-Message-State: AOJu0YwOT/L5gdWw89I0aCZF2s0EvQJ3Sjrwj3ltHLN4NpXcXnFgWYT1
	XBM92cS3bJ4rEwM1QdWYo5GnShFXdUeimeguQCIBFeYJeTRlrxOJ1dBJINDOchuEfLYE7acWaY4
	=
X-Google-Smtp-Source: AGHT+IF6DDKFWbkjqq2Rd8Fxc/iMxzC0U/PEW9prIKG/WryX2rdZlv/nK6OMbRJxmV0UAl1TbryfqQ==
X-Received: by 2002:ad4:5686:0:b0:696:38d4:b7f9 with SMTP id bd6-20020ad45686000000b0069638d4b7f9mr224519qvb.5.1710869634490;
        Tue, 19 Mar 2024 10:33:54 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id g12-20020a0caacc000000b0069186a078b3sm4627817qvb.143.2024.03.19.10.33.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 10:33:54 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-430e1e06e75so37221cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:33:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZi+8T96742ohxYENGeXirCpYGHvs9L28CPmpi/Tp4cLOHHVg85RxjsgQM8/EEpjC+JqXGWF7X/boJ0BHtnDuW7V/78ia2e2nZ1ZCQ
X-Received: by 2002:a05:622a:2293:b0:430:d723:aa66 with SMTP id
 ay19-20020a05622a229300b00430d723aa66mr20279qtb.16.1710869633686; Tue, 19 Mar
 2024 10:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org>
 <20240319152926.1288-4-johan+linaro@kernel.org> <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>
 <Zfm_oFLNgPHqJKtG@hovoldconsulting.com> <CAD=FV=UgCNmeWJiwWAGj_jm78eeTNoo-_bx7QrqLfyDMJwRNKA@mail.gmail.com>
 <ZfnLKC7B9o2reC8x@hovoldconsulting.com>
In-Reply-To: <ZfnLKC7B9o2reC8x@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 10:33:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ujx+f3SxTiuhBGUypwfvHqTO70jy-8EgLUGA93SON5Kw@mail.gmail.com>
Message-ID: <CAD=FV=Ujx+f3SxTiuhBGUypwfvHqTO70jy-8EgLUGA93SON5Kw@mail.gmail.com>
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

On Tue, Mar 19, 2024 at 10:28=E2=80=AFAM Johan Hovold <johan@kernel.org> wr=
ote:
>
> > I guess I have a different opinion on the matter. I often end up
> > cherry-picking stuff to older branches and I generally assume that
> > it's relatively safe to pick the beginning of a series without picking
> > later patches because I assume everyone has a goal of bisectability.
> > This breaks that assumption. IMO splitting up the Qualcomm Bluetooth
> > patch into two patches doesn't help enough with clarity to justify.
>
> I did that in v2 because then the two patches had to be split to
> facilitate backporting as wcn3991 support was added later.
>
> But the big issue here is taking the patches through different trees. If
> Bjorn could ack the DT patch so that everything goes through the
> Bluetooth tree, then I guess I can reorder the DT patch and squash the
> two driver patches.
>
> But waiting several weeks just to make sure that the DT patch hits
> mainline (and the binding patch before that?) before the driver fixes
> can go in just does not seem worth it to me.

Personally, I don't care quite as much about them going through the
same tree. It'd be nice, but I agree with you that it's probably not
worth the hassle (though I wouldn't object if Bjorn wanted to Ack the
dts) and it's fine with me if the patches "meet up" in mainline. In my
case, though, I could imagine following the "Link" tag in the patches
and arriving at the mailing list post. That's where I'd go back and
look to see the order which I should apply the patches safely. ...and
I'd prefer that it shows an order that lets things apply safely.

-Doug

