Return-Path: <linux-kernel+bounces-78167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D3F860FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD5E287F79
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF6F664B4;
	Fri, 23 Feb 2024 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K20sDKCU"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C18E7E76C;
	Fri, 23 Feb 2024 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684868; cv=none; b=Ofx0zeZgFR61qI9ZzQO6GzH+fLGdni83jzG49NMCZU1Vd3aV6hqwdRPfRaMH02f3w2iI/3l1Fjcm38Jo/LrwsZ/xV5dd3eWR+hvxKF1S8+nQ4j0yq9ltWAAsca1CsT12/76T023+WpQDo9J1bzhgIeSdZFJvhTx1kLzL2MiDdXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684868; c=relaxed/simple;
	bh=bS1VlWWtfMYZsf4Vr4MMGRqT9FuitId+v7MsAAu5Wqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNITKTbBlL0hGf669WkAHUKnRayhdnv3863tamWfT301hYfW1zbphNURMpWODHIqKugR8u2SDyvXw3OlZ/aVThalES3DUEq1GDlOJwcv3N2+Y23pJ1Ti2FqPuOPVF+bhSCPUEQ7bTR3xakYbZpFQb789ChfLISuecys9z7qK5HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K20sDKCU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e46b5e7c43so72832b3a.2;
        Fri, 23 Feb 2024 02:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708684866; x=1709289666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS1VlWWtfMYZsf4Vr4MMGRqT9FuitId+v7MsAAu5Wqo=;
        b=K20sDKCUCM6MHLusjSvzCijr5rH7jEaufI4EWyO7ugYGEGdg9iea4nnIFtWVUlHROe
         NyiTbDAyLE3PnqtuQ48RtG77cwVQVXUHKe09nh5tBtsWY0m7f5U8VYOsCwwc11IYxgfW
         dAdeCwg8ySfhWF+1yfepQEyCi98bx8pnBX3G8k9rgQN0l8iOiV9blsZPpq4uwEK5wkvK
         x2D131Cg3XKD5MQTmxk7aVaICLROZFco5LmmFfDYZMJkxCc/YMiTwpiIT1126k0C4XOE
         2/y6sw37i56neYVzv5Wo73hFux50uwwLux9k19Qc78uHEkdUve1nT6GC3k4dsUp4schK
         RPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708684866; x=1709289666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bS1VlWWtfMYZsf4Vr4MMGRqT9FuitId+v7MsAAu5Wqo=;
        b=aKdasx/oEqgv+CdjpcyBMUu+6URH2zgliZlZ84hzAEZ94ON4uLpXkYGDTByEBFGKrs
         4I1jvJBUNiOl9P2gKTKuI8mMXlGbL3HcNVv8mGyW56Y83X9kZRzEmET3DcYno8iEhxTX
         dVHPdaHbFzLHM7Qmjdu2kpG72zQU3lVla0oAa30S+YrzYwDDx/XboPqHQLwG1vgj1/IK
         PpFAu4TzwGXsuRED1g66yLA6dy/AsvadOsDdUswJlkI1spci5faAgzVy2D4ZdvAsFeD2
         IKQBEMt14neLj6XXQrzPrO7X8w7Q8Tm1oPGMaHuckhGT7sWSRXHLaf9X55zjmSdCrxZU
         ilCA==
X-Forwarded-Encrypted: i=1; AJvYcCXm/XAY79cy1EM6tQUUYiy84WPnFOFjzekEvaRszz92I3pfhL4prmN/Tymlh+AeV/3C4W6tT0PppD3Fg2gOR1Gtg5qB2AvvUlbJiqposOlALqQGtD9UUF3yXA2alyVRaeVDvT/e
X-Gm-Message-State: AOJu0Yy58WDDa07U+fuvOTDLOZxBA7w1oGrsA4Q6aLWbD5uCvyrhs18F
	Pd2AdlV+JZFICkNKq7Vz1XIdr0xZJYxaa808Cudg+kM0Ek0nPGIgOl6jI5EW735q5tAI/2Qd9mz
	E+upMTp7lI/J04R41ddAubV2Tawo=
X-Google-Smtp-Source: AGHT+IGTNc9DAuoK5dbDsDxbrKxA8UrZIc5SuUO2JlymGhYz29b4KU/AshwgM7WkIh4GJLy3MTwifj08Jf/BARUheMY=
X-Received: by 2002:a05:6a20:a3a6:b0:19e:9143:2ab5 with SMTP id
 w38-20020a056a20a3a600b0019e91432ab5mr985913pzk.25.1708684865861; Fri, 23 Feb
 2024 02:41:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72=gYWZ24EEqRL71Vh+YjjK9Bu0QfxGEBzee16QAf4Q6XA@mail.gmail.com>
 <20240221214939.4715-1-kernel@valentinobst.de>
In-Reply-To: <20240221214939.4715-1-kernel@valentinobst.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 23 Feb 2024 11:40:53 +0100
Message-ID: <CANiq72mHk4E2fr+6w2zn0t=Fy+-CCqE6uTFou=2+3uLiTDr_gw@mail.gmail.com>
Subject: Re: [PATCH] x86/tools: fix line number reported for malformed lines
To: Valentin Obst <kernel@valentinobst.de>
Cc: a.hindborg@samsung.com, david@readahead.eu, gregkh@linuxfoundation.org, 
	hpa@zytor.com, john.m.baublitz@gmail.com, linux-kernel@vger.kernel.org, 
	mhiramat@kernel.org, mingo@kernel.org, mingo@redhat.com, ojeda@kernel.org, 
	peterz@infradead.org, sergio.collado@gmail.com, stable@vger.kernel.org, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:51=E2=80=AFPM Valentin Obst <kernel@valentinobst=
de> wrote:
>
> Thanks!
>
> Cross checked this as well, can confirm your assessment. Thanks for
> bringing this up.

My pleasure!

> Absolutely, without him reporting the test failure and narrowing down the
> config I'd have never looked at this file. Adding him for **both** is fai=
r.
> (This particular fix was not discussed on Zulip though, its just somethin=
g
> I noticed along the way.)

In that case, up to you -- whatever you consider fair for this particular p=
atch.

> Didn't add it because the discussion does not mention this particular
> issue, but it might indeed be good for some context.

Makes sense -- I saw the [1] reference and I thought it could be a
nice complement to it, but it is true that it may be not that useful,
so please feel free to leave it out.

> Will this need a v2, or are all of the 'Fixes', 'Reported-By',
> 'Debugged-By', 'Tested-By', 'Reviewed-By' and 'Link' tags something that
> maintainers may add when merging?

Typically, tags are picked up by maintainers when they apply the patch
(if it is the last version, otherwise you would already pick them up
in the next version you send).

However, in this case, since we have the Cc stable@ and you also have
the most context to decide on the tags (e.g. for the Reported-by
etc.), I would send a v2.

Thanks!

Cheers,
Miguel

