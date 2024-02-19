Return-Path: <linux-kernel+bounces-70657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A8D859AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E3D8B20F46
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031E51FDA;
	Mon, 19 Feb 2024 02:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEgkreaL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433501865
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708310316; cv=none; b=PKLj6vbe3EJl1YZfvT7j5U46yjAh2OVszAcvQN9msQCaHhGdbEeWxrezMEZIH607r/58ZPyjZeBNEcIqjKJRH4HVPcGmPZXD1vhlzAUVtYpEwGX/t2otXtHXo49LJGPU0uEgygZi3JfXXKXIlsiDerVJdd+PvA8MA01chutsfy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708310316; c=relaxed/simple;
	bh=B8WSFf0OxDYZ3xm3TObMRuC5OD+Ax2o+y+l7pYRpOfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOnr8ePu1Muu3FyVL0rjMYTHGmJHfFlSYAiVCKYpzKJFX4S4qFNbjes3YXxfUBor6fUJH+CPXtCE18H/y2ICKWgZBLcAhUV91IhnmoIqLy/u68v9udH1/EDUPh8CkgZ+KBozT9RnOvNAmCo+9WQIpZmLUs2PpqaNPgg4HJqCKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEgkreaL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708310313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8xRMtLYUPL3mWvlxnyWEpZZfD1W87x09hoKOFcFIbbY=;
	b=TEgkreaLmvgboxr5KJq9+m2bM8t6sGCBcOKqZIFtsfAofRwzk7mmDWhHsc1Pfd/ph2rMjD
	0wK0XCXtNX+dkXlrW+N1B+9Q2KrfANFxYmfjP2JuhiNxI9qTxn441X0bVkN0uhOf6ruKEc
	5eju/tjAgfsyYyVGgeGSHLzsoVEx75c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-B2Yl_9pOP8aY06wMk21fPA-1; Sun, 18 Feb 2024 21:38:27 -0500
X-MC-Unique: B2Yl_9pOP8aY06wMk21fPA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0034862DC1;
	Mon, 19 Feb 2024 02:38:26 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EA806200A7B4;
	Mon, 19 Feb 2024 02:38:25 +0000 (UTC)
Date: Mon, 19 Feb 2024 10:38:22 +0800
From: Baoquan He <bhe@redhat.com>
To: "yang.zhang" <gaoshanliukou@163.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"yang.zhang" <yang.zhang@hexintek.com>, akpm@linux-foundation.org
Subject: Re: [PATCH] kexec: should use uchunk for user buffer increasing
Message-ID: <ZdK/Hsy1TMB8PlJs@MiWiFi-R3L-srv>
References: <20240130101802.23850-1-gaoshanliukou@163.com>
 <Zb8+8qmn5SV4LKFd@MiWiFi-R3L-srv>
 <871q9r3xl6.fsf@email.froward.int.ebiederm.org>
 <2a207ca2.1e87.18dbf17ee10.Coremail.gaoshanliukou@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a207ca2.1e87.18dbf17ee10.Coremail.gaoshanliukou@163.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 02/19/24 at 10:00am, yang.zhang wrote:
> 
> 
> 
> Thanks for your replies.
> Do you have plans to merge the improving code for clarity, or just keep them unchanged.

You need post v2 to change those two places as Eric has demonstrated.
Please CC Andrew when you post.

> 
> At 2024-02-05 20:27:33, "Eric W. Biederman" <ebiederm@xmission.com> wrote:
> >Baoquan He <bhe@redhat.com> writes:
> >
> >> On 01/30/24 at 06:18pm, yang.zhang wrote:
> >>> From: "yang.zhang" <yang.zhang@hexintek.com>
> >>> 
> >>> Because of alignment requirement in kexec-tools, there is
> >>> no problem for user buffer increasing when loading segments.
> >>> But when coping, the step is uchunk, so we should use uchunk
> >>> not mchunk.
> >>
> >> In theory, ubytes is <= mbytes. So uchunk is always <= mchunk. If ubytes
> >> is exhausted, while there's still remaining mbytes, then uchunk is 0,
> >> there's still mchunk stepping forward. If I understand it correctly,
> >> this is a good catch. Not sure if Eric has comment on this to confirm.
> >
> >As far as I can read the code the proposed change is a noop.
> >
> >I agree it is more correct to not advance the pointers we read from,
> >but since we never read from them after that point it does not
> >matter.
> >
> >>
> >> static int kimage_load_normal_segment(struct kimage *image,
> >>                                          struct kexec_segment *segment)
> >> {
> >> ......
> >>
> >>                 ptr += maddr & ~PAGE_MASK;
> >>                 mchunk = min_t(size_t, mbytes,
> >>                                 PAGE_SIZE - (maddr & ~PAGE_MASK));
> >>                 uchunk = min(ubytes, mchunk);
> >> ......}
> >
> >If we are going to improve the code for clarity.  We probably
> >want to do something like:
> >
> >diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> >index d08fc7b5db97..1a8b8ce6bf15 100644
> >--- a/kernel/kexec_core.c
> >+++ b/kernel/kexec_core.c
> >@@ -800,22 +800,24 @@ static int kimage_load_normal_segment(struct kimage *image,
> >                                PAGE_SIZE - (maddr & ~PAGE_MASK));
> >                uchunk = min(ubytes, mchunk);
> > 
> >-               /* For file based kexec, source pages are in kernel memory */
> >-               if (image->file_mode)
> >-                       memcpy(ptr, kbuf, uchunk);
> >-               else
> >-                       result = copy_from_user(ptr, buf, uchunk);
> >+               if (uchunk) {
> >+                       /* For file based kexec, source pages are in kernel memory */
> >+                       if (image->file_mode)
> >+                               memcpy(ptr, kbuf, uchunk);
> >+                       else
> >+                               result = copy_from_user(ptr, buf, uchunk);
> >+                       ubytes -= uchunk;
> >+                       if (image->file_mode)
> >+                               kbuf += uchunk;
> >+                       else
> >+                               buf += uchunk;
> >+               }
> >                kunmap_local(ptr);
> >                if (result) {
> >                        result = -EFAULT;
> >                        goto out;
> >                }
> >-               ubytes -= uchunk;
> >                maddr  += mchunk;
> >-               if (image->file_mode)
> >-                       kbuf += mchunk;
> >-               else
> >-                       buf += mchunk;
> >                mbytes -= mchunk;
> > 
> >                cond_resched();
> >
> >And make it exceedingly clear that all of the copying and the rest
> >only happens before uchunk goes to zero.  Otherwise we are relying
> >on a lot of operations becoming noops when uchunk goes to zero.
> >
> >Eric


