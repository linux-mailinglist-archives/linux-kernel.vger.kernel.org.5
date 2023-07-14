Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFA575323F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjGNGr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbjGNGrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:47:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B52826B7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689317166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXpKPKHigpMkbl63W7aUxxwZsWxrC+5Af9bciMsQwRU=;
        b=QdE2tDgkOElhRu8Z1bnFdSQH5kIiYYamk6kxGdD9221cJTU+VLYtU1y28Hm8av/YAPNEwe
        GxHpGaIFUqGkwI+q2lzKzKzEvVfl+rf30YcsL5XVLw1L4us0NTuQrag6F9StCUDv0LLTSt
        smQKIkiFOyKD6Mw6igULkQRVvv21V4A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-8OtjsKBxNDeaE3fd7RBq7g-1; Fri, 14 Jul 2023 02:46:04 -0400
X-MC-Unique: 8OtjsKBxNDeaE3fd7RBq7g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31437f02985so1064615f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689317163; x=1691909163;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXpKPKHigpMkbl63W7aUxxwZsWxrC+5Af9bciMsQwRU=;
        b=K2Twv6/KUBmT6NYdLALDKekEb/ABG5AT623OH4GmvyNtZgM2xFjVeqs7UQw277F2As
         V6cKjbeOEYZdD7xV5p4ej0LYYBVQbE+ebDXJAGJanwyQYg+bF12Rb0SkcMtGXd20FwRH
         dnVdBj0dffC3alGqDQ02uNeFogfyjFDQUbI9B6/8pY9ecEKPOdODNdLx/c8pYNwYxxvY
         3JQdgO1lFcCigfkPvlWsJBknrdqWCDsopETCOv/IK4V7iLLTO0rQwrby8+gGNJSAIlJe
         xnFMsaWuAx81maTCRE4Xg8LmozhecoHWmDXMeqxna9TSw/4xJtv3pZDk+/8u3QY/8h1M
         r2dw==
X-Gm-Message-State: ABy/qLbmSjXoWmsflXP98Oi2rMIbiuBCtD/qMimIkDZe5BLT2jXYV0GI
        88bGqcCFh2nvFCRZkynjKHEUXUuy1BQrs2ZjaqDtypjfsZ6vIaCqO0en0J5A68Ak1AfjxIXvtyd
        FFb8XXQNkRwPl7FXNr4i7u6Nu
X-Received: by 2002:a5d:5506:0:b0:314:3358:d57f with SMTP id b6-20020a5d5506000000b003143358d57fmr3243367wrv.56.1689317163690;
        Thu, 13 Jul 2023 23:46:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH9IkQug2Vp8ewiaAGSY8AV3YvIspoKiJh6biwWXVoO5nvSCptVvP139urMCIqbtER0pDCkeQ==
X-Received: by 2002:a5d:5506:0:b0:314:3358:d57f with SMTP id b6-20020a5d5506000000b003143358d57fmr3243347wrv.56.1689317163305;
        Thu, 13 Jul 2023 23:46:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:4500:8a9e:a24a:133d:86bb? (p200300cbc70a45008a9ea24a133d86bb.dip0.t-ipconnect.de. [2003:cb:c70a:4500:8a9e:a24a:133d:86bb])
        by smtp.gmail.com with ESMTPSA id j11-20020a056000124b00b0031417fd473csm10024953wrx.78.2023.07.13.23.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 23:46:02 -0700 (PDT)
Message-ID: <2b5e55ae-b7c5-3274-a6e0-61951d0c9068@redhat.com>
Date:   Fri, 14 Jul 2023 08:46:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
References: <20230714061438.122391-1-anshuman.khandual@arm.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/rmap: Convert rmap_t into enum rmap_flags
In-Reply-To: <20230714061438.122391-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.23 08:14, Anshuman Khandual wrote:
> rmap_t tracks bitwise positions for various page reverse map related flags.
> enum could provide more compact representation. This converts these flags
> into an enum listing, without any functional change.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.5-rc1

No,

please read Documentation/dev-tools/sparse.rst for "Using sparse for typechecking".

-- 
Cheers,

David / dhildenb

