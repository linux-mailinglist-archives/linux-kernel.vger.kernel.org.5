Return-Path: <linux-kernel+bounces-77429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEBB860542
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70F43B213CE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA0D12D1F4;
	Thu, 22 Feb 2024 21:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SNx2HMbN"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569BA1DA22
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639035; cv=none; b=gIngJ0EqSjzfizq1Gz+vYmzWKBjVCUzgN6fnJRXBb7bu8i4doGziwKruRa6NKDmrKBqqTAbITwMbuNjjqRYDYcqqC6eNAS56RksTPCbqkHydxxij5zsQ7Xa+DJrBYBZ/9c/292wk5ru7eSGvJ7CZ9/Rt/jqKNmcPnuBt4TMCW+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639035; c=relaxed/simple;
	bh=lRX6XeTxlnL5+mD72dnhgY+YEzSN3hJ88W5LKAoQN/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yn8+nnzVgdZsCuxTMFowMhjPdbdqx8MqHGNCBMDh+s6sNlS7xv7Oa7wvQsseuKgCMK+ffeQiQj1UhOMgk1hvGN5PbjnntauT+hesH/GjXreoagc3q3jmA1YFZkfP86eNupC6JlN6TqOxWoom8GLDrWIE4ATN+aTo9EGcv6AkSuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SNx2HMbN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d95d67ff45so853335ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708639033; x=1709243833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgirAjgozx3q0jtmvrwCmz40wwbJnIl2DI5Cq05LY48=;
        b=SNx2HMbNAJ7iPBpeWzPsQ0F0p3AgsQFVXgMzVKskY4aT6Rj7OY32SpAizKkNq8NP6x
         bYI44InxCAn3P0M7kCdgSrsdBX2ph5TXrDejBffP3mci9xyne1oqFneluX5J8O8IE7wH
         PYh0gbnV5xdXdDk1pMjGLurW1N8/prEd3HeTWinK9TqdUzbaEcTBk6cOEwHhvVGocjJl
         lfeTrRiDskiA2h4iYfspWMvys0QgqXjCeqaedQnoTfxchxHqjmM071uDTSMOk759cJC0
         HYn1l7ON9DsGXK7tfRBRsBa3dz28JRiyNY7RVRAQ4SClSwm/AkT9hJ3ibmAJZPp3fvKv
         DEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708639033; x=1709243833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgirAjgozx3q0jtmvrwCmz40wwbJnIl2DI5Cq05LY48=;
        b=o0OO+LefElNDhyEyYEAOzdSYHT/DgWyRZLt2476mXLbwzq5pONYk0EfWL/uo5QScOh
         DXKXeT+W0pbYyqDF9autAFtrO5beOIIi3yrsisWjgHewzZV3amrjI8N5C5CjPs19XAzD
         PqbYKCxwEU18/VqOGEthh2ko0BzKlz20RLgsOA8EZk0XWEuOvCejsWcRoFtH6/kO2dXN
         OlJ0knEBtkBGmPlvnOkW+O9r9/WSwm4Yw3jnPArG+oiMYY5MyfVf6mHLNkD8PasCdnzn
         xxQPl7QUYmkFORzv09LD+Yv9JgVIlTby27rEATm0LsuHsfDlMMTNnVxus5TPzAGvV3RR
         zQvg==
X-Forwarded-Encrypted: i=1; AJvYcCUMsmrx5ZB0IT9tH903ZNJkgjrzRk4C4X6tWKkIMs7njXyXy7LTcH/MZQlqPnuniQQyBo1dXkN7Q2mX4Ykl+m6dB88g3VWbS5MekFri
X-Gm-Message-State: AOJu0YzW+4ylETdlJRRIjC0SzMlrscBXrwLIH0nQC1v18YuhwasCtTP4
	R9py4Plrso7raBE1GoUWklCunWR0RgyCKcreEv9auwZKRg0fR5hMABx72f5re6Gt15FvRqCaxuK
	Th2/CvR7XEq4cXAuoEjYm67dFqqY=
X-Google-Smtp-Source: AGHT+IEm9B/mvpiEx8gGi1zFhrDKulngHY9tDJY0E+4OGsUujBGeO9/jRJU1a2bx5xoWs3aQ2Sb0vnEuUwfnp+zi7v0=
X-Received: by 2002:a17:902:d2c2:b0:1d8:b51c:6b79 with SMTP id
 n2-20020a170902d2c200b001d8b51c6b79mr191038plc.7.1708639033599; Thu, 22 Feb
 2024 13:57:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221214348.2299636-1-martin.blumenstingl@googlemail.com> <a4f8fa60-7c03-4946-a135-a405d53f361b@linaro.org>
In-Reply-To: <a4f8fa60-7c03-4946-a135-a405d53f361b@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 22 Feb 2024 22:57:02 +0100
Message-ID: <CAFBinCA3ho9fAb-iJhUEVw-=_Jbgd6UU8_9WEyvpt-+CL_V6ew@mail.gmail.com>
Subject: Re: [PATCH v1] clocksource/drivers/arm_global_timer: Simplify
 prescaler register access
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, patrice.chotard@foss.st.com, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Thu, Feb 22, 2024 at 11:02=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
[ ... ]
>
> >               /* prescaler within legal range? */
> > -             if (psv < 0 || psv > GT_CONTROL_PRESCALER_MAX)
> > +             if (psv < 0 || psv > FIELD_GET(GT_CONTROL_PRESCALER_MASK,=
 ~0))
>
>                 FIELD_MAX() ?
Oh, I was not aware of FIELD_MAX() - thank you!
While researching that I found that there's also FIELD_FIT() which I
think is perfect here. What do you think?


Best regards,
Martin

