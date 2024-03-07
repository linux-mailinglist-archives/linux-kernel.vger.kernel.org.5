Return-Path: <linux-kernel+bounces-95496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2382874E57
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B4D1F28726
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCBE129A61;
	Thu,  7 Mar 2024 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zqfyEYOK"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB451128832
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812481; cv=none; b=rzKxrbgdpb0DNd7FeZEadOKP+KPfUKRiBKqIsZnAoyVQ2V10gRAdvc5H2GskGCNhnLlFmSx7vURXp2FGb7aezO+sooqkDMfclozGNW9lsi3NaGybF2z1wvA/UEhPceWn8UFHFHd7DwTJWrGbF7RLyTUEg+J1gATlAj2jKxwo7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812481; c=relaxed/simple;
	bh=ntb9pr3kAdeyVxVTn/2n9hEfKbxC9XiXm5jiTaXzOp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRu9xpT3hW597oa7nWIo0CxTmGVEs1CGiFHngleJAczSWSbIMi8fluPG89RZ8j93YoFzfWY+505XSuuiG0jGrsZkYaYTOMF97oJvBThRTBNwNPa6tQWa8YhBdF8uwiqX+TGjVOSS1KzmzN/QMBJfq8sl/ZATiVC4GdCcw+BmBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zqfyEYOK; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso544547276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 03:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709812478; x=1710417278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ntb9pr3kAdeyVxVTn/2n9hEfKbxC9XiXm5jiTaXzOp4=;
        b=zqfyEYOKeSXBJ06rHBcVzjuPqSBee+aFh48I3lAPJos9zMgiwQu2odVYScyPK9K7Ug
         oDjK1dpG9aYJPxyoK6mAvC9plUW/CpzeKF7vEAPz83jdxEYQrhiq6TXWefqSQp1BEpuZ
         VBfvpuhnzsvne6ECrU1muNWVUauZ+07XJy5ahoH4lQ/vIoMTnFNRHbzRnylFm4eDCeFX
         2g5lrGOgWcmTIlvj8ClpZCreE+CNMo9DPjfzZOnIXHOyvjFz4+xiUKBev9CEcf4jwB01
         KLmckehK3ehP42eYKICJY/6vLNVeFFzcBcC92nZHMQfhKvbaGmgbVUgdlVQAPSL4i7i/
         hZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709812478; x=1710417278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntb9pr3kAdeyVxVTn/2n9hEfKbxC9XiXm5jiTaXzOp4=;
        b=c2pyh8pRp8KnpErk7ubR1Udc+azN26DcVNkGp0UMsJP3RIyh6hB0xtl0cBGDHBrDzL
         ErvC+JFhE9vqwP3hh/IVTjNTB6fKrFJlsnw2Q0TS17Ofi0YrhMJm0PIvNieaq12lWfyc
         eHfww08eADevaZyV7lt6cDG/0LwiG/K7lbiR7wixm7bQJUqTI1U//NNvZpYB8mQNNI75
         y70l7qrtXdEuhP8MrFns6oRgyvCZM+c3nTKZ9IW+CGjBC0yQCMUKbcj7KywMYmgtHqHA
         6jsSh2YLWDgu3SW7lYjI9wwq5XD6heCoE19zgb+G3QYFNIWjm6mba4e38VFUgS+czM1L
         8ejQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAIZqUMUZKLU2I+xRib8Yivd2UDkalx5CBxnL1qq///QqvKHpgR5ub8tN6V1E2l+IsJ+/b+QaECR9xSlnBcViTAAo7y18E18a5NmAb
X-Gm-Message-State: AOJu0Yy7tqkop9T13XzbpfYcadv4Oi9zw7iI7ZvcpBJ7NsRSmQMH9Xqy
	LBzNbKzqfP9pgwYxMnoUM5UBXrKUoA3YG8L73A6WwehIV26UaUt2LmMXpdWlR+x73GzClV7VTO5
	TE0sOt8W4/6X/IQFgrEMQbvf8ijDhbnMHWvbXUw==
X-Google-Smtp-Source: AGHT+IGYRfIyrPVfRdiPn/7hN+8lk7iJ0VjKPXb6Cl/qAfJ6FSbxZTHRMMwOYFrwMklsbyJRIXeAXCLneYs3qrSEF7I=
X-Received: by 2002:a25:690a:0:b0:dd0:aa2c:4da5 with SMTP id
 e10-20020a25690a000000b00dd0aa2c4da5mr7066826ybc.6.1709812478620; Thu, 07 Mar
 2024 03:54:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <875xyqg2yr.ffs@tglx> <79fadb9b-c4c8-4727-b812-7e519556cce1@linaro.org>
 <CAPDyKFoynM_gN=tzsWnE_xAgmy6R8Hie-_yO5zoJTjwNjR38Hg@mail.gmail.com> <87jzn5eqej.ffs@tglx>
In-Reply-To: <87jzn5eqej.ffs@tglx>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 7 Mar 2024 12:54:02 +0100
Message-ID: <CAPDyKFpnh8nUNXtWUueisExtfabawhsjtEGTnH7RxKeD7=03dQ@mail.gmail.com>
Subject: Re: [RFD] Remove irq_timings
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 15:46, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, Feb 15 2024 at 12:23, Ulf Hansson wrote:
> > On Wed, 14 Feb 2024 at 22:39, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >> On 14/02/2024 22:17, Thomas Gleixner wrote:
> >> > Daniel!
> >> >
> >> > It's 7 years now that we merged irq timings into the kernel, but we
> >> > still have zero users for this.
> >
> > Wow, is it really 7 years since then. :-)
> >
> >> >
> >> > I'm tempted to declare this experiment failed and remove the whole thing
> >> > for good.
> >> >
> >> > Comments?
> >>
> >> I worked on an irq cpuidle governor which had better results than the
> >> menu governor and equal than the teo governor. But I never succeed to
> >> have better results without putting some arbitrary when computing the
> >> next event.
> >>
> >> At one moment, Daniel Bristot de Oliveira (Cc'ed) was thinking to may be
> >> use it for the deadline scheduler.
> >>
> >> Ulf (Cc'ed) may be has a plan for the next event for the CPU cluster.
> >
> > Yes, I still have that plan, but haven't been able to run some real tests yet.
> >
> >>
> >> But if no one has plan to use it, there is no good reason to keep it and
> >> I'm fine if we remove it.
> >
> > Besides that the code isn't really used at the moment, is it also
> > blocking us from doing some cleanup/refactoring or other related code?
>
> No. I just stumbled over it (again) and wondered whether it is ever
> going to be used or not. If not there is no point to carry dead weight
> around, but there is no hurry.

Maybe a small chat about it at the next LPC? Then we can see if I have
been able to play more with it.

Kind regards
Uffe

