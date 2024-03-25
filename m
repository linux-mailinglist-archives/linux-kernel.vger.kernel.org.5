Return-Path: <linux-kernel+bounces-117761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AACC88AF33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9D51C61676
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D945C107A9;
	Mon, 25 Mar 2024 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWP1T6dD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145FADDBC;
	Mon, 25 Mar 2024 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393338; cv=none; b=H6oY03KHmZx+pR7wRcTC5B53rPlYzbqj4rL3gcazgNSb8TycY8qy/ZHvvUt+NH5k8uKsH/gR9MAxWHu/wJRPZAB0pR+ggPHB//AqpQ/l4fOyxSS+A7MRgM9TgQtI55BaaHl8SZDHHR+k1DcgcQSiiZt8+4GytCUSF1H8eDb1rEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393338; c=relaxed/simple;
	bh=GLL++iIYDEWpgztGZ5piaYOxhSeKwTJJ0ra4vN2sXR8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C/Ksqy63nDMEJrLYq7nxeuhJwcPp0AcYwyH2keF30q4Jcp3vLxzITGvHeGHrOLInsIJrpMz9lSyRfNHAv9hdyF1syAFkL82kEAdzEyurgzJSOSxXnYgiEus7bTTUZtrRf9c3Bg2EI+tIoJLapW3N0gEFSWoGaxSgehHiTb2zBWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWP1T6dD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42A2C433C7;
	Mon, 25 Mar 2024 19:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711393337;
	bh=GLL++iIYDEWpgztGZ5piaYOxhSeKwTJJ0ra4vN2sXR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OWP1T6dD58yWsqJfiVwxEwcWwcEng+TbnXwAymG/8evfTUKba/BMjS3oDSrVYwODW
	 WZv4QENXh9gB16A3bH8F1xvBkMQHqIx+SU6NGyEwXjWtOUxQ/8qRkf2HUp8lOnquVA
	 jIiKg+AiQeUadVuUB9AEp4f5iLmvbgprJrMoQ2E4rC120V96AoYGfUUv14NJbTrn3y
	 Vqvl3CEhBGiNHgPkHZsZcjSjfo2L7ur/r7JmuZEsmw97z7vNWw/aGxRdxQXghdVn7X
	 pZyheFUPFew88xhkryjRcD4SnH2CpVeVTRAoXEyUtLKaOjGLNy3yb0bH+aGs+bLjbK
	 4KnQ61SGv2rrQ==
Date: Mon, 25 Mar 2024 14:02:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ben Chuang <benchuanggli@gmail.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: GL975x: Mask rootport's replay
 timer timeout during suspend
Message-ID: <20240325190216.GA1445191@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p53NjYsYctrb6oknXVTMEq919nfVvrK17EBXwsGCxvtbA@mail.gmail.com>

On Mon, Mar 25, 2024 at 10:02:27AM +0800, Kai-Heng Feng wrote:
> On Sat, Mar 23, 2024 at 12:43 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Mar 21, 2024 at 06:05:33PM +0800, Kai-Heng Feng wrote:
> > > On Sat, Jan 20, 2024 at 6:41 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Thu, Jan 18, 2024 at 02:40:50PM +0800, Kai-Heng Feng wrote:
> > > > > On Sat, Jan 13, 2024 at 1:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Fri, Jan 12, 2024 at 01:14:42PM +0800, Kai-Heng Feng wrote:
> > > > > > > On Sat, Jan 6, 2024 at 5:19 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > On Thu, Dec 21, 2023 at 11:21:47AM +0800, Kai-Heng Feng wrote:
> > > > > > > > > Spamming `lspci -vv` can still observe the replay timer timeout error
> > > > > > > > > even after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the
> > > > > > > > > replay timer timeout of AER"), albeit with a lower reproduce rate.
> > > > > > > >
> > > > > > > > I'm not sure what this is telling me.  By "spamming `lspci -vv`, do
> > > > > > > > you mean that if you run lspci continually, you still see Replay Timer
> > > > > > > > Timeout logged, e.g.,
> > > > > > > >
> > > > > > > >   CESta:        ... Timeout+
> > > > > > >
> > > > > > > Yes it's logged and the AER IRQ is raised.
> > > > > >
> > > > > > IIUC the AER IRQ is the important thing.
> > > > > >
> > > > > > Neither 015c9cbcf0ad nor this patch affects logging in
> > > > > > PCI_ERR_COR_STATUS, so the lspci output won't change and mentioning it
> > > > > > here doesn't add useful information.
> > > > >
> > > > > You are right. That's just a way to access config space to reproduce
> > > > > the issue.
> > > >
> > > > Oh, I think I completely misunderstood you!  I thought you were saying
> > > > that suspending the device caused the PCI_ERR_COR_REP_TIMER error, and
> > > > you happened to see that it was logged when you ran lspci.
> > >
> > > Both running lspci and suspending the device can observe the error,
> > > because both are accessing the config space.
> > >
> > > > But I guess you mean that running lspci actually *causes* the error?
> > > > I.e., lspci does a config access while we're suspending the device
> > > > causes the error, and the config access itself causes the error, which
> > > > causes the ERR_COR message and ultimately the AER interrupt, and that
> > > > interrupt prevents the system suspend.
> > >
> > > My point was that any kind of PCI config access can cause the error.
> > > Using lspci is just make the error more easier to reproduce.
> > >
> > > > If that's the case, I wonder if this is a generic problem that could
> > > > happen with *any* device, not just GL975x.
> > >
> > > For now, it's just GL975x.
> > >
> > > > What power state do we put the GL975x in during system suspend?
> > > > D3hot?  D3cold?  Is there anything that prevents config access while
> > > > we suspend it?
> > >
> > > The target device state is D3hot.
> > > However, the issue happens when the devices is in D0, when the PCI
> > > core is saving the device's config space.
> > >
> > > So I think the issue isn't related to the device state.
> > >
> > > > We do have dev->block_cfg_access, and there's a comment that says
> > > > "we're required to prevent config accesses during D-state
> > > > transitions," but I don't see it being used during D-state
> > > > transitions.
> > >
> > > Yes, there isn't any D-state change happens here.
> >
> > So the timeout happens sometimes on any config accesses to the device,
> > no matter what the power state is?
> 
> Yes.
> 
> > If that's the case, why do the
> > masking in the suspend/resume callbacks?
> 
> Because there's no functional impact when the error happens, other
> than suspend/resume.

Oh, I think I see.  Is this accurate?

  Due to a hardware defect in GL975x, config accesses when ASPM is
  enabled frequently cause Replay Timer Timeouts in the Port leading
  to the device.

  These are Correctable Errors, so the Downstream Port logs it in its
  PCI_ERR_COR_STATUS and, when the error is not masked, sends an
  ERR_COR message upstream.  The message terminates at a Root Port,
  which may generate an AER interrupt so the OS can log it.

  The Correctable Error logging is an annoyance but normally not a
  major issue.  But when the AER interrupt happens during suspend, it
  can prevent the system from suspending.

> > If it's not related to a power state change, it sounds like something
> > that should be a quirk or done at probe time.
> 
> Sure, I'll change that to be done at probe time.

In general, we want to log Correctable Errors because they give an
indication of link integrity.  But I'm guessing that since this is
related to a GL975x defect, the errors occur pretty frequently and on
all systems, so they aren't an indication of poor link quality and
they only break suspend, annoy users, and cause problem reports.

Masking them at suspend time would avoid the suspend/resume problem,
but we would still have the annoying logging and get the problem
reports.

If this is all true, I think masking via a quirk is probably the right
thing.  That way we won't get reports that "lspci causes errors" even
when the sdhci driver is not loaded.

I think we should log a hint in dmesg that we're masking
PCI_ERR_COR_REP_TIMER because the error will still be logged in the
PCI_ERR_COR_STATUS register, and that will be visible via lspci, and a
dmesg hint will save debugging time when people report that.

Bjorn

