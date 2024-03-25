Return-Path: <linux-kernel+bounces-116374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C94EA889923
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9D21F2F31D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75BE3A8D0;
	Mon, 25 Mar 2024 05:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0AlS4FZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5098130ACF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711330954; cv=none; b=szH9UxYj8MzhUPOHg+fB1wFIEG/zV3qhsFmI/gQiA8EAUBU0khjKpLr55+1UxDrLtBsexiY5Lc2cNNeVTwvoinulIyRrijfIUXN7QVdxxYkM0GP2u9hK8eFT4M6lK75RrawYCO9PgTw6B/GELK4Jhdu3Bk3fazGkc9UOr5h+iOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711330954; c=relaxed/simple;
	bh=6loy/0q04b6ayFmnbr9h3yiIa/DSXvoMTj2G28w1+7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/cKsK+k/BEkVu/cIMUB3ahIcfFfB9SRkcp7W49fqrWDSuOzkfp/eeK6gKdsI65ZElJqkAHGFnGKdeHNrdPkd0OiPqkiPBYuX/w4hX/PC8+eSdb9Tvf+IUVAPm4bZGJVzeO/ow5WmPhtUxnql9MWFUVWB0BoYsYUrgwJvTHeDYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0AlS4FZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711330951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJ+1YtdvUOwXvTS2idsRTnR4T3Z82MELgPYzRzwYWno=;
	b=H0AlS4FZ4O1r+A73I9eQo98R2xM2PWchOZvNipu+JlgF54n5yEVLDywDxGwDuPMaBtiyTX
	pjMqY9rwGga3PYCCwx571+PBsNBvwz7TBnpXIHZNf4gBeqaIK8JPPMMQtRuzqV28OtAWhz
	YCVvs1vzoruN5qT+bj2c8vECQjSmFOY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-7B4C85FnPf2LuTKx9ZHYvQ-1; Sun,
 24 Mar 2024 21:42:29 -0400
X-MC-Unique: 7B4C85FnPf2LuTKx9ZHYvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F2253802AC6;
	Mon, 25 Mar 2024 01:42:29 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BE7361121313;
	Mon, 25 Mar 2024 01:42:27 +0000 (UTC)
Date: Mon, 25 Mar 2024 09:42:20 +0800
From: Baoquan He <bhe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	akpm@linux-foundation.org, chenhuacai@loongson.cn,
	dyoung@redhat.com, jbohac@suse.cz, lihuafei1@huawei.com,
	chenhaixiang3@huawei.com
Subject: Re: [PATCH] crash: use macro to add crashk_res into iomem early for
 specific arch
Message-ID: <ZgDWfMctnoLfAUa3@MiWiFi-R3L-srv>
References: <20240324033513.1027427-1-bhe@redhat.com>
 <Zf+m4YtKtmdrjw4Q@gmail.com>
 <Zf/51a+QonYj6sI7@MiWiFi-R3L-srv>
 <ZgAAIB6H+7+t7YpW@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgAAIB6H+7+t7YpW@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 03/24/24 at 11:27am, Ingo Molnar wrote:
> 
> * Baoquan He <bhe@redhat.com> wrote:
> 
> > On 03/24/24 at 05:06am, Ingo Molnar wrote:
> > > 
> > > * Baoquan He <bhe@redhat.com> wrote:
> > > 
> > ......snip
> > > > ---
> > > >  arch/x86/include/asm/crash_reserve.h | 2 ++
> > > >  kernel/crash_reserve.c               | 7 +++++++
> > > >  2 files changed, 9 insertions(+)
> > > > 
> > > > diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
> > > > index 152239f95541..4681a543eba3 100644
> > > > --- a/arch/x86/include/asm/crash_reserve.h
> > > > +++ b/arch/x86/include/asm/crash_reserve.h
> > > > @@ -39,4 +39,6 @@ static inline unsigned long crash_low_size_default(void)
> > > >  #endif
> > > >  }
> > > >  
> > > > +# define HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
> > > > +
> > > 
> > > Any reason for that stray space?
> > 
> > No clear reason. I saw stray space was added for macro definning when my
> > below patch was merged, not sure if this is preferred.
> 
> No, it's not preferred - and I don't see any stray spaces added in the 
> code added by:
> 
> > commit 85fcde402db1 ("kexec: split crashkernel reservation code out from crash_core.c")

Ah, the stray spaces are added in below macros defining, I thought they
are all the same. I didn't know nested/conditional defines and
standalone defines are different. Thanks for careful checking and telling.

arch/x86/include/asm/crash_reserve.h:
#ifdef CONFIG_X86_32
# define CRASH_ADDR_LOW_MAX     SZ_512M
# define CRASH_ADDR_HIGH_MAX    SZ_512M
#else
# define CRASH_ADDR_LOW_MAX     SZ_4G
# define CRASH_ADDR_HIGH_MAX    SZ_64T
#endif

> 
> Anyway, please just remove it.

Sure, will update and v2.

> 
> > And there are a lot of "# define " when searching with 'git grep "# 
> > define " arch/x86/include/'.
> 
> The overwhelming majority of those are not standalone defines like 
> yours, but nested/conditional defines where the space is justified:
> 
> #ifdef CONFIG_X86_32
> # define MAX_IO_APICS 64
> # define MAX_LOCAL_APIC 256
> #else
> # define MAX_IO_APICS 128
> # define MAX_LOCAL_APIC 32768
> #endif
> 
> Thanks,
> 
> 	Ingo
> 


