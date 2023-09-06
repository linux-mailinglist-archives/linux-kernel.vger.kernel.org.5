Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9069B793D30
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240785AbjIFMz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjIFMz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:55:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0F5171D;
        Wed,  6 Sep 2023 05:55:53 -0700 (PDT)
Received: from [192.168.68.123] (unknown [177.134.102.128])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 29A4466003B2;
        Wed,  6 Sep 2023 13:55:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694004952;
        bh=gQjLPgDF2IlvGX/ivEQAkZ/M9eYcT+pDslwhGu6fvqU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WXui+qTPSrp44IssO5ZBkHXw544P0fb5Y3CzDPL3YicNCTPnMyfdbjl1CV0j/l1xv
         d+O44yAcdFrmSgWxmceGHHbpMhGrHEWH5r/vosgrBap0NP2FV1KMkTr669XjZUuD7y
         EYhAHClhlpL5BCxVelqnDeaKxACc/DzOrF2VjgxP5etJzl0xjCXinnVtQjS4gEYho5
         uN1D0EWzLtsSSR8q+V+/lxh65WJ9DtN+QEJRbZ+jG23wvQAwM7r9/tRCbswpgNd81N
         rUz/x2gv6EA214pFDzmdycK6iquRo9e2P9v8u9TrGCOkZmmLZD7DjBHsEhGly9Au+6
         FJ6F29debKmbQ==
Message-ID: <cb1b9fea-d74f-fc32-a771-79713cf15674@collabora.com>
Date:   Wed, 6 Sep 2023 09:55:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 2/7] drm: ci: Force db410c to host mode
To:     Vignesh Raman <vignesh.raman@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        david.heidelberg@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com, emma@anholt.net,
        robclark@freedesktop.org, robdclark@google.com, anholt@google.com,
        robdclark@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, mripard@kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
References: <20230904161516.66751-1-vignesh.raman@collabora.com>
 <20230904161516.66751-3-vignesh.raman@collabora.com>
Content-Language: en-US
From:   Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20230904161516.66751-3-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi!

On 04/09/2023 13:15, Vignesh Raman wrote:
> Force db410c to host mode to fix network issue which results in failure
> to mount root fs via NFS.
> See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c15c80a54dda510743cefd1c4b65b8
> 
> Use fdtoverlay command to merge base device tree with an overlay
> which contains the fix for USB controllers to work in host mode.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
>    - Use fdtoverlay command to merge overlay dtbo with the base dtb instead of modifying the kernel sources
>    
> ---
>   drivers/gpu/drm/ci/build.sh                         |  5 +++++
>   .../gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts  | 13 +++++++++++++
>   2 files changed, 18 insertions(+)
>   create mode 100644 drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
> 
> diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> index 7b014287a041..92ffd98cd09e 100644
> --- a/drivers/gpu/drm/ci/build.sh
> +++ b/drivers/gpu/drm/ci/build.sh
> @@ -92,6 +92,11 @@ done
>   
>   if [[ -n ${DEVICE_TREES} ]]; then
>       make dtbs
> +    if [[ -e arch/arm64/boot/dts/qcom/apq8016-sbc.dtb ]]; then
> +        dtc -@ -I dts -O dtb -o drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dtbo drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
> +        fdtoverlay -i arch/arm64/boot/dts/qcom/apq8016-sbc.dtb -o arch/arm64/boot/dts/qcom/apq8016-sbc-overlay.dtb drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dtbo
> +        mv arch/arm64/boot/dts/qcom/apq8016-sbc-overlay.dtb arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
> +    fi
>       cp ${DEVICE_TREES} /lava-files/.
>   fi
>   
> diff --git a/drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts b/drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
> new file mode 100644
> index 000000000000..57b7604f1c23
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
> @@ -0,0 +1,13 @@
> +/dts-v1/;
> +/plugin/;
> +
> +/ {
> +    fragment@0 {
> +        target-path = "/soc@0";
> +        __overlay__ {
> +            usb@78d9000 {
> +                dr_mode = "host";
> +            };
> +        };
> +    };
> +};


Another thing that I was discussing with David and Vignesh, since we 
will need this overlay spinets not only for drm-ci but also for mesa ci 
(and every body who uses the farms), would it be interesting to move it 
to some place more official? like dts folders? Or would that be against 
Linux policy?


Regards,
Helen
