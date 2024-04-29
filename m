Return-Path: <linux-kernel+bounces-162862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F21B8B6174
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E341C22103
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C2B13AA53;
	Mon, 29 Apr 2024 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuV5O4Df"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E383CB9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416925; cv=none; b=BSWqg+9DWunDLMOKmNyhehePjxQy0iZ1LZlgjUOTZspPDMfTqY3O+elhIGxLdQ4HkuFJsIBbrlGq5zsfyAXY1zmhHV6PwInHIVnM5AyLdes5SHbJLbGYsWX3lVFSQ1AWl2jFPmRDV3P6fxk6431vbVJpk1nTd/wXVBb+F9DEslM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416925; c=relaxed/simple;
	bh=+bJ4l/+MJh21mpfoMLxqNP2P/1zhMk4yCKT38ck+uDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXUmIY5G3lYJj3xk86/S73dQvE8dF77Rtx10rKgotKnZR4e2SeMZGCWxfxokzZogy4eaULf0qKFPUs6VW/H+7OqeTs1x4c4odQnq1FTexpy+AoeS9HpvdnSuZTS6BdMa5/D6C1SdNeKSSrdp8MTOJRaCAr4XTAa9rd/D5VlehgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZuV5O4Df; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714416922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/3/BkQbBPDA1F/5I6ABEhaOnE4gox6HhtRjp973dZI=;
	b=ZuV5O4DfiTLM1+rPaLSA1UnQwRlZstGariFtxEQdQ2r9uuo2r4PsHEIGSZslOK+mcZuOZq
	y1gfkt9x0MsuuzQWZtlqLPTrqGcIMTyVoiY7R6+9FMmIcst2OnSMhzpra8v68FD2rXdn/Z
	CgZjX2dtNtKk8cV/XjSx00zAcEtja5I=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-fFXHERQnNLK0FJe8IQGq8A-1; Mon, 29 Apr 2024 14:55:21 -0400
X-MC-Unique: fFXHERQnNLK0FJe8IQGq8A-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da41c44e78so518053739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416920; x=1715021720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/3/BkQbBPDA1F/5I6ABEhaOnE4gox6HhtRjp973dZI=;
        b=Qo877JWq4XIx0+Fo8bt0C7shOnAGaa9KWyQ20g5xNR/mAThGSDuRGxR3ztXlXqFOUO
         h9RVL4CArQCAwMSO1RBRUc5AxpAE+97fSxvl7tFAlwuuO8BJQ/EYZ4TGN+4CcnwnvPb8
         Dtkz2QXcUFe9GD49BV9L6tzMyPxQZRm+pvpOGWoZgWU9wV8I5RZrPFxmswRlRu7x1m+y
         BCdrIGGHwkivRxTGW3N7jW/7KZHL0E3GFlmpXgQQCwmx1UN2XLLpLC/DhOXh4N0qUUTG
         VsLcUMtqWyo/d4rYjEFqqMItg/rw8+1UizcGv11SaNYC1kGTjxf/AYksPIrPLU/GcCHO
         fT9A==
X-Forwarded-Encrypted: i=1; AJvYcCX0t/PKaivDpaI/tQrU+GKuy6/xoaQiT7FYFuZtxoGEZr8cXq5gFOv37qa6f0dPtmtC8qsngeKqQ/7/XvMQZAhx8BZL1YoIlBA8s8sc
X-Gm-Message-State: AOJu0YyMjKHry4ZeNgK+citeyHBl2HXCly/lQgjvaXZoPrvmgP0xMAQO
	iFBRw1P4ivKmZV/7T8Ch10CRkRKiTCvzMEWwdhyORFi/10XK0v0whB2vU5+Dsf8xxREJw+eibtO
	3ArhY5Njr8qMLUGP4Thm8/3OmYW51SJHuA2RJ9SyswcPIPN2CpcV7iX+5Vp8trA==
X-Received: by 2002:a05:6e02:1384:b0:36b:3b10:7419 with SMTP id d4-20020a056e02138400b0036b3b107419mr13461536ilo.32.1714416920201;
        Mon, 29 Apr 2024 11:55:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrkmhoNdK7DR3Aq+qUGcS4scHO6A8gkPsrSrcUau21xILS5fqOfi1nMuJyEgwFhR3UNAzGmg==
X-Received: by 2002:a05:6e02:1384:b0:36b:3b10:7419 with SMTP id d4-20020a056e02138400b0036b3b107419mr13461511ilo.32.1714416919784;
        Mon, 29 Apr 2024 11:55:19 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id l15-20020a92d94f000000b0036bf91c25d4sm5162364ilq.57.2024.04.29.11.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:55:19 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:55:17 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Nipun Gupta <nipun.gupta@amd.com>
Cc: <tglx@linutronix.de>, <gregkh@linuxfoundation.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <maz@kernel.org>,
 <git@amd.com>, <harpreet.anand@amd.com>,
 <pieter.jansen-van-vuuren@amd.com>, <nikhil.agarwal@amd.com>,
 <michal.simek@amd.com>, <abhijit.gangurde@amd.com>,
 <srivatsa@csail.mit.edu>
Subject: Re: [PATCH v6 1/2] genirq/msi: add wrapper msi allocation API and
 export msi functions
Message-ID: <20240429125517.693714ef.alex.williamson@redhat.com>
In-Reply-To: <20240423150920.12fe4a3e.alex.williamson@redhat.com>
References: <20240423111021.1686144-1-nipun.gupta@amd.com>
	<20240423150920.12fe4a3e.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 15:09:20 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 23 Apr 2024 16:40:20 +0530
> Nipun Gupta <nipun.gupta@amd.com> wrote:
> 
> > SI functions for allocation and free can be directly used by  
> 
> We lost the ^M in this version.
> 
> > the device drivers without any wrapper provided by bus drivers.
> > So export these MSI functions.
> > 
> > Also, add a wrapper API to allocate MSIs providing only the 
> > number of interrupts rather than range for simpler driver usage.
> > 
> > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> > 
> > No change in v5->v6
> > 
> > Changes in v4->v5:
> > - updated commit description as per the comments.  
> 
> I see in https://lore.kernel.org/all/87edbyfj0d.ffs@tglx/ that Thomas
> also suggested a new subject:
> 
>     genirq/msi: Add MSI allocation helper and export MSI functions
> 
> I'll address both of these on commit if there are no objections or
> further comments.  Patch 2/ looks ok to me now as well.  Thanks,

Applied series to vfio next branch for v6.10.  Thanks,

Alex


