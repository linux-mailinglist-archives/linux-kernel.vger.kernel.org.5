Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3657790982
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 22:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbjIBUWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 16:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjIBUWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 16:22:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DD2CD6
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 13:22:32 -0700 (PDT)
Received: from [192.168.2.205] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DAB036607285;
        Sat,  2 Sep 2023 21:22:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693686150;
        bh=P/RoiQh/m5JLN0080yEWFysq1vNtbx1Z4bobDOQN5tU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QD63jM15RQ112hBL/Aa4GpuUrqWZmpHmRo17bQMiZD/6AoHCYW+LJSawuXr+ouYQh
         WKFzNrOvyd+hbn5T4C05oyMKyh4XuMRBMGh4xydTqNYc/ufouPGsCImsRgI2n4HNBF
         ZeWFOZO8xmgDUyuK8OjbE8qHBPQZod+oiu57mkT5DPXh2PJX3Y91zFgGOCAhRTD2pY
         Y2ZLW6aDSAMAMnQQhIuxGBWD9/Rcusg27THV8B/gYXGBNLH0YSSUjCR6FfIJLuFDhM
         3BY12+KuK0K7DA0l25Szx7SI9KRWWSZGPqx1rU198Zqq6Bu8qFLasCMxdq2QuFqMv8
         vifaHc2iXxFtw==
Message-ID: <9844875a-ee18-85ff-11bd-84bdb2333f6c@collabora.com>
Date:   Sat, 2 Sep 2023 23:22:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v15 16/23] drm/shmem-helper: Use kref for vmap_use_count
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        intel-gfx@lists.freedesktop.org
References: <20230827175449.1766701-1-dmitry.osipenko@collabora.com>
 <20230827175449.1766701-17-dmitry.osipenko@collabora.com>
 <20230828120032.3d86cb15@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230828120032.3d86cb15@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 13:00, Boris Brezillon wrote:
> On Sun, 27 Aug 2023 20:54:42 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> Use kref helper for vmap_use_count to make refcounting consistent with
>> pages_use_count and pages_pin_count that use kref. This will allow to
>> optimize unlocked vmappings by skipping reservation locking if refcnt > 1.
> 
> The core is taking the resv lock before calling ->v[un]map(), so
> switching to a kref sounds a bit premature/useless, unless there are
> plans to delegate the locking to the drivers. The only thing it brings
> is standard overflow/underflow checks. Not really sure it's worth
> transitioning to a kref for this field until we have a real use case.

The overflow checks worth transitioning. I'll mention them in the commit
message for v16.

-- 
Best regards,
Dmitry

