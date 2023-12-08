Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1D0809753
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjLHAh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHAh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:37:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CE11710
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=0dMr3UkO/xZ14hLIkPHKwGl9vSnEwn8/Nn738r3Lcgo=; b=qsvGsWdRMG1IFVegIsanG0fYJO
        /SQY4qU3xmZIbFEXhrl3Btn9cqxxrP+HdKEDSQmMyMsAvMj4iJDSkE+KF2HTt1X2RcZHezwu9C8q8
        C3K9psZNYFrD3Qbqwv4Ymd+XtztubvEYmxPIiZ4mvvqZb8Kas+0GmxwbVthEC8kJMM4YnDuNe6zm0
        tt9iSTEoAH4Taqtb8ubeB7ZmNFV47wZaFVLiVjFF6+oEUHgB8W7emCI6nYTyGpmnb42KjB6KITTzK
        Br5AlfG43qTLE0rSPikQrbxcpXJj/Fbmm/KzBBhBepb74VjWCD4YW3UKLX84YNo+eIB9RIrqLKDNn
        OvXqdUBA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rBOrv-00ELI9-0l;
        Fri, 08 Dec 2023 00:37:28 +0000
Message-ID: <926cddcc-2604-4d88-b9c9-91ad1d148c6c@infradead.org>
Date:   Thu, 7 Dec 2023 16:37:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs3: align struct ATTR_LIST_ENTRY
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231207142838.960725-1-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231207142838.960725-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/23 06:28, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On architectures like i386 that don't enforce natural alignment of u64
> struct members, so the recent change to remove the final 48 bits
> reduced the structure size from 32 to 28 bytes:
> 
> include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct ATTR_LIST_ENTRY) == 0x20"
> fs/ntfs3/ntfs.h:530:1: note: in expansion of macro 'static_assert'
>   530 | static_assert(sizeof(struct ATTR_LIST_ENTRY) == 0x20);
>       | ^~~~~~~~~~~~~
> 
> Add an alignment attribute that makes the structure the same across
> all architectures again.
> 
> Fixes: d155617006eb ("fs/ntfs3: Fix detected field-spanning write (size 8) of single field "le->name"")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  fs/ntfs3/ntfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
> index c8981429c721..2d409ac94cbb 100644
> --- a/fs/ntfs3/ntfs.h
> +++ b/fs/ntfs3/ntfs.h
> @@ -525,7 +525,7 @@ struct ATTR_LIST_ENTRY {
>  	__le16 id;		// 0x18: struct ATTRIB ID.
>  	__le16 name[];		// 0x1A: To get real name use name_off.
>  
> -}; // sizeof(0x20)
> +} __aligned((8)); // sizeof(0x20)
>  
>  static_assert(sizeof(struct ATTR_LIST_ENTRY) == 0x20);
>  

-- 
~Randy
