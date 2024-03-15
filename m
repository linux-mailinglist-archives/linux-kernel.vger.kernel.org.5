Return-Path: <linux-kernel+bounces-104783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 248DD87D38F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A18DB236FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287CC4AEF1;
	Fri, 15 Mar 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cozzzGfK"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D9E4E1CB;
	Fri, 15 Mar 2024 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527257; cv=none; b=NnuFKW8v8yHNJugOKCmYkU3d5bqa/UcZImihYEExwAP4PxfPnNL48hceBntKKbImmYDFPMISj/B4PnAMFBz/wpCWhSMjtY+6IQbj0kGdikk7tbiXNIGFyqkvNL9ODAke506mmEbDfOAP8K7hIJaUrITw/jeutH7jh44Rx8SgnUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527257; c=relaxed/simple;
	bh=o+Uvyz4YzYO4LBu6eCmoOI+ch0BavL/du69hBKagie8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4XjxLsJNpNJZfTTp6gf6UneTL4/txUy2e/oVRdKOmLKzPuX/j+GvyqhK0li850g3MyAJODTmNiG8jUEXF8sLI0tt0vfvaxU75Qd8ibN0Ws+2g1X6aQpic7OZoNFzqkluD4NQo6jZveN2NYr14uU8IWTQkSqDXt9btWSnIMdxDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cozzzGfK; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so2489884276.3;
        Fri, 15 Mar 2024 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710527253; x=1711132053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0l8ekWw0JTpeXusMsWqfGloumBIBWf5eNxMM1W0z7I=;
        b=cozzzGfKpT66ssrNAfg7iJ8n0V/H88qsF4qgHUwGlym0eZ2sapdJnpZu2+tv4jOr9F
         Rqq6Yl8p7NmVHdJLtkJAeZT1DDfUeb/cpFiU6/51lTWEMwGPdFR/MszrwuN5qH5OG2ud
         ADJ1MNMDu1cb8ayUAzcILcH90G+TgrBKrBa0R9ZdZtuYWY0gym0nsjDy92kM6c50w+LB
         fMBuqaYl9FDCxxONryz3SPM7reaq2AqFbJcvzQkc76SUcYKk8TllKZeT/CKWFrDCYuOn
         hx5AcuHAEkYa2do0IVC56FiY2phEcaH/3rgvwVMIa8CEPG/WLu9fRCNXWBYECm7BbnPz
         u1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710527253; x=1711132053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0l8ekWw0JTpeXusMsWqfGloumBIBWf5eNxMM1W0z7I=;
        b=jqVY9xksV3Fts1OKbr5CQFDXgCYR+Wr9AxBihi+ue+cA1lPwtrQpZUbrK5/s3plaSa
         cj2MdMiIq6qQUb3lrDMz/0v6qYDbEiiMpEtlUXW2VS3IwkHeigOC3gmxjuxir7D+kckx
         YiO7AMRV6UffK/pmapN0QtEJ0jd9QDDUdvgsQL41e9aZiq4I9V62W3THwHd94corK1Wo
         Kq/gLTeLrRGrvRz2bH2Y5zUc3ZYvi8VboM+VgGs5qkvs+utknfmvvOneJStd7IKMCV59
         Won3gllL0nsXiOD01F9p3Q0rEkX4b9RG1daY0sElgUyQvFQnGYi98vmsMvx9CTpeR7pM
         Qmrw==
X-Forwarded-Encrypted: i=1; AJvYcCXEbR337+prm7xImgbqFl7s/ZyVAM04f8Q4wJyCUriTHN4xt4nElMaXI3RC+4hkyefIoygXMnFpXaX/t5PFpcRlrdJc7sFHezmgnLUvrbOiPJEqxYyYWVxRz6aG+8uVM7CK7HTPniHiTvh5hl41rjHjusl9IRakS8U0Dd6sVlw=
X-Gm-Message-State: AOJu0YyqzdZ/q6bvyJ3JUA1B/M2XWNJ9ns2QnnftYRQaC2y5ueaM+63k
	OgtiDTNk160tQ0/VADlX/nzdIiyAEpsqRvZrz3a/dz7SoxsutMIsEyXkN8r2mKAqzdA9NnmwGB1
	u4tLxfu1lyZcDE6P5sTqHBJomClIpIRlNAMAvsg==
X-Google-Smtp-Source: AGHT+IFMhRRjG1ESUWFYiuNmqAYpvAzNTCRsgxJSy0t7rB+pBcx68HYz73ujPmf7VrBo4DOXQP/Zl+MVoPGaKfXcYu0=
X-Received: by 2002:a25:bcc6:0:b0:dc6:ff32:aae2 with SMTP id
 l6-20020a25bcc6000000b00dc6ff32aae2mr5004033ybm.63.1710527253128; Fri, 15 Mar
 2024 11:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315113828.258005-1-cgzones@googlemail.com>
 <20240315113828.258005-2-cgzones@googlemail.com> <CAEf4BzZF0A9qEzmRigHFLQ4vBQshGUQWZVG5L0q2_--kx4=AXA@mail.gmail.com>
In-Reply-To: <CAEf4BzZF0A9qEzmRigHFLQ4vBQshGUQWZVG5L0q2_--kx4=AXA@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Fri, 15 Mar 2024 19:27:22 +0100
Message-ID: <CAJ2a_Dfy3DKnsZZhKUXiMbG-NZqH0APwz3tGF1Fdma+nYcHmOQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] capability: add any wrappers to test for multiple
 caps with exactly one audit message
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: linux-security-module@vger.kernel.org, linux-block@vger.kernel.org, 
	Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Mar 2024 at 17:46, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Fri, Mar 15, 2024 at 4:39=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add the interfaces `capable_any()` and `ns_capable_any()` as an
> > alternative to multiple `capable()`/`ns_capable()` calls, like
> > `capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN)` instead of
> > `capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.
> >
> > `capable_any()`/`ns_capable_any()` will in particular generate exactly
> > one audit message, either for the left most capability in effect or, if
> > the task has none, the first one.
> >
> > This is especially helpful with regard to SELinux, where each audit
> > message about a not allowed capability request will create a denial
> > message.  Using this new wrapper with the least invasive capability as
> > left most argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables
> > policy writers to only grant the least invasive one for the particular
> > subject instead of both.
> >
> > CC: linux-block@vger.kernel.org
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > v5:
> >    - add check for identical passed capabilities
> >    - rename internal helper according to flag rename to
> >      ns_capable_noauditondeny()
> > v4:
> >    Use CAP_OPT_NODENYAUDIT via added ns_capable_nodenyaudit()
> > v3:
> >    - rename to capable_any()
> >    - fix typo in function documentation
> >    - add ns_capable_any()
> > v2:
> >    avoid varargs and fix to two capabilities; capable_or3() can be adde=
d
> >    later if needed
> > ---
> >  include/linux/capability.h | 10 ++++++
> >  kernel/capability.c        | 73 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 83 insertions(+)
> >
>
> [...]
>
> >
> > +/**
> > + * ns_capable_any - Determine if the current task has one of two super=
ior capabilities in effect
> > + * @ns:  The usernamespace we want the capability in
> > + * @cap1: The capabilities to be tested for first
> > + * @cap2: The capabilities to be tested for secondly
> > + *
> > + * Return true if the current task has at least one of the two given s=
uperior
> > + * capabilities currently available for use, false if not.
> > + *
> > + * In contrast to or'ing capable() this call will create exactly one a=
udit
> > + * message, either for @cap1, if it is granted or both are not permitt=
ed,
> > + * or @cap2, if it is granted while the other one is not.
> > + *
> > + * The capabilities should be ordered from least to most invasive, i.e=
 CAP_SYS_ADMIN last.
> > + *
> > + * This sets PF_SUPERPRIV on the task if the capability is available o=
n the
> > + * assumption that it's about to be used.
> > + */
> > +bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
> > +{
> > +       if (cap1 =3D=3D cap2)
> > +               return ns_capable(ns, cap1);
> > +
> > +       if (ns_capable_noauditondeny(ns, cap1))
> > +               return true;
> > +
> > +       if (ns_capable_noauditondeny(ns, cap2))
> > +               return true;
> > +
> > +       return ns_capable(ns, cap1);
>
> this will incur an extra capable() check (with all the LSMs involved,
> etc), and so for some cases where capability is expected to not be
> present, this will be a regression. Is there some way to not redo the
> check, but just audit the failure? At this point we do know that cap1
> failed before, so might as well just log that.

Logging the failure is quite different in AppArmor and SELinux, so
just log might not be so easy.
One option would be to change the entire LSM hook security_capable()
to take two capability arguments, and let the LSMs handle the any
logic.

> > +}
> > +EXPORT_SYMBOL(ns_capable_any);
> > +
> > +/**
> > + * capable_any - Determine if the current task has one of two superior=
 capabilities in effect
> > + * @cap1: The capabilities to be tested for first
> > + * @cap2: The capabilities to be tested for secondly
> > + *
> > + * Return true if the current task has at least one of the two given s=
uperior
> > + * capabilities currently available for use, false if not.
> > + *
> > + * In contrast to or'ing capable() this call will create exactly one a=
udit
> > + * message, either for @cap1, if it is granted or both are not permitt=
ed,
> > + * or @cap2, if it is granted while the other one is not.
> > + *
> > + * The capabilities should be ordered from least to most invasive, i.e=
 CAP_SYS_ADMIN last.
> > + *
> > + * This sets PF_SUPERPRIV on the task if the capability is available o=
n the
> > + * assumption that it's about to be used.
> > + */
> > +bool capable_any(int cap1, int cap2)
> > +{
> > +       return ns_capable_any(&init_user_ns, cap1, cap2);
> > +}
> > +EXPORT_SYMBOL(capable_any);
> > +
> >  /**
> >   * capable - Determine if the current task has a superior capability i=
n effect
> >   * @cap: The capability to be tested for
> > --
> > 2.43.0
> >
> >

