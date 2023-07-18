Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58816757906
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjGRKL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjGRKLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:11:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B19E8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689675031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qOpRa8a8GzyAfrufdj2k5uTc70DFoy/jhS0W0gbHuEU=;
        b=Of79ZxbVrvSCLqiTTcN38RWF7NlrYMkTYY4uJYve322aKbQlUy2TW6JEB1R3l3pufMUbEg
        hRfI+b/V7svrkvdbMW1iyHRlwSgVQ6scLFXGfyVZEe1g56/v8jonIZ11vc+L1iCZeEvyD/
        qt/1zky8nyhYP2wv2SHDQuaQd+7eKAk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-YiBtYesJMw6c6epnJ7394w-1; Tue, 18 Jul 2023 06:10:29 -0400
X-MC-Unique: YiBtYesJMw6c6epnJ7394w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fa96b67ac1so32257745e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689675029; x=1692267029;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qOpRa8a8GzyAfrufdj2k5uTc70DFoy/jhS0W0gbHuEU=;
        b=eoyz8pJ60hJbRkNs/jwsLeEn8fBnyI8VVroMa739xYDIyf/jsTkwAInL6y9YaavCOH
         bJpz3vq0x7Hn16lNDJ4w7yms5GAGkrFO1Qg7QN01e+/xJl+9DNSrLyBoukCL83Xeje8P
         m4n1Yr2G0ChZpFx45dPTCECp4t+7U12jEbrbVDC/oNaaTNCxwx5QtwdTIh/j4Qp5qVUF
         VfwCK9IlITMNL8LhZsR3vD7xrq+hp2OjCMUcANn94ZsZbbFiDXmZyLeLLw5OQpG38sAi
         MS3Oa1w4HpEYtO6v/kyN63zkfOJQNbsZwxWpktFT5zZXf/0sx65O3cyAuadtVeDMra6g
         zh+w==
X-Gm-Message-State: ABy/qLYqwa1uJr4w0+1cu+PnBHTpaccasi+ZA0Lgx0C7WZT7qBI1dQLr
        CkosIPQVSAEeaahXW5wTGdyLZ3O7BjBTu++PUpbQO48RZnXlFWuvrVL95QKYOxMyQqG70hFv6+Z
        plJH7NmW0d8Jajq3CQjcE+SdetLCRLLQX
X-Received: by 2002:a7b:c8c9:0:b0:3fc:25:ced6 with SMTP id f9-20020a7bc8c9000000b003fc0025ced6mr1731798wml.13.1689675028798;
        Tue, 18 Jul 2023 03:10:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFS9DAGxfcqCUwye+h1rdEBqC8WvvceSjNQ4CVdToFd0/UBno8Xxn7EhO3BH3JOUg8dH7YiLQ==
X-Received: by 2002:a7b:c8c9:0:b0:3fc:25:ced6 with SMTP id f9-20020a7bc8c9000000b003fc0025ced6mr1731783wml.13.1689675028507;
        Tue, 18 Jul 2023 03:10:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:6200:84e1:eabc:8e2:7429? (p200300cbc740620084e1eabc08e27429.dip0.t-ipconnect.de. [2003:cb:c740:6200:84e1:eabc:8e2:7429])
        by smtp.gmail.com with ESMTPSA id l6-20020a7bc446000000b003fc07e1908csm1725336wmi.43.2023.07.18.03.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 03:10:28 -0700 (PDT)
Message-ID: <76de1682-353b-b8e9-0f09-539988f8ffe0@redhat.com>
Date:   Tue, 18 Jul 2023 12:10:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/rmap: correct stale comment of rmap_walk_anon and
 rmap_walk_file
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230718092136.1935789-1-shikemeng@huaweicloud.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230718092136.1935789-1-shikemeng@huaweicloud.com>
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

On 18.07.23 11:21, Kemeng Shi wrote:
> 1. update page to folio in comment
> 2. add comment of new added @locked
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

