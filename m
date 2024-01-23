Return-Path: <linux-kernel+bounces-35603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A4B8393E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB691C22246
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C4F612E0;
	Tue, 23 Jan 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOUCCHvn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545DF60BA7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025348; cv=none; b=h4ayE4WxrzVoDm6ICh1APx0mOi2f5oTpXAuQC/0tanGk2kMYfAOxUqdtqaiZQYbJrtpgHNBlnMmuDtbOKlmpnT+OaBFlHFXITaO87XDrGUcyXkL/4jaqX33DpBbMGbza8v4G/QomD2eUfIWWpxhPVbgfG0usNKG09kuD+PfxUbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025348; c=relaxed/simple;
	bh=szUZSkb5KkY1XXTL2ydXpMJbCb8a3hnlpzYn5FWYKKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmxm+wo/ghL9heSk0d3XrO2KuMuHLLEhrsWSjPMANPDzanky4YS7MP+wyNS/eHudndLsufopYr1wCibqSsYTqJGYNPs+B4+nV9OUmq8RUe15QE3WvlQ4ZoxOFo797RpRQkt0zfT5+GOmTXDoFIbkBUTZSVl41Zd+lP/g/Y+yRto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOUCCHvn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706025345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sCueOm7+YIV1uypCrFlqek9GTnabxDJ4c738N9GAnY4=;
	b=SOUCCHvnNApRSjGpa5hFybVpP72OZck3TbeRZlMRy0hV2tttr0D6g1JupZjqwPgozqRcEk
	9KBjuO6lxFozUCmJ0wHiNI2ZFTGbPq5vqqxy+n2fMa6YDrarCXjGqAUCA2y0OD+ue5J3SA
	EMOvTlxceVglfTPKHp97zebg5FqXI30=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-7_aABfckN5myqxEldXUZsw-1; Tue, 23 Jan 2024 10:55:32 -0500
X-MC-Unique: 7_aABfckN5myqxEldXUZsw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bf7e0c973eso379256339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025323; x=1706630123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCueOm7+YIV1uypCrFlqek9GTnabxDJ4c738N9GAnY4=;
        b=KbFi0hCGzgFmF6aA82v7tKKXTQGnAcoGr4VpaMmzVCVxkaBpl7zp+vcEqWrrOMl79+
         PUcb5tXWXSV3CBA/unO+OPbKvvTE+hDKFzzDuU94TzxsbV2gOYiBhE0UQOnAOPT5p1yw
         LvMb/hzM2zwTrhMieqKgTVwERw+ugI5uLOMlgKESmjqi0NYCft6PAv3RT0miuBlrtq7R
         qLDK1L0yyDQREkGBOtiMhGfhaZNdCflBAQUL1xHZ+1qFYrzOIQK/ek9qyZmzsgzWMojT
         sG0k7OPoMBaKxDwG2fnU3BSGMpAlHrxFtruj4ezFtgZ8JVP88ZWS9L4EDrG7n1vdVZC7
         6ABw==
X-Gm-Message-State: AOJu0YyYo17hmIcrlFttnE5GNgD86pfKRDA51VE0fEXQR8U65EsGGVTx
	1WzEXrL5MPFYas5Gfw8JX03XFziqjILzahVCl01DXGGrZ41nJJVPwI83546gKrWKUssAc46+6fd
	FnpsqabYpbobiAzGRXBO6XC8vWAIZo1rhIfne08ibZ9DCC5fcWQVuJ98Xh0XWsA==
X-Received: by 2002:a6b:6515:0:b0:7bf:705c:f9cd with SMTP id z21-20020a6b6515000000b007bf705cf9cdmr99561iob.38.1706025323695;
        Tue, 23 Jan 2024 07:55:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH38iCjX+AEd64T4UT/2KKdkE95022H/qcfVu2tE/vKCgVvGn5gfiViiWPx9v0cG2g2zKjB3g==
X-Received: by 2002:a6b:6515:0:b0:7bf:705c:f9cd with SMTP id z21-20020a6b6515000000b007bf705cf9cdmr99549iob.38.1706025323389;
        Tue, 23 Jan 2024 07:55:23 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id x2-20020a029482000000b0046d17aff31bsm3738272jah.157.2024.01.23.07.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:55:22 -0800 (PST)
Date: Tue, 23 Jan 2024 08:55:21 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
 linux-kernel@vger.kernel.org, eric.auger@redhat.com,
 mika.westerberg@linux.intel.com, rafael.j.wysocki@intel.com,
 Sanath.S@amd.com
Subject: Re: [PATCH v2 2/2] PCI: Fix runtime PM race with PME polling
Message-ID: <20240123085521.07e2b978.alex.williamson@redhat.com>
In-Reply-To: <20240123104519.GA21747@wunner.de>
References: <20230803171233.3810944-1-alex.williamson@redhat.com>
	<20230803171233.3810944-3-alex.williamson@redhat.com>
	<20240118115049.3b5efef0.alex.williamson@redhat.com>
	<20240122221730.GA16831@wunner.de>
	<20240122155003.587225aa.alex.williamson@redhat.com>
	<20240123104519.GA21747@wunner.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 11:45:19 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> On Mon, Jan 22, 2024 at 03:50:03PM -0700, Alex Williamson wrote:
> > On Mon, 22 Jan 2024 23:17:30 +0100 Lukas Wunner <lukas@wunner.de> wrote:  
> > > On Thu, Jan 18, 2024 at 11:50:49AM -0700, Alex Williamson wrote:  
> > > > To do that I used pm_runtime_get_if_active(), but in retrospect this
> > > > requires the device to be in RPM_ACTIVE so we end up skipping anything
> > > > suspended or transitioning.    
> > > 
> > > How about dropping the calls to pm_runtime_get_if_active() and
> > > pm_runtime_put() and instead simply do:
> > > 
> > > 			if (pm_runtime_suspended(&pdev->dev) &&
> > > 			    pdev->current_state != PCI_D3cold)
> > > 				pci_pme_wakeup(pdev, NULL);  
> > 
> > Do we require that the polled device is in the RPM_SUSPENDED state?  
> 
> If the device is RPM_SUSPENDING, why immediately resume it for polling?
> It's sufficient to poll it the next time around, i.e. 1 second later.
> 
> Likewise, if it's already RPM_RESUMING or RPM_ACTIVE anyway, no need
> to poll PME.

I'm clearly not an expert on PME, but this is not obvious to me and
before the commit that went in through this thread, PME wakeup was
triggered regardless of the PM state.  I was trying to restore the
behavior of not requiring a specific PM state other than deferring
polling across transition states.

> This leaves RPM_SUSPENDED as the only state in which it makes sense to
> poll.
>
> > Also pm_runtime_suspended() can also only be trusted while holding the
> > device power.lock, we need a usage count reference to maintain that
> > state.  
> 
> Why?  Let's say there's a race and the device resumes immediately after
> we call pm_runtime_suspended() here.  So we might call pci_pme_wakeup()
> gratuitouly.  So what?  No biggie.

The issue I'm trying to address is that config space of the device can
become inaccessible while calling pci_pme_wakeup() on it, causing a
system fault on some hardware.  So a gratuitous pci_pme_wakeup() can be
detrimental.

We require the device config space to remain accessible, therefore the
instantaneous test against D3cold and that the parent bridge is in D0
is not sufficient.  I see traces where the parent bridge is in D0, but
the PM state is RPM_SUSPENDING and the endpoint device transitions to
D3cold while we're executing pci_pme_wakeup().

Therefore at a minimum, I think we need to enforce that the bridge is
in RPM_ACTIVE and remains in that state across pci_pme_wakeup(), which
means we need to hold a usage count reference, and that usage count
reference must be acquired under power.lock in RPM_ACTIVE state to be
effective.

> > +			if (bdev) {
> > +				spin_lock_irq(&bdev->power.lock);  
> 
> Hm, I'd expect that lock to be internal to the PM core,
> although there *are* a few stray users outside of it.

Right, there are.  It's possible that if we only need to hold a
reference on the bridge we can abstract this through
pm_runtime_get_if_active(), the semantics worked better to essentially
open code it in this iteration though.  Thanks,

Alex


