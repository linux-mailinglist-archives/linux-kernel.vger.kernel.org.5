Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496147852AC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjHWI1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjHWI0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:26:22 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88B31FDC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:23:07 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d6b0c2cca0aso5177417276.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692778987; x=1693383787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZ77g28iu8cqX740PqcHv95tx/jb6oTcL4UNhuP2mP4=;
        b=Swc4/RscuplUt5mV4OFAT14r21B5P6RH+ekNA1rUQivpVtFeqSuuw6fgo83EQ3P/Np
         DZ3fun8/fcBRZGkaj1yt6u8r+F5gsX1O69mSqUESGMiqbm6B/WW80g1AR9j81O+g2F6b
         Suh59omsyRyCG03pe5m8Z25HnXIlYeGsDLsSSyQSHkxT93Ys32g77SawXSSAJVAfwkpc
         ai7V6kCxnN9oj92HUGg0ZCT7ftiO6LrrH4jegYapZWI43t0H6W3YAxX2gYE0Sq+UEtZj
         5J/T1T+53vmRc4TyENHBa8+OoPgFxZmFvwwrDVb5KfrdRoMQg+uuEhkqLtT69USBM+CM
         wAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778987; x=1693383787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZ77g28iu8cqX740PqcHv95tx/jb6oTcL4UNhuP2mP4=;
        b=OEJRABbSLkzk0U+8Y5SvDG02aVAneXr1p9Q/mvQI+yl1KVK390h83rsEhdzEDSMdI1
         EsJYzlObUrLOtwE1Wpk+JrYOLB6u4qiO+0WwgAw2N3UByQ2k4ViisqDtDr19GtSKerKF
         Jt49enf8t1oFQAIQXzI3CcWtymJdoQ9F4JU7k09QODNKtIfqcPP97BZFHMZSgW/h1uMR
         B17grNHkoL6N1LUkRXAZjuARDSA9GWoBgovYLY2/acoz3pCBI/FgyJLjNc9OtAgqjPHl
         m5nNj73Fo9lUbny8jUp0qwIpgzjLhNQwMC5SD7UdG1AqLVu8spD3bez/kYAVGVC5vfWO
         NhPw==
X-Gm-Message-State: AOJu0Yw408lLsjLPRZeSiXxxqKg6wLFc/x5pZbyvdvwjnEfVm3bi+pTI
        56napIIHGpS9MqmKWnnNJiTK3G/weFMk1+qlqkvFfw==
X-Google-Smtp-Source: AGHT+IEgOqtH7KZfrpwWJmSzqs3NDM3mGFUb9MH0eyNEGXIkXQgb7oqjTM5Y1OQ/fhXuGhP63RqGSta5EWs4EreOteM=
X-Received: by 2002:a25:cc4f:0:b0:d74:4739:3e7b with SMTP id
 l76-20020a25cc4f000000b00d7447393e7bmr12589370ybf.29.1692778987058; Wed, 23
 Aug 2023 01:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230821023928.3324283-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230821023928.3324283-1-peng.fan@oss.nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 23 Aug 2023 10:22:55 +0200
Message-ID: <CACRpkdaxtfDiTjms_JXCsymPu50rO7POZs5noTKqDz9qQryLrw@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] amba: bus: fix refcount leak
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, frowand.list@gmail.com,
        andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux@armlinux.org.uk, arnd@arndb.de, jeremy.kerr@canonical.com,
        isaacmanjarres@google.com, hdegoede@redhat.com,
        ulf.hansson@linaro.org, rafael@kernel.org,
        grant.likely@secretlab.ca, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 4:34=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> commit 5de1540b7bc4 ("drivers/amba: create devices from device tree")
> increases the refcount of of_node, but not releases it in
> amba_device_release, so there is refcount leak. By using of_node_put
> to avoid refcount leak.
>
> Fixes: 5de1540b7bc4 ("drivers/amba: create devices from device tree")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Makes sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
