Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DD0780644
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358157AbjHRHUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358201AbjHRHUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:20:32 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8EB1BF9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:20:28 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d733844772eso620517276.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692343228; x=1692948028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVNINBfhI6v1OuGUQEk8EPNY2D2i8J6KxQOBkK8fRKE=;
        b=vtKHEIfodbbk9YOeCdsweZjrbmsDIETtff/h4h7g05cuFSQzU7+2B0H8ncEKIO2Dp7
         8Fgf8gBbbkIPBhgWUH+qm3iZ4NoU5kbA7WqoeI2g/NHpGLwglqZxcMJL3jBD7LFVACeF
         Rg+L0yqtEyNaM8UxESefXeSAA4iS4QW5WV1ZWN1f8+4+uOEJM1ZgPt1JNed//pG+SXZ4
         FzKPD0X0ssGI5dzDGjqvZWdUhh3z/yBaO7jZ+MGHmHh+lA59yg5DIsyYuKVq/qKLNeq8
         avrhzIZ4MUGi5jT+PqylLD3ddjUseuFRUbL+zhikPkZlaWedfMpmwlWDnye6FOvLbXxC
         mv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692343228; x=1692948028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVNINBfhI6v1OuGUQEk8EPNY2D2i8J6KxQOBkK8fRKE=;
        b=YCwvTxhOZHZzqkvfjnfRcQSnRgUEwubeGBLlmfkaO7XZRy1QLdHadqBlazmHG/L45X
         co0+81AsqtfK6XErd8pN9WKeJKnLYjelFRO9G0qB1AlcwSeA5Fq8Kya0mo7Bpov5OaUX
         JuFQfyo9A2nA0BJLgaIdf8m+7DXeQgBmh0Jb95zgDdPR94CZiKZTw3KSSHTkJ8zUdObZ
         CuzTYFsXwo/JwtzPsHs3YAKqUnFiRH/dzEtOFBI5IxPt5m0eIUOpGen0oeVE2+eZ/954
         DTo/8d/qmPlqcFu3d6b4xmTwhepGzRmpNT7u/iND+XxUJozi6gPM8IcX5iguCgWbMJBn
         D04g==
X-Gm-Message-State: AOJu0YzbuTIRcxYgq0VWSyE7oTKe5uXKtEnxVRO1T28jbtChmSsu3UMJ
        aU3rL4ZgbbAEEHQA39Ts584naRAmNjOK6GT+Qjq8Yg==
X-Google-Smtp-Source: AGHT+IGYF92sQJQ2p+S/Z25wOBxgzaE5QXpiSKLqWsfuzauonRXqEivasJTEX6QNEnPrNI851mx4jtt918kg6E0wUaw=
X-Received: by 2002:a25:b116:0:b0:d3f:2238:8872 with SMTP id
 g22-20020a25b116000000b00d3f22388872mr1701651ybj.63.1692343227823; Fri, 18
 Aug 2023 00:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230817184958.25349-1-brgl@bgdev.pl>
In-Reply-To: <20230817184958.25349-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 18 Aug 2023 09:20:16 +0200
Message-ID: <CACRpkdafsASGZCK24waSix8xwzWTrNyTCkxDu4phx7q-9KtLdw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] gpio: cdev: bail out of poll() if the device goes down
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

On Thu, Aug 17, 2023 at 8:50=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Wake up all three wake queues (the one associated with the character
> device file, the one for V1 line events and the V2 line request one)
> when the underlying GPIO device is unregistered. This way we won't get
> stuck in poll() after the chip is gone as user-space will be forced to
> go back into a new system call and will see that gdev->chip is NULL.
>
> v1 -> v2:
> - not much is left from v1, this time we don't repurpose the existing
>   gpio_device notifier but add a new one so that cdev structures don't
>   get unwanted events

This is nice, thanks for quick respin!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
