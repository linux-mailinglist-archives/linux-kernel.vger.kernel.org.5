Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A5080EBD7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346508AbjLLMcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjLLMcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:32:50 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C249A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:32:56 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5e19bfb258cso11833147b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702384376; x=1702989176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4iQ3WOkHEblQ3xu0B39kuBfSgqaQxZyrXhGlk5rPik=;
        b=AnM0wMWVUuiYWw4wNu97nWbdaoKXFgBgbLDt9rxZkcVyKxx9E6Mi/Zkvh97AoyrSEH
         ZJlLfgOS43VfjCmDOir0qxdYfTG8wrvuvubl+cF2tnucGD5QPAHntUo5UYLgbVWI7xaK
         lB44IDsb+/U2CizSq50gyN9mLevxwuc4Qp9KYSViTPWn7ntCHME8zv9gOLh9wnge/Kg4
         4Y8jQmtl6cZT3K9gxt8b+BV4tQFHZsnunqpLosjQJmH2m3ZElao+gAZnFYgGR9bKwHzp
         eO+9VUxIbtoTqhf6VD/0tgcKdZbRnQlLHE8wz6KvRaAGwJUdZUQWCPfWieFnmCPkF+gz
         Xm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702384376; x=1702989176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4iQ3WOkHEblQ3xu0B39kuBfSgqaQxZyrXhGlk5rPik=;
        b=LW0rkLBpZ9+mvJGaCzY54kHhSJiTE8TVEZpVBt7jJOYgbLdhNFen9VAO0R4c4mE6F7
         wLOyCsAnnRCguQsZ5ElCKqcHxZMP8r6fNq/ovqf4ch0JX68NOd/cNyI+6H9h9p5xVSxz
         1FRwGCnIbQXKbL4ZtgBl9EO6RsXN2v+8VI81UkZqILKAwOSNn46UrIyT6UALJny1ntYM
         rb3lAXP5KrLfIrjAqT1xdmWtfDAbDtkgHIh4mnnPhFnys8at67UGr/gXmk6/Y8TANygd
         BVOmq1OotB9ADU22lBINEb1lBrF493Ar0V38QcE/tA4sqs9NOr8bbnXvsXkEsB1/T1DI
         oybw==
X-Gm-Message-State: AOJu0YyYGeitkGkZJjUNrQW0oIgeyl8SJjP559Lu88W4oIyGFIbeCY07
        2VR90ouqD2StT0eKnYEMZL8DUdJPLkhuxX+j2y3r9A==
X-Google-Smtp-Source: AGHT+IFn301SXBawdjYt+pES8aneAtb0/wEInppLQePe1QNM3JJJlA9BRCJC1T5FkpIF2yn8Fy7ha1WrAdPqkOpdtg8=
X-Received: by 2002:a0d:cc8a:0:b0:5b3:1d71:6df7 with SMTP id
 o132-20020a0dcc8a000000b005b31d716df7mr4619087ywd.22.1702384376192; Tue, 12
 Dec 2023 04:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20231212105501.16347-1-brgl@bgdev.pl>
In-Reply-To: <20231212105501.16347-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Dec 2023 13:32:44 +0100
Message-ID: <CACRpkdaVLPbpKGt=Oa13GVgvz+1CEONbAGHwvDJb0L96cS7CZg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: allocate memory atomically with a spinlock held
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:55=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We will eventually switch to protecting the GPIO descriptors with a mutex
> but until then, we need to allocate memory for the label copy atomically
> while we're holding the global spinlock.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-gpio/62588146-eed6-42f7-ba26-160226=
b109fe@moroto.mountain/T/#u
> Fixes: f8d05e276b45 ("gpiolib: remove gpiochip_is_requested()")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Makes sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
