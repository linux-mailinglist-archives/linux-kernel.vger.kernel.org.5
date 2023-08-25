Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE84787CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbjHYBLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbjHYBLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:11:00 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1E51BFB;
        Thu, 24 Aug 2023 18:10:54 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bca857accbso358401a34.0;
        Thu, 24 Aug 2023 18:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692925853; x=1693530653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hfz8plk32XPGbEt2QShwrNfqMNFg9MSJL6dLUIANYY=;
        b=OSqjy3EPvmNFQbiZu+6TQqC303MFgZMVY2dxRbK85ZL55GmRfo5wSBHy97FPIl3mL4
         YP1GrjlSOlIbntn5wKyJu9AAEn1WhMK1cY7ITNrR9m1Ff+6YcJPAOeVDWntIbE5C8g4m
         tiI2aMKQzAPm27HJ1nNqZHyvFrjU3eft3lqiwGZdcRKo8mVQsXNK65F/A1h7E7Bwf8HK
         WxLeYfKBtd7GkT3QyiauxKHB7l6ioNBueRu5hizsGv+QjFqLzc5OL5L+Z7Z4G6T4byLH
         hv1DZ8L+7XzBtXj9TlpYE+O5kjftaoCTV5C+I1nj60+txx+qfyCN4TXTh9DszBFdCAJd
         GpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692925853; x=1693530653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hfz8plk32XPGbEt2QShwrNfqMNFg9MSJL6dLUIANYY=;
        b=dxpIfjHhVB2PrlTc1nyqb5M8FtsXTK/4czc9PUpyOCBovbMbOGb5I5w8/pXt6xCaUm
         7z9kxxe6MgIgMt3zwQ66nkaVc+XBWCusrTgd8NexLKjAi9jlDonxM1m+Un1r4iSXPj2h
         dISt0lBtUDcLb1WjWIZx1UdNlE70wW/v5cn0XhGM/NqN2XvVM1sg+btNQh47HhCL5ODT
         3Kva7epszvnBEkLZO33l6gSJVNEGrIHP18o8iMIEjD/mLpXSpLepkzlVmxXOuYj8BQkl
         lfYMk6a5O3QP6ZlJ0JG0oVHPlLY6hNJvVlDRe+PF3R/F4e8HH/JB1QAcZDqnoX3JEgZA
         J2qQ==
X-Gm-Message-State: AOJu0YzcocC1LxuMGnqsQP+IskIYMOTKGG1HIwkzzVRXtgaYN3uXDH9Y
        pGRgQKmxbEnBSfICjCQXmlR+sQNeixwIIG38uF4=
X-Google-Smtp-Source: AGHT+IHib+Z0JfkmlHGDtd866Og3qE2x3cqqdrWRxJ0RRz/R7zPutXpHHkrSaRCycUI/+u00n/0Il6ozgNEtXwf6qUA=
X-Received: by 2002:a05:6870:1711:b0:1c0:219b:17f4 with SMTP id
 h17-20020a056870171100b001c0219b17f4mr1450203oae.5.1692925853467; Thu, 24 Aug
 2023 18:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230713081429.326660-1-pawell@cadence.com>
In-Reply-To: <20230713081429.326660-1-pawell@cadence.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Fri, 25 Aug 2023 09:10:42 +0800
Message-ID: <CAL411-puh4pUoZ0r=BRoohchnmKJDmbioHpmUcAR9NJAu3iYQA@mail.gmail.com>
Subject: Re: [PATCH] usb: cdnsp: Fixes issue with dequeuing not queued requests
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     peter.chen@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 4:14=E2=80=AFPM Pawel Laszczak <pawell@cadence.com>=
 wrote:
>
> Gadget ACM while unloading module try to dequeue not queued usb
> request which causes the kernel to crash.
> Patch adds extra condition to check whether usb request is processed
> by CDNSP driver.
>
> cc: <stable@vger.kernel.org>
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP D=
RD Driver")
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter

>  drivers/usb/cdns3/cdnsp-gadget.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-g=
adget.c
> index fff9ec9c391f..3a30c2af0c00 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -1125,6 +1125,9 @@ static int cdnsp_gadget_ep_dequeue(struct usb_ep *e=
p,
>         unsigned long flags;
>         int ret;
>
> +       if (request->status !=3D -EINPROGRESS)
> +               return 0;
> +
>         if (!pep->endpoint.desc) {
>                 dev_err(pdev->dev,
>                         "%s: can't dequeue to disabled endpoint\n",
> --
> 2.37.2
>
