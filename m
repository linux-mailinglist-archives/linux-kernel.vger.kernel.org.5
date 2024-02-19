Return-Path: <linux-kernel+bounces-70715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4C8859B71
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68CEB21D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E711CD24;
	Mon, 19 Feb 2024 04:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3ZrRrdk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421591CA98
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708317979; cv=none; b=f0v5zy5MdkprzGJq5AvEkOy+Hr+uR7p/JBPEnXC6r7/DZjGErWV97JFwH0kt3eV71AgYJkY9BRKaJ9PUSzWGOVVIDuPbKA5xyQS6GaRhU/FGcqeZvRDL/ksdX+E5zRJvGvqZQVFgWhGhb8xDSGtcP0OfAUrHBSO6smnNWahhhGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708317979; c=relaxed/simple;
	bh=vLqLzH3ZR5ExPctciaBnN6OY0xRtFwrIXQU1oSpMlGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sexQla5D/8xtzqF5HeSQrebFrW2RX96MWuSvMNJtTZgQsqJBSkL66d4CSbE2jOjtojdnnfCyTF8hiPs6YlnltjuIK7w+ZTiFxutxBm+dJd0gw0Qgw5zq+O0X00tX198Et0w2P1Tg0oN+l5WhtFJzf6/grkwWLurXyVnRfV5ZCus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3ZrRrdk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708317976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dLXISstnHfpiIpRnh79Jrtq+xnWJNyw4ml3k09pwYAA=;
	b=c3ZrRrdkwqnl1Q0uUhGzyo0L47EA2ctrlWNyCIfqs5yO9C/BeaKqfAr0Qr6ztEQd4hewiW
	NS3Y6HfVLPMp6pkFcFWRS/dopAM47sgQ8PBpv7ddcz07qk+WM1fwScFn6ANALVWh6OvhOv
	REOOP4JMUypPhQffrKGL5FeHgJOpo7Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-3JnxGZhPN4OftMT9bGeA-A-1; Sun,
 18 Feb 2024 23:46:12 -0500
X-MC-Unique: 3JnxGZhPN4OftMT9bGeA-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E49291C0BB43;
	Mon, 19 Feb 2024 04:46:10 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 36F7BC03282;
	Mon, 19 Feb 2024 04:46:09 +0000 (UTC)
Date: Mon, 19 Feb 2024 12:46:03 +0800
From: Baoquan He <bhe@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCHv7 02/16] x86/apic: Mark acpi_mp_wake_* variables as
 __ro_after_init
Message-ID: <ZdLdC4B2ov4JxxXf@MiWiFi-R3L-srv>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-3-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212104448.2589568-3-kirill.shutemov@linux.intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 02/12/24 at 12:44pm, Kirill A. Shutemov wrote:
> acpi_mp_wake_mailbox_paddr and acpi_mp_wake_mailbox initialized once
> during ACPI MADT init and never changed.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Baoquan He <bhe@redhat.com>

> ---
>  arch/x86/kernel/acpi/madt_wakeup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> index 7f164d38bd0b..cf79ea6f3007 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -6,10 +6,10 @@
>  #include <asm/processor.h>
>  
>  /* Physical address of the Multiprocessor Wakeup Structure mailbox */
> -static u64 acpi_mp_wake_mailbox_paddr;
> +static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
>  
>  /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> -static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> +static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_after_init;
>  
>  static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
>  {
> -- 
> 2.43.0
> 


