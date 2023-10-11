Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC977C4F06
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbjJKJcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjJKJcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:32:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E3F91;
        Wed, 11 Oct 2023 02:32:17 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:b4ac:2b31:7a66:8708] (unknown [IPv6:2a01:e0a:120:3210:b4ac:2b31:7a66:8708])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 675CB66072F1;
        Wed, 11 Oct 2023 10:32:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697016735;
        bh=5tBLJiqzOELHvhOEyitYQraoe9MQBCrZ0Va/cYbiJGQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l7HDeNnyFwiGa8tcEAfmk+SXlkOW9tCJRHAXfwJVRumJnaxWMFC8o4quE1/PV7Cr4
         PIFAOeJxFE0T7QLRoHdfX/+XqrwL3qmvZNS+veOns4PrCVd4NHZWiK8Qcc4Dw/hw1H
         C2JBixXqLmarSHTg5PdMEbhSjcCrlmZeUFFEacCefxEl7NEgWfV6w+LmTRmKtMwfTL
         Q8HspQmkOPgzJZoerILZ+m2mlB4sM3KltcOeZqinhuSoE4xLxuor4Pcz5/YroqkgQq
         QIu/QdzKLyfG9MsdoP+max2m1xHJLZRApA9Ay6GFxpDarzTo78klgKRRPs6DsFOn2q
         Jjq4OV2rglTpw==
Message-ID: <954315b8-3e5c-4583-a904-d20fbd21aa3f@collabora.com>
Date:   Wed, 11 Oct 2023 11:32:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 11/54] media: videobuf2: Access vb2_queue bufs array
 through helper functions
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>, mchehab@kernel.org,
        tfiga@chromium.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20231003080704.43911-1-benjamin.gaignard@collabora.com>
 <20231003080704.43911-12-benjamin.gaignard@collabora.com>
 <bd0ba3d3-444a-4288-910f-4b8a84b90750@xs4all.nl>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <bd0ba3d3-444a-4288-910f-4b8a84b90750@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 11/10/2023 à 10:44, Hans Verkuil a écrit :
> On 03/10/2023 10:06, Benjamin Gaignard wrote:
>> This patch adds 2 helpers functions to add and remove vb2 buffers
>> from a queue. With these 2 and vb2_get_buffer(), bufs field of
>> struct vb2_queue becomes like a private member of the structure.
>>
>> After each call to vb2_get_buffer() we need to be sure that we get
>> a valid pointer so check the return value of all of them.
> This needs to be extended: checking the returned pointer is a preparation
> for when buffers can be deleted. As it is right now, checking for a
> NULL pointer isn't needed.
>
> I wonder if it isn't better to drop those checks and instead apply them
> at the tail end of this series when the actual work on deleting buffers
> starts (before patch 49, I think).

I think that checking vb2_get_buffer() return value while removing direct
call to queue buffers array doesn't hurt here.
It is also needed to do that before "media: videobuf2: Add helper to get queue number of buffers" patch.

Regards,
Benjamin

>
> Regards,
>
> 	Hans
>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   .../media/common/videobuf2/videobuf2-core.c   | 151 +++++++++++++-----
>>   .../media/common/videobuf2/videobuf2-v4l2.c   |  51 ++++--
>>   2 files changed, 146 insertions(+), 56 deletions(-)
>
