Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB59A76A455
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjGaWrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGaWrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:47:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2125D19A4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 15:47:11 -0700 (PDT)
Received: from [192.168.2.174] (109-252-150-127.dynamic.spd-mgts.ru [109.252.150.127])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8EFBD6606FC2;
        Mon, 31 Jul 2023 23:47:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690843629;
        bh=3iLo+/X9Y+dd0aWL6FQv0wmSSpmb4uuYk6gaieZ7DU4=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=UNFEriavW1MbAfrmjfwXHPQBEkxiaSm45DZJJmk+ktPi+ftYrSpmjkvZ6jgcuP8ZJ
         HSgMyPYLvLp4Ig903kkkxHqXqlonWSmhC68fntkjnSot59ipMYp56+rtJ/VWd7FKYi
         WxN6k+1bvPBIxEWgOTJstnh6q/ePg3F3Eq6rlzVezXhWGJPOEhIiUi5VBEXV1GhyQL
         fNWGD9h4T6JwOPfKqezBP4fQSeFeAsjC9/1vSMU+6L1Mx/9P+nZ/vtB8E2kQH0CH4h
         hJBWcKuHzCljtCOLxgjPNt6CRhviJNtiNnaJ70TJMO52RhaUZlIgraMZcsu0x6Srgo
         O3ITQGhRrxLSA==
Message-ID: <c2ffc32d-d042-2ab1-b25c-07582e22859e@collabora.com>
Date:   Tue, 1 Aug 2023 01:47:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v6 3/3] drm/virtio: Support sync objects
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <20230416115237.798604-4-dmitry.osipenko@collabora.com>
In-Reply-To: <20230416115237.798604-4-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/23 14:52, Dmitry Osipenko wrote:
> Add sync object DRM UAPI support to VirtIO-GPU driver. Sync objects
> support is needed by native context VirtIO-GPU Mesa drivers, it also will
> be used by Venus and Virgl contexts.
> 
> Reviewed-by; Emil Velikov <emil.velikov@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c    |   3 +-
>  drivers/gpu/drm/virtio/virtgpu_submit.c | 219 ++++++++++++++++++++++++
>  include/uapi/drm/virtgpu_drm.h          |  16 +-
>  3 files changed, 236 insertions(+), 2 deletions(-)

Applied to misc-next

Made a minor comment change that was requested by Geert Uytterhoeven and
took into account that outfence now could be NULL after the recent
virtio-gpu changes

-- 
Best regards,
Dmitry

