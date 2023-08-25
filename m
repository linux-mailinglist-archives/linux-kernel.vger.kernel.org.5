Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0E478840A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbjHYJqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238559AbjHYJqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B9F19A1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692956746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CrjGBjMuzKz4ebBtAvxlAUidoQDPdf4WSl157LQLo1U=;
        b=IYXPDpm6SGzAqZtnelj/K62ex6jIz7bygYNXIvkZfeV01fIFp7bVIy1JJjirAdJwtczO+d
        +i6CKhCnWF7erThWKHQUHcXaPoQbEGMfvzWXBHE6xWmzkUBgsqSjvjIdxj4hD9MAgsSr9J
        Z8Zy8mqZnx7A0t85HHjexVIJvm1A0TY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-8ecOoDNNMzatBNR3769slw-1; Fri, 25 Aug 2023 05:45:45 -0400
X-MC-Unique: 8ecOoDNNMzatBNR3769slw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5231d9f9e53so733087a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692956744; x=1693561544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrjGBjMuzKz4ebBtAvxlAUidoQDPdf4WSl157LQLo1U=;
        b=dv5jWWPLCqK4w45YgBgX+/JtMmYmXxzuAeGPaik51yHOgYHbHGbg1TkMj3fyrP+2xd
         LIiO+orB736V1iz5K+jQeoClfIpqHEWkLLQd5LXIaXPKHXfcXmIkrq54W5DZ5PWYcBEQ
         pkgdMsEswCLfuJ2tG0HcvTsN5+2c/2OBCqWgNHTVkxf1JSKMPKf+t/mz5LTZYPcKxjTj
         yVe557PqAZZjXXUa8msetzJjPrc1UISX4bIFTYR3yaPQgi6n3Mum5QnwQTBstUgSAfZL
         ElJAHOXmVfzkJlEkKRw3nJYCIsNswpoMBEY79fT2zI5QCBRE493IS7FQPNExIH00QQfp
         4uHw==
X-Gm-Message-State: AOJu0YyGTPf4B8LVqpLRba89EBrrRAfLdLMaTOIprlcPino7Hd3DwHGe
        ib/r9OO6ADKkUYg2R2XgSQeGhvjdxuNndDjm51G2BhIV08J65uahoqyUQLI2jUHbnBa+pIGUUpk
        iCDSu3fc/zqIU8yhDQJi2mMAKeGmQ0WwvNgTLg3s3
X-Received: by 2002:aa7:d6d3:0:b0:526:9c4:bc06 with SMTP id x19-20020aa7d6d3000000b0052609c4bc06mr12003163edr.18.1692956744076;
        Fri, 25 Aug 2023 02:45:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgDt9FIdtsEpC4kqD3qNgfVsFAQCtSPJhDeSOFK7od6AJWv525UNBnReV1XMVXkZOH/9VDNNk8OLriDkJjk6M=
X-Received: by 2002:aa7:d6d3:0:b0:526:9c4:bc06 with SMTP id
 x19-20020aa7d6d3000000b0052609c4bc06mr12003144edr.18.1692956743782; Fri, 25
 Aug 2023 02:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230621-logitech-fixes-v2-1-3635f7f9c8af@kernel.org> <b68cf309-fca4-7ae0-b42f-90d5f338acdd@leemhuis.info>
In-Reply-To: <b68cf309-fca4-7ae0-b42f-90d5f338acdd@leemhuis.info>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 25 Aug 2023 11:45:32 +0200
Message-ID: <CAO-hwJLURSc03SdiHXst=kJnpZNjX0eeKPn14fYhtiSvWFzqKg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: logitech-hidpp: rework one more time the retries attempts
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     bentiss@kernel.org,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

On Fri, Aug 4, 2023 at 11:14=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Hi Benjamin, /me again! :-D
>
> On 12.07.23 17:02, bentiss@kernel.org wrote:
> > From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > Extract the internal code inside a helper function, fix the
> > initialization of the parameters used in the helper function
> > (`hidpp->answer_available` was not reset and `*response` wasn't either)=
,
> > and use a `do {...} while();` loop.
> >
> > Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device i=
s busy")
> > Cc: stable@vger.kernel.org
>
> From what I understood there was hope that this would cure the last
> remains (occasional init problems iirc) of the recent regressions with
> this driver and their fixes. But things look stalled. Is there a reason?
> Lack of reviews? Is there nevertheless hope that this will make it at
> least into 6.6?

Well, mostly lack of testing. But given that nothing happened, I just
sneaked it in the 6.6 work. I guess bots are happy enough by now.

Cheers,
Benjamin

>
> Ciao, Thorsten
>
> > Reviewed-by: Bastien Nocera <hadess@hadess.net>
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> > as requested by https://lore.kernel.org/all/CAHk-=3DwiMbF38KCNhPFiargen=
pSBoecSXTLQACKS2UMyo_Vu2ww@mail.gmail.com/
> > This is a rewrite of that particular piece of code.
> > ---
> > Changes in v2:
> > - added __must_hold() for KASAN
> > - Reworked the comment describing the functions and their return values
> > - Link to v1: https://lore.kernel.org/r/20230621-logitech-fixes-v1-1-32=
e70933c0b0@redhat.com
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 115 +++++++++++++++++++++++++------=
--------
> >  1 file changed, 75 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitec=
h-hidpp.c
> > index 129b01be488d..09ba2086c95c 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -275,21 +275,22 @@ static int __hidpp_send_report(struct hid_device =
*hdev,
> >  }
> >
> >  /*
> > - * hidpp_send_message_sync() returns 0 in case of success, and somethi=
ng else
> > - * in case of a failure.
> > - * - If ' something else' is positive, that means that an error has be=
en raised
> > - *   by the protocol itself.
> > - * - If ' something else' is negative, that means that we had a classi=
c error
> > - *   (-ENOMEM, -EPIPE, etc...)
> > + * Effectively send the message to the device, waiting for its answer.
> > + *
> > + * Must be called with hidpp->send_mutex locked
> > + *
> > + * Same return protocol than hidpp_send_message_sync():
> > + * - success on 0
> > + * - negative error means transport error
> > + * - positive value means protocol error
> >   */
> > -static int hidpp_send_message_sync(struct hidpp_device *hidpp,
> > +static int __do_hidpp_send_message_sync(struct hidpp_device *hidpp,
> >       struct hidpp_report *message,
> >       struct hidpp_report *response)
> >  {
> > -     int ret =3D -1;
> > -     int max_retries =3D 3;
> > +     int ret;
> >
> > -     mutex_lock(&hidpp->send_mutex);
> > +     __must_hold(&hidpp->send_mutex);
> >
> >       hidpp->send_receive_buf =3D response;
> >       hidpp->answer_available =3D false;
> > @@ -300,47 +301,74 @@ static int hidpp_send_message_sync(struct hidpp_d=
evice *hidpp,
> >        */
> >       *response =3D *message;
> >
> > -     for (; max_retries !=3D 0 && ret; max_retries--) {
> > -             ret =3D __hidpp_send_report(hidpp->hid_dev, message);
> > +     ret =3D __hidpp_send_report(hidpp->hid_dev, message);
> > +     if (ret) {
> > +             dbg_hid("__hidpp_send_report returned err: %d\n", ret);
> > +             memset(response, 0, sizeof(struct hidpp_report));
> > +             return ret;
> > +     }
> >
> > -             if (ret) {
> > -                     dbg_hid("__hidpp_send_report returned err: %d\n",=
 ret);
> > -                     memset(response, 0, sizeof(struct hidpp_report));
> > -                     break;
> > -             }
> > +     if (!wait_event_timeout(hidpp->wait, hidpp->answer_available,
> > +                             5*HZ)) {
> > +             dbg_hid("%s:timeout waiting for response\n", __func__);
> > +             memset(response, 0, sizeof(struct hidpp_report));
> > +             return -ETIMEDOUT;
> > +     }
> >
> > -             if (!wait_event_timeout(hidpp->wait, hidpp->answer_availa=
ble,
> > -                                     5*HZ)) {
> > -                     dbg_hid("%s:timeout waiting for response\n", __fu=
nc__);
> > -                     memset(response, 0, sizeof(struct hidpp_report));
> > -                     ret =3D -ETIMEDOUT;
> > -                     break;
> > -             }
> > +     if (response->report_id =3D=3D REPORT_ID_HIDPP_SHORT &&
> > +         response->rap.sub_id =3D=3D HIDPP_ERROR) {
> > +             ret =3D response->rap.params[1];
> > +             dbg_hid("%s:got hidpp error %02X\n", __func__, ret);
> > +             return ret;
> > +     }
> >
> > -             if (response->report_id =3D=3D REPORT_ID_HIDPP_SHORT &&
> > -                 response->rap.sub_id =3D=3D HIDPP_ERROR) {
> > -                     ret =3D response->rap.params[1];
> > -                     dbg_hid("%s:got hidpp error %02X\n", __func__, re=
t);
> > +     if ((response->report_id =3D=3D REPORT_ID_HIDPP_LONG ||
> > +          response->report_id =3D=3D REPORT_ID_HIDPP_VERY_LONG) &&
> > +         response->fap.feature_index =3D=3D HIDPP20_ERROR) {
> > +             ret =3D response->fap.params[1];
> > +             dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__, ret);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * hidpp_send_message_sync() returns 0 in case of success, and somethi=
ng else
> > + * in case of a failure.
> > + *
> > + * See __do_hidpp_send_message_sync() for a detailed explanation of th=
e returned
> > + * value.
> > + */
> > +static int hidpp_send_message_sync(struct hidpp_device *hidpp,
> > +     struct hidpp_report *message,
> > +     struct hidpp_report *response)
> > +{
> > +     int ret;
> > +     int max_retries =3D 3;
> > +
> > +     mutex_lock(&hidpp->send_mutex);
> > +
> > +     do {
> > +             ret =3D __do_hidpp_send_message_sync(hidpp, message, resp=
onse);
> > +             if (ret !=3D HIDPP20_ERROR_BUSY)
> >                       break;
> > -             }
> >
> > -             if ((response->report_id =3D=3D REPORT_ID_HIDPP_LONG ||
> > -                  response->report_id =3D=3D REPORT_ID_HIDPP_VERY_LONG=
) &&
> > -                 response->fap.feature_index =3D=3D HIDPP20_ERROR) {
> > -                     ret =3D response->fap.params[1];
> > -                     if (ret !=3D HIDPP20_ERROR_BUSY) {
> > -                             dbg_hid("%s:got hidpp 2.0 error %02X\n", =
__func__, ret);
> > -                             break;
> > -                     }
> > -                     dbg_hid("%s:got busy hidpp 2.0 error %02X, retryi=
ng\n", __func__, ret);
> > -             }
> > -     }
> > +             dbg_hid("%s:got busy hidpp 2.0 error %02X, retrying\n", _=
_func__, ret);
> > +     } while (--max_retries);
> >
> >       mutex_unlock(&hidpp->send_mutex);
> >       return ret;
> >
> >  }
> >
> > +/*
> > + * hidpp_send_fap_command_sync() returns 0 in case of success, and som=
ething else
> > + * in case of a failure.
> > + *
> > + * See __do_hidpp_send_message_sync() for a detailed explanation of th=
e returned
> > + * value.
> > + */
> >  static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
> >       u8 feat_index, u8 funcindex_clientid, u8 *params, int param_count=
,
> >       struct hidpp_report *response)
> > @@ -373,6 +401,13 @@ static int hidpp_send_fap_command_sync(struct hidp=
p_device *hidpp,
> >       return ret;
> >  }
> >
> > +/*
> > + * hidpp_send_rap_command_sync() returns 0 in case of success, and som=
ething else
> > + * in case of a failure.
> > + *
> > + * See __do_hidpp_send_message_sync() for a detailed explanation of th=
e returned
> > + * value.
> > + */
> >  static int hidpp_send_rap_command_sync(struct hidpp_device *hidpp_dev,
> >       u8 report_id, u8 sub_id, u8 reg_address, u8 *params, int param_co=
unt,
> >       struct hidpp_report *response)
> >
> > ---
> > base-commit: 87854366176403438d01f368b09de3ec2234e0f5
> > change-id: 20230621-logitech-fixes-a4c0e66ea2ad
> >
> > Best regards,
>

