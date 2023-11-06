Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2DF7E1949
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 04:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjKFD5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 22:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjKFD5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 22:57:51 -0500
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EDEF2
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 19:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1699243066; x=1699502266;
        bh=As3a27QMW/BoHW+UlSXOW4dmynjX02XHuetDPzr1fAg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=BlhvldTx+ZtolLJefmPmmfXaOWSIoBHIGgVD+Ozt4PdRogycXX5xb/xAjyTNQJkoN
         1gG1i0KW01EJD/WZ929bmEkGbwsexNCyMqEXdYZC/127RtzPlTSRal2Aypr3Nuv7k+
         QRpizadcihXeVXMqOcRy0VdIa3J+E3oCGMgHkzNBk/lQi1OxE9X6RsgYUjOHpHEmdV
         8MiR0g/1UXnAG2bQjilDkbwTYXEEkp351zsCtQXUUHRY2QuWLVPN/6RZyay0KvoDP8
         K2eOMom3LhYidTXM0riGHoot+2itGyI6MxGDnvd5NoRU15MRhhar2jMW5aWQBznbIB
         6J7BGZ3Rr9bxQ==
Date:   Mon, 06 Nov 2023 03:57:39 +0000
To:     Su Hui <suhui@nfschina.com>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     ping.cheng@wacom.com, jason.gerecke@wacom.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] HID: wacom_sys: add error code check in wacom_feature_mapping
Message-ID: <871qd31qkx.fsf@protonmail.com>
In-Reply-To: <20231020090237.201029-1-suhui@nfschina.com>
References: <20231020090237.201029-1-suhui@nfschina.com>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct, 2023 17:02:38 +0800 "Su Hui" <suhui@nfschina.com> wrote:
> hid_report_raw_event() can return error code like '-ENOMEM' if
> failed, so check 'ret' to make sure all things work fine.

I can agree with adding logging for error cases personally.

>
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/hid/wacom_sys.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 3f704b8072e8..1f898d4ee708 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -320,6 +320,8 @@ static void wacom_feature_mapping(struct hid_device *=
hdev,
>  =09=09=09if (ret =3D=3D n && features->type =3D=3D HID_GENERIC) {
>  =09=09=09=09ret =3D hid_report_raw_event(hdev,
>  =09=09=09=09=09HID_FEATURE_REPORT, data, n, 0);
> +=09=09=09=09if (ret)
> +=09=09=09=09=09hid_warn(hdev, "failed to report feature\n");

I think we should report the returned error information as well.

  https://docs.kernel.org/core-api/printk-formats.html#error-pointers

Typically what I do is use ERR_PTR in tandem with the %pe modifier for
printing errors.

>  =09=09=09} else if (ret =3D=3D 2 && features->type !=3D HID_GENERIC) {
>  =09=09=09=09features->touch_max =3D data[1];
>  =09=09=09} else {
> @@ -381,6 +383,8 @@ static void wacom_feature_mapping(struct hid_device *=
hdev,
>  =09=09if (ret =3D=3D n) {
>  =09=09=09ret =3D hid_report_raw_event(hdev, HID_FEATURE_REPORT,
>  =09=09=09=09=09=09   data, n, 0);
> +=09=09=09if (ret)
> +=09=09=09=09hid_warn(hdev, "failed to report feature\n");
>  =09=09} else {
>  =09=09=09hid_warn(hdev, "%s: could not retrieve sensor offsets\n",
>  =09=09=09=09 __func__);

--
Thanks for the patch,

Rahul Rameshbabu

