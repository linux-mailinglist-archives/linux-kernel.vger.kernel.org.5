Return-Path: <linux-kernel+bounces-151133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A72F8AA983
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3EC1C21778
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07532481BE;
	Fri, 19 Apr 2024 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQYXpb1k"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07502AF16;
	Fri, 19 Apr 2024 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513031; cv=none; b=m6GZoh0k1hmZkWob7W93G87jGhug2nlnl8QfyY/AiZSi2V188qEC04pIOREpDycTTaZI8/ZlTXhTIG67EIQAWDBhgNB/L6L5EzJeji4uEy+25zvh2M4cihYHQlPX1Ga1TTxaQy78fcVRxaTGy1IwwvvN7n/788jw/qXoQF4FPxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513031; c=relaxed/simple;
	bh=IwP5Q2CZtoLD6hOLk/T2CJKuHVjlSaG23PDrcTqomUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOxQ9BxwRrbC6hcZs9nBKQLUV/HpRkPwt4TAbS+Z/QAnaaU2rXaCF/nqy0S8niIh4tqCPtSJMpifhc9HGebKtocipSiNWfrX7cW2AgwV1Agnyan10ua0PJCl3rGds/GUjWgjDyNiX4v8/Gcd7NnatY8KXZHE+zsOYKAkmIGS4xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQYXpb1k; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61ae4743d36so19875367b3.2;
        Fri, 19 Apr 2024 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713513029; x=1714117829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSU5Y3VbJeh45hJUwql0V9IYMZAkub8x03JCZpm2gGg=;
        b=iQYXpb1kWoyEyqHq3gQWCKMqu7lgntEjweMP1r3gPS2n+ojSoOSpTg9yWqOdT4ngIP
         TWwL/ns8g6qxhDNs+fW7oTkpI29gRFaCAW9I5nj52QaoeBetdQpDUC9v8dzvjzbXrZOk
         a7h5BlfFZiUNt8LWuSBEPOncyDZ5jbMcPVDOYnmOlS8/sqV8d6+QC4rfwjX39UiaDVQ6
         wqsrPE1U+UZAh3gk+d1RGHretdhSHIRL/NrHLXRr5tsTKkLZ6kTguPTi2y7/ut6eIsBl
         moL/2h8LAUAfZDjAP2vcLE/oVWclAXJ3y/Ik6gvx8bpV033S7DjBqU1nrnIgmwIyXLwe
         Iarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713513029; x=1714117829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSU5Y3VbJeh45hJUwql0V9IYMZAkub8x03JCZpm2gGg=;
        b=FqTOjzYDCpPF2v5Iy2mBV7kmrH4cfn8YpV6bOcwplf+H37P/XL0NfhB79+fqZD6kx8
         AG2HY1/DscAqfGySfu0pFAP0jB4FnyxtwpaYX1CYdqVRCzmGREEe/69BpdRnmzwASDVr
         +TJDxOS2CUWeNzVOy4QG6W/FvqcJLLKKO/uo77ZZ6++TojpjCbFyEaJl9yY92HkcBnez
         /SVHtD4n9KwCjtzxUcWXbUXghyBKUTar29m4z67ATjnfp3sAL2THvHRrqka88CQanuhT
         i2d5jjvubFNmPO+BjMRSQ1N25WZyxhzCDb/92YIw7LuEpl2Y+PE7fJpg1S2Sh+PFhO4H
         dwxw==
X-Forwarded-Encrypted: i=1; AJvYcCWHVmlwLT50uPHRnrpTo5CQYKUjs8/GMSdGUdyX5udr3Ofbj1hCj70qTlggLCnOBhgM0WK9d9+KfQaGG90EY2OLlKowTfTSdioFKiO1FRDmqpAc2KDlYXSIkmhr1OUVlW4CgjjLFwIpFEA=
X-Gm-Message-State: AOJu0YzHDtd3QexEojZq3mxZqqO9NhrnfME/Q/F2DSCIRS14ED/Qmlnt
	6vZM1BgC9H/P/vXPVwKTvSkEzo+gLcd+eHIcHKMLOOcjt6fZYNpwDz3mUd+LFdaxZ1kv7hfKplz
	eTkixTKfkyPt5+iokN/bxYlnxw/0=
X-Google-Smtp-Source: AGHT+IFjQHVch/EGEw8Lj0yIUwAdtgGagHkwnPrfEadrcXcE/jctm5NT1wWlYtcC3vYWlm5NliWpFryraTYpllWgJgw=
X-Received: by 2002:a05:690c:7207:b0:618:6aa1:a972 with SMTP id
 jl7-20020a05690c720700b006186aa1a972mr1293822ywb.5.1713513028797; Fri, 19 Apr
 2024 00:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com>
 <20240418160652.68df1a86@namcao> <87ttjywxv5.wl-tiwai@suse.de>
 <a7843657-c3f6-4d2e-8c36-5541d4c52956@gmx.de> <878r19voks.wl-tiwai@suse.de>
 <5febb249-1d4d-4ea7-b031-1df4d14620d2@oracle.com> <8734rhvlr2.wl-tiwai@suse.de>
In-Reply-To: <8734rhvlr2.wl-tiwai@suse.de>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Fri, 19 Apr 2024 09:50:17 +0200
Message-ID: <CAMeQTsbEjUyOYDAF-kFwTcovLr+8gHQGa27jPkeeJqmLhwbTag@mail.gmail.com>
Subject: Re: [bug-report] task info hung problem in fb_deferred_io_work()
To: Takashi Iwai <tiwai@suse.de>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, Helge Deller <deller@gmx.de>, 
	Nam Cao <namcao@linutronix.de>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bigeasy@linutronix.de, 
	LKML <linux-kernel@vger.kernel.org>, Vegard Nossum <vegard.nossum@oracle.com>, 
	George Kennedy <george.kennedy@oracle.com>, Darren Kenny <darren.kenny@oracle.com>, 
	chuansheng.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 9:45=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 19 Apr 2024 09:39:09 +0200,
> Harshit Mogalapalli wrote:
> >
> > Hi Takashi,
> >
> > On 19/04/24 12:14, Takashi Iwai wrote:
> > > On Thu, 18 Apr 2024 21:29:57 +0200,
> > > Helge Deller wrote:
> > >>
> > >> On 4/18/24 16:26, Takashi Iwai wrote:
> > >>> On Thu, 18 Apr 2024 16:06:52 +0200,
> > >>> Nam Cao wrote:
> > >>>>
> > >>>> On 2024-04-18 Harshit Mogalapalli wrote:
> > >>>>> While fuzzing 5.15.y kernel with Syzkaller, we noticed a INFO: ta=
sk hung
> > >>>>> bug in fb_deferred_io_work()
> > >>>>
> > >>>> Which framebuffer device are you using exactly? It is possible tha=
t
> > >>>> the problem is with the device driver, not core framebuffer.
> > >>>
> > >>> Note that it was already known that using flush_delayed_work() caus=
ed
> > >>> a problem.  See the thread of the fix patch:
> > >>>     https://lore.kernel.org/all/20230129082856.22113-1-tiwai@suse.d=
e/
> > >>
> > >> Harshit reported the hung tasks with kernel v5.15-stable, and can ev=
en reproduce
> > >> that issue with kernel v6.9-rc4 although it has all of your patches =
from
> > >> that referenced mail thread applied.
> > >> So, what does your statement that "it was already known that it caus=
es problems" exactly mean?
> > >> Can it be fixed? Is someone looking into fixing it?
> > >
> > > My original fix was intentionally with cancel_delayed_work_sync()
> > > because flush_delayed_work() didn't work.  We knew that it'd miss som=
e
> > > last-minute queued change, but it's better than crash, so it was
> > > applied in that way.
> > >
> >
> > Thanks for sharing these details.
> >
> > > Then later on, the commit 33cd6ea9c067 changed cancel_*() to
> > > flush_delayed_work() blindly, and the known problem resurfaced again.
> > >
> >
> > I have reverted that commit, but still could see some other task hung
> > message as shared here on other reply:
> >
> > https://lore.kernel.org/all/d2485cb9-277d-4b8e-9794-02f1efababc9@oracle=
com/
>
> Yes, then it could be a different cause, I suppose.
> The crash with flush_delayed_work() was a real crash, no hanging task,
> IIRC.

Neither cancel_delayed_work_sync() or flush_delayed_work() prevent new
work from being scheduled after they return. But
cancel_delayed_work_sync() at least makes sure the queue is empty so
the problem becomes less apparent.

Could this explain what we're seeing?

>
> Can you reproduce the issue with the latest Linus upstream, too?
>
>
> thanks,
>
> Takashi

