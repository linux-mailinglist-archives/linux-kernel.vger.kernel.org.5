Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930DD7B4C58
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjJBHME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbjJBHL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:11:56 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DFDA4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:11:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40566f8a093so130896135e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696230711; x=1696835511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gpBRg7ZJv9bONpjZYFon//mF9X/YfEcB0KhU+2bLc4=;
        b=uOdtpTgR1PC5nTi01dbWtgKXtHSV1GAKt9QZsgVBZX9N4QlOhNJ1+7H0Qsvy+TTuI9
         U0LUt5EpMGoggpfOa5ZkhBnB3MikC9XLr6Ph8RnbjcC6TfaJKabNIc+cUVbBIkKfqnF7
         QUC6fOWG3pqQzikOw3Urlt07syvnbmgQ8y/iL1umhSOGgfkCLT15vOtfftDWadyuNv+J
         vNbybRo5EWwD5gjhS0cGAKq8+PnGQpYENcendB8d9nTJgvrdRt2jOu/fvqYaUNAL4GRb
         /lDO0wvdZHcvgo8fso2riSjWKYFJ3yFE1OEaA1Zyth+eicsNtUWSgK4EOFyjDLDM8hp+
         14LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230711; x=1696835511;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gpBRg7ZJv9bONpjZYFon//mF9X/YfEcB0KhU+2bLc4=;
        b=G2pBFX6ntoM9OJpGQehJM+/cLCg0DgJqwHwj1CFV2VsNAgTXnQNbXsO0GkLPNZlrgM
         hktKNayqJMfFQ0CbhD/xAlG/E1FYrhZlLpqlW/f3TSk4XK3QOJnR4lOSpAiQQ7YIshcf
         QPyooiN8SHULKp2FbYARsScMNtLGHj4Y8t0D90+F3Y+GbIL7/IX2bvkqBfl+6/ghYPvC
         PcvwBEYqKp03y03P8pnaWPHBZh3wuWSlnwSSHmJaw4XpmmW22Iu/okCz/6dB/sVuuulH
         /EC8+D/S9FVqEFJUsMfXRRr9BP0Z9NTkaEfYBDa/tCYIHMEg27l4yfdLhbCDRTiYbdFl
         judA==
X-Gm-Message-State: AOJu0YxdXtdkB4nw419enqbLg0tlJ6iu4KgpeNegz9cS9v123foemnik
        UZciH2/azmLNgUBfybRRY5d5ew==
X-Google-Smtp-Source: AGHT+IGp6rwJzVjTX/tf1duHqs0q+dcoTcEZFTeqfoXaR3JpTTDM5NvXnCpyrxSyqudBktuxzyenTQ==
X-Received: by 2002:a7b:c394:0:b0:403:31a:77b9 with SMTP id s20-20020a7bc394000000b00403031a77b9mr9263029wmj.37.1696230711513;
        Mon, 02 Oct 2023 00:11:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c025900b00405623e0186sm6601371wmj.26.2023.10.02.00.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 00:11:51 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Brown <broonie@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231001-drm-lt9211-maple-v1-1-1cf74fb10991@kernel.org>
References: <20231001-drm-lt9211-maple-v1-1-1cf74fb10991@kernel.org>
Subject: Re: [PATCH] drm/bridge: lt9211: Convert to use maple tree register
 cache
Message-Id: <169623071069.3600226.16796485948138602876.b4-ty@linaro.org>
Date:   Mon, 02 Oct 2023 09:11:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 01 Oct 2023 11:24:49 +0100, Mark Brown wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/bridge: lt9211: Convert to use maple tree register cache
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=eae0cfcce3cd10a9189bf46934de9bde7ad7b2d0

-- 
Neil

