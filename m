Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EC97A2293
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbjIOPhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbjIOPhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E1A5E6D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694792193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKvZfNUAeqRJOa+1glQDGtoNRuRm5yfurVcRjFqOx34=;
        b=jJzYRDYIqGicnPRec/BjS4lBa6MVl4Scas4TIAdnTvB/Q3ktGlcMrtgkctyO7vmtAtl6Ak
        RgXJ3MwAJ0wYFYW5Bn4wQDQO39NdBHp69sOYNNoEs3raVQww2nuvohffOnOVbYzv72TgCr
        1D8TZkRu4LjIwo5Cu7lFzfYzL3laP8M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-MFuklsKtMV6dVM-kAyi7YA-1; Fri, 15 Sep 2023 11:36:30 -0400
X-MC-Unique: MFuklsKtMV6dVM-kAyi7YA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31fb896a87aso1565141f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694792189; x=1695396989;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKvZfNUAeqRJOa+1glQDGtoNRuRm5yfurVcRjFqOx34=;
        b=lWnwdNJzuE4DK9JuKtN6tXUopbg/zochkofiAuAKPkm3V8YQfAbMCR2DJ36aY5/2Z7
         GzmwHIivUPSR2P1ujn9fGLEztEanNdUnWPOv5okCUx9MqvRZxbOUnoFUt29Rb5nc6M1X
         FFRJZ8ZX+a8M5OWeBetbT9WgexVmF+VoH30GvklAg46kKHuAoOUQDM9cE70wx+cNB5yW
         w79/dzDPtM872VvD89KEoZrF/UqcTDaCvM5XBpSyHLpsavscQP+Ft7fFBT8fTkoJCysk
         rv5AXM//0SZzXc6KY9a4b7OR+Lg+r9gfYNsQ113/W2JJUboEFVqgGIxrujoyWbQOZ9e1
         couA==
X-Gm-Message-State: AOJu0YwQC7krNt3xZ7Cc6qEWJiSqAfedAKniH5YUz9GSedlUyDamuQ7f
        VazAzPIdyYd6Q72UPWUHejmLmZmflUN+cTMY7hqltCdTkfbOhQKR+ii8FoTpy7uJeiUVGM3+YjV
        spWgxjKj6Sd3+DrJk25xR9FsBpkmh39WY
X-Received: by 2002:a5d:46cf:0:b0:317:ec04:ee0c with SMTP id g15-20020a5d46cf000000b00317ec04ee0cmr1704601wrs.47.1694792189683;
        Fri, 15 Sep 2023 08:36:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtkB87/+nnfRuxfOJgL+CM9Ct3RseBJxuj5P7xcBr31HK1aWFwbEWtn8JZFFHltZl8Pm3o9Q==
X-Received: by 2002:a5d:46cf:0:b0:317:ec04:ee0c with SMTP id g15-20020a5d46cf000000b00317ec04ee0cmr1704581wrs.47.1694792189303;
        Fri, 15 Sep 2023 08:36:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c728:e000:a4bd:1c35:a64e:5c70? (p200300cbc728e000a4bd1c35a64e5c70.dip0.t-ipconnect.de. [2003:cb:c728:e000:a4bd:1c35:a64e:5c70])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d4ace000000b003176eab8868sm4793784wrs.82.2023.09.15.08.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 08:36:28 -0700 (PDT)
Message-ID: <a5c37d6e-ca0f-65cf-a264-d1220d3c3c6d@redhat.com>
Date:   Fri, 15 Sep 2023 17:36:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/6] shmem: high order folios support in write path
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Daniel Gomez <da.gomez@samsung.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
References: <CGME20230915095123eucas1p2c23d8a8d910f5a8e9fd077dd9579ad0a@eucas1p2.samsung.com>
 <20230915095042.1320180-1-da.gomez@samsung.com>
 <b8f75b8e-77f5-4aa1-ce73-6c90f7d87d43@redhat.com>
 <ZQR5nq7mKBJKEFHL@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZQR5nq7mKBJKEFHL@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.09.23 17:34, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 05:29:51PM +0200, David Hildenbrand wrote:
>> On 15.09.23 11:51, Daniel Gomez wrote:
>>> This series add support for high order folios in shmem write
>>> path.
>>> There are at least 2 cases/topics to handle that I'd appreciate
>>> feedback.
>>> 1. With the new strategy, you might end up with a folio order matching
>>> HPAGE_PMD_ORDER. However, we won't respect the 'huge' flag anymore if
>>> THP is enabled.
>>> 2. When the above (1.) occurs, the code skips the huge path, so
>>> xa_find with hindex is skipped.
>>
>> Similar to large anon folios (but different to large non-shmem folios in the
>> pagecache), this can result in memory waste.
> 
> No, it can't.  This patchset triggers only on write, not on read or page
> fault, and it's conservative, so it will only allocate folios which are
> entirely covered by the write.  IOW this is memory we must allocate in
> order to satisfy the write; we're just allocating it in larger chunks
> when we can.

Oh, good! I was assuming you would eventually over-allocate on the write 
path.

-- 
Cheers,

David / dhildenb

