Return-Path: <linux-kernel+bounces-65499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F717854DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390F61F24E99
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE796024E;
	Wed, 14 Feb 2024 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kc+gpjxi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16435FDD6
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927399; cv=none; b=ceEJG29NAO1Db/jUT7OCQVrMsE4qbwUB6QJqEUrrZtDSCgW6GZhAcovPULwIUm+jJ1NZ2VRoQ6SRVQxQbfiJTdwEjOwjTZfhp5IFFtKGHUfID2x+cFJFr6Sm/EICExYWDpFZ37fxtCNALPcKqZCucjhfWYlojdEqEfTDz/0kP5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927399; c=relaxed/simple;
	bh=NynwJ0AFNEyMAfXdjjgwyAof/FM1H7Av8eStEA2GWQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AZv6aEmovxq6VXx/zfXz5ZCRcP6z5AzoFgfQiQ1edAGoxtf6ypgALEsoWBo/e2id4Fb/De1PlHgMEglhrg+CpycOSz749j0Hni9HLxhKdAMn0uU9PZXQ5fRwFpSGi6kccqznvQhunhtQNelj5Ng4kPibI/26mkcv1SGiBfna9+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kc+gpjxi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707927396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NynwJ0AFNEyMAfXdjjgwyAof/FM1H7Av8eStEA2GWQ8=;
	b=Kc+gpjxiOKrD/RnlXipQQ/cxt6fzBMlxX+3zLAbaZDg57gqlAGq3u2wUlOCKzL+OPomk1W
	3UM7Uj++KTSqNZqXY8bm42957RgGokbohGWIKk9B4cciYQLLuvEy48U3JuwMfVer5s8weo
	c10aMUM6e1hxMtByDChBrDDbJhmwKD4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-66mnAALEPgmUI4-D32-EHg-1; Wed, 14 Feb 2024 11:16:34 -0500
X-MC-Unique: 66mnAALEPgmUI4-D32-EHg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a27eddc1c27so131515966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707927393; x=1708532193;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NynwJ0AFNEyMAfXdjjgwyAof/FM1H7Av8eStEA2GWQ8=;
        b=oj+830+wN19hOL1bDhFjd2BxRNYdQgmfYTZh7hT1RwwRXZbLonRJklMVlp+GrnPx+h
         5MJGsm8alHoCfAqp7B45g8aGIyhR3txDf3ENTOACVoVuJDdfmt17jkpVoVt3xA5V2+IM
         1dlknOY5JzwWiO13u1iO5GpwahuoNi3dKT0lkO/PAwjXD46eoe4wwn86qBOumNhhel0x
         /djjaFdeGk72n01xjgpz98uyRq7lAa0t7jKg6uaG//P0BMHILiYuqfr+8dJRfaCOkTs5
         pZtAio9AiJExzaZXe0VX98+ljGAtHXD7Ib1lw9K1iOog/vG+aY7azo8Zdh5nhAgXo6mF
         OzDA==
X-Forwarded-Encrypted: i=1; AJvYcCUJZrPhYvlspQmziDYK3RHydWImMpw+XaNxR8GkXBXBnAn7t9UtyOZupq1vIMA/NmlTRvLZLrKxc0B2KAyfn/J4ej6IxlSvSAcBEKaH
X-Gm-Message-State: AOJu0Ywbrwf+Uh7YoQUhepgJHfxLtfwuw+bk7XRjmakZpLTFwq2f+4yU
	pz+pRwPsFdeYtEvh4d7CKvJHKHhIBxrGUHdo/j/W7eLf35w405ayURkR8cVXparZ9wu8EV66nAh
	E5c+h3JvpgmsmYEeKe8PTNm4Aq/y7kaVBJk+f7PvTNUPWc4g42IZxJDW0LS6Qeg==
X-Received: by 2002:a17:906:b295:b0:a3d:7559:6ed1 with SMTP id q21-20020a170906b29500b00a3d75596ed1mr180336ejz.4.1707927393604;
        Wed, 14 Feb 2024 08:16:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBF50fj2t1VrO4nlcJxfDzb3+UgO6SrtoiH8S6oP0zsV+naqCZz8OsshNnXDp0xJ5kbRGiJA==
X-Received: by 2002:a17:906:b295:b0:a3d:7559:6ed1 with SMTP id q21-20020a170906b29500b00a3d75596ed1mr180311ejz.4.1707927393183;
        Wed, 14 Feb 2024 08:16:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvWSzW/sHbHaDDzeSp1uL8SKv5n9VHwyIwWL7PGYq0Ek7HvpPw616TcD402iBl0wutzUvWVCAVEQ29muGToMScmOgRaJ1PMCgmnGQCAbVp6qvs/t0Pl2OeofCKEBrj5e1zQCkSs5GlDvLUIkMRlCY+d6+jH3c4aCcDacPCCdVQ0vIXMATTuIO6E9b2ZhNJhtUIWRhrLp/1YNd9amOmlTfUUtKibKRlmp2prRkrJFuu1KLpvU8yBSjKFsTeplDxqRydRYtBlGOoJG+qMybE+Oy+b9mj8mxubSjhmQs7IorCsGXhahWgAJ9AcB/MPNDoAkgflCXMGbgH
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id cw5-20020a170907160500b00a3ce60b003asm2260365ejd.176.2024.02.14.08.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 08:16:32 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4A91510F57EE; Wed, 14 Feb 2024 17:16:32 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Jakub Kicinski <kuba@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf/test_run: increase Page Pool's ptr_ring
 size in live frames mode
In-Reply-To: <20240214153838.4159970-1-aleksander.lobakin@intel.com>
References: <20240214153838.4159970-1-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Feb 2024 17:16:32 +0100
Message-ID: <87cyszdnrz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Currently, when running xdp-trafficgen, test_run creates page_pools with
> the ptr_ring size of %NAPI_POLL_WEIGHT (64).
> This might work fine if XDP Tx queues are polled with the budget
> limitation. However, we often clear them with no limitation to ensure
> maximum free space when sending.
> For example, in ice and idpf (upcoming), we use "lazy" cleaning, i.e. we
> clean XDP Tx queue only when the free space there is less than 1/4 of
> the queue size. Let's take the ring size of 512 just as an example. 3/4
> of the ring is 384 and often times, when we're entering the cleaning
> function, we have this whole amount ready (or 256 or 192, doesn't
> matter).
> Then we're calling xdp_return_frame_bulk() and after 64th frame,
> page_pool_put_page_bulk() starts returning pages to the page allocator
> due to that the ptr_ring is already full. put_page(), alloc_page() et at
> starts consuming a ton of CPU time and leading the board of the perf top
> output.
>
> Let's not limit ptr_ring to 64 for no real reason and allow more pages
> to be recycled. Just don't put anything to page_pool_params::size and
> let the Page Pool core pick the default of 1024 entries (I don't believe
> there are real use cases to clean more than that amount of descriptors).
> After the change, the MM layer disappears from the perf top output and
> all pages get recycled to the PP. On my test setup on idpf with the
> default ring size (512), this gives +80% of Tx performance with no
> visible memory consumption increase.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Hmm, so my original idea with keeping this low was to avoid having a lot
of large rings lying around if it is used by multiple processes at once.
But we need to move away from the per-syscall allocation anyway, and
with Lorenzo's patches introducing a global system page pool we have an
avenue for that. So in the meantime, I have no objection to this...

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


