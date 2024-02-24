Return-Path: <linux-kernel+bounces-79424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64332862207
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870721C2193A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5923F1870;
	Sat, 24 Feb 2024 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jmQQsPUQ"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766044A06
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708738566; cv=none; b=O9uBloJ7N0dEC0fh7zMSidZeujr3Vl0OGkz32e+x4KctwV89W81tPO+oClhnVFbEgFTyntU7I++G8gZ4AQzUioU8/H4XIO58gJ+4dOVvdWMvIHZINqBQ1rJClBb5kelTCGDsSgvhb7wg0dZGvGcyBi0T9QGuMIGqaipsgQRKwYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708738566; c=relaxed/simple;
	bh=qAScd7DY/IYCjD2R/EuynLEPhyrsPq/8ci8QRnkk19A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbrboUFFkYCma68LkVcBCltb+8QMO11E1ztrki0ntk/sWNdIQAygNukYFa6X7AtCgkbjIIQo6mP/SFO74V/uSTzX7Y93RO9GSNTRKMTE1c0vS33F4mgKt947XlRyrTnfx1SBvbEyAKItG0hqc5UK1w/XndfUKlM2FrovYCe3HBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jmQQsPUQ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42e6939d34fso140781cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708738563; x=1709343363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhlF8VaoU7j5mCqbyUhZwnr4hHO3LQ/+x59GEqEGR2w=;
        b=jmQQsPUQvcRJvAlwTgFmONxD5/Upc97nH/a+mNqWeR8i8JN8HNpuX+Jzn5ycV3/FvV
         AGyy8ptsHXKXMG8LFH84boEiFqx0vqioynqlR91q78PC8ZOTJ15KYpjdzrSgd9fCOx8V
         F5anLjXOcv30xKqL1D2GHbATkWp9Qo3OZre9EmvzMSvmWwVawyVfo3hutwrI3VxO2tAX
         XH5hQelnu1QQYR5uyNUXmEVf2RyKD/fAP6OHSTfy6+Lp97MRVDQKF5lg8Od7jof8hLnW
         PaC3LCtCeLbkvMfXLu3TP1r1XCwmyCdV8oEmboo2RD/VKf98y1h4wNjp2QzxjqyKU27A
         75BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708738563; x=1709343363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhlF8VaoU7j5mCqbyUhZwnr4hHO3LQ/+x59GEqEGR2w=;
        b=xBC04QEQDS71o67w8zYlK9WqnY/hbjI3kkBnsW6BjWZdPiU/2lJbOpkvjTPpsj4oDT
         wa5Sg94cBu+x6nmY6ykFsXxgmUOt4gB110tJIGYNBzJWZp7Xl0CGHVS1tFX+2rKqB+ih
         uFApTffLQfYIF21QlpgQtBL3pDtzpUdYSDskKr1j55vwe0u8sN7kD4SSZ23RC8wlwYzZ
         +FnVDz06eTMffxFu/LoM7mllzjBsRLCQYugJpTkvT059alF7Odn/BzkGnvjxKLmLYOdo
         P5T2KaS3XHD5nRDrTxP46KqohIeG28GoinF894CyWJn2wPa+58ad/FLS5ybMtdhxjzyT
         CdFg==
X-Forwarded-Encrypted: i=1; AJvYcCWnIG+BX+mSmFi1KlyR5xNJgym2pQ2NFZgHHAaT1/uYiBCg6jeDa4HZYGMBYrkbh4wjWrwAYOHC6MKIXEZKvt7Xh4dpbQxBPGRHavAl
X-Gm-Message-State: AOJu0YxL1kbFN+FN48MwwwiqZ3o/bv3GXfn2Z0Wmxk6vngPx3MUlYZaI
	/Jaz33OoV1SE8xKutyK8XPKmIX6Sq8ZYWfgGJfnM9TTqiYgaT9rZnL7FrGNkN4qZceOiIeAaYxT
	mJtnhFsrjzFfKfN/UB5Uo+E2L4oZNP/d89jBt
X-Google-Smtp-Source: AGHT+IGf0rr6oIUX8HTboWJgYYBRtKW9NiDl4Jx0q0Yill0NLFELHByPqLS1Q0GzF7rxZ0oe9S8xFfSvlQdbfVvRycU=
X-Received: by 2002:a05:622a:1705:b0:42c:766f:b13c with SMTP id
 h5-20020a05622a170500b0042c766fb13cmr144010qtk.18.1708738562977; Fri, 23 Feb
 2024 17:36:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207011803.2637531-1-saravanak@google.com>
 <20240207011803.2637531-3-saravanak@google.com> <20240223171849.10f9901d@booty>
In-Reply-To: <20240223171849.10f9901d@booty>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 23 Feb 2024 17:35:24 -0800
Message-ID: <CAGETcx99hhfOaEn1CH1OLDGp_pnrVeJ2nWb3X5=0j8tij4NR9w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] of: property: Improve finding the supplier of a
 remote-endpoint property
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 8:18=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Hello Saravana,
>
> [+cc Herv=C3=A9 Codina]
>
> On Tue,  6 Feb 2024 17:18:01 -0800
> Saravana Kannan <saravanak@google.com> wrote:
>
> > After commit 4a032827daa8 ("of: property: Simplify of_link_to_phandle()=
"),
> > remote-endpoint properties created a fwnode link from the consumer devi=
ce
> > to the supplier endpoint. This is a tiny bit inefficient (not buggy) wh=
en
> > trying to create device links or detecting cycles. So, improve this the
> > same way we improved finding the consumer of a remote-endpoint property=
.
> >
> > Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_phandle()")
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> After rebasing my own branch on v6.8-rc5 from v6.8-rc1 I started
> getting unexpected warnings during device tree overlay removal. After a
> somewhat painful bisection I identified this patch as the one that
> triggers it all.

Thanks for the report.

>
> > ---
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1232,7 +1232,6 @@ DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5", NULL)
> >  DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
> >  DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
> >  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> > -DEFINE_SIMPLE_PROP(remote_endpoint, "remote-endpoint", NULL)
> >  DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
> >  DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
> >  DEFINE_SIMPLE_PROP(leds, "leds", NULL)
> > @@ -1298,6 +1297,17 @@ static struct device_node *parse_interrupts(stru=
ct device_node *np,
> >       return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.n=
p;
> >  }
> >
> > +static struct device_node *parse_remote_endpoint(struct device_node *n=
p,
> > +                                              const char *prop_name,
> > +                                              int index)
> > +{
> > +     /* Return NULL for index > 0 to signify end of remote-endpoints. =
*/
> > +     if (!index || strcmp(prop_name, "remote-endpoint"))
>
> There seem to be a bug here: "!index" should be "index > 0", as the
> comment suggests. Otherwise NULL is always returned.

Ah crap, I think you are right. It should have been "index". Not
"!index". But I tested this! Sigh. I probably screwed up my testing.

Please send out a Fix for this.

Geert, we got excited too soon. :(

> I am going to send a quick patch for that, but haven't done so yet
> because it still won't solve the problem, so I wanted to open the topic
> here without further delay.
>
> Even with the 'index > 0' fix I'm still getting pretty much the same:

This part is confusing though. If I read your DT correctly, there's a
cycle between platform:panel-dsi-lvds and i2c:13-002c. And fw_devlink
should not be enforcing any ordering between those devices ever.

I'm surprised that in your "working" case, fw_devlink didn't detect
any cycle. It should have. If there's any debugging to do, that's the
one we need to debug.

>
> [   34.836781] ------------[ cut here ]------------
> [   34.841401] WARNING: CPU: 2 PID: 204 at drivers/base/devres.c:1064 dev=
m_kfree+0x8c/0xfc
> ...
> [   35.024751] Call trace:
> [   35.027199]  devm_kfree+0x8c/0xfc
> [   35.030520]  devm_drm_panel_bridge_release+0x54/0x64 [drm_kms_helper]
> [   35.036990]  devres_release_group+0xe0/0x164
> [   35.041264]  i2c_device_remove+0x38/0x9c
> [   35.045196]  device_remove+0x4c/0x80
> [   35.048774]  device_release_driver_internal+0x1d4/0x230
> [   35.054003]  device_release_driver+0x18/0x24
> [   35.058279]  bus_remove_device+0xcc/0x10c
> [   35.062292]  device_del+0x15c/0x41c
> [   35.065786]  device_unregister+0x18/0x34
> [   35.069714]  i2c_unregister_device+0x54/0x88
> [   35.073988]  of_i2c_notify+0x98/0x224
> [   35.077656]  blocking_notifier_call_chain+0x6c/0xa0
> [   35.082543]  __of_changeset_entry_notify+0x100/0x16c
> [   35.087515]  __of_changeset_revert_notify+0x44/0x78
> [   35.092398]  of_overlay_remove+0x114/0x1c4
> ...
>
> By comparing the two versions I found that before removing the overlay:
>
>  * in the "working" case (with this patch reverted) I have:
>
>    # ls /sys/class/devlink/ | grep 002c
>    platform:hpbr--i2c:13-002c
>    platform:panel-dsi-lvds--i2c:13-002c

Can you check the "status" and "sync_state_only" file in this folder
and tell me what it says?

Since these devices have a cyclic dependency between them, it should
have been something other than "not tracked" and "sync_state_only"
should be "1". But my guess is you'll see "active" and "0".

>    platform:regulator-sys-1v8--i2c:13-002c
>    regulator:regulator.31--i2c:13-002c
>    #
>
>  * in the "broken" case (v6.8-rc5 + s/!index/index > 0/ as mentioned):
>
>    # ls /sys/class/devlink/ | grep 002c
>    platform:hpbr--i2c:13-002c
>    platform:regulator-sys-1v8--i2c:13-002c
>    regulator:regulator.30--i2c:13-002c
>    #
>
> So in the latter case the panel-dsi-lvds--i2c:13-002c link is missing.
> I think it gets created but later on removed. Here's a snippet of the
> kernel log when that happens:
>
> [    9.578279] ----- cycle: start -----
> [    9.578283] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-=
bridge@2c: cycle: depends on /panel-dsi-lvds
> [    9.578308] /panel-dsi-lvds: cycle: depends on /soc@0/bus@30800000/i2c=
@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> [    9.578329] ----- cycle: end -----
> [    9.578334] platform panel-dsi-lvds: Fixed dependency cycle(s) with /s=
oc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> ...

Somewhere in this area, I'm thinking you'll also see "device:
'i2c:13-002c--platform:panel-dsi-lvds': device_add" do you not? And if
you enabled device link logs, you'll see that it was "sync state only"
link.

> [    9.590620] /panel-dsi-lvds Dropping the fwnode link to /soc@0/bus@308=
00000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> ...
> [    9.597280] ----- cycle: start -----
> [    9.597283] /panel-dsi-lvds: cycle: depends on /soc@0/bus@30800000/i2c=
@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> [    9.602781] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-=
bridge@2c: cycle: depends on /panel-dsi-lvds
> [    9.607581] ----- cycle: end -----
> [    9.607585] i2c 13-002c: Fixed dependency cycle(s) with /panel-dsi-lvd=
s
> [    9.614217] device: 'platform:panel-dsi-lvds--i2c:13-002c': device_add
> ...
> [    9.614277] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-=
bridge@2c Dropping the fwnode link to /panel-dsi-lvds
> [    9.614369] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-=
bridge@2c Dropping the fwnode link to /regulator-dock-sys-1v8
> ...
> [    9.739840] panel-simple panel-dsi-lvds: Dropping the link to 13-002c
> [    9.739846] device: 'i2c:13-002c--platform:panel-dsi-lvds': device_unr=
egister

Oh yeah, see. The "device_add" I expected earlier is getting removed here.

> [   10.247037] sn65dsi83 13-002c: Dropping the link to panel-dsi-lvds
> [   10.247049] device: 'platform:panel-dsi-lvds--i2c:13-002c': device_unr=
egister
>
> And here's the relevant portion of my device tree overlay:
>
> --------------------8<--------------------
>

I think the eventual fix would be this series + adding a
"post-init-providers" property to the device that's supposed to probe
first and point it to the device that's supposed to probe next. Do
this at the device node level, not the endpoint level.
https://lore.kernel.org/lkml/20240221233026.2915061-1-saravanak@google.com/


-Saravana

> /dts-v1/;
> /plugin/;
>
> &{/}
> {
>         panel_dsi_lvds: panel-dsi-lvds {
>                 compatible =3D "auo,g133han01.1";
>
>                 ports {
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         port@0{
>                                 reg =3D <0>;
>                                 dual-lvds-odd-pixels;
>                                 panel_dsi_lvds_in0: endpoint {
>                                         remote-endpoint =3D <&sn65dsi84_o=
ut0>;
>                                 };
>                         };
>
>                         port@1{
>                                 reg =3D <1>;
>                                 dual-lvds-even-pixels;
>                                 panel_dsi_lvds_in1: endpoint {
>                                         remote-endpoint =3D <&sn65dsi84_o=
ut1>;
>                                 };
>                         };
>                 };
>         };
> };
>
> &i2c5_ch3 {
>         dsi-lvds-bridge@2c {
>                 compatible =3D "ti,sn65dsi84";
>                 reg =3D <0x2c>;
>                 vcc-supply =3D <&reg_sys_1v8>;
>
>                 ports {
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>
>                         port@0 {
>                                 reg =3D <0>;
>
>                                 sn65dsi84_from_bridge: endpoint {
>                                         remote-endpoint =3D <&hpbr_source=
>;
>                                         data-lanes =3D <1 2 3 4>;
>                                 };
>                         };
>                         port@2 {
>                                 reg =3D <2>;
>
>                                 sn65dsi84_out0: endpoint {
>                                         remote-endpoint =3D <&panel_dsi_l=
vds_in0>;
>                                 };
>                         };
>                         port@3 {
>                                 reg =3D <3>;
>
>                                 sn65dsi84_out1: endpoint {
>                                         remote-endpoint =3D <&panel_dsi_l=
vds_in1>;
>                                 };
>                         };
>                 };
>         };
> };
>
> --------------------8<--------------------
>
> That's all I could get at this point. Any clues for further
> investigation?
>
> Best regards,
> Luca
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

