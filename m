Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAE87FB5BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjK1J1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjK1J1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:27:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C26CC;
        Tue, 28 Nov 2023 01:27:57 -0800 (PST)
Received: from [100.122.216.38] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3351366072A7;
        Tue, 28 Nov 2023 09:27:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701163675;
        bh=Z5GZ1cB9pKK23OqS6OplSteBYe8gnO0cBoeNPG8Ac0c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i5RnCMTBTHvS1nFSTQxvTB1oI3D/D8BZLy5P1ETi5ooitBjJKYfaOtGRyv3aH7TxM
         yT9Ue/rJLT7cUpYByL10KqK4iJoTHNFYl4Fwgqw9vH3BbpqgSF1QLUefMll7kiGq18
         +07u33xFwmf/Z2nbeY/23JZD+XKRF2sYf1QshZNJsZPPuSWbzh6wO77FyRI410ZIIJ
         uWs2TtPS6szMZCYRhRvVIFtZxKgAvnxwH8RcaZ1de1YDfPFuhDuBwN3MmsiHI4xsUt
         BOpkmtJi1xKR6iK7fPIw1VsA0YzaQibavK8i4oeVw7rxhd7gdZ+Meomef+VHIaLChE
         od1fkkrUgVbOA==
Message-ID: <7aa0e48b-6ddc-4af3-9b42-aa48c29be2e1@collabora.com>
Date:   Tue, 28 Nov 2023 10:27:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/55] media: test-drivers: Stop abusing of
 min_buffers_needed field
To:     Shuah Khan <skhan@linuxfoundation.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
References: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
 <20231127165454.166373-3-benjamin.gaignard@collabora.com>
 <dd6739ca-72b1-4eb6-9fd6-e18dc974de50@linuxfoundation.org>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <dd6739ca-72b1-4eb6-9fd6-e18dc974de50@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 27/11/2023 à 18:00, Shuah Khan a écrit :
> On 11/27/23 09:54, Benjamin Gaignard wrote:
>> 'min_buffers_needed' is suppose to be used to indicate the number
>> of buffers needed by DMA engine to start streaming.
>> Obvious test-drivers don't use DMA engine and just want to specify
>> the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
>> That 'min_reqbufs_allocation' field purpose so use it.
>> While at it rename function parameter.
>>
>
> So how ate the test-drivers currently abusing this field
> and how does this change benefit?

In videobuf2-core.h min_buffers_needed is documemented as:
"the minimum number of buffers needed before @start_streaming can be called.
Used when a DMA engine cannot be started unless at least this number of buffers have been queued into the driver."

Test-drivers don't use DMA engine so they (ab)use of this variable, like Hans said in this RFC:
https://www.spinics.net/lists/linux-media/msg244455.html

The goal of this series is to distinguish the minimum number of buffers to be allocated in VIDIOC_REQBUF
versus the minimum numbers of buffers needed before start streaming.

Regards,
Benjamin

>
> I don't have objections to this change, I want to understand
> it a bit more. I would like to see more details on why this
> change is needed.

>
> thanks,
> -- Shuah
