Return-Path: <linux-kernel+bounces-146709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF06B8A69A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE5E1F21673
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A744D1292D7;
	Tue, 16 Apr 2024 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WL2ijIa7"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692B212838F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267194; cv=none; b=ffVt/SkLcveg18VSnmg8iIlIlDnW3rP66YvCM01sQcPVzauXU1e9MStCmL8HBaJfyceLsj+Lu+xVnpo2r+gYw7M5J9AG8ltu/CyZTFDg5pimLLNBHx6arc+3t2fsMChugJwN9OusWFMWFLd/lz6aA2FB7gNyx8DPve/Fm63jVjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267194; c=relaxed/simple;
	bh=/J/j05/+16uopVTGFKC52nqDPULfg6d/l94dzwLNwzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qwdlgc0jQhOKGdcenljiGkRs1RQuzxua/azD2XP7M+H7fRcNmF8pHsGZ662efH3anaaqbJDTlOe057lp3Ss0SWNgx+o+e4PUCeyifR4s03MEAYPRSO9uHbGcawl7pzToe0+3BK8bFL69G9xXruIbQbRhVN2W52Lt8CNCU7J3tfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WL2ijIa7; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a52223e004dso481690766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713267190; x=1713871990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwJdmAUAGjo5XlKYImrypGenO5EDNxyflFLlUfqTWMk=;
        b=WL2ijIa7aQq2J07tAjiYkksPVOhjozdaJGuc7o5EmPEvGXPo+oONl5LfKZKSlQlxBu
         FpIWRZXVv+Smsa3YvG/LfqxyeRNyP+QqAKmB5ozA4odOQQxdMB9cwGz4g0U7yl42KE3v
         wUuiTHbWoBF4j5a0DLb/VTho+qtf8lm0+TTP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267190; x=1713871990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwJdmAUAGjo5XlKYImrypGenO5EDNxyflFLlUfqTWMk=;
        b=bshC1r/iKk2mZ/QIugCjOHCpa8340PJ30kLqnViFfiODE4xTP+VBVRjbUSSsJH9OSZ
         D2ZY7fSnhXPfZNoI4E33TokjiDmLDq6kIItIk2LX7IOblz37PJfHNqeQNFno4OnlrkuX
         Abpwhilor56kGhUquKYwdHzMVVFnNOulVAh2iFKKrWl7DDmQbHn06O1JnHOpvJZTFKzF
         gEgNeZg+UHnz014ChShIiFJ5ChfbzVE8ZaHg5QrLe7LcRezdZSi6PTodCZ1/sSjf7K/t
         KOAvAXxbgdokBzDwVhrZpmW4vui+u+ixXOmyjbiNg5K56StrguT1DyifpXEx9eiQtXwJ
         0I8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+RuAhcTyRK4MCN5XBah7krBKS81jKsn32b9YApgtFl3eCap1NObTc15hEBIalAwC1nYGqij9u/yNFq83s5DZmZkyUHMCgEF5gDmmg
X-Gm-Message-State: AOJu0YyYUg9LmEfKMvJEX00yc1u4vBOcbk7A9cQHnDjUJHF1RPH8oS06
	pURFDp5t/ujeYQJy/ZIszUNLeGEMzCq1ev6KjP+2CYkC6qzYTnI21Qhj8gEaQ1rLG7ViWa+adLk
	e6WrC
X-Google-Smtp-Source: AGHT+IHHdIrFdS6HbutL+7pt+0uCWMrVjLH9MIRNTZZu8/xxHB8Mdda2T8y85uNXOyiu61/G2joY/Q==
X-Received: by 2002:a17:906:6b8f:b0:a52:5493:a0b9 with SMTP id l15-20020a1709066b8f00b00a525493a0b9mr5868150ejr.39.1713267190675;
        Tue, 16 Apr 2024 04:33:10 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id y24-20020a1709063a9800b00a5268203c85sm2860129ejd.107.2024.04.16.04.33.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 04:33:10 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3455ff1339dso2931994f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:33:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWl2BluwVpHmekQzYpdLk1/FpzX29VTrdhze57DlHswktKDERdYsJdmjHHSDgEJbRO0zzDsOp8FlPY99a8+q8l604Npf+zeGYXOiKfA
X-Received: by 2002:adf:e80b:0:b0:341:c210:3d1b with SMTP id
 o11-20020adfe80b000000b00341c2103d1bmr10320976wrm.8.1713267189995; Tue, 16
 Apr 2024 04:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-minimax-v1-1-5feb20d66a79@chromium.org> <fbf22b53-7b68-4e60-99c7-ab38a77a53c8@web.de>
In-Reply-To: <fbf22b53-7b68-4e60-99c7-ab38a77a53c8@web.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 16 Apr 2024 13:32:52 +0200
X-Gmail-Original-Message-ID: <CANiDSCuvXvjfhw2mjSef1wR8RiL=9KrDEoh+3o1ed4+8P+AqGw@mail.gmail.com>
Message-ID: <CANiDSCuvXvjfhw2mjSef1wR8RiL=9KrDEoh+3o1ed4+8P+AqGw@mail.gmail.com>
Subject: Re: [PATCH] coccinelle: misc: minmax: Suppress reports for err returns
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr, 
	LKML <linux-kernel@vger.kernel.org>, Denis Efremov <efremov@linux.com>, 
	Nicolas Palix <nicolas.palix@imag.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus

On Tue, 16 Apr 2024 at 13:30, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> =E2=80=A6
> > +++ b/scripts/coccinelle/misc/minmax.cocci
> > @@ -50,11 +50,26 @@ func(...)
> >       ...>
> >  }
> >
> > +// Ignore errcode returns.
> > +@errcode@
> =E2=80=A6
>
> I see that you would like to omit the specification =E2=80=9Cdepends on p=
atch=E2=80=9D
> from the previous SmPL rule location.
>
> Would you really like to influence and adjust SmPL code any more
> according to affected coccicheck operation modes?

I probably do not know what I am doing :), it is my first .cocci patch.

If I leave the "depends on patch", then the change is ignored in report mod=
e.

I think errcode needs to be executed in report and in patch mode, but
there might be a better way to do it.

>
> Regards,
> Markus



--=20
Ricardo Ribalda

