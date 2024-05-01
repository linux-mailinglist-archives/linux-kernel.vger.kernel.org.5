Return-Path: <linux-kernel+bounces-165756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EADBF8B90A7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F1928128D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC0F13049E;
	Wed,  1 May 2024 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M47hYE5V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AEA1527B2
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714595650; cv=none; b=D5T0x84JakqUqZQ/Uh6+oKFz+UcHv6U0KTUyc0Ufn0Z6haRE/oJfnp0vY8Yb7iSTaYRMpKHy7v3IF1jPcrKp2oKHCnSQrt84Wtyk44VT8CRYTZEAeTITTSfWmeGKUEt/K1NKICRUgTq5NXhvlkJb2nTYI8KsGYzpWVdz0RETOPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714595650; c=relaxed/simple;
	bh=S4gMc9PYohtS7iDz9js+1MOi4xx9ihe0CPuKY0C7z18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goWdxeICIFiYe+uUgsOsRF6E940PngVHIn8qZINyMVUZU1HOgGpygu9GHBwR4CBGOmpiWPGxRXNIcos3tW85eGJO1704LSvyUQS5RjLQjyWkF1Vp+ktxI4MbnE+pvKkFRIhJVamNeEhw7sanq7Htfxi5jvnY91k/HnhtN14BqPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M47hYE5V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714595647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LdDh7oUGAbyt9urk+32PtF3HqHzbC4XDQfWRXcpyWD8=;
	b=M47hYE5VsyW/dlwAUM44OIecXwKRIRl07stitwGC2CqqDo/CXrWnYWnAwJQjUenNSZbXVA
	UZslMIalawobtSwei6WGwFzNIZQv9Tb7sDIUDHnFoEyu963/p9PkZ3y/Gu3Y85cPVNJuPO
	4OqJrI4UxgtL14P++hXLVKbdRKWA124=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-PcM4DLGVPO21wtJhRXY4wQ-1; Wed, 01 May 2024 16:34:05 -0400
X-MC-Unique: PcM4DLGVPO21wtJhRXY4wQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a52539e4970so461156466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 13:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714595644; x=1715200444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdDh7oUGAbyt9urk+32PtF3HqHzbC4XDQfWRXcpyWD8=;
        b=VpL4kFZpvvipO3x6t+dWQP6gm/Ys7fz/vkO8LluOY6i/x27BdXXSKbjo0U/nCCtYsE
         NHx4NP5G1cyZNyTVWydgwPXsF95AA53vdaRe97WOUMsJ04ld8icZNHklwZoPcr8wFn3z
         l8TULSHFMM9osgPrPVY8LSedl37HbMfnpZzEZe1A5jPB3fDtJjRCodyrVsmpFYoxC0et
         ITumkYqIcZd/qOEfqF/e4mP06mycz/Cq5Iy/2RZEbjORXquf2mQRXaN/fC2++7Q4Pek9
         EwJaOY4P8MwxFbgdk7eKaEfEazQcfw7DHLKgNYOEiNUBLYOBvqyQUwVG9cYBG1q6Sn3k
         KmZg==
X-Forwarded-Encrypted: i=1; AJvYcCWrbRqI85HDF85jjL4mrudZppcJJG8b3Sx8hLbBPMJu3Qkhtwttxz1vnhlpgY3FbpRLU7Q8zOSf+L7QqFbjH6IaFmWn/ePVDp8DkhAe
X-Gm-Message-State: AOJu0Yxb2rhOCKYsDC4oeoojtmaQY2UYTpadwlAVQeGh4OW+WS14Anzh
	oQx1NB0e2hXt+bNKLXBTrlWGxYsgbzNTsItNY6ToxBEbq9AIH5L64ZHg5EfxV2sA8jZULffMI1b
	EAujx6gjxcP+AP2j3V/GKig8XWCg2wCmNv/ymS4Pl99/fZiWUzgTbDDfgbP46vg==
X-Received: by 2002:a17:906:f9c8:b0:a58:bdfb:f824 with SMTP id lj8-20020a170906f9c800b00a58bdfbf824mr2094415ejb.43.1714595644218;
        Wed, 01 May 2024 13:34:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0fj8cf4Xu4OUildOjXwDDrW79g0W5KCW7k9+WTeJiTKlpmW6rq8Bd/l5mGuEZJo2yfltfQA==
X-Received: by 2002:a17:906:f9c8:b0:a58:bdfb:f824 with SMTP id lj8-20020a170906f9c800b00a58bdfbf824mr2094405ejb.43.1714595643656;
        Wed, 01 May 2024 13:34:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:6a42:bb79:449b:3f0b:a228])
        by smtp.gmail.com with ESMTPSA id j18-20020a1709062a1200b00a557616395csm16227433eje.85.2024.05.01.13.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:34:02 -0700 (PDT)
Date: Wed, 1 May 2024 16:33:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read
 in vhost_task_fn
Message-ID: <20240501163247-mutt-send-email-mst@kernel.org>
References: <000000000000a9613006174c1c4c@google.com>
 <tencent_546DA49414E876EEBECF2C78D26D242EE50A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_546DA49414E876EEBECF2C78D26D242EE50A@qq.com>

On Tue, Apr 30, 2024 at 05:31:47PM +0800, Edward Adam Davis wrote:
> please test uaf in vhost_task_fn
> 
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git bb7a2467e6be
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 48c289947b99..8800f5acc007 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -61,8 +61,8 @@ static int vhost_task_fn(void *data)
>  		set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
>  		vtsk->handle_sigkill(vtsk->data);
>  	}
> -	complete(&vtsk->exited);
>  	mutex_unlock(&vtsk->exit_mutex);
> +	complete(&vtsk->exited);
>  
>  	do_exit(0);
>  }


OK so if rebased on latest master by linus then this patch is
sufficient. I squashed it in. Edward, thanks a lot for working
on this! I added Suggested-by tag if you like me to add your
S.O.B too I can do this.


