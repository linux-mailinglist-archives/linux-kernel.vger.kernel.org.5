Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F947B39F5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjI2SUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2SU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:20:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAEF199
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:20:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c723f1c80fso42999525ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696011627; x=1696616427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/kevk4tNSCK4yq8Y8Eq8euOICXuk1g8ja9WwJ3j9fE=;
        b=ObxzFty48yclGWTgW3DznT3hAu8oEygwLdBhCChH95bXA/2BdRnl3Cf9WHgOH5aLJq
         nVeIiB9v3r6MuEuUO92otna9q+2wYntCfcDoOtFQTP1ae8hK+jPiNExgXe/3imvnK2ou
         QMUkLZx4zyd+p6cf29thDHYN7RZjjg38DfBUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696011627; x=1696616427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/kevk4tNSCK4yq8Y8Eq8euOICXuk1g8ja9WwJ3j9fE=;
        b=X7q+JBQWvPl2nU+gi3QQKsgGyc46IlOfIsbmfD/E2os2BmrW4TVRySvolXiS+fINJj
         OJUJxbDYDHaJMzyxJEKRp3CeaWYWXdynwzPKD/X9SKQgFVGXJpuL7sgEa9eL4bhCS9DI
         K2vXL44Tp3mSJgSIxQsqufGgd23qFmYBKyNg87osY+zkNvHsLF1UQXyIDF3Vtg7FJoFl
         W8EDLX2G7ZB+RGrG9buUPahxjX2tkFIksKZ1MNH5I36CL5PvEQjU3LDm6eAF0M1w0/Bw
         iAK4k1mobpGFjipzqXyVYbyfvz+2yC8SkAoZwb5pXjzbuXp5/QLIBON2gOsYpltnAW+I
         WLtA==
X-Gm-Message-State: AOJu0YyPDuBtrnXfMYc4+fNal0+9jlJbUO8n4YYySUQeJxAWAG6tDRYd
        bavOnoVDRcUkEmwdd8axCCxL4g==
X-Google-Smtp-Source: AGHT+IGcMZNuu5by/ybQZhXigau4jvxccIHAaE4PpspYWQGaz1tg3yDDLn1/20+ox//v17UMP49BKA==
X-Received: by 2002:a17:902:d2c7:b0:1bd:a42a:215e with SMTP id n7-20020a170902d2c700b001bda42a215emr5862019plc.38.1696011626675;
        Fri, 29 Sep 2023 11:20:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v3-20020a1709029a0300b001b850c9d7b3sm17135700plp.249.2023.09.29.11.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:20:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2][next] nouveau/svm: Replace one-element array with flexible-array member
Date:   Fri, 29 Sep 2023 11:20:01 -0700
Message-Id: <169601159821.3006883.15782981674963813068.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692208802.git.gustavoars@kernel.org>
References: <cover.1692208802.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 12:03:06 -0600, Gustavo A. R. Silva wrote:
> This small series aims to replace a one-element array with a
> flexible-array member in struct nouveau_svm. And, while at it,
> fix a checkpatch.pl error.
> 
> Gustavo A. R. Silva (2):
>   nouveau/svm: Replace one-element array with flexible-array member in
>     struct nouveau_svm
>   nouveau/svm: Split assignment from if conditional
> 
> [...]

These look trivially correct and haven't had further feedback for over a month.

Applied to for-next/hardening, thanks!

[1/2] nouveau/svm: Replace one-element array with flexible-array member in struct nouveau_svm
      https://git.kernel.org/kees/c/6ad33b53c9b8
[2/2] nouveau/svm: Split assignment from if conditional
      https://git.kernel.org/kees/c/4cb2e89fea5f

Take care,

-- 
Kees Cook

