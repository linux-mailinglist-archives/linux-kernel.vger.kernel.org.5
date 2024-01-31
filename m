Return-Path: <linux-kernel+bounces-45953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E00A0843851
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987C928AA2C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6377355E72;
	Wed, 31 Jan 2024 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrEr1tyw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA255C04
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687632; cv=none; b=MV/GuocdRH1A44Ayj1sZSJf7SUZKfPp3z5FV53ctS8CoHXer80SM8YG1HmDMGFcrQZf8iazgpL5tNlGlnJuUvi8bzKGjrzKNNOluLQpzPDCWyVgZR5kPjZG7y8/bWPF49MNBE54owLWgceqWJVjxIUUlT8zFfdQvU1I24K4jwK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687632; c=relaxed/simple;
	bh=W9r78muWkI7nDBVfVwQKxgwZF+QemuVc+xUj/UPzmy8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qws4TusrXpXcq8BHrkUoUOVYBQbWD5qX9I6VKp2sB/rbQkBZ8zBIgw/4pv3Xh1g5vsy1wkGPsR6oZCJYQ/yPKhl0PPksQHuZMmVHH+5tEXzM+BgGIejE77ZrgvURJ5KIUKpKSF/jdpD/8L/LHY2zw3wQgGAdse6jCBcKvfLv2Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HrEr1tyw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706687629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NoCqocFaREeAQQuKlxOEQkO+oRFd1J81Erw4wSxms6o=;
	b=HrEr1tyw2CSblJi+Rf3T78uByCZezJENRAQcezycd/nXtxRWsbZtIbHwQT8A05iqUiDqDd
	qoKwLF0xrCWg47XueCDriCL/6Rd2AWPOFYDEbY1CLUGnF+Blmtzn1YMJXywoqz4Iifj61f
	0jO1fblfYK5VV0/tGxsvUGQY+n5AyqM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-KHEcACATNOCZmihN0j5VXg-1; Wed, 31 Jan 2024 02:53:45 -0500
X-MC-Unique: KHEcACATNOCZmihN0j5VXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2346A86E91F;
	Wed, 31 Jan 2024 07:53:45 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.109])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A15D2166B31;
	Wed, 31 Jan 2024 07:53:41 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Yang Shi <shy828301@gmail.com>
Cc: oliver.sang@intel.com,  riel@surriel.com,  fengwei.yin@intel.com,
  willy@infradead.org,  cl@linux.com,  ying.huang@intel.com,
  akpm@linux-foundation.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm: mmap: map MAP_STACK to VM_NOHUGEPAGE
References: <20231221065943.2803551-1-shy828301@gmail.com>
	<20231221065943.2803551-2-shy828301@gmail.com>
Date: Wed, 31 Jan 2024 08:53:40 +0100
In-Reply-To: <20231221065943.2803551-2-shy828301@gmail.com> (Yang Shi's
	message of "Wed, 20 Dec 2023 22:59:43 -0800")
Message-ID: <878r46ym4b.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

* Yang Shi:

> From: Yang Shi <yang@os.amperecomputing.com>
>
> The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> boundaries") incured regression for stress-ng pthread benchmark [1].
> It is because THP get allocated to pthread's stack area much more possible
> than before.  Pthread's stack area is allocated by mmap without VM_GROWSDOWN
> or VM_GROWSUP flag, so kernel can't tell whether it is a stack area or not.
>
> The MAP_STACK flag is used to mark the stack area, but it is a no-op on
> Linux.  Mapping MAP_STACK to VM_NOHUGEPAGE to prevent from allocating
> THP for such stack area.

Doesn't this introduce a regression in the other direction, where
workloads expect to use a hugepage TLB entry for the stack?

It's seems an odd approach to fixing the stress-ng regression.  Isn't it
very much coding to the benchmark?

Thanks,
Florian


