Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5237A116B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjINXGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjINXGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:06:04 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97563270A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:05:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so5682238a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694732748; x=1695337548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1ZXNYZuH4kWnk1JCUQ16o1+EQL82qZT05lOEyrXgZ0=;
        b=olDVR5WY8J/l4AxAOsgFefpKEd5pX8GygtEQ/rQvVShJyGnjx/mhReb+c3XcpE0UgX
         WXt6hQbbeD2DGFkVIyBGq2WZydzkEDJvyPnnQ0gRn+tmzW0THUbNNY3SJKb37eAmRGKQ
         VfzkhiSRRCmOjMmVeaIk1685Vi01lO6z4QasVmZf6eqALXgbW/cUEjuNiHifFKHBgGww
         75nwomGdaK5jKNzzVp9STq9PWq++88X7NghTU43ZCI72/cGEnTtIdog5bIhliu/kQIxZ
         ypzsEvi1bHtBZ+KHitzXv75++9bWIYoMHnaQKZqxIbO/cb/NX3WHoJ7KWGGyYNjFf1C3
         WcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694732748; x=1695337548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1ZXNYZuH4kWnk1JCUQ16o1+EQL82qZT05lOEyrXgZ0=;
        b=olb8vgRwJ9OtkWHa+kw8kjzn8MjiKWrHsQJIeSVOxE48p+DyOYeCVDvVmDAcUPrshD
         tG7fFSsKJR+n+bgiozdkpPMcbgnYXMbQUG4x7cS6D7szhevAv+2Ltyu/0rAnb8oY/6pc
         O9sQNtQ5FCoHIGThvTbXwnLkJLc7Z2YW1Agk+8e1o4UnuxygpbEy7DU9HS2hGLWnqbKn
         PQLlAbylNC/kGa0ywt9iTR8AZWruJJZJcD21gOE5RYip+xnGGPF60bG3z8Uo9KsEXoIF
         aW4zbR65MwC/teA0JmKH0YZJo5pFQgpCTLGxbjNekFepxn8PmSIzkAQYNbuyMmhJdgYV
         Vp0A==
X-Gm-Message-State: AOJu0YzprpPedmAr+7odzCuJSvcC7V076d6uSHc+C5p286bblQ41LPzU
        OAxMN1+aAkm5RsowNaNQYXjSJ6dvITsaoeKPoo9RHg==
X-Google-Smtp-Source: AGHT+IEYjO7yOeoI4U5uv88zCqAim8OtNIXGMQ0pIFGmP9HBSuvYiXqE5Do5P87Z31kBv1tppdr7V/FnfLnt2Xt0Va0=
X-Received: by 2002:a17:906:8a6b:b0:9a9:d5d1:35a4 with SMTP id
 hy11-20020a1709068a6b00b009a9d5d135a4mr56901ejc.7.1694732747675; Thu, 14 Sep
 2023 16:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230912041910.726442-1-arakesh@google.com>
In-Reply-To: <20230912041910.726442-1-arakesh@google.com>
From:   Avichal Rakesh <arakesh@google.com>
Date:   Thu, 14 Sep 2023 16:05:36 -0700
Message-ID: <CAMHf4WLeSC9m05XOU54yL=2xUcSqbWP0f7evM0rZRsJ=J-btWw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] usb: gadget: uvc: stability fixes when stopping streams
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 9:19=E2=80=AFPM Avichal Rakesh <arakesh@google.com>=
 wrote:
>
> We have been seeing two main bugs when stopping stream:
> 1. attempting to queue usb_requests on a disabled usb endpoint, and
> 2. use-after-free problems for inflight requests
>
> Avichal Rakesh (2):
>   usb: gadget: uvc: prevent use of disabled endpoint
>   usb: gadget: uvc: prevent de-allocating inflight usb_requests
>
>  drivers/usb/gadget/function/f_uvc.c     | 11 ++++----
>  drivers/usb/gadget/function/f_uvc.h     |  2 +-
>  drivers/usb/gadget/function/uvc.h       |  5 +++-
>  drivers/usb/gadget/function/uvc_v4l2.c  | 21 ++++++++++++---
>  drivers/usb/gadget/function/uvc_video.c | 34 +++++++++++++++++++++++--
>  5 files changed, 60 insertions(+), 13 deletions(-)
>

Bumping this thread up. Laurent, Dan, and Michael could you take a look?

Thank you!
- Avi.
