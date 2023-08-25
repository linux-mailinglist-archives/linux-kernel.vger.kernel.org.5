Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907CF7880F8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243072AbjHYHgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243244AbjHYHgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:36:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E151FE4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:36:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68becf931d0so538152b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692948967; x=1693553767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmQXS7ZljRGETNucrUHW9C7e9E1jrlIlPOAPECVnU4o=;
        b=L3EiltqAvipBCYB89ybi72qBxE87H58lYTfHNPfrgziksCQ+c76HutAnmOWWJHW8WI
         KOEkDzazuBirxMAvb1VtRUCmr/EMasK4+85E3WV4Mc9/wqZYDOyzxTst+CSTA3CRw5I2
         nqy90/N36qQp7OI5baDF/ryNd4uxZKhEqB5w6BauiMmtFGJuEMIHSS0GCDYb58qOJjPO
         MF2OakVwTLvQmUYhEnFuvuBwb96eD2wMA062mMQpPrR6HC7lAcP3q+m4mCaCD2jPSXdt
         FSoUlD7DhNLy6CQCkEu6O7Y3E0yi4YYZkg3AKB5FobGDIWEx1JwIwaza4wTPY0FL/tFq
         HHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692948967; x=1693553767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fmQXS7ZljRGETNucrUHW9C7e9E1jrlIlPOAPECVnU4o=;
        b=LrAZYtrDSVvz2/q6R8Z22d4eMtfY2xn3qqhbUU92lPFxtg+xF4JSvSYhehdiH2II3t
         wleDAlttTJqE77eBdnt0Br6A8nrP0+1FLRnWQdpIwCdyAmRgy7/SOxXs1CC1NUmaZMz0
         t9ZlKlDOHEXHMaMIqvFuFdIlqcOSCuumMFSJUkb1DTWQBwv+4RKzyU2hyRq8hzLdMpJF
         IwPC44M3H27gdNOMUzA/MgfqkNpio/9FXqKt8DI36a8QrGwyLR1LlEx4xS9djGPEsA39
         kGPmBBqjJ88oKQEMI+nBVfV7uRUEIe/nJn2BgB23/IqOnc+UM+klE9loJPbpjsZsB0Du
         ICsA==
X-Gm-Message-State: AOJu0YzkLXWkHppRZpGk/jZbZHTc0WLt1RsESbSQ2NwzwXCD0a46tGQN
        FSKSDZ/0yIv9K8hD4ojWjLA=
X-Google-Smtp-Source: AGHT+IFApIFHFPfhzlDLidf2FziQwvEK0ynti/yha+pP4Udf90W+JODZDSPEYGx+qcrjEmY6JnpFpA==
X-Received: by 2002:a05:6a20:138f:b0:10c:7c72:bdf9 with SMTP id hn15-20020a056a20138f00b0010c7c72bdf9mr12929766pzc.29.1692948967087;
        Fri, 25 Aug 2023 00:36:07 -0700 (PDT)
Received: from [192.168.255.10] ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id c3-20020aa781c3000000b0068892c40253sm873672pfn.216.2023.08.25.00.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 00:36:06 -0700 (PDT)
Message-ID: <90562ff0-9689-4d00-848e-87347cacdbae@gmail.com>
Date:   Fri, 25 Aug 2023 15:36:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmscan: Use folio_migratetype() instead of
 get_pageblock_migratetype()
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     zhaoyang.huang@unisoc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vern Hao <vernhao@tencent.com>
References: <20230825040848.1542-1-user@VERNHAO-MC1>
 <aa5d199b-ea12-90f3-91fb-468d74a6f934@redhat.com>
 <ca7199a4-5628-425f-8f0b-8e8123b431b8@gmail.com>
 <9d4d0643-6a7e-22bf-1f54-19646bb7231e@redhat.com>
From:   Vern Hao <haoxing990@gmail.com>
In-Reply-To: <9d4d0643-6a7e-22bf-1f54-19646bb7231e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/8/25 15:34, David Hildenbrand 写道:
> On 25.08.23 09:31, Vern Hao wrote:
>>
>> 在 2023/8/25 15:12, David Hildenbrand 写道:
>>> On 25.08.23 06:08, Vern Hao wrote:
>>>> From: Vern Hao <vernhao@tencent.com>
>>>>
>>>> In skip_cma(), we can use folio_migratetype() to replace
>>>> get_pageblock_migratetype().
>>>>
>>>> Fixes: 5da226dbfce3 ("mm: skip CMA pages when they are not available")
>>>
>>> Why did you think "Fixes" was a good idea?
>>>
>> The skip_cma() contains the folio argument, and the folio_migratetype()
>> is already implemented in the kernel, so I think it's fine to keep it
>> consistent.
>
> If this doesn't actually *fix a bug*, then please don't add fixes and 
> confuse people looking for actual bugfixes.
>
> See Documentation/process/submitting-patches.rst
OK, my bad, i will remove it, thanks.
