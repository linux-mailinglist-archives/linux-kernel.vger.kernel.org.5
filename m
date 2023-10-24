Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31C07D5B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344188AbjJXTDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344194AbjJXTDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:03:42 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A84C10D3;
        Tue, 24 Oct 2023 12:03:40 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6bee11456baso3921709b3a.1;
        Tue, 24 Oct 2023 12:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698174220; x=1698779020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrekS4CoNdEIxbVvO8w8TUPqsoqaiQBuxBSUtv98lU4=;
        b=KZ9VnlEx/aaPPNhxMCn6QA3Aq4g7JqlJMgiYbIW5rfNx2OeBIgyV5+uK0iOPwvAhVx
         4vLgMDkQTUN8yVhSNka0d9PIooHzCX+efz0uPGYUM//V205lNZ4uxwlyvbj89nfEjxjd
         rvBGLjWw8jj4pc6EoZPeyMZg+nxc7xNQMkODov5HF5wVOBpfufW7OaIQtG8eOtRAXOzc
         dRUgv6r4HoNilwc3bLoDewzX9z6djHvS9p4FreuUnOfXaESiMCREtmeoGCExg6fPlgTW
         J/0ZQqilMvMt6oWF17F5uZ3lLhmXCQ/WlX0iBrz3shPS6t1TMZ6JdTpu0nIHu/G94vnx
         FX8Q==
X-Gm-Message-State: AOJu0YyapflGvuBYa4+aS+aZijPL7ZNgKDoe36JDFSy/xy5ISSMDA0Dc
        wHN1ZPpbiHRmpm+zWtCUa8DszTkF93y9sQ==
X-Google-Smtp-Source: AGHT+IH5kFgcgjymvrgMAh6NmnXeArwK9PGAN0hZmCJkG0hP0WCvZr46x7oM3882L5K4YXbNXJzVcQ==
X-Received: by 2002:a05:6a21:35c8:b0:17d:f676:40b3 with SMTP id ba8-20020a056a2135c800b0017df67640b3mr3420676pzc.19.1698174219596;
        Tue, 24 Oct 2023 12:03:39 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:30e1:c9d3:6b41:493d? ([2620:15c:211:201:30e1:c9d3:6b41:493d])
        by smtp.gmail.com with ESMTPSA id q4-20020aa78424000000b006be2927ca7esm7922835pfn.85.2023.10.24.12.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 12:03:39 -0700 (PDT)
Message-ID: <7f9fa4eb-01fb-4581-badf-535f634d0152@acm.org>
Date:   Tue, 24 Oct 2023 12:03:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: message: fusion: Fix a possible data race in
 mpt_ioc_reset()
Content-Language: en-US
To:     Tuo Li <islituo@gmail.com>, sathya.prakash@broadcom.com,
        sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@outlook.com,
        BassCheck <bass@buaa.edu.cn>
References: <20231024072729.455713-1-islituo@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231024072729.455713-1-islituo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 00:27, Tuo Li wrote:
> In my opinion, this may be a harmful race, because the value of
> ioc->taskmgmt_quiesce_io can be rewritten by mpt_ioc_reset() when
> another thread is accessing it.

It is a common pattern in the Linux kernel that a variable is set from
one thread without using locking and is read by another thread that is
holding a lock. It should be sufficient here to use WRITE_ONCE(). I
don't think that acquiring and releasing the spin lock is required.

Thanks,

Bart.

