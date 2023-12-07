Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BAA808629
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjLGKdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjLGKdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:33:14 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8441AA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:33:20 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bf32c0140so576726e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 02:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701945199; x=1702549999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G7EQ5KcNMD+FJBWqkf4cHHplz7DlKiV0y/rovpjNYk=;
        b=mHlckjvwdE+ckDctbHjSswGalnpiQOIRoapOG9ll4U/ixzhJnV1txER4vu7AipY8Lt
         YmfjKLbCT0wgUU+MF0a376ufdyaXTdCtCJXBsirWUPiHVsb8kglFG2IWOMdHjKdAe0oJ
         voc6T2cHJ4iOy/DJ9WdcptSUJxZGKPJnQVz+e0ExvuRJQZeAIGS8reU4idCP+jK8NSZv
         6NvvPkK+iBlQZwVJYFqao7c1A90UWsSn2G0WOBr0QhNhnyA1rdRQsCGg+DeSPAfcZBUW
         AYCTuZQoWt5XmU1cI6Ok40o9Ce/Re6OT/2cTUl9qbycAITHfBJK79cuPbxHUGLvy4anl
         Nehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701945199; x=1702549999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0G7EQ5KcNMD+FJBWqkf4cHHplz7DlKiV0y/rovpjNYk=;
        b=tUKt4xw/qbwQJmAnLIh8lTeNtt1AUnyYqkugZ8vWiRCtf3LmbDn6I/o/TfuJnHgfEt
         WzbjDXtZNAUpYfCfzesbSWYEhsP5a8Nzre4qHXh250Z8plktZ3naYbbqVQyVF5fOKn+s
         vIY2uclRJLlXlhJmu3Px2x0W3fi6f+vJxbnqeBISQfzvRNe1ajSJmjAKnQ3KmNoUX4cu
         Mesewu47PrgtDYq67j86OWzqKpLc1XzyRPMIiaDm93QnM1LYABugOzh/91O5GYyYVr7E
         dINSr86kW+oms0oLWOyXLCkYMY5mRaRkR+lFVEnIGdjtmQ+qBk1po9scZp1ckdxWMluH
         Ka7A==
X-Gm-Message-State: AOJu0YyogsbXhLYkSRZPmSsuNXdzxUK7x89rXhr0jWkfCcz/kN2yU1GC
        Oo24xD65+m14smSaPBUB/NtdGg==
X-Google-Smtp-Source: AGHT+IElfQrP5//I1yr0A5j3iV0uNq6PB6PrCqFCGPat86Z8HQ+XO+jpbihW4CTlZz6+VkLy4eJv1g==
X-Received: by 2002:a19:5f19:0:b0:50b:e5e6:aa8e with SMTP id t25-20020a195f19000000b0050be5e6aa8emr1318607lfb.127.1701945199127;
        Thu, 07 Dec 2023 02:33:19 -0800 (PST)
Received: from eriador.lan (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24bd1000000b0050c19506428sm138326lfq.170.2023.12.07.02.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 02:33:18 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/debugfs: fix potential NULL pointer dereference
Date:   Thu,  7 Dec 2023 12:33:15 +0200
Message-ID: <170194519139.470483.9628943162805035474.b4-ty@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231205130631.3456986-1-m.szyprowski@samsung.com>
References: <CGME20231205130643eucas1p283a5476b78a87997fa393d00f5172418@eucas1p2.samsung.com> <20231205130631.3456986-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 14:06:31 +0100, Marek Szyprowski wrote:
> encoder->funcs entry might be NULL, so check it first before calling its
> methods. This fixes NULL pointer dereference observed on Rasberry Pi
> 3b/4b boards.
> 
> 

Applied to drm-misc-next, thanks!

[1/1] drm/debugfs: fix potential NULL pointer dereference
      commit: 76385d493c2137460ee7735a5d3a494099c35188

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
