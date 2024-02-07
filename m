Return-Path: <linux-kernel+bounces-56786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6783084CF2A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F672862F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1665181207;
	Wed,  7 Feb 2024 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeyoffAt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA92823A6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324072; cv=none; b=Z1VhDcvzv4oE1ZrfIpqk7JIkRvzby8MQMb9SyzujNBChJR7dzXeQ6OEbOiSLmk0XRKCh4VzZuwnhnmAx7e/IWaEt5xpIQnC0atiXkhJ4ftiQyESa/bSgtlHApxV+jTu/gJG0zeX9+neAD725zdofAxuaNdNx41y0rZF5T3VNWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324072; c=relaxed/simple;
	bh=ysRZQj+fMnSP0kwWwLlGUpk66/SFquxkGeUnwQ0KwWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgUF5Fy5PKU/62Un3E4H3/QnaeL/Klev+Uu4iN+vm+U5YR5ZImhXfhIklI4qrjeGzjGKGImLekNG3wUw3kRZitYNGk+hZjVtVr8fEuXYf2SnorVCMZMFeeqeqRNSv57NsszspGuftiNQ7zYyOsInnJrbD50/2sApVcw8/fUQmh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OeyoffAt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707324069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pLHmOri0rwabgYHmtFqkZU7UR9oorDvGKBxIT2pvDE4=;
	b=OeyoffAt9znlUBvPx6jjzffZp2gv/ptcpw21Hltex52Fv4Mc7rTcmf1q05e+KRe9yhs3gC
	lzB4M38B9Tkl7ae5UNYMDDpAQy4SUJrCbmGqTstoA6zkOOMKzbDbx/YfFvxc6Gaarp9xWT
	IR3d4PylOyx0LBacJu/mx5wz0FhOA/E=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-ivyzch4zP-CL3qROyV4nZw-1; Wed, 07 Feb 2024 11:41:08 -0500
X-MC-Unique: ivyzch4zP-CL3qROyV4nZw-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-7d2d72f7965so383381241.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 08:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324067; x=1707928867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLHmOri0rwabgYHmtFqkZU7UR9oorDvGKBxIT2pvDE4=;
        b=a5KLSN1Dajp6xXsx8GZdLtFwjZ8fKjwd92ZQ50bsVStmgZA7FXgwsTf2QkxKvqoLri
         Q3vdOX0TCfqGruvBRZ019pgdXSv/KQxpPPsiPFCjDd0kIkptZfVu3QgXLRT7WNPGaB1w
         c4Aa38BwCgJuxEiN05MwTNWHm/B6UReoksrEZmlu2GctM9X3+1aetgWQsf32T/W2LJaB
         WnkyM/ScY/u4X/n7xwN8uHOrdp3CI9+34XCkkxw8bQwVHR6Q3iIcQdt0j79PD+NTcre/
         aRfrNaFnjrvx9u4bot1J+CATPcCzx6hkKhPjtofoXvNDbnt5qeZin2cxJ2AIzE8IPxVn
         SPUw==
X-Gm-Message-State: AOJu0YzLVvPiM2sp6ybR4D0rH/gHE86W7OoNk1qr2wjIdunb/spxA3im
	oxGlkNNG7PPfCt7NisdMqJ7B/SdOz5SYLo7DmmeIl7kc7Xf8joi3CPmI6+U8YVYNFdeYggkOX8W
	4VkuhoE1U9DOeq79G6ZB1KIQdWMkmtZWV/sZmiZic7IK+YhAXE1blWqsRYkLiMA==
X-Received: by 2002:a05:6102:4423:b0:46d:2719:7a8d with SMTP id df35-20020a056102442300b0046d27197a8dmr3213009vsb.6.1707324067566;
        Wed, 07 Feb 2024 08:41:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI7L8pil6iYGjgA+wbXsRO5bpLfCdQiwFjFbu6u3Xk4AfE+eFX5x0ob1pS5dKI4b5MoLT5EQ==
X-Received: by 2002:a05:6102:4423:b0:46d:2719:7a8d with SMTP id df35-20020a056102442300b0046d27197a8dmr3212990vsb.6.1707324067181;
        Wed, 07 Feb 2024 08:41:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4YpG9ByTiv189vcqpCJjfwcaVnc97uYfbTiy23VL7e+NLa8gM9pBl6B7kahhJlhqPHbEWl1XrMx1P6vyzoGOLmOjIwXlHMo0TjnydXq4DVhDrEtKwKzTMw6Sgw7f3lqOVbokB9BkbKPkhIIg0AXeDiKMIl3K7BVl6U01MzR9wcqhOUR8vItXu26DH+pDjjT/X2LSNjgf7atpGli3k8+2OZNR5+Swewic0KcHarXUWGvcqf+weW1kCNMMwndWRbvMKAF/79tUpApSiN7K4JKYba49PH8dCPLyO8L4ZE0jabc3kc4HpsQ+C
Received: from localhost (ip70-163-216-141.ph.ph.cox.net. [70.163.216.141])
        by smtp.gmail.com with ESMTPSA id mf7-20020a0562145d8700b006852ff71ac2sm738818qvb.30.2024.02.07.08.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:41:06 -0800 (PST)
Date: Wed, 7 Feb 2024 09:41:05 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, pasha.tatashin@soleen.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rientjes@google.com, yosryahmed@google.com, john.g.garry@oracle.com
Subject: Re: [PATCH v3 2/3] iommu/iova: Reorganise some code
Message-ID: <oskl6xbmrv24vs2mmau23mnzb35x2mvhh4ujg6ntcih7pribkj@oxurium75tnu>
References: <cover.1707144953.git.robin.murphy@arm.com>
 <d4753562f4faa0e6b3aeebcbf88fdb60cc22d715.1707144953.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4753562f4faa0e6b3aeebcbf88fdb60cc22d715.1707144953.git.robin.murphy@arm.com>

On Mon, Feb 05, 2024 at 03:32:40PM +0000, Robin Murphy wrote:
> The iova_cache_{get,put}() calls really represent top-level lifecycle
> management for the whole IOVA library, so it's long been rather
> confusing to have them buried right in the middle of the allocator
> implementation details. Move them to a more expected position at the end
> of the file, where it will then also be easier to expand them. With
> this, we can also move the rcache hotplug handler (plus another stray
> function) into the rcache portion of the file.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iova.c | 128 +++++++++++++++++++++----------------------
>  1 file changed, 64 insertions(+), 64 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>


