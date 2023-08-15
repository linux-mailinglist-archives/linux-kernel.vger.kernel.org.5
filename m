Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76F877D168
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbjHORxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238985AbjHORx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE9B1BDC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692121959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uEGcshSa7D7Rn4do1hXBlQcdMbZtjbdurCGpqlpyZdg=;
        b=VkZ0vRupOkEBzoAdFGpAFLx09GbYAai9KvaAbBepVRakeIfLhMCkx51A8A3PhCUiAlkBlg
        COZCOtQrU2yOqNTnzC2WREkvUgg47y6t2JQiDmmVUUroXcmB3twCvOmIwoIvuPqetToq4F
        LH95JTu/PXjOaOFPUiLNShHCtn2CQqI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9--wLl0LIPNR6GLO7m83wOOw-1; Tue, 15 Aug 2023 13:52:38 -0400
X-MC-Unique: -wLl0LIPNR6GLO7m83wOOw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3196e92c3f6so1278277f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692121957; x=1692726757;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEGcshSa7D7Rn4do1hXBlQcdMbZtjbdurCGpqlpyZdg=;
        b=TRA/QN0I1m0+oJsHNHfpPqxNzlW6M2zwdnaFZda9HnSCk2S6mqTBvxrothJfC0ZoV6
         EQ8w/ikMRIr7QV+SKwZeTpORjEgua5RaM3Aluv041aPfUZrnnbJ5W3QphVBgAsORJ2Ag
         175XH0MXMBNy858jwDYxDdwNxEYwHnJu1NB7J3DTT1oMB5ki342m8ZzfjbRlrY6cVa0v
         LqzkrLhAeph3Mz0AY8/9iDnN6w03zuEoeHR2t6kzMcy62mvUeSS+EADxz7ybAKPDlEg0
         Av9hUmTrHYYG7xeIdg/SKeu8P/yd7rVMSO1+YdEotlmDJC5EZPctZy4dMOyYFwsH7ps+
         z0Iw==
X-Gm-Message-State: AOJu0YyXQyjI0G4SLt4hNI+KXDcNMOxZHXk9Y4mdVuOV3dPKbraQRCi/
        xHiI0qykdfVhat66NUHJQ3i2RCYQ9mHkg6TNmRTDdLSfd0GyOLL4r3LlWSfQx1n2CmkLoGcr/m2
        lUHr8ykc+nhHKtHOIzrTt5zxc
X-Received: by 2002:a5d:6383:0:b0:314:2f3e:dca5 with SMTP id p3-20020a5d6383000000b003142f3edca5mr1722985wru.28.1692121957024;
        Tue, 15 Aug 2023 10:52:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQDdi7G9B96J6s6o7hiyqpnZECJnPgbHSp302wJcV59oqFBVab10uyDbfNC2BLosXV4Kk4CQ==
X-Received: by 2002:a5d:6383:0:b0:314:2f3e:dca5 with SMTP id p3-20020a5d6383000000b003142f3edca5mr1722977wru.28.1692121956649;
        Tue, 15 Aug 2023 10:52:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:3100:c642:ba83:8c37:b0e? (p200300cbc7013100c642ba838c370b0e.dip0.t-ipconnect.de. [2003:cb:c701:3100:c642:ba83:8c37:b0e])
        by smtp.gmail.com with ESMTPSA id m5-20020a056000008500b00317b063590fsm18700629wrx.55.2023.08.15.10.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 10:52:36 -0700 (PDT)
Message-ID: <57cd9256-1295-c797-5711-807732421063@redhat.com>
Date:   Tue, 15 Aug 2023 19:52:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] mm,thp: no space after colon in Mem-Info fields
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <dc264fd6-40bb-6510-db36-9340a5f01d94@google.com>
 <c1edd7da-5493-c542-6feb-92452b4dab3b@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c1edd7da-5493-c542-6feb-92452b4dab3b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.23 22:00, Hugh Dickins wrote:
> The SysRq-m or OOM Mem-Info dmesg showed (long lines containing)
> ... shmem:NkB shmem_thp: NkB shmem_pmdmapped: NkB anon_thp: NkB ...
> 
> Delete the space after the colon after shmem_thp, shmem_pmdmapped,
> anon_thp: as the shmem example shows, no other fields have a space
> after the colon in this output.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>   mm/show_mem.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/show_mem.c b/mm/show_mem.c
> index 09c7d036d49e..4b888b18bdde 100644
> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -251,9 +251,9 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
>   			" writeback:%lukB"
>   			" shmem:%lukB"
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -			" shmem_thp: %lukB"
> -			" shmem_pmdmapped: %lukB"
> -			" anon_thp: %lukB"
> +			" shmem_thp:%lukB"
> +			" shmem_pmdmapped:%lukB"
> +			" anon_thp:%lukB"
>   #endif
>   			" writeback_tmp:%lukB"
>   			" kernel_stack:%lukB"

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

