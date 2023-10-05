Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7462E7BA7FC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjJER1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjJER1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:27:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D72A35A6;
        Thu,  5 Oct 2023 10:23:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-533cbbd0153so2285730a12.0;
        Thu, 05 Oct 2023 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696526600; x=1697131400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6No5T+K1vf1nW01MUcNpePl2n3fgfVqNM+PBXuFav/8=;
        b=bHNDN3Eikd14VWLHSjQLuoPiQP4P+qXqGa3y8G/iA9GYnOYG9qTSKz5F0U92PdpwRK
         ohP2kxpoB3pxbOkwzS4O8X+/c0N48dc+y2zzB2RepuxUqhF9OgH74quTnOIx+UCWkI6Y
         WU6TlpjK7AsYDmtJ4NbkPG6q7jbl073N5zC6Tg/E8qpWPzQTMpQ9pvQ0yTCV9T6n0Qqv
         P8FC/WKn+FW31WqXYAaSzPgW4CmvkGSA9hDpBbhDXQMSvzizMNhtUlnu6HZmEKdYkMwT
         gn0ivl2mqGrmJ1TtHZVCdYGKzknln3PlGxWJ26sNBBkuSxo24lSIBa+P5UsGeqXqObzT
         vKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696526600; x=1697131400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6No5T+K1vf1nW01MUcNpePl2n3fgfVqNM+PBXuFav/8=;
        b=kdewHlY2T4I8kIXa8IvfHv016OD/LD0N2Yw9I0/buf71ACjDO3jQ/0enRFhZi7iVT4
         J8ViniBiD5x1fmroGlcX0Rfm3ztKoPRD8NAYPr/ak4vazgHuBTpG1TigfQyx7eK5XIZ2
         Ta8jxMJsTjJzFwX2vyIuVtsXRQBzS7FdZBplonYwHGNMzmkq0amfo2LoNFUWED1SlX4G
         rRztal2BGSzo+W/TxcPZA1DNLt297JnZBdJfWijYglTYApvf/j4NqETlURw6uEBdro/8
         k68o2a/kiIDeB4rUTtcmC8PQlkNoq3wGPAK/1xrnnGyPyyZ9DtfIkNe+vRlaH3bZDgpe
         9FOQ==
X-Gm-Message-State: AOJu0YwbhW+JKE7HILS4sdbSSv+Zj3fuU8vP7cKqbfAWePQhCkQk9gtJ
        msKDAcjxmi0qkkV0AxiT5t+wbxm8PSk9sZye9T2uOcsgej8=
X-Google-Smtp-Source: AGHT+IF0Rt6UW/UV9Lchh5LVRFwF3Z2tctX7gQ8Ry7vHu3ouw9LokTfSv6n3bZL78YJHe1Csm0xbR16AjNdMprlBoPo=
X-Received: by 2002:aa7:d1cb:0:b0:532:edda:3bb8 with SMTP id
 g11-20020aa7d1cb000000b00532edda3bb8mr5434826edp.16.1696526599747; Thu, 05
 Oct 2023 10:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231005113624.8329-1-piyush.mehta@amd.com>
In-Reply-To: <20231005113624.8329-1-piyush.mehta@amd.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 5 Oct 2023 13:23:05 -0400
Message-ID: <CAMdYzYq87xuZ8fTrGhcV5sdCyuGFGyEAPwJOJSoXE2O_pVZUag@mail.gmail.com>
Subject: Re: [PATCH V2] usb: dwc3: core: disable 3.0 clock when operating in
 2.0 device mode
To:     Piyush Mehta <piyush.mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, michal.simek@amd.com,
        Thinh.Nguyen@synopsys.com, robh@kernel.org,
        herve.codina@bootlin.com, yangbin@rock-chips.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 7:36=E2=80=AFAM Piyush Mehta <piyush.mehta@amd.com> =
wrote:
>
> The GUCTL1.DEV_FORCE_20_CLK_FOR_30_CLK bit enable the feature of internal
> 2.0(utmi/ulpi) clock to be routed as the 3.0 (pipe) clock. This feature i=
s
> applicable when core is operating in 2.0 device mode.
>
> When this bit is set in host mode and core is in 2.0 device mode (maximum
> speed =3D high-speed) then usb super speed devices not detected on host.
>
> To address the above issue added usb device mode conditional check.

Good Afternoon,

This will outright break the patch it attempts to fix. This was
originally done to work around hardware where a dwc3 core was attached
only to a 2.0 phy and lacked 3.0 clocks. While I empathize with the
intentions of the hardware designers, it works perfectly well for host
mode as well as device mode. As I didn't have access to the register
mappings, I was unaware of the original intention of this register
beyond what was in the downstream commit.

If this is affecting hardware in the wild, I would surmise the
firmware for that hardware is incorrectly reporting the dwc3
implementation max speed as USB_SPEED_HIGH or USB_SPEED_FULL when it
should be USB_SPEED_SUPER or USB_SPEED_SUPER_PLUS. If this is the
case, we have fixed this issue in other ways both in newer kernels and
in firmware so the risk of this affecting users is slim. If this is
just to make the software behave the way the hardware designers
originally intended, then I have to respectfully nack this patch.

Very Respectfully,
Peter Geis

>
> Cc: stable@vger.kernel.org
> Fixes: 62b20e6e0dde ("usb: dwc3: core: do not use 3.0 clock when operatin=
g in 2.0 mode")
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---
> DWC3 Register Map Link:
> https://docs.xilinx.com/r/en-US/ug1087-zynq-ultrascale-registers/GUCTL1-U=
SB3_XHCI-Register
> Register Name   GUCTL1
> Bit: 26
> Bit Name: DEV_FORCE_20_CLK_FOR_30_CLK
>
> Change in V2:
> - Added CC stable kernel email.
>
> Link: https://lore.kernel.org/all/20231005102725.8458-1-piyush.mehta@amd.=
com/
> ---
>  drivers/usb/dwc3/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 9c6bf054f15d..0cf1fe60628b 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1202,6 +1202,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
>                         reg |=3D DWC3_GUCTL1_PARKMODE_DISABLE_HS;
>
>                 if (DWC3_VER_IS_WITHIN(DWC3, 290A, ANY) &&
> +                   (dwc->dr_mode =3D=3D USB_DR_MODE_PERIPHERAL) &&
>                     (dwc->maximum_speed =3D=3D USB_SPEED_HIGH ||
>                      dwc->maximum_speed =3D=3D USB_SPEED_FULL))
>                         reg |=3D DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK;
> --
> 2.17.1
>
