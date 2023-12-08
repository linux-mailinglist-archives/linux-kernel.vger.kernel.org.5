Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1787980A24B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573590AbjLHLeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHLeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:34:22 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2324B11D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:34:29 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d3644ca426so19157817b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702035268; x=1702640068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ioy7a4mjD1TM5aUtdQWmEC4pgXl3wwexCFdK6aCY8Cc=;
        b=giCreBYvncCZ6/Io7X9V45ZU9cTxZYvEelC13IDRv1edoaTEq4yxql/3MFNoG4Iynd
         q480wb/ag2cQPD9q6JzOkinjdC1EVxF2beHzTTmE75hR1lrPHbtqw2NcucJJEJ/2ZfcL
         ddtDBkmtVSwUMICGCjkuPUitKmFJ9YZXOhYADgPdPye2wKqGt3w0+Og37qyGwIemviKh
         ZHf/QggpWIp4I6XmhcZP9q2BdguvHN28z/JBYui2m4DwxJW+W3L9eNnGD7SLovonZdRb
         tx5S08qkbj98/Ba1sKCzKucMaJH1g4wGCQXOvMBsS/k74dlbcdKbteyhfqRWch7O6VXv
         xqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702035268; x=1702640068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ioy7a4mjD1TM5aUtdQWmEC4pgXl3wwexCFdK6aCY8Cc=;
        b=nzzT9zQYFMrSm6xdE88A+MSbhRgOECBPTV8K9GGPOsNAKJXg0ms719NFrlaX+c3Fso
         yIt1+y2KFIja1h3X9ObwzOiv5Vr/CmjmGzIBtnUOjVca3TJyY+cEMH7DJqTEmb7yGora
         xtOhiLMY56KjACkGB+3kVpK9zz1KXdenxDEAgJB/3hYH3sHQT+7GpsBL1eyE69UU8I1B
         N8tPS5lg+W8ESkHpnWiygZo7l4dfuZYjfyfI87AkSgr4Gmau/NRe/E611TeCb2hMGBRe
         ON3F42EvjV8rzPCUH4hF8tpD0tvWksScla7zKMxFauIxLmunOfiQpVN3/lAK2iXyVnrp
         d74A==
X-Gm-Message-State: AOJu0Yyi5xHZ8ZYXZ/aTm1KF6nWgbzyO1C5HsuVBzy7MPd6gmsMIGpKH
        a0iqkHoB85djUMX28mtKSU02Sw3muDF3kl7+MqK8dQ==
X-Google-Smtp-Source: AGHT+IEnxfoJSBiNek6sdMc7Ud4skvctpIP2+cEf8vddxE69b7AorZ3VH3y8fLa2ZwsZWhID77sUwyYka6dZEElUZlU=
X-Received: by 2002:a0d:cbc4:0:b0:5de:955e:24a6 with SMTP id
 n187-20020a0dcbc4000000b005de955e24a6mr639733ywd.2.1702035268406; Fri, 08 Dec
 2023 03:34:28 -0800 (PST)
MIME-Version: 1.0
References: <20231208050641.32582-1-quic_abhinavk@quicinc.com> <20231208050641.32582-11-quic_abhinavk@quicinc.com>
In-Reply-To: <20231208050641.32582-11-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 13:34:17 +0200
Message-ID: <CAA8EJpowcKmn_xXbmwXZGiTJXuwJcArjyDii7m1WjofPE_xoxA@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] drm/msm/dpu: add CDM related logic to dpu_hw_ctl layer
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 07:07, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> CDM block will need its own logic to program the flush and active
> bits in the dpu_hw_ctl layer.
>
> Make necessary changes in dpu_hw_ctl to support CDM programming.
>
> changes in v2:
>         - remove unused empty line
>         - pass in cdm_num to update_pending_flush_cdm()
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 35 ++++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h | 12 ++++++++
>  2 files changed, 47 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
