Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC5F75423C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbjGNSGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbjGNSGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:06:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DA63AA0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:06:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16CFE61D92
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 17:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B27CC433CA;
        Fri, 14 Jul 2023 17:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1689357263;
        bh=fdVkW64IxxcF8DxXW9FKwBOs41Z3K3ZO+58rMAhgv6Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t3yNB4qUTKucGZQRMmAXccb95B8Olhm45qBpLUz1VrWdfUHo1tjZCy4i9zXgjnWpC
         1vhw2g687TfMz+I9p2nejpK51vcLdPW+gLHJJLWAD2K9o+TGXmn1TJlwGA1gWZ+SZV
         Ey/qB0hHRQTn+ERdMEB/mLRBzhXmJCK0DQFC+BjA=
Date:   Fri, 14 Jul 2023 10:54:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/page_ext: remove rollback for untouched
 mem_section in online_page_ext
Message-Id: <20230714105422.648d17f9ba6141f26e469423@linux-foundation.org>
In-Reply-To: <20230714114749.1743032-3-shikemeng@huaweicloud.com>
References: <20230714114749.1743032-1-shikemeng@huaweicloud.com>
        <20230714114749.1743032-3-shikemeng@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 19:47:48 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:

> If init_section_page_ext failed, we only need rollback for mem_section
> before failed mem_section. Make rollback end point to failed mem_section
> to remove unnecessary rollback.
> 
> As pfn += PAGES_PER_SECTION will be executed even if init_section_page_ext
> failed. So pfn points to mem_section after failed mem_section. Subtract
> one mem_section from pfn to get failed mem_section.
> 
> ...
>
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -424,6 +424,7 @@ static int __meminit online_page_ext(unsigned long start_pfn,
>  		return 0;
>  
>  	/* rollback */
> +	end = pfn - PAGES_PER_SECTION;
>  	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION)
>  		__free_page_ext(pfn);
>  

This is a bugfix, yes?

I guess init_section_page_ext() never fails for anyone...
