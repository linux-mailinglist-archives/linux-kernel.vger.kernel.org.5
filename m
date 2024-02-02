Return-Path: <linux-kernel+bounces-50281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A978B8476DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF481C265C0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F0214C596;
	Fri,  2 Feb 2024 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYPLBzsL"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA3114A4DD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896786; cv=none; b=FSVQP8Yh3UiDDwpf56JGR9N8/+1uICjlAzZlJywr1361W7iOeS6r6TFvmjNbOuHcvq2Ok/rKq00MYMRU85nfYnL2Q7Y3IO3vpSnDo4itODtD5D1pTKFWKaVNdchDZKBEG/NylnCu9EkLnD/+ZfsbOhC/pVNCSzr8Yt6nmHlwhNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896786; c=relaxed/simple;
	bh=PbsGV+LRfbFclR41vL+iMrFaR+sc6SmvwNXGlLB70Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACZblruj1zW3HUrwiXdRvRq8ztcO72Hpt9Xko+yEMw8hqtSJMeQTqWoLnPeCvTFUjv5FSuVD2AzItq1U8yxbpSKWQhal/z5wEr7J0RcZOwVEdbQPpNtBdm8CsKzmb1UZfTriO6Zo2+wF4buKhisa/Rn4QvfGMJ7nGizm23UvPjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YYPLBzsL; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68c3ac1fdb9so10702526d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706896782; x=1707501582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEmXtPEVMO3oHchObaEeNLlugLVri5Npjz+Khhebm7g=;
        b=YYPLBzsL1r5Jej00eSNA+2x76YPfjfGMz/iUhshPTOP8Io8RxFdQuNUhZQFJiO+/6M
         dK2CAobNiey7ViP1BJFs3rvQyf9SyTg719z1xdU6zkC8lY6rQcK0UB5SebXKODa2WRtn
         OezM8Vc7N9dx22iitxv7fIsCJZCkL90K2X9EJvh5LscO1Et+oWZ8bnNQ68aLvd5aOa8r
         ebnxZV8fV1KiKjVULog33sCwgWrtTORpnLitkxVzwI0zxL5zPxn5/avtQtPpL/ekDAXb
         Hjz/CH+HjTtat9sZm7pbrff1PtTZm5hC6HZ3EzFnjW8blTcrhFfvlqNHIY1q6Q9xzaq3
         6DiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706896782; x=1707501582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEmXtPEVMO3oHchObaEeNLlugLVri5Npjz+Khhebm7g=;
        b=vIQHUcujMDqFm2K+xWcwqlyWdjbGds81z52c0ejci0jZ5egeQcK5HfS9e119DyXoGh
         /OOdgCe/2+1wp7qSMNhSAyZ4oCt4RPlOLrKuSDrq5VAVpCzwHPVskrGNv7qBqxGnIUG3
         R/cbSZP+4q2UzSiRYiON62kHrYsGTRTko+THbbEcfAyfjScsryyOUDrAaTDbqpdSuO2h
         jb7zE8UHcCnwlAUXxbEUVV2DMjwkgrSoadllC8Ldz21FKS0pE1UmitUaHG/0pHnWjZyA
         luX2eXE9lyt77+DSpiI3p2U3scAlWwETP7ckUtltf2xhZmTCqrIIS+AXDBv5mmfA0uHH
         1s0w==
X-Gm-Message-State: AOJu0Yw7/XTp/f9PHkp5UT86ateZnSHsAI+B/9NYTbhWJjKVhgAhrTGS
	JqjXm5JxC707qNYHLJLUxnCDNd1Wqc1HX+26z5jsDI8tJAmki5xF37/lDH2a7rfp/atD269qFUz
	yDXogg0ts/viYTt+Jx0VqWJTi2/I/wJPfGQMK
X-Google-Smtp-Source: AGHT+IFHffLQtTMSTo5MUK3Dg8CqXbPyFRi0wqCfcGRuk9MxRoFa7PZm9cOEbEUY9T1OOExuntVHNL+xSqTF5WAgEvM=
X-Received: by 2002:a05:6214:1c0d:b0:681:9c10:e33c with SMTP id
 u13-20020a0562141c0d00b006819c10e33cmr11755584qvc.53.1706896781885; Fri, 02
 Feb 2024 09:59:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129202741.3424902-1-aahila@google.com> <ZbvFEtQskK3xzi6y@nanopsycho>
 <CAGfWUPzeWeF-XPGem=VqxG=DaOEMRWnjCcueD+ODsEKLczDEMA@mail.gmail.com> <ZbyXJu0ZO4sZfrV2@nanopsycho>
In-Reply-To: <ZbyXJu0ZO4sZfrV2@nanopsycho>
From: Aahil Awatramani <aahila@google.com>
Date: Fri, 2 Feb 2024 09:59:30 -0800
Message-ID: <CAGfWUPyaSrmWG9eY+TgBwmzP4eHoLf4S8L1HVCGr9p+Akkh5Rg@mail.gmail.com>
Subject: Re: [PATCH net-next v6] bonding: Add independent control state machine
To: Jiri Pirko <jiri@resnulli.us>
Cc: David Dillow <dave@thedillows.org>, Mahesh Bandewar <maheshb@google.com>, 
	Jay Vosburgh <j.vosburgh@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Don't touch procfs here.

OK removing procfs changes.


On Thu, Feb 1, 2024 at 11:18=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Thu, Feb 01, 2024 at 07:45:23PM CET, aahila@google.com wrote:
> >> Any chance we can have some coverage via self-tests?
> >
> >I plan to work on these self-tests decoupled from the current patch.
> >
> >> Hmm, I wonder how it makes sense to add new features here. This should
> >> rot.
> >
> >Could you clarify what you are suggesting here?
>
> Don't touch procfs here.
>
> >
> >
> >On Thu, Feb 1, 2024 at 8:28=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> Mon, Jan 29, 2024 at 09:27:41PM CET, aahila@google.com wrote:
> >>
> >> [...]
> >>
> >>
> >> >diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/=
bond_procfs.c
> >> >index 43be458422b3..95d88df94756 100644
> >> >--- a/drivers/net/bonding/bond_procfs.c
> >> >+++ b/drivers/net/bonding/bond_procfs.c
> >> >@@ -154,6 +154,8 @@ static void bond_info_show_master(struct seq_file=
 *seq)
> >> >                          (bond->params.lacp_active) ? "on" : "off");
> >> >               seq_printf(seq, "LACP rate: %s\n",
> >> >                          (bond->params.lacp_fast) ? "fast" : "slow")=
;
> >> >+              seq_printf(seq, "LACP coupled_control: %s\n",
> >> >+                         (bond->params.coupled_control) ? "on" : "of=
f");
> >>
> >> Hmm, I wonder how it makes sense to add new features here. This should
> >> rot.
> >>
> >>
> >> >               seq_printf(seq, "Min links: %d\n", bond->params.min_li=
nks);
> >> >               optval =3D bond_opt_get_val(BOND_OPT_AD_SELECT,
> >> >                                         bond->params.ad_select);
> >>
> >> [...]

