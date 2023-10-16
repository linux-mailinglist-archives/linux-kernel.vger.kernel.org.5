Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F827CB529
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjJPVQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjJPVQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:16:15 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EBFAC;
        Mon, 16 Oct 2023 14:16:13 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c9e95aa02dso30812745ad.0;
        Mon, 16 Oct 2023 14:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697490973; x=1698095773;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lEhcuHiu2scOZP08dw+rF+hfx+bVpPniCecMP/FEFVg=;
        b=hIucgWl1ZWBatpFSMsBOWUeX7V1J+m9rJIJ7VoPvbZkkuXB05WJ4j7Ojnk1P6ENMId
         LUVjIF6vF20mHyjMlxfBHwENRORyF9v+8VojZPHi8/Imaw5qWFcnP11oJWgjkLO9OJt0
         D8W2jHjvNyWiHTg19m1mfFDtFMtc8ZaejMGr1PyMqKNIeddfSGEdJl0nfrEOHRJM/sX0
         FD8A1SsTe+ee89uTVXjmYAtZojWn+LQMZQQNmT6PZUqfv2hEAbUm2quEHFNhBo2Tvq51
         mXUU/HA7D5McOFz2QyuunlSvH/cONbQ7MHhby6gGgBGbqnH4C8xBDDU/l1meaz7HMgWy
         8x6g==
X-Gm-Message-State: AOJu0Yz7xSmB3ZvWk2NFaEAdJ02JpqckH2ctA4cutWclP5LC5b0U81KD
        vp4oCtSeFHNqjwuA2eGQGlE=
X-Google-Smtp-Source: AGHT+IGbhJJgcRO7Al1j9Lh8J9XP+Tac9kCgzi0rM8m7eBBfpIMCgeyQD/JVdVjpxfvf0xnEldYi3Q==
X-Received: by 2002:a17:902:c711:b0:1c3:e2eb:f79d with SMTP id p17-20020a170902c71100b001c3e2ebf79dmr10770547plp.8.1697490973207;
        Mon, 16 Oct 2023 14:16:13 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id bb11-20020a170902bc8b00b001c5d09e9437sm76976plb.25.2023.10.16.14.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 14:16:12 -0700 (PDT)
Message-ID: <d10c329b-85c9-4bc2-be00-f156c48639e5@acm.org>
Date:   Mon, 16 Oct 2023 14:16:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] Consider inflight IO in io accounting for high latency
 devices
Content-Language: en-US
To:     Gulam Mohamed <gulam.mohamed@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231013195559.1306345-1-gulam.mohamed@oracle.com>
 <35e3e173-8018-42d8-a6e8-7ba994ff6b17@acm.org>
 <CO1PR10MB4563B1B650C89FA32B60AE1298D7A@CO1PR10MB4563.namprd10.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CO1PR10MB4563B1B650C89FA32B60AE1298D7A@CO1PR10MB4563.namprd10.prod.outlook.com>
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

On 10/16/23 13:01, Gulam Mohamed wrote:
> [GULAM]: Yes, it will be called for every submitted bio but for the
> high latency devices it will not have much impact. This is indicated
> by the latency figures I provided in the review mail, with and
> without our patch.

Calling tag iteration code from the hot path is wrong.

There are more devices than only hard disks that have a single hardware
queue, e.g. certain SSDs. I'm pretty sure that this patch will have a
significant negative performance impact for such devices.

Thanks,

Bart.
