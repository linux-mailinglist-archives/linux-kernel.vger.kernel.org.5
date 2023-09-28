Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B659E7B1AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjI1L1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjI1L02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:26:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49947CFC;
        Thu, 28 Sep 2023 04:25:00 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 23087660733A;
        Thu, 28 Sep 2023 12:24:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695900299;
        bh=hYbCeLnlTSQfRAgC7ALpkheWCkzbYcpdRuwjsO0GqDs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CKRSIceL+5qHqhFGqwgl1BvbRF73hBlPflXssfoTGIkcUTbdjtWBfByxsrM0hcJo6
         Q2dbBUhqpO/TYIjcwwtAH41K2gOruB3sRfZYXgzyrN7e6bE6M9qkBxCpABERFusjkf
         wS/iTamCpvkHOJCk+SfzC66cDmyGOgPNSS8pS8TEk5UhxMylRYD8fzxDMp6TKauKlH
         0mAGm/4LSUZEA5xXoXpBQKGwRkAYvbO7u1LRl/AwTfdUSRGWVm0tF31gHAFQ68EynQ
         yqWL8CNIGCBrts58LWr1C0h5EKVmlSshteK352FmtlUneJ3RgP/EutWTqUhtnSFkyu
         WoayComFkmNxg==
Message-ID: <3fd7e291-4254-c6b3-893a-b8e457cccb58@collabora.com>
Date:   Thu, 28 Sep 2023 13:24:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v7 2/5] drm/panfrost: Add fdinfo support GPU load metrics
Content-Language: en-US
To:     =?UTF-8?Q?Adri=c3=a1n_Larumbe?= <adrian.larumbe@collabora.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        healych@amazon.com, kernel@collabora.com,
        tvrtko.ursulin@linux.intel.com, boris.brezillon@collabora.com
References: <20230927213133.1651169-1-adrian.larumbe@collabora.com>
 <20230927213133.1651169-3-adrian.larumbe@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230927213133.1651169-3-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/09/23 23:29, Adrián Larumbe ha scritto:
> The drm-stats fdinfo tags made available to user space are drm-engine,
> drm-cycles, drm-max-freq and drm-curfreq, one per job slot.
> 
> This deviates from standard practice in other DRM drivers, where a single
> set of key:value pairs is provided for the whole render engine. However,
> Panfrost has separate queues for fragment and vertex/tiler jobs, so a
> decision was made to calculate bus cycles and workload times separately.
> 
> Maximum operating frequency is calculated at devfreq initialisation time.
> Current frequency is made available to user space because nvtop uses it
> when performing engine usage calculations.
> 
> It is important to bear in mind that both GPU cycle and kernel time numbers
> provided are at best rough estimations, and always reported in excess from
> the actual figure because of two reasons:
>   - Excess time because of the delay between the end of a job processing,
>     the subsequent job IRQ and the actual time of the sample.
>   - Time spent in the engine queue waiting for the GPU to pick up the next
>     job.
> 
> To avoid race conditions during enablement/disabling, a reference counting
> mechanism was introduced, and a job flag that tells us whether a given job
> increased the refcount. This is necessary, because user space can toggle
> cycle counting through a debugfs file, and a given job might have been in
> flight by the time cycle counting was disabled.
> 
> The main goal of the debugfs cycle counter knob is letting tools like nvtop
> or IGT's gputop switch it at any time, to avoid power waste in case no
> engine usage measuring is necessary.
> 
> Add also documentation file explaining the possible values for fdinfo's

Also add a documentation file explaining .....

or

Moreover, add a documentation file explaining .....

> engine keystrings and Panfrost-specific drm-curfreq-<keystr> pairs.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>

Nitpick apart:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


