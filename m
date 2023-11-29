Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AD17FDB66
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjK2P3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjK2P3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:29:12 -0500
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [IPv6:2001:41d0:203:375::ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131C6D43
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:29:19 -0800 (PST)
Message-ID: <0c2efe49-03db-4616-a4e5-26ff0434e323@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701271757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8oj8NqBU6PvsJkrw0mP5/tdKRY1iPOIpTDWPs7tNcdE=;
        b=HPus4F3FMmbIqNJQzFTIAo9HB0eWDFdXdKvnw6QL5Rp5aEV8A4LNIKR2WOvqID06ZbwgEv
        mtwS8FO0s2eJHn/JUmKoqtcZtUM57btzOL1xXjLE0y/Ih8Vjh43dXSx90tMspRNGT/nMhI
        GzstSrHYhJLRYv47ExNn+CguKXmc+BU=
Date:   Wed, 29 Nov 2023 23:29:10 +0800
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/5] virtio_net: Add page_pool support to improve
 performance
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Liang Chen <liangchen.linux@gmail.com>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
        kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        pabeni@redhat.com, alexander.duyck@gmail.com
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <20230526054621.18371-2-liangchen.linux@gmail.com>
 <c745f67e-91e6-4a32-93f2-dc715056eb51@linux.dev>
 <20231129095825-mutt-send-email-mst@kernel.org>
 <b699fbc8-260a-48e9-b6cc-8bfecd09afed@linux.dev>
In-Reply-To: <b699fbc8-260a-48e9-b6cc-8bfecd09afed@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/11/29 23:22, Zhu Yanjun 写道:
>
> 在 2023/11/29 22:59, Michael S. Tsirkin 写道:
>> On Wed, Nov 29, 2023 at 10:50:57PM +0800, Zhu Yanjun wrote:
>>> 在 2023/5/26 13:46, Liang Chen 写道:
>>
>> what made you respond to a patch from May, now?
>
> I want to apply page_pool to our virtio_net. This virtio_net works on 
> our device.
>
> I want to verify whether page_pool on virtio_net with our device can 
> improve the performance or not.
>
> And I found that ethtool is wrong.
>
> I use virtio_net on our device. I found that page member variable in 
> rq is not used in recv path.
>
> When virtio_net is modprobe, I checked page member variable in rq with 
> kprobe or crash tool.  page member variable in rq is always NULL.
>
> But sg in recv path is used.
>
> So how to use page member variable in rq? If page member variable in 
> rq is always NULL, can we remove it?
>
> BTW, I use ping and iperf tool to make tests with virtio_net. In the 
> tests, page member variable in rq is always NULL.


And I replaced page member variable in rq with page_pool, but the 
statistics of page_pool are always 0.

It is interesting that page_pool member variable in rq is not used in 
ping and iperf tests.

I am not sure what tests can make page member variable not NULL. ^_^

Best Regards,

Zhu Yanjun


>
> It is interesting.
>
> Zhu Yanjun
>
>>
