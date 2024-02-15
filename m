Return-Path: <linux-kernel+bounces-67588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 058D7856DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2A61F25E97
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD2813959D;
	Thu, 15 Feb 2024 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="eg+FHDE7"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E776A1386AE
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025624; cv=none; b=VYjekGZkQmgfvVbq974wA0JAp8f88oiS0SPrbjPszaBYoSc5kkpXJHyhTF3xzLftVdwZeJ/dSHec+iHGyZ7N6ieXGSemP5ePSNqzuseiV1LwauVHgqILkUoufCJooBWy5Jj7jgODcIFwlwt+8UoxoTP6UbFZFZAcP6JBHOFLM2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025624; c=relaxed/simple;
	bh=fY7bPeUGECHTJGAnq11eLS1BJV4utg9nEqgu+9p9e5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZ9VhNGVw67I5yIgFdT6olZT+dLLDhIAmTjS51twLb7k+6yzldh2zi1j3x4te6D88dMKgfYXEdono8mtANvndUQMe5LWLEwflU6HRhxLlFqud4db8DfgR4b23T6c8MkrYhuOSa0D90ZA6MlMWzq1UP7+eWDkIZrwoNUyDly7lmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=eg+FHDE7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0e5212559so15534191fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708025620; x=1708630420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fY7bPeUGECHTJGAnq11eLS1BJV4utg9nEqgu+9p9e5s=;
        b=eg+FHDE7vwPXtRWJ0BP3d2css1ZPc1GQJpSKyiil/iL2GsR5X4vjfI+PTgrKwdg23E
         rSwqf5iugy7O0gtdajsUIypHrWbkRZYSyLnmRkb0Qifa+m3Es943y3PqzY7VHGhRvg9B
         CaKq1hoq9PH09hICsmFkM1hjstBTXmW9kBJs6FotG4jpzxxP9iHZFv92k/3jAUDRobzb
         2OrzYIzBcN1+uoPENrFLjG1HvZAVeHITrYw1Is5u6bvR9yfV57oaNx0OWqdSRZ3rz83N
         wBya0HvKPU0aHW8aAArCdjqIXpTbsmK1UQXZJXTCcJ8t/qHnsezyoPROC7lbDl3bhRIT
         HfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708025620; x=1708630420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fY7bPeUGECHTJGAnq11eLS1BJV4utg9nEqgu+9p9e5s=;
        b=B5Ym7L7CHKLfWUziqn1hQ1UiEE1rEpVe6QE05FMSl9+C7pdRjGf7lNXBht9SpGHMtm
         oUEM+/PLEUfpJs+UCBCBL619gS91kz/p3HaxaZPvyBp+FnA1L0qMS4WWdSEDVTVq43JV
         2u59ZTjDbQM5dq4DHaAc58YVBqTbxs6Xsf2PZl6AIlVLdDVaUVa5wnFIQSQBFQZlmqXh
         R8Kmfv6oyWEoA12z2A5MBpy4OQUj+IVe854VI6kMeOG7UDTjozVOBuQEYwuyjtqaup9y
         tB/bHICbitj9+I0EyNbRVw2NKK0eY+Ic9S0Hg+Tri6hiaK5oJQUhqFOuUXSj93jNQ1X5
         aN9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdKK7o3KsAuPLOFl2tXLRKKKW5ct/w6G+n579t3UcHlVJga/khhVXsy54qrsaOs5afGkkKnuJJnJATqQAex4bNGvxcJ5HYintI21nd
X-Gm-Message-State: AOJu0Yxc9HajrjtCf+8NzQD3MSdXqG6UjW6lXIlCRIc8TROwWBh3eMCF
	L3FlPO1mzFPcnTfZUnyOsA8neAGuy1u/Znw3JmtZVXprpJ5ab+TTKdA3NO7WAzjBS4ynEhPQnpr
	K4q2El4paB2tCGhkEIyseElPv4J0F3NDr+Pm5Fw==
X-Google-Smtp-Source: AGHT+IEkD9DfmAVvJoUA76C927vp9QSuWjLrw/gPYp/wFh5Xl4sFBBEvu2vXnNp5wym+2fg+tY6NIQ36BY/T6qfRVrE=
X-Received: by 2002:a05:651c:b08:b0:2d2:145e:b36c with SMTP id
 b8-20020a05651c0b0800b002d2145eb36cmr302147ljr.21.1708025619959; Thu, 15 Feb
 2024 11:33:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215145602.1371274-1-max.kellermann@ionos.com>
 <20240215145602.1371274-10-max.kellermann@ionos.com> <Zc5mRRhhU7flXB2f@casper.infradead.org>
In-Reply-To: <Zc5mRRhhU7flXB2f@casper.infradead.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 15 Feb 2024 20:33:28 +0100
Message-ID: <CAKPOu+_LbVg4YNumZWAc6R+bA+_LTBniUkQgH=WRaFDCjnDoDg@mail.gmail.com>
Subject: Re: [PATCH v1 09/14] linux/mm.h: move usage count functions to mm/page_usage.h
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 8:30=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
> Why does this want to be its own header instead of being part of
> page_ref.h?

Because I thought page_ref.h was a low-level header and the new one
would be higher-level with (slightly) heavier dependencies. Keeping
different layers of code in separate headers helps keeping
dependencies lean. I used the term "usage" from the explanatory
comment at the top. I'll amend the patch description to explain that
detail.

