Return-Path: <linux-kernel+bounces-44786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B82842763
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C617F1C24133
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ED17E578;
	Tue, 30 Jan 2024 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfHT3XZw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B43A7CF08
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626791; cv=none; b=XsMnj0+hmqFqdeL4fu+Ea2P4Rf+oAU7nGUw07uPD1ng4gv+bXkeNmZrbdPArFi7/fwBTe6DAQhSnkfK5r9Qcmrjeri3YMEJmop6CLt25LTgUd+jnCNURu8G2kehD0vYZxs+W5nnffHM7nKcljfk0bgXJgd69jYS4gAt/IquPrt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626791; c=relaxed/simple;
	bh=1tgAgVSY1WXEHtXlxjinJFnJmsZeG3N/wjN5CzUBIZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9XlXop0OfIT+PlmtK/PFDXxrSQihrbunqNeOabuHRqGWJ66kMfGH6956pg2QCMqvZKbpgu+xLGmSn10s+ItJbiNvphI3u3KLgGIgVs0hvpQVoSnvQBz357gY1q2yhAQcwSfnsLj0jBGXrJITDVHFb425wqF1sOSRoGyzXjl6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfHT3XZw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706626789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1tgAgVSY1WXEHtXlxjinJFnJmsZeG3N/wjN5CzUBIZc=;
	b=QfHT3XZwK88KwZCpXEFti8+XLepgEDh5a29IMchVK9bNIebrC2r0GwtWqkv7qFqyrjOpFZ
	gerkr9qZJ2RmHMwzBMVdcQ+MbKn0IYim67LJY0O/6hkyKDT9fLlfTMQ5zl6aTPDOqIY9oS
	utzVlHACs7k3I9kFMKNroY26xP8XAX0=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-brbp_rAUMvyAJ6QGb7z09Q-1; Tue, 30 Jan 2024 09:59:46 -0500
X-MC-Unique: brbp_rAUMvyAJ6QGb7z09Q-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-7d3184d4989so2288011241.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706626786; x=1707231586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tgAgVSY1WXEHtXlxjinJFnJmsZeG3N/wjN5CzUBIZc=;
        b=eGeqxggks4NR2ELWHPUd6n4JsR244vuOTzgwIXWutCqtWm8D0z0tVbGz7ei6tp68Hq
         oK3feK8bpXEFK8G+pAdnMEiHO5Pq54szJB5tX1gZFm2EAebHZA2WQq9AdPxfC/czAAnU
         5yA8dB4DjBB8uhTrkp+TUdIP5bWTxKYj4cslgfYpb4T4/V5LMNBacpCc6kxmNHyOaVCe
         toLtUT0euqv4Xk/r6kohVE3meOggg+aAG0Omac7Z+birXm1wzs0uwkKxD4Xc2zbOkbr4
         xTJJTAv0VkWcZ3okHLWXrLAIsL7RNiQXzLeYNyED/OeGqJXJpm3sMZm35FNnCVRudzQ9
         Q1Vg==
X-Gm-Message-State: AOJu0YzzO0tQlz80SAJzRu+B/ca0biETVwcbbgNCLMbAzbZThBmyz+Sm
	wrxae//PXPIlyMfJ4O+FvRxhYdFoM+mVUw7hpX52KMNm0EfO5wPBGAE3T7Wwmnm0EASD4gLA5MK
	kRHnv3h7oXnt3AzT8Dei+VLNyAmoCSNczjSKRQIt9VlwjhohUhirTeYGzpaG08jW8tRWN6dOegR
	WJIsxSm1SJ+gpvRGdN2yVOXy5554YcIB6T89C5
X-Received: by 2002:a05:6102:2256:b0:46b:6a7a:30a1 with SMTP id e22-20020a056102225600b0046b6a7a30a1mr2218301vsb.6.1706626786409;
        Tue, 30 Jan 2024 06:59:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDswsxCrtanUl+20n0ev8u+2WT23/0oF8G8nh8pG6OHZQJZLcwjksCHvNXwQ79sSgdmASJmVb7xQIYR598Wyc=
X-Received: by 2002:a05:6102:2256:b0:46b:6a7a:30a1 with SMTP id
 e22-20020a056102225600b0046b6a7a30a1mr2218288vsb.6.1706626786190; Tue, 30 Jan
 2024 06:59:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com> <g7jh422ild6c23hjxvf7q2xtygkumbpynz4hcops7nvg5izvpp@r3oyhvssph2o>
In-Reply-To: <g7jh422ild6c23hjxvf7q2xtygkumbpynz4hcops7nvg5izvpp@r3oyhvssph2o>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Jan 2024 15:59:34 +0100
Message-ID: <CABgObfZiyx8hRsD37xZq5TNs9sRq48vLUxbOKa=HZ1vcr67sWQ@mail.gmail.com>
Subject: Re: [PATCHv6 00/16] x86/tdx: Add kexec support
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 3:34=E2=80=AFPM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Tue, Jan 30, 2024 at 02:43:15PM +0100, Paolo Bonzini wrote:
> > On 1/24/24 13:55, Kirill A. Shutemov wrote:
> > > The patchset adds bits and pieces to get kexec (and crashkernel) work=
 on
> > > TDX guest.
> > >
> > > The last patch implements CPU offlining according to the approved ACP=
I
> > > spec change poposal[1]. It unlocks kexec with all CPUs visible in the=
 target
> > > kernel. It requires BIOS-side enabling. If it missing we fallback to =
booting
> > > 2nd kernel with single CPU.
> > >
> > > Please review. I would be glad for any feedback.
> >
> > Hi Kirill,
> >
> > I have a very basic question: is there a reason why this series does no=
t
> > revert commit cb8eb06d50fc, "x86/virt/tdx: Disable TDX host support whe=
n
> > kexec is enabled"?
>
> My patchset enables kexec for TDX guest. The commit you refer blocks kexe=
c
> for host. TDX host and guest have totally different problems with handlin=
g
> kexec. Kai looks on how to get host kexec functional.

Yeah, that was right there in the cover letter (and I should have
gotten a clue from the many references to CC_* constants...). Somebody
pointed me to this series as "the TDX kexec series from Intel" and I
had some tunnel vision issues. Sorry for the noise!

But since I have your attention, do you have a pointer to the
corresponding edk2 series? Thanks,

Paolo


