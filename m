Return-Path: <linux-kernel+bounces-41462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1455A83F239
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D9A281A1D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD34822F06;
	Sat, 27 Jan 2024 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cdQGcePf"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0920DC8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 23:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706398521; cv=none; b=Bkd53/QgVfSqyRhgdINIomS+nlplfWtEp3QOtILQY8IleX3GxysXLRmA6v5BN5wytfjNKllZCo5eXaS6ecvMRwPWD+k5jQ5AHEJUHGnXs7kunXsp3zhH/hDnrFzH5di0xYZ4nyTFogcEcY9fI2TunGYzSMmutctpYgBHwlVZyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706398521; c=relaxed/simple;
	bh=8dcs2TTkHifbaPOo0/++EzaKXk8QckqprO0d5UdvmNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=da8/eZISkv3Cum8+I2hmJpEJbpQYp9dOkOmqdRb+8bv/viUHk+MDlax7isSt5LkEkXODzHzExU+rKAyifh1hYIVNwrLhaFiDWaDle72/kXYk4AciYun9ThSBNPc/34Ft+K32CTwfzf+DYUyyr7t7BDuf+Vee3oURt07Sj/uLNM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cdQGcePf; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-602d2e67217so14620977b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706398517; x=1707003317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dcs2TTkHifbaPOo0/++EzaKXk8QckqprO0d5UdvmNM=;
        b=cdQGcePfn+hWNuLbjso96g32qo8/g2TeSlD6FwjRe2t4wKn30YYAr8TA+t7sdi2h6h
         rt1dmwhPWR7FJWmyBlGgnHgCzDY5RJBuAKgbJQjSv/5Tnhk2JaEY2/5M6SBuPVkiZax5
         frvV24EabdjJZYpVIr3aR1pVC2NUurehT77c4U+iTyq5AFlG9LB6DiKsVVTo+8Dg/qYs
         hCm3Ei3Nx9vT/y+2gAVKJMR73CCiRR9snspWLrQudQ+9IX4WGFjZQDg9VaHN4XhgBuMI
         yQ8cXYx5+RmH+ig3geK6pJRoqq5WXNTYT6ymKi3o4ga6imFCtZovEKis2F/hu2L4u7rj
         yr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706398517; x=1707003317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dcs2TTkHifbaPOo0/++EzaKXk8QckqprO0d5UdvmNM=;
        b=QCHh0OIKUxS+pMAbmHmYOnV28qyfaxWC9hL7wK9RLRjOreB8RscDcA5pfPix6WPqZd
         deB+rY1J0Zb8EjcGSTlpaZOkUqsKcEK7knw3e++GrUuPPlH5VGhJY1q/40v3+eRPM/6d
         q9nzBXUQW22gxWvsJqC0ITL7eKH66v6T9K2yq8bRYePmiHDP+RanPV2xzo76i2N3WgHJ
         MhBBtkbqkk8Lk1PBD515c3qYvfGRUdk7u9c5BNfR4/NKJg41GbVMBNHJrZhxNwYu+4AX
         wX8b9oa7WiZF5XadfGtwVdjtWAhSVrX0kGB5BJR1XjJA94+oNG3wiMWDR30Z5TDHLtNw
         Duqw==
X-Gm-Message-State: AOJu0YxWSqXkn6iWyP0HicUPiKO8/Leoh+X0f5hbeFQrgvlSVmYIgse/
	E3k616jLbM3yZrX2VsjAzsk3fWyRyFpipaawkBdirPQ6deL24jZ//j4X/I35MaQLxsI2Qhch5Xq
	dN5EJ4lEHwoqrOfUVi9vLp5oEu/edlqKL+o3XcQ==
X-Google-Smtp-Source: AGHT+IG+6hWb0s/foSEZLTCcN7SlXEPPPDIG9Ie8b6zG/DvFbXAnoRbb9i8W1JXuHzPD5xc+sCGWgYH3mLKI3aCinio=
X-Received: by 2002:a81:d80b:0:b0:600:2a65:cad2 with SMTP id
 d11-20020a81d80b000000b006002a65cad2mr2081570ywj.26.1706398517251; Sat, 27
 Jan 2024 15:35:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110-pxa1908-lkml-v8-0-fea768a59474@skole.hr> <20240110-pxa1908-lkml-v8-2-fea768a59474@skole.hr>
In-Reply-To: <20240110-pxa1908-lkml-v8-2-fea768a59474@skole.hr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 28 Jan 2024 00:35:06 +0100
Message-ID: <CACRpkdbSSH6mBYVyk2u3G60vmbED7WhEdYnXoc3TwovOo3oJhA@mail.gmail.com>
Subject: Re: [PATCH v8 2/9] dt-bindings: pinctrl: pinctrl-single: add
 marvell,pxa1908-padconf compatible
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, Karel Balej <balejk@matfyz.cz>, 
	David Wronek <david@mainlining.org>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 8:04=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic=
@skole.hr> wrote:

> Add the "marvell,pxa1908-padconf" compatible to allow migrating to a
> separate pinctrl driver later.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

