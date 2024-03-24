Return-Path: <linux-kernel+bounces-112628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611CC887C30
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859B12817AC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 10:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3565817555;
	Sun, 24 Mar 2024 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dn9txOjl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8596C7465
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711274474; cv=none; b=qlWy/1XokMGslGv9rtm0Dy/FHB88p/DA5fYADOQuqXEij8RGlHJ6AI8IV4klBYb0VA61yy5xAi12OGE80MrHYqjF72TSRzrGeqy669mA74FjC69gdlPpxOjR4PIzp3PTwkeb6ps+JzhzAA3ov9dUl93iDf51zo5EObyk5n0kUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711274474; c=relaxed/simple;
	bh=pnPspqavpoMtwsq/RvAuAeEffw+/GmMh9oZI8PuHgIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEgZTEVVB7eEJys1gQ7WxvDbNF+soK7hXu0G1t5GcBuuh7QaiGeiLZlDc5++kONMgzsa/mG8ISG2fUfdqCjpwUo5uAKRC443gIBIbq1fKWmGr0xJPFXUn+Qnwje9Bg9impHioLefM8Hawjx+FPfYanoid+2ZO+7i4qsj4TM+NPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dn9txOjl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711274471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfH3QzU95PzfsukOJ1WaAwTLgYf8vlvgxPDNhEf4xog=;
	b=Dn9txOjl85lJIlXOt2t8CpRcH6vT6MsfzLpi0N+USWGGSew+PT2CL86r0MDHyx+x7WdHNU
	dH6N06Znjv/oVgGYPXJngV/nYRYTmpp7cCFhWnFhDHxjGAE/uZh90QSC71O9qAJYUfzxf2
	aDlg8em5ul4YCVGwuM4mbwai118YMRw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-wDbvS-nJNOSmsMCHyVhjNg-1; Sun,
 24 Mar 2024 06:01:08 -0400
X-MC-Unique: wDbvS-nJNOSmsMCHyVhjNg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F8B81C05AF4;
	Sun, 24 Mar 2024 10:01:07 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7ED5D492BD3;
	Sun, 24 Mar 2024 10:01:04 +0000 (UTC)
Date: Sun, 24 Mar 2024 18:00:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	akpm@linux-foundation.org, chenhuacai@loongson.cn,
	dyoung@redhat.com, jbohac@suse.cz, lihuafei1@huawei.com,
	chenhaixiang3@huawei.com
Subject: Re: [PATCH] crash: use macro to add crashk_res into iomem early for
 specific arch
Message-ID: <Zf/51a+QonYj6sI7@MiWiFi-R3L-srv>
References: <20240324033513.1027427-1-bhe@redhat.com>
 <Zf+m4YtKtmdrjw4Q@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf+m4YtKtmdrjw4Q@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 03/24/24 at 05:06am, Ingo Molnar wrote:
> 
> * Baoquan He <bhe@redhat.com> wrote:
> 
.....snip
> > ---
> >  arch/x86/include/asm/crash_reserve.h | 2 ++
> >  kernel/crash_reserve.c               | 7 +++++++
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
> > index 152239f95541..4681a543eba3 100644
> > --- a/arch/x86/include/asm/crash_reserve.h
> > +++ b/arch/x86/include/asm/crash_reserve.h
> > @@ -39,4 +39,6 @@ static inline unsigned long crash_low_size_default(void)
> >  #endif
> >  }
> >  
> > +# define HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
> > +
> 
> Any reason for that stray space?

No clear reason. I saw stray space was added for macro definning when my
below patch was merged, not sure if this is preferred. And there are
a lot of "# define " when searching with 'git grep "# define " arch/x86/include/'.

commit 85fcde402db1 ("kexec: split crashkernel reservation code out from crash_core.c")


