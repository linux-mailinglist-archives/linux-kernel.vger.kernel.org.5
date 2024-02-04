Return-Path: <linux-kernel+bounces-51840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AB4848FE2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19651C21528
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CBC24A13;
	Sun,  4 Feb 2024 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g1hUHdEU"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42715249FC
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707070740; cv=none; b=apNhUE5GOFDBrS/9B1tnm+7ttmPV5me69h3N+61bTA/FcvG+BMhy3otue0O0hwgwqmOhAvwLAjKy/75f5KiD7OBXaAmCt6YjM99Ngqxo4GizV1gomj0juy6t9gJKRgsrWKJdTvPAnhXlkCXM56oY1tQ1ioVISxFfB1ibfFZN+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707070740; c=relaxed/simple;
	bh=3w00XsqZZNEJgfTVb0Mw/wkTith+nLWiGUTMx8Ahb8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhJ4eCy17KBpIyyN1sLFk3nYXoITYz+DqXiRXdZDEciVa/JP7nGJ+A9KqO9t1vKuSJulVQ6iMDcnp1mmCmKTz5odQrQJWfQnHfRH6hZ9qGOY8QG7RPucT+Jb5lAqBm4NGzOL6kxpTzCJk8P+k4QIUFjbu4G+6bbKipmcLY0oHCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g1hUHdEU; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6045db1b5a1so1602307b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 10:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707070738; x=1707675538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w00XsqZZNEJgfTVb0Mw/wkTith+nLWiGUTMx8Ahb8Q=;
        b=g1hUHdEUrYrhiMomvYkGATJ8IhocW6cOUqUjGrnkTwgj1otzyd0Psn0QeIQ/Cqo9pX
         hQ0af42fVxe8Ph+qUQ2sDrl/LAeleXiZ7l4hmFfVMbTB05dRCWqwFOe4vDG6iVdIR0ew
         iRQHAdbTHnvngTLDemQO3lRFYEOet6PTvs8iwp6qYSOw7dkDk7D1OE0m6/aUxoTIu4Em
         KC4IpqV/TusfXjnghdj01YfFzA7BM/qJ1FpwbeR0ojci4D2NbACjJZPoh63jV+A3ILr9
         yjBGgNoMXAtM8ccZm0yzHDw+DB0Fyq+nXiZXfjIdlG4AaJN6V1HwzLneyEkMtLJCpZid
         lQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707070738; x=1707675538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3w00XsqZZNEJgfTVb0Mw/wkTith+nLWiGUTMx8Ahb8Q=;
        b=T2V+hyECtO1aK4Mi5M3QM3qkvQaIsICsd5PaD650g6V/earWJil+7YOAK15AgXgVW5
         Jn3jsYvr7T98Pm/6QLTRu4jOBGfG8XZqm5oQTocBi6RsI/SE973xgsX7HuwO3kGuipCR
         Yt45JQIdOXI5lYBAJ1NpOpfVuP/lOGIR5FuhxwUiax8bbYKa6yxE7A7/WSlyfDU7SVHH
         R03FYU9gj3ma9YxpIIciV+9+ZqerDameqH8SH+NKSLCPQ2pLt5A9DlUeE4CBRckDRsk6
         GoAjnoeBRVl/L+rquNSIls+ulHhU+rdJ1oL+TuuigPURQjaRtvy15DvUrqacwtvlPI/7
         BG5A==
X-Gm-Message-State: AOJu0YzjjbouEzCA3FKmDNEXSwI/TwrjQ4r+DC6Hz9HQosvA+DX1jfk8
	QdzkHlvqEDFiF15OxBCIvrQRM+TzlMPMzm19Sc8Ru9eVRniEipyFR8BXlPt7fkNu/rszBl5txks
	9NtmZnVlsyz9Di8Y82IChTUT7raZ0G45gjP6mDw==
X-Google-Smtp-Source: AGHT+IHlIEaGaeAMWab7/L3E0/tkffip020QFwU575qHSmmvDyGp5Zk55jezREUcVn3JVEng+6jrgXNRvKQDrd38TRk=
X-Received: by 2002:a81:4422:0:b0:5ff:91d8:42b0 with SMTP id
 r34-20020a814422000000b005ff91d842b0mr10758935ywa.46.1707070738137; Sun, 04
 Feb 2024 10:18:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706802756.git.geert+renesas@glider.be> <ffb1eb1d747dce00b2c09d7af9357cd43284d1c4.1706802756.git.geert+renesas@glider.be>
 <CACRpkdaBBFjtgoUhhK8-X28BK=2NCyRS2NiYvVEZFAsQiNZH9g@mail.gmail.com> <d41b0858-df3f-4002-8a51-aaf91bf3a659@sirena.org.uk>
In-Reply-To: <d41b0858-df3f-4002-8a51-aaf91bf3a659@sirena.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 4 Feb 2024 19:18:46 +0100
Message-ID: <CACRpkdbquEYe4mtfFikaQSFjEsQMqY5tPbOSTCSB9MPqx2OOLQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: gpio: Correct default GPIO state to LOW
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Liam Girdwood <lgirdwood@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 1:23=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
> On Fri, Feb 02, 2024 at 06:41:31PM +0100, Linus Walleij wrote:
>
> > Actually, Linux can read back the value just fine in output mode,
> > so what about just ignoring the property and update the document
> > to stop saying that about Linux?
>
> IIRC that was there because historically the gpiolib documentation
> said that this was unsupported (though the code never actually prevented
> you trying I think?) and will have made it's way through the DT
> conversion and refactoring of the bindings.

I have this gut feeling too but I can't find it!

Yours,
Linus Walleij

