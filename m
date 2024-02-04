Return-Path: <linux-kernel+bounces-51492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35741848BDB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 865D3B228B2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26591B660;
	Sun,  4 Feb 2024 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwlI4SNs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222C8F54
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707032320; cv=none; b=UgilOCiwbQNTQ2lOq/zPK3pB270xgaisjf8E1CATtXro3pb8imR1CHRAVigOrcf29ZbCVI9SLR9rt/kReosafFmiX4ThJ6lIoCNOsTff+g5q8K3cHlI2u6/P1sGf7AyJm1gfo+Mw9AOS2NYsynFYkAIo200xgHeyvKrTkiAJGdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707032320; c=relaxed/simple;
	bh=1h/K1JOTIwtYnwgNlheYmiKXCZwTIUYYV6F7BDGr2uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPYfS8grpvbQ9W2ZWCF9huwCoXBxuf9l6FAANMOpEBcpyRw4UC+EkQYFl4qYWdlhPbK2VsiPaEYrhmRrgKugkYX6scs6D2tLaeDG6xdkyKgICjArcD8Tufo6/Z+AvAP1Ke0LxLCqvc6ctsrHGIxaWT7Nic8gsoYASJf41x5Dg0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwlI4SNs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707032316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DW8SolzwMeCv8mPxutq7dUzGbNRfIdT1DwumifZIq0c=;
	b=TwlI4SNsWgLC5N/LApwesjcNul4WwIc5o6J7GYrFjcpCQoHIJywKc8MbxKOAriWOL2c4lK
	SEeK05wSnlMce4y3pa+FO3DkpnB1iU1aG1r1JncPE/dyK2O5BfJJd9i6wbIIKEkmatJbGQ
	wmj+i7whWcDlO6X+fxqU8DdPM5kZECQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-mn4BQlZTO5ShtAF3obfNEw-1; Sun, 04 Feb 2024 02:38:32 -0500
X-MC-Unique: mn4BQlZTO5ShtAF3obfNEw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D97885A588;
	Sun,  4 Feb 2024 07:38:32 +0000 (UTC)
Received: from localhost (unknown [10.72.116.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 376AA1121306;
	Sun,  4 Feb 2024 07:38:30 +0000 (UTC)
Date: Sun, 4 Feb 2024 15:38:26 +0800
From: Baoquan He <bhe@redhat.com>
To: "yang.zhang" <gaoshanliukou@163.com>
Cc: ebiederm@xmission.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"yang.zhang" <yang.zhang@hexintek.com>
Subject: Re: [PATCH] kexec: should use uchunk for user buffer increasing
Message-ID: <Zb8+8qmn5SV4LKFd@MiWiFi-R3L-srv>
References: <20240130101802.23850-1-gaoshanliukou@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130101802.23850-1-gaoshanliukou@163.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 01/30/24 at 06:18pm, yang.zhang wrote:
> From: "yang.zhang" <yang.zhang@hexintek.com>
> 
> Because of alignment requirement in kexec-tools, there is
> no problem for user buffer increasing when loading segments.
> But when coping, the step is uchunk, so we should use uchunk
> not mchunk.

In theory, ubytes is <= mbytes. So uchunk is always <= mchunk. If ubytes
is exhausted, while there's still remaining mbytes, then uchunk is 0,
there's still mchunk stepping forward. If I understand it correctly,
this is a good catch. Not sure if Eric has comment on this to confirm.

static int kimage_load_normal_segment(struct kimage *image,
                                         struct kexec_segment *segment)
{
.....

                ptr += maddr & ~PAGE_MASK;
                mchunk = min_t(size_t, mbytes,
                                PAGE_SIZE - (maddr & ~PAGE_MASK));
                uchunk = min(ubytes, mchunk);
.....}

> 
> Signed-off-by: yang.zhang <yang.zhang@hexintek.com>
> ---
>  kernel/kexec_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index d08fc7b5db97..2b8354313c85 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -813,9 +813,9 @@ static int kimage_load_normal_segment(struct kimage *image,
>  		ubytes -= uchunk;
>  		maddr  += mchunk;
>  		if (image->file_mode)
> -			kbuf += mchunk;
> +			kbuf += uchunk;
>  		else
> -			buf += mchunk;
> +			buf += uchunk;
>  		mbytes -= mchunk;
>  
>  		cond_resched();
> @@ -881,9 +881,9 @@ static int kimage_load_crash_segment(struct kimage *image,
>  		ubytes -= uchunk;
>  		maddr  += mchunk;
>  		if (image->file_mode)
> -			kbuf += mchunk;
> +			kbuf += uchunk;
>  		else
> -			buf += mchunk;
> +			buf += uchunk;
>  		mbytes -= mchunk;
>  
>  		cond_resched();
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


