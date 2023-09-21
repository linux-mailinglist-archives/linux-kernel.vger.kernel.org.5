Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A12E7AA1D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjIUVHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjIUVFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D4B86E40
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695317889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OOwzuFe78Vbuyug87izQRXFFJhV23TSLZTUmERr8ACI=;
        b=hsRVn1iAQpdVd/JDXVNC/d1QoQLsTPWoDsqOuvYtxSxCymv6lq7q5Z90w1PZg/ywbHniVr
        WuN/JJu6uvtmc18+ozwAwKmwCw9u8oM2Tv2qgd6XngbnaXntRX1i3qfMdoouKmnWwosQp3
        gX91kx9Rc2CyEd4q+K9zPTW8E5Rwh9g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-v1DoxTgMPZ-7gRrLx5iIqA-1; Thu, 21 Sep 2023 10:21:41 -0400
X-MC-Unique: v1DoxTgMPZ-7gRrLx5iIqA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-502d58d14beso1447044e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 07:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695306100; x=1695910900;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOwzuFe78Vbuyug87izQRXFFJhV23TSLZTUmERr8ACI=;
        b=ND/ZcBk/ovt8NinzbAcnGNpcAMV4MDWM+E25G2ESp6CEV1rbqSGggDP176jbBbKC/R
         znWe5D2V7nQ70kOSEnA7p8qogKcvn/bNexYUAn/hhn5DWTcgGBUHcabtHTkzCBk//mKK
         f/E/azw/wc/KtDcT0RjQ7MPjyo1xenS126Ns9+INkDZjsvCq6BPLlcozQU+QW8rY/KIS
         de9PhWqXZfRJIX1koW3rrDujEeOodrgczD3GEdog8w2z0fbH3rIVi3rtmmEkcBFWtCaB
         wS5zANuC3SfkCAkd5IFtscyhR0IjD1ImVnrQiE3fDnonmNVILAr4qKfMD9wmnn91S/6h
         1u5A==
X-Gm-Message-State: AOJu0YynBuyWDgIsvdULnXxERoqZS2B9k+t8Zh0sUA+URkhZwwyB/iUy
        PwtWuFWXAiZ883kd/7D0dmDhVkrE4ur3jmXNElOSDXUf8/Rrgk/QQA4mgzAxyzWd+dNkKq7V3dN
        0awegepfqN7abeH18dFpiFaj/qAQP4wHO
X-Received: by 2002:a05:6512:3ca6:b0:502:e651:129b with SMTP id h38-20020a0565123ca600b00502e651129bmr6905108lfv.19.1695306100162;
        Thu, 21 Sep 2023 07:21:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwy9Bm1IMREXwYw+IfTctkQhUlEOehm320GrGrs1Q8R4k4xZkWr3mKW2Q8KTCgOLnlB12CYA==
X-Received: by 2002:a7b:ce91:0:b0:3fe:4548:1892 with SMTP id q17-20020a7bce91000000b003fe45481892mr5090253wmj.16.1695306079163;
        Thu, 21 Sep 2023 07:21:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:3c00:9eab:fce5:e6f3:e626? (p200300cbc70d3c009eabfce5e6f3e626.dip0.t-ipconnect.de. [2003:cb:c70d:3c00:9eab:fce5:e6f3:e626])
        by smtp.gmail.com with ESMTPSA id f18-20020a7bc8d2000000b00401d8181f8bsm4919880wml.25.2023.09.21.07.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 07:21:18 -0700 (PDT)
Message-ID: <90d76803-9e77-516d-83ac-99233cbd43f1@redhat.com>
Date:   Thu, 21 Sep 2023 16:21:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] riscv/mm: Fix the comment for swap pte format
Content-Language: en-US
To:     Xiao Wang <xiao.w.wang@intel.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230921141652.2657054-1-xiao.w.wang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230921141652.2657054-1-xiao.w.wang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.09.23 16:16, Xiao Wang wrote:
> Swap type takes bits 7-11 and swap offset should start from bit 12.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>   arch/riscv/include/asm/pgtable.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index e05b5dc1f0cb..e94a2998e81e 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -812,7 +812,7 @@ extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>    *	bit            5:	_PAGE_PROT_NONE (zero)
>    *	bit            6:	exclusive marker
>    *	bits      7 to 11:	swap type
> - *	bits 11 to XLEN-1:	swap offset
> + *	bits 12 to XLEN-1:	swap offset
>    */
>   #define __SWP_TYPE_SHIFT	7
>   #define __SWP_TYPE_BITS		5

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

