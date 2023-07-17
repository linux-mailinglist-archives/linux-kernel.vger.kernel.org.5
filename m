Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C749755CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjGQHUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjGQHUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:20:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A93CE2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:20:07 -0700 (PDT)
Received: from [192.168.2.153] (109-252-154-2.dynamic.spd-mgts.ru [109.252.154.2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A88486603203;
        Mon, 17 Jul 2023 08:20:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689578406;
        bh=2azQJ2Y4SSayyaeHVwWvWOeHAUzUtm51R0fJQMMVQ5c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QHaic3iJQAnUh41LPL/dSxbTzIoLUHJUqvA9Ca1tskxSrpSt8oXSxP50SxH+ur4tx
         /M19RkGlQGU3ywi/XWLXSf4C9qJau1esH0awecUt3jsSQ88rIgga/XZzYGCb5Z7+AA
         Zu3gwmBu4OT9MXtYwwdryWn8LZsBUudGGRDIgcDFHbIRqL4XSUI1cPkb3Lh28JF/D+
         BPVKiqTpwGIbWoiTbqPyLDY/+4L3NTMkCjVHouapZULziLYjhxuu3caF1cJu7DT62a
         sGNhb8kbkBIcRQzvcGrr0paHt8hVQz/E9i/yJc+1kNUyaotcK1+8YxUaL5ujj9SSPK
         HyEyIDEP7XZdQ==
Message-ID: <80de081a-e443-85a2-1a61-6a8885e8d529@collabora.com>
Date:   Mon, 17 Jul 2023 10:20:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v1] drm/panfrost: Sync IRQ by job's timeout handler
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230717065254.1061033-1-dmitry.osipenko@collabora.com>
 <20230717090506.2ded4594@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230717090506.2ded4594@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/17/23 10:05, Boris Brezillon wrote:
> Hi Dmitry,
> 
> On Mon, 17 Jul 2023 09:52:54 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> Panfrost IRQ handler may stuck for a long time, for example this happens
>> when there is a bad HDMI connection and HDMI handler takes a long time to
>> finish processing, holding Panfrost. Make Panfrost's job timeout handler
>> to sync IRQ before checking fence signal status in order to prevent
>> spurious job timeouts due to a slow IRQ processing.
> 
> Feels like the problem should be fixed in the HDMI encoder driver
> instead, so it doesn't stall the whole system when processing its
> IRQs (use threaded irqs, maybe). I honestly don't think blocking in the
> job timeout path to flush IRQs is a good strategy.

The syncing is necessary to have for correctness regardless of whether
it's HDMI problem or something else, there could be other reasons for
CPU to delay IRQ processing. It's wrong to say that hw is hung, while
it's not.

-- 
Best regards,
Dmitry

