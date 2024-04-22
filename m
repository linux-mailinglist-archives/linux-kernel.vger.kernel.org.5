Return-Path: <linux-kernel+bounces-154030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C6E8AD64E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AAB283326
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888CC1C6A7;
	Mon, 22 Apr 2024 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnH0j7QZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440641BC53
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713820099; cv=none; b=JOUWR2M8HwV+OWXD58TGMKtzRhTNI9+hB7AnEGKhrXECnkiQJE31WCD6atNcNR8sQCzwZ4Ih2VCOgUvf4U0ABSM4NPFkFOo4OmR8QEh0GbMLwejKvmiIBKaTQMatGrHEP2b1qsCcfYmQMRIZqPZch+CoAyZUZ8URbB90/ZWsO/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713820099; c=relaxed/simple;
	bh=2qAlw6f4QYW3oaPT74jNSmTYmLUa/63MwQIXFScO3Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+kIAcFwQ1wv90KrYH2fkvMDzhbM5KjmaT+pCnSUAs0TWXOOOfFzOcgUkq2vro5fALKTwtzwmns5uWQtA4Q4z82zC5pRyhXxQ0kcxSlewcThzj4X+NU0t/xjnpIxQnHSrT9YNSKGxtDWKfOKFl1Sr725YMnhxhbv05fFHwtwf4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DnH0j7QZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713820097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ekiFdY7KdKIVeACK1SW6wWvdTyknybnOlNtI4Ls9b00=;
	b=DnH0j7QZFI/s0bGkjGW4EJbe2UQlbVFi/OmCbwMbxZKbhyGawt2OQqKadu5rZTqYQddj1r
	QFXylZEXN54GCjYsaKI10Sv2cwJHHBVpK6OR/6GaZuwQbLFRNzunKUjDMqUM5yQtVD9/zu
	O+xYBUTiW3lW6cXvn+NeeLFq6ztbWP8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-InRofPuPNl-678tbE1XGpg-1; Mon, 22 Apr 2024 17:08:15 -0400
X-MC-Unique: InRofPuPNl-678tbE1XGpg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ecf5a85182so841649b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713820094; x=1714424894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekiFdY7KdKIVeACK1SW6wWvdTyknybnOlNtI4Ls9b00=;
        b=r9foayGar5V9OsA5Yj0U6mfs+sPNCN3j9IbvlmEMYtT55sOXpiX5LHWtds+bYwXyGU
         IaoJyXiyyc/XcmdNt3C2kSYRmP9p3VhdJt8GAvD1rZW+smidvR5f1rHSYTOhUB3MJabQ
         uHGoSh3o3zeyYc4n+FBANKIQLqDmNgsQApVbyZzSispw74GmoO5rF5CedVn/pDiROo/f
         Q5huhfEwFTZqMT+qoYikG3b/D/NBGvXCnAzF2ji6V1ZeJKmq+8Q6CMMPYOxLtfDk/a/Y
         yuBGKHIJADsA3vASeCoiUdxjQoMbtLSV3BUnk0ab7BtEBt0rzO+xSU2vVMh89Y5XnuUz
         GGIw==
X-Gm-Message-State: AOJu0YzOBFGi3nva9cYNAr3qqya/eirJtop40o0IlcMVQTiVo9HWFgA4
	ajx9Umptw9vsOPBzdSJFWijEYQ2dZbANurcWm1mQn/OvaYZMtlCFvI+0MpIYUn3Y0Obfmce4FWh
	fdikhjnEbcpf3rIIiBEAJQu6ORpWOjDisQoAXEJJ8sVr3RbPqu0CoPMMW4FljWw==
X-Received: by 2002:aa7:9f4d:0:b0:6ec:ee44:17bb with SMTP id h13-20020aa79f4d000000b006ecee4417bbmr12183570pfr.2.1713820093964;
        Mon, 22 Apr 2024 14:08:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+um4rmUwhSDUv3JUmF9L1QUqtLXHFWP93cOe73DJBTQrIZbZR7KhE8RPP+ljNoQaPsAsxnw==
X-Received: by 2002:aa7:9f4d:0:b0:6ec:ee44:17bb with SMTP id h13-20020aa79f4d000000b006ecee4417bbmr12183536pfr.2.1713820093131;
        Mon, 22 Apr 2024 14:08:13 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id fc4-20020a056a002e0400b006eb058b2703sm6655857pfb.187.2024.04.22.14.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 14:08:12 -0700 (PDT)
Date: Mon, 22 Apr 2024 17:08:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Nadav Amit <nadav.amit@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	syzbot+d8426b591c36b21c750e@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/userfaultfd: Reset ptes when close() for wr-protected
 ones
Message-ID: <ZibRuVdLPBu3JtH3@x1n>
References: <20240422133311.2987675-1-peterx@redhat.com>
 <20240422124719.5097e42a736403d306ba7cf0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240422124719.5097e42a736403d306ba7cf0@linux-foundation.org>

On Mon, Apr 22, 2024 at 12:47:19PM -0700, Andrew Morton wrote:
> On Mon, 22 Apr 2024 09:33:11 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > Userfaultfd unregister includes a step to remove wr-protect bits from all
> > the relevant pgtable entries, but that only covered an explicit
> > UFFDIO_UNREGISTER ioctl, not a close() on the userfaultfd itself.  Cover
> > that too.
> 
> We should include a description of the userspace-visible effects of the
> bug, please.  Always.

Ah, this one is a bit special so I didn't consider copying stable at all,
but I'll be more verbose next time..

The only user visible side effect is the user can observe leftover
wr-protect bits even if the user close()ed on an userfaultfd when releasing
the last reference of it.  However hopefully that should be harmless, and
nothing bad should happen even if so.

This change is now more important after the recent page-table-check patch
we merged in mm-unstable (446dd9ad37d0 ("mm/page_table_check: support
userfault wr-protect entries")), as we'll do sanity check on uffd-wp bits
without vma context.  So it's better if we can 100% guarantee no uffd-wp
bit leftovers, to make sure each report will be valid.

> 
> I see it triggers a WARN, but so what - why ca't we simply delete the
> WARN statement if that's the only effect?  Presumably there are other
> consequences - what are they?

Because that's newly added and we want to keep using those WARNINGs to trap
real bugs (and I'd expect new reports coming after this one.. we at least
have one real bug to fix somewhere..).

> 
> Also, a WARN-triggering bug should be fixed in -stable kernels so we'll
> need a FIXES:, please?

This only triggers due to the most recently added WARNING, so I assume it
shouldn't trigger in any old kernels, even Linus's tree shouldn't trigger
because the WARNING isn't there.

Though maybe it's indeed better to also pick this one up for stable, as it
does similar thing as what below commit does, however just to cover close()
too which was overlooked:

commit f369b07c861435bd812a9d14493f71b34132ed6f
Author: Peter Xu <peterx@redhat.com>
Date:   Thu Aug 11 16:13:40 2022 -0400

    mm/uffd: reset write protection when unregister with wp-mode

So I think that Fixes should be:

Fixes: f369b07c8614 ("mm/uffd: reset write protection when unregister with wp-mode")

Thanks,

-- 
Peter Xu


