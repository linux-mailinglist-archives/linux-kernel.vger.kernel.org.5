Return-Path: <linux-kernel+bounces-108138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A990880687
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3E11C21EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79913D0B8;
	Tue, 19 Mar 2024 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S2XV8n7x"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560353C47C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882477; cv=none; b=NQFrf1lwAduPoKDFOVOWxnZSlk8gfxom1LL37rXf+w1WquPzkp+jwqK0AU8pOX7L9b++a6++hHUsVsQamxPC0iCRTBy+lcQ3WhJUML+VNVKbqltys+UpDmUUlqXNev1QyYyaJvQkYVLGKaUOVvproYR0Qvd1+itU9RjycBEiYm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882477; c=relaxed/simple;
	bh=FFxWdNsrCs+Ws3tNdAflAKfMvAZZKT7Q+ZcIn5QT9hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJO6ZfOvG0QkaUtac6WjpaiThzGD5Ne0EJkpzNpzrQYAJwOhYtHQF62Nk+Bp80qPFHc5kAJA3X5Gpn4X3QpVRzWnUqWLT7YgzPTy5lIXn8XJtbnq7dhZKhpsdTxEai9FCyySWLBIpc+P5QyHOJU8P/qUZHIijS0v/d1W3V/XHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S2XV8n7x; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so441185a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710882473; x=1711487273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJm66ymQj4qZljhVLm+D5W3oaVWUS1R2lKPopMwVbNw=;
        b=S2XV8n7xOCoKA1ZsGeTKJxm4LVxd17jzvzbsILfKbvLSiFxb8YvXIW8k/pruthvZhU
         b6F1ibvmfDEpJQXDRDu6KcGpgt72XP64HEEa0u9ZaTIqubx4YOfgimKtzsZ0/7SoQtec
         5plzljmu+EDUfBr4XtT+eyy8ZE7sVzP2O6iuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710882473; x=1711487273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJm66ymQj4qZljhVLm+D5W3oaVWUS1R2lKPopMwVbNw=;
        b=uaGKc2burCADR2YdEFkIlV7WLvPPE+KrbQGg7CxuFeHspPeRUU8+Qtzsp/4iISLNUM
         J1DUK4BCVSftMQns56B/DXYMLnVrFg2gCaJ1XEBHZrMS097MrujjOlqZx0O1tkuqZjcp
         aCAlyWWMLTvYkhyP5+XPRTCSG08MiX66TysfefylITfvwiWoK+eDAncYb0vkThW2q8pq
         Dtl3p61v1rg4OA61FL3xWDlrwG1OIG4Hos20PBuNKw5UxZbys4qhA7FvD25P1fuZSAhb
         l/u8gup1YFUr/tDHwKEFnHwZ5k0EsS5nFcuJoHE8P9q4hRZahfOj1TWIXFY0d4WVSO3o
         fK1A==
X-Forwarded-Encrypted: i=1; AJvYcCU8fnUI71giADcNmgQ0/l6Kr5+GOmMWBwUA9hT1H+Nj6lKLWjIk+x5ngMysGhcWjhWVuGYtuIfeAazMIiwEgfQQMgky/FH5VFhDadoQ
X-Gm-Message-State: AOJu0Yz39msyyVW8xvcSe62AmVjSM0YkF4rP1LqLUL2rxb95Oj7ICmFp
	bSjrnGubBLQlst7qbWsPQyzfKlXUCbBxrrsIhT/uvK4kRDQN7h+15JIA82PmK/gkeZQHitPLQsO
	wSPE4
X-Google-Smtp-Source: AGHT+IFZywubxRU2D1nav+U3ZPUWtgE9JV67CssCp/nnlmZkj/3tHGFfk6a8i2vGMTZyamxX6cqCgw==
X-Received: by 2002:a17:907:7d9e:b0:a46:85ea:7e9e with SMTP id oz30-20020a1709077d9e00b00a4685ea7e9emr735224ejc.1.1710882473484;
        Tue, 19 Mar 2024 14:07:53 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id af3-20020a170906998300b00a469604c464sm4990996ejc.160.2024.03.19.14.07.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 14:07:53 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41428b378b9so8795e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:07:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVINjdgc3TMNwUYK99xL9X3g2EJ2JN82ZZM6ZXSvfimjrVl+M3VRujBTeIoOuUpOSdR/qk+1Neyiv/ygp1ZhyBRx9fKOe8crIEPBzyx
X-Received: by 2002:a7b:cbd0:0:b0:414:da8:76dc with SMTP id
 n16-20020a7bcbd0000000b004140da876dcmr63824wmi.6.1710882032388; Tue, 19 Mar
 2024 14:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319111432.1.I521dad0693cc24fe4dd14cba0c7048d94f5b6b41@changeid>
 <CAA8EJpq-NjmYkWHAVsuP5jA_Z7Xx0jCiqEDgU-0ni9BCg7Opuw@mail.gmail.com>
 <2fa9a262-de60-2c1e-9ac3-1e478ec65bb8@quicinc.com> <CAA8EJpqg+Di7PH2bmQ6uMidD3MhQ+N7w-1MWWEOBrH5DbsWSTA@mail.gmail.com>
 <977f647a-fc30-d9c9-f973-fd8bd9a4020a@quicinc.com> <CAA8EJpoAwRKbHxVhi0q9koSUWFPcD4sP=F36r+rYsrtbY0fLkQ@mail.gmail.com>
In-Reply-To: <CAA8EJpoAwRKbHxVhi0q9koSUWFPcD4sP=F36r+rYsrtbY0fLkQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 14:00:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W0k5U0i+Q_X_3HAviY-LXNrAw=PFjWDg+eej-Kq=0Y3w@mail.gmail.com>
Message-ID: <CAD=FV=W0k5U0i+Q_X_3HAviY-LXNrAw=PFjWDg+eej-Kq=0Y3w@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: Clarify that wait_hpd_asserted() is not optional
 for panels
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, dri-devel@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Imre Deak <imre.deak@intel.com>, 
	Jani Nikula <jani.nikula@intel.com>, Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 1:55=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> > >>>> -        * panel to finish powering on. This is an optional functi=
on.
> > >>>> +        * panel to finish powering on. It is optional for DP AUX =
controllers
> > >>>> +        * to implement this function but required for DP AUX endp=
oints (panel
> > >>>> +        * drivers) to call it after powering up but before doing =
AUX transfers.
> > >>>> +        * If a DP AUX controller does not implement this function=
 then it
> > >>>> +        * may still support eDP panels that use the AUX controlle=
r's built-in
> > >>>> +        * HPD signal by implementing a long wait for HPD in the t=
ransfer()
> > >>>> +        * callback, though this is deprecated.
> > >>>
> > >>> It doesn't cover a valid case when the panel driver handles HPD sig=
nal
> > >>> on its own.
> > >>>
> > >>
> > >> This doc is only for wait_for_hpd_asserted(). If panel driver handle=
s
> > >> HPD signal on its own, this will not be called. Do we need a doc for=
 that?
> > >
> > > This comment declares that this callback must be called by the panel
> > > driver: '...but required for DP AUX endpoints [...] to call it after
> > > powering up but before doing AUX transfers.'
> > >
> > > If we were to follow documentation changes from this patch, we'd have
> > > to patch panel-edp to always call wait_for_hpd_asserted, even if HPD
> > > GPIO is used. However this is not correct from my POV.
> > >
> >
> > hmmm I dont mind explicitly saying "unless the panel can independently
> > check the HPD state" but not required in my opinion because if panel wa=
s
> > capable of checking the HPD gpio (its self-capable) why would it even
> > call wait_for_hpd_asserted?
>
> I'm fine with the proposed change. Doug?
>
> >
> > I will let you and Doug discuss this but fwiw, I am fine without this
> > additional clarification. So the R-b stands with or without this
> > additional clause.

Adjusted wording in v2. Kept Abhniav's R-b. PTAL.

https://lore.kernel.org/r/20240319135836.v2.1.I521dad0693cc24fe4dd14cba0c70=
48d94f5b6b41@changeid

