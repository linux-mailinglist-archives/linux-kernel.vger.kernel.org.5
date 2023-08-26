Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37EC78984D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 18:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjHZQxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 12:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjHZQxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 12:53:11 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B801C19A0;
        Sat, 26 Aug 2023 09:53:08 -0700 (PDT)
Date:   Sat, 26 Aug 2023 16:52:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1693068783; x=1693327983;
        bh=Tq7QVROr0nN3yxYZhO3RFdX2qIiWBXzb+TGWvqqd7XU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=vDFcgLW/h+QmXyo3sFe45wXPHSpOZe0vbSmfhhUowrL/Bs06YWLTS+umrG+CUECTx
         bzvQ6ul1rpRVVn+U+xzXiY3G9z33s90FkQ5WtWklB/hwNu6C1J6YeeXcyEMhikTp39
         P98ZEbr0NM5a4VZroX/StQsX91MJ51j9oFpbLBityUv7LSlfMqbzqvcTXu6uyD5wy8
         PZdBpPYKKvmAvBWOlIGWFX5aUf+CGmZtngh4J3wYm0qHmrQmT3rgyimdNv/9/viP1M
         Vj8t+ZXecfVyCkhv2DH9DPJgp2IZLyEybAjAg8CGGRJzg2qG+Kv1xhCq7NVPcqzre2
         WLcwodANCajhg==
To:     Max Staudt <max@enpas.org>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Vicki Pfau <vi@endrift.com>,
        Pavel Rojtberg <rojtberg@gmail.com>,
        Roderick Colenbrander <roderick@gaikai.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] xpad: XTYPE_XBOX: Report analog buttons
Message-ID: <87fs45u4o2.fsf@protonmail.com>
In-Reply-To: <20230826152111.13525-2-max@enpas.org>
References: <20230826152111.13525-1-max@enpas.org> <20230826152111.13525-2-max@enpas.org>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You will want to update the commit message subject to use the prefix
"Input: xpad -" instead of "xpad:".

  https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/log/driver=
s/input/joystick/xpad.c

On Sun, 27 Aug, 2023 00:21:10 +0900 "Max Staudt" <max@enpas.org> wrote:
> The original Xbox controllers (XTYPE_XBOX) report 8 buttons in an analog
> fashion, in addition to the digital on/off state:
>
>  - Action buttons A/B/X/Y/black/white
>  - Triggers L/R
>
> Up until now, only the triggers L/R are reported as values 0-255. The
> other pressure sensitive buttons are reported as digital buttons, as
> found on other controllers.
>
> This change exposes these buttons as axes in a way that is as backwards
> compatible as possible.
> The new axes are merely added, and numbered after any existing axes.
> This way, libraries like SDL which renumber axes in enumeration order,
> can keep their button/axis mapping as-is. Userspace can keep working as
> before, and can optionally use the new values when handling this type of
> gamepad.

FWIW, I like the way you handled adding support for the range of the
analog buttons.

>
>  - BTN_A..BTN_Z mapped to ABS_MISC+0..ABS_MISC+5, 0 to 255
>
> Signed-off-by: Max Staudt <max@enpas.org>
> ---
>  drivers/input/joystick/xpad.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.=
c
> index cdb193317c3b..609c06f795de 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -420,6 +420,14 @@ static const signed short xpad_abs_triggers[] =3D {
>  =09-1
>  };
>
> +/* used for analog face buttons mapped to axes */
> +static const signed short xpad_abs_analog_face_buttons[] =3D {
> +=09ABS_MISC + 0, ABS_MISC + 1, /* A, B */
> +=09ABS_MISC + 3, ABS_MISC + 4, /* X, Y */
> +=09ABS_MISC + 2, ABS_MISC + 5, /* C, Z */
> +=09-1
> +};

Would it make more sense to use an enum for this?
Something like the below enum.

  enum xpad_abs_analog_face_btn {
       XPAD_ABS_ANALOG_FACE_BTN_A =3D ABS_MISC,
       XPAD_ABS_ANALOG_FACE_BTN_B,
       XPAD_ABS_ANALOG_FACE_BTN_C,
       XPAD_ABS_ANALOG_FACE_BTN_X,
       XPAD_ABS_ANALOG_FACE_BTN_Y,
       XPAD_ABS_ANALOG_FACE_BTN_Z,
       XPAD_ABS_ANALOG_FACE_BTN_END, /* Must remain as the last element */
  };

This would clean up both xpad_process_packet and xpad_set_up_abs a bit
in my opinion. Your loop for xpad_set_up_abs would look like the
following.

  enum xpad_abs_analog_face_btn btn;

  ...

  for (btn =3D XPAD_ABS_ANALOG_FACE_BTN_A; btn !=3D XPAD_ABS_ANALOG_FACE_BT=
N_END; ++btn)
          xpad_set_up_abs(input_dev, btn);

> +
>  /* used when the controller has extra paddle buttons */
>  static const signed short xpad_btn_paddles[] =3D {
>  =09BTN_TRIGGER_HAPPY5, BTN_TRIGGER_HAPPY6, /* paddle upper right, lower =
right */
> @@ -784,6 +792,15 @@ static void xpad_process_packet(struct usb_xpad *xpa=
d, u16 cmd, unsigned char *d
>  =09input_report_key(dev, BTN_C, data[8]);
>  =09input_report_key(dev, BTN_Z, data[9]);
>
> +=09/* analog buttons A, B, X, Y as axes */
> +=09input_report_abs(dev, xpad_abs_analog_face_buttons[0], data[4]); /* A=
 */
> +=09input_report_abs(dev, xpad_abs_analog_face_buttons[1], data[5]); /* B=
 */
> +=09input_report_abs(dev, xpad_abs_analog_face_buttons[2], data[6]); /* X=
 */
> +=09input_report_abs(dev, xpad_abs_analog_face_buttons[3], data[7]); /* Y=
 */
> +
> +=09/* analog buttons black, white (C, Z) as axes */
> +=09input_report_abs(dev, xpad_abs_analog_face_buttons[4], data[8]); /* C=
 */
> +=09input_report_abs(dev, xpad_abs_analog_face_buttons[5], data[9]); /* Z=
 */
>
>  =09input_sync(dev);
>  }
> @@ -1827,6 +1844,14 @@ static void xpad_set_up_abs(struct input_dev *inpu=
t_dev, signed short abs)
>  =09case ABS_HAT0Y:=09/* the d-pad (only if dpad is mapped to axes */
>  =09=09input_set_abs_params(input_dev, abs, -1, 1, 0, 0);
>  =09=09break;
> +=09case ABS_MISC + 0:
> +=09case ABS_MISC + 1:
> +=09case ABS_MISC + 2:
> +=09case ABS_MISC + 3:
> +=09case ABS_MISC + 4:
> +=09case ABS_MISC + 5:
> +=09=09input_set_abs_params(input_dev, abs, 0, 255, 0, 0);
> +=09=09break;
>  =09case ABS_PROFILE: /* 4 value profile button (such as on XAC) */
>  =09=09input_set_abs_params(input_dev, abs, 0, 4, 0, 0);
>  =09=09break;
> @@ -1928,6 +1953,10 @@ static int xpad_init_input(struct usb_xpad *xpad)
>  =09=09=09xpad_set_up_abs(input_dev, xpad_abs_triggers[i]);
>  =09}
>
> +=09if (xpad->xtype =3D=3D XTYPE_XBOX)
> +=09=09for (i =3D 0; xpad_abs_analog_face_buttons[i] >=3D 0; i++)
> +=09=09=09xpad_set_up_abs(input_dev, xpad_abs_analog_face_buttons[i]);
> +
>  =09/* setup profile button as an axis with 4 possible values */
>  =09if (xpad->mapping & MAP_PROFILE_BUTTON)
>  =09=09xpad_set_up_abs(input_dev, ABS_PROFILE);

--
Thanks,

Rahul Rameshbabu

