Return-Path: <linux-kernel+bounces-34261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB54883768A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBAE1F27DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1033E111B4;
	Mon, 22 Jan 2024 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2UVqB4I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E1C111A7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963811; cv=none; b=X74UE/bDv2JwfPL/DxbSSrduVhqmIlKu7o4HV7DT5eRCWuxxTOkdxq0tzubDq6FcdpySkz8TUTHl95VtdJthPmSRSSwkYUGydXfhU5iopt8qIrEqJiXIf88BpV9HjuHgHcgv5j/rtdYO8DDIRDaXxdRGjnU1RlJIqu8rNWxY1ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963811; c=relaxed/simple;
	bh=0DmqyN2qzJd7KHdqMTDg8vYx/m/BX1ady2AVpwzlH2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gt/i2W+DKafMgJjazxlQ0z2uWvqFvW6MtKWAxKrZu+vJt+2TdLGNOu2oNYLaA8vI8eZUr3QU6bh+kvnPD2eVSyGUp81Pu4gxCb3vYWXDP8JC/Pg5PhI/0OY8TZ2qjMkfLBbR2q2LlzvlHXRNa96nNcwWtrTbecVHDJz1ad6ssxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I2UVqB4I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705963808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVVeXL5qmLu3TdV98EN624/Dnbva2hL9Ll9ny/kn3/A=;
	b=I2UVqB4IYkFHMe2e3QAGpRdZdQwFqzswAqWpW0QahM49KtPxIcij8Sau5R6/M6TdTMKzjd
	pnsKSIFtl7qgSWTbu8iO7dhHgnhlb5NVbrm81XwbBTi0XWrzpaKU5ZBIj9jAW0Ur7VxUVN
	Bk9Dxc5JoN2kWJRCZ5naDbVpeTsPNSo=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-lZHTy9h5PzO1llTO95VeSQ-1; Mon, 22 Jan 2024 17:50:07 -0500
X-MC-Unique: lZHTy9h5PzO1llTO95VeSQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bf7e0c973eso302646839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:50:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705963806; x=1706568606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVVeXL5qmLu3TdV98EN624/Dnbva2hL9Ll9ny/kn3/A=;
        b=MxtPh+UJoo1i5NFr0+LbF0urYOk6ODKnDCT6wHRoWhntCjeniZXedhzVR18GDiYBip
         a0HDL1m22SKlcL1TYJGPJtZ1toORp4Ug7iaN3Jg2/R9O2/jy4mfjJ8ZL3yIlPvivePuC
         XsHxpQ2eyuIRyCb8+ysQtpHmX9khglltiXMAUr1EroCKuiA0o5RSp9BuDYe0BoHdPb5q
         a3j1CMlgpzDelA+X11dgNhNZj3LEmfdwOkd36aGrWEQpdeRJpSXv/yPQHRFThVMumjDX
         0svPtuYAQb4roTRTH89BgieQAKNfd7deYgPmDlbXkTBMm+DBi+9WX/+aLE7gFeMc7Roe
         YSDA==
X-Gm-Message-State: AOJu0Yy/itUWTsvI+E1WyqL9ZQII6vs9SeNE3SRzjieon4bXldeHLIYY
	Hk1IObp0jTeswkT5VsNJWoFfGCiUENy5N+w5eunTz2LeuUMYBs3P3h7pJxqPKy2xouPsSKkWdkN
	AUxt4VP7IqA9RZUKnbm34tDuKU8EeNvU3ivbns+ERW4UWugK65Jjgx1w6/KkdVw==
X-Received: by 2002:a6b:6915:0:b0:7be:de5e:b62f with SMTP id e21-20020a6b6915000000b007bede5eb62fmr5147586ioc.35.1705963805866;
        Mon, 22 Jan 2024 14:50:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENSbToaby3ajpkurTOZkthuOENTMixweGS3HCdmResnrfwS/+Ukg/a8tOI1QELS/0DFJbyXw==
X-Received: by 2002:a6b:6915:0:b0:7be:de5e:b62f with SMTP id e21-20020a6b6915000000b007bede5eb62fmr5147574ioc.35.1705963805574;
        Mon, 22 Jan 2024 14:50:05 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id t17-20020a056602181100b007bf9a6363f4sm526582ioh.6.2024.01.22.14.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 14:50:04 -0800 (PST)
Date: Mon, 22 Jan 2024 15:50:03 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
 linux-kernel@vger.kernel.org, eric.auger@redhat.com,
 mika.westerberg@linux.intel.com, rafael.j.wysocki@intel.com,
 Sanath.S@amd.com
Subject: Re: [PATCH v2 2/2] PCI: Fix runtime PM race with PME polling
Message-ID: <20240122155003.587225aa.alex.williamson@redhat.com>
In-Reply-To: <20240122221730.GA16831@wunner.de>
References: <20230803171233.3810944-1-alex.williamson@redhat.com>
	<20230803171233.3810944-3-alex.williamson@redhat.com>
	<20240118115049.3b5efef0.alex.williamson@redhat.com>
	<20240122221730.GA16831@wunner.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 23:17:30 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> On Thu, Jan 18, 2024 at 11:50:49AM -0700, Alex Williamson wrote:
> > On Thu,  3 Aug 2023 11:12:33 -0600 Alex Williamson <alex.williamson@redhat.com wrote:  
> > > Testing that a device is not currently in a low power state provides no
> > > guarantees that the device is not immenently transitioning to such a state.
> > > We need to increment the PM usage counter before accessing the device.
> > > Since we don't wish to wake the device for PME polling, do so only if the
> > > device is already active by using pm_runtime_get_if_active().
> > > 
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > ---
> > >  drivers/pci/pci.c | 23 ++++++++++++++++-------
> > >  1 file changed, 16 insertions(+), 7 deletions(-)  
> > 
> > Resurrecting this patch (currently commit d3fcd7360338) for discussion
> > as it's been identified as the source of a regression in:
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=218360
> > 
> > Copying Mika, Lukas, and Rafael as it's related to:
> > 
> > 000dd5316e1c ("PCI: Do not poll for PME if the device is in D3cold")
> > 
> > where we skip devices in D3cold when processing the PME list.
> > 
> > I think the issue in the above bz is that the downstream TB3/USB4 port
> > is in D3 (presumably D3hot) and I therefore infer the device is in state
> > RPM_SUSPENDED.  This commit is attempting to make sure the device power
> > state is stable across the call such that it does not transition into
> > D3cold while we're accessing it.
> > 
> > To do that I used pm_runtime_get_if_active(), but in retrospect this
> > requires the device to be in RPM_ACTIVE so we end up skipping anything
> > suspended or transitioning.  
> 
> How about dropping the calls to pm_runtime_get_if_active() and
> pm_runtime_put() and instead simply do:
> 
> 			if (pm_runtime_suspended(&pdev->dev) &&
> 			    pdev->current_state != PCI_D3cold)
> 				pci_pme_wakeup(pdev, NULL);

Hi Lukas,

Do we require that the polled device is in the RPM_SUSPENDED state?
Also pm_runtime_suspended() can also only be trusted while holding the
device power.lock, we need a usage count reference to maintain that
state.

I'm also seeing cases where the bridge is power state D0, but PM state
RPM_SUSPENDING, so config space of the polled device becomes
inaccessible even while we're holding a reference once we allow polling
in RPM_SUSPENDED.

I'm currently working with the below patch, which I believe addresses
all these issues, but I'd welcome review and testing. Thanks,

Alex

commit 0a063b8e91d0bc807db712c81c8b270864f99ecb
Author: Alex Williamson <alex.williamson@redhat.com>
Date:   Tue Jan 16 13:28:33 2024 -0700

    PCI: Fix active state requirement in PME polling
    
    The commit noted in fixes added a bogus requirement that runtime PM
    managed devices need to be in the RPM_ACTIVE state for PME polling.
    In fact, there is no requirement of a specific runtime PM state, it
    is only required that the state is stable such that testing config
    space availability, ie. !D3cold, remains valid across the PME wakeup.
    
    To that effect, defer polling of runtime PM managed devices that are
    not in either the RPM_ACTIVE or RPM_SUSPENDED states.  Devices in
    transitional states remain on the pci_pme_list and will be re-queued.
    
    However in allowing polling of devices in the RPM_SUSPENDED state,
    the bridge state requires further refinement as it's possible to poll
    while the bridge is in D0, but the runtime PM state is RPM_SUSPENDING.
    An asynchronous completion of the bridge transition to a low power
    state can make config space of the subordinate device become
    unavailable.  A runtime PM reference to the bridge is therefore added
    with a supplementary requirement that the bridge is in the RPM_ACTIVE
    state.
    
    Fixes: d3fcd7360338 ("PCI: Fix runtime PM race with PME polling")
    Reported-by: Sanath S <sanath.s@amd.com>
    Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218360
    Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bdbf8a94b4d0..31dbf1834b07 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2433,29 +2433,45 @@ static void pci_pme_list_scan(struct work_struct *work)
 		if (pdev->pme_poll) {
 			struct pci_dev *bridge = pdev->bus->self;
 			struct device *dev = &pdev->dev;
-			int pm_status;
+			struct device *bdev = bridge ? &bridge->dev : NULL;
 
 			/*
-			 * If bridge is in low power state, the
-			 * configuration space of subordinate devices
-			 * may be not accessible
+			 * If we have a bridge, it should be in an active/D0
+			 * state or the configuration space of subordinate
+			 * devices may not be accessible.
 			 */
-			if (bridge && bridge->current_state != PCI_D0)
-				continue;
+			if (bdev) {
+				spin_lock_irq(&bdev->power.lock);
+				if (!pm_runtime_active(bdev) ||
+				    bridge->current_state != PCI_D0) {
+					spin_unlock_irq(&bdev->power.lock);
+					continue;
+				}
+				pm_runtime_get_noresume(bdev);
+				spin_unlock_irq(&bdev->power.lock);
+			}
 
 			/*
-			 * If the device is in a low power state it
-			 * should not be polled either.
+			 * The device itself may be either in active or
+			 * suspended state, but must not be in D3cold so
+			 * that configuration space is accessible.  The
+			 * transitional resuming and suspending states are
+			 * skipped to avoid D3cold races.
 			 */
-			pm_status = pm_runtime_get_if_active(dev, true);
-			if (!pm_status)
-				continue;
-
-			if (pdev->current_state != PCI_D3cold)
+			spin_lock_irq(&dev->power.lock);
+			if ((pm_runtime_active(dev) ||
+			     pm_runtime_suspended(dev)) &&
+			    pdev->current_state != PCI_D3cold) {
+				pm_runtime_get_noresume(dev);
+				spin_unlock_irq(&dev->power.lock);
 				pci_pme_wakeup(pdev, NULL);
-
-			if (pm_status > 0)
 				pm_runtime_put(dev);
+			} else {
+				spin_unlock_irq(&dev->power.lock);
+			}
+
+			if (bdev)
+				pm_runtime_put(bdev);
 		} else {
 			list_del(&pme_dev->list);
 			kfree(pme_dev);


