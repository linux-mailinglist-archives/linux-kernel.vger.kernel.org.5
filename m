Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351F28112D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379029AbjLMN2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjLMN2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:28:41 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D6B91
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:28:47 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c2655da63so10220215e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:28:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474125; x=1703078925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GpY0Sui/xdAtuYAxQCzYA4TDxdQVSm04ypmrZ12oNg=;
        b=sEcotXVfldAwdYaw6/Dp/v5UvNMYHdTaTxcjsATAg98HQhuXcQaXgukjebgr8x3OLh
         yotpzuQu/4phqHllmu/xfIigsRelq+NeA2E4Oog+GzGyds4YvWKR7Yxlsli+0ktdtJor
         GVNb9lmP8Z4i6mlyimQ2jq2VAatfAgJscZXRgrb8cXRIeIUcfzPbn0O9+io3YvWA2lhT
         HjILP+J56DbePyCQKzrpjV/7KPqB2/7DFMQ+cZ+ryyxm5NxoYFQ1ORvI0qf9lzCyx+Sp
         fJfojjcgip2ZZ+3UrtqJhn0PbaKyOLA6kAfJWC878CLc0SDp9K24UiuCQf5gXzS8zjyz
         LKEg==
X-Gm-Message-State: AOJu0YzD1nk78LiDyK7EePOJf67/3zzRJ8kymV0FjOjC6LVaEHSTQBU0
        ZPNXWmO3SN/NjlbpWDIU/+2Pl0c07Z4=
X-Google-Smtp-Source: AGHT+IH6lOEW2PUSy+Pz9w6k9x6hHoNgKmh1Z+Gv16j8L0ACg4SEls3uKWjT/rH1rGxO3WlZ2zJP7w==
X-Received: by 2002:a05:600c:1c9d:b0:408:3836:525f with SMTP id k29-20020a05600c1c9d00b004083836525fmr9742267wms.1.1702474124959;
        Wed, 13 Dec 2023 05:28:44 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05600c3d8b00b0040c2963e5f3sm20289168wmb.38.2023.12.13.05.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:28:44 -0800 (PST)
Message-ID: <f50c8a61-7523-4750-b884-cb06bd59fe3e@grimberg.me>
Date:   Wed, 13 Dec 2023 15:28:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] nvme: refactor ns info setup function
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20231208105337.23409-1-dwagner@suse.de>
 <20231208105337.23409-4-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231208105337.23409-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same on the PI comment.

Other than that,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
