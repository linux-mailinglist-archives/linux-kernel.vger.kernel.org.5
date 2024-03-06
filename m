Return-Path: <linux-kernel+bounces-93258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1281872D22
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ABACB25213
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C59DF51;
	Wed,  6 Mar 2024 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tWCV8sVi"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB37D266
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694028; cv=none; b=QsrqECBTHXzAe8YiMOWFjDlJ/jfyjVQAW4olAZ1YCu5IGa4gf2fKH33XqOcyLF0Obenx2xg7oC36aQTYj91ZhXWM84ksGZ82jQMcPYD5UREuztr5kp9R6mhGICGSTZgfjl19znK4TV6P6vc7Bo6MuwwDpw7ePBKUNgWPwhfgp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694028; c=relaxed/simple;
	bh=nWq2RjA6xIKVHD53z5lCOa7DP8gC0ToPNtns2+g4VwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huwR3jRMZBkyk8xC40OaX97RSjwhhYWiXVrrVOlU+OXO4ec7/YwyCEHT+r/TimrvmhSngVdg0cacm6E308ZZBqDE3YGTeL1XDiSnvdhKXgslobZWRN0D9+jVqNH/zRwirCVzQkPSyle3ZxqM1ZIYzsZsHklRjUnLmO9GOZvHj5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tWCV8sVi; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42f024b809cso149861cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 19:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709694025; x=1710298825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDLZzB+bt3GZcs1jFg49I3gbIv3ak3sP4bxpEBluYl4=;
        b=tWCV8sVijyin+gqrzoRSLglZTRHd1rLe1Ahu3So2L8a+3UsACtIpdJOlCc6F97/xiJ
         OExcHbBQ5MC6AaTgs+a6D+/YHrXUGcZzhEtEYzaYF/hvYoPysMx4oS6IQ1U+vGCW/ns9
         QO00sqIwNtdnylYXrFonIBS5uf1RowKxSroeIaMBPgKkR1IcgbgINMOvdFqF42pqzB6L
         lCYOOKwsSUWjA7qd1iy0pjJH01uLD+7alA3saBzD4ynf28zq9FsQhaOF9Krs8z12eizs
         Sil8qsbuz5Z478jiN+lNjhlRqXaQ7OVTlrLVtoccLx6woxHrtBHDHYgOfdUIFc6F7kWo
         fLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709694025; x=1710298825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDLZzB+bt3GZcs1jFg49I3gbIv3ak3sP4bxpEBluYl4=;
        b=imDOwfKlpFR6I56oaC94yi+CWqYdPiArdo81cixjLPxys2dRM9tqqgJOx46ShFG1xM
         TYqpbx6T/azzG77Xv5BmFAJaNjF0sIvPwjOikUMEMA5JDeAFjs8VOTUmpyLWrttDxdLy
         Y2wwq5LDUD7lliOltm4Fl+65UWgw0M0hdRgfbR0EK/T5/Iw3yyuOBkeaeI6SDMhR2YyZ
         i0xs4xPNjTvlgBsFVnWqi6QM4SAU1UyWjROmsNi4PZaUvwynt40HzeN4JcUsgd5vRuRX
         8OnzpPdmh6EAzdL+dYh4UBVQM8DaOyQ7s/WItrQBM6hXcyLyYbdGimjWe05sTZUHoH92
         hW+w==
X-Forwarded-Encrypted: i=1; AJvYcCWSgzgLlBs2+LntkzrV4X4BAo0TCqK7483YwqNdCSCGx1Z//Yr3fw1IKWeF5Ojhygx1SE92uAybOVTLrFpgRUM3QqsbpEGUx4yQyMzT
X-Gm-Message-State: AOJu0Yyv0trrtronCVkqxj6HpBm9DCM+0/QUr2pvTspGsdiuzvt4bFO1
	ux0d7JN87vqRS6VtXddMQLPM2hOS4O35Nayv2jbF58MVoVjIlKVj1aUnDi44ZLeu7qK3/48BHUy
	Sibh5WGzfwsdMpWSuSSHKw3RlZZ6s4p0RCDUE
X-Google-Smtp-Source: AGHT+IFbiQbpmvfWgUpkxWjLJMdlRthJJh/rzASOKXR1l2syMub/sbufMHigAdAk3F+vv22c8tPcls43uGvju6+yl1o=
X-Received: by 2002:a05:622a:5490:b0:42e:e9a3:4a49 with SMTP id
 ep16-20020a05622a549000b0042ee9a34a49mr147815qtb.28.1709694025321; Tue, 05
 Mar 2024 19:00:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229105204.720717-1-herve.codina@bootlin.com>
 <20240229105204.720717-3-herve.codina@bootlin.com> <acb69aa8c1a4c4e9849123ef538b9646a71507a0.camel@gmail.com>
 <20240304152202.GA222088-robh@kernel.org> <20240304174933.7ad023f9@bootlin.com>
 <CAGETcx-tmyJA30GtdU_dO9tWFoK+rO5tm-On4tPR7oQotnMkqQ@mail.gmail.com>
 <2f497783da939f13d8c8faeab931cac0ef9c98eb.camel@gmail.com>
 <20240305112708.56869e4c@bootlin.com> <c2be9a4cbbe6946e2f98a69d915c22bc52c9f1d9.camel@gmail.com>
In-Reply-To: <c2be9a4cbbe6946e2f98a69d915c22bc52c9f1d9.camel@gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 5 Mar 2024 18:59:47 -0800
Message-ID: <CAGETcx9W81JNeqKFJvG_ydGMdBML9SvNMsmoxnCuyKgf2vN89w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] of: overlay: Synchronize of_overlay_remove() with
 the devlink removals
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 2:43=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
>
> On Tue, 2024-03-05 at 11:27 +0100, Herve Codina wrote:
> > Hi Nuno, Saravana, Rob,
> >
> > On Tue, 05 Mar 2024 08:36:45 +0100
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >
> > > On Mon, 2024-03-04 at 22:47 -0800, Saravana Kannan wrote:
> > > > On Mon, Mar 4, 2024 at 8:49=E2=80=AFAM Herve Codina <herve.codina@b=
ootlin.com>
> > > > wrote:
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > On Mon, 4 Mar 2024 09:22:02 -0600
> > > > > Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > ...
> > > > >
> > > > > > > > @@ -853,6 +854,14 @@ static void free_overlay_changeset(str=
uct
> > > > > > > > overlay_changeset *ovcs)
> > > > > > > >  {
> > > > > > > >   int i;
> > > > > > > >
> > > > > > > > + /*
> > > > > > > > +  * Wait for any ongoing device link removals before remov=
ing
> > > > > > > > some of
> > > > > > > > +  * nodes. Drop the global lock while waiting
> > > > > > > > +  */
> > > > > > > > + mutex_unlock(&of_mutex);
> > > > > > > > + device_link_wait_removal();
> > > > > > > > + mutex_lock(&of_mutex);
> > > > > > >
> > > > > > > I'm still not convinced we need to drop the lock. What happen=
s if
> > > > > > > someone else
> > > > > > > grabs the lock while we are in device_link_wait_removal()? Ca=
n we
> > > > > > > guarantee that
> > > > > > > we can't screw things badly?
> > > > > >
> > > > > > It is also just ugly because it's the callers of
> > > > > > free_overlay_changeset() that hold the lock and now we're relea=
sing it
> > > > > > behind their back.
> > > > > >
> > > > > > As device_link_wait_removal() is called before we touch anythin=
g,
> > > > > > can't
> > > > > > it be called before we take the lock? And do we need to call it=
 if
> > > > > > applying the overlay fails?
> > > >
> > > > Rob,
> > > >
> > > > This[1] scenario Luca reported seems like a reason for the
> > > > device_link_wait_removal() to be where Herve put it. That example
> > > > seems reasonable.
> > > >
> > > > [1] - https://lore.kernel.org/all/20231220181627.341e8789@booty/
> > > >
> > >
> > > I'm still not totally convinced about that. Why not putting the check=
 right
> > > before checking the kref in __of_changeset_entry_destroy(). I'll cont=
radict
> > > myself a bit because this is just theory but if we look at pci_stop_d=
ev(),
> > > which
> > > AFAIU, could be reached from a sysfs write(), we have:
> > >
> > > device_release_driver(&dev->dev);
> > > ...
> > > of_pci_remove_node(dev);
> > >     of_changeset_revert(np->data);
> > >     of_changeset_destroy(np->data);
> > >
> > > So looking at the above we would hit the same issue if we flush the q=
ueue in
> > > free_overlay_changeset() - as the queue won't be flushed at all and w=
e could
> > > have devlink removal due to device_release_driver(). Right?
> > >
> > > Again, completely theoretical but seems like a reasonable one plus I'=
m not
> > > understanding the push against having the flush in
> > > __of_changeset_entry_destroy(). Conceptually, it looks the best place=
 to me
> > > but
> > > I may be missing some issue in doing it there?
> >
> > Instead of having the wait called in __of_changeset_entry_destroy() and=
 so
> > called in a loop. I could move this call in the __of_changeset_entry_de=
stroy()
> > caller (without any of_mutex lock drop).
> >
>
> Oh, good catch! At this point all the devlinks removals (related to the
> changeset) should have been queued so yes, we should only need to flush o=
nce.
>
> > So this will look like this:
> > --- 8< ---
> > void of_changeset_destroy(struct of_changeset *ocs)
> > {
> >       struct of_changeset_entry *ce, *cen;
> >
> >       device_link_wait_removal();
> >
> >       list_for_each_entry_safe_reverse(ce, cen, &ocs->entries, node)
> >               __of_changeset_entry_destroy(ce);
> > }
> > --- 8< ---
> >
> > I already tested on my system and it works correctly with
> > device_link_wait_removal() only called from of_changeset_destroy()
> > as proposed.
> >
> > Saravana, Nuno, Rob does it seems ok for you ?

Looks good to me.

-Saravana

> >
>
> It looks good to me...
>
> - Nuno S=C3=A1
> >
>

