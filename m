Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8CA784846
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjHVRPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjHVRPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:15:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818F030FC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692724499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WVwfq44EfyjOUMF9Cqrif+Xnw1bx5Ni+IbYDS3wJpQk=;
        b=aXICV+gvciFZyxPKonFBK6oxly1A44qwOKR4HfZFJbdJcBFEGgLVGjAafAtdoNfs1f5pvg
        /Yl9llSl5qw0qujhJxWHZMFYYt82/kao2p0tU3Svwx0Qw3e1ZEwCSkSwceF2+K/dNwHtTB
        wIp4/rzuxt7c0eZuAvETZwen1EdhwCs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-CYo6zpgzMCy2sczxf5QYbQ-1; Tue, 22 Aug 2023 13:14:58 -0400
X-MC-Unique: CYo6zpgzMCy2sczxf5QYbQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe2a5ced6dso30175215e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692724497; x=1693329297;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVwfq44EfyjOUMF9Cqrif+Xnw1bx5Ni+IbYDS3wJpQk=;
        b=XOQUKtgEWR7BDG53I5pvg731EB2wPRXtB+ERA4k4sLmGXr/OZZ5l5N82FXc1RmXY6j
         4L/vSdbEhpbaleLaYxQMGn2MNOptiqst9z/8uKh6uVLGdKk+56hnmr+lwDsUJHVkpNWx
         X0alAljfKl7fTz/gbS4zxcpZWmXqkpHdTLCyL4iZEkbNNqd/yUHE5Zv78m+tNRr/Rs1r
         qcu+3NZ8M6W+RtEzcWpgAZVxgOpDZcRmIJmfR3PmbrRvpH5jdYaqOft+ZsoFMYur3xbz
         fxLcTKrC3C+UhSzd+FUPsO6jZEXxw5VzFrPLUaNBbZFszcoawBftYv14g42cVDn5K0Q5
         GL/g==
X-Gm-Message-State: AOJu0YxRp8hGgZNF67P3aGqDbbCAGE3YCF4rvC1/S/X1zaZqsNlDARV1
        Bye3mOQQqfRkxg9EzLUFw8mYDpPCsReNRXGZueKnMKlPaW2j1Or3Qt7mCFavKe+9LG1Z+5n6A6K
        Pt68K4nzEt0Io13aZYWWJvaB8
X-Received: by 2002:a05:600c:21d7:b0:3fb:adc0:609b with SMTP id x23-20020a05600c21d700b003fbadc0609bmr8272114wmj.13.1692724497285;
        Tue, 22 Aug 2023 10:14:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH23bPSS+vVpGjWOU/XLeF3o8YSRaJk61qT7CmrK10eD+OTjKTmDNWRtt1BojDn7JN7UWCgIw==
X-Received: by 2002:a05:600c:21d7:b0:3fb:adc0:609b with SMTP id x23-20020a05600c21d700b003fbadc0609bmr8272094wmj.13.1692724496901;
        Tue, 22 Aug 2023 10:14:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:7400:83da:ebad:ba7f:c97c? (p200300cbc706740083daebadba7fc97c.dip0.t-ipconnect.de. [2003:cb:c706:7400:83da:ebad:ba7f:c97c])
        by smtp.gmail.com with ESMTPSA id q1-20020a1cf301000000b003feea62440bsm9821557wmq.43.2023.08.22.10.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 10:14:56 -0700 (PDT)
Message-ID: <a123dc21-d9f5-fc57-7a04-0bf2aa4253b7@redhat.com>
Date:   Tue, 22 Aug 2023 19:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH mm-unstable v1 1/4] mm/swap: stop using page->private on
 tail pages for THP_SWAP
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
References: <20230821160849.531668-1-david@redhat.com>
 <20230821160849.531668-2-david@redhat.com>
 <CAJD7tkZNjwq6sWE5hCh6rYpSdD0quGFevXWq9eO_t3tHQBTNmA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAJD7tkZNjwq6sWE5hCh6rYpSdD0quGFevXWq9eO_t3tHQBTNmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> +static inline swp_entry_t page_swap_entry(struct page *page)
>> +{
>> +       struct folio *folio = page_folio(page);
>> +       swp_entry_t entry = folio_swap_entry(folio);
>> +
>> +       entry.val += page - &folio->page;
> 
> Would it be better to use folio_page_idx() here?

Sounds reasonable!

-- 
Cheers,

David / dhildenb

