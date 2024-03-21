Return-Path: <linux-kernel+bounces-109881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807A4885713
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6D20B22095
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE6855E75;
	Thu, 21 Mar 2024 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PHl8whJM"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690028DCB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711015558; cv=none; b=Kl3Hwr5aROXATa6fkRS+8wGmEENtrSx5i/11tyH+s76bfwTO1FQ22oi/viblmFAXfugriUTLgGp4odB7rPn3r7llDT2vc9Bv3kM09SPAJB77QZiF6GsCEIn8OFMS3qWjQkac2Jk8p8R2NvAzesluHG6JEptFeJUBEeZwwN6OZn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711015558; c=relaxed/simple;
	bh=b+rciItgQ63I1Dae55rZN3j6shbZla46y8wJCZTU0VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rg2+r/NpD7gVdW88NP3x7GlBu9e8zNQ51L9n1g6sYgQSbtNu1rqrbo7uzrS2urhK+vWXvjxk6/FnoKztPYgrmLgFoa38oyujdAh/WNbyjVpE1lyF3mL3jbJm34FRkeswwq4wgSs4X4ZOiCH97a9EiZX9EpCFrMREpBpBNhhkUx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PHl8whJM; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2D8703F5D7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711015547;
	bh=e84nSgZoWpw76jwjDEWwNR7Z6OMjBRZ4GtKdgKTzihs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=PHl8whJMHQY9xPCcCOega4Y4EIaqZ0ha5XaLdF9ggddndAQ6TWvXcZKl8IP2sFO3x
	 W5VmnpFwqqZD/hsELo7Pu8vj6VpBhZpzSKYCwDuuM6LdIQkYZVXeoeWDwt5gI5o2kW
	 Vc/VtXAGKj0r5NnaL9d4Z/vw0cIJ/++FwulpFQhz1T1Ok7KAN8qcLXrGw8+OK9bD2z
	 6pinBgxZjtqGDqWGZCwoSoeF2HIJgKuk+if8zIoNt0YNSIg+FLR6PpOBsE4QyNNsth
	 6fUJiZTis6DHGm7vnl+P3DN6icyNWwhG+8CMi20ioEyuLVDRW4yfmRiCC1Wm3LNFhC
	 wsBA+0xipQSFA==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29b8f702cbfso593718a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711015545; x=1711620345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e84nSgZoWpw76jwjDEWwNR7Z6OMjBRZ4GtKdgKTzihs=;
        b=EWkSwNigvF6y8wttgsCrywAsyzVUJZjvkh95Fht8VBKjM9TVsOVs41hTED/Lnct6/6
         MkQG0dN1Khr0zqQcbS9+zRRIMbtUE3oPT4POF2GpPZN97R9qLvl7VUzOjNucD4hWBjZ2
         hl/n5Oh3YIvU1DAVHEJ/lyfFuI/SCZ3IdwihcmQl1Z0YM7onQ3b5y4LHcGT6f0PsXYYP
         RU0xdV1JPY20wnIX4WxxjPkMQEOZyTjtCePtlhXo0IWtAqFEZsHDqUx8H9ypyUM6WnMY
         W0FrGt6bmUph4xTM4OjaLlnUBJFB4kVjDr8LZiYRm8xoJPIgXUJR6HxGhf0au632Wn8e
         P0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUMSyms4obBdtjqEuC7CLBMgm3GeBuklHNH1xV04tCMtLfhE0jiYXkkjbKk+JHi7xVm2BUycB4dZ6/ITrVRxscVFhnzPjT3/r9Zw5jW
X-Gm-Message-State: AOJu0YyTjgUPY30CLATRfexnKNJRFzA9af87YXeQ02YwikCo9gdU6uvR
	aZlG0oUTg4ws9GsWobkVWThfERrvkYmiM0+Ma5kbB0Ir/8H5q4xdMjC8FvIEz8pXfdPy7uHXrXK
	U3FuSzcIDIvFM9K/+fqZ3bUYX/0xHImrjtKIOP7B1YgprVjVR3AsnJpnD8C2Ilx0ikCE+AVGgZ8
	bFaEabgCRpANQjjC1g4Qhn7f5A9rROIUcGWe/h2xvqLURIUQP9yzG6
X-Received: by 2002:a17:90a:bf06:b0:2a0:2113:cc0a with SMTP id c6-20020a17090abf0600b002a02113cc0amr1043395pjs.23.1711015545631;
        Thu, 21 Mar 2024 03:05:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvBvGXaXr0P5krxIvz8tQQaSdycxIth7mnlhCsjV2v5phh35HrXd5sbHMNMt9wjyHtuxnggObbV1Fkd7tkpWw=
X-Received: by 2002:a17:90a:bf06:b0:2a0:2113:cc0a with SMTP id
 c6-20020a17090abf0600b002a02113cc0amr1043368pjs.23.1711015545196; Thu, 21 Mar
 2024 03:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAd53p6qE76QjJmjr5ei0mU8xcSNE32hJMOE9Frwz-BuC3gDkA@mail.gmail.com>
 <20240119224053.GA187501@bhelgaas>
In-Reply-To: <20240119224053.GA187501@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 21 Mar 2024 18:05:33 +0800
Message-ID: <CAAd53p52fi_wr3Js9Rqct+i1D3rjrnVZ6tBN=uHqThM7UvzXQA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: GL975x: Mask rootport's replay
 timer timeout during suspend
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, Ben Chuang <benchuanggli@gmail.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Sorry for the belated response.

On Sat, Jan 20, 2024 at 6:41=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Jan 18, 2024 at 02:40:50PM +0800, Kai-Heng Feng wrote:
> > On Sat, Jan 13, 2024 at 1:37=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Fri, Jan 12, 2024 at 01:14:42PM +0800, Kai-Heng Feng wrote:
> > > > On Sat, Jan 6, 2024 at 5:19=E2=80=AFAM Bjorn Helgaas <helgaas@kerne=
l.org> wrote:
> > > > > On Thu, Dec 21, 2023 at 11:21:47AM +0800, Kai-Heng Feng wrote:
> > > > > > Spamming `lspci -vv` can still observe the replay timer timeout=
 error
> > > > > > even after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Ma=
sk the
> > > > > > replay timer timeout of AER"), albeit with a lower reproduce ra=
te.
> > > > >
> > > > > I'm not sure what this is telling me.  By "spamming `lspci -vv`, =
do
> > > > > you mean that if you run lspci continually, you still see Replay =
Timer
> > > > > Timeout logged, e.g.,
> > > > >
> > > > >   CESta:        ... Timeout+
> > > >
> > > > Yes it's logged and the AER IRQ is raised.
> > >
> > > IIUC the AER IRQ is the important thing.
> > >
> > > Neither 015c9cbcf0ad nor this patch affects logging in
> > > PCI_ERR_COR_STATUS, so the lspci output won't change and mentioning i=
t
> > > here doesn't add useful information.
> >
> > You are right. That's just a way to access config space to reproduce
> > the issue.
>
> Oh, I think I completely misunderstood you!  I thought you were saying
> that suspending the device caused the PCI_ERR_COR_REP_TIMER error, and
> you happened to see that it was logged when you ran lspci.

Both running lspci and suspending the device can observe the error,
because both are accessing the config space.

>
> But I guess you mean that running lspci actually *causes* the error?
> I.e., lspci does a config access while we're suspending the device
> causes the error, and the config access itself causes the error, which
> causes the ERR_COR message and ultimately the AER interrupt, and that
> interrupt prevents the system suspend.

My point was that any kind of PCI config access can cause the error.
Using lspci is just make the error more easier to reproduce.

>
> If that's the case, I wonder if this is a generic problem that could
> happen with *any* device, not just GL975x.

For now, it's just GL975x.

>
> What power state do we put the GL975x in during system suspend?
> D3hot?  D3cold?  Is there anything that prevents config access while
> we suspend it?

The target device state is D3hot.
However, the issue happens when the devices is in D0, when the PCI
core is saving the device's config space.

So I think the issue isn't related to the device state.

>
> We do have dev->block_cfg_access, and there's a comment that says
> "we're required to prevent config accesses during D-state
> transitions," but I don't see it being used during D-state
> transitions.

Yes, there isn't any D-state change happens here.

Kai-Heng

>
> Also, it doesn't seem suitable for preventing config accesses during
> suspend because pci_wait_cfg() just busy-waits and never returns an
> error.
>
> Bjorn

