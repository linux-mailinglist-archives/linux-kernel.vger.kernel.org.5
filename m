Return-Path: <linux-kernel+bounces-142469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1B38A2BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC761F222B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B451E53E13;
	Fri, 12 Apr 2024 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsnN7CMH"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76073535C4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916476; cv=none; b=L7N+VlVQVTAek5QlfjwFojyCbg/YiwoBV+YurzsLLkG39CVfUUd9Pp5PCRpHTaJA21fQmgm/rADroqpQcIWRuPwJ95G78yxBygFCuTLZ5RvduXH7xY42Gn2b3mIaTyiu++p+7JR8JpYgqyVjBtiXdke3aIYfHA5I16jzIupkBZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916476; c=relaxed/simple;
	bh=TUv2nJagR2r4uAvL25YF8nJB2rsmp4p08hUHWGbC6R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0oUw//7mWDACaRDEf3Qzwk19LhqRtscBJ3SEuZOSkDOAquLe42rUYcS8vsQ61rnOr9O+FhPV3S8NVq8Yn7NyeY0E/QHGiLnQ3juS1KzR40yVmyvaquVxxt8iUGbr/Lv1aQd3XGDY9UmFiEmZY55vu/lPYIOJoIW9Wf1rTtjIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsnN7CMH; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4702457ccbso85425566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712916473; x=1713521273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VzUzE7x+skOX5qaEeZqxkVm0YOlBS5qhNXsJv+OjBw=;
        b=nsnN7CMHXIowAa7bjYVFGqEzZA/H9hKhWlMB13uy8nDDh57Ba2/hwGJmsN5xii0hhj
         XR9eq01K1dotulBX4Akd4p4t/FBWINfsV4l67pgPsKRYl6LZIDw0oWX8TyQV5DM9EhXv
         KVRP2e+o4052jCBxQE9aCxKwoFqI+AX6JMGUfIEV2N+ET6cbtBmISWpk0ZKyVa2q8P3t
         tQLXWxuRTNiCBF8R2sR09yWED5cxXITr99Oywp5eC6k5WbFeBqQeke2stUmHPGMb8ls/
         pWYcz3WDIQS+FDbBrBY9/TJCNasra7DIr/WWAZ9TM2ARuLTHu9zbw8a0Dco3EPMp9Ly9
         R4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712916473; x=1713521273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VzUzE7x+skOX5qaEeZqxkVm0YOlBS5qhNXsJv+OjBw=;
        b=shmNHyYHcn2ERb7XsoyQMDZwQtDPMYjfdQGmiyMoOdLRTzAe/3LHoDLxlOlUjI87hT
         nN6rA95TSY+OiFrVyNmkIPIyrLPICm9eS+TlAaCIrLaTNrEImq0lpTynznDQNg4bGor8
         V6R+jQd9aV9ri+shC9shaKxv0KKpug4k5OZuyNnFte72YROLOtG4mPfOEjR5Iq4cjw27
         2FggFLa5eT/kHAsWSNlnBDnCkOvSS/Hl25BExSOOtBC8VlRF1Gh27n9968d6ZTV+XRtH
         61HOQgDPx8CpYWdgHr0ZtHzfXHl3SrfajR1/+T7T74FXcdNGH0PcUeY3gFbaG6OeZDbY
         xItg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ+YCZN9hausdXiq8yVWjkXyv1Ii+ffPrisOcn4CY0BpcySEy7ijDKmAV4KqqGstaNyqU93O8VvA5ZtlD2ANPPe3bSezMaJz3ommxU
X-Gm-Message-State: AOJu0Yx/TX9Bewl6RoNgVlUMBfU+eA/3fdyuwX9AgQXg4KlCfVfriEnW
	bhbprAJbfQaUTJa+0OOFhDUtqh8szKXzekd7XABI3Jt/AW8UqQMa
X-Google-Smtp-Source: AGHT+IHZOF0dTcDrT6PJW33QyI+Y6R8xFKEV+O9ONmCIqhCk04E6SlGXbqI73c+6gSpg8N7+03Al7A==
X-Received: by 2002:a17:907:6e8c:b0:a4e:3fad:b973 with SMTP id sh12-20020a1709076e8c00b00a4e3fadb973mr1609050ejc.65.1712916472172;
        Fri, 12 Apr 2024 03:07:52 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id bq16-20020a170906d0d000b00a51aa517076sm1664208ejb.74.2024.04.12.03.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 03:07:51 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 12 Apr 2024 12:07:49 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 5/7] x86/bugs: Only harden syscalls when needed
Message-ID: <ZhkH9aFKw+Y1utPV@gmail.com>
References: <cover.1712813475.git.jpoimboe@kernel.org>
 <97befd7c1e008797734dee05181c49056ff6de57.1712813475.git.jpoimboe@kernel.org>
 <20240412001522.3zp2mzked4ksglkl@desk>
 <20240412035740.ojgvlqahqlm2umsx@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412035740.ojgvlqahqlm2umsx@treble>


* Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> > [...]
> > > @@ -1720,6 +1744,7 @@ static void __init spectre_v2_select_mitigation(void)
> > >  
> > >  	case SPECTRE_V2_CMD_RETPOLINE_LFENCE:
> > >  		pr_err(SPECTRE_V2_LFENCE_MSG);
> > > +		setup_clear_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
> > 
> > I don't know if it intentional, this seems to be the duplicate of
> > X86_FEATURE_INDIRECT_SAFE clear later in SPECTRE_V2_LFENCE mode. Also it
> > seems a bit odd to do this here in SPECTRE_V2_CMD handling.
> 
> Yeah, I accidentally left that in from an earlier implementation.  It's 
> harmless but I'll clean that up too with a new patch unless Ingo wants to 
> remove that line.

Lemme remove it entirely from x86/urgent, so that you can submit an updated 
patch with all feedback included.

In addition to the above line, Pawan's suggestion of doing it in C via 
cpu_feature_enabled() looks quite a bit simpler and easier to read & argue 
about, right?

Thanks,

	Ingo

