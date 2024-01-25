Return-Path: <linux-kernel+bounces-39345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A8983CF20
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03BFA1C25C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F6413AA4E;
	Thu, 25 Jan 2024 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5QSbJnZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D641613A272
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706220284; cv=none; b=R66pQTqKdN5ePqs+P4Vo+mBfavNoF4u4+1tSXSzJNXTZenXWPba9FSweOmcBzbL4McZCA0+i/6I4+L7Q0WotjTn6R4cpx40qZGQq2qR2iEEUqP757OPaHlTiftGwHTixjoj5B56D/oIN78ad8bvFTuVMHoc58MZbZJDAqdDQET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706220284; c=relaxed/simple;
	bh=F6BdAOpGQ3/dhQX/Njz5YjMdVFa6pj6a+ARiS6t0Kn8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TkFTaUZP0274hT6i21jPvsdGz9EsTARuPyNPAIAtGXhcmPCgBhkbtazriiFWLVmZSQTmsJxTSR0CHQrffeRO7j+0wvzhGm1yi638NtyV1qF4WByNn6YzTc6huC91nG1cq57X27g0MY+2TgGiNLVx9VgCvsV2Ms+lNxqQEfMpTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5QSbJnZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706220281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ND3gC5edxcaoPgStVxLJXgo22mQ2Z/46B7atIlzRitw=;
	b=N5QSbJnZo8xJYHusA0Iq719tY4/oczu6Ejzd0Trg1GitA6wcIWmOZbVBExt340zw9DSIT1
	Ges2Dkhdg88SXdCB2ZV/PVswVm1AAlwU/WqpbF6ElF+W5ZixVnwF/UckyS4m3vvWRipr4t
	PxWc6ziI4Gz+rq2i51NR+0BAnwDhCpE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-27xKG1s-PhSUfzCTcz0Ing-1; Thu,
 25 Jan 2024 17:04:36 -0500
X-MC-Unique: 27xKG1s-PhSUfzCTcz0Ing-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 104993C13A8C;
	Thu, 25 Jan 2024 22:04:36 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A21CE3C2E;
	Thu, 25 Jan 2024 22:04:35 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 88DD030C72AB; Thu, 25 Jan 2024 22:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 844DE3FB50;
	Thu, 25 Jan 2024 23:04:35 +0100 (CET)
Date: Thu, 25 Jan 2024 23:04:35 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
    linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
    Mike Snitzer <msnitzer@redhat.com>, Ignat Korchagin <ignat@cloudflare.com>, 
    Damien Le Moal <damien.lemoal@wdc.com>, Hou Tao <houtao1@huawei.com>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] softirq: fix memory corruption when freeing
 tasklet_struct
In-Reply-To: <CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com>
Message-ID: <586ca4dd-f191-9ada-1bc3-e5672f17f7c@redhat.com>
References: <82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com> <CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1



On Thu, 25 Jan 2024, Linus Torvalds wrote:

> On Thu, 25 Jan 2024 at 10:30, Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > There's a problem with the tasklet API - there is no reliable way how to
> > free a structure that contains tasklet_struct. The problem is that the
> > function tasklet_action_common calls task_unlock(t) after it called the
> > callback. If the callback does something that frees tasklet_struct,
> > task_unlock(t) would write into free memory.
> 
> Ugh.
> 
> I see what you're doing, but I have to say, I dislike this patch
> immensely. It feels like a serious misdesign that is then papered over
> with a hack.
> 
> I'd much rather see us trying to move away from tasklets entirely in
> cases like this. Just say "you cannot do that".

OK. I will delete tasklets from both dm-crypt and dm-verity - it will 
simplify them quite a bit.

BTW. Do you think that we should get rid of request-based device mapper as 
well? (that's another thing that looks like code bloat to me)

Mikulas


