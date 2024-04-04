Return-Path: <linux-kernel+bounces-132159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 690A3899061
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE381F27123
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547E313C677;
	Thu,  4 Apr 2024 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZWb4mMFB"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF34713C3EB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712266095; cv=none; b=psCZkl/0RR8oiV+POx7CWktLEmCia66tUzqiLFYv0HLufpu74w6V5OoovvYAkCfRMpbxTKHrfaKzFQGQVl9CF74rtNWa67/V+7lAAPsHUsXiWzETJx7CBp+u1Llna52WcvFfASWP/8Db5rnRegA04sBikWaWtgEAGfskoIGhnP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712266095; c=relaxed/simple;
	bh=npMODBQKA2nj4U5DnfvWas5C+UgEISrVD0B3z/+vB1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWnFyWW+OUkuAu1V55SLC3GT4WZ5pH3ErNsacqvkJWSGJpyjIkMVnG4xRYgvl1b9RuD//7H0787vsnACDiJlLNFSI5ZIQLlYc4DxEdr2xBt4NWrCXu/eLgMjK71U2SbFdhhX5ReSDHXuG++bZ4VwTThHGUaN4cFJz/bs+eyGox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZWb4mMFB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343cfa6faf0so586632f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 14:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712266092; x=1712870892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OUdguqwR0wl7IoJc/6ZxoQ05I+NWMpwGK+WJht4B5k=;
        b=ZWb4mMFB5iYnGiZRg9sNjT3Y8xx9ODzb44WD3HBzHx4ejat66hjJ3E0rPok3bTQ5gD
         uB1rFBJS3yzbw9Y1D/o3ACbHOH2OTxtzvHjPUL6GLj68t67H5lHjrknbILcIyJ3316M6
         k02J6k465qgy3qubGD/gM5atwobS2X8Kc7eCLNu9CPcWZTdhYWTaZIQdEUZTlphkzt5N
         l3fOUlBf45gWI9gXpa/WNP/R+Rim7IiocbqCc0ab7N7+7PPx3jswQZG/f/sDSi8bjcD5
         ge4rnq8Gvg/zTnZFnzF72KBxkJh7i7PKm0BFU4yzgBk2Ot1jwgyyXc2fW++JgbBIam4m
         /NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712266092; x=1712870892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OUdguqwR0wl7IoJc/6ZxoQ05I+NWMpwGK+WJht4B5k=;
        b=mHYZn7eOL/kqWN7+Y3oMfqqLPcPoJHXj5DRCa5rbgEAIC4HbCifinO9neAxFu1FuVB
         p7JhhGf7ChT2ginxEte+dTrVPXBRO3ETl1z3MzsJ0YMfdyVBjFIj+UkqXboKWzOZsF6S
         7xlNsaM35NfDBzQ9LDLISyRH28m1x4ZN+P3AppFJoUG41N1tvA3LKspOAswffF7ekTYZ
         zA4EJ54gNff5mcez2fOpMoJfJba63aw/d3zFoNZGQoEMd27mZNDNtG5lNLIF6kNPE13u
         w5Nu739WaxUD1UuWLy2Iw217K1W/Q5WtYa5jcnOe/HdLZV8GcVEo6TaeFlP2j6QsDwqT
         Hw8w==
X-Forwarded-Encrypted: i=1; AJvYcCXhWfqTfHUrSlNhI34nh7mc3f2R2unYblYXWqS9yvvKHZI2A+74/xXRQ3mjkxca3jxABy8VVfUCwjmJXECr38VCZx9o1M6oXW/yaqA7
X-Gm-Message-State: AOJu0Yz5RFx7YtuD06jahNUmRuWSDKGf9MofLA01icXqUFvALwrrDyui
	CkQTjH3YoLpmduwRD3/1P6cRTScOtgu+kcgrRLEt9ER1JKFBhR4+2HCzWPJ1HU5eRfgmyEaIqkv
	il4EZqib14p3/387OsU7UKtzdtyhNfEwnLQfe
X-Google-Smtp-Source: AGHT+IGJXJt3z9AjFNT8jY0zgvGJQUXCyam/rKGlEORAE2+JiSEdT0O8DCZgFu4KuDOhR1WF8ozN+G8rXaz8Y8+rApU=
X-Received: by 2002:adf:ce0c:0:b0:33f:84a1:7eb8 with SMTP id
 p12-20020adfce0c000000b0033f84a17eb8mr3002011wrn.1.1712266091794; Thu, 04 Apr
 2024 14:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312155641.4003683-1-yosryahmed@google.com>
In-Reply-To: <20240312155641.4003683-1-yosryahmed@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 4 Apr 2024 14:27:33 -0700
Message-ID: <CAJD7tkYg3KbmMHg0jt8x0Lp9zss6qr-9PnbwmYXGfa0uQ_Xyig@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/mm: Use IPIs to synchronize LAM enablement
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 8:56=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> LAM can only be enabled when a process is single-threaded.  But _kernel_
> threads can temporarily use a single-threaded process's mm.
>
> If LAM is enabled by a userspace process while a kthread is using its
> mm, the kthread will not observe LAM enablement (i.e.  LAM will be
> disabled in CR3). This could be fine for the kthread itself, as LAM only
> affects userspace addresses. However, if the kthread context switches to
> a thread in the same userspace process, CR3 may or may not be updated
> because the mm_struct doesn't change (based on pending TLB flushes). If
> CR3 is not updated, the userspace thread will run incorrectly with LAM
> disabled, which may cause page faults when using tagged addresses.
> Example scenario:
>
> CPU 1                                   CPU 2
> /* kthread */
> kthread_use_mm()
>                                         /* user thread */
>                                         prctl_enable_tagged_addr()
>                                         /* LAM enabled on CPU 2 */
> /* LAM disabled on CPU 1 */
>                                         context_switch() /* to CPU 1 */
> /* Switching to user thread */
> switch_mm_irqs_off()
> /* CR3 not updated */
> /* LAM is still disabled on CPU 1 */
>
> Synchronize LAM enablement by sending an IPI from
> prctl_enable_tagged_addr() to all CPUs running with the mm_struct to
> enable LAM. This makes sure LAM is enabled on CPU 1 in the above
> scenario before prctl_enable_tagged_addr() returns and userspace starts
> using tagged addresses, and before it's possible to run the userspace
> process on CPU 1.
>
> In switch_mm_irqs_off(), move reading the LAM mask until after
> mm_cpumask() is updated. This ensures that if an outdated LAM mask is
> written to CR3, an IPI is received to update it right after IRQs are
> re-enabled.
>
> Fixes: 82721d8b25d7 ("x86/mm: Handle LAM on context switch")
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

There hasn't been any further review comments on v2, and the merge
window has been closed for a while now. Do I need  to take any further
action or send a new version of this series?

