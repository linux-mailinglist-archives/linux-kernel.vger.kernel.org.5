Return-Path: <linux-kernel+bounces-124370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDDE891657
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3146228791B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C2451C42;
	Fri, 29 Mar 2024 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PX3+alzm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DF93C49A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705923; cv=none; b=CEOHepebAqBBKHjUXKdFWgFesWwz9Uky6NJuiWZ/LragnvVBR2ljTKyiaWcx5DQ1pRk4v4FdNfczQh8OtuusIIh5kWcxcoo28ovspZZwOORz6e7l3dqM2XKVPcWU3WMEolRRvT1zzRQuX2V5qljpodPidYrjWGHkwkV4J9eDmP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705923; c=relaxed/simple;
	bh=djiaB4U2ZnOlHE7cFPb+RDg52bCNsVSynx5YnvVL9bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCb7hsqu5y3fFY03wuwkzxisQGEryh0xZEC5kTdgoF33ZX2WeK4LAuUHirW7ZWUcpJFtXORDuXQAZpFr+biqpFtckoiU++UAu42RHLcThALNqYjPXc7DQ3Czsm+kImLMfQ5oVy0uR0Na8EVn3ZiR6yo6xEuPqgfWQH3KFYiYcbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PX3+alzm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711705921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=deMJ3oVnouvBFi4X5/gthJT9K+f+3N94offCvLJPHoE=;
	b=PX3+alzmCMBvD6eQRPlJVPtuh1beVa47cewYix/8/CeJSFus9IcK1g2y7qLttiQd+THEHA
	MeZttrJm5RW7uFa8hfA27UkiuyFWNG9WvWxUUgeL7PM5vQDVMyTOBxhnSDT6JdMW7+JdBP
	CastF84TfETO/w5yRSfeiiWQ50o5Z60=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458--mwH2MVbOUezi-hpvVQOjA-1; Fri, 29 Mar 2024 05:51:55 -0400
X-MC-Unique: -mwH2MVbOUezi-hpvVQOjA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-515d45b24f3so1006e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711705914; x=1712310714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deMJ3oVnouvBFi4X5/gthJT9K+f+3N94offCvLJPHoE=;
        b=v3AF1XsUrpj7qUgQ0fD9ejzYpYiTQWKXW6YYmT4nSPouu0gBZoH07tT7N/hCXjbT0p
         dg2A+hmpsj2CdsB4jliCnRP2Nr1/imOGyeKh8A/QSUN0GsCsxogBQZKI/0IOAgoW2vsx
         2Jq4yQj98MRB2+DaS4M7qNOVFeQg+WT54b9donKXEKbhiP2TubmMouslEXned5+7gIci
         tjmDLcgpNeEVqEb7j1wpnzdK9J8tGCQRHJwCfOb7mPY8b4SaBAFAVUe/vfdW9REHu56X
         mcLnE08jyxFx9X42Siix0XYESTPzgznzNy6sWwSq1EEv1rftL+Meo/0riaV5SHiZ7dvu
         cJJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlaiJeGn24ZMFwmMG79GJVfkqCvlk8B7hExyhQbucTYgYU8G5biyDMRs68Son+8g/Q03qR8iwu7tLuXaXSKiji9OygF/h4SjpkFsyC
X-Gm-Message-State: AOJu0YxHKKZYsE/Tw4JqiDgjU2MECXeplkyMbfJNpVx6vFzefq27Req8
	URUxNM2NcjlaO2ExYe4XOidy7MiYqZfb7MGP/iDKnMDkkaF/swHWYd4h0jo5+HAXuY0OiTT13dK
	9h++hgb/W5qRazKiTLf/Ch56dA/kgcnchZuN47G4qg6ASUEe8inPLuZ3kiLZ2cQ==
X-Received: by 2002:ac2:414e:0:b0:512:cc50:c3e0 with SMTP id c14-20020ac2414e000000b00512cc50c3e0mr1283294lfi.52.1711705914341;
        Fri, 29 Mar 2024 02:51:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzCIBkxIKVbMHIoPNaKtpwlibzeDnCCEzGl88sYaXjP+u7tE0mYtwUWm3GQccH/hMA1lWuvA==
X-Received: by 2002:ac2:414e:0:b0:512:cc50:c3e0 with SMTP id c14-20020ac2414e000000b00512cc50c3e0mr1283273lfi.52.1711705913698;
        Fri, 29 Mar 2024 02:51:53 -0700 (PDT)
Received: from redhat.com ([2.52.20.36])
        by smtp.gmail.com with ESMTPSA id y13-20020a5d4acd000000b00341e5f487casm3782337wrs.46.2024.03.29.02.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:51:53 -0700 (PDT)
Date: Fri, 29 Mar 2024 05:51:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Add reconnect process for VDUSE
Message-ID: <20240329054845-mutt-send-email-mst@kernel.org>
References: <20240329093832.140690-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329093832.140690-1-lulu@redhat.com>

On Fri, Mar 29, 2024 at 05:38:25PM +0800, Cindy Lu wrote:
> Add a document explaining the reconnect process, including what the
> Userspace App needs to do and how it works with the kernel.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  Documentation/userspace-api/vduse.rst | 41 +++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
> index bdb880e01132..f903aed714d1 100644
> --- a/Documentation/userspace-api/vduse.rst
> +++ b/Documentation/userspace-api/vduse.rst
> @@ -231,3 +231,44 @@ able to start the dataplane processing as follows:
>     after the used ring is filled.
>  
>  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> +
> +HOW VDUSE devices reconnectoin works

typo

> +------------------------------------
> +1. What is reconnection?
> +
> +   When the userspace application loads, it should establish a connection
> +   to the vduse kernel device. Sometimes,the userspace application exists,
> +   and we want to support its restart and connect to the kernel device again
> +
> +2. How can I support reconnection in a userspace application?
> +
> +2.1 During initialization, the userspace application should first verify the
> +    existence of the device "/dev/vduse/vduse_name".
> +    If it doesn't exist, it means this is the first-time for connection. goto step 2.2
> +    If it exists, it means this is a reconnection, and we should goto step 2.3
> +
> +2.2 Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> +    /dev/vduse/control.
> +    When ioctl(VDUSE_CREATE_DEV) is called, kernel allocates memory for
> +    the reconnect information. The total memory size is PAGE_SIZE*vq_mumber.
> +
> +2.3 Check if the information is suitable for reconnect
> +    If this is reconnection :
> +    Before attempting to reconnect, The userspace application needs to use the
> +    ioctl(VDUSE_DEV_GET_CONFIG, VDUSE_DEV_GET_STATUS, VDUSE_DEV_GET_FEATURES...)
> +    to get the information from kernel.
> +    Please review the information and confirm if it is suitable to reconnect.
> +
> +2.4 Userspace application needs to mmap the memory to userspace
> +    The userspace application requires mapping one page for every vq. These pages
> +    should be used to save vq-related information during system running. Additionally,
> +    the application must define its own structure to store information for reconnection.
> +
> +2.5 Completed the initialization and running the application.
> +    While the application is running, it is important to store relevant information
> +    about reconnections in mapped pages. When calling the ioctl VDUSE_VQ_GET_INFO to
> +    get vq information, it's necessary to check whether it's a reconnection. If it is
> +    a reconnection, the vq-related information must be get from the mapped pages.
> +


I don't get it. So this is just a way for the application to allocate
memory? Why do we need this new way to do it?
Why not just mmap a file anywhere at all?


> +2.6 When the Userspace application exits, it is necessary to unmap all the
> +    pages for reconnection
> -- 
> 2.43.0


