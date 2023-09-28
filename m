Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3817B2238
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjI1QZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjI1QZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:25:08 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F2A136;
        Thu, 28 Sep 2023 09:25:07 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-277564f049dso6508728a91.1;
        Thu, 28 Sep 2023 09:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695918306; x=1696523106;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOloAo3tqLI/VxHy6G+Dm/gSK2CBKX5itJ92CKMeKPw=;
        b=CHzAkmi17yIPNxjTwknCuwxc76ysCKHyCniMtWl3yv9j8s+jScRhJmUCQ+OxWK1SaF
         KQ7SLtvNqkDgp53KJUZBDzP7q7H0aEH0XuIWHH4e1GkzimEaH8FXhXwAsjq7DA0+/HN5
         /eTx/TYKYBddmwvoOXAn3+l+uBwE+lRf+aB97EOXTcuBq08x8hOhHzwfbG+ZTlbuv573
         kS0RjaVSRvUzK+4NSBJnK1hRmInzFFOEg+bsrIHOvrhiGQ/xx1MbotiARdEnaa+h8nJJ
         JGAz2BJON5WoQI+oEwJoTp8LpSEo9v33NPPDjDQ2X/eqFaGQJG8wxu585AJtq5OqGXxd
         yToA==
X-Gm-Message-State: AOJu0YxIgySzgkU95YbLt6lVbYWbBSXP0ZWyYv4Kz9I9rBak153W6/hA
        8romdr29LLmfKOCtAY7TrlKA37oEcA8=
X-Google-Smtp-Source: AGHT+IHvIv1RXyblsRX8TG6D+0hOKcdcs0B/ajC/Hu2MZ4FP7dPYBlZX73TdUk4VwYhGxrCYJ5yq1w==
X-Received: by 2002:a17:90a:e2c9:b0:271:9237:a07f with SMTP id fr9-20020a17090ae2c900b002719237a07fmr1700808pjb.32.1695918306545;
        Thu, 28 Sep 2023 09:25:06 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:4d78:c1af:9677:9afd? ([2620:15c:211:201:4d78:c1af:9677:9afd])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090a9dc600b00274a43c3414sm4961598pjv.47.2023.09.28.09.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 09:25:06 -0700 (PDT)
Message-ID: <5f504cd3-d7cd-4846-9978-011ef3780ae2@acm.org>
Date:   Thu, 28 Sep 2023 09:25:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: lpfc: Clean up errors in lpfc_init.c
Content-Language: en-US
To:     KaiLong Wang <wangkailong@jari.cn>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3ee2affd.8a2.18ad99dc0ef.Coremail.wangkailong@jari.cn>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <3ee2affd.8a2.18ad99dc0ef.Coremail.wangkailong@jari.cn>
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

On 9/27/23 19:28, KaiLong Wang wrote:
> Fix the following errors reported by checkpatch:

checkpatch is a tool that should only be used to verify new patches
before posting these on a Linux kernel related mailing list. It should
not be used to "fix" old code.

Thanks,

Bart.
