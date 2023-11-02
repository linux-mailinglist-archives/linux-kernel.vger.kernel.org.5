Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C447DF997
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344990AbjKBSKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjKBSKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:10:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E07F1BD9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698948369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nD8lh0J8JiWJ+kvt0KJ7RLOjVJvmjV+qsIu+YAgB6DM=;
        b=aINcxVMRE3np9F4EWH5RmUBot/jqDSg1QaXg/rVWADCQNqvjKcWblVsRVW2p2y1ie3EE3b
        3sR385BRPCi7KSYzKpDGt/Vc1cSNGYpwPw+ZaEsbziUCcj9BF0klrXXcKjSp16KddyKraA
        PcsrLj+3+XOKV02uoSEzjeUbQnQaUUE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-byqEuzz2PuSpyklDQ6HWLA-1; Thu, 02 Nov 2023 14:06:06 -0400
X-MC-Unique: byqEuzz2PuSpyklDQ6HWLA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40839252e81so7982015e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948365; x=1699553165;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nD8lh0J8JiWJ+kvt0KJ7RLOjVJvmjV+qsIu+YAgB6DM=;
        b=vsuWV60Y3G9eXNo+X/oqr+wYuL0wAqEn0KlGvy2AdENTzqFEkiWKvJpwFvriYvXgP9
         9IgqkDccRKfNqIUdVUyASiSfVbrGYl97aFj3y+W8g3N2/7/K+7bRIwZKuAo0fFu9vUlX
         Wnk+8HmuXZcbAeoKHKy/D5RcXT08FYsZWh8cQWmiK1MOjBlj/06hVCgT9/YnwTvdzYyO
         fc/Uy3XLHtMHmvQmokpL6UmWap9Hj8QPAcb7JmFVTZBv9xNp3/239gVrK25J4AuFygpL
         IplkXtR4bUIHqmkXc5BMkbi5rCA1+dlXiywR2AUI08/shbAlrGTRGkzFVnx1Fw/WL5zI
         IbWg==
X-Gm-Message-State: AOJu0YyQTK8goDZDebwE8TlouabRvM1wpkH7rcgIagG6j2Il0lgS/49z
        6VIaQZAAHDVvcZp0dItlxzzwZ6HFYKtfsDXcjYMLxHc7UqzNb5uqTMwI+7/S6RsNqoA6lR+6dtk
        JUh7p+8GJAxyHrnbuYk+wiLLK
X-Received: by 2002:a05:600c:acc:b0:401:bdd7:49ae with SMTP id c12-20020a05600c0acc00b00401bdd749aemr17206729wmr.18.1698948365144;
        Thu, 02 Nov 2023 11:06:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUfpY3pn466g3IG4+RPvgHe7nNa/Hy9VJNg9r7eUGZ4RAmCjMw5LPHpYlEp269Vaogh4yBnA==
X-Received: by 2002:a05:600c:acc:b0:401:bdd7:49ae with SMTP id c12-20020a05600c0acc00b00401bdd749aemr17206702wmr.18.1698948364781;
        Thu, 02 Nov 2023 11:06:04 -0700 (PDT)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id bh27-20020a05600c3d1b00b004063d8b43e7sm3649100wmb.48.2023.11.02.11.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:06:04 -0700 (PDT)
Message-ID: <e87c077a463f13b3c71bfc4e09493e4751aaa563.camel@redhat.com>
Subject: Re: [PATCH 4/9] KVM: SVM: Rename vmplX_ssp -> plX_ssp
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     John Allen <john.allen@amd.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        weijiang.yang@intel.com, rick.p.edgecombe@intel.com,
        seanjc@google.com, x86@kernel.org, thomas.lendacky@amd.com,
        bp@alien8.de
Date:   Thu, 02 Nov 2023 20:06:02 +0200
In-Reply-To: <20231010200220.897953-5-john.allen@amd.com>
References: <20231010200220.897953-1-john.allen@amd.com>
         <20231010200220.897953-5-john.allen@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-10 at 20:02 +0000, John Allen wrote:
> Rename SEV-ES save area SSP fields to be consistent with the APM.
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  arch/x86/include/asm/svm.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 19bf955b67e0..568d97084e44 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -361,10 +361,10 @@ struct sev_es_save_area {
>  	struct vmcb_seg ldtr;
>  	struct vmcb_seg idtr;
>  	struct vmcb_seg tr;
> -	u64 vmpl0_ssp;
> -	u64 vmpl1_ssp;
> -	u64 vmpl2_ssp;
> -	u64 vmpl3_ssp;
> +	u64 pl0_ssp;
> +	u64 pl1_ssp;
> +	u64 pl2_ssp;
> +	u64 pl3_ssp;
>  	u64 u_cet;
>  	u8 reserved_0xc8[2];
>  	u8 vmpl;

Matches the APM.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

