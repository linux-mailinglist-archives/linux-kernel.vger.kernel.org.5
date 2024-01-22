Return-Path: <linux-kernel+bounces-32312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE358359EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276C4282423
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991E61FB3;
	Mon, 22 Jan 2024 03:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U43mwVvr"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA781C2D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705895937; cv=none; b=kcJu90vCRfNKok435w+wjzX9W8H5ds5B3ug9j1QehtNnRKeOnS3jHUHR6ar8Foz6PJzS/bHyn8prUy0+WxWAFOMG0oXYKEbVq9rYlIiMMEICpWXi6PSrx0KOc2dBkzJQoRfE3SWBVazXM+zgQu972CpD1GujvwRSVY+ZezKLZdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705895937; c=relaxed/simple;
	bh=tLXsqPP7DZTbGqeWxVioSmb1fX8OXB2SzYiah5WXtgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyFux5opaJ6dRhM/mbzh7Qcjxm+/DTf68of02U6OeN+bUFMPVdsXMdjIvkXEbVnDNot97ezPFcVnkLY3UrCCV5AwWyt3JYDQfN7ywZafocn5sDtbvtEPdxBn7l1Kp2P+6tb9Hoceu15dYUyfD13CnMl+fN3Kp0uWj0nvwGId/4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U43mwVvr; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cef994d4e6so7129201fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 19:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705895934; x=1706500734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nTrFT7rRpBWds3+I6H31jRLE1XMXyJqWuOdYqlemoc=;
        b=U43mwVvrnNbyhUXtAeFnKL8CnOHfPT4mOtsBL4PbJhOv5gVNr8hQOULZZpwRFaQi0X
         oUkyQR01OK4NMz+gJ4S7WZD30Y7vE7cx5n62V5mc1Z8Q83fk2fmSK0ugF71kEpkXyiDW
         b/lSsdGTvsFZStYe9EaJiqPohvfEODx3S3vG/djyGFN5eEhaNcmvYdz2m68GWOP6VKQ5
         /3X2mu6b8S5KS4p/jWJ4M89KdSXK1Yg+VZq12kPUmcj2FM/He9xTygAg8y4DTKcb0jbZ
         dVKZ5bPg04CF7J5+8+39lxt3j6g0/9qhaK2cS31eTCbhhBbCuIw+1svjeew3DUpvuqF1
         cuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705895934; x=1706500734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nTrFT7rRpBWds3+I6H31jRLE1XMXyJqWuOdYqlemoc=;
        b=kTPEYU3/ktX5WLoHJWAzED1BnrWvRIT0RCezFNildwaa6WjCqxeEOTg49SIfcShDn5
         +aTS6Vo3rR5RoJYWMFTJ9DGFj3iFq9PLGKRB5HNmkuYcpKh87ZH/EiMa+tyMB1w+UR0f
         5bH2E+L85hJCtJcL02m/u9cbOl/e5RWLMYUqtCLY8atKuLARBTEiZ5Ti9BxYysZ037ij
         dKypm1mSzDeK32I+ajCyu8HMoIkFR8DBAmOMWoYgMLYdWdRcC5lIATQQZ5KpMHPupIeJ
         w0ocAokGyCRcKH789kpkUnK/LwskOeLItYJV8gX3yD9jAp71ovRJJyAVGiq3nR5gdnJR
         OYMw==
X-Gm-Message-State: AOJu0YzYhBWYUVxHO70ONI+u1Ig8eYlQjO94hCgiUcJgIua/Nu5+lIlw
	t2/6Dlub5gwJMi2/Xfnl/QQduplVvw5A+FdFS6MfWy/R+HGlFuwRY5egfYoTwsv6Vw9nCHiw+EG
	iTQNGNCSq3MqnAVHKbgs6duY/H6Y=
X-Google-Smtp-Source: AGHT+IEE2b90Y6392Ag2hM7Vsg78r+ea3Vn7jT132azgHsbhwikxozW66belbEyks/1gcyZRatZRM5OWzKmTvlOVi7c=
X-Received: by 2002:a2e:3519:0:b0:2cc:31e9:745e with SMTP id
 z25-20020a2e3519000000b002cc31e9745emr1165912ljz.60.1705895934035; Sun, 21
 Jan 2024 19:58:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116234901.3238852-1-avagin@google.com> <30cd0be4-705f-4d63-bdad-fc57301e7eda@intel.com>
 <CANaxB-xu+zG=5_EAe4zapC5a_x4CkkDovmVX7LjiLk+E7kU75g@mail.gmail.com>
 <b3e5456a-7113-4868-b8ce-020421e898ba@intel.com> <CANaxB-zQYC8=7frWGU2pRTDJrkVu0iR8QZCmUxSzGmBG-_b1cg@mail.gmail.com>
 <54bcb902-0fab-4a53-8b8e-85b6e4484b03@intel.com> <87cytyfmd8.ffs@tglx>
 <5bddbb34-4081-494b-8c12-c2e70898a608@intel.com> <877ck6fg0z.ffs@tglx>
In-Reply-To: <877ck6fg0z.ffs@tglx>
From: Andrei Vagin <avagin@gmail.com>
Date: Sun, 21 Jan 2024 19:58:42 -0800
Message-ID: <CANaxB-zaa0nMFmep9jtJh_QDdAj=2K9G5PAKF4iTuNbNnYj4bg@mail.gmail.com>
Subject: Re: [PATCH] x86/fpu: verify xstate buffer size according with
 requested features
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>, Andrei Vagin <avagin@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 2:11=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Jan 18 2024 at 14:02, Dave Hansen wrote:
> > On 1/18/24 11:54, Thomas Gleixner wrote:
> >> On Thu, Jan 18 2024 at 10:27, Dave Hansen wrote:
> >>> If we have nice, reliable fault handling and then decide that we've g=
ot
> >>> XRSTOR's running amok reading random memory all over the place that n=
eed
> >>> a nicer error message, then we can add that code to predict the futur=
e.
> >>> If our "predict the future" code goes wrong, then we lose an error
> >>> message -- not a big deal.
> >> After staring more at it, it's arguable to pass fpstate->user_size to
> >> fault_in_readable() and ignore fx_sw->xstate_size completely.
> >>
> >> That's a guaranteed to be reliable size which prevents endless loops
> >> because arguably that's the maximum size which can be touched by XRSTO=
R,
> >> no?

fpstate->user_size isn't constant.  It can be modified from the XFD #NM
handler. For example, it happens when a process invokes one of amx
instructions for the first time. It means we have to be able to restore
an fpu state from signal frames generated with a smaller
fpstate->user_size. Can it trigger any issues?

> >
> > I like it.  It takes fx_sw completely out of the picture, which was the
> > root of the problem in the first place.
>
> Correct.
>
> I really don't care about the esoteric case where this might
> theoretically result in a unjustified application abort.
>
> You really need to twist your brain around 6 corners and then squint
> twice to construct that case. Of course syzcaller might trigger it, but
> fuzzing the sigreturn frame is a #GP, #PF and whatever lottery anyway.

In my case, the bug was triggered by gVisor (it is like the user-mode
Linux).

Thanks,
Andrei

