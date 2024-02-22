Return-Path: <linux-kernel+bounces-77010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A01F85FFFF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFADDB277DC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90251552EF;
	Thu, 22 Feb 2024 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GTH5DnT9"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F321534F8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624122; cv=none; b=o81VCgRu0Epg7L3brqTZNsiV6MYNH2cWI0iTb/gZljaSOC5TwtBBTjNwM41GXJkSSp57AfeWaagHouAWqsN7w8KgO3jIEzAbyqBgJXDuPB4kWxAwwZv7Q/iBS47o04ZlU3Zzhc3iYcTTGieaDsdIS5BkvrJV1uGrQ7wXl2/ZTnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624122; c=relaxed/simple;
	bh=qYLmMIu0Rese8RbpYgo2VOL3SKIbbZc5jXyxFfzqGQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTfhXGOSs0yQMA1HnFN09SNcbjkH6S+NB9gsTAAHlcNqJiGjKn5htooeCtdXO2D8rjsDXXGVoee+WCJBFOlPTIT+K5tUIiPdVCKri3ZkbebtOnMV2woPG9u8ruzlY1N3ZpZRCeEsuvXlRZcP93qaUCd1Dz1O8B4/jRewGcmb3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GTH5DnT9; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc74435c428so7655779276.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708624120; x=1709228920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBJRDZD5mD/oheWRH0mQPSFnNThEgDgn9q7qpy7k0qc=;
        b=GTH5DnT9xglKTab+WFANAJFmNX/cdm3sZVD1kXdgWlkDpG5ru36mcbZkJ3/82+JyVT
         m4bVLomnL5FiRaD7gT/Wzt+3pAV+Rsq7fhggbpY/KtA3Fxf8DWf/XhX5xWkGYWPkgl1Q
         i756rYi3M4+BywWDl+BiONa63VasKHKpBeMiXtg+Sicndzz//H5swVYg9j5qHZwS1ps8
         TZn9m6ik3J8JOsLIRnD1VocDeLhfib7H7CUEI7bwgotypesLZGaYRFSTuQOYO2Q77lpJ
         NceaBTsGw6E1r2F9auAdaGV4F2/CB9WA7CW1hq53K0sRsg60N4xfhYt0AesA49Awo+fG
         HfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624120; x=1709228920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBJRDZD5mD/oheWRH0mQPSFnNThEgDgn9q7qpy7k0qc=;
        b=QWt9mRn7Bb+u3ptEBBu+fX1JrV6uRmmsP3AX4vTOD/FIgezlIHmPFbEMu3Sq5nGeYs
         lft+pg22oOzyBB8gcN2By9auaMeWsw7SiEP2GteoecfLcRs5RZCwtCENRvTHHvUeXxlV
         b8BpUFRWNLENdK8y+Y22NLOoigqk/k/4Ul0mm3qsIXg4dIg6j8jsCi7rDxvHCQaULInv
         5CIzlLmM2JdInTFvMtJo/zsZi+ogbQ+MUGNMsCZNqAFYQi7YyU2FoJPH6yCFXDkLpTfC
         7WU8HO70ZR3dZ1bAmpv93M9XC5w5WZSmpjQhgCVm1Kc+dW6prJul3UsG+uKPAK4sRWAG
         5KPA==
X-Forwarded-Encrypted: i=1; AJvYcCVCGI66Lk72fDquw2r4hzydv4rfX4RQklOV2kUqzVHgZmUaq6qLHX6FpSJsumbvWeiC5I6CqGt/QKcAKNuqWrKDgGcfbZXu4bGXYhCy
X-Gm-Message-State: AOJu0YylYz3BQXGkQ17iEaGoeMkiSshSF4lkEq5Hn2exuecokodTT4VK
	gOQPHRP8PK2olo9pAjbNfaNZzQOwPKzmQAu+tValc0ptzNDNyzX+k7uBkmnXawvi4Bo0Syt3aoD
	r0W41/r4aUovbrFvitDg3Y+AFUjZF17hM8I5U
X-Google-Smtp-Source: AGHT+IFBiGaibrZl3vFlfOhP0RI6ypAvrT3Tolqp4SbjChhLeFk5HSc3i8HWa2N8L7WhRDnc/VCwvi7FLu3KyZqosMA=
X-Received: by 2002:a25:b90c:0:b0:dcb:d8d1:2d59 with SMTP id
 x12-20020a25b90c000000b00dcbd8d12d59mr2986852ybj.38.1708624119917; Thu, 22
 Feb 2024 09:48:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130094037.76895-1-chentao@kylinos.cn> <CAHC9VhQG6XAm3R3wtgFrb0b0UHoxkSV2yziVAnUy2x7Ovun_pQ@mail.gmail.com>
 <CAHC9VhRLNHT0ar2YPkZBsyha_mh6Ggf6=V2gnbFkdo7ryXmHnQ@mail.gmail.com> <0f51c6ba-a6c0-4fbf-9b00-21cea6d59ca9@kylinos.cn>
In-Reply-To: <0f51c6ba-a6c0-4fbf-9b00-21cea6d59ca9@kylinos.cn>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 Feb 2024 12:48:29 -0500
Message-ID: <CAHC9VhTJXfPztz2W_V6sp41PJW8dzvZH0YdnRXd7tUZOF1Q09Q@mail.gmail.com>
Subject: Re: [PATCH] cred: Use KMEM_CACHE instead of kmem_cache_create
To: Kunwu Chan <chentao@kylinos.cn>
Cc: axboe@kernel.dk, elena.reshetova@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:06=E2=80=AFPM Kunwu Chan <chentao@kylinos.cn> wr=
ote:
> Thanks for your reply.
> On 2024/2/22 08:10, Paul Moore wrote:
> > On Thu, Feb 15, 2024 at 10:54=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >> On Tue, Jan 30, 2024 at 4:40=E2=80=AFAM Kunwu Chan <chentao@kylinos.cn=
> wrote:
> >>>
> >>> commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
> >>> introduces a new macro.
> >>> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> >>> to simplify the creation of SLAB caches.
> >>>
> >>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> >>> ---
> >>>   kernel/cred.c | 4 ++--
> >>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> This seems reasonable to me, unless I see any objections I can pull
> >> this via the LSM tree next week.
> >
> > Actually, never mind, the original posting has some non-ASCII junk in
> > the patch and I'm not able to import it cleanly.
> Thanks for reply.
>
> I checked the patch with the checkpatch.pl script and applied it to
> another machine to compile and found no issues.
> Seems ok to me, what should I do next to clean up that non-ASCII junk.
>
> And i use :perl -ne 'print if /[^[:ascii:]]/'
> 0001-cred-Use-KMEM_CACHE-instead-of-kmem_cache_create.patch seems ok too.

Look at the message when in the mailing list archive (link below) and
you'll notice the extra characters:
https://lore.kernel.org/all/20240130094037.76895-1-chentao@kylinos.cn/raw

.. and then look at a correctly submitted patch:
https://lore.kernel.org/all/20240126104403.1040692-1-omosnace@redhat.com/ra=
w

--=20
paul-moore.com

