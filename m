Return-Path: <linux-kernel+bounces-46704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CA18442F5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037E81F23837
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2DC86AC5;
	Wed, 31 Jan 2024 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDsw4kK2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B52480C11
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714640; cv=none; b=m7lJ+QoswkwqkHwsWB8tToDxn2OEChfJRxQIYZz7Pof5ftrDJ9U2+ShupAIjEPqwFL4n5rhL1VOr6NxVY9Z3GChgrSR7BFkahRCJ9tWTiC43GlecSjK7sOggEXS8TocHnB9iHKJ/fhSa9eFhSrr9BNMlJGLAvOI3klBrhVHwUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714640; c=relaxed/simple;
	bh=nPSaMyCuayy/I+QR1Qo4ECI40Tw9VjSdBcgrujLtNpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wr1J9vmATv8gLAS+b0L6kzGGd/n3trURfMyfJzYgFuosMMujlSfT2U+VljuPtbVQBDY2oLbNv0Wz35Cmzs824mfiv6ou+Jx7pyjG3LjRjvoJ+3Afv5BtOiu3FNqSRFl38yH/YFnw81PAuh7G5B3LJafyEkmTdeLjs/aPRkA1LSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RDsw4kK2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706714638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ShXEhsnOf4Qa8k8iTBTenpYOXlavsQuWnbVyMIJ1hzA=;
	b=RDsw4kK2gHDkvRchbESRRC60cPHjZZqqw3zrjfW6bgNbNwlMhylHEg2cSHUBCHGVuVD6+I
	gRGd7nHLdAWHuFmboN+9PyqQ/UAEZLDkZvg2OaoKdnnKV4pGs3W/sNev38HPptHfRXCdY6
	oU/Rn7UW17wm+uul0JiSCFUduxJ7XmQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-DXhB-mCfPv-1sXMqsS7BtQ-1; Wed, 31 Jan 2024 10:23:55 -0500
X-MC-Unique: DXhB-mCfPv-1sXMqsS7BtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4853F185A784;
	Wed, 31 Jan 2024 15:23:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 32C088B;
	Wed, 31 Jan 2024 15:23:53 +0000 (UTC)
Date: Wed, 31 Jan 2024 23:23:50 +0800
From: Baoquan He <bhe@redhat.com>
To: "Huang, Kai" <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv6 00/16] x86/tdx: Add kexec support
Message-ID: <ZbpmBulaR7eft/CE@MiWiFi-R3L-srv>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
 <efe20a00-9a7c-4c03-8fcc-fce265cdbf0e@suse.com>
 <ZbpBbAkPxQZ6gHoE@MiWiFi-R3L-srv>
 <5d91fc11-0b3b-40f0-872d-abdbb4038f76@suse.com>
 <BL1PR11MB5978633DF36A69F8020818E1F77C2@BL1PR11MB5978.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5978633DF36A69F8020818E1F77C2@BL1PR11MB5978.namprd11.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 01/31/24 at 01:07pm, Huang, Kai wrote:
> > > Runtime disabling kexec looks better than at cmpile time, esp for
> > > distros. While from above patch, making using of kexec_load_disabled
> > > to achive the runtime disabling may not be so good. Because we have a
> > > front door to enable it through:
> > >
> > > /proc/sys/kernel/kexec_load_disabled
> > 
> > AFAIU it can't be enabled via this sysctl because the handler for it expects
> > only 1 to be written to it:
> > 
> >       2                 .proc_handler   = proc_dointvec_minmax,
> > 
> >       1                 .extra1         = SYSCTL_ONE,
> > 
> >    994                  .extra2         = SYSCTL_ONE,
> > 
> 
> This is also my understanding.  
> 
> The documentation also says once it is turned to disable we cannot turn back again:
> 
> kexec_load_disable
> ===================
> 
> A toggle indicating if the syscalls ``kexec_load`` and
> ``kexec_file_load`` have been disabled.
> This value defaults to 0 (false: ``kexec_*load`` enabled), but can be
> set to 1 (true: ``kexec_*load`` disabled).
> Once true, kexec can no longer be used, and the toggle cannot be set
> back to false.

you are quite right, I have never noticed this, thanks.

Then then mentioned patch looks good to me.


