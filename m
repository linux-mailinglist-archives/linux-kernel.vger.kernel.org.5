Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AC27DF300
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376353AbjKBM6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKBM6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:58:14 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5812A112
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:58:08 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a84204e7aeso11256337b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698929887; x=1699534687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCCONn8E1n3ofwv6haSRwqO8XLggJEnfeXJadE+g31c=;
        b=Jf8C7iKKsSMX0bRonOaIBv3hBaPaEWu8RmmeuRKP0MqTFIjTe8eTndCLSJM/cGj92b
         /TMmfmAjX9ufPr0Jg5o/eJNCzhtwAS1ctTUb7j3BBxftu/1q3zg2HSL7r2dlvr28/Qef
         vxGDxQfCqs1fx34d0BzzR93nnPKFopHsae7i6MrfFVrxxvUTwliy6Z83p0CH9tbJWT5z
         lHRTCqYzaUGbvJFfb5IQpFzqv0w24wnpbQOVJq+EhlmUpVhousxbmTpa8MBViKx/Stgj
         7pK7SWEXnJ6VVRGvi0HCvB6bUGkY7cEePIvJtV/T137KlHckStamwtbDxhg4qWIpYwS0
         IXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698929887; x=1699534687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCCONn8E1n3ofwv6haSRwqO8XLggJEnfeXJadE+g31c=;
        b=mrlKhi67Zg97cAANoAjy2oNtDNpb003h/hYTEG3KJPy/LbAmlqdHhd537cX7n7UrFF
         ZOi+ED7K1LBgG7P4J7jpCfjx4cWkV9vZ2Oho7iRvpL8TnsvDFburumqRaIXvUp+NnQeK
         n1o1BoWjyp6uxjm8SgB693Qys4R3Bkm72KSdcpCJDlBXOI905UbigD//vrbn9HNnPEvw
         2gcyEYVFCtL2lZj1MWYrZ2760jmZszb5bMlzvK16zw0cLb4zhOeKbexDysqDIV+mAfQ8
         IuQKQbx0OiJN5+lxU7e/AtjcowG74PWfITet1ztOnMW//+y7S/udtQy0Mohbmy7D4kmN
         rvaQ==
X-Gm-Message-State: AOJu0Yz1pXkDxQ9SsCRpjnbZuUhTTivTJVql7lxuZEPPhoOhLGP7vVe3
        NESBu4RCdsEsh6aP1toPTXBagyGXvvFzdBCZuDm1zQ==
X-Google-Smtp-Source: AGHT+IHcgHYJhzP5Y7dFQbPW7i51z51wvIBnxWK2BKswP/EfWsiw4NQNlN+H23Rr8yHC8tbOVmgUopyu2cV9Ga7Vhgk=
X-Received: by 2002:a81:ac09:0:b0:5a7:d412:af32 with SMTP id
 k9-20020a81ac09000000b005a7d412af32mr19926040ywh.10.1698929887555; Thu, 02
 Nov 2023 05:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231030120734.2831419-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231030120734.2831419-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Nov 2023 13:57:56 +0100
Message-ID: <CACRpkdY1Ckc6SQDKKMEVkzOLe8jHNDA=P-7AF_W4QbVb75DFkQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] pinctrl: intel: Use NOIRQ PM helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 1:07=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Intel pin control drivers use NOIRQ variant of the PM callbacks.
> To make them smaller and less error prone against different
> kernel configurations (with possible defined but not used variables)
> switch to use NOIRQ PM helper.

Makes sense. The series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
