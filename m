Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335AD81085F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378349AbjLMCsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378325AbjLMCr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:47:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DEBA6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702435683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dDe3Xx994EAr7fXMmd7lwT7nn7a4sVje/xUjU4I8WuA=;
        b=Ai45uxPpCRi6eKRxeB9qk24PNUHhqFo3cgyGYaSkIyJqxRMnjwtkDt56YZ9DDuu8DraxH9
        qpS6pvRj1rhGIcKyVin5gUcFbmbaacERd8QF5DN6tdYGX0QikEPelizPlrowPS/fUocQ7j
        ebAgDiSLNETTuCmkHhA0JBlJMycc2dA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-MWXzzuQbPDKUI1J342W0UA-1; Tue, 12 Dec 2023 21:47:57 -0500
X-MC-Unique: MWXzzuQbPDKUI1J342W0UA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6001185A781;
        Wed, 13 Dec 2023 02:47:56 +0000 (UTC)
Received: from localhost (unknown [10.72.116.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BBD285190;
        Wed, 13 Dec 2023 02:47:55 +0000 (UTC)
Date:   Wed, 13 Dec 2023 10:47:52 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] x86/kexec: Simplify the logic of mem_region_callback()
Message-ID: <ZXkbWMzCsU5S5szm@MiWiFi-R3L-srv>
References: <20231212150506.31711-1-ytcoode@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212150506.31711-1-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 at 11:05pm, Yuntao Wang wrote:
> The expression `mstart + resource_size(res) - 1` is actually equivalent to
> `res->end`, simplify the logic of this function to improve readability.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 1a3e2c05a8a5..6f8df998890e 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -42,12 +42,9 @@ struct init_pgtable_data {
>  static int mem_region_callback(struct resource *res, void *arg)
>  {
>  	struct init_pgtable_data *data = arg;
> -	unsigned long mstart, mend;
> -
> -	mstart = res->start;
> -	mend = mstart + resource_size(res) - 1;
>  
> -	return kernel_ident_mapping_init(data->info, data->level4p, mstart, mend);
> +	return kernel_ident_mapping_init(data->info, data->level4p,
> +					 res->start, res->end);
>  }
>  
>  static int
> -- 
> 2.43.0
> 

