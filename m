Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2197DC92E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343771AbjJaJMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjJaJMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:12:43 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395CA9F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:12:41 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-41cd7a3e8f8so39757331cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698743560; x=1699348360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0BRx8gZoE9fOWKsHw60pqFlz6sDQAcL5kgFNRqM8gpY=;
        b=EE8/N5AcZs5D6R5XBDm7Gwh3piwUMoP3wZyctDyP0+AMSgL8WBMtLqrbQwRa1rkx+n
         vsAI/u0U8t20NJgq33LeAXTNiqlc874ziZ//StMo9RfwpJD2zqxkW+shk6Mn0PD8Kdr7
         xQSmxOf1AAXQPpkNWKyJFrnq95xyQlhJNfYns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698743560; x=1699348360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0BRx8gZoE9fOWKsHw60pqFlz6sDQAcL5kgFNRqM8gpY=;
        b=LgvEG2ss+HSQWXJxL1aId4/6YzzRq2RtP33RcXE+gwi2Amjl4Rk+eH7+ofEF0KXuDd
         gfduC7+yjL12/lfnuEekQWRyPP+CT9ZOZsdldg5orbBnODy/jZ6NpTfZO/i8UhQqqMUx
         t+5Q+nDcvCfVQUoDyXc8chYgAytMF+lFWK9Hmcv9vtaAhSOk4tR5pZg+eSihr0dM2fCe
         pLQujNv9quOd9OVFUNZhSmhtmfTHdI1/wv/BsfhTU5yQwMYiT7JBHjRF4F9Vx7ur03MR
         cyk3+sznqqaZg5nb8sBF8gxo6CI4NewFafb7qDKPfC9xHig/QVmY7IO5ROCsTO4Q8YaS
         ejwA==
X-Gm-Message-State: AOJu0YxvZg+7cuhXDPYxFS7erGYyaL2spfENL8KE7gZ19/I2xqdfJIuY
        vy7dMxSzkbT5yA7cTTIPW0qvUT2842lMbdVRQSY=
X-Google-Smtp-Source: AGHT+IFBLsHOG6JQncEXzvoZ+IzeRLZ052FYOz+Epy6y9itpTWi4x5nD6W89dEcLnEcDx76vQl/z1Q==
X-Received: by 2002:a05:622a:3d0:b0:418:110e:6179 with SMTP id k16-20020a05622a03d000b00418110e6179mr15579816qtx.1.1698743560085;
        Tue, 31 Oct 2023 02:12:40 -0700 (PDT)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id h9-20020ac81389000000b004195faf1e2csm327853qtj.97.2023.10.31.02.12.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 02:12:39 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-66d093265dfso35090946d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:12:39 -0700 (PDT)
X-Received: by 2002:a05:6214:627:b0:66d:63d6:3600 with SMTP id
 a7-20020a056214062700b0066d63d63600mr15176670qvx.55.1698743558964; Tue, 31
 Oct 2023 02:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231028-uvc-power-v1-1-fa5c376abe78@chromium.org> <20231031002545.GF12764@pendragon.ideasonboard.com>
In-Reply-To: <20231031002545.GF12764@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 31 Oct 2023 10:12:24 +0100
X-Gmail-Original-Message-ID: <CANiDSCuiUWEQ292Lt2RnZ2OjXA4pATxdEufkLDBzpYLk74yY+g@mail.gmail.com>
Message-ID: <CANiDSCuiUWEQ292Lt2RnZ2OjXA4pATxdEufkLDBzpYLk74yY+g@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix power line control for SunplusIT camera
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yunke Cao <yunkec@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

>
> No need to resend for the typo, I'll fix it locally.

Thanks!
>
