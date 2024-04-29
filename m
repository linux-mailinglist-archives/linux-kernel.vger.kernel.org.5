Return-Path: <linux-kernel+bounces-161824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3398B51C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1041F22AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C119125C7;
	Mon, 29 Apr 2024 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByVSR8WO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F9C1119B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714373358; cv=none; b=L+JyxkHwAZbbV013z6ptRp56iWvQNkgjFRt22GNR08fwBIgIoQGWO8tQGItAvI77wmwI9aEKEEdqr0oBuK4cwfcGunueVFooGB74UETz6hARs9gAFDYyAjBkVude6SUFB1hi4acUpOoKKBc8EMqroF7y5cbGfidLLCrfbvwY3Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714373358; c=relaxed/simple;
	bh=8vEsWheUY/PvRn653Oqry5I9g+0ZKOyL2X0BXoqCHiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okOhSiTTyN7SwEZmLor2nHazw3By0Vq57uWovhgDOPALgAgXIG+viW+cgBxsDZUNrtXPCx3BWDgA8DvmaYabr8X/y1iyN2cWQnaxVUx1bJqq/eXZOTfoVK4GJzP62tuqyVSfE3YHGsvKdmA9n0K9IE8tq+F24OafQwJVy/WrtNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByVSR8WO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714373353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4PhUZhVF9RyfxmoFtdmZbDxyMR/o8b2EeiB8j5+C41E=;
	b=ByVSR8WODEWbAM9WIbGVTNXORL9v/hzF5xv2ePJSDCbwk6+FheeXlEC7tRoFzI6b9Qc0mm
	32WZUZLjSPq4vatRtbpBi6ata3dGQcLFGpUEh7G8zlH+VBduB/EO+eZGskS0ZlYfCXyFU7
	h38Q1W5F5++cJ9rqVGw06Wc6RC5TNO8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-Rsl1L-PYP1akjDKJigCbqw-1; Mon,
 29 Apr 2024 02:49:07 -0400
X-MC-Unique: Rsl1L-PYP1akjDKJigCbqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAA8538000A8;
	Mon, 29 Apr 2024 06:49:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.134])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A43451C06700;
	Mon, 29 Apr 2024 06:49:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 5D43A18009BA; Mon, 29 Apr 2024 08:49:00 +0200 (CEST)
Date: Mon, 29 Apr 2024 08:49:00 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: David Laight <David.Laight@aculab.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: ohci: Prevent missed ohci interrupts
Message-ID: <ef23ykui3axiwfkr4wi24abbuklvejx5r5wqem5cr4lq36x7py@kkxvsi3ibtbi>
References: <20240424195951.3749388-1-linux@roeck-us.net>
 <a1b4bac14c6a4334969cc7d671f3a8eb@AcuMS.aculab.com>
 <d434c88a-6575-4d45-ab3e-e27ac7684b07@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d434c88a-6575-4d45-ab3e-e27ac7684b07@roeck-us.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

  Hi,

> > > +	/* repeat until all enabled interrupts are handled */
> > > +	if (ohci->rh_state != OHCI_RH_HALTED) {
> > > +		ints = ohci_readl(ohci, &regs->intrstatus);
> > > +		if (ints & ohci_readl(ohci, &regs->intrenable))
> > 
> > Doesn't the driver know which interrupts are enabled?
> > So it should be able to avoid doing two (likely) slow io reads?
> > (PCIe reads are pretty much guaranteed to be high latency.)
> 
> No, the driver does not cache intrenable.

Does the driver ever change intrenable after initialization?

PCIe reads are expensive, especially in virtual machines where this
goes vmexit to qemu, so doing that for a piece of information the
driver should have (or is able to calculate) should indeed better
be avoided.

take care,
  Gerd


