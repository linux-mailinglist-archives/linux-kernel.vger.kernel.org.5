Return-Path: <linux-kernel+bounces-98048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7F5877409
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 22:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8132A1C209C9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9604A50A97;
	Sat,  9 Mar 2024 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1lhF684D"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C611364AE
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 21:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710020269; cv=none; b=LX/VefKCAPkY6Z9tAqrwZjLJ3gA62SpvdaWXyCr1zrHZDKIMORAeuM85Nxiic4HmzXzDB8J4AbtH+bpcSYDcsU5CCVqaDdHDyxJbXKz/g+xoY9Y4bUryHCOyoMWFNGMk8WfdRyCrlQhE8xaL/Q7O8iTYurQbXxzapn8W4PemLAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710020269; c=relaxed/simple;
	bh=slLuHbk3WtakpcBqnee9gqaMqDn9FcyIy1Pde24rTWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFruywjn8mr3MxI8+jTPo5mcNYAvMjcKqDFz9PfXft1XSE0Q8vwKHO+ouLs+ix0E1niLWhC1C/b3cI7NB3ePrh4iVZ4VO6ptSkvL3Vo3WflVgx3o8R+j9jr0ceCZGUDf/NA0kJJ9rcgIXb6ccUZgByPSqpWu7tlsgUmVbftbSRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1lhF684D; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51340e89df1so3444280e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 13:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710020266; x=1710625066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slLuHbk3WtakpcBqnee9gqaMqDn9FcyIy1Pde24rTWg=;
        b=1lhF684DEO/nqsAoDxd98cQsdqZ1VHPJrgVS24YX6lZFIwvoKv4JWnxF0nj8lTYO2R
         BLSt2IhcNfGswKapPgK7nh/j/SEahZ+C+fnYLNhsnBrEY73nZ1ua2pyETNTdCWvTmK33
         bdq/ImGEwrnQ9my7yAS3V03MmVDEh8V04Vb9wQusVB2KwNr2F4pbXVSn7H4beXBWU1qs
         JQdIYWf7qvwNtJYNdZuFULmcm4CLAJduBGmQepb+GdXKvw57A9RYLS4kaLtun5GbtjdB
         TKsQHsQlCVc1FE6jCvEW/MFoQkZbyuvNgjbggwUZJjWo0hs1+A3ERdLrru1Qjfhm4b3p
         ZoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710020266; x=1710625066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slLuHbk3WtakpcBqnee9gqaMqDn9FcyIy1Pde24rTWg=;
        b=gddAJyjY9rpl0lpZMQMJiyZK4qrR+VG4qWwLhPrkqvK8n9dexd1xwWT/xWK8eWLHRg
         rCtflTU+NJsWgtj9E891ygOkBoVgurtP0xou+7GfucvkKP0NwDhAszfLgnr47pFQGJtT
         jdTGggZHQRFfUXO8onAzNb8gFai1Y+jovjGbH+VfQkfJBkEMiP8/I3BnvakAA2vE42Zy
         mgtwEShD9UBPIWcMpTzwCWfZSP6NYEoe5/bpTur1Ac4WMuRGrND1i3pQOAMEQksWjv2a
         ntz4kWk+8ayU5ZpbNn13nkaTAZgxMxfG8UbgTi2y0RfFzngPJUMdUXQvjAybaAyXavbs
         /s3g==
X-Forwarded-Encrypted: i=1; AJvYcCWsE9AmEEnwoYT778WVM4LmrvEVdS6orTEdWQ7h/ckmwrY1GZA98JjlgisHZAkAE+bvkBRT0m2x+BniuD62q6AHSTJR3+NAVL5jZ0c4
X-Gm-Message-State: AOJu0Yw3XRrQAkHgETZTDN3TUytsSnl8VW+Q0HLAdrCiBcg86fXL7Rga
	8PFzTzo+24islCqiVMbVRc1VDgBqI5J9Y86z2Ng6eM9/TMzWLEvhy8VFTjN417BijJxNt97yqnE
	USzb0EUZCqZFRMYlfn5G4bTXELsxg1ar6lJRE
X-Google-Smtp-Source: AGHT+IGxmu8tZ2auf5n6LXuKbVU3mYUSyn5t8jODyhg2T6wGz22bjhxnnh9DN4PNnVS8ldrkThRfjtmeyWF/vffwUfg=
X-Received: by 2002:a05:6512:2823:b0:512:fe1f:da5b with SMTP id
 cf35-20020a056512282300b00512fe1fda5bmr2306933lfb.57.1710020266087; Sat, 09
 Mar 2024 13:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-3-yosryahmed@google.com> <420fcb06-c3c3-4e8f-a82d-be2fb2ef444d@app.fastmail.com>
 <35b670e2-9ef5-4d3a-b6ea-f8016dfa088d@intel.com> <ZevHJ5o3G00_nBha@google.com>
 <o5t3qrrlw37hdkcja2vny3ycpmhb4dowmdj74a2wrq2x4xctqk@5g5jvzen46qe>
In-Reply-To: <o5t3qrrlw37hdkcja2vny3ycpmhb4dowmdj74a2wrq2x4xctqk@5g5jvzen46qe>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Sat, 9 Mar 2024 13:37:06 -0800
Message-ID: <CAJD7tkZABvm4v87T2WJ593sjZ_Z9iLCcgecghQJHrZDnuisBLg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during
 context switching
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, "the arch/x86 maintainers" <x86@kernel.org>, linux-mm@kvack.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 8:34=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Sat, Mar 09, 2024 at 02:19:19AM +0000, Yosry Ahmed wrote:
> > I don't see how skipping set_tlbstate_lam_mode() for kthreads fixes thi=
s
> > problem. Do you mind elaborating?
>
> Define what problem is.
>
> Yes, in this scenario kthread gets more permissive LAM mode than it needs=
.
> But nothing breaks.


The problem here is not how the kthread runs at all. It is the fact
that if that kthread context switches into the user process that has
enabled LAM, it may not update CR3 because the mm doesn't change.
switch_mm_irqs_off() will only update CR3 in this case if there is a
pending TLB flush. Otherwise, we just return, even if the LAM for this
mm has changed.

This can cause the process that has enabled LAM to run with LAM
disabled and fault on tagged addresses, right? Did I miss something?

