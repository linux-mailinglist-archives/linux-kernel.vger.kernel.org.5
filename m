Return-Path: <linux-kernel+bounces-86012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 352C586BE89
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29B4286521
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5043A381B0;
	Thu, 29 Feb 2024 01:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iqoWSzGh"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21ED376EB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171483; cv=none; b=EQP13LAQFt7sGuae6ZqWgtMGLD6AghfauIJs1tXwGBg36lsojL0xRWs2qCQ9WKrdsqcuHTbWYTaaN+f6kZWwmfTiwZnM42R3w9OPvh1g+LhoAgUGGrV5X0Y4H5j78joQ/ulrZMN5/X7MQEyv6onE1RMyG7d3Jfp/WZKXhkJiuzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171483; c=relaxed/simple;
	bh=dyNQOsNqoX691z3lmsUE0UqeK3j+5UYGTMnTcRHjwiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEKBnd9SWXrEd048XksLTnXsrxBVh/lpEdtwoLXwQoosm0tYBHEw3lBzIXr+VUspAS2HQzVCjiI0eFjTC2+/Ls8z05Ay2XLWNwTifgUSJcC5GC/nzNUnSeY36jJVU9r2ZYdgbffqggwz7ZUk4V4DeLdQgHrKfUvnUFyDjSW5g9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iqoWSzGh; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5649c25369aso574328a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709171480; x=1709776280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BA3HNtaKQLlopR5HvEpA7g8ezYuwOK+W5LJ79NFDZrw=;
        b=iqoWSzGh37cQSmXOYe5wmZu9QoaiQGkBjr6jBUzcKfGzc9S90/QTsySvUfDK2c53YS
         hpwThV4OwwmfPf44zeBYZe0jRcUn4Ik2wai+UzklEIVZ97QVBd+++MThL/7IvcnQIQvc
         aVrE8CWYPqoXrumISVWKrqx1G1VLEbytEGi5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709171480; x=1709776280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BA3HNtaKQLlopR5HvEpA7g8ezYuwOK+W5LJ79NFDZrw=;
        b=EDE7BnIEHr39l7Eqa6SAg4E5urw/PgWPiqIQ9Qgy5zbsei0yYsPvpf28M+BmWiiUHv
         TqG5VkhvrLR0pZYb9WhHcoZaUjkzZwRt07ojKZDypbE8dX+NtXjha0OQdtygPdH+8seN
         x7O7wzYACW/x2HREdceihRdpCzmM5cnrwv1GlGN7DThj7QDIB8OAS3ToAcm9QFNSiaUP
         GZhEpuO5GvOdt5abGRxeBHe9zhNZLGrKl6oVrrHPYYc7twGQWXDL+MFdN/1zQi1Os19j
         wTafcqCIG2sv/Elf+VIoNaz4wGYInfArrhfyHlr6nBNyedbg6pfEqeTfnguxuZDCX6n4
         ORZA==
X-Forwarded-Encrypted: i=1; AJvYcCU+wgkO57ma7mQ6PV/9Iguh1hu0S1RZuyQml1YHHogfIbVDHQGWRw6sAbQu2a693hvTfNbRuxUE6N7qXB7V3Gay6WY5h/DiFV4hw84c
X-Gm-Message-State: AOJu0Yw7ur525E6cHbYL5u7cm6Di/Nm/kwQC859rmpmGvUaziV/c7C8X
	SKWMxg9LJYiRtsPajeDy2YqSMf/s5MZW3Uh+WTTvpT1oZW3VPoOpR9MsCuWaWKfLgxPjDp6s6vf
	metKC
X-Google-Smtp-Source: AGHT+IFViGrZR9LZU0ifXA0Kyw41xZJ4Q983O2T3YbyjhD2YbKKzpscuMvp4jHN2fjPGh/BFG2Pu0w==
X-Received: by 2002:a05:6402:214e:b0:565:6f27:9dcf with SMTP id bq14-20020a056402214e00b005656f279dcfmr470537edb.34.1709171479847;
        Wed, 28 Feb 2024 17:51:19 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id c8-20020aa7d608000000b0056470bf320asm120742edr.43.2024.02.28.17.50.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 17:50:59 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so19485e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:50:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgTBOzZ7wkXZXicd3dE0oL5j5hfxQewV/buijOKehqQf1V8QqPb3XJn3MqwfCcgroUO8fN1KqK2hqwmBqZtKihNmugzB3WNo1u/pAI
X-Received: by 2002:a05:600c:a384:b0:412:ba22:fe90 with SMTP id
 hn4-20020a05600ca38400b00412ba22fe90mr11378wmb.7.1709171458829; Wed, 28 Feb
 2024 17:50:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229013503.483651-1-swboyd@chromium.org>
In-Reply-To: <20240229013503.483651-1-swboyd@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Feb 2024 17:50:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xba76ZER=rqWm8H6dQTgkTRM38Edi81Y8-QXETvsmDCw@mail.gmail.com>
Message-ID: <CAD=FV=Xba76ZER=rqWm8H6dQTgkTRM38Edi81Y8-QXETvsmDCw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Disable DCC node by default
To: Stephen Boyd <swboyd@chromium.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org, 
	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 28, 2024 at 5:35=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> We don't use this device on Trogdor boards. If we did, it would be
> enabled in the sc7180-trogdor.dtsi file. Let's disable this here so that
> boards with t he sc7180 SoC can decide to enable or disable this device.

s/t he/the/


> Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Fixes: add74cad7c9d ("arm64: dts: qcom: sc7180: Add Data Capture and Comp=
are(DCC) support node")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Seems fine to me. I guess the driver never landed, but if/when it
lands then it makes sense to just enable the device it for boards that
need it.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

