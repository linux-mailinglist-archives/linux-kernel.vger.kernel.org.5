Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B107C4F22
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345729AbjJKJg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjJKJgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:36:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D0CA4;
        Wed, 11 Oct 2023 02:36:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E86C433CD;
        Wed, 11 Oct 2023 09:36:47 +0000 (UTC)
Message-ID: <07237b8b-ecd2-4717-8eda-101e52edf60c@xs4all.nl>
Date:   Wed, 11 Oct 2023 11:36:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 11/54] media: videobuf2: Access vb2_queue bufs array
 through helper functions
Content-Language: en-US, nl
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20231003080704.43911-1-benjamin.gaignard@collabora.com>
 <20231003080704.43911-12-benjamin.gaignard@collabora.com>
 <bd0ba3d3-444a-4288-910f-4b8a84b90750@xs4all.nl>
 <954315b8-3e5c-4583-a904-d20fbd21aa3f@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <954315b8-3e5c-4583-a904-d20fbd21aa3f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2023 11:32, Benjamin Gaignard wrote:
> 
> Le 11/10/2023 à 10:44, Hans Verkuil a écrit :
>> On 03/10/2023 10:06, Benjamin Gaignard wrote:
>>> This patch adds 2 helpers functions to add and remove vb2 buffers
>>> from a queue. With these 2 and vb2_get_buffer(), bufs field of
>>> struct vb2_queue becomes like a private member of the structure.
>>>
>>> After each call to vb2_get_buffer() we need to be sure that we get
>>> a valid pointer so check the return value of all of them.
>> This needs to be extended: checking the returned pointer is a preparation
>> for when buffers can be deleted. As it is right now, checking for a
>> NULL pointer isn't needed.
>>
>> I wonder if it isn't better to drop those checks and instead apply them
>> at the tail end of this series when the actual work on deleting buffers
>> starts (before patch 49, I think).
> 
> I think that checking vb2_get_buffer() return value while removing direct
> call to queue buffers array doesn't hurt here.
> It is also needed to do that before "media: videobuf2: Add helper to get queue number of buffers" patch.

If we convert the drivers first, then there is (I think) no need to
split this patch in two parts, since then this patch is part of a much
shorter series and it is sufficient to just mention in the commit log
that the pointer checks prepare for deleting buffers.

Regards,

	Hans

> 
> Regards,
> Benjamin
> 
>>
>> Regards,
>>
>>     Hans
>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>> ---
>>>   .../media/common/videobuf2/videobuf2-core.c   | 151 +++++++++++++-----
>>>   .../media/common/videobuf2/videobuf2-v4l2.c   |  51 ++++--
>>>   2 files changed, 146 insertions(+), 56 deletions(-)
>>

