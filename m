Return-Path: <linux-kernel+bounces-134657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5C689B485
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 00:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5A41C20CDE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4878E3B2BE;
	Sun,  7 Apr 2024 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="crwQIsSr"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2147B22318
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712530042; cv=none; b=CzPNdieIlp6BqjMyGKsILb/SNm64Yg7umQ2TjFPeA1Lcch60soNnk9ZksVNqfMNZE8d7aSj3QcM7zcKkjMlf6pOhcYGd8jY2V7Qu7s/kYUv5xJ5q+Tzczbe3wedlYAP1IDP2ohcAlaVx9XGF/zk/CmnZMIsx8567G57iQ6PhQ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712530042; c=relaxed/simple;
	bh=cYPJsLS2G4LFo5gdhX3bUtU8WUtFxavLfQpIQuT7eNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6I9qnE7TbA2+Tseq2xX22vScVxj7bJPibpobneDEQcAJYIqXFfG40oo06Zt5pJy3S9Q0RrPWGIEKOryMDohpP7Bcja42cb4D8FfE4FUPBkyAj31y7yZZUBmfX6x/djmlnptDjRP9QDKajeVuZBsfi4W2ERjv/fq2ogPnff2OOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=crwQIsSr; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso3644868276.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712530040; x=1713134840; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nQNYObhRI+L+iMTgrH55FYC3oUBM9fgxDq9UB6KvUqQ=;
        b=crwQIsSrlx93WcSP3CtqTwtvaTR5Xttmv0Yl94zKhJtwpZE7/nL5OlYWBFqIjOgoE5
         F8W2JcxK5g2CsYJmHjFiSi81t1z8MFyIQENQFxOfoAUbi8l7/ARFTuC0ZsJfgn93T0Rw
         uxBBE1ks3oVwa2qjk1EBkAz2nnuo5Yb4rnmjqOtOPQakLRsuFfnOfNMk5IIIqAwhfzzD
         E4eC/6w+R6k+WFGNabbtpRcd9bTEgDObSrpW+yx8tY9pw+y+2+5HypTNJ9yMiDc0c0rw
         ZuSBoYdzo1z6KcI/wI5hxQteWpNVPy7ZX9A3p9G6O7e7dFtqqSSJm/3o+cqcPZmoW/A7
         tVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712530040; x=1713134840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQNYObhRI+L+iMTgrH55FYC3oUBM9fgxDq9UB6KvUqQ=;
        b=bGVfj982fL66RhcXEfmiEqwAxqBNhGEBan90zvsliXMgs4hX9KphRO3JLFwnBi8h12
         qOoSh9iry2NL7MuFARWY3918nX8POJ8otSIxY2We2uzbeCergK/uH8yLORgn3hvQ1d60
         GNoh5j5+vwntrxVtdSxt2Zhy6zmGYLpyPPPhJpPz1k0iTXyqt0YswX2X2dHb/SANM5Hi
         oLi1lAktVXzNXnssKNRF1VeRILBkIqPQeiqA75nnTsgZC9ChP8cAXInlx3aGpZEgnYD/
         gGtuLldUEwYRnSV/CUeyvErjTns8POpaHMs405y3224y0J7SvXVWGDwo+GR3MC2+5Nms
         ay/A==
X-Forwarded-Encrypted: i=1; AJvYcCWAgZ25d8csmU+bvfjnF1TmMLU2DVchM+L8uKb3e5bkvVHNM13TD+1WZYycZmE0cmfYYhwEamIgGT6IjT9buWpZ2ue7+s0UdeekLrkV
X-Gm-Message-State: AOJu0YxmWXzTcC6F41Mfd44hW5DTcjtxLZno061rGinwIHQGPNFnwUAg
	K77GiBt3zzx6ZEJM6INI+7AUNWcAN1RAL2J/l7Cze5Z/rmloQi/aLN7b1cy5a4Ws44ZQ8B+IFkx
	zPw+qDN5kszvqEY93JkvJxdTahMGiaBW60SRVVg==
X-Google-Smtp-Source: AGHT+IHzI3URLtIKHjkgagSJHJwCpeqvakmVzMQtX97IDpfEl/4h04a63N36WTGKHXr1vbYz2M7Lr3rdQ7sA7Q+TPmM=
X-Received: by 2002:a05:6902:c12:b0:dcc:375:2257 with SMTP id
 fs18-20020a0569020c1200b00dcc03752257mr6845376ybb.0.1712530040073; Sun, 07
 Apr 2024 15:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405-qc-pmic-typec-hpd-split-v1-1-363daafb3c36@linaro.org>
 <c1899fae-8669-485a-95bd-0e76738a1187@linaro.org> <CAA8EJppBE8xdmc6zQ2VLLPSzmtNq-+03H5skqbnLmLZ8AqSBfw@mail.gmail.com>
 <c9948be1-4700-4aa5-9a63-10dc215fcff7@linaro.org>
In-Reply-To: <c9948be1-4700-4aa5-9a63-10dc215fcff7@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 8 Apr 2024 01:47:09 +0300
Message-ID: <CAA8EJprybRaxMGHW+bAm5SriKNJYjWYHAok+je=Q4SjGV0iDfw@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: qcom-pmic-typec: split HPD bridge alloc and registration
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Caleb Connolly <caleb.connolly@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Apr 2024 at 22:32, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 07/04/2024 16:08, Dmitry Baryshkov wrote:
> > Basically, if for some reason (e.g. because the TCPM returns an error
> > to one of the start functions) the drm_bridge is destroyed, the DRM
> > driver isn't notified about the event. It still keeps the pointer to
> > the bridge pointer and can access freed memory afterwards.
>
> Hmm, my concern/question is about the TCPM code triggered by an IRQ
> firing here, racing with the bridge code.

There is no actual race. In the worst case scenario, the TCPM will
bring up the DP altmode and the altmode driver will send an OOB HPD
event. However as this is an OOB event, the DRM subsystem correctly
handles the case if there is no corresponding connector.

> If you're happy you've reasoned about that and it won't happen, then
> apply the ACK with the commit log fixed alone.

Thanks!


-- 
With best wishes
Dmitry

