Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DE77BD122
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 01:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344957AbjJHXVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 19:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344922AbjJHXVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 19:21:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D10A6;
        Sun,  8 Oct 2023 16:21:18 -0700 (PDT)
Received: from [192.168.0.206] (unknown [179.221.49.143])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5F5AB660708F;
        Mon,  9 Oct 2023 00:21:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696807277;
        bh=n6FyZS8CpZQUQ33bu6wL3AYnS1Dftji3soEkyzZ0Od8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GSjmJuCEEU/d63ysqmYNF+ppD8PPHjhJmgIZCbe/H2M9L+kqYc1HsZB+5ouw1YaDF
         tgvM4WojDp1WpdjG+iCtOQpQphyhycBHXKhR23lmFys6vSioZxfjnAuezCLXVl3YB3
         Qz9BH2x80q5aU19QDIWGVXUIGxbuIBuKel1eeS+oVmEk/qlji5E7Pf14retQP7WY2X
         a2LBo3FgO6cvptP3lJfZ0wID7eyIB9FcnvV2P/c3Si+KM7Cuzi4U48YrQ6AigPSM82
         7dXbSSR8kAE3jw4DqAauqNJFlBKxMNKQttu8LyKAFRXvg2R4Ih2N2qE5MqTe2H4c6+
         /jEgajdueChEQ==
Message-ID: <526457dd-37f2-467d-b583-b710a5e84b97@collabora.com>
Date:   Sun, 8 Oct 2023 20:21:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: Use the encoder for default CRC source
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Daniel Stone <daniels@collabora.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        open list <linux-kernel@vger.kernel.org>
References: <20231008175615.413497-1-robdclark@gmail.com>
 <CAA8EJppgUmkLrhTw779tq5wkgXfu4sypGrQbJFYtrnCrbwa3=Q@mail.gmail.com>
From:   Helen Koike <helen.koike@collabora.com>
In-Reply-To: <CAA8EJppgUmkLrhTw779tq5wkgXfu4sypGrQbJFYtrnCrbwa3=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/10/2023 16:59, Dmitry Baryshkov wrote:
> On Sun, 8 Oct 2023 at 20:56, Rob Clark <robdclark@gmail.com> wrote:
>>
>> From: Rob Clark <robdclark@chromium.org>
>>
>> i-g-t expects the CRC to reflect any applied CTM.  But the layer mixer
>> source is upstream of the DSPP, so it is before the CTM is applied.
>>
>> Switch the default source to 'encoder' instead so that the CRC is
>> captured downstream of the DSPP.
>>
>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>> ---
>>   drivers/gpu/drm/ci/xfails/msm-sc7180-fails.txt |  4 ----
>>   drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt |  5 -----
>>   drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt | 11 +----------
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c       |  6 +++---
> 
> I'm not sure, if updating the CI skip list together with the
> functional changs is a good idea, my preference would be towards two
> separate patches.

On the other hand, having both together in the same patch documents 
which tests this PATCH is fixing.

Regards,
Helen

> 
> Nevertheless:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
>>   4 files changed, 4 insertions(+), 22 deletions(-)
> 
> 
