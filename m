Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D267CF254
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjJSIVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjJSIVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623B111F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697703630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6JocWFvICwQAu51spYQ9UkYkn/vFA+DgKSrhAcOeN84=;
        b=HPqAOsmeq6IymvWkm9YEcOzKvts+k3fgyvU6aGKjgQ1PvOFIGWheWXO0hYVK7xDqzsbx++
        WxHUrmj+NxySPYefvdhav69BQFsvufrJbcAYeZkMQbk1n7CLT1NAHl8Ps2h4Ho1ZJFYQWq
        0yCqG1PMgj/jA2k4EfHIgDzJNTvFHCs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-kY8aLpDiOBClVDAnba0TFA-1; Thu, 19 Oct 2023 04:20:28 -0400
X-MC-Unique: kY8aLpDiOBClVDAnba0TFA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-997c891a88dso567022766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697703627; x=1698308427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JocWFvICwQAu51spYQ9UkYkn/vFA+DgKSrhAcOeN84=;
        b=BRdRWMQfzTiLRxCKGcZmlgZ2XZBPo6fdHaFzHkx8+PO2tIKfUpNBlC8/cJR6beHl1f
         d0sIO6u00rFN2mkkzyEslXiPx7BDX58JAy/LfH5sFD43if6Gsmr5mmMWfk2t7mAk4V1x
         UKKUk+E0/gKTbll3MfydYhGDShKrr0FIQjwK0r33gi1WdwxuJY8hxv89lIcuzaPLGSJG
         9kebkBxWTaA8bXguVNdQUNtJ/HxrzQ1Wsrb0RjoMI7cqss6H3FPw3hzRNZpQyUCaBABB
         5/uAFXeZf0pQ9VwekMz8O2Xj/v69IWCtIiGwQiwcGDzTKjdGHdGDg9mYTlHH1HtfaQ/j
         IXhQ==
X-Gm-Message-State: AOJu0Yx7uqrl86fWRPFVeneRJIITv1UZSJgS8j9Lnt9fFyTLGdQx5FSs
        mS+fM72XplI40WL+yVKIcLoemnpHtgDDnAE6MBT5GsupOnv63x67NHvAt0rD7DvIT35IypGZoJR
        GqI83nwT+EWOuDujsDj7yukub
X-Received: by 2002:a17:907:7b89:b0:9c5:844f:a7f4 with SMTP id ne9-20020a1709077b8900b009c5844fa7f4mr1416920ejc.35.1697703627222;
        Thu, 19 Oct 2023 01:20:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTnMKXbHzCyh0CpWl8FqNt59EDAGlNA5Kw8X7mQsKbdb09VixEWWMGkJGLb9zHxDpsNDg2ag==
X-Received: by 2002:a17:907:7b89:b0:9c5:844f:a7f4 with SMTP id ne9-20020a1709077b8900b009c5844fa7f4mr1416904ejc.35.1697703626942;
        Thu, 19 Oct 2023 01:20:26 -0700 (PDT)
Received: from localhost ([193.32.126.216])
        by smtp.gmail.com with ESMTPSA id rn1-20020a170906d92100b0099d45ed589csm3040281ejb.125.2023.10.19.01.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 01:20:26 -0700 (PDT)
Date:   Thu, 19 Oct 2023 10:20:25 +0200
From:   Maxime Ripard <mripard@redhat.com>
To:     Vignesh Raman <vignesh.raman@collabora.com>
Cc:     helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
        david.heidelberg@collabora.com, sergi.blanch.torne@collabora.com,
        guilherme.gallo@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com, emma@anholt.net,
        robdclark@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 9/9] drm: ci: Update xfails
Message-ID: <clpne3ctm2aptl6whv4nxqsjcrqfggkdckocusxjksjirvflsm@6dppwwlqg4bt>
References: <20231019070650.61159-1-vignesh.raman@collabora.com>
 <20231019070650.61159-10-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019070650.61159-10-vignesh.raman@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 19, 2023 at 12:36:50PM +0530, Vignesh Raman wrote:
> diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt
> new file mode 100644
> index 000000000000..8b12e97d59f3
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt
> @@ -0,0 +1,9 @@
> +# https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1013138
> +# https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1012894
> +# https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1013011
> +# https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1013055
> +kms_cursor_legacy@cursor-vs-flip-atomic-transitions
> +kms_force_connector_basic@force-edid
> +kms_force_connector_basic@prune-stale-modes
> +kms_prop_blob@invalid-set-prop
> +kms_prop_blob@invalid-set-prop-any

We agreed recently to provide more context to flakes going forward, see:
https://lore.kernel.org/dri-devel/ax6tspeffujmk2vpvh6rwclqkkavpezvcubra25vs2ev7f5njs@2rpnycg2rgnj/

I'll send a doc update to make that formal (and discuss it at XDC if needed)

Maxime

