Return-Path: <linux-kernel+bounces-130863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47923897E25
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CA01C23288
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DCE20DFC;
	Thu,  4 Apr 2024 04:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXspNnRb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79B62F37
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 04:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712203680; cv=none; b=dctZfIAaDliW0eM/BZf7UFbU5gGTWj71yLoJisV+ADyZ8hjg9rjiIogtfQ+0dD0zgHJ0LCH1atuolALaSzMewbhrTOs71vmzP0VFilMazIW3c6gU6DvV/GJ6HmsxFw8o7SQs4iiQrK+8PH5F0f8skPXxW6EJcP+5E0pWxAAOOgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712203680; c=relaxed/simple;
	bh=cG0Z/Q8Vd/6CIRdn/7mt96uH+81CK7mUItk43ieg5Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxVTBc8aPZ34STl7b77i98qH4JONA4gpc4+DaJo2nETzJF7v0+cx90QXWPSXRDjwz3ACkf3MM8+LttTGoJwLw0gSB0QXjjiy8zKT/ayX3mVc6lsk2+80wz4pK/3XBqMsNQ8a33R/x5vjjMQdavnYccxkVlCdsHFf9vezZB+KX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXspNnRb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712203677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Tnf/JqmvOIZtBLVJwY7VQErV1KE6NDkwVDWid6kh50=;
	b=hXspNnRbWz6Z1V/PKVrg90oxgdAKvR8JRCMXBXAltbREe8h/zH2b11X/9ELm5xc9JkI+TU
	pl7B09FsKzS/NtaWn26D7i8+yzp2FWaZ3yl7ulRG3LsPv0x6UFi/Mns5x85MucI2pLYEIC
	E5Bo+c5O+K+55anb3/StOtg4wyL+S3E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-6qohKH8hNYix2r2mMKHUzQ-1; Thu, 04 Apr 2024 00:07:55 -0400
X-MC-Unique: 6qohKH8hNYix2r2mMKHUzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9445185A782;
	Thu,  4 Apr 2024 04:07:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F31448173;
	Thu,  4 Apr 2024 04:07:53 +0000 (UTC)
Date: Thu, 4 Apr 2024 12:07:46 +0800
From: Baoquan He <bhe@redhat.com>
To: Justin Stitt <justinstitt@google.com>
Cc: akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] vmcore: replace strncpy with strscpy_pad
Message-ID: <Zg4nkkXYySZT6ZdE@MiWiFi-R3L-srv>
References: <20240401-strncpy-fs-proc-vmcore-c-v2-1-dd0a73f42635@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-strncpy-fs-proc-vmcore-c-v2-1-dd0a73f42635@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 04/01/24 at 06:39pm, Justin Stitt wrote:
> strncpy() is in the process of being replaced as it is deprecated [1].
> We should move towards safer and less ambiguous string interfaces.
> 
> Looking at vmcoredd_header's definition:
> |	struct vmcoredd_header {
> |		__u32 n_namesz; /* Name size */
> |		__u32 n_descsz; /* Content size */
> |		__u32 n_type;   /* NT_VMCOREDD */
> |		__u8 name[8];   /* LINUX\0\0\0 */
> |		__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
> |	};
> ... we see that @name wants to be NUL-padded.
> 
> We're copying data->dump_name which is defined as:
> |	char dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Unique name of the dump */
> ... which shares the same size as vdd_hdr->dump_name. Let's make sure we
> NUL-pad this as well.
> 
> Use strscpy_pad() which NUL-terminates and NUL-pads its destination
> buffers. Specifically, use the new 2-argument version of strscpy_pad
> introduced in Commit e6584c3964f2f ("string: Allow 2-argument
> strscpy()").
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - don't mark buffers as __nonstring, instead use a string API (thanks Kees)
> - Link to v1: https://lore.kernel.org/r/20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  fs/proc/vmcore.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 1fb213f379a5..5d08d4d159d3 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1370,9 +1370,8 @@ static void vmcoredd_write_header(void *buf, struct vmcoredd_data *data,
>  	vdd_hdr->n_descsz = size + sizeof(vdd_hdr->dump_name);
>  	vdd_hdr->n_type = NT_VMCOREDD;
>  
> -	strncpy((char *)vdd_hdr->name, VMCOREDD_NOTE_NAME,
> -		sizeof(vdd_hdr->name));
> -	memcpy(vdd_hdr->dump_name, data->dump_name, sizeof(vdd_hdr->dump_name));
> +	strscpy_pad(vdd_hdr->name, VMCOREDD_NOTE_NAME);
> +	strscpy_pad(vdd_hdr->dump_name, data->dump_name);

LGTM, thx

Acked-by: Baoquan He <bhe@redhat.com>


