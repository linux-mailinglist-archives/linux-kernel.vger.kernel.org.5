Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251637BD04F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 23:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344570AbjJHVcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 17:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjJHVcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 17:32:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AA89D
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 14:32:19 -0700 (PDT)
Received: from [192.168.2.166] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B8BDB6607095;
        Sun,  8 Oct 2023 22:32:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696800736;
        bh=XUtLmucQmSmbTeOzlijxRbhLNkEky+Jw98wNMb8b+Kc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jSl976mlAr4sN985I9ZG4oY1UqjTKcMGlAaA3bEvzUvcT1Pt21wfVmh3x0toX9Lo4
         XOkm5OvIAKAq8mJoiGzBqpkbb2Z8Or6lfmiBRcsPSEFzXJfOASv6QLGI3gN3zsDgdF
         OhzibDAkUNwvWhPQFiZIfX8MwY5Rw1B2yn6rW/13C9OUYbYytdHgNzUhWYqgbWAsR6
         R8t8/gcTF1iFAWhS0Ae9WBaWMU7/O50h5c2nJfn1G1bsXkxE0tohcOUucVgslwxpkr
         Q4+PVq8GVvCUAwelNT47w/cnv7F4Y/eULUSCgB3at+KCetvR/kLx/4sB/USqtH2AED
         v9hIFQjJl6rmA==
Message-ID: <938d1363-849b-0d7d-0ca3-03d6162fe0cd@collabora.com>
Date:   Mon, 9 Oct 2023 00:32:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v17 13/18] drm/shmem-helper: Add memory shrinker
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
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
 <20230914232721.408581-14-dmitry.osipenko@collabora.com>
 <20230915104633.0d5c3932@collabora.com>
 <454c464e-4534-7ec3-6d38-49b7df83c7be@collabora.com>
 <20230926093517.11a172ad@collabora.com>
 <bbbd82a5-41bf-4ca3-476d-e5039e94631b@collabora.com>
 <20231003110055.346fd94c@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20231003110055.346fd94c@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 12:00, Boris Brezillon wrote:
>> I'd prefer to keep refcounting as is, don't see how to implement your
>> suggestion.
> Can you be more specific? I don't really see what the problem is with
> decrementing pages_use_count when you free the sgt (eviction), and
> re-incrementing it when the sgt is restored (swapin).

For the reference, we further discussed this question about refcounting
with Boris offline and found how to implement the refcnt drop done by
shrinker's evict/purge.

For evict/purge we can do:

    if (!refcount_dec_not_one(&shmem->pages_use_count))
        refcount_set(&shmem->pages_use_count, 0);

and then for swapin:

    if (!refcount_inc_not_zero(&shmem->pages_use_count))
        refcount_set(&shmem->pages_use_count, 1);

This resolves the issue with dropping refcnt to zero I was talking
about, allowing to delegate sgt's refcnt ownership to shrinker.

-- 
Best regards,
Dmitry

