Return-Path: <linux-kernel+bounces-103862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C0987C5DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A68428231C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80D010962;
	Thu, 14 Mar 2024 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XesqMM2+"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A362A101EE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458482; cv=none; b=t52M5O+WaaBNhcCqUeFe2CrC9tPlZ6ikTQU9Cg5lVIYGmN48uRudtjUPwg/5KVSCRUVr46NIupECSbh1VQ6F3y0598uF3cqRXG4gm+c7ssE2NjKbF88iHGapStNPshAoVrJOGwOsi8WAqu9y7FhY2oB+yg8kix2DRal3BofxNyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458482; c=relaxed/simple;
	bh=1nZ1koHEL3nJ3Z4WOjyBj9l6GAQC4q9nTZpHJxmXIvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mC+y57/Dcz7lzOWfaWYDN4bhEG/kHKDVkHKGaHbN4xccq+q+jdfi6QMzF1qcrZoknkulRfGie2qCy6Le73e0bXSVHi0IR3ZgslXO+C7QdILjzOk4qUPkcc1whv//91ljxJ+X7l8zCDyy3K0ouUeNjPFLkdL0lndUmuH9FRzpRfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XesqMM2+; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so1264803b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710458477; x=1711063277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYkkAOiHkqIfOBWqACZEdL7PfJhzMKheJAaNem7Ve48=;
        b=XesqMM2+0OtLF1Z5Bi/lXkEwLCBBfPfvKktojOEw8uqSzGmvUl1/ts0S7mnQoBP8O3
         48jbxrsxMwkYNQepyqtpL7XZd3D3oImXon26P9HrGdZGEZbLSQ848cPJbv+p79IPByGL
         HfuQ13rvvUXz1704M5KROgCku7AbNDdZRaPMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710458477; x=1711063277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYkkAOiHkqIfOBWqACZEdL7PfJhzMKheJAaNem7Ve48=;
        b=cfhEvsK+ALmtAHU1/c4t/9ZJWnD/m0cM8Gy879oe+wyldpOJQzwIjCkc9HL5c9fquE
         h8+tezzGBOUpdBICWq/65hv7dh0FDY1vvd4Idf85cHeD+dvZPz2V8jGRKsG1J71TtPBd
         6dwuHq3hX6FqAqxjDs+gycFj1CLFLc2ltvAwvgz2kDxJXhxe3ye6xFcxm+lzXusZhhqc
         OlIDvsoONO2S1Wt5QBJ4nPAR5/em5wI7Z4yOysOnac81CnD6OLYWtuJ6WqUayyPLvhyJ
         tcHN1w3DEOX9glLLuuTn84UkcZMFaBh4XHm3dGNQ7oSOTUCCdsT0K9S5FiiYa7RcYrfR
         bcAA==
X-Forwarded-Encrypted: i=1; AJvYcCXfBG0J/jN1ZCQsiSSGw6g1Tytpfa9XU3FlC74rxdKmnapOQR8f9EhNVbWkF4I0/72XVUbtcRsspSaeOA2tHDTI+Zegw/HBRhH+EN2W
X-Gm-Message-State: AOJu0YytEUtpv75lYFUP/RECrL2zpq+/4cCfmKLFENRRlIm/pqK9AmjC
	te/gHfq4YP/AUFmSqKHGr+Gc6KfCO/QkxVGpik6W2v3V2EcR0fKyTNtFJYonrdR+qcGe3/tHIjM
	=
X-Google-Smtp-Source: AGHT+IGLceA49CVw/GsOlLw10a7d6URdVkXhtqV7edImn0UspwWVQhXVlcClCYUmaV66Hasx65jA4g==
X-Received: by 2002:a05:6808:23d1:b0:3c3:5fba:98a1 with SMTP id bq17-20020a05680823d100b003c35fba98a1mr3227294oib.41.1710458476741;
        Thu, 14 Mar 2024 16:21:16 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id d4-20020ac85344000000b00430ac082732sm516411qto.70.2024.03.14.16.21.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 16:21:15 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43095dcbee6so129511cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:21:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXj/qlwpjVMFLf8aKQYAyT2u8+roqqSAw03tBbb5JvMShCVbEgAFVTzdB9nWwYDvtNAa2nH+f1mtsj3JYn/3LrRpFD+/kVdO9yL/Bvz
X-Received: by 2002:ac8:6618:0:b0:42e:ef12:8025 with SMTP id
 c24-20020ac86618000000b0042eef128025mr64373qtp.25.1710458474993; Thu, 14 Mar
 2024 16:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703085555.30285-1-quic_mkshah@quicinc.com> <20230703085555.30285-4-quic_mkshah@quicinc.com>
In-Reply-To: <20230703085555.30285-4-quic_mkshah@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 14 Mar 2024 16:20:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XWH+Eoa9XjDns--NSDTZHeUwTdrX_r_QZhSPpbZNwz+w@mail.gmail.com>
Message-ID: <CAD=FV=XWH+Eoa9XjDns--NSDTZHeUwTdrX_r_QZhSPpbZNwz+w@mail.gmail.com>
Subject: Re: [RESEND v4 3/3] arm64: dts: qcom: sc7280: Add power-domains for
 cpuidle states
To: Maulik Shah <quic_mkshah@quicinc.com>
Cc: andersson@kernel.org, ulf.hansson@linaro.org, swboyd@chromium.org, 
	wingers@google.com, daniel.lezcano@linaro.org, rafael@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, sudeep.holla@arm.com, jwerner@chromium.org, 
	quic_lsrao@quicinc.com, quic_rjendra@quicinc.com, devicetree@vger.kernel.org, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 3, 2023 at 1:56=E2=80=AFAM Maulik Shah <quic_mkshah@quicinc.com=
> wrote:
>
> Add power-domains for cpuidle states to use psci os-initiated idle states=
.
>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 98 +++++++++++++++++++++-------
>  1 file changed, 73 insertions(+), 25 deletions(-)

FWIW, I dug up an old sc7280-herobrine board to test some other change
and found it no longer booted. :( I bisected it and this is the change
that breaks it. Specifically, I can make mainline boot with:

git revert --no-edit db5d137e81bc # arm64: dts: qcom: sc7280: Update
domain-idle-states for cluster sleep
git revert --no-edit 7925ca85e956 # arm64: dts: qcom: sc7280: Add
power-domains for cpuidle states

(I get an ath11k crash after that, but that's easy to hack out since I
don't need WiFi)

I suppose the two options here are to either:

1. Track the problem down and figure out why the breaks boot and then
fix it. I'm personally not going to track this down, but if someone
wants me to test a patch I can do that.

2. Delete all the herobrine dts files.

So far we've been keeping the herobrine dts files alive because I
thought some graphics folks (Rob, Abhinav, Jessica, for instance) were
still using it. ...but Rob says he hasn't booted his in a while. No
idea if Abhinav and Jessica are using theirs. Any opinions? Is
herobrine hardware support near and dear to anyone these days?


-Doug

