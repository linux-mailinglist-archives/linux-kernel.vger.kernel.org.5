Return-Path: <linux-kernel+bounces-40306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 793CB83DE23
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FE928222E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4DD1D52D;
	Fri, 26 Jan 2024 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V007I65a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04C1DA21
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706284692; cv=none; b=PLZXwfQZ2tgboMdQ0wqumG8S15a18ddvvzuYgD5O2e1sQJmt98f9bhUdIj2LfXlMGNVQD8C9S/kU2TLm05i1Un5Xi4RtYTnclKGRZslgNqryIBxYuKXndflZGcc8nvprL5FsESfKEpyUuqrVjxXx8QjeUuNeMyf8MMEb7CB8Gok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706284692; c=relaxed/simple;
	bh=ilnm1wNghs09Z/CTi1P721/uUCE6aBg4rWcPoCAoqQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmZMZ/eGXiyoEZW2E8e0skm9uhZtnCnDwCyiQsSTD85cwqEEzvHttNuLLDV85PzeBEMVuIzmEZnNZm2Dvg43pOMnmSe+sVygkwM6F0H6jvCcz2mpzE0kx969Yzj/lIC9DMnj/kbUcjjWgODZJCdXr5538EHWITFFUQgwQRaoGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V007I65a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706284689;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lg7dGqFnTAiQObLEEkoZsTTFKEGghBhKhIxyZIgynYY=;
	b=V007I65a5Q8eNRD7sMSYyAUarsumoSvgIZ8xhOi9WR1hVOR951AQ+Or4DhiqrRQuGaDdWp
	zcwh2P4GKNVtO+KXqGrqgYr2afE3xLsRzYr3HSkwBONGH0Mx1AT0dlFaOHGz20v4jVIIxP
	hWgWzLeBp9JA5qveZtAGy8z8VFjcWP8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-jG-sTitgOSWX5w2TxXHjZg-1; Fri,
 26 Jan 2024 10:58:06 -0500
X-MC-Unique: jG-sTitgOSWX5w2TxXHjZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1CCD28B6AA8;
	Fri, 26 Jan 2024 15:58:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.198])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C7D8C15E61;
	Fri, 26 Jan 2024 15:58:01 +0000 (UTC)
Date: Fri, 26 Jan 2024 15:57:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Randomness on confidential computing platforms
Message-ID: <ZbPWht37uWZGhp4m@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com>
 <6afe76be-90a7-4cf7-8c6c-23e6a14f8116@suse.com>
 <DM8PR11MB5750C6641F0951928E95439BE7792@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM8PR11MB5750C6641F0951928E95439BE7792@DM8PR11MB5750.namprd11.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Fri, Jan 26, 2024 at 03:42:12PM +0000, Reshetova, Elena wrote:
> > 
> > On 26.01.24 г. 15:42 ч., Kirill A. Shutemov wrote:
> > > 4. Exit to the host/VMM with an error indication after a Confidential
> > >     Computing Guest failed to obtain random input from RDRAND/RDSEED
> > >     instructions after reasonable number of retries. This option allows
> > >     host/VMM to take some correction action for cases when the load on
> > >     RDRAND/RDSEED instructions has been put by another actor, i.e. the
> > >     other guest VM. The exit to host/VMM in such cases can be made
> > >     transparent for the Confidential Computing Guest in the TDX case with
> > >     the assistance of the TDX module component.
> > 
> > But is this really a viable solution in the face of malicious VMM? It
> > assumes that if the VMM is signaled that randomness has been exhausted
> > it will try to rectify it, what if such a signal can instead be
> > repurposed for malicious purposes? Could it perhaps be used as some sort
> > of a side channel attack ?
> 
> The idea here is that it is not necessary VMM that is the cause why the
> RDRAND/RDSEED fails, so if this is the case, VMM can in theory do smth
> about the situation.
> 
> We have been thinking about if it can create an additional attack vector,
> but were not able to come with one. Do you have any in mind?

A guest might exit claiming failed RDRAND when in fact no such problem
occurred, as a way to mislead the host admin into taking action against
other guests.

If the CPU performance counters could report RDRAND exhaustion directly,
then the host admin could trust that information and monitor it, but the
host shouldn't rely on the (hostile) guest software to tell it about
exhaustion.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


