Return-Path: <linux-kernel+bounces-40569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B8B83E28B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609292846CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865A7225AE;
	Fri, 26 Jan 2024 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TT9BWieN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8E224E4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297505; cv=none; b=o8mVRBzzYtAX2yc8Nwy4wN5H9e6Oq9nA2UJGogIdt8fBvb7dXByTJEfoNII6WDLTz8kWAenXJ9dcbUhgLBZ/G3CDjjZQWio8nBRILI3EJi/vgfS5qpd3TKJlHA7JZstS7YamSiyB8NimvSmMRa4OvF9sV5usvGMyln//Z+3sgAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297505; c=relaxed/simple;
	bh=QJ9CAa5A/yNS1CZvD8wdvEiJQuGv9F0gPuW/DiBsYxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iqi8P6LMG6JF94yJAoOqkjzQc4e+iVnpkbCRFeF4gyAAhU3oav94AR4cTD7utZLkNL6YZ2CgXFTIVseBCHRVBhoOVN53lm4ipGepMWTo79Oe+24vr/vO0VnkUZuKudD0hpXV1vF2d4vVNzSL6sH70Aivfu6JjSLZBSd6b3O8BaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TT9BWieN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706297503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8O4KZiKHB/hwZHbW9Vu9NJR3ZSgU5Japxu+5xbR0p5w=;
	b=TT9BWieNHRXN2ezqmV+/toEUjF5FC60yUOHwjIvblQlx8HIp2LFkgo3KlGjsqDDetCf4P7
	heh3zTc+ZQyMZZbbO4PRIQil0PhPyCBhIrYXUF+RPXR0SEsg/kygPuHuX8rFA/wqpG2ZHA
	J0a5T2GB9Nl1Q/4q9QjzJEeOOjuzJrw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-_qGGXYebOpedveeHiao1_A-1; Fri, 26 Jan 2024 14:31:41 -0500
X-MC-Unique: _qGGXYebOpedveeHiao1_A-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-602acac08c8so11348077b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:31:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706297501; x=1706902301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8O4KZiKHB/hwZHbW9Vu9NJR3ZSgU5Japxu+5xbR0p5w=;
        b=cHKjw9hR7iOgHtjxt8oaFZn20W2PZ2hPlCusmam9dAVaf6Yt2inMvwPojvW7xTRI1n
         wItqWNLtaT2r4X7wHXt0WrEr1f3XEbpXuq6WI2H/bqS9TQfdndtsfWhnj/78JK2MdX12
         EJOrLOQUkLwEB86ELklbPSTAzdgMJvKSAIna5Q0osqoNTg8k4Ywd0EyXA9hJL6YnJPn2
         rhAaLRzRPHpofyfhrIFPL4/ptWWvWoy5fnrLnTBrBXM4NALZBLgVcsrGDCYNm/+2ZL2D
         DuzkK1MHIkAnydxCEzqmzunT0QtITKJ8PsLf1xwPAs9vS4V4il50p1kOaLvXbd4P5gtB
         NHoQ==
X-Gm-Message-State: AOJu0Yyc25HSXaqHjNAJJaW/tr7or20JBjMqQKbojnA96qZ9BC7Dk0Mb
	9dTowRHxbxkufHqCN3XU5zjhwFi5UoU5PU+TZMvnqVHwUhnIDnT0HoDqSMxomOLKGVzKxv/Mi/H
	cgW3mGIqHASifBdLrR8VfSoFCS4YkgErkJJcUk0dCCLdGlpCcmnRbtrMWG3+noFJNgJBCNAm/8f
	z6dxpSrJXLdOhHHs9WLCa3beaR/K+gLvTdk//f
X-Received: by 2002:a81:4cce:0:b0:602:c7e7:4721 with SMTP id z197-20020a814cce000000b00602c7e74721mr291695ywa.98.1706297501195;
        Fri, 26 Jan 2024 11:31:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0RByXyJ/rysgPkfpq/s7XLE5JytXnsA6kZpBjPROqnD6sbZsuB+j2dxLKBC6MlOZRhXkfdAdA9aE4HMKjgVA=
X-Received: by 2002:a81:4cce:0:b0:602:c7e7:4721 with SMTP id
 z197-20020a814cce000000b00602c7e74721mr291681ywa.98.1706297500954; Fri, 26
 Jan 2024 11:31:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-32-keescook@chromium.org>
In-Reply-To: <20240123002814.1396804-32-keescook@chromium.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 26 Jan 2024 20:31:04 +0100
Message-ID: <CAJaqyWdGAb088DxKq4ELBeir=PGrqkRuQ0FYkTBwKkfJa4SWbQ@mail.gmail.com>
Subject: Re: [PATCH 32/82] vringh: Refactor intentional wrap-around calculation
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 2:42=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
>
>         VAR + value < VAR
>
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
>
> Refactor open-coded unsigned wrap-around addition test to use
> check_add_overflow(), retaining the result for later usage (which removes
> the redundant open-coded addition). This paves the way to enabling the
> unsigned wrap-around sanitizer[2] in the future.
>
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f185365=
94 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: virtualization@lists.linux.dev
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/vhost/vringh.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 7b8fd977f71c..07442f0a52bd 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -145,6 +145,8 @@ static inline bool range_check(struct vringh *vrh, u6=
4 addr, size_t *len,
>                                bool (*getrange)(struct vringh *,
>                                                 u64, struct vringh_range =
*))
>  {
> +       u64 sum;

I understand this is part of a bulk change so little time to think
about names :). But what about "end" or similar?

Either way,
Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> +
>         if (addr < range->start || addr > range->end_incl) {
>                 if (!getrange(vrh, addr, range))
>                         return false;
> @@ -152,20 +154,20 @@ static inline bool range_check(struct vringh *vrh, =
u64 addr, size_t *len,
>         BUG_ON(addr < range->start || addr > range->end_incl);
>
>         /* To end of memory? */
> -       if (unlikely(addr + *len =3D=3D 0)) {
> +       if (unlikely(U64_MAX - addr =3D=3D *len)) {
>                 if (range->end_incl =3D=3D -1ULL)
>                         return true;
>                 goto truncate;
>         }
>
>         /* Otherwise, don't wrap. */
> -       if (addr + *len < addr) {
> +       if (check_add_overflow(addr, *len, &sum)) {
>                 vringh_bad("Wrapping descriptor %zu@0x%llx",
>                            *len, (unsigned long long)addr);
>                 return false;
>         }
>
> -       if (unlikely(addr + *len - 1 > range->end_incl))
> +       if (unlikely(sum - 1 > range->end_incl))
>                 goto truncate;
>         return true;
>
> --
> 2.34.1
>
>


