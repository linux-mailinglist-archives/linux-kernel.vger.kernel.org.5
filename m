Return-Path: <linux-kernel+bounces-48719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C778784603A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035791C24E3F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458445A4E0;
	Thu,  1 Feb 2024 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yq0/h8Rf"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6674E7C6C9
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813138; cv=none; b=INZoN+We4fdPAAxjwng5aKRXMcWsJDD3JOehByCgB7RAccOJ/Fa0enpBeWrrpP+2osnF3UF2P+WIUgl/SPaPRM5ExO8BFmcu91n4jBSS79tsV4qjkI0DmSy+Md17P2lXtX41cQKvmvM0+KElW27lIje0pw1aed7Z2f1yjkDK4RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813138; c=relaxed/simple;
	bh=WLN/I8zDIYv90emnu+BrvNcZrC5OZrKJETTsJYXnWTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMHFLmkDHI+koQl+RexiFtWtc67r52b+IBAdnEPdwkFghaxgjJPMIyRt086xuOQ44tnzfp8vx3mYzf2knQrduHKorx5CREdPlLEiK0Io4ArXPYxOBIDzJv/Jc8gJ3XTkIuHXoVy0QcENnI4RZg8FLpEvW9ybKX0n13mZvvTrZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yq0/h8Rf; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d2e007751eso706745241.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 10:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706813135; x=1707417935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX+XzKo3hA/FKch3SlJ9SoxyEE2YWPNWjBbiP8ff5mw=;
        b=Yq0/h8Rf6nn6jo/4ybGWe1xHTJ1V5gpN9w9PX/Lz9TsjE2/EleA74R2zrXGdq/494V
         psqKdEcVY7P1O78zXptHzfIPfdpKmU0eC9bsohiOmGcwr5Gy2riFENzZx/3iHEO4qMbk
         EsFq4Fn7KrjNtCZXRQehuu9fK8WLB1Jd+reV2GuYfybOT23JzgK2uHUZ8/YxdH42IAks
         PHJ8T+Pl1fH7LSY8dVb91uApi/IyfzNAVSXkwSvEVS/rtpUvyJgaU72VANN51jjcBxaX
         HSCPbfdHxgT+9gWYkMoA+08IYETFwaNjgmKp0u6YVX6TNJ1B2nUBqVhfNmtN0CjPLvko
         Sujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706813135; x=1707417935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KX+XzKo3hA/FKch3SlJ9SoxyEE2YWPNWjBbiP8ff5mw=;
        b=cOuqG+qyfXq3a2DJDLu18fwVOUYRLPAB5EqmcLRE8m7Qc5JjO8nYm91G/mDFuI9jKH
         +/sgYyaSyqg0XwWpVo19EVAoLaMYIZORWorwZ/vOjdKJqJ6DzfbRrgBMBME/vq+pMX86
         EmNFCENYnHsRemjS005hb2WQnP6jWUaca2ljiOAdWEEpk5oQif7hZsQ76nYq/PJ7eEuw
         izdvkPbmGBS2BUP/69rzM+vi+HYOGRzpD8uZB2Aw7umGBFkYmYwaZDZPxZh3DSC0i8v4
         j8eSpDwfaQSyVhWc/oGTepmJ+BFWmEtk/+7j/YGUuJX6iy8I3BZjEMSWXLXehhEFRlY7
         UWlA==
X-Gm-Message-State: AOJu0YxVnACGkOrIeXlIl5KfIWp4OvC+p2JCUDpp1e0jNBx2HiAUF1zY
	uubHXm6SlTpBfzplmD0808wxJLwBmw4l47K3eFeCUH0jDtho922N+ohR8CfyTJkwOjkMFnfZ3qf
	hgcRWQm7r3G5t8HMaYOV7n7k/DkDKQA/hCU56
X-Google-Smtp-Source: AGHT+IH1Wl5ytQxmsJFPNY4DrHKVCmHhPAyclcfbt6/cJFgaOTuEXKaeL7MSzTipVlTACWjESrw5MiwBVrVpy5tQ1Wk=
X-Received: by 2002:a67:ad12:0:b0:46b:3a27:9895 with SMTP id
 t18-20020a67ad12000000b0046b3a279895mr6007237vsl.14.1706813135051; Thu, 01
 Feb 2024 10:45:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129202741.3424902-1-aahila@google.com> <ZbvFEtQskK3xzi6y@nanopsycho>
In-Reply-To: <ZbvFEtQskK3xzi6y@nanopsycho>
From: Aahil Awatramani <aahila@google.com>
Date: Thu, 1 Feb 2024 10:45:23 -0800
Message-ID: <CAGfWUPzeWeF-XPGem=VqxG=DaOEMRWnjCcueD+ODsEKLczDEMA@mail.gmail.com>
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

> Any chance we can have some coverage via self-tests?

I plan to work on these self-tests decoupled from the current patch.

> Hmm, I wonder how it makes sense to add new features here. This should
> rot.

Could you clarify what you are suggesting here?


On Thu, Feb 1, 2024 at 8:28=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Mon, Jan 29, 2024 at 09:27:41PM CET, aahila@google.com wrote:
>
> [...]
>
>
> >diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bon=
d_procfs.c
> >index 43be458422b3..95d88df94756 100644
> >--- a/drivers/net/bonding/bond_procfs.c
> >+++ b/drivers/net/bonding/bond_procfs.c
> >@@ -154,6 +154,8 @@ static void bond_info_show_master(struct seq_file *s=
eq)
> >                          (bond->params.lacp_active) ? "on" : "off");
> >               seq_printf(seq, "LACP rate: %s\n",
> >                          (bond->params.lacp_fast) ? "fast" : "slow");
> >+              seq_printf(seq, "LACP coupled_control: %s\n",
> >+                         (bond->params.coupled_control) ? "on" : "off")=
;
>
> Hmm, I wonder how it makes sense to add new features here. This should
> rot.
>
>
> >               seq_printf(seq, "Min links: %d\n", bond->params.min_links=
);
> >               optval =3D bond_opt_get_val(BOND_OPT_AD_SELECT,
> >                                         bond->params.ad_select);
>
> [...]

