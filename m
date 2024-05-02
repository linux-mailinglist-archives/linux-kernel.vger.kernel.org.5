Return-Path: <linux-kernel+bounces-166522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC178B9BCF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56091F22E05
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8D913C67D;
	Thu,  2 May 2024 13:45:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A5E12DDBF;
	Thu,  2 May 2024 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657527; cv=none; b=sqYzeVSoyeS685C8aRJ/yravFiKGq/hewj2Fw9g1lGzOV0Arc3kr9CFrbs8ZVXK/KUBbqqv/vBo6MHraz1/XWX5/ExYCbpk9vtBWQGJkDRNdhCMTEtApbv7mwFqOVZz21K7H3ZkpFfRpmLFVoipAN9lWIOdJPjW1j6Vd3sbPimw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657527; c=relaxed/simple;
	bh=0crVSpQ2cRq8IdCQmQ+23c21kGzUGsODa4EJXn+Y3sM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0KsdJbjg9i8lCfK58Y6IdBc4HZ1OV8bVIq0m9eF+db1+stfqAxDUJzJqaiqXWkE2zPlGKvMArhlGN5iyeshUsNQPrABlX/0qwiYeRa+4JUW42JV+4d5Fw5/bCxX880kL46KOWNk4mNtuG83pBt/0l7FVeh9vMka5BV1dJLEDsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F32CC113CC;
	Thu,  2 May 2024 13:45:26 +0000 (UTC)
Date: Thu, 2 May 2024 09:46:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: David Hildenbrand <david@redhat.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 rdunlap@infradead.org, rppt@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v22 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240502094612.7f92a3e4@gandalf.local.home>
In-Reply-To: <ZjOXWLfR7GpzE8H_@google.com>
References: <20240430111354.637356-1-vdonnefort@google.com>
	<20240430111354.637356-3-vdonnefort@google.com>
	<78e20e98-bdfc-4d7b-a59c-988b81fcc58b@redhat.com>
	<ZjOXWLfR7GpzE8H_@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 May 2024 14:38:32 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > > +	while (s < nr_subbufs && p < nr_pages) {
> > > +		struct page *page = virt_to_page(cpu_buffer->subbuf_ids[s]);
> > > +		int off = 0;
> > > +
> > > +		for (; off < (1 << (subbuf_order)); off++, page++) {
> > > +			if (p >= nr_pages)
> > > +				break;
> > > +
> > > +			pages[p++] = page;
> > > +		}
> > > +		s++;
> > > +	}
> > > +
> > > +	err = vm_insert_pages(vma, vma->vm_start, pages, &nr_pages);  
> > 
> > Nit: I did not immediately understand if we could end here with p < nr_pages
> > (IOW, pages[] not completely filled).
> > 
> > One source of confusion is the "s < nr_subbufs" check in the while loop: why
> > is "p < nr_pages" insufficient?  
> 
> Hum, indeed, the "s < nr_subbufs" check is superfluous, nr_pages, is already
> capped by the number of subbufs, there's no way we can overflow subbuf_ids[].

We can keep it as is, or perhaps change it to:

	while (p < nr_pages) {
		struct page *page;
		int off = 0;

		if (WARN_ON_ONCE(s >= nr_subbufs))
			break;

		page = virt_to_page(cpu_buffer->subbuf_ids[s]);
		for (; off < (1 << (subbuf_order)); off++, page++) {
			if (p >= nr_pages)
				break;

			pages[p++] = page;
		}
		s++;
	}

I don't like having an unchecked dependency between s and p.

-- Steve

