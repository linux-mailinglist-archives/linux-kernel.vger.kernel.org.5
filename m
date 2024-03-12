Return-Path: <linux-kernel+bounces-100510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F157A8798E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08218B22A24
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B157E119;
	Tue, 12 Mar 2024 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NVjxajyq"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C38F7E114
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260668; cv=none; b=TQAiY3a+LghdxBtgkoqxQWoxim0SyAOdVFFrxREQtvmwBHpggOpcTyMJxoFIKBtyl9NYvpnY8bpL5JWNZym6/tZUG+2q/kl4Wk5jw5PF6aKit9kZStVHgIbjsRF5QChJ3dHbjrwtJdkt/MiJo7+jTdjBWr7M2Dy/UmwHQh6eB3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260668; c=relaxed/simple;
	bh=IMTi1mmB21fOGrwdrG1aJWx8CERlzTfordyN6vtcN1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+6yEag1j3h8TejTQF+T0rfsW3Gj0+UMawAYEdhY81dkyHMM5nrvUWXrQ9rAwGlW8+tZoaeuJoFzSu/eaeQoiOgfEhUcFH3Y9/cAS287+D5x7lyH0rBpgHWvEB/d6neXqbRf7h+SnD60zK2Txdl3u1m1Z8nQM7PRQ7QXySZ8bxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NVjxajyq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44665605f3so809162166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710260665; x=1710865465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMTi1mmB21fOGrwdrG1aJWx8CERlzTfordyN6vtcN1Y=;
        b=NVjxajyq0h8aMkzHz+E3bPuW7+4RbsM5QXfuFNWsVKI6DhcjBDEalBpI46Ixhj8iqo
         Xc+oRGqtJOttbDzpzaRtfKRW/A52aK6aMIZV+eLm8qFwZDBTarAPq4w2Y4wM7+Ftt0au
         duwIdY2RzhEaAq5tPWFOgKt0HmflkIg2zcdTKU0lej9P5ZLgQ6g4KG/Ou3TqALEYA+rp
         wzSzNRk2K+wy1d+fTBFe+iBc1aruAJCUlmsvyT1AnSFpWCPYeaUhfnOh3CSajiczxpzz
         5LkWuE8jz3H6pCkiDsyD7ilVc88W8QUc1oY2PRvVBrHwDgqKpj5M9UamsgicCceIs913
         ILOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710260665; x=1710865465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMTi1mmB21fOGrwdrG1aJWx8CERlzTfordyN6vtcN1Y=;
        b=EeVwsDrkY6QLx1xSn6vYcgP9VugQ/DLFwx3CRi06CjYc5INim8LYTLebDXNvKuFaZi
         CaUy5PPshv9u1JvbJH3/NsHJECgIrwKn7hEhY8s3dM47Dma0enLESJu4LnLVo+fPAtyC
         mcncMSOy/Ym5HLnzNz1bIRAKrP/w5Oe9gmoBQo0AgKSLVFNLmd/BcmSnBwtgl5pKoPFE
         RHIGoTIHu6WF4NdFO8kcIUTxnYJDmMR4CfCF8Cu1qdci7pS9q73w8vX2/2Bse74I9mG6
         UCkEJ2BPZcOOgS/X0rkcJtucOgyzIdQOkTfp3WTLQbdzBgLbkVDdYwL5WH31AlP59saJ
         O+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUj9d4TkFG9J1WF535cCXIsYjIKA1kndwLRYqIsnRVFBbQFX9qWkSlv2MH3mHF6TT+9Gt5q/S7JVx7W2ph302Fc283dP7Xw0SIJQpPg
X-Gm-Message-State: AOJu0YwM30/X0ttqC4uuWbcRZqLVn0Aosa6S3dJI/+2CjP7QrK7Gv0MA
	1h1vnZDojAK5uObrFVmhdtmyOg+MEGCuXTKQvZvwfZtKaMG8tASAgAeIOLEa4QYnKAgqnUInvYL
	CfeW0gVERZfn2ZwFc5twE5xl8znMsjeBWdvCl
X-Google-Smtp-Source: AGHT+IFslqmmUssGyflGn1EGvqy/X6vDu2aiTHkYqqbD1uKW93yCxokoKZ+bIq5yFMGyKXdhGCAS8UiLrLdKB9/dtjM=
X-Received: by 2002:a17:906:19c5:b0:a46:2c22:7f4c with SMTP id
 h5-20020a17090619c500b00a462c227f4cmr3631747ejd.35.1710260664523; Tue, 12 Mar
 2024 09:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312155641.4003683-1-yosryahmed@google.com>
 <d24c8736-d963-4aa5-a3cb-5cc1110e3ca8@intel.com> <CAJD7tkYXfFiOQMpM+GkR7a=aUxFM-smDc-ZFTTtFu2Kbd2KoPQ@mail.gmail.com>
 <20240312161337.GFZfB_MdSFtAUXjeLU@fat_crate.local>
In-Reply-To: <20240312161337.GFZfB_MdSFtAUXjeLU@fat_crate.local>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 12 Mar 2024 09:23:48 -0700
Message-ID: <CAJD7tkYa_NuX2_PD1sEn6kE6Q0Z0VCyq2T2HK_Qdj-_94+OG_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/mm: Use IPIs to synchronize LAM enablement
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 9:14=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Tue, Mar 12, 2024 at 09:09:30AM -0700, Yosry Ahmed wrote:
> > My bad, I lost track of when I sent v1 and saw Kirill's comment when I
> > woke up so I addressed that. FWIW, v1 and v2 are almost identical
> > except for a small change in patch 2 to address Kirill's comment. I
> > will hold off on sending anything else this week.
>
> and while you do, you can have a look at
>
> https://kernel.org/doc/html/latest/process/development-process.html

Sure, although I am kinda familiar with that. It would be useful to
point out what part(s) I may be violating :)

>
> And we're in a merge window now so no queueing of new patches for
> 2 weeks unless they're regressions.

Right, I am aware of that part. According to the tip tree handbook I
shouldn't expect them to be handled during the merge window, but do
x86 folks prefer I hold off on sending them until after the merge
window?

