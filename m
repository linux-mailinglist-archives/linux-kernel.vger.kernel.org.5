Return-Path: <linux-kernel+bounces-103595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B2787C190
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E541C21640
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D66C74411;
	Thu, 14 Mar 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbCz/o76"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B591EB34
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435321; cv=none; b=W8NBMRvuGsxcE6ltL79yirdxMaiLB0zQBwvkQkzCfANyO2k+SSDAPSZcq8i+LBASpMEjI6gQ4xZb112RuNx1gdUkhrglNFvDLZ/J5ZIYXLqvt/TFbk/8EtTArPl7zvlj8zWEs9iOJXXo3y6wi3K23JGCKrkg+YZH2q3of4mLPGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435321; c=relaxed/simple;
	bh=0oWET50ReYVFiUV39cnYiJFH1L/O2I+HkRr5gstNEjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpllognMcrF3QVoUGmSWrMMZtNmlWm8NFiOcSxXpCLeiHp0pEVmo3n0exBOVmTRoPkWFFSc3rFpiV+bqSCUunHRBol4aLj3r2+0ETKyCavr93hvJi8C8S4wO1mQyxxTBqTlqIypAxMfgx6m/jhPDgzI/7486l9M6nqar/cXk4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fbCz/o76; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36646d1c2b7so1595ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710435319; x=1711040119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5dW0gMuORo7rcnXCPfAPRP+bphbtCW0qVhM/Z5OPHY=;
        b=fbCz/o76htBOISV2x6yRakdhz2zQOhjVWb0h5CM2AnAa3DQqQYFYv/ljnSnyq79mfx
         5P72SsUoQE7EMh9l/EC5GgEKtjJpmamwwB+dTBnY7CeHWF8opVJq8HQHE5eiKJkIw/3R
         0+9A1RaAZ1Cvg6S4/kLfspmo23BCSJsow+AdmmFFm6XtK1hA4IxN9Hx7m7g6cKEP1dUx
         ileBIUKCW9wo0qMY2JnYBv8qI0FWgATRN2cHFf7F33JgvzyBj/QiwiRObZiaofX+kZ6u
         nXISnWkiEj4ImWkSuzwjc9RTBapxTY0sNckiapDxcLDGtkK0KNv88q5hxgvk0i2kLjZo
         Bcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710435319; x=1711040119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5dW0gMuORo7rcnXCPfAPRP+bphbtCW0qVhM/Z5OPHY=;
        b=sylmo9fqUvWEKFw6Q6m48he4ieTJXPztLNA4LMbYOwumUCOV/X4kQHBMHJxaExmHi3
         iihWn40eyuuZ/XBQ7yLTVK+B1a8IRDJapO/wtkCF7ysKo6m7OAkcH2wDmBUIjARBaKEs
         9Ddo3qqeQQcNJEZ/LgqaEzllfC4r8pNrxJh0qrrwvcCAa6rpxG96PmL60VOa0zjSJYhO
         Jnf5PBjS3/cy2Kks42d1jlieOld44I2acLd12CwTTfMm+PqpHrIoLxJry5+AUc0fsLDo
         vb4ef9sc/KRboQ16IVKiDP0TFJJQOO5b026SjRf2G4D7gKs8PE0aSSUnW3eKdmHLmEQP
         hJ3A==
X-Forwarded-Encrypted: i=1; AJvYcCWIcc1jpq2LMY7ai6Biz2zIMcXdPEoNuVP51F+eAgKO5xUsj24oZ499xrsm1IajkR/h+Bz02pa4pmwkb5SEHN/1rU20Jq2djZk4eD8p
X-Gm-Message-State: AOJu0YyympAhGO0zqcjRKLaDnu9vo4JNdsLqSq2Lb8X6mVx/u2jQkjCn
	CgKA3DLNJmvMiz4+TZL0fwMCL/LoX9R0p1m19olBu+WgTb5h6TIhIAlLKjG4ubag+MkzRQpiSbP
	jEER0jLEefMQ0dqv08hzPZl7otyFUOs71mdgO
X-Google-Smtp-Source: AGHT+IGKatndCxMi834h/dlO/DC03asvOPVr9HAIlJRDGJOBaCq6kQ0C1aOMQZbfhFiIDxZzgJGPup9P3JwtQy2vn8I=
X-Received: by 2002:a05:6e02:74a:b0:366:27e0:3436 with SMTP id
 x10-20020a056e02074a00b0036627e03436mr289316ils.15.1710435319075; Thu, 14 Mar
 2024 09:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314144320.743217-1-acme@kernel.org> <CAP-5=fX=UmW2iAQNfYcBG89Bv9LmLUtSmPOOH+3LN=r396sO1g@mail.gmail.com>
 <CA+JHD93osaLDZurWep=ie5Rnshk-T8i8ZnLrneVfeQ6eNAaKJA@mail.gmail.com>
In-Reply-To: <CA+JHD93osaLDZurWep=ie5Rnshk-T8i8ZnLrneVfeQ6eNAaKJA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 Mar 2024 09:55:04 -0700
Message-ID: <CAP-5=fUzj7CFstDH-4=_wRFaib8sbuQ1vothgfUB7R2Ei=6ovQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Move some more header copies to tools/perf/trace/beauty/
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 9:46=E2=80=AFAM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On Thu, Mar 14, 2024, 12:00 PM Ian Rogers <irogers@google.com> wrote:
>>
>> On Thu, Mar 14, 2024 at 7:43=E2=80=AFAM Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>> >
>> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
>> >
>> > Hi,
>> >
>> >         Move a few more files that is used just by scrappers.
>>
>> Thanks Arnaldo! A nit, could you change s/scrapp/scrap/g in the commit
>> messages - scrapping is throwing away, you mean scraping :-)
>
>
> Sure, learned the difference an extra p makes :-)
>
> Can I take this as an acked-by?

Yep.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> - Arnaldo
>
>>
>> Ian
>>
>> > - Arnaldo
>> >
>> > Arnaldo Carvalho de Melo (3):
>> >   perf beauty: Move uapi/linux/usbdevice_fs.h copy out of the director=
y
>> >     used to build perf
>> >   perf beauty: Move uapi/sound/asound.h copy out of the directory used
>> >     to build perf
>> >   perf beauty: Move arch/x86/include/asm/irq_vectors.h copy out of the
>> >     directory used to build perf
>> >
>> >  tools/perf/Makefile.perf                      | 19 +++++++++++-------=
-
>> >  tools/perf/check-headers.sh                   |  6 +++---
>> >  .../arch/x86/include/asm/irq_vectors.h        |  0
>> >  .../beauty}/include/uapi/linux/usbdevice_fs.h |  0
>> >  .../trace/beauty}/include/uapi/sound/asound.h |  0
>> >  tools/perf/trace/beauty/sndrv_ctl_ioctl.sh    |  4 ++--
>> >  tools/perf/trace/beauty/sndrv_pcm_ioctl.sh    |  4 ++--
>> >  .../beauty/tracepoints/x86_irq_vectors.sh     |  6 +++---
>> >  tools/perf/trace/beauty/usbdevfs_ioctl.sh     |  6 +++---
>> >  9 files changed, 24 insertions(+), 21 deletions(-)
>> >  rename tools/{ =3D> perf/trace/beauty}/arch/x86/include/asm/irq_vecto=
rs.h (100%)
>> >  rename tools/{ =3D> perf/trace/beauty}/include/uapi/linux/usbdevice_f=
s.h (100%)
>> >  rename tools/{ =3D> perf/trace/beauty}/include/uapi/sound/asound.h (1=
00%)
>> >
>> > --
>> > 2.43.2
>> >

