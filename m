Return-Path: <linux-kernel+bounces-96176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FB987581C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E997D1C21858
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7011386BE;
	Thu,  7 Mar 2024 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dv/5hQOF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4211386B6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842644; cv=none; b=bBHSBMbonQDnFe/xFZ0C5k20wD2E+it4uAQ3JxjtwQNAnenp7G0ZhCzIxCxXjFJczLzz01YSYxVEvlDBHY/THBcsR7YgTtKIAHL3PeZ45kk3H74JO13w95mZk/R5e6jMyYH/iMYzYX7ESEJ0Mt72Uh/UMjs9JaLDpJdtl7qAh0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842644; c=relaxed/simple;
	bh=/YUybJbsSXbRwRUMAvYnKQA/SRd72YChTHUB65fv0+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEmGW+PCLKG+alZ5xRQQbauhRZ17GSR60kkRDun2w1vFm6ktZUgaZv1XQ0DcX+GTzbxXRiBCOU0TtrqPiMTPHrd3O9cM3r1TBzPQr5B7iw46iTdVR8wx/8S2oShWmvaDcB/9IWErBpt6nMn+fhp2OhmmfuSsKOdimWT29hNqIts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dv/5hQOF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709842640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oWG/IRYPalUuOXVHKI+XsPiSvzLLDZYH1nG41oHFe8M=;
	b=dv/5hQOFORGEZ+mFptvUbziiVnLO0d81KJ9VC7a4RHXEM5/QPTb+/xj0xc1CwF7lER9zrX
	SLWm2Kdl0XSqh3ABPjMr5M8+kx2sRIS+SEeEHjgpyra0Eu7ELWuy70zMc7lXjHKfuTo06z
	0Z8zCQqw72eJkDlM80ZCoLLyoZ9gLYs=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-zbYFb6-rO1GZ4Bj8cAiI3w-1; Thu, 07 Mar 2024 15:17:19 -0500
X-MC-Unique: zbYFb6-rO1GZ4Bj8cAiI3w-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c83c53216bso129830439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:17:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709842638; x=1710447438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWG/IRYPalUuOXVHKI+XsPiSvzLLDZYH1nG41oHFe8M=;
        b=TLNARkXBhxnWFrnEAM9cuzMv7jyqpVY22a5a/G64yR9CgR4uKk9OniqqqdXPaOyxBZ
         KhP2FspbAnlo0XzUsIv3aXVrMFtgHKRMS6y5a9nQoamkIx3lDET4gFUC8MZaV8Nd8uHi
         qndLDC4ZOMPznkWXL8Pjmdpn3sbuQ35fzSdQ49v+qy6YApb4UEIyHHDas/pZxyjKPnRb
         aUzEXC5RzyKV6Dl+PmvV9wVvRcrHQ19BGR+9gMV7bxtxIcEvIC8HqjHH4BTWgvhxT1ON
         6Q8lWTd8JzECueRGkXXHMg2iSfW0Zu2GlJzKYkoIay1OaINaCFcK1fWXOmOakn0PAt5V
         xCGA==
X-Forwarded-Encrypted: i=1; AJvYcCX3RNITj2E7a5P2an0Kvpwtk0H1o5SkSeqvEJkq8Ze01xg7nuu8MQTAkXyDb6JHq2Vd48ZgdkyhFFFniiS4U9kIvXSNUUq+LI5QxPHX
X-Gm-Message-State: AOJu0YwQWDRwCEWIGEABt+OSjaXN75ue4SiF+lYvUYY1ipfN6yvLIJVk
	1Z4n+/5tjTN/DHjPyoyq8HuHP+X9couAtzBy3VDr6eQ7YsLBGp2TwMUWrewhKo/CzfTJwPcPqTG
	uTcikzfVbyqE3Wjrz0ytf3Wo3wlh+rCcmPK4XNMO024YeQjzTfGg3OjeMqctmyesWduVUfA==
X-Received: by 2002:a5e:d50f:0:b0:7c7:ead3:d8a0 with SMTP id e15-20020a5ed50f000000b007c7ead3d8a0mr17169222iom.2.1709842638333;
        Thu, 07 Mar 2024 12:17:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6jNLo/L7oVmym45jibgdfGVjio9E2EV/9/SsVH70E+7HdSuDVCHGsvUBY8tx1dnDdq/K7iA==
X-Received: by 2002:a5e:d50f:0:b0:7c7:ead3:d8a0 with SMTP id e15-20020a5ed50f000000b007c7ead3d8a0mr17169210iom.2.1709842637970;
        Thu, 07 Mar 2024 12:17:17 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id d18-20020a6b6812000000b007c854623affsm1796957ioc.35.2024.03.07.12.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 12:17:17 -0800 (PST)
Date: Thu, 7 Mar 2024 13:17:16 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "clg@redhat.com" <clg@redhat.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] vfio/pci: Disable auto-enable of exclusive INTx IRQ
Message-ID: <20240307131716.5feda507.alex.williamson@redhat.com>
In-Reply-To: <BL1PR11MB52711AF96C93A7C2B70FE12D8C202@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20240306211445.1856768-1-alex.williamson@redhat.com>
	<20240306211445.1856768-2-alex.williamson@redhat.com>
	<BL1PR11MB52711AF96C93A7C2B70FE12D8C202@BL1PR11MB5271.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Mar 2024 08:28:45 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Thursday, March 7, 2024 5:15 AM
> > 
> > Currently for devices requiring masking at the irqchip for INTx, ie.
> > devices without DisINTx support, the IRQ is enabled in request_irq()
> > and subsequently disabled as necessary to align with the masked status
> > flag.  This presents a window where the interrupt could fire between
> > these events, resulting in the IRQ incrementing the disable depth twice.  
> 
> Can you elaborate the last point about disable depth?

Each irq_desc maintains a depth field, a disable increments the depth,
an enable decrements.  On the disable transition from 0 to 1 the IRQ
chip is disabled, on the enable transition from 1 to 0 the IRQ chip is
enabled.

Therefore if an interrupt fires between request_irq() and
disable_irq(), vfio_intx_handler() will disable the IRQ (depth 0->1).
Note that masked is not tested here, the interrupt is expected to be
exclusive for non-pci_2_3 devices.  @masked would be redundantly set to
true.  The setup call path would increment depth to 2.  The order these
happen is not important so long as the interrupt is in-flight before
the setup path disables the IRQ.

> > This would be unrecoverable for a user since the masked flag prevents
> > nested enables through vfio.  
> 
> What is 'nested enables'?

In the case above we have masked true and disable depth 2.  If the user
now unmasks the interrupt then depth is reduced to 1, the IRQ is still
disabled, and masked is false.  The masked value is now out of sync
with the IRQ line and prevents the user from unmasking again.  The
disable depth is stuck at 1.

Nested enables would be if we allowed the user to unmask a line that we
think is already unmasked.
 
> > Instead, invert the logic using IRQF_NO_AUTOEN such that exclusive INTx
> > is never auto-enabled, then unmask as required.
> > 
> > Fixes: 89e1f7d4c66d ("vfio: Add PCI device driver")
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>  
> 
> But this patch looks good to me:
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> with one nit...
> 
> > 
> > +	/*
> > +	 * Devices without DisINTx support require an exclusive interrupt,
> > +	 * IRQ masking is performed at the IRQ chip.  The masked status is  
> 
> "exclusive interrupt, with IRQ masking performed at..."

TBH, the difference is too subtle for me.  With my version above you
could replace the comma with a period, I think it has the same meaning.
However, "...exclusive interrupt, with IRQ masking performed at..."
almost suggests that we need a specific type of exclusive interrupt
with this property.  There's nothing unique about the exclusive
interrupt, we could arbitrarily decide we want an exclusive interrupt
for DisINTx masking if we wanted to frustrate a lot of users.

Performing masking at the IRQ chip is actually what necessitates the
exclusive interrupt here.  Thanks,

Alex


