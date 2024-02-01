Return-Path: <linux-kernel+bounces-48415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0825845BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833531F2C270
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9660D62159;
	Thu,  1 Feb 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbxzJq7g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9671E894
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801655; cv=none; b=GZMgwE2oga95MdzeIXGkrhRR/mlyT9WdH8imcx9x5cqXQT4w3Qe+AWEjXRx8+I+YeUfVsrwwO/VQQfb6s6kBhLR5rCiDd71EWDbFg27aGHMQ4C4tr6cUVwb98POG8C/9GtE8hwDBrUkoIBTCV/uRHqiFyjOccxq5wPC3nwackew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801655; c=relaxed/simple;
	bh=V5+D8HewZFxaQtgiLDM3YvRfVj6YfWYNUH5qXt8yw0I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VFDRAcQXjys+L28fPgXRKxs0y5mSBAJVcoXBYUmqk+hwYNYpL7ZDOrzOhwrfo5niAZg41x67xY4gEJBDlaX8p0tcsaF4WpJM71Ssbbljspq3DZ71RiVZK0rcF4AEDfJoZ9zaoi/9mCvX80yfOwl9wutBlojE52iLjuiDDLqUAw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XbxzJq7g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706801653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLmnE/gYkTuSx/M0LwIfDVXAISrRFGPert75rch5DJk=;
	b=XbxzJq7grCYt6QOeWS8huumBf65KXkPKhzJxSGVfPbrDgyP0vgQA8+9vWfCoLGANncke9i
	sqZnvUkp2mqJciEPpacxooTMOrle/CYOEPJfY3XzqbGYJ3Ij/Sy0D0taEl5123uc8ar2xH
	Tc3nZxVCNNSMBjHj4wIJlNDDeNfn7Rk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-JXOlJ8RbOkG3YtoFU44Oiw-1; Thu, 01 Feb 2024 10:34:09 -0500
X-MC-Unique: JXOlJ8RbOkG3YtoFU44Oiw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA6E6848C0A;
	Thu,  1 Feb 2024 15:34:08 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B13A81C060AF;
	Thu,  1 Feb 2024 15:34:06 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Yang Shi <shy828301@gmail.com>
Cc: oliver.sang@intel.com,  riel@surriel.com,  fengwei.yin@intel.com,
  willy@infradead.org,  cl@linux.com,  ying.huang@intel.com,
  akpm@linux-foundation.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm: mmap: map MAP_STACK to VM_NOHUGEPAGE
References: <20231221065943.2803551-1-shy828301@gmail.com>
	<20231221065943.2803551-2-shy828301@gmail.com>
	<878r46ym4b.fsf@oldenburg.str.redhat.com>
	<CAHbLzkq1ah6y-dCgA0rFePNn3FsE8ebuSNd+jaS8sO51a=X9Yw@mail.gmail.com>
Date: Thu, 01 Feb 2024 16:34:01 +0100
In-Reply-To: <CAHbLzkq1ah6y-dCgA0rFePNn3FsE8ebuSNd+jaS8sO51a=X9Yw@mail.gmail.com>
	(Yang Shi's message of "Wed, 31 Jan 2024 10:46:48 -0800")
Message-ID: <87frycryfq.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

* Yang Shi:

> On Tue, Jan 30, 2024 at 11:53=E2=80=AFPM Florian Weimer <fweimer@redhat.c=
om> wrote:
>>
>> * Yang Shi:
>>
>> > From: Yang Shi <yang@os.amperecomputing.com>
>> >
>> > The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
>> > boundaries") incured regression for stress-ng pthread benchmark [1].
>> > It is because THP get allocated to pthread's stack area much more poss=
ible
>> > than before.  Pthread's stack area is allocated by mmap without VM_GRO=
WSDOWN
>> > or VM_GROWSUP flag, so kernel can't tell whether it is a stack area or=
 not.
>> >
>> > The MAP_STACK flag is used to mark the stack area, but it is a no-op on
>> > Linux.  Mapping MAP_STACK to VM_NOHUGEPAGE to prevent from allocating
>> > THP for such stack area.
>>
>> Doesn't this introduce a regression in the other direction, where
>> workloads expect to use a hugepage TLB entry for the stack?
>
> Maybe, it is theoretically possible. But AFAICT, the real life
> workloads performance usually gets hurt if THP is used for stack.
> Willy has an example:
>
> https://lore.kernel.org/linux-mm/ZYPDwCcAjX+r+g6s@casper.infradead.org/#t
>
> And avoiding THP on stack is not new, VM_GROWSDOWN | VM_GROWSUP areas
> have been applied before, this patch just extends this to MAP_STACK.

If it's *always* beneficial then we should help it along in glibc as
well.  We've started to offer a tunable in response to this observation
(also paper over in OpenJDK):

  Make thread stacks not use huge pages
  <https://bugs.openjdk.org/browse/JDK-8303215>

But this is specifically about RSS usage, and not directly about
reducing TLB misses etc.

Thanks,
Florian


