Return-Path: <linux-kernel+bounces-95220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 022BB874AD9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834541F29452
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C97C839FB;
	Thu,  7 Mar 2024 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIlwPfXI"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D983CB7;
	Thu,  7 Mar 2024 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803697; cv=none; b=EiRFeREAet+h7gXWma1k9TihpK+9xXz8yeAd+XYMGhOgs2E0zTR2kLmsE7BD3OeZ8LperV1a8OXkT4LN5h77hIZoltXLsJ69pLFxHZp1rmU0a60ozfUZfVxPPCAzqLjnv0ENuvv2h4nhF3p39jIFskWD0qgdq4d47bTkbvZvLIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803697; c=relaxed/simple;
	bh=D9TARgVfvKxiTfXSCd37HBbIyUqk+XaFYYpnT4+b3YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRXzDgfe67BlZ2zmLB0ELAyPGQgX0mQeQrhH+zNPuxeMBGJGMdZDU310gCXzxHRcv4HD5hSQ0MmLNFmpUo8ap2EMWbmb3on6uGVE52qqt9wySCh4dHk6wswYgzAE0FM023NwbxDlbWObh4jHxWmgMrz9U6/k8SkDkffxNMkKB08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIlwPfXI; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d2fad80eacso6633881fa.2;
        Thu, 07 Mar 2024 01:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709803694; x=1710408494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqElFMkTvBicMVdZ7SEelWOQGbRnANtN0YyyYb/TJwk=;
        b=SIlwPfXIBKKCEzYhcIbY1Ntxla0rWEwQYTqeF4vqO1D4bEBBFTUyQ99qaLwsJderiU
         Z+XsnDBU6ic0PeEq0Ldb8c1alYskTZkiTv8xLslE9lywYXxF3Ga/7VQUz26IIIhSNh37
         cUJhqCon3mufXuSfMSNHtrqvh7+Bxo28/BYabB0ZuvrfNWGMmA5t4FgfI9FeEI8XuMed
         78kl0vbFcw/dMVqa8JAo+aWLnmIL0QunO9JVos0jmPlTUJHH4c3uz6m0J/nx6FetZG6+
         e8kNhEBaMdb0X6pbowtm7S2mjjv3cWk5qyPad9AwnEhAzzy61ykyWX2WKpMDJQQKazjF
         bqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709803694; x=1710408494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqElFMkTvBicMVdZ7SEelWOQGbRnANtN0YyyYb/TJwk=;
        b=vxoIH3oQzc9yjXWndJeV9uwtYRhYIjwqRMijJLvSEeW9O7HTjV8EQHkifRDkCo2fIW
         LdOQ8CNuubs7TUNoqz34Iinyv1H8tw3482BwkubC44MlcMDkpYM1uczKrzIZky97i+J0
         gBUtv0hpxkpOT64jLsF3bf9LRcEuMuA21l9RHokjt+EgjvMUffyeXXcn9Ob4J5sBYBD1
         g0SDuh/ef6xEad0xiMDMkPd0sMqYZyTjiBi+SJKwBr47h0jgYLkVJ0xL0XRDVxcDdqe4
         eRXAJaVYFVVlHbqPESeuYJwGwmVPfgCNZxYMsuiggkVn3q/7brjc/tf19/MXb+1do6lH
         wNLA==
X-Forwarded-Encrypted: i=1; AJvYcCX7gFCXQHhdKyloL8zLm7qq2MvKeDBl8ot/DjSk+K5XbFVbcBjzrtw8M+6WKaIUWfqeKYaaFqj3XXgMZxbVnNs3EPGGbfZieAqnHNMLe4LQnHQlD2CoSVzJQZge2Pw0AixGVN7qw2duiQ==
X-Gm-Message-State: AOJu0YxG7/iFq8pq2jj+wO4tSMeQgSTYqgBoAaF197UfE6TQkUAaPzYo
	RFWfBHL/70qfNIENbEe60KPa6CXz2nlBAGqtTBHpDrhVyGNf66CaqecGORaISq/pDqmRp5LuLBM
	4clkKtjDYeE9roYYMeU6sMvYU+w0=
X-Google-Smtp-Source: AGHT+IHjiV486p3sDeAH/QYQK+UU0DDVMP/fjkLCxIHtvcvLxZRd6CYQ+zyuZllwi3vJwxDlj6y9NUHPpGfSmrapx9A=
X-Received: by 2002:a2e:9787:0:b0:2d3:fae3:d7d5 with SMTP id
 y7-20020a2e9787000000b002d3fae3d7d5mr862143lji.48.1709803693441; Thu, 07 Mar
 2024 01:28:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709780590.git.haibo1.xu@intel.com> <f23da383a8fdbee15acd41fdcd38ef3a89045a43.1709780590.git.haibo1.xu@intel.com>
 <c9e9da9f-ff81-48eb-beec-4f54921cd268@app.fastmail.com> <CAJve8o=BsR1SG0k_7mb61Jj1fb+9rc4V9Y=MMX004fpAWE4vjg@mail.gmail.com>
 <460338ee-c8d5-4f43-9bab-4c35e417e4ad@app.fastmail.com>
In-Reply-To: <460338ee-c8d5-4f43-9bab-4c35e417e4ad@app.fastmail.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Thu, 7 Mar 2024 17:28:02 +0800
Message-ID: <CAJve8o=SKkV1oE__4waY8gx0OoYptPNH3a2UzL37a=-+wcbcDA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] ACPI: NUMA: Remove ARCH depends option in
 ACPI_NUMA Kconfig
To: Arnd Bergmann <arnd@arndb.de>
Cc: Haibo Xu <haibo1.xu@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Jisheng Zhang <jszhang@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	"Conor.Dooley" <conor.dooley@microchip.com>, guoren <guoren@kernel.org>, 
	Zong Li <zong.li@sifive.com>, James Morse <james.morse@arm.com>, 
	linux-riscv@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>, 
	Baoquan He <bhe@redhat.com>, acpica-devel@lists.linux.dev, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Dan Williams <dan.j.williams@intel.com>, Len Brown <lenb@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Yuntao Wang <ytcoode@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Anup Patel <apatel@ventanamicro.com>, Tony Luck <tony.luck@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>, Evan Green <evan@rivosinc.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 5:23=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Mar 7, 2024, at 10:19, Haibo Xu wrote:
> > On Thu, Mar 7, 2024 at 4:44=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wr=
ote:
> >> On Thu, Mar 7, 2024, at 09:47, Haibo Xu wrote:
>
> >> If we make it
> >>
> >>       def_bool NUMA && !X86
> >>
> >> then the select statements except for the X86_64_ACPI_NUMA
> >> can also go away.
> >>
> >
> > Good idea!
> > Shall we include the ACPI in the def_bool definition?
> >
>
> No need, because this is inside of an 'if ACPI' block.
>

Cool! Let me have a try.

Thanks,
Haibo
>        Arnd

