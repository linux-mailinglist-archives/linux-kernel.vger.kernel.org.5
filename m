Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABBD757595
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjGRHme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjGRHm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:42:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9309818C;
        Tue, 18 Jul 2023 00:42:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-316f589549cso2641943f8f.1;
        Tue, 18 Jul 2023 00:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689666143; x=1692258143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HBTUsPX3YvntfTZI2BJwTQrVcbVBz5Q1lYZZhnlWqIQ=;
        b=I0yeZByMpjvvMpotLF/XngYPd2NX9ZEgRea4SAAjHsthZofUp53ZJ7mQKCFDSNA6T+
         sJ5jqO6QZxig93B0Ei08XvG7IoFj3yZAK3SPixMc7PzKXNKuFlcSQKOSTrH6s1hCqPuz
         rwJxduJq61+vXE8Rv3cI7Nqo0pX8kkxRmCZYd+40tTR6+DVcWRfAxkvx/Jn4roL2vXvW
         d3hIhs0uiZwb4noeBxRppCZZ1+1rbKfRm3YwDxmLyV8SlClXNLZtYviku1hWLQ8CPa9r
         onqMgTCKGgslqP/7PUhtgbkamzWqBS7RmCkWZDDGbIZD11He7QQWrAjScZ+YCfd4Gzt7
         hC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689666143; x=1692258143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBTUsPX3YvntfTZI2BJwTQrVcbVBz5Q1lYZZhnlWqIQ=;
        b=Zft9ROItO9MI9i8CDrPZqE5zT9sJlUEbrbeK9NlKF9LBG7Hc9BYJn8RZV0Ix3PwiAs
         SKDdC44hdUgUvQbbA45res2317vt3waUOqL+jqN+32N0tknScK9HvgoUwaVLduRFnLg2
         ClpMmY9qXFBxGGOQxfsfaVKaypuVHx8547YOq6sdvdE8+nNzELg0WViTd6tLaBHy2Lqu
         78KcENRSeXYWCwFcE4urn13YE9ECboAKISDZJZLRXK9ZJhcMEeb1WZlRhbUP0ho2mRXQ
         oUkfpV/x6pLEaoQTEuntkj1DmTP5i5ezeZGoh8aQQYicR6Vxe9hoGlKMH6V+gDP2CgR/
         WSnQ==
X-Gm-Message-State: ABy/qLbme/foIdfr6zc93nIr/EXAFPTm43qEhWYQFwW7zbmKBIfehJH7
        JwetcA8Sy/IIArZwMU1A7DufDnrekrE+wclL9iDVm/0zJ0GDag==
X-Google-Smtp-Source: APBJJlFPDXNi6eICVLooKdAF3giri39djaYL1GqULI3igq3CzvwlvOLSCBtfDplTCyADBiVtBIPyXm/E54bA2nicTEQ=
X-Received: by 2002:a5d:6110:0:b0:315:a6a5:fe95 with SMTP id
 v16-20020a5d6110000000b00315a6a5fe95mr11487668wrt.52.1689666142872; Tue, 18
 Jul 2023 00:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230628072840.28587-1-dg573847474@gmail.com> <20230713101848.GM10768@google.com>
In-Reply-To: <20230713101848.GM10768@google.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Tue, 18 Jul 2023 15:42:11 +0800
Message-ID: <CAAo+4rW8hK9WZzfXQ3wLf1i_xKMksXM1sffbmk6+kyJ8kVtfGA@mail.gmail.com>
Subject: Re: [PATCH] mfd: qcom-pm8xxx: Fix potential deadlock on &chip->pm_irq_lock
To:     Lee Jones <lee@kernel.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is very old code that you're changing and some of the people who
> made the largest contributions are not on Cc.

Thanks for letting know. Will be patient while the patch is being reviewed.

Best,
Chengfeng
