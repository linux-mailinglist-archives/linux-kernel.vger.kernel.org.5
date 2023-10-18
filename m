Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C6A7CDDDA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344774AbjJRNvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjJRNvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:51:31 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54EB112;
        Wed, 18 Oct 2023 06:51:29 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1c434c33ec0so46094545ad.3;
        Wed, 18 Oct 2023 06:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697637089; x=1698241889;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncX7AAbima5ZEvqy0x7/Hr5T6QPBCs/wkwfAYs2sYa0=;
        b=oiLbORKcASzzVbaAJAbxXU1wzmD3YOVytA9rtTZUzHo+fQfCnJF0p8rfcWAuC/wvkM
         /0FiCGXmXXjY1bkSi3ZEDeWoVRGG+qSzZfxKnI6rmFvp5GN5r88aeB1BUl9HnOE2wUCZ
         dNHDqoIRHRcnpUQqJc9owo+rc6iGxJRH1QyqN6Qp60BkjoqaeSBq7BDHu8nOBrZ7gjI8
         +DKvFz7sqOI7V1G9a5wKBKa374XwWU/Qg+NO8XqJVetMF9z181jcWMDrbNg7FGiqFdbE
         XFnAkFizdA9C2nga/H4StE8mbi+MkCLXkySCTAFmt4Z8s3vXQYufoa3UTo7XImgPIeO+
         NaYQ==
X-Gm-Message-State: AOJu0YxGHh/4uPT5Z1N74fUqvB/0kk1obiqW3ln4PJ750iExC0HEoGt6
        BXXgNkKQ194tIpcHLl35U9I=
X-Google-Smtp-Source: AGHT+IEORGdRyv2BL4v+e3ILfXIKJDzhNpH/BmYAHGlYl85wuL++pOLEkpzlGoZ4Pu0V/gd4wSlYew==
X-Received: by 2002:a17:90a:357:b0:27d:1f5c:22cb with SMTP id 23-20020a17090a035700b0027d1f5c22cbmr5031915pjf.20.1697637088904;
        Wed, 18 Oct 2023 06:51:28 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id o21-20020a17090a5b1500b0027ce48022cbsm1326248pji.14.2023.10.18.06.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 06:51:28 -0700 (PDT)
Message-ID: <3e7cd38f-681b-446d-9c16-a694a8d03497@acm.org>
Date:   Wed, 18 Oct 2023 06:51:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] SCSI: Fix issues between removing device and error
 handle
Content-Language: en-US
To:     Wenchao Hao <haowenchao2@huawei.com>,
        Wenchao Hao <haowenchao22@gmail.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        louhongxiang@huawei.com
References: <20231016020314.1269636-1-haowenchao2@huawei.com>
 <CAOptpSMSpuU_NDKNPKRk1ZS76KhOfCmSeB7YxbD6jvNpvNGZPg@mail.gmail.com>
 <0091a3e7-d3cf-4572-af46-79adbde42ab8@acm.org>
 <8877db4d-50e2-d814-484b-c2ec501f752b@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <8877db4d-50e2-d814-484b-c2ec501f752b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/23 18:37, Wenchao Hao wrote:
> The previous version was posted on 2023/9/28 but not reviewed, so I
> ping soon after repost.

Since a repost counts as a ping, I think posting a ping soon after
reposting is considered aggressive.

Bart.
