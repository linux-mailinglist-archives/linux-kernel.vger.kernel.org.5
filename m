Return-Path: <linux-kernel+bounces-82289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835C48681E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E962D28DF85
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C5E130E3D;
	Mon, 26 Feb 2024 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kXUH4LYt"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817412F588
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708979370; cv=none; b=gHox39/Zk43JKeyD9IfKVkaOJcltLHA0rgPfwcHA2bbuHpc70w4VzowLt4LGCoigEORXXbevg+rfg7v8yjW3d2YCUDDFYavIjWLF2jc0USA0lHbOg4oi3q1e+hpFJ9TWjwYC6FIJSzjdgIFX3KWgRF8xxNuCNnJ/FwTqnvGRelI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708979370; c=relaxed/simple;
	bh=QxHMa8tXHRVUnwvw9mD2wDd93p39Q3LXyym88+LBQsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjRcoJsuser3Fw9vKaLzdBW8BJg8D3dJw04tE8CVtsaaumsDkIZ8XIMA8yJCzahvt3WTBvyTcS0Hnr6gpryP3JeL3oxeQXU1VY10BbLhBNXoyKzyS9uvrXGbi0BQwvy0Y5CBQiqIf0PEyCha7wsg3+SCR/LGmYirF1x+L/Vn3dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kXUH4LYt; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512f54c81d2so2048499e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708979366; x=1709584166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNlbAlWQ1iLJPy/RP5LQxjXWzGeumRLZ8mhf6SEDR2k=;
        b=kXUH4LYt0O+PcJSbQibj7bUR7GS3p3pHNY+97jePEAWM6mstU1LXPsKaj0lU/+8N7C
         a666jEF++XwzafrndzIg3MCT+lqXplSbXR9Q5dOEtP2fyWl/TmEoEor3dDLM9Xb9UiFG
         a1kxSmGodbTYdmNgGzzjy8k4nVrkFm7FRnGew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708979366; x=1709584166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNlbAlWQ1iLJPy/RP5LQxjXWzGeumRLZ8mhf6SEDR2k=;
        b=kK1cC1C4lsG2TEz3Yz7vcCmdonmnn7E1b9efMynrmnHLLVHh/R0YSexPpa05uXBPgA
         woaYw7T/5K6BXX5KOst8KNNDJ5DINArqCSgxo0KB4CjPJcKFd3sA1altXW816j6v5dIr
         M+PUTKbyyDBRDtqYrILYSgqe2AUN0e/WAQNvN9yyDwqaZxxj5N+beZMdzvwDNvleCuFe
         m/tBjCoV5osv8zO4jb0sigS71YDJ/FcXz9GuEZnDlCkhjwzYrVNUpDZwMTKG0LaigYL+
         o3E1mBJ0NYEEJUui1gs3i3DKidC9okfMFs0YookbWXaFOMWgY4PNPM4jTFOL8uhV7kCJ
         A8Lw==
X-Forwarded-Encrypted: i=1; AJvYcCX1Qdnm2It3p+CCenH6+O/6xCoYw9zSNLKAjauRrO2o2EzGjKJkYtLhGC33L5B/7daUjKk5IAkVhg2Bq83jpk08TTxljRFPiHFxOD4Q
X-Gm-Message-State: AOJu0Yx1Km5FN/Bdx4jlH5uxQxhvdlg7JQVlrxL56rCN0z4cknM8iUeR
	UyzVI7iEsfjOf+EMcdI6qPzUuMRdhJNAt5QMcbhakXAqsjmFv3xOH4eNJpa1/YJardsaCbSjEEt
	B/U9Wi8jxqvcHahIs/jkuBo8VJIfyNMlGeTWA
X-Google-Smtp-Source: AGHT+IE4y/QI5ASnYlnv6FmbjUzGGENEjUwIiTvu+iC22zSP9/uqeaEIobfef09+sc2WB6Z9VlPhm8xH62y6EUnNoXI=
X-Received: by 2002:ac2:5d4f:0:b0:512:a4ce:abaa with SMTP id
 w15-20020ac25d4f000000b00512a4ceabaamr4861210lfd.48.1708979366487; Mon, 26
 Feb 2024 12:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221210626.155534-1-adrian.ratiu@collabora.com>
 <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
 <202402261110.B8129C002@keescook> <202402261123.B2A1D0DE@keescook>
In-Reply-To: <202402261123.B2A1D0DE@keescook>
From: Mike Frysinger <vapier@chromium.org>
Date: Mon, 26 Feb 2024 15:28:49 -0500
Message-ID: <CAAbOSckyxGka1vWTpuYwA8eH=17sJbGMUOuCwHs2gE_FPnXG3A@mail.gmail.com>
Subject: Re: [PATCH] proc: allow restricting /proc/pid/mem writes
To: Kees Cook <keescook@chromium.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, jannh@google.com, 
	Doug Anderson <dianders@chromium.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com, Guenter Roeck <groeck@chromium.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(lemme try this again as plain text)

On Mon, Feb 26, 2024 at 2:24=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Mon, Feb 26, 2024 at 09:10:54AM -0800, Doug Anderson wrote:
> > On Wed, Feb 21, 2024 at 1:06=E2=80=AFPM Adrian Ratiu <adrian.ratiu@coll=
abora.com> wrote:
> > +     if (ptracer_capable(current, mm->user_ns) &&
>
> It really looks like you're trying to do a form of ptrace_may_access(),
> but _without_ the introspection exception?

to be clear, we want the check to be "ptracer is attached, and the
process attempting the write is the ptracer", not "does the writer
pass ptrace access checks".  the latter opens up more angles,
including shellcode self-modification, that we don't want.  the only
use case we have for writable mem files is for debuggers, and those
should already be attached.
-mike

