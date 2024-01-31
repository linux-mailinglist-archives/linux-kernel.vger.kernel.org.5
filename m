Return-Path: <linux-kernel+bounces-46436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A487C843F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591091F2A41A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65EF7A716;
	Wed, 31 Jan 2024 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlrLs+8h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666FE7690E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705281; cv=none; b=hoeggOgRX26zWDOHnjHnkQwwOBxpcQGA4wFhC5n7qAzQfOAR5edmigpfBmz6qSagiV9OMy2YSQ8zJf1U71AnR35k0iE4wRzwP3mFQe5seXkOselQsOiL7WZzmx531JxKmldjJXOWEZwdQ1jFlm05+YxLPS7lTkogiR5FSHP3QJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705281; c=relaxed/simple;
	bh=4wQ7TAIOJQ5m6kdVg1wSzsPCQ4PkDeWkFwCc0m1BgrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8lQxK+PLxHUc1oYBIcArbm8IYvyT6PZQ8ErBDwiKIwcnU3zsFPAbNn5KQ4xazWj9R/JQoBp5sDsJiDrUR97643o5l4WxFMOB1wa1rvHCCWU+n5ZzFlXzq9MXj4WGl2UgMGKHifpt4P7ugm0ZeaZIArSZcGM00GTWuBKTpG0nV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LlrLs+8h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706705278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZgQ3em8+hL4vf1kxriNyHbGVBBe93HygSX6eu/F3dE=;
	b=LlrLs+8hJoDguBb3Xj1IR6spHgt8v7pgwNPv6z9rmG/Y8fWIumOsU5f6dZvyK868BWaJN/
	zd86Yy0YxwykWggDTYI0hSjJAwwEk6BA3YUi5tSKirfuFofn//L1SEHydK4yG8y1gXCNo1
	dR+3Ph6gDyvjgiAnr5iEoLyLhIkXo1Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-VJTCrdEtObC81bpv7NZDpQ-1; Wed, 31 Jan 2024 07:47:49 -0500
X-MC-Unique: VJTCrdEtObC81bpv7NZDpQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA1EA800074;
	Wed, 31 Jan 2024 12:47:48 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CAA01492BC6;
	Wed, 31 Jan 2024 12:47:47 +0000 (UTC)
Date: Wed, 31 Jan 2024 20:47:40 +0800
From: Baoquan He <bhe@redhat.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 00/16] x86/tdx: Add kexec support
Message-ID: <ZbpBbAkPxQZ6gHoE@MiWiFi-R3L-srv>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
 <efe20a00-9a7c-4c03-8fcc-fce265cdbf0e@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efe20a00-9a7c-4c03-8fcc-fce265cdbf0e@suse.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 01/31/24 at 09:31am, Nikolay Borisov wrote:
> 
> 
> On 30.01.24 г. 15:43 ч., Paolo Bonzini wrote:
> > On 1/24/24 13:55, Kirill A. Shutemov wrote:
> > > The patchset adds bits and pieces to get kexec (and crashkernel) work on
> > > TDX guest.
> > > 
> > > The last patch implements CPU offlining according to the approved ACPI
> > > spec change poposal[1]. It unlocks kexec with all CPUs visible in
> > > the target
> > > kernel. It requires BIOS-side enabling. If it missing we fallback to
> > > booting
> > > 2nd kernel with single CPU.
> > > 
> > > Please review. I would be glad for any feedback.
> > 
> > Hi Kirill,
> > 
> > I have a very basic question: is there a reason why this series does not
> > revert commit cb8eb06d50fc, "x86/virt/tdx: Disable TDX host support when
> > kexec is enabled"?
> 
> While on the topic, Paolo do you think it's  better to have a runtime
> disable of kexec rather than at compile time:
> 
> [RFC PATCH] x86/virt/tdx: Disable KEXEC in the presence of TDX
> 
> 20240118160118.1899299-1-nik.borisov@suse.com

Runtime disabling kexec looks better than at cmpile time, esp for
distros. While from above patch, making using of kexec_load_disabled to 
achive the runtime disabling may not be so good. Because we have a front
door to enable it through:

/proc/sys/kernel/kexec_load_disabled

If there's a flag or status to check if TDX host is enabled, and does
the checking in kexec_load_permitted(), that could be better. Anyway, I
saw Huang, Kai has posted the tdx host support patchset.

> 
> I'm trying to get traction for this patch.
> 
> 
> > 
> > Thanks,
> > 
> > Paolo
> > 
> > 
> 


