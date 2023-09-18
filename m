Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77F87A4872
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbjIRLbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241781AbjIRLbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B96C10F8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695036524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g16afrB/IJtgdcRXAAX+biTwSfPDIbTu9JzJpZbPHVU=;
        b=DiMe6sf058tjs/Dh/oOH2+BaIUU2R2lbjYEonINWpbWecRUeQB1MlUrhtS7fRLAOpAXYJt
        PhRVGadAEA9fxu8aP8D8ZgnTvJjyCplFtppzD7WDWekEO3kfqSuNT++tDvrG4hfHk10JjF
        gGIb9HEZ683UGygRUVJ2BP+9njLZOVY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-r0J7pLs_P_KDCwSllV9BGw-1; Mon, 18 Sep 2023 07:28:41 -0400
X-MC-Unique: r0J7pLs_P_KDCwSllV9BGw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-402d63aeea0so34587985e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695036520; x=1695641320;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g16afrB/IJtgdcRXAAX+biTwSfPDIbTu9JzJpZbPHVU=;
        b=uq2/E3feE+tydO87roIXT8kPJ0czmCHj2RzLHD2J8S4yq2kzkLwbuI1VQY3wbH8ZzB
         oZ7CEQxmweHpQeSrH3VtVWW+8RnAKa0MnCdiOvg0pkU7SWtAc4rTc15dckqBupxuOfb9
         TUNx9Fs4pnz9BU0FYVitlg2N4XMjB9QXvgzu/67hu+DoGP9/y+gGvjOU0PvrccgTcjlV
         iiLONNzGx0RdLgoRciInVxWN187LRL9WNOD7O6b3T4vDKNFxnemBOsgXuYfYm3+kbt7H
         1a3ni6z6hq2V0U3cR4/4cVTfG7mGFUwkvFazGcY5pHJi42ZeWNSkelIH0Wn7GKuKAHXK
         v2mw==
X-Gm-Message-State: AOJu0YxWFJyxhJHX+QTKB0rUbdoow8cxhBD3JPwXmlKleTEPTQQ33cs7
        rgYmUcDOseKsHcy4ja5Q0aRLR5lHJpVvCrfMUJp5uxyU7u6bIxxKRcCupiqiir14+EQ/MGA66H6
        z3WesPSMjvDzuD9Yo81meUxydcwX+Gy36
X-Received: by 2002:a05:6000:1370:b0:31f:ec91:39a3 with SMTP id q16-20020a056000137000b0031fec9139a3mr7383701wrz.30.1695036520093;
        Mon, 18 Sep 2023 04:28:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOSf0N7WbbxmutDM7t75az3Pq6wxCxLXgIvIncstTy6b6v3Un6bzJ0GpwGs8RRhI/tO+BE3g==
X-Received: by 2002:a05:6000:1370:b0:31f:ec91:39a3 with SMTP id q16-20020a056000137000b0031fec9139a3mr7383685wrz.30.1695036519712;
        Mon, 18 Sep 2023 04:28:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:3400:ec51:7a3a:274e:cbee? (p200300cbc74b3400ec517a3a274ecbee.dip0.t-ipconnect.de. [2003:cb:c74b:3400:ec51:7a3a:274e:cbee])
        by smtp.gmail.com with ESMTPSA id w4-20020a5d5444000000b0031f3b04e7cdsm12205388wrv.109.2023.09.18.04.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 04:28:39 -0700 (PDT)
Message-ID: <aee51f0c-8cf1-d893-c111-e3aa93de2af9@redhat.com>
Date:   Mon, 18 Sep 2023 13:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 3/4] mm/ksm: document smart scan mode
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230912175228.952039-1-shr@devkernel.io>
 <20230912175228.952039-4-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230912175228.952039-4-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.09.23 19:52, Stefan Roesch wrote:
> This adds documentation for the smart scan mode of KSM.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>   Documentation/admin-guide/mm/ksm.rst | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
> index 776f244bdae4..1762219baf51 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -155,6 +155,15 @@ stable_node_chains_prune_millisecs
>           scan. It's a noop if not a single KSM page hit the
>           ``max_page_sharing`` yet.
>   
> +smart_scan
> +        By default KSM checks every candidate page for each scan. It does
> +        not take into account historic information. When smart scan is
> +        enabled, pages that have previously not been de-duplicated get
> +        skipped. How often these pages are skipped depends on how often
> +        de-duplication has already been tried and failed. By default this
> +        optimization is disabled. The ``pages_skipped`` metric shows how
> +        effetive the setting is.
> +
>   The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm/ksm/``:
>   
>   general_profit

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

