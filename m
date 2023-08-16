Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FD277EAD9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346181AbjHPUjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346186AbjHPUi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:38:56 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135C02708
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:38:55 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-565f24a5c20so172263a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692218334; x=1692823134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cF1BM3f2bxhcGy+lZOB+pU20s/yGXG20KfnXyoafx1I=;
        b=S1cecA8Y35UFe/B7wgZ82/ZTWMSsufbVjFnSUYcJB3o8aMW/V3gdW/NqqjLGmO+/Nr
         p8v0eiPJZuYK4vEcgNTVWplYOR4aqODDHJvhA5an/IVfLeY6N1sDRsz3rQxNBzwBiMVD
         4gs2IAjxEHrARmE99bg7/U1Ht2qAQtqmWPVuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692218334; x=1692823134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF1BM3f2bxhcGy+lZOB+pU20s/yGXG20KfnXyoafx1I=;
        b=Yb6sjPyVGwXjDL/Adyg0lYJzTkUyPtWywjIzm2hLnkhhsJ8420wib2KbTf4lcFLXOM
         UWUrwH7p0H0FVDazNC/w86obKLri8XLKokAGPxO6SIKMy62SyMp0+7LwXD9mJIDicdDU
         wC6S3/o8fjrzOBbvFEirjZAtcxwPDeBG6tKLOilsapNGlakGN2aYfMqpMXx5ur7Jyftk
         dyjUkbu22PnW1xdlvC7J2rkieUmWi7VFDuLki9hVTbool5RnTZ1QQeVHUE4PYX1s4ftu
         dr8vX4J6YE65wribqv5i4HDm9S1Ijq9QFjAHmwGPwLmhbsu0zPrRsmVtHEtCsUjEON3g
         gi3g==
X-Gm-Message-State: AOJu0YxZtZioDGs8ASYRxBqHoKD24ZPgKYVHJyJ12V3F4GHwIZgeJ7eJ
        DX/GN7jeY2KrZTM6ybW12ZqHvQ==
X-Google-Smtp-Source: AGHT+IFBs4yFI2ZdF5J+zDBYRSv/8/8CUjxCOKVwBxVARzrU7XVEhR34nZ31QOQcz8vsQ6XyltMRDA==
X-Received: by 2002:a05:6a20:938c:b0:13e:90aa:8c8b with SMTP id x12-20020a056a20938c00b0013e90aa8c8bmr977018pzh.4.1692218334596;
        Wed, 16 Aug 2023 13:38:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i5-20020a63bf45000000b00565cc03f150sm4165109pgo.45.2023.08.16.13.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:38:54 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:38:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2][next] nouveau/svm: Replace one-element array with
 flexible-array member in struct nouveau_svm
Message-ID: <202308161338.1B73172C@keescook>
References: <cover.1692208802.git.gustavoars@kernel.org>
 <087a1c335228bd245192bbb2fb347c9af1be5750.1692208802.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <087a1c335228bd245192bbb2fb347c9af1be5750.1692208802.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:04:06PM -0600, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct nouveau_svm with flexible-array member.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/338
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
