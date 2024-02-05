Return-Path: <linux-kernel+bounces-53870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC1384A773
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14421C270A0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADF7823C4;
	Mon,  5 Feb 2024 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JafixgZw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF2F4D5A2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162584; cv=none; b=f75nRyguK2roOzRYPB3TrbQn98tphOQgVWsNcH3z76qboMYGunC+Kb0OsSiJPcpXaOXg86a51LGcqAp9NCQeE+KEcjemfrwAE5oGg9Z9XDMMKgjIWWt8crp1/PAp25bS7ZcXgDgVQjQ6UCledt2V4GSdyzOj5LcPbLCD5rwCRfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162584; c=relaxed/simple;
	bh=XtlAVK6YDcvQ+pR0/3RJq86cSBgtfjV822+OPR5KgHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9ceP9/fN52VsrPlPISP9YmUnKB6EoqDiTxMlZfTTTPfPXSM/uypQvgQT1d6M0g/mAk0M9pjrOnQLwIUJKdqYsYp4aZiAhec/O0HBtsEl32ID6IEMBLcnPE+lv5Kb8hY5i4D6dGhFVNgTa6CMvAHWZKNp4s3eTxyV6UvohqTJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JafixgZw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707162579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnjll7ttqP5qOfWrHmrZxBvwGo00AeSiiRX6JPIK/sM=;
	b=JafixgZw0qxczemwQgpapEYs6Vl6XneM1pD/+RU384TdrD5Wu8BkgE6J2q2+mZ7cnMPqHS
	faixfNlqofxWPU3W9Zh01RdKgaBP+jCORpOgl2ipA1srAX/5yxdm9cZx08isqQHGEvpSOR
	DKAtOD5wNtfpZNvkow3HZIHLJGj8RlQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-g-EDNanKPNSYyvdlA3O-Mg-1; Mon, 05 Feb 2024 14:49:38 -0500
X-MC-Unique: g-EDNanKPNSYyvdlA3O-Mg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-56001b47349so1820718a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 11:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707162577; x=1707767377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnjll7ttqP5qOfWrHmrZxBvwGo00AeSiiRX6JPIK/sM=;
        b=a6MJVWtVGIWcRII6NaWraQDSQ5sm5M6nMt/cNSHLetboMOjhZKKy9B+9h/9653tRi4
         nnc0NOk5IO/JN5/O4iO6/hCl6A6RMWYfy/AFnAnPAV0ZW3WbNKYjj6oj0BApy6s30yqW
         H/GgABV2r5cTuvwaEuXCfbVy/82qW4TnKJpgdqw0R2kQ8pbZTYc0GFN6SJvo3t8uEXta
         dWt4OKRvMYGcJNBSmeI32Qnt1QSbRPBGLgX6d518eS4HldVEEWzdSkVKnkm7AT+eq3Hh
         vr4P/EO7V/X1NaOwW7sIb1TwiG71cpYdfjCVX6LVu4Sy7lLoEdzC8TDo+IL3Ma4057yJ
         KS3A==
X-Forwarded-Encrypted: i=1; AJvYcCUC8YsK0tDeEOPTKlJwPe7ITLC4KDvFWBrxHQCi7csfbO6iDmqijOM7NCpIODjmB+YZntBmhBJXbkyzD5z/9zm4rSyjU1Oui+OpT+Vh
X-Gm-Message-State: AOJu0YyjskOJiLDy4P8OFcfcwf39UzAProiMYI1EixS8nWA/SnSUdery
	AfEC/jBiLgHNNuRoF4sh+g89LpGx4nRYCIzQKCrBQmL6BFf71XXv5eLASsksNxBiIb/l2jj58XL
	OAdeauPQrvMukjH36NTwojeCuMML6hiMq4QaIoZGDy9STh2ZuW7OAVh8ltgjfzVzNol76Zlu2aP
	9WYFRfP5FKYtpTcJcM1HhQYdzG+xEkBOxfAYwz
X-Received: by 2002:a05:6402:70c:b0:55f:f5d2:ef27 with SMTP id w12-20020a056402070c00b0055ff5d2ef27mr26670edx.41.1707162577421;
        Mon, 05 Feb 2024 11:49:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBlSYwIisgeeQLdSLhQ5yBMT9FQ2Ei+kgu73drD6ctuVLS3E+BlVQEjgFpzoHQ+6IW9efo8m2HvcdOR1MzrqA=
X-Received: by 2002:a05:6402:70c:b0:55f:f5d2:ef27 with SMTP id
 w12-20020a056402070c00b0055ff5d2ef27mr26660edx.41.1707162577159; Mon, 05 Feb
 2024 11:49:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK-6q+jsZ13Cs9iuk_WjFeYFCEnnj-dJ9QYkWaw4fh6Gi=JtHA@mail.gmail.com>
 <20240112131554.10352-1-n.zhandarovich@fintech.ru> <CAK-6q+gcs2djQfKRsuGpD7WERmbLhzjkHEm80MRe+2UE3bteKw@mail.gmail.com>
 <CAK-6q+hRbsFkQec3O8FnT-G9Mx07rdhEMfmTE2Q0SDN0kKN-8g@mail.gmail.com> <64dbd05c-4939-49ba-a8d5-807fe3ff2987@fintech.ru>
In-Reply-To: <64dbd05c-4939-49ba-a8d5-807fe3ff2987@fintech.ru>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 5 Feb 2024 14:49:26 -0500
Message-ID: <CAK-6q+gEjqCrnFkpKSuQiuhpx9zyuWr6y0tQpJOLquoz2pnmzw@mail.gmail.com>
Subject: Re: [PATCH RESEND] mac802154: Fix uninit-value access in ieee802154_hdr_push_sechdr
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Zhang Shurong <zhang_shurong@foxmail.com>, alex.aring@gmail.com, 
	stefan@datenfreihafen.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	harperchen1110@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 18, 2024 at 8:00=E2=80=AFAM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
..
>
> I was curious whether a smaller change would suffice since I might be
> too green to see the full picture here.
>
> In all honesty I am failing to see how exactly it happens that cb->secen
> =3D=3D 1 and cb->secen_override =3D=3D 0 (which is exactly what occurs du=
ring
> this error repro) at the start of mac802154_set_header_security().
> Since there is a check in mac802154_set_header_security()
>
>         if (!params.enabled && cb->secen_override && cb->secen)
>
> maybe we take off 'cb->secen_override' part of the condition? That way
> we catch the case when security is supposedly enabled without parameters
> being available (not enabled) and return with error. Or is this approach
> too lazy?

I need to see the full patch for this. In my opinion there are two patches =
here:

1. fix uninit values
2. return an error with some mismatched security parameters. (I think
this is where your approach comes in place)

The 1. case is what syzbot is complaining about and in my opinion easy
to fix at [0] to init some more default values of "struct dgram_sock"
[1].

Then 2. can be fixed afterwards.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/ieee802154/socket.c#n474
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/ieee802154/socket.c#n435


