Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DE979004B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243978AbjIAP77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbjIAP75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:59:57 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1117710EB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:59:55 -0700 (PDT)
Date:   Fri, 01 Sep 2023 15:59:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1693583992; x=1693843192;
        bh=Y9eaprJMcBGpMVdDgNW6CZnivHlTL91JLFKvr441fEU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Hb0oMYDFpg8bdnkFVfLwdgHFsXa0sbR4MIIkIY9bJKVdN/XiqudAGvnRPJ7nRFRNa
         7fi54qjYFGtkQM+J4mG+yXCJs+AgIgNi4tKNaxwF2mTSLY0SszD/CPcvk19k2DJ4k0
         x5Tod0TJjql16c8g1WuVO6VtTM3pOxqALDuDGvPb3lZdYQBA1qaQ25uk83wuYdVaOH
         N26XjikLY3bUpGKYkb2NxfZL+GMR2wpn+lV9x3/9j0zcPLQ0Qk/Cgz5GWrksxJDtD7
         Q7Y30WGQ30xjuzF1sEM6fZZkslQRjMBAAt6LLGV1jvDg3huPFbJW7fgOj68m4kN7xd
         LSxoWA2oXDBuQ==
To:     Riwen Lu <luriwen@hotmail.com>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        dmitry.torokhov@gmail.com, linux@weissschuh.net,
        hdegoede@redhat.com, rrangel@chromium.org,
        u.kleine-koenig@pengutronix.de, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v3] HID: i2c-hid: use print_hex_dump_debug to print report descriptor
Message-ID: <87pm31vq8u.fsf@protonmail.com>
In-Reply-To: <TYCP286MB26078CEC570EA9055D86D82DB1E4A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
References: <87bketu33z.fsf@protonmail.com> <TYCP286MB26078CEC570EA9055D86D82DB1E4A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 01 Sep, 2023 16:33:56 +0800 "Riwen Lu" <luriwen@hotmail.com> wrote:
> From: Riwen Lu <luriwen@kylinos.cn>
>
> The format '%*ph' prints up to 64 bytes long as a hex string with ' '
> separator. Usually the size of report descriptor is larger than 64
> bytes, so consider using print_hex_dump_debug to print out all of it for
> better debugging.
>
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
>
> ---
> v1->v2:
>  - Add a prefix for the hex dump.
>
> v2->v3:
>  - Print the size of report descriptor.
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c=
-hid-core.c
> index efbba0465eef..dd69abdd1f0d 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -772,7 +772,9 @@ static int i2c_hid_parse(struct hid_device *hid)
>  =09=09}
>  =09}
>
> -=09i2c_hid_dbg(ihid, "Report Descriptor: %*ph\n", rsize, rdesc);
> +=09i2c_hid_dbg(ihid, "Report Descriptor size: %#x\n", rsize);
> +=09print_hex_dump_debug("Report Descriptor: ", DUMP_PREFIX_OFFSET, 16, 1=
,
> +=09=09=09rdesc, rsize, false);
>
>  =09ret =3D hid_parse_report(hid, rdesc, rsize);
>  =09if (!use_override)

Thanks for the new version.

Reviewed-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>

