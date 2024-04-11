Return-Path: <linux-kernel+bounces-141518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D44C8A1F50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A51F9B24F73
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC49134A6;
	Thu, 11 Apr 2024 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PKjQqiMy"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118E418028
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862891; cv=none; b=jroHZHMULfrx+VK0pQJopkfkmVPVGBE9QWJOuuN/jO6fUGwspSFWanWVtUqP1RATdvRW33XIAyWh2rvUMvXu9bbhMOR4cBV7N+mGLMTWz1ucuc5RnEeszy2AXL6p0EyhAuHDHuJCsSr1v5hyqhU/fz9NC6ZvsbD1XRMfFfQMUBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862891; c=relaxed/simple;
	bh=H8ys9L1hv7S7Nx/j9cn+rySGJ/YQIhVVIhaZ1i15xeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmzz1OSedsAUuURBJSSiGm+gGfciboCPEiXuUnX5f9Ep+E7AywA9WUBfnatjWfOW3qWhM334R+6oornnDI+e8SorQVkvsGwYx1uH4YS/MMZb5SkfzD+ZT6jJ92Bhn5P9VjQ/pwG+SUNdg39hgL8oVNE8+Hke5kfvPv7+v7x4oKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PKjQqiMy; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d700beb6beso1148491fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712862888; x=1713467688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=24c5MYVKM5W9suD5aHIvWrEfS4imCoj9FJNn9YD5CY4=;
        b=PKjQqiMyZwpR2Uz7GycDFY43Zud9snhUbFkDnWSZwohnAdGFw6RbjSSseTjpiWKMPT
         4mJg3mWIHFLr8aR6f4M2+N20jzRrS76XhfVXHbkA/sSpjCnvjbS2bEAHavLoxKD+5BEE
         F+BkLf9dsVLkBlG+qj9185+XtP1vww40iX2fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712862888; x=1713467688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24c5MYVKM5W9suD5aHIvWrEfS4imCoj9FJNn9YD5CY4=;
        b=BkicpOp47HFbM5ePSLmoIVi8e2xhmHNcg4lPlKK9lnHxysd8sS0139ItI6mN5IYgzg
         2WwoT1A6AO/+RvF3WyUYTgK3uC+0nzib5etKbukgO/rXmUM/NfADocs7sKWcUF8QR3VW
         wS+X9t4quZfQnPnPrN05rWmUFXhEJhZFx/6p4TmRao2QqvaLtf4RnfvqN9G5Mpb4DB4E
         HkX2N1/2TvDcj+DJhwBhpxCLDotfvgSp9XS9EndiANkl5atCYn/f8In/ULF8iVjaPs+D
         pPUws56J04qoz93DKBkKBTJouY5lSNIC7PexdqPf56t9j9POM6sZcqKxVN8F5uuuBVZf
         JViA==
X-Forwarded-Encrypted: i=1; AJvYcCXK+O6k7T51rgBwlkgUx0ZPD3gQ9RHHM/+FtDBf0Zn6ll2vW+8aDgWd2TeWLjCsNTLvhRSSxDIbzQvMlnuOQU9XlZDOv44Bv1Opg9jn
X-Gm-Message-State: AOJu0YyfKQ9UVVI8Tup3Ut5XO302JnQvCnyAgrLrm17GBXgyIAZc7jFH
	2+ryOgYn2ktiB6Cf+kPdg8M9FQBGrJS2BQ+Sxf4RClGwijLJQ7Qa0dtfLRgjfqywmz8iUj4wffg
	MMhEloA==
X-Google-Smtp-Source: AGHT+IH//t7HP1vm3xxI7sXzOnFHn2wQFbaXMoq9IwSLJKdkxZN2rLRiUz8GrzhfcBJAWF6CJzAGsw==
X-Received: by 2002:a2e:8758:0:b0:2d6:f698:7ecf with SMTP id q24-20020a2e8758000000b002d6f6987ecfmr330829ljj.9.1712862887938;
        Thu, 11 Apr 2024 12:14:47 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id ig4-20020a056402458400b0056fe7e308c3sm864578edb.0.2024.04.11.12.14.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 12:14:47 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-346b480e1acso67264f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:14:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKOx3cTso00QuVF6DOvITsgszu0OIDYi6QC/5CXlHDHbmMEKetHe6ZCJVgotbBxmaR7sMB/EWMLBv/hSxOqeDVsMXOn08JiGr2qihZ
X-Received: by 2002:a5d:570b:0:b0:346:44:3910 with SMTP id a11-20020a5d570b000000b0034600443910mr307796wrv.49.1712862887128;
 Thu, 11 Apr 2024 12:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJvTdKmK_U7nChpm=MzaDyw3T9V6hSua-6C89WCjo828vxm+yw@mail.gmail.com>
 <CAHk-=wgaTzpJssX2z7OiQOLL0BZzHGAfJn0MYPhuN9oU0R2f-Q@mail.gmail.com> <CAJvTdK=BO2YtUCrNzjMR8EydaDzaPasfi9m3_4UreC2J1MYjTg@mail.gmail.com>
In-Reply-To: <CAJvTdK=BO2YtUCrNzjMR8EydaDzaPasfi9m3_4UreC2J1MYjTg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Apr 2024 12:14:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNZV3pwPMjOr1_NGUt3L1rK+38xtSp78w02X6qYwqhJA@mail.gmail.com>
Message-ID: <CAHk-=wgNZV3pwPMjOr1_NGUt3L1rK+38xtSp78w02X6qYwqhJA@mail.gmail.com>
Subject: Re: [GIT PULL] turbostat 2024.04.10
To: Len Brown <lenb@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 11:20, Len Brown <lenb@kernel.org> wrote:
>
> ISTR that once upon a time at the kernel summit you expressed a
> preference that things like utilities (which sometimes depend on merge
> window changes) come in after rc1 is declared to basically stay out of
> the way.

That may have been true at some point, but probably long ago - the
merge windows have been so reliable that it's just not an issue any
more.

So I'd rather see people hold to the normal release cycle, and aim to
have the rc releases for fixes or major problems.

We also used to allow entirely new drivers etc outside the release
cycle as a "this cannot regress" exception to the normal rules, but
that has also been largely abandoned as the release cycle is just
short enough that it makes no sense.

So the "new hardware support" rule has basically been watered down
over the years, and has become a "new hardware IDs are fine" kind of
rule, where just adding basically just a PCI ID or OF matching entry
or similar is still fine, but no more "whole new drivers".

                  Linus

