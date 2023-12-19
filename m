Return-Path: <linux-kernel+bounces-4671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF42E81807A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D326B233BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5108C158;
	Tue, 19 Dec 2023 04:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QT669H8b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BF96FB4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702959753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Igax5UgIuAw00YDf5GDEbl6lhbS7QUhnxvUBz1O2KrM=;
	b=QT669H8biv0ramN14eSOZuXyDzIzRLRtBx3s3FQRscjsw2lNa6jhWHljzkx/AW9rqMN7/3
	iir0xDQ/n32l3lB7jVTy0/9J/d0V+6rDxmREPrpQTnTCH0Aq1H70eCjXbhFbCErFa9zVgs
	UZKi82vE6kpMkHtieb6zHkhZaM9gVOI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-GwesIK5LNZ-Romlg7SDN4A-1; Mon,
 18 Dec 2023 23:22:29 -0500
X-MC-Unique: GwesIK5LNZ-Romlg7SDN4A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BB573813F22;
	Tue, 19 Dec 2023 04:22:28 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F16F6492BF0;
	Tue, 19 Dec 2023 04:22:26 +0000 (UTC)
Date: Tue, 19 Dec 2023 12:22:22 +0800
From: Baoquan He <bhe@redhat.com>
To: James Gowans <jgowans@amazon.com>, akpm@linux-foundation.org
Cc: Eric Biederman <ebiederm@xmission.com>,
	Sean Christopherson <seanjc@google.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Pavel Machek <pavel@ucw.cz>,
	Sebastian Reichel <sre@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>, Alexander Graf <graf@amazon.de>,
	"Jan H . Schoenherr" <jschoenh@amazon.de>
Subject: Re: [PATCH] kexec: do syscore_shutdown() in kernel_kexec
Message-ID: <ZYEafpms++a3a8ch@MiWiFi-R3L-srv>
References: <20231213064004.2419447-1-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213064004.2419447-1-jgowans@amazon.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Add Andrew to CC as Andrew helps to pick kexec/kdump patches.

On 12/13/23 at 08:40am, James Gowans wrote:
......
> This has been tested by doing a kexec on x86_64 and aarch64.

Hi James,

Thanks for this great patch. My colleagues have opened bug in rhel to
track this and try to veryfy this patch. However, they can't reproduce
the issue this patch is fixing. Could you tell more about where and how
to reproduce so that we can be aware of it better? Thanks in advance.

Thanks
Baoquan

> 
> Fixes: 6735150b6997 ("KVM: Use syscore_ops instead of reboot_notifier to hook restart/shutdown")
> 
> Signed-off-by: James Gowans <jgowans@amazon.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Alexander Graf <graf@amazon.de>
> Cc: Jan H. Schoenherr <jschoenh@amazon.de>
> ---
>  kernel/kexec_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index be5642a4ec49..b926c4db8a91 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1254,6 +1254,7 @@ int kernel_kexec(void)
>  		kexec_in_progress = true;
>  		kernel_restart_prepare("kexec reboot");
>  		migrate_to_reboot_cpu();
> +		syscore_shutdown();
>  
>  		/*
>  		 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


