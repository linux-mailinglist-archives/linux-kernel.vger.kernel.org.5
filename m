Return-Path: <linux-kernel+bounces-123544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ED4890A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCAB11F2329E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3171152F62;
	Thu, 28 Mar 2024 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bkz2jjHI"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F94436D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711656414; cv=none; b=XShGqsLmRElAogqf/S+v7QkfOcpAr2PALOl1JsWY5VA8nqMHngDWHkk8LDNvf4s6ivPG+1kSQZccOjUticfxyQurHw0lYvoCOlQTDWPsj42GPlrTQGK10PcLZmd9CjrdmFfqIbCeYaK8rlhiBF+OCXt9Bo13TPdKuZ0aLgDk9lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711656414; c=relaxed/simple;
	bh=Ij7Ouf/ymUoifh8mgCvqV2Oc2Vgv7bDzjKVaIK67K1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPQeODDkkv4VSYJj5VA1BCkazT8nK39iDl6zintl+nI6os7BQfEJrFyFl2p3+LUKpnAYqoukXNb3KsKh+QIPCjEMtSuFT78Fx/P7nl+BJxjm+6RgH8AzuAZcQKW6tgfA2Jj1YtWU2Xb1+x3abCFaFcYeGqlSft2KD1lVPT69QNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bkz2jjHI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a450bedffdfso160779366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711656411; x=1712261211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ij7Ouf/ymUoifh8mgCvqV2Oc2Vgv7bDzjKVaIK67K1A=;
        b=Bkz2jjHIa0xkYo/qq6Unn/EXErXPDoHC/jP5uWlJPH3bVzxM9QdpNZVVf1VOPAvIde
         wr5iMXDfjRoItkNVTmExAqmXZzMHWEB9xyoQudz8ns1VCYDC4ET6FqNmR46QgAWtWOh2
         pcCGD6A8aZOqhLgzzTWhLsGl7pK1kTVq1nzayALta/zd9lY6SLYa2Q0Iw2zSIhRnySBC
         AWuM1z3/DPwy8tX8Tbxa1TQDtwTJVPUvi9IeKft6s/TlR2Vo3NtxD0Y1Cqjyo5fKCRdr
         Vhf0Beq/aFf/UgzbIYk9yss24e9c05j4XX1A7yKALLyJWWUDeN5LGvn/NrPAsYzmUsfm
         IH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711656411; x=1712261211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ij7Ouf/ymUoifh8mgCvqV2Oc2Vgv7bDzjKVaIK67K1A=;
        b=wWjOffSqxMQniafo7AESAyWT8DsRgVcMeJwS8OM5W523bWMvzTZTE+tv+BMQ6ewR4M
         bW/hshCWoyRnJ0yWOG94LCpqbKQu7FK1xofYKHBNHY5FnaWnXTgQeBFyXal2dLDv4rai
         Uv8y//jouQjulgrTNvgl0EnNVwYtqXESYpW/vA1Ejnn+c3yqjUjdSIUJ9gHKAKcjaaXV
         pUVmD/eeNxisLeBrs1S+QT/YefLlE7Uzn/OlyV2XYPLhD958fm38cuf6u3tqTJ4wXS/Z
         w26ep/5L1W+2oJlxv6TQANOkONB1tIgYIFFgCkEe4m5O41oqlr2prpqFpu/GXPw3HC6J
         RRCw==
X-Forwarded-Encrypted: i=1; AJvYcCUZj1Jlp1n6yHFvuI3aKxPZzJfEisqe5KLJgmHCUUfHaxg58VMa14U7owDgZMpRqY1h7vL2rWn0FuErLhgucXIT57eLr2Ct8BQYilpS
X-Gm-Message-State: AOJu0Yy/XQDSp5bqR4VwCLXe5WTnW00JCGs+iblT7RIZfQljJC+Dkh96
	t9QeoPRm5rEhmEh82+81KslBuQjwCG1inzAgtFdSZRg3gNerbhKeqbx/K44L6O5VSVCoh0xtCXa
	bmzwSjmZDmM+quM5QDG4K3ZbOjwJka8uC1Kx9weEf/Dr+3G9eKQ==
X-Google-Smtp-Source: AGHT+IE1Ht3Yt9FVoWdIKtNsYI1USNu5UTJHLFwpfZwvzxs6llb+5nQ8s9MPRC8pMqtwnbk0dEnMHrne2iPHPkzCCxQ=
X-Received: by 2002:a17:906:c309:b0:a4e:f82:375e with SMTP id
 s9-20020a170906c30900b00a4e0f82375emr192488ejz.73.1711656410453; Thu, 28 Mar
 2024 13:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-6-yosryahmed@google.com> <20240328191109.GE7597@cmpxchg.org>
In-Reply-To: <20240328191109.GE7597@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 28 Mar 2024 13:06:13 -0700
Message-ID: <CAJD7tka4iKD0=MOkj7iBCXvG6Jmq6WQgvRNV3mY+YRWPnYWmAg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/9] mm: zswap: remove zswap_same_filled_pages_enabled
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 12:11=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Mon, Mar 25, 2024 at 11:50:13PM +0000, Yosry Ahmed wrote:
> > There is no logical reason to refuse storing same-filled pages more
> > efficiently and opt for compression. Remove the userspace knob.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> I also think the non_same_filled_pages_enabled option should go
> away. Both of these tunables are pretty bizarre.

Happy to remove both in the next version :)

Thanks!

