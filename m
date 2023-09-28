Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E447B1AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjI1L06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjI1L02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:26:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0351A5;
        Thu, 28 Sep 2023 04:24:54 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B1C106607337;
        Thu, 28 Sep 2023 12:24:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695900292;
        bh=CppPHmkoLt+zjmY2qAg60/g1MggRcPf5o7BrilZYcSM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NsftOWZCWUP2/39arzsyP0pYJZPB9p7utGw2Z/2IiqZb7hZM5lDxEd/KLlSOzY2pn
         mKVHuopcahUsicUAE8y4EPA/gRHwbvPuCY1bKnnyJOHaSH+QFYqsJwWncfIy/oCnR3
         ceoMqcG3ODtVkGg8GCuKkcub4N4h4+OtWzhYkdnovbGRkdeED+uBISZJEtMat3zYuW
         OMO4Oi17EDMX2cS0ULtKlm3zO2t6W7T+T7rXD74kAhWeXWb4eFDiVnky9+6GkHnxTa
         jSDCcozJyMNUeuhUBk3imaFOGo04EH/V/LsisDbHBDFvQ8aFjn4Xko+cZNgwl1IIDT
         zgIt+K/jVXYBA==
Message-ID: <df035e27-b19e-fd4c-d31c-316d526afc4f@collabora.com>
Date:   Thu, 28 Sep 2023 13:24:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v7 4/5] drm/drm_file: Add DRM obj's RSS reporting function
 for fdinfo
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
 <20230927213133.1651169-5-adrian.larumbe@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230927213133.1651169-5-adrian.larumbe@collabora.com>
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
> Some BO's might be mapped onto physical memory chunkwise and on demand,
> like Panfrost's tiler heap. In this case, even though the
> drm_gem_shmem_object page array might already be allocated, only a very
> small fraction of the BO is currently backed by system memory, but
> drm_show_memory_stats will then proceed to add its entire virtual size to
> the file's total resident size regardless.
> 
> This led to very unrealistic RSS sizes being reckoned for Panfrost, where
> said tiler heap buffer is initially allocated with a virtual size of 128
> MiB, but only a small part of it will eventually be backed by system memory
> after successive GPU page faults.
> 
> Provide a new DRM object generic function that would allow drivers to
> return a more accurate RSS and purgeable sizes for their BOs.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

