Return-Path: <linux-kernel+bounces-87411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7A686D414
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63431F26561
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC58913F454;
	Thu, 29 Feb 2024 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cm7k2hoc"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C313C9FE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238082; cv=none; b=OczakNZlt/udHckDf6lT2qkbjKLW1kphGhSmGUoehxSDhw77SG4A5k47cJmTYvuyQgJfD71S8rO7XFi7lX5t2aCpxtmif0EPKWaAhG7meefbYquUVkBc5BmEH4HRXg67N3+Sdhnp9KArOkVUYjifOkMgyDyaYLVN2Mev9aBGYd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238082; c=relaxed/simple;
	bh=uXWrJbshZP7CBnPLaekgrXuRiji+uddEtfNEXyijjLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXv6tbsMdaKVHNXrzjdDVPkLzvvLjp8UcSloHfWZU+NPhRbzRNKw11s79O8xyoOVJv46n9ptemdtqBqDQSAuUSHrZIpJ59LzRRrN5dNM6fcqwpDusSyWr//srYojlTUTfDvyLASKM2G3a+UZzFH8Da2JSZ6rjkVpbx6YiXTScH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cm7k2hoc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a443d2b78caso175534766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709238078; x=1709842878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k0i0PgDtVBoPSBAUnZ0cg1G8fT87ylUFojqmg8T1gpw=;
        b=Cm7k2hocPsX+grxEcHa84T7l9yKmtEvkapfPw4PyqEOgqf3mDYTpcY/4vtjwJ+gzm9
         XqBIs0Z0xnYJ2jA8qF/ZhIxb7+Havk+UhJQYu8kPP1lfwO2QIa/AMcuU55kpvJPjQigL
         eQ7xibr8TsILafbbonCclC3MJad4q5UL5eQSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709238078; x=1709842878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0i0PgDtVBoPSBAUnZ0cg1G8fT87ylUFojqmg8T1gpw=;
        b=DYzIsKld+lNWFoT95PwDUlBXr3G8SNSia8rFlWAIrognMyD64ybgqDNSbOrse2ZVSw
         Tf+ydux4pj/8Nl2U+kLmPb8zRfyyZPDCS/xafE8eTPzal8CR88rXnRrFB2RU4qM1tXFu
         3SmzrNM0Xl1KerbSrA7/Xr0Lsr/i4Cu2hpt4hnid/HDhuM9gLmFTvvJLCi+CajXXa1El
         YKtPCrQ8RgQ1q3iCbr0thmsXdRM3GeZ4e0a7lcJoH0ImDdaQ8i5Z1E/eEbVq6EeL86SW
         c7Wgya5XEfggALi+0PXN+cPEOrYLiDavzH2qSwwQza7Y7fHCLdjnj9782tU73/9ovSf3
         QD+g==
X-Forwarded-Encrypted: i=1; AJvYcCUsvNIPYXR1r1Isg7RmGFjgRPYd0QN2J2+gkn/bU0zVBiQ9CSIl/HaFF04kGXbAQQqky4P0BAsck8RmopdqLKAoSY/ujbabzKQgmCMD
X-Gm-Message-State: AOJu0Yy3hs5SDN/Y+JTo4UxTjUtlJ7/u+kdYDOZpUMvhI/KnDF7I8pNm
	s1C8JOJvJhhAFxaitmGwWuIHKnJNo6S8j+C2jyTFbYo/flchtIbsLSVJAm1KRYkMfDeMnjwK6Ho
	QlMcYnw==
X-Google-Smtp-Source: AGHT+IHHxPIrzjglk7gDL2YQdPTBMkhHOsn50BCoFWMfUFdBQy3e83116utEgoQYCKcwVfoF2v0umA==
X-Received: by 2002:a17:906:b30d:b0:a43:a628:ff31 with SMTP id n13-20020a170906b30d00b00a43a628ff31mr39670ejz.26.1709238078540;
        Thu, 29 Feb 2024 12:21:18 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id lb7-20020a170906adc700b00a4479997b97sm113360ejb.66.2024.02.29.12.21.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 12:21:17 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a443d2b78caso175526066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:21:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPZGESUS74scbcu9q1Z1wnktV6gMlb8COfFpqROUziOdAvjZ62EKFyrQGmqeHzSW1qtyI5D+YJhS7JdFWwsRmW2mxA9Hpo1SXaWZmp
X-Received: by 2002:a17:906:d9c9:b0:a3f:1cb6:fb00 with SMTP id
 qk9-20020a170906d9c900b00a3f1cb6fb00mr12394ejb.69.1709238077400; Thu, 29 Feb
 2024 12:21:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com> <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
In-Reply-To: <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Thu, 29 Feb 2024 12:21:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
Message-ID: <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, Helen Koike <helen.koike@collabora.com>, 
	linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com, 
	pawiecz@collabora.com, tales.aparecida@gmail.com, workflows@vger.kernel.org, 
	kernelci@lists.linux.dev, skhan@linuxfoundation.org, 
	kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com, 
	cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
	ricardo.canuelo@collabora.com, kernel@collabora.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Feb 2024 at 01:23, Nikolai Kondrashov <spbnick@gmail.com> wrote:
>
> However, I think a better approach would be *not* to add the .gitlab-ci.yaml
> file in the root of the source tree, but instead change the very same repo
> setting to point to a particular entry YAML, *inside* the repo (somewhere
> under "ci" directory) instead.

I really don't want some kind of top-level CI for the base kernel project.

We already have the situation that the drm people have their own ci
model. II'm ok with that, partly because then at least the maintainers
of that subsystem can agree on the rules for that one subsystem.

I'm not at all interested in having something that people will then
either fight about, or - more likely - ignore, at the top level
because there isn't some global agreement about what the rules are.

For example, even just running checkpatch is often a stylistic thing,
and not everybody agrees about all the checkpatch warnings.

I would suggest the CI project be separate from the kernel.

And having that slack channel that is restricted to particular
companies is just another sign of this whole disease.

If you want to make a google/microsoft project to do kernel CI, then
more power to you, but don't expect it to be some kind of agreed-upon
kernel project when it's a closed system.

               Linus

