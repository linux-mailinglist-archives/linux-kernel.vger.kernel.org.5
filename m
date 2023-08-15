Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C3077CE3E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbjHOOiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237752AbjHOOiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:38:17 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2591BE3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:38:16 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bd04558784so4761324a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692110295; x=1692715095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cAjN5VYYLu/zUPsz5SLD65K+s9r/2epOWr9SL7xLgo8=;
        b=bkMWMFbZS8ZqqGEqYJjheEvIdGbOb45G7/SEAPO8hD6Py8K3qwduxzer0etIps3Vgm
         qmJbobC9dXoCKLJ3+zi/OykoJzZmKa6LpJ1P0FvwLS5+L5eojVTUCanFFD2wOL2xIzZj
         6ZN6UIBoBS3VTrf7N6h3D1nqq5rkdo8/1Ywqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692110295; x=1692715095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAjN5VYYLu/zUPsz5SLD65K+s9r/2epOWr9SL7xLgo8=;
        b=b8ykkdAsaHJRyGJS/8lGL1k8WPresWArpmJQSLWWewhE8D4RP6F3y0nGW1ZoNnkSVk
         VVqWAd3TCMDRHxxvI5kGNc8kC7Y/ne7pEjIWBSk/NniclifH7SbZoAOEXKIbI7uYYa88
         LD+Ai5KSsZVBwLSo27UqAmsGiCaqZUsYdzZu96OSszLUpu2jksjTfk1Am7UuQslhIkzL
         uRRVsKgANn/mgxY28BAVb9Do/BBrlrV933yT2CKI2ncC1ezG7nL4j0kXD74mLhXd4/7p
         4lYvfLPMX1ovEx5r5YeXSg2KG3Szf+XlOCkXxgchnLfQVz1HsOhBhH7k3JvMilxMPVHD
         /onA==
X-Gm-Message-State: AOJu0Yw2fGHVEQ376XygvbROCCKScFey7tXb+6JVvBVMNzEL3iyPUluz
        vlV0dMhXt1Fz+3PD2FyU7r08jLUQSFQruS1iYTc=
X-Google-Smtp-Source: AGHT+IHX3HpVJayzoieH/7GWq4LTV9LKCmrlC3fd74SZx9QkJ9NUjt0jAMZWv0DNDiKFygIod/F+Pw==
X-Received: by 2002:a05:6870:ac23:b0:1bd:a5ea:ed7d with SMTP id kw35-20020a056870ac2300b001bda5eaed7dmr15291286oab.7.1692110294980;
        Tue, 15 Aug 2023 07:38:14 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id du15-20020a0568716e0f00b001beeaa10924sm6404395oac.0.2023.08.15.07.38.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 07:38:14 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3a3efebcc24so4668371b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:38:13 -0700 (PDT)
X-Received: by 2002:a05:6808:1309:b0:3a7:ae9c:4d53 with SMTP id
 y9-20020a056808130900b003a7ae9c4d53mr18605920oiv.46.1692110293152; Tue, 15
 Aug 2023 07:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220920-resend-hwtimestamp-v7-0-cf1d78bb8821@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v7-0-cf1d78bb8821@chromium.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 15 Aug 2023 13:26:30 +0200
X-Gmail-Original-Message-ID: <CANiDSCtC2zOKtopkuuqJYqi6+FQ1Kav6LfMH5gGhKrnDeG7GYw@mail.gmail.com>
Message-ID: <CANiDSCtC2zOKtopkuuqJYqi6+FQ1Kav6LfMH5gGhKrnDeG7GYw@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] uvcvideo: Fixes for hw timestamping
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "hn.chen" <hn.chen@sunplusit.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

Could you give a look to this patchset?

Thanks!
