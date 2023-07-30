Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7478768364
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 03:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjG3BuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 21:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG3BuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 21:50:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA6A2134;
        Sat, 29 Jul 2023 18:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=NbwbCQT8KMNRIPvq+q9lapcQ2h0sWsXj0fj9zqMOVKI=; b=O3JWKw4XNWjyAbDPQmLJilCOgX
        eCSDsaDMyaSYoP1ehB6ebHPhygQWZsuv/uXlyeuu2uLa1dyCtL/nWtdlrNuKUsRDkW+fNQoWxYLPB
        eyEmWr94Eqj5+vKictOKFtZM40gWI9jyNgbrEZY0WUnck1Z9MVyhmT8mmqNT0u7Ay+MGs9boK7eV5
        +U885x4QsoQ9LaKaL36Al+sdqfhHvpSWDx+nHrfc+1BlHXcPvW7hRD0sAq0tfXC2n2A/05KKzF+Ee
        9ZzZpNYDBYq95yoP+VGJPBQAflx5UPkEJ1L+zv35zRvS73LPNF6DRK2Qrd8fY2CwSJT+B1SUCtPOy
        rcVDzpmQ==;
Received: from [2601:1c2:980:9ec0:e65e:37ff:febd:ee53]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qPvZI-009Xez-06;
        Sun, 30 Jul 2023 01:50:00 +0000
Message-ID: <1c4b9496-2ac3-d271-0ef9-0c0979da55ae@infradead.org>
Date:   Sat, 29 Jul 2023 18:49:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] alpha: remove __init annotation from exported
 page_is_ram()
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Chen Gong <gong.chen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20230729074223.1457109-1-masahiroy@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230729074223.1457109-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/23 00:42, Masahiro Yamada wrote:
> EXPORT_SYMBOL and __init is a bad combination because the .init.text
> section is freed up after the initialization.
> 
> Commit c5a130325f13 ("ACPI/APEI: Add parameter check before error
> injection") exported page_is_ram(), hence the __init annotation should
> be removed.
> 
> This fixes the modpost warning in ARCH=alpha builds:
> 
>   WARNING: modpost: vmlinux: page_is_ram: EXPORT_SYMBOL used for init symbol. Remove __init or EXPORT_SYMBOL.
> 
> Fixes: c5a130325f13 ("ACPI/APEI: Add parameter check before error injection")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
>  arch/alpha/kernel/setup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
> index b650ff1cb022..3d7473531ab1 100644
> --- a/arch/alpha/kernel/setup.c
> +++ b/arch/alpha/kernel/setup.c
> @@ -385,8 +385,7 @@ setup_memory(void *kernel_end)
>  #endif /* CONFIG_BLK_DEV_INITRD */
>  }
>  
> -int __init
> -page_is_ram(unsigned long pfn)
> +int page_is_ram(unsigned long pfn)
>  {
>  	struct memclust_struct * cluster;
>  	struct memdesc_struct * memdesc;

-- 
~Randy
