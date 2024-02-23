Return-Path: <linux-kernel+bounces-77616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F7486081E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52BCAB224BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83436CA73;
	Fri, 23 Feb 2024 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qrOjmIbw"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D173C2E9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650656; cv=none; b=Ccn3bSLuVWLuYBKWCNaVo+ROzs3VDN3LMKkFw/P+jr1KYROL4hM+PDm/GgGGBRAgX/Kby4f+t/prKCbhdrf9/uPWK0IrqRP5FVfxY408OxZ/DO/3KPHRDM+MJvxZaTVIx7Wm5XuarJa62SoBWn+Tb0fZE7bRfHnVHPOxkrFFqHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650656; c=relaxed/simple;
	bh=/zpuAjWPgH31NStUkpI15+FlzmfUlwOshTeI8pkbaqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFD+WnVMmdWlIB1a0rDdYvzvTpdfWufiJlHK4B6+y2c/sTsW08WBjP0amrCP2Zjr2NHyRygLAVkwkPBM2iALcnkcMxSEXod3N6DKAy7CE1REOGuBC1hw4ux31N7m92LH/UG1P6pt51v7H2+Gtm8HH8my3KlK70q53wxb5anFKcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qrOjmIbw; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-428405a0205so89561cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708650654; x=1709255454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sboURurxKEaNFycoxUz2gIfzdUDsQeMcss9yHWictuE=;
        b=qrOjmIbw7EANQsZGTFxVA84giKb42LVWlUAVfk7WLYQnFgyg8swptnJ5Xya8DQtw8e
         b1F7GiBn66l8/5RtBl4XSW2fFvB937BdJlwcQH3vz+wUG60PhDdOmdXbQ8yMd0GuMfMH
         YqQAiS2XPdSCCqBgUEAIwCy/2W6uXsgLxUDUyyAuWTP5adZ+y3vOSivzhZesZJOq7Zjh
         U/0SEruiy1bVquCWwGKtOLqu+Km9YqBZyifTy4q0VF+pmxMDPsyup2yLhuL30Gxh32ps
         SHJXaLsUnm2LXEninVzJLFL+Qvywo/GJUeCN+9rIwizyUxRTujwywAKkVtWSfSTfRSfb
         1mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708650654; x=1709255454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sboURurxKEaNFycoxUz2gIfzdUDsQeMcss9yHWictuE=;
        b=pBKi+C0UQoaGdwOegRL2IrQC3a6BLYL9BkxxwDmTVcqbhxDKZlndxHzD9eO/CKNGen
         /ktRCk1FotxNINOBVhdp5a7y+K3jPP9XLiOkpCJVNGLbcec4MSQb0KTEKVTioABstfWV
         7Dyv5nrhnYp8FzDP0rmBXJ+mcEFRuMDgiaVMgKjJxND6Ku60FOMeIGmVfVbTtcxL0F0e
         FmnBircVSweNUjA9LtN/1EuNcCIIm+bVCLX9oQiUT7qkwlLWx3s9/xQ8ZSuGvLHC+ti7
         F809OnzlFj/1D0jS79HGSU6xfvC8H+8S2HPxSLIwu3RV+aBDFBE4aXny+F1PYP0ZDZzZ
         VnYA==
X-Forwarded-Encrypted: i=1; AJvYcCXlLusKbOPe0VIyiTnwUFzdgSmtU8FReuVsVhG4p/X9s0oXKOLeRm4cK2UTZwayuSDB6uMGaaSB4V62Owy2gLvPT07kcBvvwbS65nNV
X-Gm-Message-State: AOJu0Yym8ONdgOTMuzPEAiVmegZCJORJon2fhqV0ttMxNVfbr5sSGIuj
	ky8Y7zJ1oS+8nBFFtSpnO6Foyini2QK0uK4qTchK4Sewm0A0kkzYaOEcxjXMO8G0U38lgSByy3T
	tW2RtDq3MZNA2EDhNPwI/QGtFVRjTFyj8g3hI
X-Google-Smtp-Source: AGHT+IF4A8WgyhCwujaoqvxR7XmJo5hrndtXNmFCWfL5+79E/HTYlxRiPlD53MjXhmEhr7Ccgr8vbSTIU0f+NvIUZ6U=
X-Received: by 2002:a05:622a:1b18:b0:42e:60c2:4522 with SMTP id
 bb24-20020a05622a1b1800b0042e60c24522mr83400qtb.1.1708650654091; Thu, 22 Feb
 2024 17:10:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222051539.3001988-3-saravanak@google.com>
 <20240222051539.3001988-4-saravanak@google.com> <ffec7c7b8eb86f573e420e0582075ba1e75d0e54.camel@perches.com>
 <CAGETcx-mNt+_ST0opQ=_M1ZJK1acf8Rr0VqaAUskyig5YwL_dw@mail.gmail.com> <e51c5e6fe02bcc5a487cae063fe8f440013d0ca9.camel@perches.com>
In-Reply-To: <e51c5e6fe02bcc5a487cae063fe8f440013d0ca9.camel@perches.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 22 Feb 2024 17:10:15 -0800
Message-ID: <CAGETcx8rANkOHhay6iFoXtXtJ8KvoNQBAMpruGENys+L2uHQTQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkpatch: Don't check for unified diff format in
 git sendemail headers
To: Joe Perches <joe@perches.com>
Cc: Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 5:01=E2=80=AFPM Joe Perches <joe@perches.com> wrote=
:
>
> On Thu, 2024-02-22 at 16:45 -0800, Saravana Kannan wrote:
> > On Thu, Feb 22, 2024 at 12:54=E2=80=AFAM Joe Perches <joe@perches.com> =
wrote:
> > >
> > > On Wed, 2024-02-21 at 21:15 -0800, Saravana Kannan wrote:
> > > > When checkpatch is used as a git sendemail-validate hook, it's also=
 passed
> > > > in the email header for sanity check.
> > >
> > > Why?
> > >
> > > If so, why not use a front-end script to stop/remove
> > > the file from being scanned by checkpatch?
> >
> > Sure, I could do that. But this also makes it easier for people to
> > start using checkpatch. Or I can put up a git hook wrapper script in
> > here for people to symlink into their .git/hooks that does this.
> >
> > I'd prefer the lazy route of not creating a 1 line wrapper script :)
>
> I'd not.  checkpatch is for _patches_.
> Don't feed stuff to it that isn't patches and expect good results.

Would you be open to being a maintainer if I add a git hook
sendemail-validate wrapper? It feels silly to add myself as a
maintainer for a 1-line script. I'd rather give it to you :)

-Saravana

