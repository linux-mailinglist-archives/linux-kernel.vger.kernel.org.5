Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C1E77B311
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjHNH4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjHNHz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A31EAD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691999708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P7/j61t4D/5jBK6eYpwonDi3AuimXp4+GahooloEebQ=;
        b=RcjWqZ9Ip6LGbH95CenVehnTRgs7lzuQ5THfYIJS3fI0ILd5vh/O0Q5Z9WYVSDf6tVNShf
        03TkHdLmtJ1F/x1p+iQdQHN6aiXEDhCaiOskmsSB2ABfaKeKkfMdgftEELrVT02Cxz0RCM
        CtW+RMSq+G6Wzenz6wCI2PArBMrXV00=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-ThZcdAdXPMGxPAfabsbwtw-1; Mon, 14 Aug 2023 03:55:06 -0400
X-MC-Unique: ThZcdAdXPMGxPAfabsbwtw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3175efd89e4so2223163f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691999705; x=1692604505;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7/j61t4D/5jBK6eYpwonDi3AuimXp4+GahooloEebQ=;
        b=NG4CUGW6GKHlurEDcjQnxk84EKUiUTj+xEcyBCbcsvO+2xmq1v+MJVgO4bVtjI39xK
         eG0LfXc9axVNq60uNP0KOIZ81hqJJRyA/ZhA4ruAmHJypvnH7LqwDMQ7xPWfv+C6EdJR
         VC6SnHOllzDt2pnOgSD0AZ57nIZXpYrG8sU0Ywk48dzA0J8BsdlE8d6OhlLMd7E0vpFG
         +M9K2DGkzH63bZXEqm15SJIk2gGDROFRvtmAmi+l11pDG/KOJMEflBytHAW1VRe5m2KM
         AmJJXpJ6eYt5ARQHTCI8GCsTFLQQM3o8yk9y/Xaasco3ubirjfPGQiQSjrb2JPuVEXNm
         pxoQ==
X-Gm-Message-State: AOJu0YwmHlr1JN1lxX8xZRORH6jvj6AMgCFlLKXmLJWpfhkUZe+j4SXH
        VljvSZp+HAA3ieQc4qUNRGB/ErP5tScMDZAPJxN9+v12qbSPAs1KNAGBMZ41yVTV0mp71RbbrdO
        ccA6tlx6YPiBSVFs7mgwIEaP9
X-Received: by 2002:a05:6000:100d:b0:314:475:bc47 with SMTP id a13-20020a056000100d00b003140475bc47mr5631620wrx.69.1691999705288;
        Mon, 14 Aug 2023 00:55:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjVn4+pfyZBdF8li8OulmsCl0dFZ7840nZK9+9x0/pdi4H0k1F/VHRwA/pirI89TgpASHrUQ==
X-Received: by 2002:a05:6000:100d:b0:314:475:bc47 with SMTP id a13-20020a056000100d00b003140475bc47mr5631601wrx.69.1691999704917;
        Mon, 14 Aug 2023 00:55:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:d900:2d94:8433:b532:3418? (p200300d82f2bd9002d948433b5323418.dip0.t-ipconnect.de. [2003:d8:2f2b:d900:2d94:8433:b532:3418])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d684a000000b0031758e7ba6dsm13532656wrw.40.2023.08.14.00.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 00:55:04 -0700 (PDT)
Message-ID: <00dd353b-e5aa-69fb-6b52-cb59028ea90a@redhat.com>
Date:   Mon, 14 Aug 2023 09:55:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, koct9i@gmail.com, oleg@redhat.com,
        dave@stgolabs.net
References: <20230813123333.1705833-1-mjguzik@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] kernel/fork: stop playing lockless games for exe_file
 replacement
In-Reply-To: <20230813123333.1705833-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.08.23 14:33, Mateusz Guzik wrote:
> xchg originated in 6e399cd144d8 ("prctl: avoid using mmap_sem for
> exe_file serialization"). While the commit message does not explain
> *why* the change, clearly the intent was to use mmap_sem less in this
> codepath. I found the original submission [1] which ultimately claims it
> cleans things up.

More details are apparently in v1 of that patch:

https://lore.kernel.org/lkml/1424979417.10344.14.camel@stgolabs.net/

Regarding your patch: adding more mmap_write_lock() where avoidable, I'm 
not so sure.

Your patch doesn't look (to me) like it is removing a lot of complexity.

-- 
Cheers,

David / dhildenb

