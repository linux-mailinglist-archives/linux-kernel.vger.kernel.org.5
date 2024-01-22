Return-Path: <linux-kernel+bounces-32542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78942835CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB93D1C211B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09F6364D9;
	Mon, 22 Jan 2024 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4y47o3B"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE7039852;
	Mon, 22 Jan 2024 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912987; cv=none; b=dhsGctakk7EMYs0OBWvCrQEZ/Dr9sMibDaIHA6rC/HNkO5kaMgYaqJCAZH29uxVFQwhVQ2yKDNwr/i5uT857I5t9COEYRViMbDqdq6WS+FNjC6lMPD8QJM//ssatpVT0JURqZZOYJwNZRaJRSllB5jMtUIfLCuXf/H5gLTXBfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912987; c=relaxed/simple;
	bh=lvVrC+f35N01r8aPfRDm4pbZkjSq9nuQifRbMlHzeSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xpdeh0346ibCj4lsmelTyeygK1BwsztOrZAsLHOlWRKKezfXKvBqwI6MwL9n1tXP1865copLWQOK8cGvNqvtGeo5UeW9xthVDvv22s4mOCDSTv56yZsGKcMybhqoz/pj8fLwxC4mAN661iA6QpzA9hLMX9FirMJWLBW82aMXlAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4y47o3B; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2108c7829caso895305fac.3;
        Mon, 22 Jan 2024 00:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705912985; x=1706517785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvVrC+f35N01r8aPfRDm4pbZkjSq9nuQifRbMlHzeSQ=;
        b=C4y47o3BKg/qT3YbiTSfurLWyx1GYVgfWTeC8WCN6pac9s3DfPBWBE4Ykrh0p4NecR
         5esUthIIl9Pu2zbkYfscyQLvgTDsc153bqqaqopnyZU0KYvxbo0Vboir1ajymnAyE0xl
         AFoyYZQ7Ou1LDuEt/B/6CIp2JA1LF1HGKC4ETuDWEnaIBUiw1pxQ989I62Ft32pd+zqV
         us5Y6ElCW+zNQzgd8GNS19PiDIczNLIsvBEw2sEaTqgmM8b+z5x/TaZPQz6bXx+56XXk
         ojrRrI2nTzpQQMl1NzL2/umfQfXaxAr/hBNDbf2fS6SoJ1yQlg1b7nBXVl6u+yCjnDFk
         bPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705912985; x=1706517785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvVrC+f35N01r8aPfRDm4pbZkjSq9nuQifRbMlHzeSQ=;
        b=pB6LVK6ydYnPwPOLUlkmyy0hgEfHTq4erkM5/MKMEryWNhnN4NqwhWjN3WjVwV7CL2
         w/mAbTCJIYNOjhbfdGYsttocyKPbrqUurF6FXOBcIa1rOk/0yHOrjRcqoRheBEAfCQZF
         dCp0g50kKwZt1WVDZSmC0KqJr2abhV7+7IBB/uZdisdmHHOm1xgGnls0JBzkcncy0bfs
         8NyPFOscYSmPMzNAddXzBXxVuEh0ILmW1TY0jHAOYbSCFebQt2oNeFl1nVa6/ZkQy8rY
         nEp88kdmvFcNulubAgBEVJa203wnZGtFnVupjs1fHH1FbqghXvq0/L2+ScEfcefh1hkt
         drkw==
X-Gm-Message-State: AOJu0YyG/udR286KUgVdjsVxIL0W5BhGNpjdvxgnTL5J9GO0ZbuWbjQj
	MfVmqnZStw4xilK01v0OIs2GL8tB9Ki8kofA8uKs24xa9Fa+3NDeo3NKACBVFUs30cBqtMCGxPJ
	HoQMnyq3f+IbgRZr6XCNVQ0YxNP0=
X-Google-Smtp-Source: AGHT+IGO5jrrZtbYOiVQIVGyuNjgvRWaxekfSQGoJMFUsTLosSs7KRyYuQS/Sq24qmG5IJnhKHCJRFaIq5fdWNYON4o=
X-Received: by 2002:a05:6870:b30e:b0:210:b602:5b75 with SMTP id
 a14-20020a056870b30e00b00210b6025b75mr2072119oao.42.1705912984419; Mon, 22
 Jan 2024 00:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122080631.2880-1-qiujingbao.dlmu@gmail.com>
 <20240122081722868bdda5@mail.local> <CAJRtX8QU8iHY1oQJ1uDN3YOmCeN7SH+vPC8nD29WS5+2DT1oKQ@mail.gmail.com>
 <fcd64bbb-9f3c-4e62-96a4-84cb1e3ac59d@linaro.org>
In-Reply-To: <fcd64bbb-9f3c-4e62-96a4-84cb1e3ac59d@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Mon, 22 Jan 2024 16:42:53 +0800
Message-ID: <CAJRtX8R9bZZyU_6XZ+G_rctRu3TTEAUamVbq1h8q+Fzzd6SZiw@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 4:37=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/01/2024 09:34, Jingbao Qiu wrote:
> > On Mon, Jan 22, 2024 at 4:17=E2=80=AFPM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> >>
> >> On 22/01/2024 16:06:30+0800, Jingbao Qiu wrote:
> >>> Implement the RTC driver for CV1800, which able to provide time alarm
> >>> and calibrate functionality.
> >>>
> >>> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> >>> ---
> >>>
> >>> Depends on https://lore.kernel.org/all/IA1PR20MB4953C774D41EDF1EADB6E=
C18BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com/
> >>
> >> What is the dependency?
> >>
> >
> > Thank you, this driver requires support from the CLK driver.
>
> How? This is really unusual. Just to remind: we talk about build
> dependencies. Other do not matter for new drivers, right? Otherwise what
> is being broken and how it could be even broken?
>
yes, you're right. This is wrong, I will drop it.

Best regards,
Jingbao Qiu

