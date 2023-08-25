Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0165A787E23
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjHYC6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjHYC6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:58:48 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8381E78
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:58:46 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b703a0453fso6510841fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692932325; x=1693537125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3zX4Zb+/ffsYg6eBe+TNid4MG/g6LStWIhoKJPVbas=;
        b=QF971O+bJsLvZ9A2DhNJTQBhjQiiG7vmdQxDxtALAwt1S3XJCKuBQWbZZMAeEWjHiY
         IOZcpB2pcxcDjQLP0j3gAakDNA7gfDXXNAV5n/R2bT2i1T6mcj4p7VP+RB6dGBz53Tba
         UBZFoyZNvcXAdk6SNSr6L4g+7vDHss0vKT7HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692932325; x=1693537125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3zX4Zb+/ffsYg6eBe+TNid4MG/g6LStWIhoKJPVbas=;
        b=a4lEIysx2NkJP/kGKLDWyFa/BOZloNXXBDI5jGF1rVapj88p7U13zAtvKLqfwfgWdf
         5yT53UDSPz+vbHEEmfqLTEpOxVW/vrXd09cJ29Fz+xP9w1hRP/ZPf+HPyLJydcyrsgrL
         acR/KGvV1nV7yGRtGce2u02ZOf6a1d0+TZc/w12eWZ2KH+SllzWhiELQ0s8ockjrdV7y
         WDdm83Yta63QHRxSjRO0U0CXCNQJVn84TKiJFn02aqV2oLOushJg5/65dl7YAIRA4RWh
         BtL7EuxnUnnGb+EtYcAPV/8ir794QbdyjOFvBKCBavEYoQXyMgxdbvskFQsRQoKrV842
         AggQ==
X-Gm-Message-State: AOJu0Yw2Ku119eGKBDbkBioIBZiP/dhBNX+si/Ymzf3SEIdkkni/LsWr
        sGfjCw+2ClsF+TWZKK8qhtT7bXFqPu4bvqRiLje7wg==
X-Google-Smtp-Source: AGHT+IFuAJ8RQxzqoJv6ilDeUOdyzRsdkgYgw1Ez/KEf+jHlvOd98qy2c7Bflc9X1+/D4C1D82gUS0YG3A1fj2lC6uU=
X-Received: by 2002:a2e:988d:0:b0:2b9:4413:864e with SMTP id
 b13-20020a2e988d000000b002b94413864emr12811186ljj.53.1692932325114; Thu, 24
 Aug 2023 19:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230814043140.1108917-1-rekanorman@chromium.org>
 <20230814043140.1108917-6-rekanorman@chromium.org> <67a1657a-e8f4-683c-375d-5ca6b1e75b9a@xs4all.nl>
In-Reply-To: <67a1657a-e8f4-683c-375d-5ca6b1e75b9a@xs4all.nl>
From:   Reka Norman <rekanorman@chromium.org>
Date:   Fri, 25 Aug 2023 12:58:32 +1000
Message-ID: <CAEmPcwssUgayw4B9Wemr818_zSQB5ir3Hpbvm5vFt8S7cLSE_g@mail.gmail.com>
Subject: Re: [PATCH 5/9] media: cros-ec-cec: Support multiple ports in MKBP cec_events
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Stefan Adolfsson <sadolfsson@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thanks for the review.

On Mon, Aug 21, 2023 at 6:51=E2=80=AFPM Hans Verkuil <hverkuil-cisco@xs4all=
.nl> wrote:
>
> Hi Reka,
>
> On 14/08/2023 06:29, Reka Norman wrote:
> > Use the top four bits of the cec_events MKBP event to store the port
> > number.
> >
> > Signed-off-by: Reka Norman <rekanorman@chromium.org>
> > ---
> >
> >  drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 13 +++++++++++--
> >  include/linux/platform_data/cros_ec_commands.h   | 10 ++++++++++
> >  2 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers=
/media/cec/platform/cros-ec/cros-ec-cec.c
> > index d674a432dfdd..eb4b778f83e9 100644
> > --- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> > +++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> > @@ -77,8 +77,17 @@ static void handle_cec_message(struct cros_ec_cec *c=
ros_ec_cec)
> >  static void handle_cec_event(struct cros_ec_cec *cros_ec_cec)
> >  {
> >       struct cros_ec_device *cros_ec =3D cros_ec_cec->cros_ec;
> > -     uint32_t events =3D cros_ec->event_data.data.cec_events;
> > -     struct cros_ec_cec_port *port =3D cros_ec_cec->ports[CEC_PORT];
> > +     uint32_t cec_events =3D cros_ec->event_data.data.cec_events;
> > +     int port_num =3D EC_MKBP_EVENT_CEC_GET_PORT(cec_events);
> > +     uint32_t events =3D EC_MKBP_EVENT_CEC_GET_EVENTS(cec_events);
> > +     struct cros_ec_cec_port *port;
> > +
> > +     if (port_num < 0 || port_num >=3D cros_ec_cec->num_ports) {
>
> Since cec_events is unsigned, then I would also keep port_num unsigned.
> Mixing signed and unsigned for bit shifting is a bit dangerous.
>
> That will also mean that you can skip the 'port_num < 0' check.

Done in v2.

>
> Regards,
>
>         Hans
>
> > +             dev_err(cros_ec->dev,
> > +                     "received CEC event for invalid port %d\n", port_=
num);
> > +             return;
> > +     }
> > +     port =3D cros_ec_cec->ports[port_num];
> >
> >       if (events & EC_MKBP_CEC_SEND_OK)
> >               cec_transmit_attempt_done(port->adap, CEC_TX_STATUS_OK);
> > diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/l=
inux/platform_data/cros_ec_commands.h
> > index 9a0c6e28f370..b7e8573a8a49 100644
> > --- a/include/linux/platform_data/cros_ec_commands.h
> > +++ b/include/linux/platform_data/cros_ec_commands.h
> > @@ -4440,6 +4440,16 @@ struct ec_response_i2c_passthru_protect {
> >
> >  #define MAX_CEC_MSG_LEN 16
> >
> > +/*
> > + * Helper macros for packing/unpacking cec_events.
> > + * bits[27:0] : bitmask of events from enum mkbp_cec_event
> > + * bits[31:28]: port number
> > + */
> > +#define EC_MKBP_EVENT_CEC_PACK(events, port) \
> > +             (((events) & GENMASK(27, 0)) | (((port) & 0xf) << 28))
> > +#define EC_MKBP_EVENT_CEC_GET_EVENTS(event) ((event) & GENMASK(27, 0))
> > +#define EC_MKBP_EVENT_CEC_GET_PORT(event) (((event) >> 28) & 0xf)
> > +
> >  /* CEC message from the AP to be written on the CEC bus */
> >  #define EC_CMD_CEC_WRITE_MSG 0x00B8
> >
>
