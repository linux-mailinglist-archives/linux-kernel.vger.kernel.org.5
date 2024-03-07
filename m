Return-Path: <linux-kernel+bounces-96184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49345875836
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FC81C21F58
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41831386AA;
	Thu,  7 Mar 2024 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNrS1QcO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E21B12FB2A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843035; cv=none; b=h8jBrzcqc6OSxN45U0FeQTEegQBUEqeq8b3zP1eMmP8ya1AieVicHwBMi+Zx32QtjuI1yhtts+4MCitXnhZyhvQ30+8wmRXCQACbvxPpKD+EJOxx/tIZm+oUCSV8qBRSrmmBRAnEGTftj5uveEV7GwcFUUV/pa1TkgTtzriAyMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843035; c=relaxed/simple;
	bh=n41G5cMXZfffNFebNQD0HhXIaaovLpPefnDOeOUdHew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLtujjUevlLZCgT/jfBh31+M5pwdBZY5FyFEfrKE7p46OGA5aDKyXcJ401eW6e1oKxPKJQBgiDBu3m3bHLJSrmweS+QjyVRmCeQrngF+Lhpmwdq7S1jY0TlM1qK5UVfsmGkAEwpJTkIBt2KWAt5/Iob4YF6UYU0ENuVURlkIHgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNrS1QcO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709843032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzYa2p0WN1L2k72Xj6BYuK/wXJ3KScc8Fyb6F0WXYSw=;
	b=UNrS1QcO7diqxQkQ+yM5Hudv9LsGPzVQG1C71ecw1N+AzeTPiV4qpUQT85HGx9rvSoJlxZ
	W+F+hhrI5ZvkRM6tafL4+mVfxwjFzt656/OGjpydbB5m7zErPeLSi5R2WQVuOxotdiCtl6
	q1Bw7zXujqcZaqYpFVNXmtSAZHUsTTM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-PFwi8fPMOyiUnD9w66tQDQ-1; Thu, 07 Mar 2024 15:23:51 -0500
X-MC-Unique: PFwi8fPMOyiUnD9w66tQDQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso11330439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709843030; x=1710447830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzYa2p0WN1L2k72Xj6BYuK/wXJ3KScc8Fyb6F0WXYSw=;
        b=Ur4VSR5Jf6ODdKyZceN1/Z0rGqcruesmmGOyKgBUgE4T7x+ZSp0YqCAzV8+GyAs8h7
         4Qr2m5NSVBeM8e3usFeu5mgr5j4/tCJkDBW6SSOZzsfbcUAlK4NHGspyL41RK70Ona7z
         P1Rglv3UZnvMHqYTdpuhHypIaoaLEohaP5QqgdRNPDqH/csbGnDW7KRmhuLerfpHvsL4
         DsXIRXvUAvoSZw1uhERyrKFGDeYcHbkRD+yi7js5MOAu6SVab5695gASYAc9DZlaDFtu
         fBVG46Y6vQ9jssC9ZTW6DTaTCXk7tbVA/Y3NMLfhOO148uIv03FXpD3mFabWgwKC2ExM
         nCmA==
X-Forwarded-Encrypted: i=1; AJvYcCWELZHIfDNMmqVchzU8v2HtK0xkeaXPoLmvZ2eckNFtHtwMdlvFuOuMGIWgO0YGXbTlnuOzsddWorEmAFJaKtsV0jcutnB81PxYV9Qk
X-Gm-Message-State: AOJu0Yw7Vq7xXtfo9t4HKhgNm6lvWKjtriZ/ud0e8/v0lnQdP0Balwqy
	tqptkSHO0sR4cvZUNjMllQpZXoVVoIcECFG0je3NWX6I9cSWjjnSDJCtArMTWJNexLx4d0mtpnO
	Pz6Enir5AJorLrELrschIrDz1zAencfGUm5d08Pmxi2pdy0tEW8kussMP3LcxzQ==
X-Received: by 2002:a6b:e509:0:b0:7c8:84c8:7813 with SMTP id y9-20020a6be509000000b007c884c87813mr3123553ioc.0.1709843030396;
        Thu, 07 Mar 2024 12:23:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi5cEQ2ohJmNhdL87DIGzEjk0iugzxVt59dKtJvpR8SdNhIluz4q5AmTctWKUVHAHjcsZauA==
X-Received: by 2002:a6b:e509:0:b0:7c8:84c8:7813 with SMTP id y9-20020a6be509000000b007c884c87813mr3123548ioc.0.1709843030170;
        Thu, 07 Mar 2024 12:23:50 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id g12-20020a02c54c000000b00474f04561bdsm2269985jaj.136.2024.03.07.12.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 12:23:49 -0800 (PST)
Date: Thu, 7 Mar 2024 13:23:48 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "clg@redhat.com" <clg@redhat.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] vfio/pci: Disable auto-enable of exclusive INTx IRQ
Message-ID: <20240307132348.5dbc57dc.alex.williamson@redhat.com>
In-Reply-To: <BL1PR11MB527189373E8756AA8697E8D78C202@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20240306211445.1856768-1-alex.williamson@redhat.com>
	<20240306211445.1856768-2-alex.williamson@redhat.com>
	<BL1PR11MB527189373E8756AA8697E8D78C202@BL1PR11MB5271.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Mar 2024 08:39:16 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Thursday, March 7, 2024 5:15 AM
> > 
> > Currently for devices requiring masking at the irqchip for INTx, ie.
> > devices without DisINTx support, the IRQ is enabled in request_irq()
> > and subsequently disabled as necessary to align with the masked status
> > flag.  This presents a window where the interrupt could fire between
> > these events, resulting in the IRQ incrementing the disable depth twice.
> > This would be unrecoverable for a user since the masked flag prevents
> > nested enables through vfio.
> > 
> > Instead, invert the logic using IRQF_NO_AUTOEN such that exclusive INTx
> > is never auto-enabled, then unmask as required.
> > 
> > Fixes: 89e1f7d4c66d ("vfio: Add PCI device driver")
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>  
> 
> CC stable?

I've always found that having a Fixes: tag is sufficient to get picked
up for stable, so I typically don't do both.  If it helps out someone's
process I'd be happy to though.  Thanks,

Alex


