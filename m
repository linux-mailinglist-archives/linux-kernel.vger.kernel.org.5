Return-Path: <linux-kernel+bounces-116393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF06C889A22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC4A1F32861
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E13086643;
	Mon, 25 Mar 2024 05:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HPoaBkJW"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5963314BFB3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332174; cv=none; b=klZHRnI9a/N76tO69fXAGvsqoy5Dica/vZqyiFoZotfMYuNucooVJel6QBp7bjeoem4BNa/So2zU6NpCLuOUAbv1MI4mMLqlRuDusry/O1oj2vmC5mE24dsX8arQpZkyMUjOWqroxvr3m36Ql/FlDUfx0pbcJrFP7Q7Y9/dIL50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332174; c=relaxed/simple;
	bh=r9B98m2a8dZ0bmDDC3obEW4AWL7V1A9bqVt8onHT71A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiWXF0GeVW+KlK1rsvqCn/D1Ji+os36vr3I/mIsvp8QcKcXd6vyLOom3Uh2Tv/KNdFVlV/6CTDNO8tk+UFbajZNR8B8ehnrnIHaAOe61hDET7NgPbUcQG79vOMwn/VVgHR8J3QyUejK3WRQtJloVdH/GZHi4QV/DmILER0HImtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HPoaBkJW; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 482F23F1D9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711332161;
	bh=+mIvzsZciY5ySPQ+G6tsFtbRNob9H1jOM+O8s2gDVJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=HPoaBkJWaUSAhzG61KIqwhJmEJ3hjwfC/pHM13HADqToVk0L0mmlcAQ/H00ejuLUS
	 iB/257cAHzylA5wVw8/tdS7OINE8Ho9J7mguQdmnS8C5bqOZRmt9aT9PDuENT+dquE
	 dyIV7Q29wJd+Q+ZZBIeBBWZm19/vDk+58QJe6IZc8x6W6CbzWquWQokOBccP9g77Jq
	 R5uYjFi21w/rzWuU/Q7yjQ0LygKaYtSkTk1eYb2nOBdBlmakhOCVfyrZFsFka7J8JO
	 usm491YRm8kPu+PXYA4bE73x2IHX16UTNHu4X0KaeGXulMVsuvU8jnG/f9TwLgJ+kK
	 sScLaJU+63QPA==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29f96135606so3471349a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 19:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711332160; x=1711936960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mIvzsZciY5ySPQ+G6tsFtbRNob9H1jOM+O8s2gDVJ4=;
        b=PFNQR2WiUkJIz5kNkyXnE5/eB7PrrOPksWtI8PfoGroMGKvga51JJuRUgfkMmdY/Hi
         uvkT5qRegau1YKOyL+cUDZrIHC20nU9HcHIPc0jXd0PcMOaKODeps7qgRXFmkb6aiJG8
         x9FM3jOYNRpO48iYZRR9wBNCiWy4gzWcI96CFH/VE/eC+Qt9PJecGAOxsPE83gqFKwPE
         UTlce/UPgSPos5y4XKw4JndOgTa2Sv10C5tLKExwG5wqtBGIjC3zXQSfTvc7YXiJPHau
         ehSBvs/0D6B5ZSA2A9a6OEx06QxW3PxbQV2HL4JH8Z4eLxxLnyqkBsPFSKBM/Zkg3uKa
         FDMA==
X-Forwarded-Encrypted: i=1; AJvYcCWOxVaL1F+fp/uFoYpms0fX8ifbC2ECLMI+QGu9nC19AurBbebcILVDF6BJdYCQlA/c6PlrZVtkQgY5Yd9gfL+x28Aog069U2X6tSc1
X-Gm-Message-State: AOJu0YziOj4LNfVgYhVMGAYPdjlZfH5RgcCOpk9Uh/RqLjd3ysj3PAHl
	5m1VGfwFjfpCT5iH5UjhGWdLprSnpQEFJ6+pWUYNuJqVTn9pgu/m0r0TjECK1umn2o3+Q8HEHIe
	GSMt1OH8D4dqlXdehALdDl4dNAKolnCX6wZEVNM51XwA101cQhCiqDqLSZ/g3mE57wfA+coNgrh
	P4B+zq5izmDzbSnVJ3uUxq+SeWdrG4ngugKGmgeygCeGTKFKcSa/qP
X-Received: by 2002:a17:90a:f305:b0:29d:e004:f8ce with SMTP id ca5-20020a17090af30500b0029de004f8cemr4659458pjb.6.1711332159828;
        Sun, 24 Mar 2024 19:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdgo5FDJzC6NeqQqpgbGFtMGSoVZp9BqWYX8x2dG/6JMT5Lw6ZI0PR/TgTb83gGW2BD44epryd1XgAsZ7KfBs=
X-Received: by 2002:a17:90a:f305:b0:29d:e004:f8ce with SMTP id
 ca5-20020a17090af30500b0029de004f8cemr4659443pjb.6.1711332159386; Sun, 24 Mar
 2024 19:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAd53p52fi_wr3Js9Rqct+i1D3rjrnVZ6tBN=uHqThM7UvzXQA@mail.gmail.com>
 <20240322164311.GA1367151@bhelgaas>
In-Reply-To: <20240322164311.GA1367151@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 25 Mar 2024 10:02:27 +0800
Message-ID: <CAAd53p53NjYsYctrb6oknXVTMEq919nfVvrK17EBXwsGCxvtbA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: GL975x: Mask rootport's replay
 timer timeout during suspend
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, Ben Chuang <benchuanggli@gmail.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 12:43=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Thu, Mar 21, 2024 at 06:05:33PM +0800, Kai-Heng Feng wrote:
> > On Sat, Jan 20, 2024 at 6:41=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Thu, Jan 18, 2024 at 02:40:50PM +0800, Kai-Heng Feng wrote:
> > > > On Sat, Jan 13, 2024 at 1:37=E2=80=AFAM Bjorn Helgaas <helgaas@kern=
el.org> wrote:
> > > > > On Fri, Jan 12, 2024 at 01:14:42PM +0800, Kai-Heng Feng wrote:
> > > > > > On Sat, Jan 6, 2024 at 5:19=E2=80=AFAM Bjorn Helgaas <helgaas@k=
ernel.org> wrote:
> > > > > > > On Thu, Dec 21, 2023 at 11:21:47AM +0800, Kai-Heng Feng wrote=
:
> > > > > > > > Spamming `lspci -vv` can still observe the replay timer tim=
eout error
> > > > > > > > even after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750=
: Mask the
> > > > > > > > replay timer timeout of AER"), albeit with a lower reproduc=
e rate.
> > > > > > >
> > > > > > > I'm not sure what this is telling me.  By "spamming `lspci -v=
v`, do
> > > > > > > you mean that if you run lspci continually, you still see Rep=
lay Timer
> > > > > > > Timeout logged, e.g.,
> > > > > > >
> > > > > > >   CESta:        ... Timeout+
> > > > > >
> > > > > > Yes it's logged and the AER IRQ is raised.
> > > > >
> > > > > IIUC the AER IRQ is the important thing.
> > > > >
> > > > > Neither 015c9cbcf0ad nor this patch affects logging in
> > > > > PCI_ERR_COR_STATUS, so the lspci output won't change and mentioni=
ng it
> > > > > here doesn't add useful information.
> > > >
> > > > You are right. That's just a way to access config space to reproduc=
e
> > > > the issue.
> > >
> > > Oh, I think I completely misunderstood you!  I thought you were sayin=
g
> > > that suspending the device caused the PCI_ERR_COR_REP_TIMER error, an=
d
> > > you happened to see that it was logged when you ran lspci.
> >
> > Both running lspci and suspending the device can observe the error,
> > because both are accessing the config space.
> >
> > > But I guess you mean that running lspci actually *causes* the error?
> > > I.e., lspci does a config access while we're suspending the device
> > > causes the error, and the config access itself causes the error, whic=
h
> > > causes the ERR_COR message and ultimately the AER interrupt, and that
> > > interrupt prevents the system suspend.
> >
> > My point was that any kind of PCI config access can cause the error.
> > Using lspci is just make the error more easier to reproduce.
> >
> > > If that's the case, I wonder if this is a generic problem that could
> > > happen with *any* device, not just GL975x.
> >
> > For now, it's just GL975x.
> >
> > > What power state do we put the GL975x in during system suspend?
> > > D3hot?  D3cold?  Is there anything that prevents config access while
> > > we suspend it?
> >
> > The target device state is D3hot.
> > However, the issue happens when the devices is in D0, when the PCI
> > core is saving the device's config space.
> >
> > So I think the issue isn't related to the device state.
> >
> > > We do have dev->block_cfg_access, and there's a comment that says
> > > "we're required to prevent config accesses during D-state
> > > transitions," but I don't see it being used during D-state
> > > transitions.
> >
> > Yes, there isn't any D-state change happens here.
>
> So the timeout happens sometimes on any config accesses to the device,
> no matter what the power state is?

Yes.

> If that's the case, why do the
> masking in the suspend/resume callbacks?

Because there's no functional impact when the error happens, other
than suspend/resume.

>
> If it's not related to a power state change, it sounds like something
> that should be a quirk or done at probe time.

Sure, I'll change that to be done at probe time.

Kai-Heng

>
> Bjorn

