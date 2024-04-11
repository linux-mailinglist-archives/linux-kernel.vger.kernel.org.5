Return-Path: <linux-kernel+bounces-140035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2F18A0A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B612865B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA20213E8AD;
	Thu, 11 Apr 2024 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIfUs1xS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E813DDD4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822080; cv=none; b=d66w6as/ehQKfiTw2h7iTfsPhk/YghPSTC7BhI2p5F8W7rcOU++lzHqF9L/M3Em6kpqEbumZOh9RV5NVza6/cxfyCvazVP9gav/FJ8epazImkya2hBd2wuuYByzKbdoI8w4j/6tpMOuWeGdGN7bTvG4X8XtdLdEdIiwu5YkwYFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822080; c=relaxed/simple;
	bh=ZimJfwvl3WzhsFTbPcUKcAmZJIX5Tie8DjUsEOTGLWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXHTrjRf+2zmhKhSga7oCfv+q5JB8FBGQaXhkUU7BmKSnCQcpw1A5r+iCuhWt/v/y3xf74hJUs9Quk2KLGn1nEkMv9D67d75UXsXHxqwWNBPHWfYlN3UhYTNJuURbQYxesQJMJQV1j9HBE59OFQHc+kBrtOZcvE+VCi8OUXk5yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIfUs1xS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712822077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxDRipmzDDBkSip6m/UVrfqyWqi0BJV7Yyl6Xvbo+6E=;
	b=NIfUs1xSlJNu0kCvawMt43rf+V9HRJmVVzXmoiAJsK8exkQVs1jEIEw4dBzGjvUkaHbZNg
	tb89vEgpXbTfB41JX5UXFhwny3dD6tySAVet1b2x9f8bB8j+gTmzsAuF07PWePaIaAKRy6
	01epJmWSH+kdIKXY4dMsY300+fM9pwQ=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-P29VKBSvMiioVpp9nSkdaw-1; Thu, 11 Apr 2024 03:54:35 -0400
X-MC-Unique: P29VKBSvMiioVpp9nSkdaw-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-dcdc3db67f0so856408276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712822075; x=1713426875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxDRipmzDDBkSip6m/UVrfqyWqi0BJV7Yyl6Xvbo+6E=;
        b=cDt1IA9xqWzUOpH59et8IXxoj+jlIrEWP/o7pUNxSxhfrQ+1O6wbee/ri5gil0vErU
         bLd6c9Gf834BCpmGuj7EdkVlZVKBPUBqUxkddbpkRsZNYF0Fh4s52lyiF35RO3gOcGLN
         vjGTu1qxxZESAg85obxI7D6gdh5DVCvFXIh5j9S5aC+y/wmRthjEmzzJlJjqwLCoPei4
         3g3RKCqeGakuDx/5jpqXm9auYwQ5uEXkcFGqWHONa80KhDsQZHD3mhFU8ERC6cTTXJ8Y
         27IeTtyIpzJWao81gYteWvTU8BtFEezr+otcF88p5GZuIqcUSVNH5VBl1QzyssH49PqL
         I4Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUfiY33thhrMcQtWYU1AugvoS2APlb3TJbUwAX9gx/xJcZVRXV7oHyrJ7tJzQbD/omswZAcCpW1Promi1hnaYjE/60o91riulNRDJdd
X-Gm-Message-State: AOJu0YzWKMVkvZ6t1KfDd4/6XmjellXH0eKa3Mp0jADWOikkJPeB8KDx
	UQKaT4/XNigcSryOrNfPiEI0tbQHfrqgqmhoEDPfXsdPFrF6WuZI2rr01UbyqXbloaoPU8alxrb
	yHtk3byeGfyeHxXb/M/vHrYlMrHHF5VeGn2D7KrVic0o3BP0EK2XkCnTT+WtZeMkoLaboyJHTr6
	80lltFSQqQF8Gw/STrbQ7GgBznA1H9vXm8jEv4
X-Received: by 2002:a25:cd82:0:b0:dc6:ca3a:31da with SMTP id d124-20020a25cd82000000b00dc6ca3a31damr1446418ybf.16.1712822075237;
        Thu, 11 Apr 2024 00:54:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4/VROz6VRwtxqGZSnsbr8an7LRWsYWB4kGZ99T+tllX8qYXGWqrOEg5CQ+iJUfbEzOcupJtkqlQIST/p0M3k=
X-Received: by 2002:a25:cd82:0:b0:dc6:ca3a:31da with SMTP id
 d124-20020a25cd82000000b00dc6ca3a31damr1446407ybf.16.1712822074917; Thu, 11
 Apr 2024 00:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405164920.2844-1-mcassell411@gmail.com>
In-Reply-To: <20240405164920.2844-1-mcassell411@gmail.com>
From: Vratislav Bendel <vbendel@redhat.com>
Date: Thu, 11 Apr 2024 09:54:18 +0200
Message-ID: <CAHrQN1xuLfc0sfe1kMHmHrBzKQLMD-6PNEakA=EDdabEv4ATnQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/admin-guide/sysctl/vm.rst adding the
 importance of NUMA-node count to documentation
To: Matthew Cassell <mcassell411@gmail.com>
Cc: corbet@lwn.net, akpm@linux-foundation.org, rppt@kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 6:49=E2=80=AFPM Matthew Cassell <mcassell411@gmail.c=
om> wrote:
>
> If any bits are set in node_reclaim_mode (tunable via
> /proc/sys/vm/zone_reclaim_mode) within get_pages_from_freelist(), then
> page allocations start getting early access to reclaim via the
> node_reclaim() code path when memory pressure increases. This behavior
> provides the most optimization for multiple NUMA node machines. The above
> is mentioned in:
>
> Commit 9eeff2395e3cfd05c9b2e6 ("[PATCH] Zone reclaim: Reclaim logic")
> states "Zone reclaim is of particular importance for NUMA machines. It
> can be more beneficial to reclaim a page than taking the performance
> penalties that come with allocating a page on a REMOTE zone."
>
> While the pros/cons of staying on node versus allocating remotely are
> mentioned in commit histories and mailing lists. It isn't specifically
> mentioned in Documentation/ and isn't possible with a lone node. Imagine =
a
> situation where CONFIG_NUMA=3Dy (the default on most major distributions)
> and only a single NUMA node exists. The latter is an oxymoron
> (single-node =3D=3D uniform memory access). Informing the user via vm.rst=
 that
> the most bang for their buck is when multiple nodes exist seems helpful.
>

I agree that the documentation could be improved to better express the
implications
and relevance of setting zone_reclaim_mode bits.

Though I would suggest to go a step further and also elaborate on
those "additional actions",
for example something like:
"The page allocator will attempt to reclaim memory within the zone,
depending on the bits set,
before looking for free pages in other zones, namely on remote memory nodes=
"

> Signed-off-by: Matthew Cassell <mcassell411@gmail.com>
> ---
>  Documentation/admin-guide/sysctl/vm.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admi=
n-guide/sysctl/vm.rst
> index c59889de122b..10270548af2a 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -1031,7 +1031,8 @@ Consider enabling one or more zone_reclaim mode bit=
s if it's known that the
>  workload is partitioned such that each partition fits within a NUMA node
>  and that accessing remote memory would cause a measurable performance
>  reduction.  The page allocator will take additional actions before
> -allocating off node pages.
> +allocating off node pages. Keep in mind enabling bits in zone_reclaim_mo=
de
> +makes the most sense for topologies consisting of multiple NUMA nodes.
>
>  Allowing zone reclaim to write out pages stops processes that are
>  writing large amounts of data from dirtying pages on other nodes. Zone
> --
> 2.34.1
>


