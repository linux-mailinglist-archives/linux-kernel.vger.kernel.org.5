Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295AB77EDF1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 01:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347219AbjHPXpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 19:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347240AbjHPXpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:45:35 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75921272C;
        Wed, 16 Aug 2023 16:45:33 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-68896d7eb1eso533190b3a.3;
        Wed, 16 Aug 2023 16:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692229533; x=1692834333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnY/yGoj6nHDhHvr9WuPTW+0izn3EbM5Po7pZrQVm+s=;
        b=eS+IT3TxTlpwHnG+yYbWMxuNDSo8Fsszi9KMelLRbjdLriatbxlZQSFaDfnG3NTEF9
         lVZn8HYVQd992yVQDckK1LVbmNAXPNKDl9g6wa67t5lIEmzt50wsSNR1g22Z/XoMMlBQ
         UMcd1shHrPQ98Mt7QBvb4LPuyt+IJxMpIbb7LQOZJ2kkH9cdoeUD/TKinT9IaI/F3O53
         dIwS2a1dVi1AqBLRihQ9MYj6d9diCNw/EgUQUYT5pwjS3yyl4YOggHmI1B9OjKA7ZBJg
         edcjnwJQN/wVQ5TjZyqWpd8PSGnkQE/QmA/aRkbukoHx5n/nk320W9S8951Q0hAN8uHo
         7PUQ==
X-Gm-Message-State: AOJu0YztL+tuppiuYNh+7tmuzM9r6/qGZNgBH1YMJrhnBD5igPvvT0dJ
        zIn0MT4gQUW7BUGk7cmumu4=
X-Google-Smtp-Source: AGHT+IFI2GGcw2Y2TjCUhuvguu20fUYcEI4mDmBOmmhfmqK8EPQP6DKhuZjuGdQ+3a4qIJErZ8oE5A==
X-Received: by 2002:a05:6a20:ce9c:b0:131:5f8b:9c7d with SMTP id if28-20020a056a20ce9c00b001315f8b9c7dmr2849424pzb.22.1692229532686;
        Wed, 16 Aug 2023 16:45:32 -0700 (PDT)
Received: from ?IPV6:2601:647:5f00:5f5:4a46:e57b:bee0:6bc6? ([2601:647:5f00:5f5:4a46:e57b:bee0:6bc6])
        by smtp.gmail.com with ESMTPSA id fm22-20020a056a002f9600b00688459a9bdcsm3487440pfb.135.2023.08.16.16.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 16:45:32 -0700 (PDT)
Message-ID: <de179ae2-0d26-79f4-b689-cb038099a5e7@acm.org>
Date:   Wed, 16 Aug 2023 16:45:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 1/1] scsi: ufs: mcq: Fix the search/wrap around logic
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, avri.altman@wdc.com, beanhuo@micron.com,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        open list <linux-kernel@vger.kernel.org>
References: <ff49c15be205135ed3ec186f3086694c02867dbd.1692149603.git.quic_nguyenb@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ff49c15be205135ed3ec186f3086694c02867dbd.1692149603.git.quic_nguyenb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/23 18:38, Bao D. Nguyen wrote:
> The search and wrap around logic in the ufshcd_mcq_sqe_search()
> function does not work correctly when the hwq's queue depth
> is not a power of two number. Correct it so that any queue depth
> with a positive integer value within the supported range would work.

Does this patch need a Fixes: tag?

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
