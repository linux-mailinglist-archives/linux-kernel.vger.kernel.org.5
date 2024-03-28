Return-Path: <linux-kernel+bounces-123612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB541890BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1D3B2391A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B1713A258;
	Thu, 28 Mar 2024 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNAyQFDI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167AE13B5A0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658529; cv=none; b=EPn6dhVh4T2BC77YqqQLe06at4PczpXa/RZLQQn6whW4YpXqaRzfNt9q57ID+8UU2LKt34EfKGZ/4wmYQU+/nuZyCGD5/FUma4j+wEuXvyoKI7HWOoctoNp31NfhWQq/JcxubXp8y2Maw2JWi9Umh/BYinrEUr557h3KZDS6btg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658529; c=relaxed/simple;
	bh=dx67GYsTkBy2f4E6+nDiqrEy7ZQNVITGQVNCkKyQWmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFhJyped+9VtPurQ1+mIi921M5b9L/wYAWqLsmIIlicaPrz55FZSuFNATXMrliwh2Oe4GmazZrzELZClXxNkyTeht4aV77GrQwOKAbMne+y1MnlhR7bWNxx18Rq7/C+ch2V/CjxEp8kFyb1mCVd3JEVsI8euptJUfYSQdruEVqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNAyQFDI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711658526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ry2KwNiHHETpw/ISNKmQIteSWFjYtHm09Kp2vXN04J8=;
	b=eNAyQFDIt3psjvpDAJLJ6YK+3QzwrVJAAkETzwpnKDMq0FThLe2rUy2S+gxFpZS8xh2ILk
	dJ4oAMJmEnuWKxOiwCXqFc9UyUD1u+4h++53JBx+Ubbih9CIjyQyNuX9rzx4HgSSxjf3lg
	1XpdoM8kRqXKEfB+vRGLPOitjtcch0M=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-96SUoOYGMOqQKuGOqcynsQ-1; Thu, 28 Mar 2024 16:42:05 -0400
X-MC-Unique: 96SUoOYGMOqQKuGOqcynsQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbf2ff0e33so120753139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658524; x=1712263324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ry2KwNiHHETpw/ISNKmQIteSWFjYtHm09Kp2vXN04J8=;
        b=JTYiaOyNPnaQa1NXY8RYTuF7xUTkES9OFJqKbRTI7YdudkJSCnCify8SW1sAcFvgTh
         8h4mcXU7NHV2GnRqr69hkdKyAsPcPdi248/FWy2++ZGhBtoEnQYDAo5Mn8hA2EWCp41V
         dBhjqAGDSYGn7ph8Ib2+t1To6eKKQgEaWyR7X6AFIAE2BV0/S/vs6mD0Aeh4FW0p7XwT
         502LkjCVDTsizfmwU3vTDpDaUvhC6rthtzU4F3Mhourd1XmnvsjgFZjhTGMmGvGpYXPU
         1cAVix7M2RWpZ9IEwQkTm+vSfOClkzBig4B0dQD7pLwILq4r6cMq9YRA2cPcuCXKeT+7
         0Fqw==
X-Forwarded-Encrypted: i=1; AJvYcCW/a3j92biHw53mwjLWdArn8Ff1+aUgU/eIzU2He7xdJrRSbBxO9zOhdz+3hz1wEw7Ofv1rpHIKpEvVJcZw1/akOdIy1tXNC1aPagFa
X-Gm-Message-State: AOJu0YwUJ7lbnK1/clz28oJRFC3060Ru78DUEi6pBjTw3Ki+AMrfxQH6
	zSBXIBGtZLqP55oq/mR+qlrJTvkiQLfMTsInIq+6l41ECJTU7P0r2WaQOE554TlHYUTh0k/sRrc
	bde1j0a2Lwnpj4vIRpMGFVVzjn+hBOZJ+XtitkXz+hCOHVM22vGsZJIAwWN5PIg==
X-Received: by 2002:a6b:e610:0:b0:7d0:2e09:914 with SMTP id g16-20020a6be610000000b007d02e090914mr311624ioh.14.1711658524512;
        Thu, 28 Mar 2024 13:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETxGX4iy66B/NI8RaJIF20PbD28PYM4/zW2oAcxKRRkohptt64R98fB5Lkzx1WzA2aqpVdzw==
X-Received: by 2002:a6b:e610:0:b0:7d0:2e09:914 with SMTP id g16-20020a6be610000000b007d02e090914mr311607ioh.14.1711658524241;
        Thu, 28 Mar 2024 13:42:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id c8-20020a5e8f08000000b007cf185099e6sm602078iok.35.2024.03.28.13.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:42:03 -0700 (PDT)
Date: Thu, 28 Mar 2024 14:42:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, edmund.raile@proton.me, Takashi Sakamoto
 <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2] PCI: Mark LSI FW643 to avoid bus reset
Message-ID: <20240328144201.510f6d5e.alex.williamson@redhat.com>
In-Reply-To: <20240327150119.GA1502858@bhelgaas>
References: <20240326131858.GA140624@workstation.local>
	<20240327150119.GA1502858@bhelgaas>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 10:01:19 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Mar 26, 2024 at 10:18:58PM +0900, Takashi Sakamoto wrote:
> > On Mon, Mar 25, 2024 at 09:41:49AM -0500, Bjorn Helgaas wrote:  
> > > So even without this patch, you are able to pass the FW643 to a VM
> > > with VFIO, and you don't see any issues caused by VFIO resetting the
> > > device?  
> >  
> > Absolutely yes, at least in my VM, for recent years to maintain Linux
> > FireWire subsystem and ALSA firewire stack.  
> 
> So there must be something different between your system and Edmund's.
> Maybe we can refine the quirk so it avoids the SBR on Edmund's system
> but not yours.
> 
> Can you both collect the output of "sudo lspci -vvv" so we can try to
> figure out the difference?  Also a complete dmesg log would be helpful
> and would contain DMI information that we might need if this is
> firmware dependent.

The original patch proposed for this gave me the impression that this
was a device used on various old Mac systems, not likely applicable to
a general purpose plug-in card.  Given the expanded use case, I'd
suggest reverting the patch.

I think we need significantly more exhaustive testing on the afflicted
system to understand whether this is an issue with the endpoint, the
root port, the BIOS, etc.

In the meantime, or maybe as a permanent solution, Edmund can make use
of the reset_method interface in pci-syfs to restrict the available
reset methods for the device rather than risk removing a reset
mechanism identified as working by other users.  My 2 cents.  Thanks,

Alex


