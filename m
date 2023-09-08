Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D111A798B81
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 19:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbjIHRaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjIHRaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 13:30:06 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC5D1FC7;
        Fri,  8 Sep 2023 10:30:01 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 39D4910FE;
        Fri,  8 Sep 2023 19:28:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694194111;
        bh=tJBIxhbcn6XKva6LtHAB0MW4fczFZF1SSUAIJocFSGY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mduOhQvh1EqpIdh5dIYiv030fs5L6KtKqm6KnQ1j4tBciA9hC7eIXHNSvSPK0/G4U
         ySYgviVWeRCE9btIANDYi7FkTs4yWZmmNMKAhdCxfgAMiBO9zcoxJf0AWdfQu3X94d
         FqUfv8KI2iGd7/S7jO6B3ZmiyvsEvnFJrXmuGPLE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPY8ntCYz3D77R7G+JTKvOWW4uNTj-wKrsjJ7ASw_RoN4FU-ow@mail.gmail.com>
References: <20230908124344.171662-1-umang.jain@ideasonboard.com> <20230908124344.171662-3-umang.jain@ideasonboard.com> <vp3bbkaibfzdxzgv5xedpneqtyxqxlvioou5whb567s5txtgve@a4xr3wtmjqzu> <CAPY8ntCYz3D77R7G+JTKvOWW4uNTj-wKrsjJ7ASw_RoN4FU-ow@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] media: i2c: Add driver for IMX519 sensor
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jackson <lee.jackson@arducam.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shawn Tu <shawnx.tu@intel.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Date:   Fri, 08 Sep 2023 18:29:56 +0100
Message-ID: <169419419630.3437168.7121485951334169757@ping.linuxembedded.co.uk>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Quoting Dave Stevenson (2023-09-08 17:57:01)
> Hi Jacopo
>=20
> On Fri, 8 Sept 2023 at 17:24, Jacopo Mondi
> <jacopo.mondi@ideasonboard.com> wrote:
> >
> > Hi Umang
> >
> > On Fri, Sep 08, 2023 at 08:43:44AM -0400, Umang Jain wrote:
> > > From: Lee Jackson <lee.jackson@arducam.com>
> > >

... <snip>

> > > +/* Power/clock management functions */
> > > +static int imx519_power_on(struct device *dev)
> > > +{
> > > +     struct i2c_client *client =3D to_i2c_client(dev);
> > > +     struct v4l2_subdev *sd =3D i2c_get_clientdata(client);
> > > +     struct imx519 *imx519 =3D to_imx519(sd);
> > > +     int ret;
> > > +
> > > +     ret =3D regulator_bulk_enable(ARRAY_SIZE(imx519_supply_name),
> > > +                                 imx519->supplies);
> > > +     if (ret) {
> > > +             dev_err(&client->dev, "%s: failed to enable regulators\=
n",
> > > +                     __func__);
> > > +             return ret;
> > > +     }
> > > +
> > > +     ret =3D clk_prepare_enable(imx519->xclk);
> > > +     if (ret) {
> > > +             dev_err(&client->dev, "%s: failed to enable clock\n",
> > > +                     __func__);
> > > +             goto reg_off;
> > > +     }
> > > +
> > > +     gpiod_set_value_cansleep(imx519->reset_gpio, 1);
> >
> > Usually on power_on the reset/poweron gpios are set to logical 0.
> > If this works for you I think you need to invert the line polarity in
> > your .dts.
>=20
> XCLR needs to go high for IMX519 to power on.
> I think it possibly depends on what you've named it - reset vs power_on
>=20
> Quick sample (admittedly on 6.1 as that's what I happen to have):
> gpiod_set_value_cansleep(XXX_gpio, 1); in power_on.
> - imx219
> - imx214
> - imx274
> - imx334
> - imx335
> - ov7251
>=20
> gpiod_set_value_cansleep(XXX_gpio, 0) in power_on
> - imx290
> - imx296
> - imx412

As this is a camera connected using the Raspberry Pi connector - I have
been looking in this area too to add support for an IMX283.

It occured to me that the GPIO line on the RPi Camera Connector seems to
be named 'POWER_EN' ... and is usually responsible for enabling the
power to the regulators on the camera module...

It seems to me more 'clean/clear' to do something like the following:


/ {
        /* 12 MHz Crystal on the camera module */
        imx283_inclk_0: imx283-inclk-12m {
                compatible =3D "fixed-clock";
                #clock-cells =3D <0>;
                status =3D "okay";
                clock-frequency =3D <12000000>;
        };

        reg_imx283_0_3v3: regulator-imx283-0-vdd3v3 {
                compatible =3D "regulator-fixed";
                pinctrl-names =3D "default";
                pinctrl-0 =3D <&pinctrl_csi0_pwdn>;
                regulator-min-microvolt =3D <3300000>;
                regulator-max-microvolt =3D <3300000>;
                regulator-name =3D "IMX283_0_POWER";
                gpio =3D <&gpio2 11 GPIO_ACTIVE_HIGH>;
                vin-supply =3D <&reg_csi1_3v3>;
                startup-delay-us =3D <300000>;
                enable-active-high;
        };
};


&i2c2 {
        sensor@1a {
                compatible =3D "sony,imx283";
                reg =3D <0x1a>;

                clocks =3D <&imx283_inclk_0>;
                clock-names =3D "xclk";

                rotation =3D <180>;
                orientation =3D <0>;

                status =3D "okay";

                VANA-supply =3D <&reg_imx283_0_3v3>; /* Analog 2.8v */
                VDIG-supply =3D <&reg_imx283_0_3v3>; /* Digital Core 1.05v =
*/
                VDDL-supply =3D <&reg_imx283_0_3v3>; /* IF 1.8v */

                port {
                        imx283_0_ep: endpoint {
                                remote-endpoint =3D <&mipi_csi_0_in>;
                                clock-lanes =3D <0>;
                                data-lanes =3D <1 2 3 4>;
                        };
                };
        };
};


I wondered if that's more clear than using a 'reset' line which isn't
actually what the schematics show.




> > > +     usleep_range(IMX519_XCLR_MIN_DELAY_US,
> > > +                  IMX519_XCLR_MIN_DELAY_US + IMX519_XCLR_DELAY_RANGE=
_US);
> >
> > fsleep() will do
> >
> > > +
> > > +     return 0;
> > > +
> > > +reg_off:
> > > +     regulator_bulk_disable(ARRAY_SIZE(imx519_supply_name), imx519->=
supplies);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int imx519_power_off(struct device *dev)
> > > +{
> > > +     struct i2c_client *client =3D to_i2c_client(dev);
> > > +     struct v4l2_subdev *sd =3D i2c_get_clientdata(client);
> > > +     struct imx519 *imx519 =3D to_imx519(sd);
> > > +
> > > +     gpiod_set_value_cansleep(imx519->reset_gpio, 0);
> > > +     regulator_bulk_disable(ARRAY_SIZE(imx519_supply_name), imx519->=
supplies);
> > > +     clk_disable_unprepare(imx519->xclk);
> >
> > Usually, the reverse power up sequence is used. It shouldn't make any
> > difference, unless the datasheet prescribes this sequence.
>=20
> I'd agree.
> T1 from XCLR falling to VANA/VDIG/VIF falling is 0us, so XCLR must go
> low first. VANA, VDIG, and VIF can then fall in any order.
>=20
> The diagram shows INCK stopping before XCLR is dropped.
> Driving a clock signal into powered down electronics is generally "a
> bad thing", so the clock should be stopped before the regulators are
> killed.
>=20
> Again this is copied from imx477. Our modules don't matter as all 3
> regulators, clock, and XCLR are sequenced off one GPIO.

Indeed, that's the part that makes me think modelling the regulator part
rather than a reset gpio could potentially make sense, but I'm sure this
is one of those scenarios that someone is about to shoot down my idea
;-)

--
Kieran
