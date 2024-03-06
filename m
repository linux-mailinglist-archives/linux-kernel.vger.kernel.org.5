Return-Path: <linux-kernel+bounces-93452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD87A87300B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB2C289B5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DED65D470;
	Wed,  6 Mar 2024 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWQ/NT1i"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556CC5CDDC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709711777; cv=none; b=NGwhkpOROrcaqK/DBkw1mk0J64/OrM0SzN/jmE9q7vmWsbdgGhIm64B8RAQUTL5tAoUu4fb1y37PH/4VL8Iqajv0CyIz4td4sxdb39w7hzGdzSrWueY0mBkaeTlm2K4SJmTfx2m9qm7oIbpHqi+g9zJXrVhxwsnYkLYrhO14umA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709711777; c=relaxed/simple;
	bh=DAHtD8v2l5vj0Pvrph3wvnBNooXZC0OYJ9kZAnTthmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjYfKD85YSy0lnRt6YcG8EluU/DNDSif/YyyzuFFjs+8H/itEnwgG7C1kKN/lfJhnBBVONv/Ud5kTtkekDB7+W3GhkQuz3outpfWnwhUJ8HWhOOeVN3dWyF2XxykqfS9aQOwbMxdBaAM3ltS0VzeDu6j0E3qiZ6ZTNdr4h/pM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FWQ/NT1i; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60978e6f9a3so67945127b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 23:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709711775; x=1710316575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R2p1lYtbK1lYuq/4XRU4oVO0x0kHeG6Tm2yL9vnyQOc=;
        b=FWQ/NT1iR4OX4IijhqQmkPD6i+DYnE+gybGE0hQkvPRUoC0ynGStLj5V3X/E3+oX0u
         8RKYrV4mAbZ3cKkSUh3stHq+cS/bj7JJ6v+eTVaYB06usNaevSemISgeEK3rH56hO5rq
         yVbwW7zAqMnPRXrxPj/47u8OCDfKG97HWeP/q3v413pbkJhrx4Zq2MsCQz0EWW6csV84
         DCUNGZ0zY+i6fjjTT3SeSMH1TdK1kNyfJvS+ihulXekeKSWqp/wI2OixOhq4+Z1SASbm
         l4f8+EV6lZPrYpKZbTP1qQB+JW2fMShAhkm2M6qgk7bW0KR5CxOZWmVOEBRKfGIwD82x
         LB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709711775; x=1710316575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2p1lYtbK1lYuq/4XRU4oVO0x0kHeG6Tm2yL9vnyQOc=;
        b=AevSUZsHKeRQ64IePJLPkK8GPNcQRd4TxWZZcGw73lNHhZLcxWWlgBDRrrBmRkpMjy
         TFKq1zt6F5iaZtuU3IGlTbHpFCQqyuXzkVyPsVaUPT3y/Ct10QZ/NekcGRLKt9WWhVU3
         2P+9MLxMzHb7oBcVn3TCD6F8o2jfJRh1VPVKp9vGVM8QaRroHFh4kl9MlRYzOD2nMu5X
         TzmUnjcJhs0QDHdMvHEYXESJhEjPNOpWpZHWa4MJ1o5W8dHA16gFIae4oR26JfRJzX//
         5YTAwTQASfPykJNuUz8kxEsLW3IpS/M+dhPlr5bZ1euFzueJ0hwUqrOWXjNEx1YrkYfu
         aYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwDdd8ThQ7V44npFsRH7ItWFAkereeyI046DFA9ftHZwaehUanPBQtF6aXZad+0kk4rEwRBuasjXjvhSkwpzaDv7fMBgRM15DX+jMk
X-Gm-Message-State: AOJu0YyV6zmHw7zrroNqVibnyJpVmQtdbquAGSt3Sd4AM2ccI1+iZIqw
	Sg5vy0gLRWsN+Ar22M8XA5hyNsStmi0qV5i7ZScsvX4n5l+tPHJqgTFMzh1gATJw++PnQjAja/1
	qRwQhpkelNe9tbOFdiJMwHwxqzm8WmxZZW5PjHw==
X-Google-Smtp-Source: AGHT+IGlvcQrkg1QpVFgZ5NlDd9P0g9ctcuCGmag8rQ9D7aPGaoal06qvr96/3iIQknLCEgxJyaHwrsl05+/MGfVdUQ=
X-Received: by 2002:a05:690c:ed4:b0:607:ca2e:f23e with SMTP id
 cs20-20020a05690c0ed400b00607ca2ef23emr20013019ywb.30.1709711775343; Tue, 05
 Mar 2024 23:56:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304-gpio-keys-v4-1-03604d778c86@quicinc.com>
 <f09dc3a4-ed5e-40b7-ae71-7c6cfd79da1b@linaro.org> <02a2e93b-f0f1-4506-9e17-444cfd1a208f@quicinc.com>
In-Reply-To: <02a2e93b-f0f1-4506-9e17-444cfd1a208f@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 6 Mar 2024 09:56:04 +0200
Message-ID: <CAA8EJpq64dwEi3NrEnvqnFR5YTSDitx9sgZVheho+UL0rz0FsQ@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: dts: qcom: qcm6490-idp: enable PMIC Volume and
 Power buttons
To: hui liu <quic_huliu@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 05:02, hui liu <quic_huliu@quicinc.com> wrote:
>
>
>
> On 3/6/2024 5:20 AM, Konrad Dybcio wrote:
> >
> >
> > On 3/4/24 08:09, Hui Liu via B4 Relay wrote:
> >> From: Hui Liu <quic_huliu@quicinc.com>
> >>
> >> The Volume Down & Power buttons are controlled by the PMIC via
> >> the PON hardware, and the Volume Up is connected to a PMIC gpio.
> >>
> >> Enable the necessary hardware and setup the GPIO state for the
> >> Volume Up gpio key.
> >>
> >> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
> >> ---
> >
> > [...]
> >
> >
> >> +&pmk8350_pon {
> >> +    status = "okay";
> >> +};
> >
> > This device is already enabled
> Hi Konrad,
>
> The status is not set in pmk8350.dtsi, so I thought we should set it for
> "okay" manually. Do you think so?

What is the default device status if there is no status property?


-- 
With best wishes
Dmitry

