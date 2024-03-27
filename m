Return-Path: <linux-kernel+bounces-121864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C80488EEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537D61C34176
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2B714E2FB;
	Wed, 27 Mar 2024 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCCFm4Ab"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A8F12EBEF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565828; cv=none; b=eNx+bCJUqTg9a626MPfIStPPqBr3aeySdx+ySHTbVvQnBoVoUmiRrr4vuZtn3WWjxB//2IwuWvM+bgZMLiM/WrPLePED6CQaLSTmHe0i+X2OGGjS44SWVnZaaPYoaBJUYfUrL7Tv+SGJLaWuQ9GONNIyE3PDprPgBiz7/fNs+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565828; c=relaxed/simple;
	bh=ODLp4kP0ztBb4uqhFI47CKqUmFGO3U9j0BAO0PTKgIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHNGiI4g8YtOFBjbbf07WnnWIAbdDuqjZtfSvhjm2ozR2HwDQnHQl12r1RnjtqhVMxlA2RY5YZ9KXftWkoCzrQPkFcJQeaIuikv2a6r1VADTFUqseGl4w8cQW99pMtugrz2zXwBPSx61TcCcXlPt7A1PCYWf6e0F0NdXh0UJBjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VCCFm4Ab; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711565825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2uV3fcPM6D/HTQQaQNr9EXbWv5n0KKEQ28+lh++mlU=;
	b=VCCFm4AbBNI4AvJgLfZduol71nERf+Ly4JtbyyMq4OxXT9kN3YXfe4AOwLzi8tam3kcH/1
	PxnNUmRke7tkWyI0tGRcJSPnIsEd6a8L9D8yfU5TZuVGZbMX0JS0sCWrT0SgSZOLqsPqQ6
	Jfow9BmqISIpwWYqvbmTkeWTmYe2sMw=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-VtwvtTlnO1KffZKvnvMxFg-1; Wed, 27 Mar 2024 14:57:03 -0400
X-MC-Unique: VtwvtTlnO1KffZKvnvMxFg-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5a4d25f4795so22729eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711565823; x=1712170623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2uV3fcPM6D/HTQQaQNr9EXbWv5n0KKEQ28+lh++mlU=;
        b=vVE0gPnm+wWccNBPk+Mo0g238Qf7E8z/X7dcOXFmZVR7Jpx63Fr9q99hGWVlwGuN71
         bPHhRKf3YXWvJpWOeL6+X+/aX0DVh01cv6o3wAk+jNUOFbR7H66oOKhGzwhSzT8kMt7W
         bTEczVTibH0U7uboks+OKFM/kVarARn9ERKMVcSfEB8OsJvSbnuXB84jPNQ5kCnE3phC
         YMvR/J2sTyLRii88fFgOtp9xojnmow/YqRJM58TnfzJh/6oUm9WVsdd2QwPTvZ9zYksE
         mqGYSaTKDfrigiZWq5UkVTpT8d9eIHcGO/bH76/cOyZLmeX99h5Ou3S8jY2YuWpvzU3r
         xHZg==
X-Forwarded-Encrypted: i=1; AJvYcCXLv5KzNlJkR+BXrUuLySlTh0dk6HO09pCL4mlNRVzKVQavitY17BVrIFCSOQynMA5gLgtgjqOdeLEPYXyZ06Wn1+yscwf3dITEWxyl
X-Gm-Message-State: AOJu0YxKGZPoVLRxVw/QowTFzr165sVdNAadpdbB2hWkoVSxJfN7sOn/
	f2TVxeDHTOyLL9mt60p+AJuNDOgvdq8D/cWxKWeBC8tq8ohdrW0u7/YUVTSsaLXXfbs4HS9dun1
	V2gRUzO9h/LJ6teBzogxEgf6RVnks8RCpNSeQffzHzX47tI2vKipyxJlhHpbyvg==
X-Received: by 2002:a05:6820:e0f:b0:5a5:5ed9:b246 with SMTP id el15-20020a0568200e0f00b005a55ed9b246mr998444oob.0.1711565822860;
        Wed, 27 Mar 2024 11:57:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8ZLok88R0OgZXibxpbpVWGqPZ88QA+3LjCUsYCfI3W3udUs2WL1Xfomla6duh8BwZ8ZRucA==
X-Received: by 2002:a05:6820:e0f:b0:5a5:5ed9:b246 with SMTP id el15-20020a0568200e0f00b005a55ed9b246mr998422oob.0.1711565822369;
        Wed, 27 Mar 2024 11:57:02 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id eq17-20020a05622a5e1100b004313f54aaa9sm4895159qtb.5.2024.03.27.11.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:57:02 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:56:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Peng Zhang <zhangpeng362@huawei.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, david@redhat.com,
	axelrasmussen@google.com, surenb@google.com, lokeshgidra@google.com,
	Liam.Howlett@oracle.com, wangkefeng.wang@huawei.com,
	sunnanyong@huawei.com
Subject: Re: [PATCH] userfaultfd: early return in dup_userfaultfd()
Message-ID: <ZgRr-8PX2Jdk6VKz@x1n>
References: <20240327090835.3232629-1-zhangpeng362@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240327090835.3232629-1-zhangpeng362@huawei.com>

On Wed, Mar 27, 2024 at 05:08:35PM +0800, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> When vma->vm_userfaultfd_ctx.ctx is NULL, vma->vm_flags should have
> cleared __VM_UFFD_FLAGS. Therefore, there is no need to down_write or
> clear the flag, which will affect fork performance. Fix this by
> returning early if octx is NULL in dup_userfaultfd().
> 
> By applying this patch we can get a 1.3% performance improvement for
> lmbench fork_prot. Results are as follows:
>                    base      early return
> Process fork+exit: 419.1106  413.4804
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


