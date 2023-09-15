Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A9F7A2259
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbjIOP1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbjIOP1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7816DE71
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694791610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXJCz6BbI6aPCSAZn+qO6JUf8WIvxxBmFHYvub3SbQw=;
        b=W7K9sdwpt5PNhoX4dWIHdWIP3c+o+gYQdCMpJWJjGLgml5QEd28vVXF2bbQa9i6ttGdp5Z
        rMN6MXMXVvzOWYcIOddX6nuhOapUhoaQw9kEWhvTLGKdy+nN9pWbJNmgtYyo1uD4TdRyCG
        3cB66hhZvq+H055LGCXfwRqNiKseYss=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-aoU2dkBWOvmTPY5J-I6H6A-1; Fri, 15 Sep 2023 11:26:46 -0400
X-MC-Unique: aoU2dkBWOvmTPY5J-I6H6A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31fed999e27so740619f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694791605; x=1695396405;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXJCz6BbI6aPCSAZn+qO6JUf8WIvxxBmFHYvub3SbQw=;
        b=rmdTjAvgNe4i54oe5oZFNaVtZOPDGOPkOtYOi/nom7eu0RHH5Ch9tspzM6wgMcrpOH
         ux1C1q460IdMVMNlhsxsS2jSfhpMsWDOclAJ66oIguYNH1sv1w4jBe38gf2NQKW5R9dA
         eCAnvEQxClvLSJDaAFr5QnkuzQ416eyIC+osfSQt8+oCNqnFwQm1IhOyJ0t9q38U5bxj
         du1ukjuXGaCrejQQCfLKJuqMlSnBcb7KdYrn3gPlgw+vHy2Gb2bmpFjhDrP07RqzFa3A
         ttlzZP509AiIpoGhbEVQ2a3Fl66VCymlFx3j04qVAvoI3b5c3c9nGgnBKFOVdq/Ycrnu
         umeQ==
X-Gm-Message-State: AOJu0Yx2oRORODtriQTgcwYn9qcpMSKtaZFBikFrq4QGpTNjjo5UlaGc
        lSJbIzN7klqeR6MVhEO03z+9uJ/s0LhmMs5ryIAJbBsF90LE/CikRte8CzRUCsYJPS4pXEuwC07
        aoxHCWVFyugDqgV5FUnVmBuIDBdSXPUrJ
X-Received: by 2002:a5d:4705:0:b0:314:12c:4322 with SMTP id y5-20020a5d4705000000b00314012c4322mr1846934wrq.4.1694791605413;
        Fri, 15 Sep 2023 08:26:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcciUEO3Yzg/B/EH3LHnJHXESKC04F9L6yYC6mauISILfyLrs3Bv2tOaf8tetTfv85dpKLcA==
X-Received: by 2002:a5d:4705:0:b0:314:12c:4322 with SMTP id y5-20020a5d4705000000b00314012c4322mr1846917wrq.4.1694791605012;
        Fri, 15 Sep 2023 08:26:45 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6d49.dip0.t-ipconnect.de. [91.12.109.73])
        by smtp.gmail.com with ESMTPSA id z9-20020adff1c9000000b0031f07d1edbcsm4729335wro.77.2023.09.15.08.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 08:26:44 -0700 (PDT)
Message-ID: <b3d9f64a-1661-10c0-0e20-06d91b54bb80@redhat.com>
Date:   Fri, 15 Sep 2023 17:26:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm/rmap: convert __page_check_anon_rmap() to folio
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230915101731.1725986-1-yajun.deng@linux.dev>
 <ZQRg89X67vKL8Q4d@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZQRg89X67vKL8Q4d@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.09.23 15:49, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 06:17:31PM +0800, Yajun Deng wrote:
>> @@ -1176,8 +1175,8 @@ static void __page_check_anon_rmap(struct folio *folio, struct page *page,
>>   	 */
>>   	VM_BUG_ON_FOLIO(folio_anon_vma(folio)->root != vma->anon_vma->root,
>>   			folio);
>> -	VM_BUG_ON_PAGE(page_to_pgoff(page) != linear_page_index(vma, address),
>> -		       page);
>> +	VM_BUG_ON_FOLIO(folio_pgoff(folio) != linear_page_index(vma, address),
>> +		       folio);
> 
> No, this is not equivalent.  You haven't hit any problems testing it
> because you don't have large anonymous folios.

Right, the address would have to be adjusted as well by the caller.

-- 
Cheers,

David / dhildenb

