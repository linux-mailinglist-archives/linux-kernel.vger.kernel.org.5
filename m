Return-Path: <linux-kernel+bounces-39779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA4C83D5FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45337282D09
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE511CD1A;
	Fri, 26 Jan 2024 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjMDqSpr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFA61C295
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258378; cv=none; b=JszIUzKvmE3B1WQ6t5IR20FdZcPqLiwj6wgs3JNebjZe1FROH/m40stP+VTUU4MGkXJMsmhh8CwZeyZOhBpnzv1mxh7Mu37ZZdsiS1t96FRdtHDGmLOkQy1MIIrCDXiBrAWYcSlMSA+4kvRxSE497/0wHqXln2Ho3UuQCMmvwCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258378; c=relaxed/simple;
	bh=/ZExn/vuFRbWZ0XKt1iPU3BjOB9+pjTpfC4eFtC/r/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HP7+3/0UfLOWbsqgc+ihvjsMpfWwhH1sSS8M55+4X0FduBg0D2QXmoViIjZT/agHc0u8kKH4mhXus2pP34qyi9No8YFSl3bw8znQbckMwXeEGV9CWy/IcelspM6xawqvkQOSZ/HurnI4tL95agbz2/KKuh6PtZvyEHnYCGEzj1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjMDqSpr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706258375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HSrHQZvaP0ykbKDhrUoGu3IZMLvnpMMUqhqC7/0YNy4=;
	b=EjMDqSprCCUPv/X2GQJ5qogV3vqMd958KyzjVAkVlAzpr2J02iLkIKgqq73YGX8Ol07E9p
	vdsWromPVegJPrOm1jfVnRWUP75P852ttT8CoBPMk+GO6TplLDIu8Sd5ud+W3P4eT0eAUt
	otqiCUzwizkgcgtj5jaG54Ut7uwBAsI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-om3G2RmaPemkZ3oWARd5Fg-1; Fri, 26 Jan 2024 03:39:32 -0500
X-MC-Unique: om3G2RmaPemkZ3oWARd5Fg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bdef76ae17so177006b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706258372; x=1706863172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSrHQZvaP0ykbKDhrUoGu3IZMLvnpMMUqhqC7/0YNy4=;
        b=sRb8OG/dMtPmz2MmWofLb/oORlzuR5UR3cZ7dkyI8IaqiwJEbEp9e+TiIqiC0lhsV/
         78qTcb2cWdgph2n4luKIuRGJGd1iiaWHz4aDPoylcyc2E9Qqjjn7ei6HpPW+ecax4nG/
         gVGSzjJT2cJf6fMddgf8bD3qvMBA8jQiXeQThCiQHSArlQG61mzYRgYgq+a+3mgy8c2W
         DfQdwdU6mUn0MOgUj7z7+aSd3zsfvjioM9ae3r+CZ2UW1Yazjb29QYNlLJNDInGyTApl
         Er8AOtEPSvTJv3ECBrbR9clneS6sHpDOtNDtodzz8Nb38LFt4303ibeOzeTS1i3fbmez
         RvIg==
X-Gm-Message-State: AOJu0Yw4jVYFYn8EZvkCI7c5tHNoaax6RG5QJADFJJ/Jt4Uz4rIuoRTs
	KxxlJEaYaMc+cRrzrcBf3iBU3tAEiNK+8DIRvz+SNsLsIwJFY0swKepcvlqml5B4o00lqn/nzaJ
	Sv2Vh8Otjw0ygh0NlJ59MVIfJ9jGfBMz71BqlpVTU5obNcGBdX+00G7A6gVcJQw==
X-Received: by 2002:a05:6808:1411:b0:3bd:f2fe:6fe with SMTP id w17-20020a056808141100b003bdf2fe06femr273114oiv.52.1706258372217;
        Fri, 26 Jan 2024 00:39:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/LGvYtOivFaoHVOM/ZlUoxsC/pKi4lqh3yOx8zM4vi3aNRhuCKiggBTdsYv3Iy3sYxZ0dvQ==
X-Received: by 2002:a05:6808:1411:b0:3bd:f2fe:6fe with SMTP id w17-20020a056808141100b003bdf2fe06femr273106oiv.52.1706258371884;
        Fri, 26 Jan 2024 00:39:31 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c6:4a05:9f01:cede:7b45:1f9d:67f])
        by smtp.gmail.com with ESMTPSA id cp10-20020a05622a420a00b0042a7e2b45cdsm250836qtb.1.2024.01.26.00.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:39:31 -0800 (PST)
Date: Fri, 26 Jan 2024 08:39:28 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH wq/for-6.9] tools/workqueue/wq_dump.py: Clean up code and
 drop duplicate information
Message-ID: <ZbNvwJoj8zd2RmqC@localhost.localdomain>
References: <ZbKKi2cnczB0MuV_@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbKKi2cnczB0MuV_@slm.duckdns.org>

Hi,

On 25/01/24 06:21, Tejun Heo wrote:
> - Factor out wq_type_str()
> 
> - Improve formatting so that it adapts to actual field widths.
> 
> - Drop duplicate information from "Workqueue -> rescuer" section. If
>   anything, we should add more rescuer-specific info - e.g. the number of
>   work items rescued.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> ---
> I'm applying this to wq/for-6.9.

Thanks for the heads up! Looks good to me.

Tested-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri


