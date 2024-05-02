Return-Path: <linux-kernel+bounces-166512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FAA8B9BB9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DADDF1F21E38
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB4513C662;
	Thu,  2 May 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nlv6ewbZ"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB1A937
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657120; cv=none; b=IejC3vCL4eh+ngq1THmhTFWQB4WbAEwDtS1deRvpH51JLzAjKzu0L6q0Y89cHULFoyvkpzol9/z4s+QJ0Jkt/L6u/gKlEV9LinjKeDIxHvKga07ezTbW1ndDpGRCKuAajGn/7Dt36iwp17yYHwAdDxP3OWivxth20o8noFkCIMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657120; c=relaxed/simple;
	bh=ZVLBKb/qfI6mje1+IuKXRZDIRVv/zAcr0IH3th4DjWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2axTHf3Fv2EgNjUq76P72ZOHrklTJ2N3f4mgTVWY2E0aAStMhWPiRj4KKysQSHSyRjsblKsFtW21TKPSo6nBa9iPekyKkKx4MzgeAmgkCQPnGs39MmeyvoCIwVFQpf7PPPiejSptgLnbSAvCpzKoW3U/y0CouRmG72rgwzV6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nlv6ewbZ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2db7c6b5598so103266381fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714657117; x=1715261917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y19TweyZ1KjMmIo4xW3n0XYd8Twm3R3dqBl/XKJ2/GA=;
        b=nlv6ewbZHBekushdOOyhFDEJEc9le+2MGpWHGjbESTQU2IeikuYvOQ580MuU3seGrG
         lwlpF5yUeWL7NpK425O+qQsVkEW/cINZ+U8xaAhe5B0Zf1ehtHvc9L9YryZ+SceylwSH
         nsvuKSwx/36R1xzj3GUcBxzEr2eirNgRbeLr0L67Ed43lilb9PRSLU53Tkdk0GcEM/dy
         39LzfskehykVkpWpa1CsUpuTFyPdRWBCbg3j7H77xfsPFAlcXgxr7lN45G5JxPpxrNM8
         9svdIm0AJS9V3ZtfoJ4ncdD7LlkpLLdsCaeqdHFPrM+sElWapr2/J1c+UweJofdHDqGa
         Y6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714657117; x=1715261917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y19TweyZ1KjMmIo4xW3n0XYd8Twm3R3dqBl/XKJ2/GA=;
        b=S+ZtRCE+6HrLZ6lMJSuwex8SPMxs5C5se0FJHEouh+7qD9k4dUQ1kMjxn2EpYWQhEc
         PubHOxgSNOcM2x/5n5iqPy6bFs4goDmPa8OPKMhtqFIjnwnJ1Z9/DXi6px/JNlNsXyp7
         EPk7gj/1bT3+se8/B9a0Ea12vW2Su8J9zJpgXn/8M0uR3GghZm3x08XWzKVwIlxldPPn
         ujZxL/HIfhP2WlsTst8MdIDZwGFKj+iLD8oHxK0JVbShia9lun7lJc/wWCbyJyKYxgu8
         6xSFmsXMzn7vhbp0JD6woQ3F0B/4GYNShlPGKem9/l63rnwURTmldMwUwuQ+dTiYvyla
         ecBA==
X-Forwarded-Encrypted: i=1; AJvYcCXiGTVJQGlxFDfNXYC/W1q2d4d6CW+3ceYra9UiRZrDecYutDc+qZLptGO0i3iJDXVP7IESG5SDKMdRkuBa69eMlfYJQ35xuH18c8wW
X-Gm-Message-State: AOJu0YzK9DV9B2/CuokY5U8UCViylHPd67kHMAHe+UEP/MebgxjQ5T/W
	b/IvxEt9EDXod48KUUqd0GGNY40aKl66fGGNKBJuEc1/GOcuhFPmSiyjtPcAcA==
X-Google-Smtp-Source: AGHT+IG2RlbVsy/QxzmOQcZwMGxzJIvMVzR+A/xkThaRhY+BkG8J7xN8nSCssUzWHbF/M78GCwlHmQ==
X-Received: by 2002:a05:6512:3c83:b0:51c:17d5:b56e with SMTP id h3-20020a0565123c8300b0051c17d5b56emr3948387lfv.11.1714657116382;
        Thu, 02 May 2024 06:38:36 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id m3-20020adffa03000000b0034db974d7a1sm1287085wrr.81.2024.05.02.06.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 06:38:36 -0700 (PDT)
Date: Thu, 2 May 2024 14:38:32 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, rdunlap@infradead.org, rppt@kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v22 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZjOXWLfR7GpzE8H_@google.com>
References: <20240430111354.637356-1-vdonnefort@google.com>
 <20240430111354.637356-3-vdonnefort@google.com>
 <78e20e98-bdfc-4d7b-a59c-988b81fcc58b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e20e98-bdfc-4d7b-a59c-988b81fcc58b@redhat.com>

On Thu, May 02, 2024 at 03:30:32PM +0200, David Hildenbrand wrote:
> On 30.04.24 13:13, Vincent Donnefort wrote:
> > In preparation for allowing the user-space to map a ring-buffer, add
> > a set of mapping functions:
> > 
> >    ring_buffer_{map,unmap}()
> > 
> > And controls on the ring-buffer:
> > 
> >    ring_buffer_map_get_reader()  /* swap reader and head */
> > 
> > Mapping the ring-buffer also involves:
> > 
> >    A unique ID for each subbuf of the ring-buffer, currently they are
> >    only identified through their in-kernel VA.
> > 
> >    A meta-page, where are stored ring-buffer statistics and a
> >    description for the current reader
> > 
> > The linear mapping exposes the meta-page, and each subbuf of the
> > ring-buffer, ordered following their unique ID, assigned during the
> > first mapping.
> > 
> > Once mapped, no subbuf can get in or out of the ring-buffer: the buffer
> > size will remain unmodified and the splice enabling functions will in
> > reality simply memcpy the data instead of swapping subbufs.
> > 
> > CC: <linux-mm@kvack.org>
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> > index dc5ae4e96aee..96d2140b471e 100644
> > --- a/include/linux/ring_buffer.h
> > +++ b/include/linux/ring_buffer.h
> 
> [...]
> 
> > +/*
> > + *   +--------------+  pgoff == 0
> > + *   |   meta page  |
> > + *   +--------------+  pgoff == 1
> > + *   | subbuffer 0  |
> > + *   |              |
> > + *   +--------------+  pgoff == (1 + (1 << subbuf_order))
> > + *   | subbuffer 1  |
> > + *   |              |
> > + *         ...
> > + */
> > +#ifdef CONFIG_MMU
> > +static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
> > +			struct vm_area_struct *vma)
> > +{
> > +	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
> > +	unsigned int subbuf_pages, subbuf_order;
> > +	struct page **pages;
> > +	int p = 0, s = 0;
> > +	int err;
> > +
> > +	/* Refuse MP_PRIVATE or writable mappings */
> > +	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
> > +	    !(vma->vm_flags & VM_MAYSHARE))
> > +		return -EPERM;
> > +
> > +	/*
> > +	 * Make sure the mapping cannot become writable later. Also tell the VM
> > +	 * to not touch these pages (VM_DONTCOPY | VM_DONTEXPAND). Finally,
> > +	 * prevent migration, GUP and dump (VM_IO).
> > +	 */
> > +	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_IO, VM_MAYWRITE);
> > +
> > +	lockdep_assert_held(&cpu_buffer->mapping_lock);
> > +
> > +	subbuf_order = cpu_buffer->buffer->subbuf_order;
> > +	subbuf_pages = 1 << subbuf_order;
> > +
> > +	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
> > +	nr_pages = ((nr_subbufs) << subbuf_order) - pgoff + 1; /* + meta-page */
> > +
> > +	vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
> > +	if (!vma_pages || vma_pages > nr_pages)
> > +		return -EINVAL;
> > +
> > +	nr_pages = vma_pages;
> > +
> > +	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> > +	if (!pages)
> > +		return -ENOMEM;
> > +
> > +	if (!pgoff) {
> > +		pages[p++] = virt_to_page(cpu_buffer->meta_page);
> > +
> > +		/*
> > +		 * TODO: Align sub-buffers on their size, once
> > +		 * vm_insert_pages() supports the zero-page.
> > +		 */
> > +	} else {
> > +		/* Skip the meta-page */
> > +		pgoff--;
> > +
> > +		if (pgoff % subbuf_pages) {
> > +			err = -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		s += pgoff / subbuf_pages;
> > +	}
> > +
> > +	while (s < nr_subbufs && p < nr_pages) {
> > +		struct page *page = virt_to_page(cpu_buffer->subbuf_ids[s]);
> > +		int off = 0;
> > +
> > +		for (; off < (1 << (subbuf_order)); off++, page++) {
> > +			if (p >= nr_pages)
> > +				break;
> > +
> > +			pages[p++] = page;
> > +		}
> > +		s++;
> > +	}
> > +
> > +	err = vm_insert_pages(vma, vma->vm_start, pages, &nr_pages);
> 
> Nit: I did not immediately understand if we could end here with p < nr_pages
> (IOW, pages[] not completely filled).
> 
> One source of confusion is the "s < nr_subbufs" check in the while loop: why
> is "p < nr_pages" insufficient?

Hum, indeed, the "s < nr_subbufs" check is superfluous, nr_pages, is already
capped by the number of subbufs, there's no way we can overflow subbuf_ids[].

> 
> 
> For the MM bits:
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks a lot for having a look at the series, very much appreciated!

> 
> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

