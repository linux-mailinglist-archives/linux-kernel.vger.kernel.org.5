Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877E9778E76
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjHKL7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjHKL7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:59:23 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE71D110
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:59:22 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-4476f713e15so752900137.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691755162; x=1692359962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oGMlHTUgjH+xggxT1qijFrU6WZyh/QvNvCP4XO/nKM=;
        b=cx9frQPqStrt/thwpAphkjd3EmYVpZAt5s/JGz52z3/klncOwJBRoZA6nG8OKEpvzx
         EbLPYsMAaSBpMU0GT+ZPIDvhFkaZFy1kyFbpN0Gq9YUtGAP7veAZ2db907rbTDU0vMno
         MLnjHpbUmMa1cMfsFgLwJowdRHu7P7dd57LJC88EybZxpXxOncELhjmIoZjRZwFldYPj
         rcfI2h4mLjHEsFD7oPK1l+5FAsWc258MwA/6Wobvp3NBhRMZe0T0qI4uzBqNBaSxn5Oy
         P9d4YFYo9jVZzUJZiCz6t1ydGyYWt7UI4fn8tgXoDmlym7esb+uKz/z//+wDbppjkeqm
         Gk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691755162; x=1692359962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oGMlHTUgjH+xggxT1qijFrU6WZyh/QvNvCP4XO/nKM=;
        b=gWYB7IEsUY11XwpIqoPNzZ9lMZS+tXyI5DleHlAp9wYWuKfmIKbe97ihVwKLNdLhv5
         uP+srfxuhkScm9pu/04knGKwwF/7VlY61/SBnwY8GuprmfstPbg+/2uF12jLnyrrQKPe
         lJc2d+EDeab68BrYvkHXTWQOXLQ99AqIFNMyBtAgksXaX4qYwuaNzolfs+ASn6tWTC7i
         NfcD40uFvmT64UcG7/ocCmHc78KEAp+WkGJh4Wq3yNsIMH9T+AkWHydRXW8KpEJvoT5O
         7GKeY8+nwi/2Pv6GcEUfPg4LzdhVEwUrDO0Ut11gPNsS4YslXNZ+RCZfQEmBeuvOG7G0
         Mhvg==
X-Gm-Message-State: AOJu0Yx+9Pn8Pkf8HqIvC0UYW1g3MWZZ0tug5zlRqBtmAEt1CvWPCXbz
        c7eLpiWJ3dCpoSXD0B6DOnuHPpZsUHMAcgEI02afHYOlL5sIRI1f58A=
X-Google-Smtp-Source: AGHT+IHwP3ZU+ItnzX6UaQGIAfOWzhLSGnYNcLL4IdB/7n1JYlMTUn54ure6PmSRFhSNR1fcOX2LPZGVOTuCljnHFjs=
X-Received: by 2002:a05:6102:3d4:b0:447:4b52:5c8 with SMTP id
 n20-20020a05610203d400b004474b5205c8mr1296064vsq.26.1691755162016; Fri, 11
 Aug 2023 04:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230809131442.25524-1-brgl@bgdev.pl>
In-Reply-To: <20230809131442.25524-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 11 Aug 2023 13:59:11 +0200
Message-ID: <CAMRc=MfE5TYgKL1pPkbMt4dP9PwdEo9nsy4aH3nvrNAdniG2Ag@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: sim: use sysfs_streq() and avoid an strdup()
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 3:14=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> When comparing strings passed to us from configfs, we can pass the page
> argument directly to sysfs_streq() and avoid manual string trimming.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

I applied this one, I'll send a v2 for other one.

Bart
