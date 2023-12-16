Return-Path: <linux-kernel+bounces-1956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4B0815654
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AB828691D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F35186D;
	Sat, 16 Dec 2023 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEA3rY3e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA7317E8
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702693322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YDbMrrJMxJaNaZxmdjaWs9yxNCXUr/R3B3gdWPDjk0k=;
	b=fEA3rY3eiznHEi3gyBPLVBBsONlahCgJXFbhIHYftpDYiueXoHqZX8QSPpUMyhRC//KQvc
	XSh+jgIAAsh+/kLjZYVjzE2DAEtIL5c3AWkaPtwn6EVr6Q9c2N0bUIFO/OIpQE+hVN4zHm
	TWmnbPJSOEnHaMIo+ogXM62yfe34ew8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-VuBV7y_tPXOverfdkz6vmw-1; Fri,
 15 Dec 2023 21:21:59 -0500
X-MC-Unique: VuBV7y_tPXOverfdkz6vmw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 427523C025BD;
	Sat, 16 Dec 2023 02:21:58 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E9F871C060B1;
	Sat, 16 Dec 2023 02:21:56 +0000 (UTC)
Date: Sat, 16 Dec 2023 10:21:53 +0800
From: Baoquan He <bhe@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yuntao Wang <ytcoode@gmail.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/3] kexec_file: fix incorrect end value passed to
 kimage_is_destination_range()
Message-ID: <ZX0JwbQ59XH5rqm9@MiWiFi-R3L-srv>
References: <20231215080910.173338-1-ytcoode@gmail.com>
 <20231215080910.173338-2-ytcoode@gmail.com>
 <87a5qb4avf.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5qb4avf.fsf@email.froward.int.ebiederm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 12/15/23 at 11:46am, Eric W. Biederman wrote:
> Yuntao Wang <ytcoode@gmail.com> writes:
> 
> > The end parameter received by kimage_is_destination_range() should be the
> > last valid byte address of the target memory segment plus 1. However, in
> > the locate_mem_hole_bottom_up() and locate_mem_hole_top_down() functions,
> > the corresponding value passed to kimage_is_destination_range() is the last
> > valid byte address of the target memory segment, which is 1 less. Fix
> > it.
> 
> If that is true we I think we should rather fix
> kimage_is_destination_range.

It's true wit the current implementation of
kimage_is_destination_range(). Its callers pass the start/end+1
pair. Agree we should fix kimage_is_destination_range() instead and
adjust callers, such as kimage_alloc_normal_control_pages(), and
kimage_alloc_page().


> 
> Otherwise we run the risk of having areas whose end is not
> representable, epecially on 32bit.
> 
> 
> Eric
> 
> 
> > Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> > ---
> >  kernel/kexec_file.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index f9a419cd22d4..26be070d3bdd 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -435,13 +435,12 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
> >  		if (temp_start < start || temp_start < kbuf->buf_min)
> >  			return 0;
> >  
> > -		temp_end = temp_start + kbuf->memsz - 1;
> > -
> >  		/*
> >  		 * Make sure this does not conflict with any of existing
> >  		 * segments
> >  		 */
> > -		if (kimage_is_destination_range(image, temp_start, temp_end)) {
> > +		if (kimage_is_destination_range(image, temp_start,
> > +						temp_start + kbuf->memsz)) {
> >  			temp_start = temp_start - PAGE_SIZE;
> >  			continue;
> >  		}
> > @@ -475,7 +474,7 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
> >  		 * Make sure this does not conflict with any of existing
> >  		 * segments
> >  		 */
> > -		if (kimage_is_destination_range(image, temp_start, temp_end)) {
> > +		if (kimage_is_destination_range(image, temp_start, temp_end + 1)) {
> >  			temp_start = temp_start + PAGE_SIZE;
> >  			continue;
> >  		}
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


