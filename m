Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681097B436B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 21:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjI3Tz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 15:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3Tz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 15:55:27 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B569AA7;
        Sat, 30 Sep 2023 12:55:24 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c00df105f8so243864641fa.2;
        Sat, 30 Sep 2023 12:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696103723; x=1696708523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ut4Z8cA/agQwDBiDry0zraMKbJnH+d/MUmYpWf+VUE=;
        b=ECSTZDzYqV/wcgFpkx9192XYUpbKmslhmkP/0k3A9JtYPp8WAYcBysU3AC1fzvzjCf
         hxmYi95eIV1Kf3DDzEMSzPM5WB114O2zaFvFCS6CyZBrXU6Ypg2ujb0lhvjFJddx0jaY
         w4khWQYkHBJPDLleRumlia52IiFqzRijGKhnGFXYEOx+Cb5duItujBNSl91MMSE2VJIS
         306Lbm/49YQrcoqQ9n8ybI3cUGs33v7Sys1OVVlBecHPBY4yjw95E9qvkhByG2Trx1jl
         g+z5HbZQwKS+92DqwOT2idGwG1MrErBWBzU7FMr6qZj/mKScaPE0Y1IUxHIChki/DsaM
         /mNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696103723; x=1696708523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ut4Z8cA/agQwDBiDry0zraMKbJnH+d/MUmYpWf+VUE=;
        b=R+UxdegN8n56FCFLjUv398xGBV5Zjmt/rvnx5rJq/VS85UkK+ZOYjqgjl00Ob/wkg8
         MOKc8U/bNidIdahisBUTbFjIlhVkRnzF2sRw7I4Y11ewsflsjGHmKLIPCPUI7uIEaX6j
         QZz9mArf2cqMfYMgyKKEkPWDQp02NKnENFkmjojpZ4vqc+mkp9HgOqg3w471MM639Vl9
         dCqC8YeXx/egMi8lZem4lESB9PwEzRrej1gO/g7w0Fu1Y2HHkDPzPseeUWgY042ycDiX
         xvvwMrnN3XziVMFUdsOEaHdhRD5CwO0O/icTfvuV8vy7ceBWpnu9IrNbGPwx2XA11xZZ
         H9mw==
X-Gm-Message-State: AOJu0YzeruFxgswwHbeYp/ryWMQcdGYeArvnopbANe0EXJIOvZS6vxFl
        1vfO5PmIXW3yjfnu5jJac9AE1LeS3idSlYrq2J8=
X-Google-Smtp-Source: AGHT+IGfKyEiGlrtUTYkcy5hYvJUyl58aMfY8VxFG5umRnVpxeE2AYnsASUDisxyjWGSqiX01V4SHN2HClJak9lgZP8=
X-Received: by 2002:a2e:9085:0:b0:2c0:2f51:cb98 with SMTP id
 l5-20020a2e9085000000b002c02f51cb98mr6048819ljg.11.1696103722668; Sat, 30 Sep
 2023 12:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230924140927.9844-2-tinozzo123@gmail.com>
In-Reply-To: <20230924140927.9844-2-tinozzo123@gmail.com>
From:   Daniel Ogorchock <djogorchock@gmail.com>
Date:   Sat, 30 Sep 2023 15:55:11 -0400
Message-ID: <CAEVj2tnbFrdUPmNWWb2ePoh-6-OTqLmv1n6OcmJeUgBrY6w1FA@mail.gmail.com>
Subject: Re: [PATCH v3] HID: nintendo: reinitialize USB Pro Controller after
 resuming from suspend
To:     Martino Fontana <tinozzo123@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Martino,

On Sun, Sep 24, 2023 at 10:13=E2=80=AFAM Martino Fontana <tinozzo123@gmail.=
com> wrote:
>
> When suspending the computer, a Switch Pro Controller connected via USB w=
ill
> lose its internal status. However, because the USB connection was technic=
ally
> never lost, when resuming the computer, the driver will attempt to commun=
icate
> with the controller as if nothing happened (and fail).
> Because of this, the user was forced to manually disconnect the controlle=
r
> (or to press the sync button on the controller to power it off), so that =
it
> can be re-initialized.
>
> With this patch, the controller will be automatically re-initialized afte=
r
> resuming from suspend.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D216233
>
> Signed-off-by: Martino Fontana <tinozzo123@gmail.com>
>
> ---
> Changes for v2 and v3: Applied suggestions
>
>  drivers/hid/hid-nintendo.c | 175 ++++++++++++++++++++++---------------
>  1 file changed, 103 insertions(+), 72 deletions(-)
>
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 250f5d2f8..10468f727 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -2088,7 +2088,9 @@ static int joycon_read_info(struct joycon_ctlr *ctl=
r)
>         struct joycon_input_report *report;
>
>         req.subcmd_id =3D JC_SUBCMD_REQ_DEV_INFO;
> +       mutex_lock(&ctlr->output_mutex);
>         ret =3D joycon_send_subcmd(ctlr, &req, 0, HZ);
> +       mutex_unlock(&ctlr->output_mutex);
>         if (ret) {
>                 hid_err(ctlr->hdev, "Failed to get joycon info; ret=3D%d\=
n", ret);
>                 return ret;
> @@ -2117,6 +2119,85 @@ static int joycon_read_info(struct joycon_ctlr *ct=
lr)
>         return 0;
>  }
>
> +static int joycon_init(struct hid_device *hdev)
> +{
> +       struct joycon_ctlr *ctlr =3D hid_get_drvdata(hdev);
> +       int ret =3D 0;
> +
> +       mutex_lock(&ctlr->output_mutex);
> +       /* if handshake command fails, assume ble pro controller */
> +       if ((jc_type_is_procon(ctlr) || jc_type_is_chrggrip(ctlr)) &&
> +           !joycon_send_usb(ctlr, JC_USB_CMD_HANDSHAKE, HZ)) {
> +               hid_dbg(hdev, "detected USB controller\n");
> +               /* set baudrate for improved latency */
> +               ret =3D joycon_send_usb(ctlr, JC_USB_CMD_BAUDRATE_3M, HZ)=
;
> +               if (ret) {
> +                       hid_err(hdev, "Failed to set baudrate; ret=3D%d\n=
", ret);
> +                       goto out_unlock;
> +               }
> +               /* handshake */
> +               ret =3D joycon_send_usb(ctlr, JC_USB_CMD_HANDSHAKE, HZ);
> +               if (ret) {
> +                       hid_err(hdev, "Failed handshake; ret=3D%d\n", ret=
);
> +                       goto out_unlock;
> +               }
> +               /*
> +                * Set no timeout (to keep controller in USB mode).
> +                * This doesn't send a response, so ignore the timeout.
> +                */
> +               joycon_send_usb(ctlr, JC_USB_CMD_NO_TIMEOUT, HZ/10);
> +       } else if (jc_type_is_chrggrip(ctlr)) {
> +               hid_err(hdev, "Failed charging grip handshake\n");
> +               ret =3D -ETIMEDOUT;
> +               goto out_unlock;
> +       }
> +
> +       /* get controller calibration data, and parse it */
> +       ret =3D joycon_request_calibration(ctlr);
> +       if (ret) {
> +               /*
> +                * We can function with default calibration, but it may b=
e
> +                * inaccurate. Provide a warning, and continue on.
> +                */
> +               hid_warn(hdev, "Analog stick positions may be inaccurate\=
n");
> +       }
> +
> +       /* get IMU calibration data, and parse it */
> +       ret =3D joycon_request_imu_calibration(ctlr);
> +       if (ret) {
> +               /*
> +                * We can function with default calibration, but it may b=
e
> +                * inaccurate. Provide a warning, and continue on.
> +                */
> +               hid_warn(hdev, "Unable to read IMU calibration data\n");
> +       }
> +
> +       /* Set the reporting mode to 0x30, which is the full report mode =
*/
> +       ret =3D joycon_set_report_mode(ctlr);
> +       if (ret) {
> +               hid_err(hdev, "Failed to set report mode; ret=3D%d\n", re=
t);
> +               goto out_unlock;
> +       }
> +
> +       /* Enable rumble */
> +       ret =3D joycon_enable_rumble(ctlr);
> +       if (ret) {
> +               hid_err(hdev, "Failed to enable rumble; ret=3D%d\n", ret)=
;
> +               goto out_unlock;
> +       }
> +
> +       /* Enable the IMU */
> +       ret =3D joycon_enable_imu(ctlr);
> +       if (ret) {
> +               hid_err(hdev, "Failed to enable the IMU; ret=3D%d\n", ret=
);
> +               goto out_unlock;
> +       }
> +
> +out_unlock:
> +       mutex_unlock(&ctlr->output_mutex);
> +       return ret;
> +}
> +
>  /* Common handler for parsing inputs */
>  static int joycon_ctlr_read_handler(struct joycon_ctlr *ctlr, u8 *data,
>                                                               int size)
> @@ -2248,85 +2329,19 @@ static int nintendo_hid_probe(struct hid_device *=
hdev,
>
>         hid_device_io_start(hdev);
>
> -       /* Initialize the controller */
> -       mutex_lock(&ctlr->output_mutex);
> -       /* if handshake command fails, assume ble pro controller */
> -       if ((jc_type_is_procon(ctlr) || jc_type_is_chrggrip(ctlr)) &&
> -           !joycon_send_usb(ctlr, JC_USB_CMD_HANDSHAKE, HZ)) {
> -               hid_dbg(hdev, "detected USB controller\n");
> -               /* set baudrate for improved latency */
> -               ret =3D joycon_send_usb(ctlr, JC_USB_CMD_BAUDRATE_3M, HZ)=
;
> -               if (ret) {
> -                       hid_err(hdev, "Failed to set baudrate; ret=3D%d\n=
", ret);
> -                       goto err_mutex;
> -               }
> -               /* handshake */
> -               ret =3D joycon_send_usb(ctlr, JC_USB_CMD_HANDSHAKE, HZ);
> -               if (ret) {
> -                       hid_err(hdev, "Failed handshake; ret=3D%d\n", ret=
);
> -                       goto err_mutex;
> -               }
> -               /*
> -                * Set no timeout (to keep controller in USB mode).
> -                * This doesn't send a response, so ignore the timeout.
> -                */
> -               joycon_send_usb(ctlr, JC_USB_CMD_NO_TIMEOUT, HZ/10);
> -       } else if (jc_type_is_chrggrip(ctlr)) {
> -               hid_err(hdev, "Failed charging grip handshake\n");
> -               ret =3D -ETIMEDOUT;
> -               goto err_mutex;
> -       }
> -
> -       /* get controller calibration data, and parse it */
> -       ret =3D joycon_request_calibration(ctlr);
> +       ret =3D joycon_init(hdev);
>         if (ret) {
> -               /*
> -                * We can function with default calibration, but it may b=
e
> -                * inaccurate. Provide a warning, and continue on.
> -                */
> -               hid_warn(hdev, "Analog stick positions may be inaccurate\=
n");
> -       }
> -
> -       /* get IMU calibration data, and parse it */
> -       ret =3D joycon_request_imu_calibration(ctlr);
> -       if (ret) {
> -               /*
> -                * We can function with default calibration, but it may b=
e
> -                * inaccurate. Provide a warning, and continue on.
> -                */
> -               hid_warn(hdev, "Unable to read IMU calibration data\n");
> -       }
> -
> -       /* Set the reporting mode to 0x30, which is the full report mode =
*/
> -       ret =3D joycon_set_report_mode(ctlr);
> -       if (ret) {
> -               hid_err(hdev, "Failed to set report mode; ret=3D%d\n", re=
t);
> -               goto err_mutex;
> -       }
> -
> -       /* Enable rumble */
> -       ret =3D joycon_enable_rumble(ctlr);
> -       if (ret) {
> -               hid_err(hdev, "Failed to enable rumble; ret=3D%d\n", ret)=
;
> -               goto err_mutex;
> -       }
> -
> -       /* Enable the IMU */
> -       ret =3D joycon_enable_imu(ctlr);
> -       if (ret) {
> -               hid_err(hdev, "Failed to enable the IMU; ret=3D%d\n", ret=
);
> -               goto err_mutex;
> +               hid_err(hdev, "Failed to initialize controller; ret=3D%d\=
n", ret);
> +               goto err_close;
>         }
>
>         ret =3D joycon_read_info(ctlr);
>         if (ret) {
>                 hid_err(hdev, "Failed to retrieve controller info; ret=3D=
%d\n",
>                         ret);
> -               goto err_mutex;
> +               goto err_close;
>         }
>
> -       mutex_unlock(&ctlr->output_mutex);
> -
>         /* Initialize the leds */
>         ret =3D joycon_leds_create(ctlr);
>         if (ret) {
> @@ -2352,8 +2367,6 @@ static int nintendo_hid_probe(struct hid_device *hd=
ev,
>         hid_dbg(hdev, "probe - success\n");
>         return 0;
>
> -err_mutex:
> -       mutex_unlock(&ctlr->output_mutex);
>  err_close:
>         hid_hw_close(hdev);
>  err_stop:
> @@ -2383,6 +2396,20 @@ static void nintendo_hid_remove(struct hid_device =
*hdev)
>         hid_hw_stop(hdev);
>  }
>
> +#ifdef CONFIG_PM
> +
> +static int nintendo_hid_resume(struct hid_device *hdev)
> +{
> +       int ret =3D joycon_init(hdev);
> +
> +       if (ret)
> +               hid_err(hdev, "Failed to restore controller after resume"=
);
> +
> +       return ret;
> +}
> +
> +#endif
> +
>  static const struct hid_device_id nintendo_hid_devices[] =3D {
>         { HID_USB_DEVICE(USB_VENDOR_ID_NINTENDO,
>                          USB_DEVICE_ID_NINTENDO_PROCON) },
> @@ -2404,6 +2431,10 @@ static struct hid_driver nintendo_hid_driver =3D {
>         .probe          =3D nintendo_hid_probe,
>         .remove         =3D nintendo_hid_remove,
>         .raw_event      =3D nintendo_hid_event,
> +
> +#ifdef CONFIG_PM
> +       .resume         =3D nintendo_hid_resume,
> +#endif
>  };
>  module_hid_driver(nintendo_hid_driver);
>
> --
> 2.42.0
>

Thanks for adding the resume hook for usb controllers. Looks good to me.

Reviewed-by: Daniel J. Ogorchock <djogorchock@gmail.com>
