Return-Path: <linux-kernel+bounces-49198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4BA846715
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1690928D875
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8292FF9D7;
	Fri,  2 Feb 2024 04:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqoFdJi6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6AFF4F6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 04:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706849329; cv=none; b=EsBj6XNg99NvOa1O1hQC3CvNQ811BuWv/xTkpFZNKZJQ+sxCeL+q1L4xhkPn4JmxvTUtAW0+viTn3Xqyz/C2eqD9DyE6n0Fg0moeheKbfcL3ca8g47KHI5Qj6YQR/HdvvJJixJ3GqYLgweSyjmmUMBChBwj9mZLbTxmCrYG2hFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706849329; c=relaxed/simple;
	bh=MRhJrLFFGtALFkTfyB+TSCQ4/kJfsL3idSkvr2wXUuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbaUIJbi8sp+fNbZgGY9Gq+1/JY6HgNgQwTji80SzVne4AZpIjaXOnocnJbuuU0VYv7iSHzn33OHJJ8sVO7Ou30+Po0lmxyTb8nV++/9gAO1LeHopg8L5Q55szZLy3LUI6rOMIrk6caPJx9Ga2QUF58g4UX674J0dRgpqWK4Wk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqoFdJi6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706849326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GBcHybaOTExgtSnIw6pfOqSTYi0/PYs/65WdqotfksI=;
	b=KqoFdJi6fREQLBKjydvX8+6sCfJHTdqXyayeclxWuE0cxBeyQRl9qi0tS7brMayDgTqDmJ
	JFzWb6kiQB+V+QDs1BwigeOMLaFjcFEO9LYKg0yAf0bZoVXb/Yeg+ssq9ZC2tQ7CFl0HxR
	0u1k+82hq43Dhcp4wA9grRgBVZI/mnw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-Ua2OcVI-PcSJtTR88LE0oA-1; Thu,
 01 Feb 2024 23:48:42 -0500
X-MC-Unique: Ua2OcVI-PcSJtTR88LE0oA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EB0B38117FB;
	Fri,  2 Feb 2024 04:48:42 +0000 (UTC)
Received: from fedora (unknown [10.72.116.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 41BD21121306;
	Fri,  2 Feb 2024 04:48:35 +0000 (UTC)
Date: Fri, 2 Feb 2024 12:48:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Don Dutile <ddutile@redhat.com>, Rafael Aquini <raquini@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Mike Snitzer <snitzer@kernel.org>, ming.lei@redhat.com
Subject: Re: [PATCH] mm/madvise: set ra_pages as device max request size
 during ADV_POPULATE_READ
Message-ID: <Zbx0HDYfdneFRs9/@fedora>
References: <20240202022029.1903629-1-ming.lei@redhat.com>
 <Zbxsawh-wlkQ5-8C@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbxsawh-wlkQ5-8C@casper.infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Fri, Feb 02, 2024 at 04:15:39AM +0000, Matthew Wilcox wrote:
> On Fri, Feb 02, 2024 at 10:20:29AM +0800, Ming Lei wrote:
> > +static struct file *madvise_override_ra_win(struct file *f,
> > +		unsigned long start, unsigned long end,
> > +		unsigned int *old_ra_pages)
> > +{
> > +	unsigned int io_pages;
> > +
> > +	if (!f || !f->f_mapping || !f->f_mapping->host)
> > +		return NULL;
> 
> How can ->f_mapping be NULL?  How can f_mapping->host be NULL?

You are right, the two checks can be removed because both two won't
be NULL for opened file, and .f_ra is initialized with
f->f_mapping->host->i_mapping directly too. I will drop the checks
in next version.

BTW, looks the same check in madvise_remove() can removed too.

Thanks,
Ming


