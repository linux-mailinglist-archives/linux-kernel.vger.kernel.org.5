Return-Path: <linux-kernel+bounces-155460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8068E8AEADD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BCE28ABF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6EF13B7A3;
	Tue, 23 Apr 2024 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaKjbPLp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5239F13BAF1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885538; cv=none; b=g5Uk7R5y4c1i1fUDcUnDNFZZ4Jw9DwFv46I8OYJhvcIEfDJC6kOZDGTYP0pddJ/RNNSPS7XFnPr+7wmB3w9FembMqZZAORpZoWk4H8eQYuYJpY03Ng6H0isDKEus0SQemo7NcgMsBcqXXrVlrGbPJElKujJhutbq6WPk9Lg5o68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885538; c=relaxed/simple;
	bh=oVaDmsDL6pbOGstGGNwIRlt3eAt8QlSYJGDN+v5bRKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jafI6T+c0ULNROU05W2l+bH4x+F8uXbsSc2ex6j5J1U7E+2pkY80OFnEzU/pzVYOslE33P4+q910whR9/WBzvViWbK/6q9u58GNzbKZ9Y+899Qk8xBYYI92vlVg52YUsy6k1H3xCN//pKQednMgAdfe7/bh57I0A3biqI82H6k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XaKjbPLp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713885535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1//G2apB5e6xOK0fMlwdOHS94yS2AW5Xhdqiqal+aJQ=;
	b=XaKjbPLpKyzXj8d0Pv2bh8iMdA8f8nfTizTSo4jAraNcq4peTHPNzmKOMHUNI2LzV9Z5lD
	EXTv72YhK9rWY0mLraRLJeHb6EoSEIRyx1vhmIEhGNqSA7U5ZwcQ0Ewwycf5zezgzhrtED
	GRWuti5DfhUq03jVshd1srwjdIZYKZ0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-z6PJzHYBOZ28K7mQ4qJibw-1; Tue, 23 Apr 2024 11:18:53 -0400
X-MC-Unique: z6PJzHYBOZ28K7mQ4qJibw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343d6732721so3606275f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713885532; x=1714490332;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1//G2apB5e6xOK0fMlwdOHS94yS2AW5Xhdqiqal+aJQ=;
        b=GX/sbhiCjNAtIqDPfKH2aK1+k8k0tzmXarLfWhdZzx/ad57+tK/XaPiYDp+8l2dEc1
         lWKY+cCgPQLKOobQchqG320GmHsFJYHnbv+nCb2hM8XDHYm+zYuBJ9kwZu+DuXl3Lvzd
         CRgKt6gdJIw8Nofks0FZ8rPSIFf48RWgVJa0aHksvOXUqIXl6T9RSVRk4qHH4y7OQGbx
         fYk0IZaFFb8pxHcypl6KMdUoYX9K6nrVMeX2Dm0l10q3qc3rOkrRZFgFbXN5CsyUD29b
         VXzbYvwgehw32zY+Yn9+M2s6kcXg8eY4uMjP4RYr/9E3vuwXdKm+JHGyA+vDD38k+98V
         GVIw==
X-Forwarded-Encrypted: i=1; AJvYcCUHW82/Iq3OeO66i+ttqbA4KSXRyAxHtdXTKGPZxRseJCNEi/9KR06iENGVQjSLw6E8ZO52O+xtpolZnBSCGhQRpQ8Wt5yhQF0Ghki2
X-Gm-Message-State: AOJu0YzzrpKm6xEhFl+OAod+gy+GkH7yz4cSpjVwUfbNVnz03Ye+f608
	Y3+lXHGPypdF8du/7ybpV2/Q+Suavo/9EVx0Jx4hqHztWXxX3xDgb5NFlGL+WniaTPHP6w0OqIy
	p9BHchmCF1oOB2nPL/Pylr+btx6NdhlG5DwetKCMifxYD6A+/pX8Mlj11VOvo2A==
X-Received: by 2002:a5d:4e08:0:b0:343:b942:3430 with SMTP id p8-20020a5d4e08000000b00343b9423430mr11034977wrt.17.1713885532187;
        Tue, 23 Apr 2024 08:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0oJ67oCLXe6CJ4NK827JaF/R/fYzxs/6dNXtzUR9Ro/CqZVvcLFOi2ryPuJwyuy0jA15m7g==
X-Received: by 2002:a5d:4e08:0:b0:343:b942:3430 with SMTP id p8-20020a5d4e08000000b00343b9423430mr11034943wrt.17.1713885531593;
        Tue, 23 Apr 2024 08:18:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fd00:fb07:92f8:8f0c:6a08? (p200300cbc706fd00fb0792f88f0c6a08.dip0.t-ipconnect.de. [2003:cb:c706:fd00:fb07:92f8:8f0c:6a08])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d5542000000b0034720354152sm14797500wrw.117.2024.04.23.08.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:18:51 -0700 (PDT)
Message-ID: <ba9df085-a3ff-42ab-bc9b-567b2d7cb983@redhat.com>
Date: Tue, 23 Apr 2024 17:18:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, rdunlap@infradead.org, linux-mm@kvack.org
References: <20240406173649.3210836-1-vdonnefort@google.com>
 <20240406173649.3210836-3-vdonnefort@google.com>
 <9c553dae-5395-4ec9-b41c-a4decc37acf2@redhat.com>
 <06c6b023-6cdc-430d-be0b-086fd6453aeb@redhat.com>
 <ZiaqgNFLOwimE2Me@google.com>
 <0283adf3-0295-4b2d-997e-befb02b1cc1a@redhat.com>
 <ZibJLSdOlxZUGRBa@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZibJLSdOlxZUGRBa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.04.24 22:31, Vincent Donnefort wrote:
> On Mon, Apr 22, 2024 at 08:27:17PM +0200, David Hildenbrand wrote:
>> On 22.04.24 20:20, Vincent Donnefort wrote:
>>> Hi David,
>>>
>>> Thanks for having a look, very much appreciated!
>>>
>>> On Mon, Apr 22, 2024 at 11:27:11AM +0200, David Hildenbrand wrote:
>>>> On 19.04.24 20:25, David Hildenbrand wrote:
>>>>> On 06.04.24 19:36, Vincent Donnefort wrote:
>>>>>> In preparation for allowing the user-space to map a ring-buffer, add
>>>>>> a set of mapping functions:
>>>>>>
>>>>>>       ring_buffer_{map,unmap}()
>>>>>>
>>>>>> And controls on the ring-buffer:
>>>>>>
>>>>>>       ring_buffer_map_get_reader()  /* swap reader and head */
>>>>>>
>>>>>> Mapping the ring-buffer also involves:
>>>>>>
>>>>>>       A unique ID for each subbuf of the ring-buffer, currently they are
>>>>>>       only identified through their in-kernel VA.
>>>>>>
>>>>>>       A meta-page, where are stored ring-buffer statistics and a
>>>>>>       description for the current reader
>>>>>>
>>>>>> The linear mapping exposes the meta-page, and each subbuf of the
>>>>>> ring-buffer, ordered following their unique ID, assigned during the
>>>>>> first mapping.
>>>>>>
>>>>>> Once mapped, no subbuf can get in or out of the ring-buffer: the buffer
>>>>>> size will remain unmodified and the splice enabling functions will in
>>>>>> reality simply memcpy the data instead of swapping subbufs.
>>>>>>
>>>>>> CC: <linux-mm@kvack.org>
>>>>>> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
>>>>>>
>>>>>> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
>>>>>> index dc5ae4e96aee..96d2140b471e 100644
>>>>>> --- a/include/linux/ring_buffer.h
>>>>>> +++ b/include/linux/ring_buffer.h
>>>>>> @@ -6,6 +6,8 @@
>>>>>>      #include <linux/seq_file.h>
>>>>>>      #include <linux/poll.h>
>>>>>> +#include <uapi/linux/trace_mmap.h>
>>>>>> +
>>>>>>      struct trace_buffer;
>>>>>>      struct ring_buffer_iter;
>>>>>> @@ -223,4 +225,8 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
>>>>>>      #define trace_rb_cpu_prepare	NULL
>>>>>>      #endif
>>>>>> +int ring_buffer_map(struct trace_buffer *buffer, int cpu,
>>>>>> +		    struct vm_area_struct *vma);
>>>>>> +int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
>>>>>> +int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
>>>>>>      #endif /* _LINUX_RING_BUFFER_H */
>>>>>> diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..ffcd8dfcaa4f
>>>>>> --- /dev/null
>>>>>> +++ b/include/uapi/linux/trace_mmap.h
>>>>>> @@ -0,0 +1,46 @@
>>>>>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>>>>> +#ifndef _TRACE_MMAP_H_
>>>>>> +#define _TRACE_MMAP_H_
>>>>>> +
>>>>>> +#include <linux/types.h>
>>>>>> +
>>>>>> +/**
>>>>>> + * struct trace_buffer_meta - Ring-buffer Meta-page description
>>>>>> + * @meta_page_size:	Size of this meta-page.
>>>>>> + * @meta_struct_len:	Size of this structure.
>>>>>> + * @subbuf_size:	Size of each sub-buffer.
>>>>>> + * @nr_subbufs:		Number of subbfs in the ring-buffer, including the reader.
>>>>>> + * @reader.lost_events:	Number of events lost at the time of the reader swap.
>>>>>> + * @reader.id:		subbuf ID of the current reader. ID range [0 : @nr_subbufs - 1]
>>>>>> + * @reader.read:	Number of bytes read on the reader subbuf.
>>>>>> + * @flags:		Placeholder for now, 0 until new features are supported.
>>>>>> + * @entries:		Number of entries in the ring-buffer.
>>>>>> + * @overrun:		Number of entries lost in the ring-buffer.
>>>>>> + * @read:		Number of entries that have been read.
>>>>>> + * @Reserved1:		Reserved for future use.
>>>>>> + * @Reserved2:		Reserved for future use.
>>>>>> + */
>>>>>> +struct trace_buffer_meta {
>>>>>> +	__u32		meta_page_size;
>>>>>> +	__u32		meta_struct_len;
>>>>>> +
>>>>>> +	__u32		subbuf_size;
>>>>>> +	__u32		nr_subbufs;
>>>>>> +
>>>>>> +	struct {
>>>>>> +		__u64	lost_events;
>>>>>> +		__u32	id;
>>>>>> +		__u32	read;
>>>>>> +	} reader;
>>>>>> +
>>>>>> +	__u64	flags;
>>>>>> +
>>>>>> +	__u64	entries;
>>>>>> +	__u64	overrun;
>>>>>> +	__u64	read;
>>>>>> +
>>>>>> +	__u64	Reserved1;
>>>>>> +	__u64	Reserved2;
>>>>>> +};
>>>>>> +
>>>>>> +#endif /* _TRACE_MMAP_H_ */
>>>>>> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
>>>>>> index cc9ebe593571..793ecc454039 100644
>>>>>> --- a/kernel/trace/ring_buffer.c
>>>>>> +++ b/kernel/trace/ring_buffer.c
>>>>>> @@ -9,6 +9,7 @@
>>>>>>      #include <linux/ring_buffer.h>
>>>>>>      #include <linux/trace_clock.h>
>>>>>>      #include <linux/sched/clock.h>
>>>>>> +#include <linux/cacheflush.h>
>>>>>>      #include <linux/trace_seq.h>
>>>>>>      #include <linux/spinlock.h>
>>>>>>      #include <linux/irq_work.h>
>>>>>> @@ -26,6 +27,7 @@
>>>>>>      #include <linux/list.h>
>>>>>>      #include <linux/cpu.h>
>>>>>>      #include <linux/oom.h>
>>>>>> +#include <linux/mm.h>
>>>>>>      #include <asm/local64.h>
>>>>>>      #include <asm/local.h>
>>>>>> @@ -338,6 +340,7 @@ struct buffer_page {
>>>>>>      	local_t		 entries;	/* entries on this page */
>>>>>>      	unsigned long	 real_end;	/* real end of data */
>>>>>>      	unsigned	 order;		/* order of the page */
>>>>>> +	u32		 id;		/* ID for external mapping */
>>>>>>      	struct buffer_data_page *page;	/* Actual data page */
>>>>>>      };
>>>>>> @@ -484,6 +487,12 @@ struct ring_buffer_per_cpu {
>>>>>>      	u64				read_stamp;
>>>>>>      	/* pages removed since last reset */
>>>>>>      	unsigned long			pages_removed;
>>>>>> +
>>>>>> +	unsigned int			mapped;
>>>>>> +	struct mutex			mapping_lock;
>>>>>> +	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
>>>>>> +	struct trace_buffer_meta	*meta_page;
>>>>>> +
>>>>>>      	/* ring buffer pages to update, > 0 to add, < 0 to remove */
>>>>>>      	long				nr_pages_to_update;
>>>>>>      	struct list_head		new_pages; /* new pages to add */
>>>>>> @@ -1599,6 +1608,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
>>>>>>      	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
>>>>>>      	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
>>>>>>      	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
>>>>>> +	mutex_init(&cpu_buffer->mapping_lock);
>>>>>>      	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
>>>>>>      			    GFP_KERNEL, cpu_to_node(cpu));
>>>>>> @@ -1789,8 +1799,6 @@ bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer)
>>>>>>      	return buffer->time_stamp_abs;
>>>>>>      }
>>>>>> -static void rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer);
>>>>>> -
>>>>>>      static inline unsigned long rb_page_entries(struct buffer_page *bpage)
>>>>>>      {
>>>>>>      	return local_read(&bpage->entries) & RB_WRITE_MASK;
>>>>>> @@ -5211,6 +5219,22 @@ static void rb_clear_buffer_page(struct buffer_page *page)
>>>>>>      	page->read = 0;
>>>>>>      }
>>>>>> +static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
>>>>>> +{
>>>>>> +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
>>>>>> +
>>>>>> +	meta->reader.read = cpu_buffer->reader_page->read;
>>>>>> +	meta->reader.id = cpu_buffer->reader_page->id;
>>>>>> +	meta->reader.lost_events = cpu_buffer->lost_events;
>>>>>> +
>>>>>> +	meta->entries = local_read(&cpu_buffer->entries);
>>>>>> +	meta->overrun = local_read(&cpu_buffer->overrun);
>>>>>> +	meta->read = cpu_buffer->read;
>>>>>> +
>>>>>> +	/* Some archs do not have data cache coherency between kernel and user-space */
>>>>>> +	flush_dcache_folio(virt_to_folio(cpu_buffer->meta_page));
>>>>>> +}
>>>>>> +
>>>>>>      static void
>>>>>>      rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
>>>>>>      {
>>>>>> @@ -5255,6 +5279,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
>>>>>>      	cpu_buffer->lost_events = 0;
>>>>>>      	cpu_buffer->last_overrun = 0;
>>>>>> +	if (cpu_buffer->mapped)
>>>>>> +		rb_update_meta_page(cpu_buffer);
>>>>>> +
>>>>>>      	rb_head_page_activate(cpu_buffer);
>>>>>>      	cpu_buffer->pages_removed = 0;
>>>>>>      }
>>>>>> @@ -5469,6 +5496,12 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
>>>>>>      	cpu_buffer_a = buffer_a->buffers[cpu];
>>>>>>      	cpu_buffer_b = buffer_b->buffers[cpu];
>>>>>> +	/* It's up to the callers to not try to swap mapped buffers */
>>>>>> +	if (WARN_ON_ONCE(cpu_buffer_a->mapped || cpu_buffer_b->mapped)) {
>>>>>> +		ret = -EBUSY;
>>>>>> +		goto out;
>>>>>> +	}
>>>>>> +
>>>>>>      	/* At least make sure the two buffers are somewhat the same */
>>>>>>      	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
>>>>>>      		goto out;
>>>>>> @@ -5733,7 +5766,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>>>>>>      	 * Otherwise, we can simply swap the page with the one passed in.
>>>>>>      	 */
>>>>>>      	if (read || (len < (commit - read)) ||
>>>>>> -	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
>>>>>> +	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
>>>>>> +	    cpu_buffer->mapped) {
>>>>>>      		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
>>>>>>      		unsigned int rpos = read;
>>>>>>      		unsigned int pos = 0;
>>>>>> @@ -5956,6 +5990,11 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>>>>>>      		cpu_buffer = buffer->buffers[cpu];
>>>>>> +		if (cpu_buffer->mapped) {
>>>>>> +			err = -EBUSY;
>>>>>> +			goto error;
>>>>>> +		}
>>>>>> +
>>>>>>      		/* Update the number of pages to match the new size */
>>>>>>      		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
>>>>>>      		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
>>>>>> @@ -6057,6 +6096,358 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>>>>>>      }
>>>>>>      EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
>>>>>> +static int rb_alloc_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
>>>>>> +{
>>>>>> +	struct page *page;
>>>>>> +
>>>>>> +	if (cpu_buffer->meta_page)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	page = alloc_page(GFP_USER | __GFP_ZERO);
>>>>>> +	if (!page)
>>>>>> +		return -ENOMEM;
>>>>>> +
>>>>>> +	cpu_buffer->meta_page = page_to_virt(page);
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
>>>>>> +{
>>>>>> +	unsigned long addr = (unsigned long)cpu_buffer->meta_page;
>>>>>> +
>>>>>> +	free_page(addr);
>>>>>> +	cpu_buffer->meta_page = NULL;
>>>>>> +}
>>>>>> +
>>>>>> +static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
>>>>>> +				   unsigned long *subbuf_ids)
>>>>>> +{
>>>>>> +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
>>>>>> +	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
>>>>>> +	struct buffer_page *first_subbuf, *subbuf;
>>>>>> +	int id = 0;
>>>>>> +
>>>>>> +	subbuf_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
>>>>>> +	cpu_buffer->reader_page->id = id++;
>>>>>> +
>>>>>> +	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
>>>>>> +	do {
>>>>>> +		if (WARN_ON(id >= nr_subbufs))
>>>>>> +			break;
>>>>>> +
>>>>>> +		subbuf_ids[id] = (unsigned long)subbuf->page;
>>>>>> +		subbuf->id = id;
>>>>>> +
>>>>>> +		rb_inc_page(&subbuf);
>>>>>> +		id++;
>>>>>> +	} while (subbuf != first_subbuf);
>>>>>> +
>>>>>> +	/* install subbuf ID to kern VA translation */
>>>>>> +	cpu_buffer->subbuf_ids = subbuf_ids;
>>>>>> +
>>>>>> +	/* __rb_map_vma() pads the meta-page to align it with the sub-buffers */
>>>>>> +	meta->meta_page_size = PAGE_SIZE << cpu_buffer->buffer->subbuf_order;
>>>>>> +	meta->meta_struct_len = sizeof(*meta);
>>>>>> +	meta->nr_subbufs = nr_subbufs;
>>>>>> +	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
>>>>>> +
>>>>>> +	rb_update_meta_page(cpu_buffer);
>>>>>> +}
>>>>>> +
>>>>>> +static struct ring_buffer_per_cpu *
>>>>>> +rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
>>>>>> +{
>>>>>> +	struct ring_buffer_per_cpu *cpu_buffer;
>>>>>> +
>>>>>> +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
>>>>>> +		return ERR_PTR(-EINVAL);
>>>>>> +
>>>>>> +	cpu_buffer = buffer->buffers[cpu];
>>>>>> +
>>>>>> +	mutex_lock(&cpu_buffer->mapping_lock);
>>>>>> +
>>>>>> +	if (!cpu_buffer->mapped) {
>>>>>> +		mutex_unlock(&cpu_buffer->mapping_lock);
>>>>>> +		return ERR_PTR(-ENODEV);
>>>>>> +	}
>>>>>> +
>>>>>> +	return cpu_buffer;
>>>>>> +}
>>>>>> +
>>>>>> +static void rb_put_mapped_buffer(struct ring_buffer_per_cpu *cpu_buffer)
>>>>>> +{
>>>>>> +	mutex_unlock(&cpu_buffer->mapping_lock);
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * Fast-path for rb_buffer_(un)map(). Called whenever the meta-page doesn't need
>>>>>> + * to be set-up or torn-down.
>>>>>> + */
>>>>>> +static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
>>>>>> +			       bool inc)
>>>>>> +{
>>>>>> +	unsigned long flags;
>>>>>> +
>>>>>> +	lockdep_assert_held(&cpu_buffer->mapping_lock);
>>>>>> +
>>>>>> +	if (inc && cpu_buffer->mapped == UINT_MAX)
>>>>>> +		return -EBUSY;
>>>>>> +
>>>>>> +	if (WARN_ON(!inc && cpu_buffer->mapped == 0))
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>>> +	mutex_lock(&cpu_buffer->buffer->mutex);
>>>>>> +	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>>>>>> +
>>>>>> +	if (inc)
>>>>>> +		cpu_buffer->mapped++;
>>>>>> +	else
>>>>>> +		cpu_buffer->mapped--;
>>>>>> +
>>>>>> +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>>>>>> +	mutex_unlock(&cpu_buffer->buffer->mutex);
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>> +#define subbuf_page(off, start) \
>>>>>> +	virt_to_page((void *)((start) + ((off) << PAGE_SHIFT)))
>>>>>> +
>>>>>> +#define foreach_subbuf_page(sub_order, start, page)		\
>>>>>> +	page = subbuf_page(0, (start));				\
>>>>>> +	for (int __off = 0; __off < (1 << (sub_order));		\
>>>>>> +	     __off++, page = subbuf_page(__off, (start)))
>>>>>> +
>>>>>> +/*
>>>>>> + *   +--------------+  pgoff == 0
>>>>>> + *   |   meta page  |
>>>>>> + *   +--------------+  pgoff == 1
>>>>>> + *   |   000000000  |
>>>>>> + *   +--------------+  pgoff == (1 << subbuf_order)
>>>>>> + *   | subbuffer 0  |
>>>>>> + *   |              |
>>>>>> + *   +--------------+  pgoff == (2 * (1 << subbuf_order))
>>>>>> + *   | subbuffer 1  |
>>>>>> + *   |              |
>>>>>> + *         ...
>>>>>> + */
>>>>>> +static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
>>>>>> +			struct vm_area_struct *vma)
>>>>>> +{
>>>>>> +	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
>>>>>> +	unsigned int subbuf_pages, subbuf_order;
>>>>>> +	struct page **pages;
>>>>>> +	int p = 0, s = 0;
>>>>>> +	int err;
>>>>>> +
>>>>>> +	lockdep_assert_held(&cpu_buffer->mapping_lock);
>>>>>> +
>>>>>> +	subbuf_order = cpu_buffer->buffer->subbuf_order;
>>>>>> +	subbuf_pages = 1 << subbuf_order;
>>>>>> +
>>>>>> +	if (subbuf_order && pgoff % subbuf_pages)
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>>> +	nr_subbufs = cpu_buffer->nr_pages + 1;
>>>>>> +	nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff;
>>>>>> +
>>>>>> +	vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>>>>>> +	if (!vma_pages || vma_pages > nr_pages)
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>>> +	nr_pages = vma_pages;
>>>>>> +
>>>>>> +	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
>>>>>> +	if (!pages)
>>>>>> +		return -ENOMEM;
>>>>>> +
>>>>>> +	if (!pgoff) {
>>>>>> +		unsigned long meta_page_padding;
>>>>>> +
>>>>>> +		pages[p++] = virt_to_page(cpu_buffer->meta_page);
>>>>>> +
>>>>>> +		/*
>>>>>> +		 * Pad with the zero-page to align the meta-page with the
>>>>>> +		 * sub-buffers.
>>>>>> +		 */
>>>>>> +		meta_page_padding = subbuf_pages - 1;
>>>>>> +		while (meta_page_padding-- && p < nr_pages)
>>>>>> +			pages[p++] = ZERO_PAGE(0);
>>>>>
>>>>> Using the shared zeropage in a MAP_SHARED mapping that is neither VM_IO
>>>>> nor VM_PFNMAP can be problematic. So we really need patch #3 logic to
>>>>> use VM_PFNMAP.
>>>>>
>>>>> It would be cleaner/more obvious if these VMA flag setting would reside
>>>
>>> tracing_buffers_mmap() sets both VM_IO and VM_PFNMAP. But, yeah as vma is
>>> already passed to ring_buffer_map(). The flags could be set here as this
>>> function is what sets the requirements really.
>>>
>>>>> here, if possible.
>>>>>
>>>>>> +	} else {
>>>>>> +		/* Skip the meta-page */
>>>>>> +		pgoff -= subbuf_pages;
>>>>>> +
>>>>>> +		s += pgoff / subbuf_pages;
>>>>>> +	}
>>>>>> +
>>>>>> +	while (s < nr_subbufs && p < nr_pages) {
>>>>>> +		struct page *page;
>>>>>> +
>>>>>> +		foreach_subbuf_page(subbuf_order, cpu_buffer->subbuf_ids[s], page) {
>>>>>> +			if (p >= nr_pages)
>>>>>> +				break;
>>>>>> +
>>>>>> +			pages[p++] = page;
>>>>>> +		}
>>>>>> +		s++;
>>>>>> +	}
>>>>>> +
>>>>>> +	err = vm_insert_pages(vma, vma->vm_start, pages, &nr_pages);
>>>>>
>>>>> I think Linus suggested it ("avoid all the sub-page ref-counts entirely
>>>>> by using VM_PFNMAP, and use vm_insert_pages()"), but ...
>>>>> vm_insert_pages() will:
>>>>> * Mess with mapcounts
>>>>> * Mess with refcounts
>>>>>
>>>>> See
>>>>> insert_pages()->insert_page_in_batch_locked()->insert_page_into_pte_locked().
>>>>>
>>>>> So we'll mess with the mapcount and refcount of the shared zeropage ...
>>>>> hmmmm
>>>>>
>>>>> If I am not wrong, vm_normal_page() would not return the shared zeropage
>>>>> in case we don't have CONFIG_ARCH_HAS_PTE_SPECIAL ... so
>>>>> unmap()->...->zap_present_ptes() would not decrement the refcount and we
>>>>> could overflow it. ... we also shouldn't ever mess with the mapcount of
>>>>> the shared zeropage in the first place.
>>>>>
>>>>> vm_insert_page() is clearer on that: "This allows drivers to insert
>>>>> individual pages they've allocated into a user vma". You didn't allocate
>>>>> the shared zeropage.
>>>>>
>>>>> I'm wondering if we even expect VM_MIXEDMAP and VM_PFNMAP to be set at
>>>>> the same time? vm_insert_pages() would BUG_ON in case VM_PFNMAP is
>>>>> already set and it would set VM_MIXEDMAP ... similarly
>>>>> vmf_insert_pfn_prot() would not be happy about that at all ...
>>>>>
>>>>> BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
>>>>> (VM_PFNMAP|VM_MIXEDMAP));
>>>>>
>>>>> ... remap_pfn_range() is used by io_uring_mmap for a similar purpose.
>>>>> But it only supports a single PFN range at a time and requires the
>>>>> caller to handle refcounting of pages.
>>>>>
>>>>> It's getting late in Germany, so I might be missing something; but using
>>>>> the shared zeropage here might be a problem.
>>>>>
>>>>
>>>> I was just about to write code to cleanly support vm_insert_pages() to
>>>> consume zeropages ... when I started to wonder about something else:
>>>
>>> Alternatively, we could at the moment allocate a meta-page of the same size than
>>> the subbufs? (of course the downside is to waste a bit of memory)
>>
>> Supporting the shared zeropage should be possible. We just have to be
>> careful that no other code can accidentially set it writable. I'll have to
>> further think about that (not just your user, but making it sane to use by
>> new code as well).
>>
>> So far, we primarily only have shared zeropages in the MAP_PRIVATE mappings.
>> Dax is a corner case where we have them in MAP_SHARED mappings. PFNMAP would
>> not be problematic, but MIXEDMAP is. (again, I am not 100% sure about
>> combining both ...)
>>
>> I'll further think about that one, and try crafting a reasonable patch.
>>
>> Could we start with no shared zeropage and implement that as an optimization
>> on top?
> 
> Of course, I'm happy to update this series without the zero-page and to bring it
> back later, in a separate patch, as soon as vm_insert_pages() is compatible.
> 

Good, let's explore that path first!

-- 
Cheers,

David / dhildenb


