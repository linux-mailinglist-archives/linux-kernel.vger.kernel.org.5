Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA87A2C1C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbjIPAc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238459AbjIPAcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:32:01 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2801FCE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:31:09 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a9b41ffe12so1704266b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694824268; x=1695429068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wp9G9s9DRH28HBBlorzfOU/YKDu6BHZ8nl53NHfF+6U=;
        b=fPHTrDFQ9T5JiURp8ToVxhU+mInfJ3UurKHeGsicMzsg8l5zoqI5SMEvQuO7dTLNlK
         Fs56EL/eVEt0XRcnaL4bk4yuHkG1wGX8FE+5WezDFDxsbMEwX92aeH7nvjAsSqcYISY7
         t5Iocen8GGESkM8RHG5zgQQhhzoZ4U4yfAQKvq6HEtSsuCSfQIuLQc5vgFw6/c1YEKwD
         kE5SmaxUQn3T+sVic060tBmW5Qwtb6UHjvPXYtM9LBp2ZLKGArmp2r3/OZeZnGr6pVC+
         nIhVXru8Meck+mAX3fLC/Tp+OkORNM231qxdl0iC01Va+eMbaqVjmkkAZlirIKtcxGZy
         TW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824268; x=1695429068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wp9G9s9DRH28HBBlorzfOU/YKDu6BHZ8nl53NHfF+6U=;
        b=Hrb8WYjC9AAg5X4dmNao0/SzVmHfddP4Ptf7saEZX0j97f6/eBwQpvkzqVP/zAGE3v
         VC14ie5a7kBl9r+om5XHfcVH6YhSnW1PWldFQs5DYjoHnO2u0vkAnYtcvZmeQoDcPNEc
         1v9ezb+z4jvUHRBLxz3ppwOl/U0P1QNumlZsyWBj7fGYTTe4dZ1KRxUrJCUgKpeP/FCg
         yQmKCZpOy0dK7kqaefP562uDquRWH1ji1UsUTMHod35B3zhWnuu+QFdL1cffJ+TTEuC7
         yDUUIAeeuxvEh1LNXKWjJ2iTB1abgXRvZu7g4vqOayndK7qkmxNF1+pI/xwm3D/D8OJR
         VH6g==
X-Gm-Message-State: AOJu0YxABpvLzXxC9uq/bPTzvaDcflJujntJELBJua3BdX32nyTohHam
        UnwDias+XIV+69hjjRjNmfcje9UgoKjvL1nwUOPXrA==
X-Google-Smtp-Source: AGHT+IGM/5enZcjBhS6KYMkOeT141L6ZhN7mMaxpgFhmwQ/mJpnnizdzjkJxQtWVJhtldV6e0+vYCRheZ7GEycJUPHo=
X-Received: by 2002:a05:6808:309b:b0:3ab:8295:f2f1 with SMTP id
 bl27-20020a056808309b00b003ab8295f2f1mr4125798oib.45.1694824268304; Fri, 15
 Sep 2023 17:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230915204426.19011-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20230915204426.19011-1-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 16 Sep 2023 03:30:57 +0300
Message-ID: <CAA8EJpqfvmUiOvwE0PE_pWMt7MHTdNeSo1nCA5xG5ykp4Ln6NQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dsi: skip the wait for video mode done if not applicable
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Hai Li <hali@codeaurora.org>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 23:45, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> dsi_wait4video_done() API waits for the DSI video mode engine to
> become idle so that we can transmit the DCS commands in the
> beginning of BLLP. However, with the current sequence, the MDP
> timing engine is turned on after the panel's pre_enable() callback
> which can send out the DCS commands needed to power up the panel.
>
> During those cases, this API will always timeout and print out the
> error spam leading to long bootup times and log flooding.
>
> Fix this by checking if the DSI video engine was actually busy before
> waiting for it to become idle otherwise this is a redundant wait.
>
> changes in v2:
>         - move the reg read below the video mode check
>         - minor fixes in commit text
>
> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/34
> Fixes: a689554ba6ed ("drm/msm: Initial add DSI connector support")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>


-- 
With best wishes
Dmitry
