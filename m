Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE797FDB1B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjK2PWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbjK2PWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:22:33 -0500
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CDCBE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:22:39 -0800 (PST)
Message-ID: <b699fbc8-260a-48e9-b6cc-8bfecd09afed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701271358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HQiZ+7wAuSeNjpj8apTyPg8hJlrrmCrTI0XRLYKF0N8=;
        b=KVed2Zjgv7XeII9r2X+MTlQ6MpHbUpzjRjxCRVryPjqS7WQgL/klPvl0DGCIJtn+2HJ9i0
        zpbKIVf6tnVZwxthxtzt9g6JYlqiuCCWus9aNEciqYzPTrPZXLvo98bW6UJ4CPgjB7NzAd
        duAQwvGTlZusGXFH/EPUzS2lSrfQJfM=
Date:   Wed, 29 Nov 2023 23:22:30 +0800
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/5] virtio_net: Add page_pool support to improve
 performance
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231129095825-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/11/29 22:59, Michael S. Tsirkin 写道:
> On Wed, Nov 29, 2023 at 10:50:57PM +0800, Zhu Yanjun wrote:
>> 在 2023/5/26 13:46, Liang Chen 写道:
>
> what made you respond to a patch from May, now?

I want to apply page_pool to our virtio_net. This virtio_net works on 
our device.

I want to verify whether page_pool on virtio_net with our device can 
improve the performance or not.

And I found that ethtool is wrong.

I use virtio_net on our device. I found that page member variable in rq 
is not used in recv path.

When virtio_net is modprobe, I checked page member variable in rq with 
kprobe or crash tool.  page member variable in rq is always NULL.

But sg in recv path is used.

So how to use page member variable in rq? If page member variable in rq 
is always NULL, can we remove it?

BTW, I use ping and iperf tool to make tests with virtio_net. In the 
tests, page member variable in rq is always NULL.

It is interesting.

Zhu Yanjun

>
