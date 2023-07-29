Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7182A767D3F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 10:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjG2Ine (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 04:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjG2Ina (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 04:43:30 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46398130;
        Sat, 29 Jul 2023 01:43:26 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-577497ec6c6so31313417b3.2;
        Sat, 29 Jul 2023 01:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690620205; x=1691225005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIi2Xc8Sz0WhNAwrXZ8Na2sBGtRLwCKmpg7mjg5uN+s=;
        b=hW/OmNDggYpZfyvnVAqYWxygXd3M4oiyhsk0PoOjlnoHVW3H7u2h8ift2Ejd93BueP
         3dDwTRQBlwYvQoqT8mmNEPizP+bTYtLWhOifCEqlIBm1j5AhuJ13gU+9FtgoiMp7hNvf
         cJuFtmkll3f7HFpfOwNLacLjEiEb15VMmB4v+j6tVDWPXKtZJXazWIZHJ3zF8d6oV+UE
         g7jyKFYeoSq6QdyaGWfjb06au1p/t3D2VlwCx17o8u+z+JjqbvldCW3cBjXwwiVXYe+Y
         EJCi/yg0dgzT84de2+ny/5auQmst1xukyBEmLOEjZSmQeRaLRNT+zWNmQBOjGLZTPNM+
         wxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690620205; x=1691225005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIi2Xc8Sz0WhNAwrXZ8Na2sBGtRLwCKmpg7mjg5uN+s=;
        b=CsAVl1fjci2EwGIibi9hNOEzgFYK+VEfcVgFztPFVXc4tNUU3gQ+mcis/KIHoRKe+f
         qc96kShbc+g50ZZGc3WZEY9EM8dCgPW+g2F3K0MIJ9Uwp9VkufrEp3Ox2ILSadtiUt9q
         HOHqS4fQM0l8RpkrJENBiGkRAFcF/FsPxH8WMamDHiZ6lRw99qixpeI+9/RcyNn8NDL5
         gXUQ+eGM/+oSy/ZbocWhLaaD3KrTIgr3gBUWV9lo7umR3W/OoCOIZjACqWYdUflygcCD
         cHf+lyRaVs+dwV7FjmprDahS+8JU7Set9VtCg8fve3xxu7QTEDcPZytCiZy/MDETzh6j
         3iWA==
X-Gm-Message-State: ABy/qLZo0Q6+kvGDvqGq56JcVJ6xvmEMWSZNHUkBowEiF+NNMafFWxZI
        v6SZDoCd1qzwt/fiSTxbVEFnzaIDY6xIJtA3pwCSbMxsvwuzUw==
X-Google-Smtp-Source: APBJJlHaANwzwqL4FH29s9nHm/mZkAL6O/iGGMiot7WZk8ACW2iSj/ibC7q6Fmw75IiiseE7IijzW18nk/wJWSX02nk=
X-Received: by 2002:a81:c303:0:b0:576:bfc7:1e43 with SMTP id
 r3-20020a81c303000000b00576bfc71e43mr3729283ywk.25.1690620205435; Sat, 29 Jul
 2023 01:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230728073919.6473-1-surong.pang@unisoc.com> <2023072844-ceremony-lushness-c229@gregkh>
In-Reply-To: <2023072844-ceremony-lushness-c229@gregkh>
From:   surong pang <surong.pang@gmail.com>
Date:   Sat, 29 Jul 2023 16:43:13 +0800
Message-ID: <CAEDbmASpaAbqnvykL0hjm-6fOGkNk55MkbTPMiD5f0BpVVzK3w@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: gadget: let pm runtime get/put paired
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Surong Pang <surong.pang@unisoc.com>, Thinh.Nguyen@synopsys.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson.Zhai@unisoc.com, Zhiyong.liu@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,
The commit id is aad1a9ff2f53b8d5cde9ea07e1fd7eb7c20171ce

On Fri, Jul 28, 2023 at 6:46=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Jul 28, 2023 at 03:39:19PM +0800, Surong Pang wrote:
> > Pm_runtime_get is called when setting pending_events to true.
> > Pm_runtime_put is needed for pairing with pm_runtime_get.
> >
> > Signed-off-by: Surong Pang <surong.pang@unisoc.com>
> > ---
> >  drivers/usb/dwc3/gadget.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> What commit id does this fix?
>
> thanks,
>
> greg k-h
