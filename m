Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0433F77D255
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbjHOSso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbjHOSsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:48:40 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8AC1FE2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:48:18 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-79a31d66002so1495193241.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692125160; x=1692729960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HnC9mL+96GsmQffM/WCJ2ziVs9nsHYzni1mDXC/fnY=;
        b=fOu5dcNsJG44PSBBzczWvrBf/twn6/LDzDdYQyi0gKUPzmx+f6dJAwGiwHgibAI8PX
         Hoaa5JkZlrCqgFwbPt5I9hFL0FpLrghTA02HXVA5iYIRJqFcUfw1FKUb19FSEnX7KbOz
         mK6ImbNxMv8YJ0HUKo4Y4aaOXIexNl39f4h9OWS/o8xZJFb7nHVy54zga5IymJzFfVA+
         FSamj86ZUTTO9aV8TYYwcBuOdgLXXrob9efB8yNYBhFhsuAER1yksfz0r/3KeeBlq85f
         uoCHR8AYxoglwpStDhXTezNbg8TlnbcAQeOPvxRb1lzv2xYBqzxkVQLsaMVQ61VOfv9q
         gy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692125160; x=1692729960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HnC9mL+96GsmQffM/WCJ2ziVs9nsHYzni1mDXC/fnY=;
        b=Ei9yP8tfWpdTQAtQ4abMwtDZtkNNhbnhhnKROEAYVS3YXcrO00u25VUSma9EmBWHVb
         ywtXtEkRe4E24qqUDHxBF7ItEmQATC6GbRxbOwzjHzu2s/cmhqDCfgRUsRFOvcCsRa/g
         0MvPHgvgj3iSAOQ8asxoqHyAd+OZbCzO+hKZK2EKNJBD0JMvMCmSCt+Y17aQ6MHCnhS5
         N2fzYyN7TDkeKqnDXrQS0uoyoBdd5ju0lmvKBW71a1OP7B3cbWB6rf8HExvqah+qMya7
         1fxeBe6N9fhccNyMV3YTihsMAaK87GqZ881/RFG8hf0qFGZu7RdmmzOd0zkT8VL0ZIK4
         wnTg==
X-Gm-Message-State: AOJu0YxsdXl5vglSKzicqcdBw8LYQv4Vd8uhMTks0RovA85u7eWx+aBz
        hWlAPOlQ8ZjvKYMP6QAI00xr01dwdjj0WnviUlqVbQ==
X-Google-Smtp-Source: AGHT+IFdRsoYWoMD//QwpgN/QPqG2t/pBQuGz8HhsB6vm7kpmEnGwmWnIgqub8yZ0kmbBbL0mzyf7mKCDUX9PD5mLCo=
X-Received: by 2002:a1f:e701:0:b0:487:19c7:4ed7 with SMTP id
 e1-20020a1fe701000000b0048719c74ed7mr13039134vkh.16.1692125159868; Tue, 15
 Aug 2023 11:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230812185748.5799-1-brgl@bgdev.pl> <ZNtUpMe41HEztHLw@smile.fi.intel.com>
In-Reply-To: <ZNtUpMe41HEztHLw@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 15 Aug 2023 20:45:49 +0200
Message-ID: <CAMRc=McQX+YJYYncOe86+G7JF6qxuVA2p58qpK=sKLxW-6=mQA@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: replace memmove() + strstrip() with
 skip_spaces() + strim()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 12:34=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sat, Aug 12, 2023 at 08:57:48PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Turns out we can avoid the memmove() by using skip_spaces() and strim()=
.
> > We did that in gpio-consumer, let's do it in gpio-sim.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> ...
>
> > +     strim(trimmed);
> >
> > -     return dup;
> > +     return trimmed;
>
> Can be also
>
>         return strim(trimmed);
>
> If it's only about \n replacement, then
>
>         return strreplace(trimmed, '\n', '\0');

No, the user is free to pass all kinds of whitespaces after the
string. I'll queue it with the above change. Thanks.

Bart

>
> would work and in the next release be changed to kstrdup_and_replace().
>
> >  }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
