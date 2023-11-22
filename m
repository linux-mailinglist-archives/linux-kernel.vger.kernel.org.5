Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1B87F5382
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjKVWlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjKVWlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:41:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8070612A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:41:10 -0800 (PST)
Received: from [10.3.2.161] (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CF1CD6602F39;
        Wed, 22 Nov 2023 22:41:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700692869;
        bh=YLlCSf+NzrZNydyhBp3MPNZ8G11GHErGKOTZJ/5sNTo=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=QBrdsNMTMonJCrJHGiT37mW1eIW+Qf/tKsEL71pMVOtdkrALk92oZ3AcNnUF0S6HG
         dJRMJzXNzT7cAV1Hrz4mTTqKNnRnQvgEfO83o5W9qj47FkWf3joxqxsoyiUyBPQZxp
         Am2KPFZ0OU+YcWhtXofm8EU9SBcUnM6HwCS6UNlGJBYX9lBFX/LqhuJm6C2NTlWtvc
         h5lctqxjtBd27m4tjywS09u+UaRPFQFdyzOnLTmnRC6DWVI95Z2nRzSnIlZSK1f3HI
         MBIseQ7VHz8idIqu9xpr4hDgBMV2+JvCgEJmI6vqux7NmuPn0vY5tU3V+DJ5LwHXGg
         bauxjH8z3J7UQ==
Message-ID: <88b34086-894e-9697-37ca-2492b15e3b83@collabora.com>
Date:   Thu, 23 Nov 2023 01:41:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v18 24/26] drm/virtio: Attach shmem BOs dynamically
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
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
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
 <20231029230205.93277-25-dmitry.osipenko@collabora.com>
 <20231113105745.7543e8dd@collabora.com>
 <fe7188d5-d70c-0f4a-7998-99f2efcffdb6@collabora.com>
In-Reply-To: <fe7188d5-d70c-0f4a-7998-99f2efcffdb6@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/23 01:37, Dmitry Osipenko wrote:
> On 11/13/23 12:57, Boris Brezillon wrote:
>> On Mon, 30 Oct 2023 02:02:03 +0300
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
>>
>>> Prepare for addition of memory shrinker support by attaching shmem pages
>>> to host dynamically on first use. Previously the attachment vq command
>>> wasn't fenced and there was no vq kick made in the BO creation code path,
>>> hence the attachment already was happening dynamically, but implicitly.
>>> Making attachment explicitly dynamic will allow to simplify and reuse more
>>> code when shrinker will be added. The virtio_gpu_object_shmem_init() now
>>> works under the held reservation lock, which will be important to have for
>>> shrinker to avoid moving pages while they are in active use by the driver.
>> Ah, this commit might actually help getting rid of the workaround
>> introduced in "drm/shmem-helper: Add common memory shrinker".
> 
> Not really. The virtio_gpu_free_object() is unchanged, it's only
> allocation that is being deferred and it's only done for a one BO type
> (virtio-gpu has multiple BO types).

s/allocation/attachment/

Pages are still allocated by virtio_gpu_object_create().

-- 
Best regards,
Dmitry

