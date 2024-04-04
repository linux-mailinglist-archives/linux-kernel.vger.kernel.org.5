Return-Path: <linux-kernel+bounces-132100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC60898F96
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7539F28CDC1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A677712CD8F;
	Thu,  4 Apr 2024 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Or2rcp0I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39849210E4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262762; cv=none; b=hk47rN4s8zJEQaeG0awXzjIDZ/9BV3+Zf53OAGIsoSeeV9C0jKPVPtS8bEH2FLCDm349Fh9r002LgmnpkfL/wVwOmOzJrFV2s+6iQGeWumpxR8rTQU4jl9wWtIyLejPT2tHJRZ7TB8gPohwYq9VHdcwvvSBqY2FblDyl1DdA51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262762; c=relaxed/simple;
	bh=awfPHIXQopxdXq7haC0jymKLsZG6Aa0tbih+6GZa/0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTDm8FvRBJ11VzMcv7dQ3+dtxdpgBrTIllOeQ9svoBTOmMAqvRbzmINhI3fz82y6bpWd1UzXGkP4JMp4LWgyyleW/XOhv8wUWQ1aQRzt1aMlVVJ4MiL4RdVniZXzKvlDfdUnMSkd7K7Lw4Ns7udULZ1zzR1j6thyWv+N7m4t0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Or2rcp0I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712262759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vr/SUGhSbvPpqa+Xo0hTVf6gdcXmyeXEviRfCaUkX+4=;
	b=Or2rcp0IbCXEQwVQRkv/TpP8fuq8DFvn67WJ7QTdVHWIITX2ciE4I+UrMuhOlpWwPeN0d2
	0O0Tdejza3A+GuTS9+kAuKb7jPNnRJcmVNQtktAbKvLX0vTtDkyxWNGW43Le+tqOOthxXF
	GRia/ZrNnYgdu4bbOGxn5fo6kk6UqkI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-y659CN7nPPWbT62gcyt2IQ-1; Thu, 04 Apr 2024 16:32:37 -0400
X-MC-Unique: y659CN7nPPWbT62gcyt2IQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-69120b349c9so2585426d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712262757; x=1712867557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vr/SUGhSbvPpqa+Xo0hTVf6gdcXmyeXEviRfCaUkX+4=;
        b=QiUUW+b1W7AeoUjlHzL7H6NvpmV6KF0Ok3sJQRH/ZoRHTA1aq+bRL7lp14mkYNBKVN
         7BTGF09p7XWYcy3bXcJ767A/UDe7e9/4JN4P01yAVyrBcDr6eqXaBzudY3rOnNt4xZgk
         aPMwY01UMelP7lpy4ijsdzPZQ8ouNaqeyCLg+ml0rfWFFCVimCytaseVM0X+5IJ7ranp
         tBoepA0jjmWYJwh/ziCmgIuJHspHAUUFes3Y3F5OY3MtXYCSscsAWer2foyaF1ZdDFk7
         QDINyGKd2rR3zKgVtQI4ZfHs7t+abPp3eoisyV81mAIY5c1IWbE8V66b4Gu/aFOSUByJ
         cfnw==
X-Forwarded-Encrypted: i=1; AJvYcCULjDqYmizrDXK/DKo5Z493k63Yw9ijFvDU7nP03VB+ZO5jeV2v0tvRqdGPvYWt6YdSa43CnZZP7PFha7dUnBS3gA5V4+tVCTjBxs7j
X-Gm-Message-State: AOJu0YxXyJkX1k63KDNImSqwPHDiIttGuiJMD33aKQrMrRLufBkjIALj
	TBKcA6no+brDM54b5i2r+W9LfQbpbj/T2uCyJ6ZTX8W93gxua7/H1j7AFNiMywyWlrP/i/bEkEv
	KxqN0Zt7zwmMS5IcTIZmH0HceBt+78oa/ahTVgB6WEaVjczI+K5I/T48wJoLgFQ==
X-Received: by 2002:a05:6214:1c86:b0:699:2f11:384f with SMTP id ib6-20020a0562141c8600b006992f11384fmr3519017qvb.2.1712262756773;
        Thu, 04 Apr 2024 13:32:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/XWgQgMXrsC/9dKI75yPJSvQp60HieuCzEjNcjcNcBiPkBasPO28C4IidP6yoo2sMeHIWlg==
X-Received: by 2002:a05:6214:1c86:b0:699:2f11:384f with SMTP id ib6-20020a0562141c8600b006992f11384fmr3518978qvb.2.1712262756166;
        Thu, 04 Apr 2024 13:32:36 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id s13-20020ad4438d000000b0069908364644sm41556qvr.82.2024.04.04.13.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 13:32:35 -0700 (PDT)
Date: Thu, 4 Apr 2024 16:32:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	kernel-team@android.com, aarcange@redhat.com, david@redhat.com,
	zhengqi.arch@bytedance.com, kaleshsingh@google.com,
	ngeoffray@google.com
Subject: Re: [PATCH] userfaultfd: change src_folio after ensuring it's
 unpinned in UFFDIO_MOVE
Message-ID: <Zg8OYYV7DDo7S2Yf@x1n>
References: <20240404171726.2302435-1-lokeshgidra@google.com>
 <Zg7hrt5HudXLBUn_@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zg7hrt5HudXLBUn_@casper.infradead.org>

On Thu, Apr 04, 2024 at 06:21:50PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 04, 2024 at 10:17:26AM -0700, Lokesh Gidra wrote:
> > -		folio_move_anon_rmap(src_folio, dst_vma);
> > -		WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
> > -
> >  		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
> >  		/* Folio got pinned from under us. Put it back and fail the move. */
> >  		if (folio_maybe_dma_pinned(src_folio)) {
> > @@ -2270,6 +2267,9 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
> >  			goto unlock_ptls;
> >  		}
> >  
> > +		folio_move_anon_rmap(src_folio, dst_vma);
> > +		WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
> > +
> 
> This use of WRITE_ONCE scares me.  We hold the folio locked.  Why do
> we need to use WRITE_ONCE?  Who's looking at folio->index without
> holding the folio lock?

Seems true, but maybe suitable for a separate patch to clean it even so?
We also have the other pte level which has the same WRITE_ONCE(), so if we
want to drop we may want to drop both.

I just got to start reading some the new move codes (Lokesh, apologies on
not be able to provide feedbacks previously..), but then I found one thing
unclear, on special handling of private file mappings only in userfault
context, and I didn't know why:

lock_vma():
        if (vma) {
                /*
                 * lock_vma_under_rcu() only checks anon_vma for private
                 * anonymous mappings. But we need to ensure it is assigned in
                 * private file-backed vmas as well.
                 */
                if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma->anon_vma))
                        vma_end_read(vma);
                else
                        return vma;
        }

AFAIU even for generic users of lock_vma_under_rcu(), anon_vma must be
stable to be used.  Here it's weird to become an userfault specific
operation to me.

I was surprised how it worked for private file maps on faults, then I had a
check and it seems we postponed such check until vmf_anon_prepare(), which
is the CoW path already, so we do as I expected, but seems unnecessary to
that point?

Would something like below make it much cleaner for us?  As I just don't
yet see why userfault is special here.

Thanks,

===8<===
diff --git a/mm/memory.c b/mm/memory.c
index 984b138f85b4..d5cf1d31c671 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3213,10 +3213,8 @@ vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
 
 	if (likely(vma->anon_vma))
 		return 0;
-	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
-		vma_end_read(vma);
-		return VM_FAULT_RETRY;
-	}
+	/* We shouldn't try a per-vma fault at all if anon_vma isn't solid */
+	WARN_ON_ONCE(vmf->flags & FAULT_FLAG_VMA_LOCK);
 	if (__anon_vma_prepare(vma))
 		return VM_FAULT_OOM;
 	return 0;
@@ -5817,9 +5815,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	 * find_mergeable_anon_vma uses adjacent vmas which are not locked.
 	 * This check must happen after vma_start_read(); otherwise, a
 	 * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
-	 * from its anon_vma.
+	 * from its anon_vma.  This applies to both anon or private file maps.
 	 */
-	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
+	if (unlikely(!(vma->vm_flags & VM_SHARED) && !vma->anon_vma))
 		goto inval_end_read;
 
 	/* Check since vm_start/vm_end might change before we lock the VMA */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index f6267afe65d1..61f21da77dcd 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -72,17 +72,8 @@ static struct vm_area_struct *lock_vma(struct mm_struct *mm,
 	struct vm_area_struct *vma;
 
 	vma = lock_vma_under_rcu(mm, address);
-	if (vma) {
-		/*
-		 * lock_vma_under_rcu() only checks anon_vma for private
-		 * anonymous mappings. But we need to ensure it is assigned in
-		 * private file-backed vmas as well.
-		 */
-		if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma->anon_vma))
-			vma_end_read(vma);
-		else
-			return vma;
-	}
+	if (vma)
+		return vma;
 
 	mmap_read_lock(mm);
 	vma = find_vma_and_prepare_anon(mm, address);
-- 
2.44.0


-- 
Peter Xu


