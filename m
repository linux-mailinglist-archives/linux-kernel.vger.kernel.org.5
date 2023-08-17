Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F314D77EFDA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 06:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348015AbjHQE0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 00:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348020AbjHQE0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 00:26:02 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D382727
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 21:26:01 -0700 (PDT)
Date:   Thu, 17 Aug 2023 04:25:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1692246356; x=1692505556;
        bh=B8LPr7w6Usubd3nN5qYnL87Sh9VOI73zzLl73W/r3V0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=xSECdhknRS8SYmeLwfXZgc5a6WZe9zXxukHi7uLW8vBG9JsuEAtZlNtl3yfAuLdlw
         /N2QkvFlgRFOf5tsopYJxrIS/IicvQYLAGuXn6ifseC84FxRe9UqzbYBKH+4YBPoNA
         BxaTmv1znaH+lpA7n44ut0QDH91veHTATmHgeM3sXRsS6F/xoSPiNoRUWxx+rfzCEl
         HfZFvojSSjh+6FtsRT9UhPbdNUTgMoWCl3M1pQu69Y8m1aWjIsHXOoVJcnSp88ZdEE
         RN+2zaZYXQzCUO6cZhDglagT68SoDrND03o032LX05NWiCoBEAqWhILd2/8FRNh7z6
         k14oe4g4POr8A==
To:     Riwen Lu <luriwen@hotmail.com>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        dmitry.torokhov@gmail.com, linux@weissschuh.net,
        hdegoede@redhat.com, rrangel@chromium.org,
        u.kleine-koenig@pengutronix.de, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v2] HID: i2c-hid: use print_hex_dump_debug to print report descriptor
Message-ID: <87msyq5m7y.fsf@protonmail.com>
In-Reply-To: <OS3P286MB259916DCE3D992135FF05F4CB115A@OS3P286MB2599.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB2607175E9C15DB17A2102AEAB114A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM> <OS3P286MB259916DCE3D992135FF05F4CB115A@OS3P286MB2599.JPNP286.PROD.OUTLOOK.COM>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Aug, 2023 16:38:19 +0800 "Riwen Lu" <luriwen@hotmail.com> wrote:
> From: Riwen Lu <luriwen@kylinos.cn>
>
> The format '%*ph' print up to 64 bytes long as a hex string with ' '
> sepatator. Usually the size of report descriptor is larger than 64
> bytes, so consider using print_hex_dump_debug to print out all of it for
> better debugging.
>
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
>
> ---
> v1->v2:
>  - Add a prefix for the hex dump.
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c=
-hid-core.c
> index efbba0465eef..fd82e9042da5 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -772,7 +772,9 @@ static int i2c_hid_parse(struct hid_device *hid)
>  =09=09}
>  =09}
>
> -=09i2c_hid_dbg(ihid, "Report Descriptor: %*ph\n", rsize, rdesc);
> +=09i2c_hid_dbg(ihid, "Report Descriptor\n");

Instead of just indicating that the report descriptor dump begins with
the above print, I think it makes more sense for the print to be changed
to a pair of begin/end or "cut here" prints similar to what you see in
oops messages. This will help individuals reading reports copied by bug
reporters validate that the complete descriptor dump is present.

Something along the lines of what is done in sound/soc/sof/debug.c.

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/s=
ound/soc/sof/debug.c?id=3D4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6#n407

> +=09print_hex_dump_debug("Report Descriptor: ", DUMP_PREFIX_OFFSET, 16, 1=
,
> +=09=09=09rdesc, rsize, false);
>

--
Thanks,

Rahul Rameshbabu

