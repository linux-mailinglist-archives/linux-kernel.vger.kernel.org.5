Return-Path: <linux-kernel+bounces-52675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFFA849B4A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434A41F27E15
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B34A2C1A8;
	Mon,  5 Feb 2024 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PccInDGZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CC524A19
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137967; cv=none; b=VwxAso7C1kVF8U1udyXV+DfCrHcX1hM+kNYxgZyBttUOSs8GTlcAUrWkVpwCNXamNsZieHRDzNCU1XCGDwdZ5jSLspVCdPexyzhN4RxsUQ7jNXaK8xqGLaevRkrYs6HDD9GbLOJLUzilK4W5Dt6TPxXfEj3ofK9g6gKmWjStbZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137967; c=relaxed/simple;
	bh=T+MbceGRGsG5aivVnHbY4LaFkjfgsT6pW0lCS8qAO04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiEoD2IEOO1QyHWcOK7k2prqcoRRk35kvNjH1aJb3/NEgt+glBIw4aGSSy2LPV1KBYKtFuVQXu0CritAMXkmJbFk751FT640kKUYl8+5FMLhhnA3e5EswLljVsWekaKBqrT6DKo0PJtIyxQJ8/5/zw/pRf5INS9TjnYezm3QRU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PccInDGZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707137964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FpGOJ29CMHAA5hRGumj5ser9f9DDAnohQf19mV7TPfc=;
	b=PccInDGZmY3dp4rEjan5lhVDkwtEFZpf1OxCSMIvMwMpOVBRZwPDQ0HG4t+Uzftt00gANi
	7Ft0VjzXUHoi/Lzcq3e94JjqMjSOYUpcmYQOu/x6fykty7a9MeTF2jKUVoIZbzujb700O1
	N3atj2KNI6OY604codTVYo9/tBy43Eo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-Jgo5-skiN2yhuAa53_qihQ-1; Mon, 05 Feb 2024 07:59:21 -0500
X-MC-Unique: Jgo5-skiN2yhuAa53_qihQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06554862DC0;
	Mon,  5 Feb 2024 12:59:21 +0000 (UTC)
Received: from localhost (unknown [10.72.116.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F4342166B31;
	Mon,  5 Feb 2024 12:59:19 +0000 (UTC)
Date: Mon, 5 Feb 2024 20:59:16 +0800
From: Baoquan He <bhe@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "yang.zhang" <gaoshanliukou@163.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"yang.zhang" <yang.zhang@hexintek.com>
Subject: Re: [PATCH] kexec: should use uchunk for user buffer increasing
Message-ID: <ZcDbpMByJ4VNwMZY@MiWiFi-R3L-srv>
References: <20240130101802.23850-1-gaoshanliukou@163.com>
 <Zb8+8qmn5SV4LKFd@MiWiFi-R3L-srv>
 <871q9r3xl6.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q9r3xl6.fsf@email.froward.int.ebiederm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 02/05/24 at 06:27am, Eric W. Biederman wrote:
> Baoquan He <bhe@redhat.com> writes:
> 
> > On 01/30/24 at 06:18pm, yang.zhang wrote:
> >> From: "yang.zhang" <yang.zhang@hexintek.com>
> >> 
> >> Because of alignment requirement in kexec-tools, there is
> >> no problem for user buffer increasing when loading segments.
> >> But when coping, the step is uchunk, so we should use uchunk
> >> not mchunk.
> >
> > In theory, ubytes is <= mbytes. So uchunk is always <= mchunk. If ubytes
> > is exhausted, while there's still remaining mbytes, then uchunk is 0,
> > there's still mchunk stepping forward. If I understand it correctly,
> > this is a good catch. Not sure if Eric has comment on this to confirm.
> 
> As far as I can read the code the proposed change is a noop.
> 
> I agree it is more correct to not advance the pointers we read from,
> but since we never read from them after that point it does not
> matter.
> 
> >
> > static int kimage_load_normal_segment(struct kimage *image,
> >                                          struct kexec_segment *segment)
> > {
> > ......
> >
> >                 ptr += maddr & ~PAGE_MASK;
> >                 mchunk = min_t(size_t, mbytes,
> >                                 PAGE_SIZE - (maddr & ~PAGE_MASK));
> >                 uchunk = min(ubytes, mchunk);
> > ......}
> 
> If we are going to improve the code for clarity.  We probably
> want to do something like:
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index d08fc7b5db97..1a8b8ce6bf15 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -800,22 +800,24 @@ static int kimage_load_normal_segment(struct kimage *image,
>                                 PAGE_SIZE - (maddr & ~PAGE_MASK));
>                 uchunk = min(ubytes, mchunk);
>  
> -               /* For file based kexec, source pages are in kernel memory */
> -               if (image->file_mode)
> -                       memcpy(ptr, kbuf, uchunk);
> -               else
> -                       result = copy_from_user(ptr, buf, uchunk);
> +               if (uchunk) {
> +                       /* For file based kexec, source pages are in kernel memory */
> +                       if (image->file_mode)
> +                               memcpy(ptr, kbuf, uchunk);
> +                       else
> +                               result = copy_from_user(ptr, buf, uchunk);
> +                       ubytes -= uchunk;
> +                       if (image->file_mode)
> +                               kbuf += uchunk;
> +                       else
> +                               buf += uchunk;
> +               }
>                 kunmap_local(ptr);
>                 if (result) {
>                         result = -EFAULT;
>                         goto out;
>                 }
> -               ubytes -= uchunk;
>                 maddr  += mchunk;
> -               if (image->file_mode)
> -                       kbuf += mchunk;
> -               else
> -                       buf += mchunk;
>                 mbytes -= mchunk;
>  
>                 cond_resched();
> 
> And make it exceedingly clear that all of the copying and the rest
> only happens before uchunk goes to zero.  Otherwise we are relying
> on a lot of operations becoming noops when uchunk goes to zero.

ACK.
This makes the code logic much clearer, thanks.


