Return-Path: <linux-kernel+bounces-129918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80D4897203
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A502918E5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4064148FFA;
	Wed,  3 Apr 2024 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bo3VDnb2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF13149017
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153442; cv=none; b=nJvTcDf9QMeuIq1lCPTVzQt2NxuKT1quR0CiZGLXvIs4AT32u8o9q9iI/C2s30KPcpZLLLD3+wmt2Sn2bpyReX4xrGLIJ6xhd82ukLxqd25jnAHluwBYPHnShngXoR8gm9AI4Y8S0DjqbQ/qGr+BXrrK1j1iMJ8tkcAvcTQkP6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153442; c=relaxed/simple;
	bh=gnQFujUVd4le7PN2eYoz/fObbbbcl8DGK6hCKJ6Zjnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXYkHQOZRvnYnChhKRjHKkC7AkvCdlNsQP+Zvohr3D2KzelaEBbqohQvpx9s38uuJu9cQWEQ4bk5j15hsNAs3QGSBxTmpTlkbVYEbeq4IpGLsdxRWKO4eXsfOb/Z6MyLURZzIudZRrK9dDA9TC5ghAz4fbwPQFkiRbZjnrtD1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bo3VDnb2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712153439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2aBTyYb+Nt/ptLDXgMV8oWUST4z7rOytIWtEbvnm/I=;
	b=Bo3VDnb2/Mf621Iepj2ZLTOfbLLB1UOIqHXRPGfRDCwyzZ7z1r8rX3sL17U6ovvxkAUXGW
	Tawrf6iKMuNiEk2Q9CJeiD3LDxVM835ZpebusBescVvmFwLQQXvCJ7dr/TXNfmUpIBHsWz
	LIjzW76t2I6JPZzAsbK7FltTr62proU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-UVNR4HalNOG-9_jGAbHVqg-1; Wed, 03 Apr 2024 10:10:35 -0400
X-MC-Unique: UVNR4HalNOG-9_jGAbHVqg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56e0ce8d705so245414a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153434; x=1712758234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2aBTyYb+Nt/ptLDXgMV8oWUST4z7rOytIWtEbvnm/I=;
        b=k6ZQAtAdFtY5mtC9Uh89V5SDMluQw8QctB8ESfst6X/Gb1fJF/rJ2UAMe/bK2CdP71
         n+FkjZGjhIOBsbwZVa0Lb7ski7h7xRD2M4cZWhibXrdZh6sM4rYnkBNrCfDdEPbxJ8Fm
         XE/3t7cdmZFDAxSkrGJFH2bp+S4JjEwKUOoOW3pAww+lkAcV5JDr81hvkqmC+i20v+1t
         SpoSJTuf8SDA304n8+euL91c7CTGt2xHoEBtBoSyHvxNqksP44LKgj1Vx/lBGVxNAb6Z
         A+wvrkFPBMfiT89UcCp05Bt9OBQCzxu81CtDUS9TeKZ3ugSChe5i2DuEWJazpQFUNd/Y
         IWxw==
X-Forwarded-Encrypted: i=1; AJvYcCWuXvLBR15feEuzQ7Rrd8E9zMnkTr+ywlLe6XCovJ4+qOM1OyC68u+pZsLIXwit0xWkPh6/5bq/MV8W9FtmruIMwqXNmc+5NvtPGwma
X-Gm-Message-State: AOJu0Ywjkw1qckpPjFxCjoY45Dn+tIP8pSYxwrntfLUZXikJpU4WEsi0
	t5d0w0EwpEN/hpD3x/sKCGPWjF6s7uF/BrPLYIS56/OhqzeqchQF1Vym3j4HXZ8eY3KD+BsGjtJ
	SjW7AbBU5ow3b7xc1KH7b0NDTq0GvZFEVPSv53iD0APlK6vg7T2rlV1XoaRfSSfDIZ0+I+Q==
X-Received: by 2002:a05:6402:27d3:b0:568:d315:b85e with SMTP id c19-20020a05640227d300b00568d315b85emr2403729ede.36.1712153434329;
        Wed, 03 Apr 2024 07:10:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGTz1BJSzH4XsYtIvDxE2Ibd4gH2Fl0QoKJfEwumIBmM+YFFAAfM84ZxOKH6aulkAAP1jXrg==
X-Received: by 2002:a05:6402:27d3:b0:568:d315:b85e with SMTP id c19-20020a05640227d300b00568d315b85emr2403684ede.36.1712153433621;
        Wed, 03 Apr 2024 07:10:33 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f4-20020a056402194400b0056c4cdc987esm8055405edz.8.2024.04.03.07.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 07:10:33 -0700 (PDT)
Message-ID: <6898c729-cc96-4611-9a5a-8e3558e1b69c@redhat.com>
Date: Wed, 3 Apr 2024 16:10:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vboxsf: explicitly deny setlease attempts
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240319-setlease-v1-1-5997d67e04b3@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240319-setlease-v1-1-5997d67e04b3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/19/24 5:32 PM, Jeff Layton wrote:
> vboxsf does not break leases on its own, so it can't properly handle the
> case where the hypervisor changes the data. Don't allow file leases on
> vboxsf.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I have added this to my local vboxsf branch now and I'll send
out a pull-request with this and a couple of other vboxsf fixes
soon.

Regards,

Hans




> ---
> Looking over the comments in the code around cache coherency, it seems
> like it ought to deny file locks as well? We could add a stub ->lock
> routine that just returns -ENOLCK or something.
> ---
>  fs/vboxsf/file.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
> index 2307f8037efc..118dedef8ebe 100644
> --- a/fs/vboxsf/file.c
> +++ b/fs/vboxsf/file.c
> @@ -218,6 +218,7 @@ const struct file_operations vboxsf_reg_fops = {
>  	.release = vboxsf_file_release,
>  	.fsync = noop_fsync,
>  	.splice_read = filemap_splice_read,
> +	.setlease = simple_nosetlease,
>  };
>  
>  const struct inode_operations vboxsf_reg_iops = {
> 
> ---
> base-commit: 0a7b0acecea273c8816f4f5b0e189989470404cf
> change-id: 20240319-setlease-ce31fb8777b0
> 
> Best regards,


