Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCA676060D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjGYCzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGYCzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:55:33 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C95ADB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 19:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
        Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hRjHfDosZ8rZOfOyO2tkZTXG7Fh/6Qded8f9S1Smi/4=; b=mccSt1bWK6XW8GojpJNz1uyVyB
        XiKiXXHePHLaAVfTef6eYFhZIcpRBdYPTA2lq1YgMFiwtZGXEX528Bx6eAuEIyq8c0FbUx7vkqS3q
        eGMN53TSmt7/3XJJRAQ2RJNnqvrGaUagIo1rK0iaq3hKmqxF/WwoYpsGjd8789Q3l6Q1DjfOZOZli
        AOmbCkr2qhRnaPT3lYzU9dNdg91NCOEFnNUuRhjhe6FPfyDGasYBmArF4Ud2EIzxl7aP0u5D3nuOg
        qpswXNoaGRGfKDLY5zF6GeOYluWBwk4joh2yxzANJ/Ig78ALQqFYa1tfDOOlwqASzzZqMcift/8mQ
        ADzboskw==;
Received: from [189.111.93.147] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qO8Cj-003P6h-OA; Tue, 25 Jul 2023 04:55:18 +0200
Message-ID: <e292a30f-5cad-1968-de4f-0d43c9c1e943@igalia.com>
Date:   Mon, 24 Jul 2023 23:55:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: Non-robust apps and resets (was Re: [PATCH v5 1/1] drm/doc: Document
 DRM device reset expectations)
To:     dri-devel@lists.freedesktop.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        amd-gfx@lists.freedesktop.org, Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20230627132323.115440-1-andrealmeid@igalia.com>
Content-Language: en-US
In-Reply-To: <20230627132323.115440-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

It's not clear what we should do about non-robust OpenGL apps after GPU 
resets, so I'll try to summarize the topic, show some options and my 
proposal to move forward on that.

Em 27/06/2023 10:23, André Almeida escreveu:
> +Robustness
> +----------
> +
> +The only way to try to keep an application working after a reset is if it
> +complies with the robustness aspects of the graphical API that it is using.
> +
> +Graphical APIs provide ways to applications to deal with device resets. However,
> +there is no guarantee that the app will use such features correctly, and the
> +UMD can implement policies to close the app if it is a repeating offender,
> +likely in a broken loop. This is done to ensure that it does not keep blocking
> +the user interface from being correctly displayed. This should be done even if
> +the app is correct but happens to trigger some bug in the hardware/driver.
> +
Depending on the OpenGL version, there are different robustness API 
available:

- OpenGL ABR extension [0]
- OpenGL KHR extension [1]
- OpenGL ES extension  [2]

Apps written in OpenGL should use whatever version is available for them 
to make the app robust for GPU resets. That usually means calling 
GetGraphicsResetStatusARB(), checking the status, and if it encounter 
something different from NO_ERROR, that means that a reset has happened, 
the context is considered lost and should be recreated. If an app follow 
this, it will likely succeed recovering a reset.

What should non-robustness apps do then? They certainly will not be 
notified if a reset happens, and thus can't recover if their context is 
lost. OpenGL specification does not explicitly define what should be 
done in such situations[3], and I believe that usually when the spec 
mandates to close the app, it would explicitly note it.

However, in reality there are different types of device resets, causing 
different results. A reset can be precise enough to damage only the 
guilty context, and keep others alive.

Given that, I believe drivers have the following options:

a) Kill all non-robust apps after a reset. This may lead to lose work 
from innocent applications.

b) Ignore all non-robust apps OpenGL calls. That means that applications 
would still be alive, but the user interface would be freeze. The user 
would need to close it manually anyway, but in some corner cases, the 
app could autosave some work or the user might be able to interact with 
it using some alternative method (command line?).

c) Kill just the affected non-robust applications. To do that, the 
driver need to be 100% sure on the impact of its resets.

RadeonSI currently implements a), as can be seen at [4], while Iris 
implements what I think it's c)[5].

For the user experience point-of-view, c) is clearly the best option, 
but it's the hardest to archive. There's not much gain on having b) over 
a), perhaps it could be an optional env var for such corner case 
applications.

My proposal for the documentation is: implement a) if nothing else is 
available, have a MESA_NO_RESET_KILL for people that want b), ideally 
implement c) if the driver is able to know for sure that the non-guilty 
apps can still work after a reset.

Thanks,
     André

[0] https://registry.khronos.org/OpenGL/extensions/ARB/ARB_robustness.txt
[1] https://registry.khronos.org/OpenGL/extensions/KHR/KHR_robustness.txt
[2] https://registry.khronos.org/OpenGL/extensions/EXT/EXT_robustness.txt
[3] https://registry.khronos.org/OpenGL/specs/gl/glspec46.core.pdf
[4] 
https://gitlab.freedesktop.org/mesa/mesa/-/blob/23.1/src/gallium/winsys/amdgpu/drm/amdgpu_cs.c#L1657
[5] 
https://gitlab.freedesktop.org/mesa/mesa/-/blob/23.1/src/gallium/drivers/iris/iris_batch.c#L842
