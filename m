Return-Path: <linux-kernel+bounces-141473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7E88A1EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960141C24CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DDB2BCF9;
	Thu, 11 Apr 2024 18:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN3Ka05n"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC23255C26;
	Thu, 11 Apr 2024 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859925; cv=none; b=Km++c14dg0+7SvI2Mh8HnMLckmDTFsFiIx4XiROVjG3hvRtSV0W5x7/jRWNvDnMy11conFrnT6h9oHuwh46veAgbZAW3R1YEnR7NXjluj6X8Oyn417GrUvKUTB6bNgpiBGBi27uKwL2BoIPc5ciR7fMqVdmbP/6g1iymNtbqlkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859925; c=relaxed/simple;
	bh=x5ITCD68gdJ1VDIzwMIWm8Lb16eRXf4F9SQRGuHBdNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nxig6Cas3WcNJF2aVfrHh1cK797bkTGxowN4bFXu9WloTZwR8fzqnLH5ObnUUbXvCZ1J6nMGPFUCU/BjHVhh2+NIdkoCbxV5a9uNK1oeb7Pt6eS3i1zcZTbnhp9FXXZbKouipyN4CSGzSj7yLHrNaBvXQll4gxd1cz9KFtmi23w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iN3Ka05n; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so135625e87.2;
        Thu, 11 Apr 2024 11:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712859922; x=1713464722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEhrlTKELTXQ2qY+Hq6n+QM5jgM2bocOE5/LwFDOg0c=;
        b=iN3Ka05nT0YcO5bCCSE/LiZbCW1vCt0T0vGlf7r98rEsbj2M7QUT87IfHz0PLKoZE9
         p0oXIsuGjkEB+XYad09jxeokemBLJNYM/gyiA/Iyz/h4s9MmslwClFcGHzlhKWrWwfHq
         3Ng8hFUMKLBAyPPyHMXacldkxZYeP5k/jgR8nMXve61P+eqCrA42pWk8fjqBG3aSiTrB
         aK0uRzQDNKFn7aUmm7t6kJZp9bPa4Emup2RxisPHD2oLScgVcK9qF4cZz7JOZ8K8bXRy
         O75+EF319MboglDux5AfS5eMp8QmOkdR3bF1oVVlCSFadZc4/RnaPkKH1eRW1dEncvzK
         m+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712859922; x=1713464722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEhrlTKELTXQ2qY+Hq6n+QM5jgM2bocOE5/LwFDOg0c=;
        b=LG/UTbgskEdm1DrC5/KUsYn6yGY8InLxksP+Ba+H91ErVrhHMR8d5Ml6wVmThhUTzR
         MlLjkGCFljqpRJouWGJlKoV3NP88nhQVzShP9a+JytyeXztSOtcPnPFS0imxj26cdcjW
         SykWa++yPZW8kDxBwTHcbZ8e0ocROmgMKWeAjVUqwBndCs00pJOCBPY47t7NSKLAkJR2
         Vt+bkYiE6aLxbNxvZZUZjK9TyTxduVoATxuTEV6lZm7CHhrFBOmaZE/PvMI8tD8lPK0m
         JcuaTVHZ8s6jiRYFk978aQHPv85JExuoIeXwxECo3oPD/lSt8qlQEDEx+vD+RUoNVrF8
         lz/A==
X-Forwarded-Encrypted: i=1; AJvYcCV1De5qOlIXPsxQaArkXSRnQpfrLEQoGeB8Xi4KUBMQCSe3Z7t+myVCJMIpsOU6esetRuXtXWTYQlehw3d8mwA7wngmcvm+YNOE1ItdjNV+YjIHobggj2OgfMjpEDD47Py5CjxN0YAVEyfa
X-Gm-Message-State: AOJu0Yx0VNtv5/S+Wu4Eh5l8rFsSuvipafcnWiH/jPtsyUlTFsaM1hQx
	ofFP7AIG9vrhjyqqrpUimaDE4hhDAnBBzGRnn1uJ9NlSgPM7uQ0/bje6B4uw17GX6Xmbe/J5aJg
	Um2K9s6llbkMfK8DlZEufehU/zObbZPbh
X-Google-Smtp-Source: AGHT+IEE9T1FgUdSjHs4cuV+Etn215ZtZjByURORsmK6u667DyGg+Wyqosy01Ss/Z5RpwVYOZGMncPlHF04RVqmyar0=
X-Received: by 2002:a19:7718:0:b0:516:a18f:908c with SMTP id
 s24-20020a197718000000b00516a18f908cmr326181lfc.17.1712859921783; Thu, 11 Apr
 2024 11:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411180256.61001-1-romeusmeister@gmail.com> <2024041146-exciting-predefine-05bb@gregkh>
In-Reply-To: <2024041146-exciting-predefine-05bb@gregkh>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Thu, 11 Apr 2024 20:25:10 +0200
Message-ID: <CALsPMBM9DG3-St9Ne6qZMXiNzSBxSXL=pzJn8Eu9be5hfik2bQ@mail.gmail.com>
Subject: Re: [PATCH] sysrq: Auto release device node using __free attribute
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, Julia.Lawall@inria.fr, skhan@linuxfoundation.org, 
	javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

This is the output of the checkpatch:
hedin@laptop:~/prj/linux-next$ ./scripts/checkpatch.pl --strict
~/lkmp/course_tasks/coccinele/patches/sysrq/v1/*
---------------------------------------------------------------------------=
-----
/home/hedin/lkmp/course_tasks/coccinele/patches/sysrq/v1/0000-cover-letter.=
patch
---------------------------------------------------------------------------=
-----
total: 0 errors, 0 warnings, 0 checks, 0 lines checked

/home/hedin/lkmp/course_tasks/coccinele/patches/sysrq/v1/0000-cover-letter.=
patch
has no obvious style problems and is ready for submission.
---------------------------------------------------------------------------=
---------------------------------------------
/home/hedin/lkmp/course_tasks/coccinele/patches/sysrq/v1/0001-sysrq-Auto-re=
lease-device-node-using-__free-attribut.patch
---------------------------------------------------------------------------=
---------------------------------------------
total: 0 errors, 0 warnings, 0 checks, 16 lines checked

/home/hedin/lkmp/course_tasks/coccinele/patches/sysrq/v1/0001-sysrq-Auto-re=
lease-device-node-using-__free-attribut.patch
has no obvious style problems and is ready for submission.

Before sending this patch to the mailing list I sent it to me,
downloaded from the email, and then applied atop of the tree using git
am. Encountered no issues.

I can guess that you checked the whole file and got some issues. But
those are not related to my changes.

Thanks,
Roman

On Thu, Apr 11, 2024 at 8:10=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Apr 11, 2024 at 08:02:56PM +0200, Roman Storozhenko wrote:
> > Add a cleanup function attribute '__free(device_node)' to the device no=
de
> > pointer initialization statement and remove the pairing cleanup functio=
n
> > call of 'of_node_put' at the end of the function.
> > The '_free()' attrubute is introduced by scope-based resource managemen=
t
> > in-kernel framework implemented in 'cleanup.h'. A pointer marked with
> > '__free()' attribute makes a compiler insert a cleanup function call
> > to the places where the pointer goes out of the scope. This feature
> > allows to get rid of manual cleanup function calls.
> >
> > Suggested-by: Julia.Lawall <Julia.Lawall@inria.fr>
> > Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> > ---
> > This patch targets the next tree:
> > tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > tag: next-20240411
> > ---
> >  drivers/tty/sysrq.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > index 02217e3c916b..1d1261f618c0 100644
> > --- a/drivers/tty/sysrq.c
> > +++ b/drivers/tty/sysrq.c
> > @@ -758,11 +758,12 @@ static void sysrq_detect_reset_sequence(struct sy=
srq_state *state,
> >  static void sysrq_of_get_keyreset_config(void)
> >  {
> >       u32 key;
> > -     struct device_node *np;
> >       struct property *prop;
> >       const __be32 *p;
> >
> > -     np =3D of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> > +     struct device_node *np __free(device_node) =3D
> > +             of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> > +
>
> Did you run this through checkpatch.pl?  Please do so.
>


--=20
Kind regards,
Roman Storozhenko

