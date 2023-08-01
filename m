Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D0C76A6DB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjHACQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHACQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:16:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E195E5C;
        Mon, 31 Jul 2023 19:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=k/FrXh/THAB5ueNYpFa+DtWLKwB8v/g7kBddjVkmREY=; b=ho7cwcSoealjW606BJo530kKgt
        XEUNVH8f1Jjy9VMmO6MzmygNyaxNtutK6gEGLuMfO7nLQK74IxEHYRcufBlmo+K2nJG2545xsctRM
        OGduqz8m1jy/KSBORvjKB51ymqOlBQe5YrU3IzbMzH57HR3HpQJ5u5sxhiS48iQpVOzRMKPrl4ArT
        RlA3TdLkYZAxQp2pavftZoRXgVfYC5oOMpZ1jgUkfY/SXw3CuME54IT3XZtJl0It2+4j6QhvSPmhJ
        Vt9erlupCLsJdrFSVnuOAz4jvtcXgD8J5ieclD6269b7DwiW9AUhbYK2c/gC/pDyI99gG47VeLKFT
        xHLiHY7w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQevc-000BnJ-0B;
        Tue, 01 Aug 2023 02:16:04 +0000
Message-ID: <57c5ba80-bc87-e76a-98f1-5f8043711b0a@infradead.org>
Date:   Mon, 31 Jul 2023 19:16:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] s390/certstore: select CRYPTO_LIB_SHA256
Content-Language: en-US
To:     Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-next@vger.kernel.org,
        Anastasia Eskova <anastasia.eskova@ibm.com>
References: <20230728100430.1567328-1-svens@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230728100430.1567328-1-svens@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/23 03:04, Sven Schnelle wrote:
> A build failure was reported when sha256() is not present:
> 
> gcc-13.1.0-nolibc/s390-linux/bin/s390-linux-ld: arch/s390/kernel/cert_store.o: in function `check_certificate_hash':
> arch/s390/kernel/cert_store.c:267: undefined reference to `sha256'
> 
> Therefore make CONFIG_CERT_STORE select CRYPTO_LIB_SHA256.
> 
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/all/8ecb57fb-4560-bdfc-9e55-63e3b0937132@infradead.org/
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

Sorry for the delay.

Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/s390/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index d9d50a7a2016..18bf754e1fad 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -516,6 +516,7 @@ config KEXEC_SIG
>  config CERT_STORE
>  	bool "Get user certificates via DIAG320"
>  	depends on KEYS
> +	select CRYPTO_LIB_SHA256
>  	help
>  	  Enable this option if you want to access user-provided secure boot
>  	  certificates via DIAG 0x320.

-- 
~Randy
