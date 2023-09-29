Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B9E7B37CB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjI2QUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjI2QUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:20:52 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3931EBE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:20:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c60128d3f6so223005ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696004446; x=1696609246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJsy3U5P7JRkSbDtJdUi/rB+ipyk8l35yY9j6rGapyY=;
        b=F1U9F+32hO0rW9qhk+zZrkBoHSMfCbzV66CmxrB0Hge//zXbupDCK97ltbdYSQ+xse
         p6IKVnZv7gEFqEu1Y1Cbt4uTg6ZQrAX5CvIzFo10jGMqcmvRFlADOFtHfUR4mVjGroYw
         OP4jTwY7Y0BVCRQQf9Vwq3Xto8l72CxuCTnG56hpMjI78/YIr9tM9ZjK4fZe+vQFIPS7
         M7d0urUwYfj1XFiwVbFMG2epVhfj7/nbrCLshyVmNhp5TzjqHhAI1LEvDAtNpHZcF6He
         d57iIp3FuPVIpK0eVw+qjRFbFJf9AgzvEuMKrObRVPAXGByv36oJ9NcnfIu3bQiGM5jP
         Xs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696004446; x=1696609246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJsy3U5P7JRkSbDtJdUi/rB+ipyk8l35yY9j6rGapyY=;
        b=lpRenzaKQJe1phq5MBU152i7Rq8TKkUQA9+mDHWJXs8KnX2A28kPZrlaZMkTimuI3p
         WcqEdl+XXoqW6EaZXsQ/GBlrfsLHSLCw8I2B0ZXPjjyR2+JrOyTcHab3jRtLt0XPb/l/
         x4Y8B4K3BRxcfQ9ZRNDUtzprrgRkn8eRVYnnwnT3rBtiy7OAhsuKH9WkN87UqIZs6JLr
         6DjGOkuTX4Lsdm61PUeANMjDxlC+YqcpSCIIsAtmc4GVnyPsdPY0YEZ1eXktK5Q2z6wY
         PNgug/jrp98QQJIedgrCoXKGG1hF9iZNfijmARm5p/P0hG6LcvT/3TEVaOtminMSI92M
         L66A==
X-Gm-Message-State: AOJu0YyLf3QPyROJ/AlOFkKJX8/lxYSbPF8McYFMyPQg7hlhnuthdPqX
        BTHF4aQCRY5fBcZoA9S8mc8DNtwZz3SSFsU75zVaR5UzALKWHEizrMs=
X-Google-Smtp-Source: AGHT+IG7bJVACXPaJHWfeTFPOQqYslgg2MMLtTumeATk1ELGuLUrmmid3NcQWN+cuFswlozqETVEAyH8vagOlxW7bdE=
X-Received: by 2002:a17:902:f54f:b0:1c7:1fbc:b9e8 with SMTP id
 h15-20020a170902f54f00b001c71fbcb9e8mr820240plf.10.1696004446368; Fri, 29 Sep
 2023 09:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <ZRbwU8Qnx28gpbuO@work>
In-Reply-To: <ZRbwU8Qnx28gpbuO@work>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 29 Sep 2023 18:20:10 +0200
Message-ID: <CAG48ez2SJMJSYrJQ9RVC44hbj3uNYBZeN0yfxWa7pqX9Fp2L7g@mail.gmail.com>
Subject: Re: [PATCH][next] media: usb: siano: Fix undefined behavior bug in
 struct smsusb_urb_t
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 5:42=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
> `struct urb` is a flexible structure, which means that it contains a
> flexible-array member at the bottom. This could potentially lead to an
> overwrite of the object `wq` at run-time with the contents of `urb`.
>
> Fix this by placing object `urb` at the end of `struct smsusb_urb_t`.

Does this really change the situation? "struct smsusb_device_t"
contains an array of "struct smsusb_urb_t", so it seems to be like
you're just shifting the "VLA inside a non-final member of a struct"
thing around so that there is one more layer of abstraction in
between.

Comments on "struct urb" say:

 * Isochronous URBs have a different data transfer model, in part because
 * the quality of service is only "best effort".  Callers provide specially
 * allocated URBs, with number_of_packets worth of iso_frame_desc structure=
s
 * at the end.

and:

/* (in) ISO ONLY */

And it looks like smsusb only uses that URB as a bulk URB, so the flex
array is unused and we can't have an overflow here?

If this is intended to make it possible to enable some kinda compiler
warning, it might be worth talking to the USB folks to figure out the
right approach here.

> Fixes: dd47fbd40e6e ("[media] smsusb: don't sleep while atomic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/media/usb/siano/smsusb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/s=
msusb.c
> index 9d9e14c858e6..2c048f8e8371 100644
> --- a/drivers/media/usb/siano/smsusb.c
> +++ b/drivers/media/usb/siano/smsusb.c
> @@ -40,10 +40,10 @@ struct smsusb_urb_t {
>         struct smscore_buffer_t *cb;
>         struct smsusb_device_t *dev;
>
> -       struct urb urb;
> -
>         /* For the bottom half */
>         struct work_struct wq;
> +
> +       struct urb urb;
>  };
>
>  struct smsusb_device_t {
> --
> 2.34.1
>
>
