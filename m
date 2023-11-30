Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A4D7FE64C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344009AbjK3BlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjK3BlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:41:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F68495
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701308478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A+mAc5bUWQHIfKcRKPqP2W6po7z2iVLf+97SiNfRjUQ=;
        b=D2iM4iNVuq9+AjEa++FkIofH5+QmayMn/cMIOXMTh3D7T95aL+GVTcp35iHPPhmbgXpRWI
        IT9Bowr+seSAReXe9OFlc2toN45Sf80DKAnYFtA7T/W4ld+BTGuotd2moQ8enmudqJbQyM
        X+v+jfHaUKp35usdr2l6//zpO7haJ8o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-tegoFPWqOWuDru5oX104Rg-1; Wed,
 29 Nov 2023 20:41:16 -0500
X-MC-Unique: tegoFPWqOWuDru5oX104Rg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3ACCF29AA3BF;
        Thu, 30 Nov 2023 01:41:16 +0000 (UTC)
Received: from localhost (unknown [10.72.113.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 881A6112130B;
        Thu, 30 Nov 2023 01:41:15 +0000 (UTC)
Date:   Thu, 30 Nov 2023 09:41:12 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        eric_devolder@yahoo.com, agordeev@linux.ibm.com,
        kernel-team@cloudflare.com, stable@vger.kernel.org
Subject: Re: [PATCH] kexec: drop dependency on ARCH_SUPPORTS_KEXEC from
 CRASH_DUMP
Message-ID: <ZWfoOLEnS+TnikpA@MiWiFi-R3L-srv>
References: <20231129220409.55006-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129220409.55006-1-ignat@cloudflare.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 at 10:04pm, Ignat Korchagin wrote:
> In commit f8ff23429c62 ("kernel/Kconfig.kexec: drop select of KEXEC for
> CRASH_DUMP") we tried to fix a config regression, where CONFIG_CRASH_DUMP
> required CONFIG_KEXEC.
> 
> However, it was not enough at least for arm64 platforms. While further testing
> the patch with our arm64 config I noticed that CONFIG_CRASH_DUMP is unavailable
> in menuconfig. This is because CONFIG_CRASH_DUMP still depends on the new
> CONFIG_ARCH_SUPPORTS_KEXEC introduced in commit 91506f7e5d21 ("arm64/kexec:
> refactor for kernel/Kconfig.kexec") and on arm64 CONFIG_ARCH_SUPPORTS_KEXEC
> requires CONFIG_PM_SLEEP_SMP=y, which in turn requires either CONFIG_SUSPEND=y
> or CONFIG_HIBERNATION=y neither of which are set in our config.
> 
> Given that we already established that CONFIG_KEXEC (which is a switch for kexec
> system call itself) is not required for CONFIG_CRASH_DUMP drop
> CONFIG_ARCH_SUPPORTS_KEXEC dependency as well. The arm64 kernel builds just fine
> with CONFIG_CRASH_DUMP=y and with both CONFIG_KEXEC=n and CONFIG_KEXEC_FILE=n
> after f8ff23429c62 ("kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP")
> and this patch are applied given that the necessary shared bits are included via
> CONFIG_KEXEC_CORE dependency.
> 
> Fixes: 91506f7e5d21 ("arm64/kexec: refactor for kernel/Kconfig.kexec")
> Cc: stable@vger.kernel.org # 6.6+: f8ff234: kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
> Cc: stable@vger.kernel.org # 6.6+
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---
>  kernel/Kconfig.kexec | 1 -
>  1 file changed, 1 deletion(-)

This is a good catch, thanks.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index fc38f1ae3a30..946dffa048b7 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -96,7 +96,6 @@ config KEXEC_JUMP
>  config CRASH_DUMP
>  	bool "kernel crash dumps"
>  	depends on ARCH_SUPPORTS_CRASH_DUMP
> -	depends on ARCH_SUPPORTS_KEXEC
>  	select CRASH_CORE
>  	select KEXEC_CORE
>  	help
> -- 
> 2.39.2
> 

