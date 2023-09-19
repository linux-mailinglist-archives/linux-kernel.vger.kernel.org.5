Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144417A6AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjISSYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjISSYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:24:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41E2BC;
        Tue, 19 Sep 2023 11:24:30 -0700 (PDT)
Received: from [192.168.2.59] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 76CD2660319E;
        Tue, 19 Sep 2023 19:24:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695147869;
        bh=46IRBQcTc3xVzoCBaR42oqV61VUa5ntA61hgbQ977h8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VJyfYdN93Ho9wgb/de6ZZaSLk0wJ8j//7QcsdRTdOeexr2iNMDD0/3AJ9G2gqLPLW
         i4KrGMsYzzdq43ICgcz83YRB6pcGkZY+EWO+PmNN7gtF75tdU7qMbLg6SoMvmShFRf
         b0E7EVPF5SQTYFHiix6S9Ax+/dGyo6yIGR1BsU+3p1GxWxVVSGK44hRUmJ6Re5c27i
         HsVlFRqUNo4frzDWAJNOUDRnHcjRI9ZQF7een+0TqI2M8y6YA3K5eEXyx+8v7eAwve
         wvgzvtfqfStwBsSLB0QGUWD7VLP3cAqy0xWOGECbu4KD1HsHfhtPKVfopjHEPbJVLA
         76ZQ1NPw+dk/Q==
Message-ID: <4d533beb-f416-1b22-6d9d-cee7f3cfdad1@collabora.com>
Date:   Tue, 19 Sep 2023 21:24:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
Content-Language: en-US
To:     Zheng Hacker <hackerzheng666@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, Kyrie.Wu@mediatek.com,
        bin.liu@mediatek.com, mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Collabora Kernel ML <kernel@collabora.com>
References: <20230707092414.866760-1-zyytlz.wz@163.com>
 <8c8bd3ec-a5a4-32e4-45b5-ee16eeeac246@collabora.com>
 <CAJedcCxPG1mKtgB7AcJSwaQB_qvODObwq3gz6eM_1w777b2PfQ@mail.gmail.com>
 <54b14ebe-b51b-2744-328d-2adcdaaf6d0e@collabora.com>
 <CAJedcCyn+VHxcSXH+HqP3yiXX8L0wjNao+suti5GgyQzYORcYA@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAJedcCyn+VHxcSXH+HqP3yiXX8L0wjNao+suti5GgyQzYORcYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 11:18, Zheng Hacker wrote:
>> The v4l2_m2m_ctx_release() already should wait for the job_timeout_work
>> completion or for the interrupt fire. Apparently it doesn't work in
>> yours case. You'll need to debug why v4l job or job_timeout_work is
>> running after v4l2_m2m_ctx_release(), it shouldn't happen.
>>
> Yes, v4l2_m2m_cancel_job waits for m2m_ctx->job_flags to be  ~TRANS_RUNNING,
> the mtk_jpeg_job_timeout_work will finally invoke v4l2_m2m_job_finish
> to trigger that.
> 
> However, this is not the only path to call v4l2_m2m_job_finish. Here
> is a invoking chain:
> v4l_streamon
>   ->v4l2_m2m_ioctl_streamon
>     ->v4l2_m2m_streamon
>       ->v4l2_m2m_try_schedule
>         ->v4l2_m2m_try_run
>           ->mtk_jpeg_dec_device_run
>             ->schedule_delayed_work(&jpeg->job_timeout_work...
>             ->error path goto dec_end
>             ->v4l2_m2m_job_finish
> 
> In some specific situation, it starts the worker and also calls
> v4l2_m2m_job_finish, which might
> make v4l2_m2m_cancel_job continues.

Then the error path should cancel the job_timeout_work, or better job
needs to be run after the dec/enc has been started and not before.

Looking further at the code, I'm confused by this hunk:

	mtk_jpeg_dec_start(comp_jpeg[hw_id]->reg_base);
	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);

The job should be marked as finished when h/w has finished processing
the job and not right after the job has been started. So the job is
always completed and mtk_jpeg_job_timeout_work() doesn't work as
expected, am I missing something?

-- 
Best regards,
Dmitry

