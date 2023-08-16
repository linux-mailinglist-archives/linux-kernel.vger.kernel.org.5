Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B66477EBEE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346543AbjHPVeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346587AbjHPVd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:33:59 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A9D2133
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:33:58 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d6a5207d9d8so453601276.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692221637; x=1692826437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RBVqp4kduJXMJbxlAvEmo+9gvCH5BX3b44BJoL4eqo=;
        b=jvOzYHAAWNRja/8gLNIAYZd28LRCoDJ+poMcE4M6vMSSwteXt95Oac+kEwZkwJx+Jq
         t3r5/e65lbRRtbXjlQdHa2+twul/cuJKKdVPV16c4/Jsz6QHlmmxJCClrdIguWcPvzA/
         xPytpmL9Tg0O8vypX61xkkJ9B88mCxcRFvUVDYh3/G3UAggydn2hKOUZlY+6ZIYxdymf
         a/fZ5/LLysX2lpQjAb2140tZAdsO0xvQP5uouzTpACgahG45wsCdLu9k2iu8YCRvauvK
         p0zMQJ1+Ewd4/VD3/q5NTsLiWah3irTjPaK8cr5vfDMWCnit8j2PUP4BTDXJvBGX5bo8
         DnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692221637; x=1692826437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RBVqp4kduJXMJbxlAvEmo+9gvCH5BX3b44BJoL4eqo=;
        b=ThxsdSqvXbCziot5/+8OTbNdi7N5Q7fanDRFQEtijI3ynSKy5JVyIqmrt+BW85fil6
         AF2oJJ5/lE/tho4VqFtRQYfJ/oeZOYfmxkFE/VfLdH7TfyUI0XFKNbe2jfA/V3btXQtO
         ck+dPWt8T6XPSFPWfngtzARI3rXrHUuOrPRKhKJQ1/cinpNqH+mFPAwObiM4Bul2k4O1
         tSJvwxBRXEDUfY/9rIkBw+EPj/HdmTAtSMJhDQgiA2QVYIP2g3B6008AxFjGgMG0Ca/k
         irDBqnLBYDmRTLq1Z8iynqWfxUx+Rfp1OYtZ1E8PrTZ9DA+f0HF4gNTsucIw5dqP3riq
         O3jw==
X-Gm-Message-State: AOJu0Yw0qm6+W3AWiYbOCTF1KWVnxtjS/bxu39hiuFDvZN0tFaOf26d1
        0xep8adQxdYZyPsIlFPFP42mZjz5cmio6s1bPSFb8g==
X-Google-Smtp-Source: AGHT+IH2Z/OEtN5cFhO4F5L3HrStmbVp/yxc+UL7spJsYhuWAjsj/K5t8j99MIqXIZEPs68T6FRkkCgQaQWLU9GzADc=
X-Received: by 2002:a25:b189:0:b0:d4a:499d:a881 with SMTP id
 h9-20020a25b189000000b00d4a499da881mr817195ybj.9.1692221637406; Wed, 16 Aug
 2023 14:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230814112615.42448-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230814112615.42448-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Aug 2023 23:33:45 +0200
Message-ID: <CACRpkdbLbj88h98f92q_efWNbeM4s5hwu3FpyCyuaCL1QpRJkg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: sysfs: Do unexport GPIO when user asks
 for it
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
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

On Mon, Aug 14, 2023 at 1:19=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> It seems that sysfs interface implicitly relied on the gpiod_free()
> to unexport the line. This is not good and prone to regressions.
> Fix it by explicitly calling gpiod_unexport().
>
> Fixes: b0ce9ce408b6 ("gpiolib: Do not unexport GPIO on freeing")
> Reported-by: Marek Beh=C3=BAn <kabel@kernel.org>
> Closes: https://lore.kernel.org/r/20230808102828.4a9eac09@dellmb
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Marek Beh=C3=BAn <kabel@kernel.org>

Late to the show so patch already applied, but THANKS for
drilling into it and smoking out this bug Andy.

Yours,
Linus Walleij
