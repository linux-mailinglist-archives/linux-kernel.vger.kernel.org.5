Return-Path: <linux-kernel+bounces-75469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A381485E91C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EEC2833D2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37433C485;
	Wed, 21 Feb 2024 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2YfyKTCa"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974293B298
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547797; cv=none; b=TGWP3yg9D2U/R6lxyvGSYpVfV8BPjBIZA+fxrNY2DCTwqFHCy8t/WjB95EVPiGYYb1zHwUh91Rtl+SMyYsBj296Ca4b9J960sQz1DPNDkm58VQikOwzFYSW6eAUt5kNzziDBitPO7JqE/6WgkWY6QwbJDPPw8/XG5Xv0z2XQVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547797; c=relaxed/simple;
	bh=GFhPlma8ElxwHflsLYpQTVGFiMO4B/Q3z9xrY8lb7y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1rg9ojBawlxM+WLCTFh23RetCGk8tlboiILyquDej5PW6AUIZA7+UCF+60qSvr2OAbTUHO5IoDTogpnsAuQclDIIXpcn1ZBOeQC3HvAY6VJNBwY8QIpCi8onZIoQW/xjl83pOof4GTDVrR4Wfz9dFSYqHLLJtB/BKERNeUfd48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2YfyKTCa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d89f0ab02bso27805ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708547795; x=1709152595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iAiTEgCppjIE3t1disnBeWTtqYJCr/gkvmRX972lsA=;
        b=2YfyKTCalqJEmT09oHd6tBBIhAKQCDxF7k9cZJRi+n2VzJnUWP+niT0r4LbNCPyOgH
         6cZtFztITsdtDbUsJtrYkw4REvWYKreLhbQVwfgKK4NNmGXKfPqCiyYl5yPwkUIazorc
         4THvpwq5OQSfZv4K6eGeoTGY9mC5T4O9Cf1AF8comXvGUNUFC5BNyBsi3s36iEKWlJoV
         ALdfecMsG/cbTmNWMtrX9CVd/7Li88L6+ffBqCRgY6vZzpe58W81Nz25zs81BUPDkz35
         DnwufmVEwZ1+v+XvfhM7tvBhCcRreE0DLCdSh1dvhSjdmcRli/gV0g0mBgZ7XoDFuXWW
         Wrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708547795; x=1709152595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iAiTEgCppjIE3t1disnBeWTtqYJCr/gkvmRX972lsA=;
        b=g703IEZ+Npb9D+DhkWQy/5FEU5iV3+MwIbBSNPXdwkNfiI7Ts2T+ASEXSMdY1yfx4+
         zFiKYeaLXLOITDvJia0X5b3/UCD7XW40l0gDv+VC92b3P5D89YrJ+WkcteA6YVpQL5zw
         MHFqvGWpWC/PIODzHpn6xeFP2f5ySz77IT9zaHcK00IvutGpAgf6/VEE4BcuGGSfJMnE
         0D6LDL0A0h7l7GMT5NbOvIZO9K07hUx3lZJMNg5Nw/FyjBkphBfQ0BkC1/9F4ma6wqY0
         JdxpHdKGmhUtYvsjvxI4jhAzMBfvj51WSKomR42W5pBuC4ijj28u2fMgYFGZarCH8YoQ
         RJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/Q5ec+BNy8uu+u5QGnjkiyV94L0dxnGOio46XJpjKKepwRl7CfDH6IDIdrnvUaB8QSqJNZlof+08lxSkF6PJGFq5SKolfWBNgPVLz
X-Gm-Message-State: AOJu0Yxzdi+YEjmU+P4XlRdkRmKPtFz6DyAXFU58vgbRaJLbcNcH6JHp
	ZH3RkZIqbjUi3rXcG9Z5muhKrKCUI58vuOSp+UHVtxs6+6Ubrs+c6LXydM012YdRojxmGmt2Hyi
	WaUIwQSvIuPAXroFNFz34+65+h8O77MYB/cudoh5psr33H6UVrg==
X-Google-Smtp-Source: AGHT+IHkUH8682wBjX2MlXCiKDKRKTZ78A7IDkSZwKh62FAeHimOB2zWqCHjoUmuvZXD72aiFX0+O0WGwp10g7NziwQ=
X-Received: by 2002:ac8:4907:0:b0:42e:660:eb8d with SMTP id
 e7-20020ac84907000000b0042e0660eb8dmr285459qtq.5.1708547393077; Wed, 21 Feb
 2024 12:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com> <20240221092728.1281499-2-davidgow@google.com>
In-Reply-To: <20240221092728.1281499-2-davidgow@google.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Wed, 21 Feb 2024 12:29:38 -0800
Message-ID: <CAGS_qxpyNVqigHB+kS-1xqzR4BAOQXoMSNS+d5khkLYrkpmOgA@mail.gmail.com>
Subject: Re: [PATCH 1/9] kunit: test: Log the correct filter string in executor_test
To: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Kees Cook <keescook@chromium.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Stephen Boyd <sboyd@kernel.org>, 
	David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 1:28=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> KUnit's executor_test logs the filter string in KUNIT_ASSERT_EQ_MSG(),
> but passed a random character from the filter, rather than the whole
> string.

Note: it's worse than that, afaict.

It's printing from a random bit of memory.
I was curious about this, so I found under UML, the string I got was
always "efault)" if I make it fail for j=3D0.

>
> This was found by annotating KUNIT_ASSERT_EQ_MSG() to let gcc validate
> the format string.
>
> Fixes: 76066f93f1df ("kunit: add tests for filtering attributes")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

> ---
>  lib/kunit/executor_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index 22d4ee86dbed..3f7f967e3688 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -129,7 +129,7 @@ static void parse_filter_attr_test(struct kunit *test=
)
>                         GFP_KERNEL);
>         for (j =3D 0; j < filter_count; j++) {
>                 parsed_filters[j] =3D kunit_next_attr_filter(&filter, &er=
r);
> -               KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter=
 '%s'", filters[j]);
> +               KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter=
 from '%s'", filters);

note: if there is a v2, it might be nice to include `j` in the message.

