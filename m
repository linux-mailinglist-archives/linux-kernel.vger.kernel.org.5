Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034DB7E9F70
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjKMPBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjKMPBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:01:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83B7D44
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699887618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=sx/FtbWLSi9Y+ImX9augcyo62KiPvRDrvu1sJ3i6/Jg=;
        b=RLVidZplRc/bg7/pePQDIt4M5uIOjGuqvKTCGnkdHWuCdS8FAeCv/RA/ukwf1Kyf7CSvKd
        mIpnZTH8DTnN6OT67sqomCjXC+uj41v3Z104XfbWLSBWGRkF7oKqZKkAK5X6fJ8Sok22Wr
        S5mt8zn/2DxMka4m8ZYNNsaYvhvaglg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-6rkA-FuaOE2c8rAxSEaIMg-1; Mon, 13 Nov 2023 10:00:17 -0500
X-MC-Unique: 6rkA-FuaOE2c8rAxSEaIMg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40845fe2d1cso31231325e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:00:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699887616; x=1700492416;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sx/FtbWLSi9Y+ImX9augcyo62KiPvRDrvu1sJ3i6/Jg=;
        b=bJOoK41jTnm71iaG9F42IoRHHlgaHhSk6QUiaxsPzRwzHRyh4EMVK9WHLhfVnzx0ra
         UwFEyhiRFmNDKEphiP1/Rj1T1GTLThmUPa/MXESlGQxp6l65qCAs0PnGsT7xG2mJCxso
         /ofC9TUvuCx+cIAjEoZ3nmwWuHXveSCSZLWBSzBaMndsLyTsPba6Cg7jsfgqXi4bt3xx
         UIMYTE0la7jZdpONyJb5Y5xvJ1XSDwEcbSTL2ulwu6u31TuNfxVbaYnujpEvM+iRL/cc
         9zsl+axu9wjdTBJCPbcCsu3gw4YLIdDdK7HpStRrBspZM4jzmiXRPePyph7zIUNQ0Ha4
         ckug==
X-Gm-Message-State: AOJu0YyafrBg8S0foClpPerdrpXNVq1GH18VY3yAF6gfNs1+OgyMCzxP
        bL8AE1QVNFP4FbRDIZ7dICKe1yjxaSPcUZyoXuEUQR5uDDmfrJ0uPAQXfCd1Ew/4lxj6VDaCfI0
        c/IUF1DrfwILBJGpriI8DQvTQ
X-Received: by 2002:a05:600c:19cd:b0:405:36a0:108f with SMTP id u13-20020a05600c19cd00b0040536a0108fmr5664185wmq.41.1699887616083;
        Mon, 13 Nov 2023 07:00:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGanNnoty6bffXm8mtE45GvrR00O+ujPH/1JLpipbcLgavc8g/0Bg0QrRBdzRp1pBMA98PdVw==
X-Received: by 2002:a05:600c:19cd:b0:405:36a0:108f with SMTP id u13-20020a05600c19cd00b0040536a0108fmr5664161wmq.41.1699887615705;
        Mon, 13 Nov 2023 07:00:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:900:e9d2:2326:c69d:a7e2? (p200300cbc7380900e9d22326c69da7e2.dip0.t-ipconnect.de. [2003:cb:c738:900:e9d2:2326:c69d:a7e2])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b00405959bbf4fsm8308118wmp.19.2023.11.13.07.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 07:00:15 -0800 (PST)
Message-ID: <6df6cfaf-e704-49cd-9002-eb27b4e8369b@redhat.com>
Date:   Mon, 13 Nov 2023 16:00:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmap: remove the IA64-specific vma expansion
 implementation
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231113124728.3974-1-lukas.bulwahn@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231113124728.3974-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.11.23 13:47, Lukas Bulwahn wrote:
> With commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture"),
> there is no need to keep the IA64-specific vma expansion.
> 
> Clean up the IA64-specific vma expansion implementation.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>   mm/mmap.c | 37 +------------------------------------
>   1 file changed, 1 insertion(+), 36 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 1971bfffcc03..72a3bdea4fa4 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2207,42 +2207,7 @@ struct vm_area_struct *find_extend_vma_locked(struct mm_struct *mm, unsigned lon
>   }
>   #endif
>   
> -/*
> - * IA64 has some horrid mapping rules: it can expand both up and down,
> - * but with various special rules.
> - *
> - * We'll get rid of this architecture eventually, so the ugliness is
> - * temporary.

Hurray

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

