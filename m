Return-Path: <linux-kernel+bounces-160453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1200A8B3DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754C3B23319
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D2B15B978;
	Fri, 26 Apr 2024 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fcfc30Nr"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D4515B0FB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714151622; cv=none; b=cQMPMNRoipPI9e1/cNl6ZyplMpAqdxWmjlnBbbUQXMIs1LUuN/ytpKcEFCenvQ9q/SEQeVY/PosXKt3AxwQmnkbcDH2kaqLdiNiw3ni4BiltRR+4htX2AelK6GQ1AMhVVM/AVtkmLuq44no1flw/fpRNWgvwB/jEHKq/EqBCSJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714151622; c=relaxed/simple;
	bh=ZymaXvXNkT3MzkG4xrsUcsKIpaYC8/DjG6EPBxwKQ2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfpPTpcWr5ruObKi4jPge69gT/cCemu7HpbTeFccEPQc01gEBP8LYpzJnVc8nwZv2eFB0epdgXC37n24AXHRYxVv+eVxZSR9Cd5/TcqXwqKiPRLZPeuyQxY4IL0KkU5omwn9ZxYkdcLOaeLhtynIhi8UXFlMzjA8s2J6W6C8nRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fcfc30Nr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso355a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714151619; x=1714756419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8M+A6yS65de2kuu5SrHsE8TW+6iIPZa48ZOoxyEAbPY=;
        b=Fcfc30Nr0CNUwk9FQoMsYbTPajO4ENCV80kDWpCyNqN8l88pDh4loRDuKiFrcsr1xH
         9jTG744u1rhwTpY5NnRH+J7DLxWlBHOg0z+hKAqA/+ux5jy7WSAFub6tILo/lvgd1Tit
         g8n5rkO6+OUiIECiegMmkMazxYKTpwLgW/42o9YGswbYw5Ns7qRmEPY6vBd1RKClqZRY
         dM83ucKVEdhqYCs8G4zkiR2XVDJu33S+4ECxYvntzlqGMhp8ordZcnrei4xuf8j8u6e2
         +cSC2kkz9DIoIXWxg6XBNQbJpaahEnH4lgczpzbjj+fbqbv0vlvMPFTAP9fbM1VWGvLD
         MzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714151619; x=1714756419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8M+A6yS65de2kuu5SrHsE8TW+6iIPZa48ZOoxyEAbPY=;
        b=Ezdcrk8H6iwJXvuvIKoDfPJNtmUJ7OjegbZqwGKUSG+HhpK2VNDZ9nqkG7RTENeL4V
         2vVDY8//fzevhx9YMZZd3DYPzc2JD6egkYSMoKa3tVQzrFZ5JViwI7u1QCWicKE6dkFr
         a2L0mJDooliaJfqh59ZSNjMSOnY9jKg3pi36ZcPQIHzJRilSjFFgDuadxBeNa8Xrdnr7
         LJhm+j+8a66GaD8963qE3VX6H/JarUZkCXIGZIwwyGSWJ0KVuGBlPIFV3KG+FDpUjTY3
         wS1GTZhAZpZFohrgyWxbq4umRJ19qFCMt+JmzP2Pv6DEf3FnxhpTsCcOiZj5cCLT2lEl
         +lZg==
X-Forwarded-Encrypted: i=1; AJvYcCWr/iZVoPAb9IQvYSsAZ/YEKcm0eDyTNcbIEFpnMczxcaRkbHYIV5v3pohIrMqd+ANxKmFAeWpgzG7LBIAjRRsdx826C2+E/pxjkUuB
X-Gm-Message-State: AOJu0YxXQ1s0f8bFrNHwaAOjcHsXD809LZH3qLvWprN3E5MHbuBOv+DG
	vzZh0kGahaD8gEOLBmvbBNyRNG1YUk66VM9pyNpxWuKKhd9N+dXUTIbDWWIzTJ7koDyVKaNN3cI
	eV56hGry/VGu8W2voIMUzjBZ3SczpCYHuR2ob
X-Google-Smtp-Source: AGHT+IGsHmt7lJnNnIXuBzRD+sIzjGa7+9dIZFy46+H8i0QT1T3BQ0lJYE2v2KzOjK2ZYfp2u/4YpQ5rSJxT8KvoGYw=
X-Received: by 2002:a05:6402:5203:b0:572:1486:452 with SMTP id
 s3-20020a056402520300b0057214860452mr214537edd.1.1714151619176; Fri, 26 Apr
 2024 10:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321215622.3396410-2-aruna.ramakrishna@oracle.com>
 <20240425210540.3265342-1-jeffxu@chromium.org> <7054B528-C603-4EAC-B48D-784480DFE4B6@oracle.com>
 <CALmYWFsW5XcM8PYwd=SCthfgjC3TxqVz=DjnCuV8TU7k+_jLaQ@mail.gmail.com>
 <CABi2SkVvGWa0=Q9AEkTGAr6f_hZ54Ekrxw5CdgvrRKWtNPNkng@mail.gmail.com> <d0162c76c25bc8e1c876aebe8e243ff2e6862359.camel@intel.com>
In-Reply-To: <d0162c76c25bc8e1c876aebe8e243ff2e6862359.camel@intel.com>
From: Jeff Xu <jeffxu@google.com>
Date: Fri, 26 Apr 2024 10:13:00 -0700
Message-ID: <CALmYWFtnquTxBP+072xy1iTK+Qb-YKJ8iwarvQMiGApT9=P8Jw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "jeffxu@chromium.org" <jeffxu@chromium.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"jannh@google.com" <jannh@google.com>, 
	"andrew.brownsword@oracle.com" <andrew.brownsword@oracle.com>, 
	"matthias.neugschwandtner@oracle.com" <matthias.neugschwandtner@oracle.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, 
	"aruna.ramakrishna@oracle.com" <aruna.ramakrishna@oracle.com>, 
	"sroettger@google.com" <sroettger@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"keescook@chromium.org" <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 9:33=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Fri, 2024-04-26 at 09:13 -0700, Jeff Xu wrote:
> > > > I=E2=80=99m wary about reordering anything here. Also, this code is=
 not aware of
> > > > the altstack permissions. I=E2=80=99m wondering if wrpkru(0) is nee=
ded here too.
> > > >
> > > We can't change PKRU after restore_sigcontext,  the calling thread
> > > would have PKRU 0, not the original PKRU from before handling the
> > > signal.
> >
> > probably putting restore_altstack ahead of restore_sigcontext would be
> > good enough.
> > restore_altstack doesn't seem to need to be after restore_sigcontex,
> > it reads data
> > from the sigframe and calls do_sigaltstack to update the current struct=
.
>
> Just was CCed, and haven't reviewed the whole thread.
>
> But I hit an issue with the ordering in setting up a signal frame. I note=
d that
> the ordering in sigreturn was potentially wrong in the same way:
> https://lore.kernel.org/lkml/20231107182251.91276-1-rick.p.edgecombe@inte=
l.com/
>
> It might be useful analysis.

Great! so it is already noticed. It can be fixed in this patch set.

