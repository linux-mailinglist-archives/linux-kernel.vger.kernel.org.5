Return-Path: <linux-kernel+bounces-107779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B06E88018F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E592D1F212AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE0D81ADC;
	Tue, 19 Mar 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n8MHD4bB"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1518C651BB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864674; cv=none; b=H2HM4eDhEHyHvJYzk4pxKKNjAZQkN+txppsAvIerowzlb+LGCfWCCZqo/ByC4chLZz3EpS/KdqFrTYEQPKoKObV3KOioVNElQzr9SJeYPYnno80/W9A83NNvkO0/Y9k0i2f/an9VVyjnhunx79pCljjDtNaPtxF33U0+kMeqKxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864674; c=relaxed/simple;
	bh=rYjMj7ePgUflQEILg5XkDq3SlXHXtDYoYHvIrr8ecTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0cuo9rTlIKo+DGZAJqbLkIVq1mJ+mpPLr1okzOOLoYCmtquSJXUFJjtDNT+WWCwDp8eS6PHjNBGld0UkHhj9lV5n4Xw34FoTt5+G98/LdbaE4/0juWuW95K2OZEPKrMxxShAwgzy6ZtYMJFjinpfIy0/zE5HoUdgzT7+/7QN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n8MHD4bB; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-430ddb1a227so9456491cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710864672; x=1711469472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riAPw+X1m6DmK1tPVpYKEJDjgOP8E/jPhgqRZJ5EE70=;
        b=n8MHD4bBnYdVhcowT0z6c23AiZSxBtEOCoaQ7eYstfMWTnCD0XJDzd0d/4focATNSD
         DAU9yNBn1Pqxc3bZ7Em8Lhr+kNKd23ydkIrTPlB0hD2V8EDaNclpjJqE1bhjD/XkWSVP
         xHHfgY+Tm+9IHe4ixzf2R0O8EfCh/HVFTep2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864672; x=1711469472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riAPw+X1m6DmK1tPVpYKEJDjgOP8E/jPhgqRZJ5EE70=;
        b=BfH8/DMm8ohnfT7eLNrhKHSOihwXPHFlIqhAz7WZoUgscgHinWNFzTZwidAEQdU2/z
         suNPIf/kOAVaCrd2/HlL6mm5f+Ll7T+P/yhr3l52VpxE3uQCjXT+2s63F8SyBLDyPTqL
         xjCnWo9zUoUAMZ1LRqVxe5nb83IRwIQHvxRyOZ2vxKtm/F6DrDV8vkzx+f3TkCywg61F
         pXVLhc/nDQE/B4DKgpfg2g5F15W+tIjDbGpmHa0kr3ZmmY2fuXQ9MNdGa5aehWIfZJkR
         u224fTcTyynKO/wD0u+OOfKkrIFyF5GbINbflkOUhHknZ2yTk4VCqOCYQExeBa3uwN2M
         mJEw==
X-Forwarded-Encrypted: i=1; AJvYcCWBmpqyEHFetUwSh7tr8Sq/BhZElOmzgmC7cRsJefo9ITitr+igxpfUBZwlfScuHBko3Mj2IsoWTjAscCTJnuQO0Cz8ZQjv980EvUoI
X-Gm-Message-State: AOJu0YwZ/YqLBfx7ikflHXguBbXp3Ep7EmzXoKGZqEFlhI1wxSse+qsK
	Rqgw1LjpZlH6ABK37O+aL73eODJ0eHun32B1nuETnt4Ic+OoA9l5IaizIoPVV2VeKgJ5bKLUI4o
	=
X-Google-Smtp-Source: AGHT+IHWXZP/oZOf84fVpKIOjALdY6hrIt8WLczhfdEvLdiXdcik49z5BgbjTMKsFWgmrXT2Nhjrtg==
X-Received: by 2002:a05:622a:34a:b0:430:edde:dc5c with SMTP id r10-20020a05622a034a00b00430eddedc5cmr1611989qtw.56.1710864672035;
        Tue, 19 Mar 2024 09:11:12 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id k22-20020ac84796000000b0042f07081f26sm6204298qtq.22.2024.03.19.09.11.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:11:11 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-428405a0205so374371cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:11:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIfYQ6/t6reeRWT74ukkEmgxz1EfZXjQTLuqpwZny05ljSXzHCJQAI30GA946bwplAdcGjYmZBhP5MofrB+dTWuj6iWkA1govmCGiY
X-Received: by 2002:ac8:7c44:0:b0:430:bcaa:187 with SMTP id
 o4-20020ac87c44000000b00430bcaa0187mr392494qtv.18.1710864671219; Tue, 19 Mar
 2024 09:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org> <20240319152926.1288-6-johan+linaro@kernel.org>
In-Reply-To: <20240319152926.1288-6-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 09:10:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ut0pOAFxD5KELqK+_bkaKOBaYWTth0aVgO5LmMKraPyg@mail.gmail.com>
Message-ID: <CAD=FV=Ut0pOAFxD5KELqK+_bkaKOBaYWTth0aVgO5LmMKraPyg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sc7180-trogdor: mark bluetooth
 address as broken
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 8:29=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Several Qualcomm Bluetooth controllers lack persistent storage for the
> device address and instead one can be provided by the boot firmware
> using the 'local-bd-address' devicetree property.
>
> The Bluetooth bindings clearly states that the address should be
> specified in little-endian order, but due to a long-standing bug in the
> Qualcomm driver which reversed the address some boot firmware has been
> providing the address in big-endian order instead.
>
> The boot firmware in SC7180 Trogdor Chromebooks is known to be affected
> so mark the 'local-bd-address' property as broken to maintain backwards
> compatibility with older firmware when fixing the underlying driver bug.
>
> Note that ChromeOS always updates the kernel and devicetree in lockstep
> so that there is no need to handle backwards compatibility with older
> devicetrees.
>
> Fixes: 7ec3e67307f8 ("arm64: dts: qcom: sc7180-trogdor: add initial trogd=
or and lazor dt")
> Cc: stable@vger.kernel.org      # 5.10
> Cc: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Assuming DT bindings folks Ack the binding, this looks fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

