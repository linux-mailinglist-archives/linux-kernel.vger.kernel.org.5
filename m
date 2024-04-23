Return-Path: <linux-kernel+bounces-155855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F7E8AF810
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083E61F23C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D059142E7A;
	Tue, 23 Apr 2024 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AfFm0DLD"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D6B1420C6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713904600; cv=none; b=nResZ/nMMSNiyRYbzd/e8a2SpwR2+SC0Qe0wJFXZn2YpW9QDXdqkCp9cFGBKIuvkaQ+KpTV0gK1DGf+jY7MxwZMVNwXcpzO4GgdnbD7XNHc0TTv6waTgeR61jfCMegXY+DhKh4xrC+TKzgwHIbcFixwm9dJUgsom2rGK5pPr3VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713904600; c=relaxed/simple;
	bh=hdVBYhMGvt4bNKMToAfaZbct/f7HDFw/iwj5G53CShY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muUn+yrNlNv92kU9wLKhGYbCjBP/1WyKIMbytTlXwD+sk+5dFz6c4MkVT2/IDv47puufUypYwYDaD1PCQZQj6Xgavecqbok1B+davXnrmwtDuXqk+pXoi587vOnaeWKSKXa8Ui0i4l4LSWYZsCkPri101QwABF7g0nmzp3FW1G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AfFm0DLD; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5aa362cc2ccso4304846eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713904596; x=1714509396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdVBYhMGvt4bNKMToAfaZbct/f7HDFw/iwj5G53CShY=;
        b=AfFm0DLDqAIgfOhgdgIlPSE17bGr/mf1rs3EKLIdFm8I6M/2ixA4QRO6xvNnlxLT95
         TxIwYbf/9W4u5JAVzKWx6tAgOqxnjv/rjKDJ3n5B+5L/yNbynN4HEC1CLbES0yiBq/K2
         ISYb71b3auMD/PTnBCUn4ueWgXibYM3by5SV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713904596; x=1714509396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdVBYhMGvt4bNKMToAfaZbct/f7HDFw/iwj5G53CShY=;
        b=WCPbM9qQ0LrUXI+l2090CdU2B+92c30sIG0lYA8Ly0U0ZeXbDPOOF51FSq7RkiT3oD
         phtlcf4kr6fwCCaIp4TpBsVaWo8Su2FjNKhGSVh/sb7xBHnT5joFBIcDYD8kq0BzhC2o
         Lvj6USa3cUWvdZyx53p8m47lVIoTKwhxITjgbRdOrH6+Yg/MHe8L9zMS2Fii9OsE8jgE
         x/CCmyM2PrcEZl4sxA906DrvlHs3oME9R3zzBF85Rov4AhEqUXP74djOb1ntQwx7Q29f
         ojWh0jrFU5tEq1E/rvi9irUf+nsOWWGju6AGioZ8By1YefHZsvAwb46859zD5rD7djGp
         sn2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDEvAqt/c92bCMdMU4VkXqEg5aTS2wW7rLmmL2udbA3dph1klw0RkFcwJwAOu8C/nYu+pLDmORExK7+dJelTgDUaYwfio+vJ+ulsfO
X-Gm-Message-State: AOJu0YykMrPj6/T+9fvUYP+yuv56QIjj97WbllGbmSFfbohDTqr9S8OL
	tEGadkOL2TO5BOERYG39Cz/fBCkUJzXNX0VHs2xVxdFZJj2ipvqqTspbyeSlQeNc2Rp1uVf4XMl
	fNsBl
X-Google-Smtp-Source: AGHT+IFwvDjEIGZ+lXzjdX44ZYCX5McjP6m8KljJ6Jvlu92Z9Nj3x+w+atatA5CgD5obyJ9ViY2Fcg==
X-Received: by 2002:a05:6358:980f:b0:186:1805:c6c2 with SMTP id y15-20020a056358980f00b001861805c6c2mr421001rwa.0.1713904595719;
        Tue, 23 Apr 2024 13:36:35 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id dn16-20020a05622a471000b00436cd19d996sm5457680qtb.87.2024.04.23.13.36.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 13:36:34 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43989e6ca42so95741cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:36:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXR9X6gSSYJPKJ4RAbMZFOi7PgPcqko6zX4SZbz/ER/d8Fx3zg4btpQXxpLdSzJ5LE884xHlNmIzOtRO86buZ4eC9m+iVYikMS7A6Jk
X-Received: by 2002:a05:622a:1cc5:b0:437:b572:6a with SMTP id
 bc5-20020a05622a1cc500b00437b572006amr6192qtb.23.1713904593750; Tue, 23 Apr
 2024 13:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423134611.31979-1-johan+linaro@kernel.org>
In-Reply-To: <20240423134611.31979-1-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 23 Apr 2024 13:36:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W2Y=Sr-=YkKb01XLQsbQJr2b981c9kcfvAc4_5E9XD7g@mail.gmail.com>
Message-ID: <CAD=FV=W2Y=Sr-=YkKb01XLQsbQJr2b981c9kcfvAc4_5E9XD7g@mail.gmail.com>
Subject: Re: [PATCH 0/6] HID/arm64: dts: qcom: sc8280xp-x13s: fix touchscreen
 power on
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 23, 2024 at 6:46=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> The Elan eKTH5015M touch controller on the X13s requires a 300 ms delay
> before sending commands after having deasserted reset during power on.
>
> This series switches the X13s devicetree to use the Elan specific
> binding so that the OS can determine the required power-on sequence and
> make sure that the controller is always detected during boot. [1]
>
> The Elan hid-i2c driver currently asserts reset unconditionally during
> suspend, which does not work on the X13s where the touch controller
> supply is shared with other peripherals that may remain powered. Holding
> the controller in reset can increase power consumption and also leaks
> current through the reset circuitry pull ups.

Can you provide more details about which devices exactly it shares
power with? I'm worried that you may be shooting yourself in the foot
to avoid shooting yourself in the arm.

Specifically, if those other peripherals that may remain powered ever
power themselves off then you'll end up back-driving the touchscreen
through the reset line, won't you? Since reset is active low then not
asserting reset drives the reset line high and, if you power it off,
it can leach power backwards through the reset line. The
"goodix,no-reset-during-suspend" property that I added earlier
specifically worked on systems where the rail was always-on so I could
guarantee that didn't happen.

From looking at your dts patch it looks like your power _is_ on an
always-on rail so you should be OK, but it should be documented that
this only works for always-on rails.

..also, from your patch description it sounds as if (maybe?) you
intend to eventually let the rail power off if the trackpad isn't a
wakeup source. If you eventually plan to do that then you definitely
need something more complex here...


> Note that the latter also affects X13s variants where the touchscreen is
> not populated as the driver also exits probe() with reset asserted.

I assume driving against an external pull is _probably_ not a huge
deal (should be a pretty small amount of power), but I agree it would
be nice to fix.

I'm a bit leery of actively driving the reset pin high (deasserting
the reset) just to match the pull. It feels like in your case it would
be better to make it an input w/ no pulls. It almost feels like
something in the pinctrl system should handle this. Something where
the pin is default "input no pull" at the board level and when the
driver exits it should go back to the pinctrl default...


I guess one last thought is: what do we do if/when someone needs the
same solution but they want multiple sources of touchscreens, assuming
we ever get the second-sourcing problem solved well. In that case the
different touchscreen drivers might have a different idea of how the
GPIO should be left when the driver exits...

-Doug

