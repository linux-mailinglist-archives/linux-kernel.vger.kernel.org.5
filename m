Return-Path: <linux-kernel+bounces-100574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C0C879A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27BD01F22835
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A35A13A263;
	Tue, 12 Mar 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="armVoAz/"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234B913A242
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263153; cv=none; b=azIB16u2vlBkxEJshIvPAkkWolaMNDu6MFjq7PopF5PVoz4Bgo04tQ2FnUpmK04m6j81ZUMLA4FWDOxAmvVMBo+FBH/b71jOWb+vd+1q/U7aFzxG81HRtTNvmt0og3HtOcf3rqusDpMwuncw9ZC0py9pzfF/5Fet5CLe9izM1t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263153; c=relaxed/simple;
	bh=FvTbcc819N4pCSQWAY6y96YJLaH0Ge9LjREr0BO87GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=maeQnje2CcPvT6VxdEDAT9w7DegQ5zPKdwz40OGVXK766ywcbGZbqQlfycx4wyKOg6VsFT7yuhiae+IWTeOvAAwu0lDcImGkiIcPk9LWoAXW2/LGM5Pz+ihQpQS8UPLUycV97nFbjUTC9IoXIvI2/dhn01Mg6dXfxwlkR2kyQcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=armVoAz/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a45aa7cb2b3so547500866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710263150; x=1710867950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvTbcc819N4pCSQWAY6y96YJLaH0Ge9LjREr0BO87GA=;
        b=armVoAz/WpKLeRpEgTyalFOS4A0LOFyHHQ1xXtIeNOTV5Yg69EwEnGcgAfYe3fJmTp
         YU4JyLmK8AI15/69V8oOLBIbjwnpjkcKTZo3bcJdcXU7GKvLatlzAu1+3VDFslaLCHZY
         F+udhzoq9PubXqvWQV0xa+HC+fcPlNW+J3wWHadcXdpAVZGQ3riiFOuPgaGP9Z+Bf59X
         hot+yxxTkb9nt1QdvdfvYtcLGyJ2/rlJ6RmHYO2T+AGA+hHtJggThfHjEM85ThiKKRf5
         VBj1UItQrian+BRKArc0XeRAt5BYqgva5vbLEwXNaNJPa5gR1Vwc6v8geAr6Cw23FCoD
         TYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263150; x=1710867950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvTbcc819N4pCSQWAY6y96YJLaH0Ge9LjREr0BO87GA=;
        b=TCqMDxD5hqV/LzCFh4IJkJlYz2GRDCmwcOjTbQsvLQOtJTokLkAwikowI6DVPQDe5Y
         m/6vcc4V426GzyLWqlUF3PjVdBAOCUV53cNX/tZV7HTVTx+10sha87z3iV1ZOZmSlKIx
         iPAXdVtlGdemXdKjIND94HYs9gARcTkdoJSWCayc2YXP64WtIKKjalguX1IyxC7Zgrhy
         VEP9ivz43ZhHUtBGMNqbCd/HeeyNSlaIidCsIMTb7L5+RDAu9R+nCfCSMcXzYikYzmPk
         nJ+jb7JBn2QOio18hkraQFhc1RAUBt3jCA8AGj/5BwKwnvQxEAdzAk0Xd5B+QWBf/GAG
         Z4/A==
X-Forwarded-Encrypted: i=1; AJvYcCXl9C5M5MreOazzY85Z10xqLj3zYNJ7HWU3R5p7RmCmnakwTX8pYOVvg2uhKWZ5N/xnpOmXbC2laIXgXtsYm2Lz7oEoJ9sVUfkT3cVT
X-Gm-Message-State: AOJu0YzMS7O9dLx2vkc+umLAtPPINGJNpmp8V5Fi6Uzi4NxXjhfDG1ZK
	+pQdnWbm3AWxWRIKZCdvx610KjpNREo0e0HWW5gls63A6bJcKPm0in8F7982VdCv3f8ZnYGzhLr
	hVHuADp2Pp94ySZKI/cHTaSctR9c9wNYERG+i
X-Google-Smtp-Source: AGHT+IFHE1hDwCI8LMQMfa8QvKzO+nKk6hoAFylIJpytuVBLLzymZhqN1Vr8YFZMNg8P2mWrHeOMlsx22ZqoN8GAty8=
X-Received: by 2002:a17:907:7898:b0:a45:119e:3dec with SMTP id
 ku24-20020a170907789800b00a45119e3decmr6214783ejc.73.1710263150363; Tue, 12
 Mar 2024 10:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312155641.4003683-1-yosryahmed@google.com>
 <d24c8736-d963-4aa5-a3cb-5cc1110e3ca8@intel.com> <CAJD7tkYXfFiOQMpM+GkR7a=aUxFM-smDc-ZFTTtFu2Kbd2KoPQ@mail.gmail.com>
 <20240312161337.GFZfB_MdSFtAUXjeLU@fat_crate.local> <CAJD7tkYa_NuX2_PD1sEn6kE6Q0Z0VCyq2T2HK_Qdj-_94+OG_w@mail.gmail.com>
 <20240312163502.GGZfCENkvNb41IJWPy@fat_crate.local> <CAJD7tkZjHaLpWhn6bKRMwZrgiaK6V3gASB9d--e16xiV8P_7cw@mail.gmail.com>
 <20240312170111.GHZfCKV_brefr6M_2F@fat_crate.local>
In-Reply-To: <20240312170111.GHZfCKV_brefr6M_2F@fat_crate.local>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 12 Mar 2024 10:05:12 -0700
Message-ID: <CAJD7tkbjdsJ5Man6hGt-eNGdxcqq4=xj-AFhkCXgun=FbdcBTg@mail.gmail.com>
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

On Tue, Mar 12, 2024 at 10:01=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Tue, Mar 12, 2024 at 09:46:07AM -0700, Yosry Ahmed wrote:
> > Thanks for sharing that. I have always assumed this was about pinging
> > or resending patches when reviews are taking too long. In this case, I
> > was responding to review comments. Maybe I misinterpreted that.
>
> So what I would do, for example, is send my set, collect review
> comments, work them in, discuss them and once there are no more, I'll do
> a rev+1, test and send again. Not under a week unless it is some really
> serious bug.
>
> This is a perfectly fine cadence.

Makes sense to me, thanks!

