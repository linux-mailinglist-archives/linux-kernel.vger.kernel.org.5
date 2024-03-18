Return-Path: <linux-kernel+bounces-106468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F2087EF0C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C1328446E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052385577F;
	Mon, 18 Mar 2024 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="VAyHdp2V"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B495D374CB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783490; cv=none; b=eAgCD7zeNLVU5MsHIISRAWuamsgsJpc5xCcY3Vh55V4snaRHiD1WmlR/bnJlEZu6h+EAZOgkhX1IFvA1asMjYZn82fgpNGG8aCjwzHHcWZipbNxZOaXZCuJ+gydlfv9GaucrPR8rxRwXGQNFMYwDDmKzuDQ2tkwjWdRU3Lwpa7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783490; c=relaxed/simple;
	bh=hPFv+RGaYMSlxCJMkHIePzAsGOaNOQVxwte45Qtempg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McNPb1Y9eMt3AqV0Zpupayzzw5NF+Uwgj6jPQP5/sbpi1CvY9+uYdxY8uyLKrvNyye53QB6zBI15+NcKW7O9cUNHGpjqHHt44wyrVM5jQJqYNu9BwtM6W8KbSfNO+TTov5IdGIb4DTYBVMkc4EMBbKnjo+heXUAR2XZHB64XR0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=VAyHdp2V; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-609ff069a40so54429177b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710783488; x=1711388288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tQ/GoT+qLpaPN7pTPDFxNZKaxLFNg4IP20IBxyg9WHU=;
        b=VAyHdp2VaF4yf6YsGlGPTMIhc5iQOdxsEFoYGKENk6ibV75ScuZ+mRrwL4LATYT+BP
         cACQ4mGODNSVLmMOJGSKMfeIfJQNrR8Sv1+Q/5z8s8c2cvJ7bm2pOwMqfAYDHuROdH2n
         VhkdN5LRY+lksHDN1OlsrebvI3VsuO0kBXKSvRTpWkrAN6829YsvrmxbM5kV7blc+3Rm
         /cRlylE9BGC/qo9zmbrLbJ7SRf1RuF9LPGUfiy0yIfFaG6vT+s6gwo4niphsmRz0vIqg
         o0h+1uFXH2snVoLT8erEb50cTmBRd14TXMBoWBOTqVWDbjbaMvzVeAKx55NzG4r0EB8I
         J7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710783488; x=1711388288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQ/GoT+qLpaPN7pTPDFxNZKaxLFNg4IP20IBxyg9WHU=;
        b=pIaX+OFa9nuMXhvdA28XOywf1gXfeCRFBn58IbUEKKMH6C4DJ8LoylEFckB/sincEe
         PusBpSoVySOzFYJv9BwqfLiQupxFuJ1yvwBv5GKmfw8SpznSgjlGKu9F6gJnuW45LcP5
         LyUiK7KUNf0pk6mcGwqSgBY8tySTS6VbuGt1Dz5jUZAhB7I+29K3i4MJ2TRvG+BOtvNJ
         BX3fgIoocPCr32BGyCLBBU/nEw9fsTEOTxjtB/dTYAseT7a6YWocl5KVYbv5UXe7RnfZ
         OllZx9lhXxbvpPVQhPbAAVTWMKDGtgfHYd6NZpDwaASM1EMOBfiO/LlmkarZg1eNa+w7
         pwJg==
X-Forwarded-Encrypted: i=1; AJvYcCVuiXanrNyEcrihudXefcR59zXcXS3DOkXSg/1ek8R+z1b57853y1X2motPCt7YobzaiMxvL+MuPWYC7krdftasBaiWUkxyVo0ikppq
X-Gm-Message-State: AOJu0Yw0UGfNzL9wCGHpRxjaF9FKEVZ04iFFVY7NNGKnS0XoMlJyc+wI
	06Paw8DIYKwriDjRZTmC5s4Rq2F/K0xmTNxVR2W0knoOSBJnF4KTnNzfswDnbj2dNoYLU/QBgFn
	PfkoyG4ELz7kC7CTOgZ7/ygRPp/5MpPcS1NQwMQ==
X-Google-Smtp-Source: AGHT+IGI4AZ0kuz5ttCn79/hpiKk+rHMF3x+qjTJSggJqgGyjT+A46w36muUkMqrDbG5g6EMUzo//pcfoym7S3BGVyQ=
X-Received: by 2002:a05:6902:389:b0:dc7:4b43:db3f with SMTP id
 f9-20020a056902038900b00dc74b43db3fmr7681050ybs.21.1710783487828; Mon, 18 Mar
 2024 10:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com> <ZfNTSjfE_w50Otnz@casper.infradead.org>
 <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42>
 <ZfNWojLB7qjjB0Zw@casper.infradead.org> <CA+CK2bAmOj2J10szVijNikexFZ1gmA913vvxnqW4DJKWQikwqQ@mail.gmail.com>
 <39F17EC4-7844-4111-BF7D-FFC97B05D9FA@zytor.com> <CA+CK2bDothmwdJ86K1LiKWDKdWdYDjg5WCwdbapL9c3Y_Sf+kg@mail.gmail.com>
 <74c82d8a6b5f490784cc8f16fa7d2c12@AcuMS.aculab.com> <CA+CK2bCksQyhNWh-ZonMQSdcr95dDCfe4W0VNVhG+0i7et1fiw@mail.gmail.com>
In-Reply-To: <CA+CK2bCksQyhNWh-ZonMQSdcr95dDCfe4W0VNVhG+0i7et1fiw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Mar 2024 13:37:29 -0400
Message-ID: <CA+CK2bAuH80JhTR9X6cbcHA3xH01sTXeDQBnXO_rUDGak-c+iw@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: David Laight <David.Laight@aculab.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Matthew Wilcox <willy@infradead.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>, "brauner@kernel.org" <brauner@kernel.org>, 
	"bristot@redhat.com" <bristot@redhat.com>, "bsegall@google.com" <bsegall@google.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"dianders@chromium.org" <dianders@chromium.org>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, 
	"eric.devolder@oracle.com" <eric.devolder@oracle.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>, 
	"hch@infradead.org" <hch@infradead.org>, 
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "jroedel@suse.de" <jroedel@suse.de>, 
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "kinseyho@google.com" <kinseyho@google.com>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "lstoakes@gmail.com" <lstoakes@gmail.com>, 
	"luto@kernel.org" <luto@kernel.org>, "mgorman@suse.de" <mgorman@suse.de>, "mic@digikod.net" <mic@digikod.net>, 
	"michael.christie@oracle.com" <michael.christie@oracle.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"mjguzik@gmail.com" <mjguzik@gmail.com>, "mst@redhat.com" <mst@redhat.com>, 
	"npiggin@gmail.com" <npiggin@gmail.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"pmladek@suse.com" <pmladek@suse.com>, 
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"surenb@google.com" <surenb@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"urezki@gmail.com" <urezki@gmail.com>, 
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "vschneid@redhat.com" <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

> > Perhaps a 'garbage collection' activity that reclaims stack
> > pages from processes that have been asleep 'for a while' or
> > haven't used a lot of stack recently (if hw 'page accessed'
> > bit can be used) might make more sense.

Interesting approach: if we take the original Andy's suggestion of
using an access bit to know which stack pages were never used during
context switch and unmap them, and as an extra optimization have a
"garbage collector" that unmaps stacks in some long sleeping rarely
used threads.  I will think about this.

Thanks,
Pasha

