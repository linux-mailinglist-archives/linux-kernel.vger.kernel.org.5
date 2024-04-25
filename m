Return-Path: <linux-kernel+bounces-158131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D538B1BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB1C0B24289
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFA26E61F;
	Thu, 25 Apr 2024 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="K/N2DRIa"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035DE6EB45
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030402; cv=none; b=B+g0G50PeH3GQkxp+BWeBpOaxkGABO1Hbha0mqKt+pNBu2ize9vF1o0pg3Pp5NJRVTjzz2BAI4gepkQawsMv2OCRbFzB0NKhtI/y30yOF3f/eaLmoUaU9rD7x4pUrdNSRfjXaM69u0GolLkdmhQmhLtRnHFaNZICXPXZDdkjjDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030402; c=relaxed/simple;
	bh=BcHYLSESJ0hPv7oQYl6LtJ1bX+Ez09LQmP/mQu7Fbac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvAtziNIZGulzGw6vbAJ6/o7QS31C6pfaC2ncDgTise/KfxSzArBndv5j5xc3d+ek8dbHTljCLjNsEKYaSIBCxsTKtTorLhErX5mC9NYRMotu1YOs6CNG/2k/a1X+Wor4KQBRste+jaVZUQGL30PdMAL1fPOcS+RFHRzji31ly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=K/N2DRIa; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 568E04059B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714030395;
	bh=N49t3AK4kKaDmcRRhdLxt0k+B5LqZexfU9NZVLcAJRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=K/N2DRIaAjRmNok+zH6+pAoU60HS5IhDtlWrvgoAC+5zlde01ji/jFB9aetPrMeeN
	 9pgn7qyz659domxob/FkcKPJfW0/vk6864KnoOLXosCrt26NqEll/LCHjuYSDs/KAK
	 /GwwGVFrS2ib1JkZmgqqi70fNvWJrYPjia0XLMXh/kwHDiN9adj4Szvs+t1ZlomlI4
	 bdGPm7KpPZG1k8Djjtmdbj6XX3BSHM5D9NKVQH2DoGwj29Y3neOyH2rSiX1S1e7N0R
	 WTe0I3dRI8Wklfu4T9wdQXSsC7s5A3dcbFa1Rxfqdq3KulbSK3SGmzfuYMtzFqCF6A
	 fDlP1dnM0ifTg==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a4a2cace80so867997a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714030394; x=1714635194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N49t3AK4kKaDmcRRhdLxt0k+B5LqZexfU9NZVLcAJRM=;
        b=e+p+oGcN6oCEccz1/53dg7tLX7YlNLkU0Hco+MfKubplzL9a7AcfVyhXdanNbGJ3i6
         TlXNxau4GRxCDPGtOUHRTmPp+jWrlgcR2m5EQLYALenRXikv5PRrmcmz1mFdisRwYrfC
         bNhm7IyksE/HqDcwKbrzUU72+QiG+TTiIuwXF9swRG02X+n2tFGalL5Dqna489O30M9p
         Z1RBkS/N6sNFMHSD7RA150jkIdugryb72Ls2DfsaucjabucYJIu/6+6zj13R+hN1EmYg
         mzf7SGMnbHdin1NzxZ3B3HpqRq712cLVvVzO8QY3oAbc8pVbrcl/tMcyCL4wy30X/pp8
         +vQA==
X-Forwarded-Encrypted: i=1; AJvYcCX+ipF3fnBIx5TkV1M2OlDGsryWfdtwvMUrkGHWl4CnA5sCFFnen/OMkOLDfui7vrMeenZhZQyv+kqAQ7jcWECvX+Wt8gudMkKWS9sA
X-Gm-Message-State: AOJu0YwHA5dWAhHNEKszqMC1uOuSKhOxzoWih0eb+tUQ6aCyW74vjh+m
	dZN5yVDMvgEAiJWUVjyuJ7z8/WA4BFxuU88Da1tNn/OTBNw7SBaGowtVaPkR/zHATOyrdNG0QhK
	v5rC8iadz2u0H+axDOTcUnQ8rDdJCHbWobqL6vx10p+avGthtGGtJJH6A0pW8n/WwvlbbhlkMge
	25qyWJgfkwr+iSkNBPfCd2LBw2gAGUMOF+2rgr90kWVYbPtJhm5kw2
X-Received: by 2002:a17:90a:f18c:b0:2a2:775:9830 with SMTP id bv12-20020a17090af18c00b002a207759830mr3635607pjb.11.1714030393816;
        Thu, 25 Apr 2024 00:33:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxdkPh6jUQbDypZw6ih5aBEWZ8OaLuVmwkpiSeYBIaD8D8JrEbgl1UlPs5pmFlAQ5PAStLbkRGh+jSeMu9NOg=
X-Received: by 2002:a17:90a:f18c:b0:2a2:775:9830 with SMTP id
 bv12-20020a17090af18c00b002a207759830mr3635577pjb.11.1714030393404; Thu, 25
 Apr 2024 00:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416043225.1462548-2-kai.heng.feng@canonical.com> <20240418203531.GA251408@bhelgaas>
In-Reply-To: <20240418203531.GA251408@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 25 Apr 2024 15:33:01 +0800
Message-ID: <CAAd53p7O51mG7LMrEobEgGrD8tsDFO3ZFSPAu02Dk-R0W3mkvg@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] PCI/AER: Disable AER service on suspend
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, bagasdotme@gmail.com, 
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org, kch@nvidia.com, 
	hch@lst.de, gloriouseggroll@gmail.com, kbusch@kernel.org, sagi@grimberg.me, 
	hare@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 4:35=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Apr 16, 2024 at 12:32:24PM +0800, Kai-Heng Feng wrote:
> > When the power rail gets cut off, the hardware can create some electric
> > noise on the link that triggers AER. If IRQ is shared between AER with
> > PME, such AER noise will cause a spurious wakeup on system suspend.
> >
> > When the power rail gets back, the firmware of the device resets itself
> > and can create unexpected behavior like sending PTM messages. For this
> > case, the driver will always be too late to toggle off features should
> > be disabled.
> >
> > As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power
> > Management", TLP and DLLP transmission are disabled for a Link in L2/L3
> > Ready (D3hot), L2 (D3cold with aux power) and L3 (D3cold) states. So if
> > the power will be turned off during suspend process, disable AER servic=
e
> > and re-enable it during the resume process. This should not affect the
> > basic functionality.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D209149
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216295
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218090
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Thanks for reviving this series.  I tried follow the history about
> this, but there are at least two series that were very similar and I
> can't put it all together.
>
> > ---
> > v8:
> >  - Add more bug reports.
> >
> > v7:
> >  - Wording
> >  - Disable AER completely (again) if power will be turned off
> >
> > v6:
> > v5:
> >  - Wording.
> >
> > v4:
> > v3:
> >  - No change.
> >
> > v2:
> >  - Only disable AER IRQ.
> >  - No more check on PME IRQ#.
> >  - Use helper.
> >
> >  drivers/pci/pcie/aer.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index ac6293c24976..bea7818c2d1b 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/kfifo.h>
> >  #include <linux/slab.h>
> > +#include <linux/suspend.h>
> >  #include <acpi/apei.h>
> >  #include <acpi/ghes.h>
> >  #include <ras/ras_event.h>
> > @@ -1497,6 +1498,28 @@ static int aer_probe(struct pcie_device *dev)
> >       return 0;
> >  }
> >
> > +static int aer_suspend(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > +     struct pci_dev *pdev =3D rpc->rpd;
> > +
> > +     if (pci_ancestor_pr3_present(pdev) || pm_suspend_via_firmware())
> > +             aer_disable_rootport(rpc);
>
> Why do we check pci_ancestor_pr3_present(pdev) and
> pm_suspend_via_firmware()?  I'm getting pretty convinced that we need
> to disable AER interrupts on suspend in general.  I think it will be
> better if we do that consistently on all platforms, not special cases
> based on details of how we suspend.

Sure. Will change in next revision.

>
> Also, why do we use aer_disable_rootport() instead of just
> aer_disable_irq()?  I think it's the interrupt that causes issues on
> suspend.  I see that there *were* some versions that used
> aer_disable_irq(), but I can't find the reason it changed.

Interrupt can cause system wakeup, if it's shared with PME.

The reason why aer_disable_rootport() is used over aer_disable_irq()
is that when the latter is used the error still gets logged during
sleep cycle. Once the pcieport driver resumes, it invokes
aer_root_reset() to reset the hierarchy, while the hierarchy hasn't
resumed yet.

So use aer_disable_rootport() to prevent such issue from happening.

Kai-Heng

>
> > +
> > +     return 0;
> > +}
> > +
> > +static int aer_resume(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > +     struct pci_dev *pdev =3D rpc->rpd;
> > +
> > +     if (pci_ancestor_pr3_present(pdev) || pm_resume_via_firmware())
> > +             aer_enable_rootport(rpc);
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
> >   * @dev: pointer to Root Port, RCEC, or RCiEP
> > @@ -1561,6 +1584,8 @@ static struct pcie_port_service_driver aerdriver =
=3D {
> >       .service        =3D PCIE_PORT_SERVICE_AER,
> >
> >       .probe          =3D aer_probe,
> > +     .suspend        =3D aer_suspend,
> > +     .resume         =3D aer_resume,
> >       .remove         =3D aer_remove,
> >  };
> >
> > --
> > 2.34.1
> >

