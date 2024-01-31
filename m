Return-Path: <linux-kernel+bounces-46088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B52E9843A25
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407A81F2F7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FFF69E16;
	Wed, 31 Jan 2024 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Z61wUn+3"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39BC5EE77
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691503; cv=none; b=Rf42DKT5hcGu7dm2zSKJBA9hL/6B561egWxa1LJLjdNIa5tHFWw+VeozN5870mS+IkIf7AwgouaqBmlrKUAZs+H13PR4im3I3fg/5YH1Gir+fYU++jXnDHO322V3cFKdsS1dFnEg8Y56dI0ePS8PvU04iYAe91CFIlbkmxJP2/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691503; c=relaxed/simple;
	bh=6Zrgzb21tE86MlKP9O+7L5tc50ZGgJImAGA+G2RxFKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnB5fWw7lOjyEghY3tnkixpTvddiIah0bmP6WTOKut3sUwKHRCIUcLRohZfH9C4yPuy0bJG/4IJ8nJ/H65l33MnFikdC1RQuYTwQOwB5pJTjGcXXDa1P/JlzTrnTFw0fExGicjmKnZ+kiT3AsL4swH65wzrab3Y5tpxS9TEy5tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=Z61wUn+3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3394bec856fso366741f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1706691500; x=1707296300; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qh9fV0VJ5xXDNHxQ7wqQ2X7g1MNe9pqa0fEzuyTcdc4=;
        b=Z61wUn+3lfV7YeTkLJlRB1miGJj72yqa+VpPGV+brdxkWHQfA9gM+ENay7CQinN9qd
         d4ziOx1muycnFRFrV9JAecDHvVivHRAOSP2k9QN60rldvnjmmioREgV1DkToc7vnUFXD
         /ZT92g90ePpSNvzCsFvnPM2PdkurjRODrkvQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706691500; x=1707296300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qh9fV0VJ5xXDNHxQ7wqQ2X7g1MNe9pqa0fEzuyTcdc4=;
        b=xTA1F6NiWGneCq+UnIljabyz7IjlCQxLpEH0lVksGFKPivIYyiDK6t/NqqWmWV76gq
         oOcHA2pxPt40PZvWN73/83JUE8rwnVQldCvg24MNMxsimbVL78gqk/tLagNc+Z1li5nv
         76ZXUqn1yHURflN1KdU4XFaUokofbeq1O6pLCCwhU8De33qEWlmsHLY/dDPUegIIw8o4
         bzsbbCLYsD41hhxL/u5C7E6f1rHGYs+Pv3+gF5lsGa9jk6Tr06iECcNUWtY8UZ/Q0Pny
         IDQ+gLJtnxRWkGopphPYitK1TGpDW08fDqz90uk93L/C9mjRuSkpEMFoT3MfZBzE5v6L
         1Xhg==
X-Gm-Message-State: AOJu0YxCZLCAwgtVYmncdq5jSaC20Aj3xT4MW7PaRbod4Vpn+5+YAZRe
	+z7b9ANsBoKnFs3oZbbb+YZbrdPEgTgnRXJ1Vs2Zm00GF4AqV+8E/HKZq5MeqBg=
X-Google-Smtp-Source: AGHT+IEoDFw3DguH17mowGdEzig1sXO01pO7xO+LXaUUAIS/5x+ESHIRsiCl4RQiIC4BMyQA8aoC/Q==
X-Received: by 2002:adf:ea92:0:b0:33a:ded1:b01 with SMTP id s18-20020adfea92000000b0033aded10b01mr3594397wrm.28.1706691500269;
        Wed, 31 Jan 2024 00:58:20 -0800 (PST)
Received: from localhost ([213.195.118.74])
        by smtp.gmail.com with ESMTPSA id d15-20020adfa34f000000b0033ae9f1fb82sm8527367wrb.48.2024.01.31.00.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:58:20 -0800 (PST)
Date: Wed, 31 Jan 2024 09:58:19 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Chen, Jiqian" <Jiqian.Chen@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>,
	"Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>
Subject: Re: [RFC KERNEL PATCH v4 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Message-ID: <ZboLq6kZhwpUC_c3@macbook>
References: <Zbi8WJPEUSMgjuVY@macbook>
 <20240130204403.GA562912@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130204403.GA562912@bhelgaas>

On Tue, Jan 30, 2024 at 02:44:03PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 30, 2024 at 10:07:36AM +0100, Roger Pau Monné wrote:
> > On Mon, Jan 29, 2024 at 04:01:13PM -0600, Bjorn Helgaas wrote:
> > > On Thu, Jan 25, 2024 at 07:17:24AM +0000, Chen, Jiqian wrote:
> > > > On 2024/1/24 00:02, Bjorn Helgaas wrote:
> > > > > On Tue, Jan 23, 2024 at 10:13:52AM +0000, Chen, Jiqian wrote:
> > > > >> On 2024/1/23 07:37, Bjorn Helgaas wrote:
> > > > >>> On Fri, Jan 05, 2024 at 02:22:17PM +0800, Jiqian Chen wrote:
> > > > >>>> There is a need for some scenarios to use gsi sysfs.
> > > > >>>> For example, when xen passthrough a device to dumU, it will
> > > > >>>> use gsi to map pirq, but currently userspace can't get gsi
> > > > >>>> number.
> > > > >>>> So, add gsi sysfs for that and for other potential scenarios.
> > > > >> ...
> > > > > 
> > > > >>> I don't know enough about Xen to know why it needs the GSI in
> > > > >>> userspace.  Is this passthrough brand new functionality that can't be
> > > > >>> done today because we don't expose the GSI yet?
> > > 
> > > I assume this must be new functionality, i.e., this kind of
> > > passthrough does not work today, right?
> > > 
> > > > >> has ACPI support and is responsible for detecting and controlling
> > > > >> the hardware, also it performs privileged operations such as the
> > > > >> creation of normal (unprivileged) domains DomUs. When we give to a
> > > > >> DomU direct access to a device, we need also to route the physical
> > > > >> interrupts to the DomU. In order to do so Xen needs to setup and map
> > > > >> the interrupts appropriately.
> > > > > 
> > > > > What kernel interfaces are used for this setup and mapping?
> > > >
> > > > For passthrough devices, the setup and mapping of routing physical
> > > > interrupts to DomU are done on Xen hypervisor side, hypervisor only
> > > > need userspace to provide the GSI info, see Xen code:
> > > > xc_physdev_map_pirq require GSI and then will call hypercall to pass
> > > > GSI into hypervisor and then hypervisor will do the mapping and
> > > > routing, kernel doesn't do the setup and mapping.
> > > 
> > > So we have to expose the GSI to userspace not because userspace itself
> > > uses it, but so userspace can turn around and pass it back into the
> > > kernel?
> > 
> > No, the point is to pass it back to Xen, which doesn't know the
> > mapping between GSIs and PCI devices because it can't execute the ACPI
> > AML resource methods that provide such information.
> > 
> > The (Linux) kernel is just a proxy that forwards the hypercalls from
> > user-space tools into Xen.
> 
> But I guess Xen knows how to interpret a GSI even though it doesn't
> have access to AML?

On x86 Xen does know how to map a GSI into an IO-APIC pin, in order
configure the RTE as requested.

> > > It seems like it would be better for userspace to pass an identifier
> > > of the PCI device itself back into the hypervisor.  Then the interface
> > > could be generic and potentially work even on non-ACPI systems where
> > > the GSI concept doesn't apply.
> > 
> > We would still need a way to pass the GSI to PCI device relation to
> > the hypervisor, and then cache such data in the hypervisor.
> > 
> > I don't think we have any preference of where such information should
> > be exposed, but given GSIs are an ACPI concept not specific to Xen
> > they should be exposed by a non-Xen specific interface.
> 
> AFAIK Linux doesn't expose GSIs directly to userspace yet.  The GSI
> concept relies on ACPI MADT, _MAT, _PRT, etc.  A GSI is associated
> with some device (PCI in this case) and some interrupt controller
> entry.  I don't understand how a GSI value is useful without knowing
> something about that framework in which GSIs exist.

I wouldn't say it's strictly associated with PCI.  A GSI is a way for
ACPI to have a single space that unifies all possible IO-APICs pins in
the system in a flat way.  A GSI is useful in itself because there's
a single GSI space for the whole host.

> Obviously I know less than nothing about Xen, so I apologize for
> asking all these stupid questions, but it just doesn't all make sense
> to me yet.

That's all fine, maybe there's a better path or way to expose this ACPI
information.  Maybe introduce a per-device acpi directory and expose
it there?  Or rename the entry to acpi_gsi?

Thanks, Roger.

