Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAC47EBAFE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 02:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjKOBod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 20:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKOBoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 20:44:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29291DE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 17:44:29 -0800 (PST)
Received: from [10.3.2.161] (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 33DBE6602F2D;
        Wed, 15 Nov 2023 01:44:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700012667;
        bh=G2HdRE//PMPfIFvEPPpVcfoOz5Ri+WdmmDFy6ZQPcd8=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=ZYyq9jjXR57vMgRa1L3ebvcNwd2ChtruumeASWm94tRTii+hBpktDdzYPG+NvF2Pe
         Z+ppaB0fqRlDljPxqmo1I9Lu9FFTYvtzXW+XemLDRFghNa3t54x6xhJ0JI52u3tuY8
         isBV3MRDwq2TXC7jfAK0l6+BZWeSexm912HZxde03+8ibXJhzm9G0db99qfldiqeVK
         yLE4F0FtPZvEwa7UuLv7m558mslKGaiJRQCcJpl+pvpz7pl+zyg7M6AvHEw9uc2tBJ
         ikHrOXRIFzaPMS4pC3yHchiFzHtF5S2LDnkIh1Y8/iyUAb6sC/4ry0pb2ChLsrfcnJ
         ymu419nS3VJ+Q==
Message-ID: <3404c7ca-c0aa-cf23-a2ba-521dbc339780@collabora.com>
Date:   Wed, 15 Nov 2023 04:44:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] drm/virtio: Fix return value for
 VIRTGPU_CONTEXT_PARAM_DEBUG_NAME
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20231111224236.890431-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20231111224236.890431-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/23 01:42, Dmitry Osipenko wrote:
> The strncpy_from_user() returns number of copied bytes and not zero on
> success. The non-zero return value of ioctl is treated as error. Return
> zero on success instead of the number of copied bytes.
> 
> Fixes: 7add80126bce ("drm/uapi: add explicit virtgpu context debug name")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 1e2042419f95..e4f76f315550 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -665,6 +665,7 @@ static int virtio_gpu_context_init_ioctl(struct drm_device *dev,
>  				goto out_unlock;
>  
>  			vfpriv->explicit_debug_name = true;
> +			ret = 0;
>  			break;
>  		default:
>  			ret = -EINVAL;

Applied to misc-next

-- 
Best regards,
Dmitry

