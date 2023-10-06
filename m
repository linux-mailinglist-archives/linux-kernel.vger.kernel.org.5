Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1F77BB776
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjJFMTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjJFMTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78418E9
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696594710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dbw4MOmjZC51ejikUmCxHLL4GruOz1Qm7tMoP+Z0mHA=;
        b=EREJmbn1C045F9XivOj0kIeav83/Prp0z8XHQK11IxzaIKm6KlrWzG5HfHwvAh5PP+yRwh
        pfH3+V0qKVkn61we4q7x5ou1IsWTLGCGB1Htda4SLJFIyiHJUQusQ7AOgxaDBi6rn3u/M/
        /TIgvXl5zMtiyReCUl1JfwcHsG8EBDQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-kre88s0ZPPye_Wf7Ly-F-A-1; Fri, 06 Oct 2023 08:18:14 -0400
X-MC-Unique: kre88s0ZPPye_Wf7Ly-F-A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-313c930ee0eso1328857f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 05:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696594693; x=1697199493;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbw4MOmjZC51ejikUmCxHLL4GruOz1Qm7tMoP+Z0mHA=;
        b=I6bKP+AP/uvnt/vrVAz1Hq0+xFMsqRrnGwKdkRgsnWQaZMrzhXlIhfsoG9Rvpg7KMW
         9/vaspq2OxpYV9xe4qtySRKRPkq1wLNFjDtIrKGwiXaugwbyv8bilJ4Wnxw0SoXprDp4
         bX7KOo6gGueZV9aUkzclR2aevoc802vOsKwf/oRdMG5QdDs5Ao9pQMKQis+8qQlI1nnD
         8XBhOhdHXC5oxmqUKQL8M502QAMFhVFGKzYlAsMy2CdVT2VjMp0XTldpkzFiXIE/FHgx
         JtaPEZIU9PG3WNRR6r/ULpxvTN10D+feJqZyAxsthvWGGaroa91pFxDHIydTYLjrb4yd
         O47g==
X-Gm-Message-State: AOJu0YzYAmXXUF2+zpmiuKUFcBM6EVw5jh+sevOzGjPFSqQIJF56L3Pj
        ergAcYxly36FgROFPGMxfDjcYJjcHA/UPjdkiZyT1UF1l6NB4ckcBE7N6SVYQfLME99tB1OsB4/
        55f8FtMbt9NHcMK4k5k+FlRdZ
X-Received: by 2002:adf:e8cc:0:b0:322:da1f:60d9 with SMTP id k12-20020adfe8cc000000b00322da1f60d9mr7590367wrn.47.1696594693339;
        Fri, 06 Oct 2023 05:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc6SbTTZSfwrLVAys/qqFPp5hvwHwl88AuA1jeLh9rz9lTN3c+wJWP4s2tjE8cErcaLFUGCA==
X-Received: by 2002:adf:e8cc:0:b0:322:da1f:60d9 with SMTP id k12-20020adfe8cc000000b00322da1f60d9mr7590346wrn.47.1696594692925;
        Fri, 06 Oct 2023 05:18:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:ee00:4e24:cf8e:3de0:8819? (p200300cbc715ee004e24cf8e3de08819.dip0.t-ipconnect.de. [2003:cb:c715:ee00:4e24:cf8e:3de0:8819])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c00c600b00402ff8d6086sm3642880wmm.18.2023.10.06.05.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 05:18:12 -0700 (PDT)
Message-ID: <3cbd358e-501a-217f-6482-e20b55e7c728@redhat.com>
Date:   Fri, 6 Oct 2023 14:18:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mm: rmap.c: fix kenrel-doc warning
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Muzammil <m.muzzammilashraf@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231006113948.51673-1-muzammil@dreambigsemi.com>
 <ZR/6sZmNMpMkfxKf@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZR/6sZmNMpMkfxKf@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.23 14:16, Matthew Wilcox wrote:
> On Fri, Oct 06, 2023 at 04:39:48PM +0500, Muzammil wrote:
>>   /**
>>    * folio_move_anon_rmap - move a folio to our anon_vma
>> - * @page:	The folio to move to our anon_vma
>> + * @folio:  struct folio - Represents a contiguous set of bytes.
>>    * @vma:	The vma the folio belongs to
> 
> Why did you change more than just 'page' to 'folio'?  I think the
> other changes you have made to this line are not an improvement.

Oh, I missed that. indeed, just s/page/folio/ is sufficient.

-- 
Cheers,

David / dhildenb

