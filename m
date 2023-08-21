Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A085D78242A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjHUHLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjHUHLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFFDA6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692601852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7U5bfl+8GkQX2Ru+1ERv9dMSPVsL01uB88Kl7XRSQnE=;
        b=XeSoNw3kVlPpjyC5iS3D6JaM8SRy0zIjTNnE4XIZZhCi14Z1+TOn+2HFgujXJfFywZowJi
        JcvRbMC8sPlEQYBx5Oqhxb2I/K37sUTH7zP9owrj03J11t0OREZ6+iSPA2UUioTLEooTxL
        0VfH0eWxiutQbdvcg7dhn1iGQaYGxlY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-NLS9R_S3PW2SWb7Fzz3WlA-1; Mon, 21 Aug 2023 03:10:50 -0400
X-MC-Unique: NLS9R_S3PW2SWb7Fzz3WlA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3feeb420c8aso6879745e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692601849; x=1693206649;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7U5bfl+8GkQX2Ru+1ERv9dMSPVsL01uB88Kl7XRSQnE=;
        b=F/I1otJYUN+7u8w/eF5DyGiTNICJhS9B+V9un6tgfe5uTbTKXTLwHawc1chfQQvXQs
         Zav+ktQ746CjG+iVhNry38XRCGkPIXKCXdKrjsjIAq2u6mQGjOxoKOvPvuhr8/kUCfIc
         h9/bKZ1hPUS/0DJ8k0KYtGrURKxVzHhilRAuwRSEVXkJsJfhK0Ko6p/NAPIgBtDBgVlk
         TyfLzgL76T1dHTCUKEhFgkZEq6+dE00jM9DDQEkA4No7xldAk7UXuGZRzgkQIhZmNUBx
         12eYn5EnNJHR4RlXPx8IklBkJzr7LJu5phzh1mSGcGjXmnD76oD1doIg0eTloTpf9S2e
         c70Q==
X-Gm-Message-State: AOJu0YwBkPTPeADShEHBwhx0S1OdN8IU8ZF3Eyu7FapBuB90vGP/yIgz
        vfpuzPOokfa7HCVuS5JbpGwPJNqmhtUDwU/MMTSbTYli1YPLZQ1AYgdq1QT0dvG25sr6FBmWP56
        uc742K59lu9ld5g4MJ+dZP07avhmgsNoj
X-Received: by 2002:a05:600c:2117:b0:3fa:8c68:4aba with SMTP id u23-20020a05600c211700b003fa8c684abamr4085878wml.25.1692601849232;
        Mon, 21 Aug 2023 00:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7uYYKxazl0gdDW5+jbhdr1DMO67F+xV44FYK5z06H//ahedGsx1xXBk2h+YLibTlrepAj3A==
X-Received: by 2002:a05:600c:2117:b0:3fa:8c68:4aba with SMTP id u23-20020a05600c211700b003fa8c684abamr4085861wml.25.1692601848880;
        Mon, 21 Aug 2023 00:10:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:5e00:f3e5:9995:b58b:3782? (p200300cbc7155e00f3e59995b58b3782.dip0.t-ipconnect.de. [2003:cb:c715:5e00:f3e5:9995:b58b:3782])
        by smtp.gmail.com with ESMTPSA id l22-20020a7bc456000000b003fe1afb99a9sm11649923wmi.11.2023.08.21.00.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 00:10:48 -0700 (PDT)
Message-ID: <064da477-2348-9f55-b5c4-bdda60ee0fe3@redhat.com>
Date:   Mon, 21 Aug 2023 09:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm: Add vmalloc_user_node()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230820194031.1395870-1-willy@infradead.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230820194031.1395870-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.23 21:40, Matthew Wilcox (Oracle) wrote:
> Allow memory to be allocated on a specified node.  Use it in the
> perf ring-buffer code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> I was looking at the perf ringbuffer code for other reasons, and I noticed
> that everything else gets allocated on the specified node ... except
> there's no way to do this for vmalloc.  I assume it'd be helpful here too.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

