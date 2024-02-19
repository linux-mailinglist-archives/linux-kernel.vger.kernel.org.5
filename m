Return-Path: <linux-kernel+bounces-71218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BA185A214
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620E028119C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D592C1BF;
	Mon, 19 Feb 2024 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f65QS7Eq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A4D2D042
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342615; cv=none; b=OBmY58n8iBJe3gCy4ycIQtEO826JirSJRLDsypLR5FmGDuv5A1a33e7JkAeOwAYcrgFqCibqe4fX8frqsOS25zzzAXYA4MRheg4Mr4K7CgtiuZ1wQQhi38vrAFOhD4O3DTpKWCmPQl6AzoAVBJz4UHQmzf9q24kCLyirQzvVPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342615; c=relaxed/simple;
	bh=LLkUNPNEJ+hvVzwrPQtRZ5UUprEPCMjsaHbdoF/l7pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hexFX9wdoh/+1aUGDRK/7jMJrMWRT/24tHKJL+hgab4qCWKCew6WGADta7pUk0PJu/i4JnYNYVdFZwuOVddYzg/NRyH8O9dYd05ERcf0eNUN5LwQEo3AdKziwbX1Va8TBptGznMzoLjckecgVKg9HNEqMii4tikf4nWC8+un1Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f65QS7Eq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708342612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TORTFmeK/rTrufvipbgOGnTjCcaJenkxzXpRYRFY+R0=;
	b=f65QS7EqSVp14GcOzqa8GXiUjE64HfjF18RzyS/bGPdXRA7u6dahNQKW+uVajERSQOqubC
	ApPSslVbukjcVQSNR20VC/OD8yA7wJ37g7Rp1kWxPjQ8x8YcHnLT5kWVhfp/zLZqoTtVUt
	mMAO3cxQh+/PECQZT4y8SVbJyPS3SQk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-SBEEdG1FMEq9wTIVVOM19Q-1; Mon, 19 Feb 2024 06:36:49 -0500
X-MC-Unique: SBEEdG1FMEq9wTIVVOM19Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 187F6811E81;
	Mon, 19 Feb 2024 11:36:48 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6371C1C060B2;
	Mon, 19 Feb 2024 11:36:47 +0000 (UTC)
Date: Mon, 19 Feb 2024 19:36:44 +0800
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
Subject: Re: [PATCHv7 01/16] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Message-ID: <ZdM9TPVafuHJ6QQp@MiWiFi-R3L-srv>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-2-kirill.shutemov@linux.intel.com>
 <ZdLc61QMLu3L0Eqv@MiWiFi-R3L-srv>
 <a2cmua3qhbmhgzdxl5mszuvatnkyf4nwxjciurguhgbulrhin4@gvswvfats5er>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2cmua3qhbmhgzdxl5mszuvatnkyf4nwxjciurguhgbulrhin4@gvswvfats5er>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 02/19/24 at 12:08pm, Kirill A. Shutemov wrote:
> On Mon, Feb 19, 2024 at 12:45:31PM +0800, Baoquan He wrote:
> > Do we need add the entry printing for ACPI_MADT_TYPE_MULTIPROC_WAKEUP
> > now in acpi_table_print_madt_entry()? Surely it's not related to this
> > patch.
> 
> Good catch. See patch below. Does it look okay?

Looks good to me, thanks.

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> > FWIW, 
> > 
> > Reviewed-by: Baoquan He <bhe@redhat.com>
> 
> Thanks!
> 
> From 23b7f9856a3d6b91c702def1e03872a60ae07d0e Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Date: Mon, 19 Feb 2024 11:58:19 +0200
> Subject: [PATCH] ACPI: tables: Print MULTIPROC_WAKEUP when MADT is parse
> 
> When MADT is parsed, print MULTIPROC_WAKEUP information:
> 
> ACPI: MP Wakeup (version[1], mailbox[0x7fffd000], reset[0x7fffe068])
> 
> This debug information will be very helpful during bring up.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  drivers/acpi/tables.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index b07f7d091d13..c59a3617bca7 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -198,6 +198,20 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		}
>  		break;
>  
> +	case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
> +		{
> +			struct acpi_madt_multiproc_wakeup *p =
> +				(struct acpi_madt_multiproc_wakeup *)header;
> +			u64 reset_vector = 0;
> +
> +			if (p->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1)
> +				reset_vector = p->reset_vector;
> +
> +			pr_debug("MP Wakeup (version[%d], mailbox[%#llx], reset[%#llx])\n",
> +				 p->version, p->mailbox_address, reset_vector);
> +		}
> +		break;
> +
>  	case ACPI_MADT_TYPE_CORE_PIC:
>  		{
>  			struct acpi_madt_core_pic *p = (struct acpi_madt_core_pic *)header;
> -- 
> 2.43.0
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
> 


