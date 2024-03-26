Return-Path: <linux-kernel+bounces-118271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4FF88B71C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321A32A051A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1953B48CDC;
	Tue, 26 Mar 2024 01:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="KKr8ENhg"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47316282EB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711417967; cv=none; b=oocClNtTaRDk4H9VgHHBxdbWjtmm6ACi/4+XTr+GwMO7djJ4vfLaAFMWRXd4/KKI4v/UyNGgPoXESBrrybDbXTC2VwQhAKsaqaLAl6Slvoozcg5zWfIYDHBIR0qdVN328uz2PWwoYG1bZHosRY8UaOS4BdCG9yKu3D91dDclCnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711417967; c=relaxed/simple;
	bh=kmqIs/1ejhI545XuyVEW9ob4jQH3Rbj5287IN7mw75Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OS310vd/FvH01yDubgm1yPWe8nW6wAVF/0ggu/wqhaPMjFQ9faf//NsrflZO5ckwkfOPnBMMnrpQHRsxz76qWE+m/aecRfGKDKOuEulciLi4JGC1w9tm2I9MPRwgroF4Np3s5Rp26Tk9Y37pvR4aTq9eMbZpE7+IIPnFKAZRmlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=KKr8ENhg; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A2ABC3F628
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711417962;
	bh=H9EHOHwcEXwOlCQEucQXSsYUJ0eKIs5GJypjqxwPz7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=KKr8ENhg5929QrUqEa1i8CL5nEc2g+KagCre8J5lKT0e8Rl2PNf8qLmBVQH8P3Kz1
	 ixdpRS2Oh3fcjf/wbrroBy2HGMsPwlpM0mpOsDawcfNMF9c3Szu4vpKkc3j1diiqAW
	 NYKsR+Z4YX7PgY3ebmr52dwz//1SvKfYNWlbC6NRZO2g72xhSV+XxX95G7Anu16ZUB
	 y3lEAjpHVz2jxX5aKARuR1c17u7k8YPDNE29or0U6RAWZbTEFQoMsu/gCnE+mgpAHC
	 pE7hZlQKXUMdm4dRzlW7db45qgaZVNTIi1YaGzm95wYBnBwFHJCRNtm7Hv/dgHdn/2
	 nviHcavLF9b/A==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5ce67a3f275so2982650a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711417961; x=1712022761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9EHOHwcEXwOlCQEucQXSsYUJ0eKIs5GJypjqxwPz7E=;
        b=R1gYL6TCdX5SNkoeKBMsU06qeI+IxatvfLAr7zf6ehFm8xVGx5PQCzj7kT1ZpkLCUH
         qeiLcfg6Bcvkw/tRTLcbBCglrODfhmgpNHVOZJkUwYhsyNNkGu3MdYmYVMjmTXA/wp7a
         H7ubPaXDhl+nLt+swRsMGtj1+LS5ngaQx3OsGvSW7nhcC/AVSu4BYWY+qYWmivrwOs4M
         A8Eki3h/HnWi0pk3eYedtZRicswNfUfYFw/nGPuTlXz0XClfG+Z1D0yYfDRr41WO7Sow
         s+txJg7fTo5UyVBRrdJ+Vs6lGOhUMGSs/Z2UX+hBDG+LTObjlHWaM8DJ3rhHxs4ef7HF
         E70w==
X-Forwarded-Encrypted: i=1; AJvYcCV7oAwLMiq6iT7g/kho1WVePLRRLbTqs35/JNWOVaA2qNitDzaSktql03+KZZco4DPAjHqiUQCKxlSv9gQpMMRT6jjTQuQsTdr2xGOn
X-Gm-Message-State: AOJu0YxoA+WmXQpoMuVdzUNcXD9lIhlw/gh85aX7cLkDqSxx+ePTlEsW
	6oG3SEsvHI+3J7IpVyBGW1s28kMQAkLSBwFwHsIny2r+zMm3aDuDoCu4i4uuwYBGoKjyisKmOUO
	Ocp3iGYmcI7IRMc7Wc/1K+QEyHHNbDDKeLAGuOwgqB65BU61NmeOckq18bzbzNlRqBCG+BqiZrm
	IVeJIZgwz4z9QKIsmhQl6FXKDxGQgKAbkqAgbQwsdKOEbh4sPqqV7X
X-Received: by 2002:a05:6a20:c220:b0:1a3:463d:e6f1 with SMTP id bt32-20020a056a20c22000b001a3463de6f1mr6586290pzb.22.1711417961306;
        Mon, 25 Mar 2024 18:52:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcaXeQRtlSZfuuNtMri5G5mrnSGH9yi/jYrCARIdvPrsTrrJ72nS+E4iFfcCGLMQcH+cYnP/TyL084NPvtufA=
X-Received: by 2002:a05:6a20:c220:b0:1a3:463d:e6f1 with SMTP id
 bt32-20020a056a20c22000b001a3463de6f1mr6586277pzb.22.1711417960981; Mon, 25
 Mar 2024 18:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAd53p53NjYsYctrb6oknXVTMEq919nfVvrK17EBXwsGCxvtbA@mail.gmail.com>
 <20240325190216.GA1445191@bhelgaas>
In-Reply-To: <20240325190216.GA1445191@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 26 Mar 2024 09:52:28 +0800
Message-ID: <CAAd53p5p=JJ9OOQd=XPzJgW7yib+hMJxZqj7PZFsd2uFtK94xg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: GL975x: Mask rootport's replay
 timer timeout during suspend
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, Ben Chuang <benchuanggli@gmail.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 3:02=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Mon, Mar 25, 2024 at 10:02:27AM +0800, Kai-Heng Feng wrote:
> > On Sat, Mar 23, 2024 at 12:43=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.=
org> wrote:
> > > On Thu, Mar 21, 2024 at 06:05:33PM +0800, Kai-Heng Feng wrote:
> > > > On Sat, Jan 20, 2024 at 6:41=E2=80=AFAM Bjorn Helgaas <helgaas@kern=
el.org> wrote:
> > > > > On Thu, Jan 18, 2024 at 02:40:50PM +0800, Kai-Heng Feng wrote:
> > > > > > On Sat, Jan 13, 2024 at 1:37=E2=80=AFAM Bjorn Helgaas <helgaas@=
kernel.org> wrote:
> > > > > > > On Fri, Jan 12, 2024 at 01:14:42PM +0800, Kai-Heng Feng wrote=
:
> > > > > > > > On Sat, Jan 6, 2024 at 5:19=E2=80=AFAM Bjorn Helgaas <helga=
as@kernel.org> wrote:
> > > > > > > > > On Thu, Dec 21, 2023 at 11:21:47AM +0800, Kai-Heng Feng w=
rote:
> > > > > > > > > > Spamming `lspci -vv` can still observe the replay timer=
 timeout error
> > > > > > > > > > even after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL=
9750: Mask the
> > > > > > > > > > replay timer timeout of AER"), albeit with a lower repr=
oduce rate.
> > > > > > > > >
> > > > > > > > > I'm not sure what this is telling me.  By "spamming `lspc=
i -vv`, do
> > > > > > > > > you mean that if you run lspci continually, you still see=
 Replay Timer
> > > > > > > > > Timeout logged, e.g.,
> > > > > > > > >
> > > > > > > > >   CESta:        ... Timeout+
> > > > > > > >
> > > > > > > > Yes it's logged and the AER IRQ is raised.
> > > > > > >
> > > > > > > IIUC the AER IRQ is the important thing.
> > > > > > >
> > > > > > > Neither 015c9cbcf0ad nor this patch affects logging in
> > > > > > > PCI_ERR_COR_STATUS, so the lspci output won't change and ment=
ioning it
> > > > > > > here doesn't add useful information.
> > > > > >
> > > > > > You are right. That's just a way to access config space to repr=
oduce
> > > > > > the issue.
> > > > >
> > > > > Oh, I think I completely misunderstood you!  I thought you were s=
aying
> > > > > that suspending the device caused the PCI_ERR_COR_REP_TIMER error=
, and
> > > > > you happened to see that it was logged when you ran lspci.
> > > >
> > > > Both running lspci and suspending the device can observe the error,
> > > > because both are accessing the config space.
> > > >
> > > > > But I guess you mean that running lspci actually *causes* the err=
or?
> > > > > I.e., lspci does a config access while we're suspending the devic=
e
> > > > > causes the error, and the config access itself causes the error, =
which
> > > > > causes the ERR_COR message and ultimately the AER interrupt, and =
that
> > > > > interrupt prevents the system suspend.
> > > >
> > > > My point was that any kind of PCI config access can cause the error=
.
> > > > Using lspci is just make the error more easier to reproduce.
> > > >
> > > > > If that's the case, I wonder if this is a generic problem that co=
uld
> > > > > happen with *any* device, not just GL975x.
> > > >
> > > > For now, it's just GL975x.
> > > >
> > > > > What power state do we put the GL975x in during system suspend?
> > > > > D3hot?  D3cold?  Is there anything that prevents config access wh=
ile
> > > > > we suspend it?
> > > >
> > > > The target device state is D3hot.
> > > > However, the issue happens when the devices is in D0, when the PCI
> > > > core is saving the device's config space.
> > > >
> > > > So I think the issue isn't related to the device state.
> > > >
> > > > > We do have dev->block_cfg_access, and there's a comment that says
> > > > > "we're required to prevent config accesses during D-state
> > > > > transitions," but I don't see it being used during D-state
> > > > > transitions.
> > > >
> > > > Yes, there isn't any D-state change happens here.
> > >
> > > So the timeout happens sometimes on any config accesses to the device=
,
> > > no matter what the power state is?
> >
> > Yes.
> >
> > > If that's the case, why do the
> > > masking in the suspend/resume callbacks?
> >
> > Because there's no functional impact when the error happens, other
> > than suspend/resume.
>
> Oh, I think I see.  Is this accurate?
>
>   Due to a hardware defect in GL975x, config accesses when ASPM is
>   enabled frequently cause Replay Timer Timeouts in the Port leading
>   to the device.
>
>   These are Correctable Errors, so the Downstream Port logs it in its
>   PCI_ERR_COR_STATUS and, when the error is not masked, sends an
>   ERR_COR message upstream.  The message terminates at a Root Port,
>   which may generate an AER interrupt so the OS can log it.
>
>   The Correctable Error logging is an annoyance but normally not a
>   major issue.  But when the AER interrupt happens during suspend, it
>   can prevent the system from suspending.

That's totally the case here.

This brings up another different but related topic  - should the port
driver disable AER/DPC IRQ during suspend?
We've discussed this many times, I still think that's the right
approach to "quiesce" many unexpected errors during system state
transition.


>
> > > If it's not related to a power state change, it sounds like something
> > > that should be a quirk or done at probe time.
> >
> > Sure, I'll change that to be done at probe time.
>
> In general, we want to log Correctable Errors because they give an
> indication of link integrity.  But I'm guessing that since this is
> related to a GL975x defect, the errors occur pretty frequently and on
> all systems, so they aren't an indication of poor link quality and
> they only break suspend, annoy users, and cause problem reports.
>
> Masking them at suspend time would avoid the suspend/resume problem,
> but we would still have the annoying logging and get the problem
> reports.
>
> If this is all true, I think masking via a quirk is probably the right
> thing.  That way we won't get reports that "lspci causes errors" even
> when the sdhci driver is not loaded.
>
> I think we should log a hint in dmesg that we're masking
> PCI_ERR_COR_REP_TIMER because the error will still be logged in the
> PCI_ERR_COR_STATUS register, and that will be visible via lspci, and a
> dmesg hint will save debugging time when people report that.

Sure. Where do you think it's a better place to implement the quirk? I
Assume PCI quirk is a better place than driver's probe routine?

Kai-Heng

>
> Bjorn

