Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95047DECE0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 07:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjKBGcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 02:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBGcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 02:32:02 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647E2111
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 23:31:57 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9ad90e1038so568635276.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 23:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698906716; x=1699511516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=StUp8Et2C40MeeNi4V7XV6N5+td2AtmdwFbNutMfZZM=;
        b=IbmrE8BTlD5QSLb43KMksTYB4Gj3/nBdPlGRIOE89v5o/Qj8JQpGYGn5EywjKbwI23
         gKV2fO4cMOWLGzzV7B6WKWuFzxseKDgfDkxmz1f7r1gXnaLt048c9GFIm9JQnYYOU9DZ
         2jPFC1BglKD2hrWL4pMBNxqWyR+pSoe17TDywGmhrqgbi2Uty8Q9+xkra7mdmiJsH3Pf
         LFTdqGRK4ApxalQL+wY93vk520Yww0+dtWjlWBMVE+zeKjRqjKvZm3Yb7So3j1zX/6fd
         C3q5I7G5QiUYtAbPGiqaM+onhY8dn6BDJDqBQS1qWJTZP0y/+XdemWnKsMBS2HlQJye1
         /nbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698906716; x=1699511516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StUp8Et2C40MeeNi4V7XV6N5+td2AtmdwFbNutMfZZM=;
        b=VH6gH8QAxSSYbleF9RMLWAfCsPVzYKutFc5Kl20Q6C8iLpF2FlH4DVGMrjAgGqaS0N
         +myDT17ORbcDKhSMCwIWCXB0p9UZk2D0q2/0//xe8hlCpTrsibGSor5/Asl7Eo3mbg/b
         YQWimpgAUuyetDmaXJrPz0DelvAJeNxaGlj2Ewxa7CkUXu7YKosTW8jsSxNn3VfYqf8l
         ozsn2i213q+2d3ya9PRCc7EltToPq6AFjhJAtKIXgev+/LF1r7ZTQm60Hk9X3eUNsZYj
         6FEp3w29DFTmGasuOfr7KVtiGZgKovwRyzVPHkZLscnwT8JupeaZhNkq+/Lmt5bQo5fS
         8F8w==
X-Gm-Message-State: AOJu0Yx8+MaB4rq2pvxNd7eiiOpO6Elr7X+iKwQ25auQUFMfszI2tg5Q
        HxZKWQ0+he3y1/37cD3Ukl11gOHiF8XrCORdM1Z3l755HVYwfLdy
X-Google-Smtp-Source: AGHT+IErkxOJ7DnSFJx36BZcxIVf1TUwHioSsB58JfzUCGvwGWx6kzJyj9h+0s3GWmFHNf2Y9+D53Hc2XaiK5h9CWiM=
X-Received: by 2002:a25:50d0:0:b0:d9a:4839:68fe with SMTP id
 e199-20020a2550d0000000b00d9a483968femr16145403ybb.43.1698906716622; Wed, 01
 Nov 2023 23:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231101212604.1636517-1-hsinyi@chromium.org> <20231101212604.1636517-4-hsinyi@chromium.org>
In-Reply-To: <20231101212604.1636517-4-hsinyi@chromium.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 2 Nov 2023 08:31:45 +0200
Message-ID: <CAA8EJpoPMkQRhCD-9SPSheiio1dH8V6BUv89MZKfZdrBzsBW-w@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/panel-edp: Choose correct preferred mode
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2023 at 23:26, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> If a non generic edp-panel is under aux-bus, the mode read from edid would
> still be selected as preferred and results in multiple preferred modes,
> which is ambiguous.
>
> If a hard-coded mode is present, unset the preferred bit of the modes read
> from edid.

Can we skip the EDID completely if the hardcoded override is present?

>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/drm_modes.c       | 16 ++++++++++++++++
>  drivers/gpu/drm/panel/panel-edp.c |  7 +++++--
>  include/drm/drm_modes.h           |  1 +
>  3 files changed, 22 insertions(+), 2 deletions(-)

Anyway, this should be split into two patches. One for drm_modes.c,
another one for the panel driver.

-- 
With best wishes
Dmitry
