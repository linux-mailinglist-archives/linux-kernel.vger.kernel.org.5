Return-Path: <linux-kernel+bounces-87658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1415986D713
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B5BBB22236
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BE445948;
	Thu, 29 Feb 2024 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="pJLd0YIF"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9A16FF51
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709247290; cv=none; b=iOZvBWCkj0TPJVmuShVZRlrB053lPPaXlgz2q/TVfI0+7Ict3qlhWX0nTdn+IXuQODYF0/TMZxeBlGc8p7fcIKLolsK6kbxcZyztwe88rdn8HwOV9yzXHEQrYxFyjGyC3Jr0d2J9LTXOtoNi43b+JKNe4zdZ9SWAEb0CM+lQjFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709247290; c=relaxed/simple;
	bh=BzE9TtJXw0OT2ctsGuF95nCD3XyMd/gwzOIC9DeYU9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frACu2ce8IbsLyQjAcoDESSVi4sm+cVuuAhg25Ltu7StpVdPu+6Ry0MM0P7sooYrupBUwZEpELA5O82poA4HshhEMvakH+Iuiub67qFTg2oTvHyM30+/wKcgfxbx7Bc/MnExnMQuNr7kjIYdG9+LyeMl/OcVhn5frhl46iVpKQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJLd0YIF; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42ec412cafdso12121cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709247287; x=1709852087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JX/J+zkh43A2orxP0xrWTQKrggtmjMs6UPrRYq8Gb98=;
        b=pJLd0YIFIpvAceYD17Q+0/Shqq1nq8Iy3yCUMkoHw8fBqt0SsdH/2AaI7Kd+sF+Wg9
         wF0aqR9WUIQu8x3BJNTZ6RAGO+UFLglFP8p9TXy1PBZKhJBWv+PKacUMHqs+yPe1Q8uD
         3Ee8xreJSqw02fCi047g97uSLNy4K+XqEHS/4CdW4nhaTtJevKf1gyvXrS9azTxpq4v2
         nJt3379eR5qJwSNAFqnmkaF6QQ6ieBbGENeUGzYHbw4nrJqaYYPZq16tTwx5jCbEfTFk
         3LmXUbyaYivGkuEFZ05G/eYjqSfGwhI0C0hKe3FpAGI+ejmgvycp16fr+pstyIltWQn3
         S3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709247287; x=1709852087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JX/J+zkh43A2orxP0xrWTQKrggtmjMs6UPrRYq8Gb98=;
        b=gRBKqTC9HKk3nl9ClgyCHTvgL0CZRXdziyq/kgfKLEcJ3AjqfgMjud+BjfbwdQrDAt
         ZRusEAd7QC+/wkBzvAh+FnHFudhchL2XppD3T0uuCqXAdznPyPAf3322MGWZYgLs9G1/
         nf6eYXNwK1kmeMJ+/to+kn28DB9+n1uf+ZWXVlXFJkrCpOTQYoqgv5zNKlBOD/ronc+Q
         vWGllOvWVqsjAtYoQ7fOnkmaB3vPl4nqcgeIPo+zLy2EY4/2zTpL8XjQAnO85O4aCScw
         h9WdMsCw4KYK+/E1OW6Q+ijA1adgE9toAEN2vf1nbzmsJUMlGVjwdTPjJUHBpypOIzPE
         5CCg==
X-Forwarded-Encrypted: i=1; AJvYcCUPH1CG2qzMz6AFExgm/P4ar+OKZx7/VJIXBbKIuD9DcwqaOD1qnrktMtFiAtuwms30ajm+t3K57UvlfrbRDc8JfHjkadwYuCSOzRMp
X-Gm-Message-State: AOJu0YyffTPoIcucYnphG2gTLVgGJBx/X0H6EuEMSkFa50yvc9A2bX4W
	jYod7R2AbjZTbfWVSH4Az4UJNaZIFTNCgD7L+Dth3CsxnYxPDnOkUU1PRGQ0UqOdgWEz5W7kMsf
	kZytFhD29bTE2dxhzGPLJYUQcGsLhW2gcMCGD
X-Google-Smtp-Source: AGHT+IEOvoF7/kpM84OCXfzuF8A0OL2YCdxY9gR0t1QHdHGse+BvDX8iygl9ABpbBt/oCG2T8+/rabifwnpvmcjJ3sQ=
X-Received: by 2002:ac8:542:0:b0:42e:b6c4:f33a with SMTP id
 c2-20020ac80542000000b0042eb6c4f33amr12820qth.19.1709247287378; Thu, 29 Feb
 2024 14:54:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207011803.2637531-1-saravanak@google.com>
 <20240207011803.2637531-3-saravanak@google.com> <20240223171849.10f9901d@booty>
 <CAGETcx99hhfOaEn1CH1OLDGp_pnrVeJ2nWb3X5=0j8tij4NR9w@mail.gmail.com>
 <20240226125226.705efef3@booty> <CAL_JsqLMY94KmiEUcOYT4p1HdHENffOFgRJ+Tv6RDH7ewVbyig@mail.gmail.com>
 <CAGETcx_6UEpOJteQ0Gmfb=NgU+9MZumtmyLbn++C=uj7nOon=g@mail.gmail.com>
 <CAL_Jsq+edTZ3yC0Xxojo5bR3aCwAMFERjuqVFaU8sFmj=nAB8w@mail.gmail.com>
 <20240229103423.1244de38@booty> <CAL_JsqLxDozqONeN818qYg9QxQVte-9Cv_GuAz7SQ1FsscwuVw@mail.gmail.com>
In-Reply-To: <CAL_JsqLxDozqONeN818qYg9QxQVte-9Cv_GuAz7SQ1FsscwuVw@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 29 Feb 2024 14:54:09 -0800
Message-ID: <CAGETcx_Sdt7o2aOzHHfTmC5gugwXEEdgEkzUAXt1M51HgnPLZA@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v2 2/3] of: property: Improve finding the
 supplier of a remote-endpoint property
To: Rob Herring <robh+dt@kernel.org>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, Frank Rowand <frowand.list@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 2:10=E2=80=AFPM Rob Herring <robh+dt@kernel.org> wr=
ote:
>
> On Thu, Feb 29, 2024 at 3:34=E2=80=AFAM Luca Ceresoli <luca.ceresoli@boot=
lin.com> wrote:
> >
> > Hi Rob, Saravana,
> >
> > On Wed, 28 Feb 2024 18:26:36 -0600
> > Rob Herring <robh+dt@kernel.org> wrote:
> >
> > > On Wed, Feb 28, 2024 at 5:58=E2=80=AFPM Saravana Kannan <saravanak@go=
ogle.com> wrote:
> > > >
> > > > On Wed, Feb 28, 2024 at 1:56=E2=80=AFPM Rob Herring <robh+dt@kernel=
org> wrote:
> > > > >
> > > > > On Mon, Feb 26, 2024 at 5:52=E2=80=AFAM Luca Ceresoli <luca.ceres=
oli@bootlin.com> wrote:
> > > > > >
> > > > > > Hello Saravana,
> > > > > >
> > > > > > On Fri, 23 Feb 2024 17:35:24 -0800
> > > > > > Saravana Kannan <saravanak@google.com> wrote:
> > > > > >
> > > > > > > On Fri, Feb 23, 2024 at 8:18=E2=80=AFAM Luca Ceresoli <luca.c=
eresoli@bootlin.com> wrote:
> > > > > > > >
> > > > > > > > Hello Saravana,
> > > > > > > >
> > > > > > > > [+cc Herv=C3=A9 Codina]
> > > > > > > >
> > > > > > > > On Tue,  6 Feb 2024 17:18:01 -0800
> > > > > > > > Saravana Kannan <saravanak@google.com> wrote:
> > > > > > > >
> > > > > > > > > After commit 4a032827daa8 ("of: property: Simplify of_lin=
k_to_phandle()"),
> > > > > > > > > remote-endpoint properties created a fwnode link from the=
 consumer device
> > > > > > > > > to the supplier endpoint. This is a tiny bit inefficient =
(not buggy) when
> > > > > > > > > trying to create device links or detecting cycles. So, im=
prove this the
> > > > > > > > > same way we improved finding the consumer of a remote-end=
point property.
> > > > > > > > >
> > > > > > > > > Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_p=
handle()")
> > > > > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > > > >
> > > > > > > > After rebasing my own branch on v6.8-rc5 from v6.8-rc1 I st=
arted
> > > > > > > > getting unexpected warnings during device tree overlay remo=
val. After a
> > > > > > > > somewhat painful bisection I identified this patch as the o=
ne that
> > > > > > > > triggers it all.
> > > > > > >
> > > > > > > Thanks for the report.
> > > > > > >
> > > > > > > >
> > > > > > > > > ---
> > > > > > > > > --- a/drivers/of/property.c
> > > > > > > > > +++ b/drivers/of/property.c
> > > > > > > > > @@ -1232,7 +1232,6 @@ DEFINE_SIMPLE_PROP(pinctrl5, "pinct=
rl-5", NULL)
> > > > > > > > >  DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
> > > > > > > > >  DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
> > > > > > > > >  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> > > > > > > > > -DEFINE_SIMPLE_PROP(remote_endpoint, "remote-endpoint", N=
ULL)
> > > > > > > > >  DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
> > > > > > > > >  DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
> > > > > > > > >  DEFINE_SIMPLE_PROP(leds, "leds", NULL)
> > > > > > > > > @@ -1298,6 +1297,17 @@ static struct device_node *parse_i=
nterrupts(struct device_node *np,
> > > > > > > > >       return of_irq_parse_one(np, index, &sup_args) ? NUL=
L : sup_args.np;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static struct device_node *parse_remote_endpoint(struct =
device_node *np,
> > > > > > > > > +                                              const char=
 *prop_name,
> > > > > > > > > +                                              int index)
> > > > > > > > > +{
> > > > > > > > > +     /* Return NULL for index > 0 to signify end of remo=
te-endpoints. */
> > > > > > > > > +     if (!index || strcmp(prop_name, "remote-endpoint"))
> > > > > > > >
> > > > > > > > There seem to be a bug here: "!index" should be "index > 0"=
, as the
> > > > > > > > comment suggests. Otherwise NULL is always returned.
> > > > > > >
> > > > > > > Ah crap, I think you are right. It should have been "index". =
Not
> > > > > > > "!index". But I tested this! Sigh. I probably screwed up my t=
esting.
> > > > > > >
> > > > > > > Please send out a Fix for this.
> > > > > > >
> > > > > > > Geert, we got excited too soon. :(
> > > > > > >
> > > > > > > > I am going to send a quick patch for that, but haven't done=
 so yet
> > > > > > > > because it still won't solve the problem, so I wanted to op=
en the topic
> > > > > > > > here without further delay.
> > > > > > > >
> > > > > > > > Even with the 'index > 0' fix I'm still getting pretty much=
 the same:
> > > > > > >
> > > > > > > This part is confusing though. If I read your DT correctly, t=
here's a
> > > > > > > cycle between platform:panel-dsi-lvds and i2c:13-002c. And fw=
_devlink
> > > > > > > should not be enforcing any ordering between those devices ev=
er.
> > > > > > >
> > > > > > > I'm surprised that in your "working" case, fw_devlink didn't =
detect
> > > > > > > any cycle. It should have. If there's any debugging to do, th=
at's the
> > > > > > > one we need to debug.
> > > > > > >
> > > > > > > >
> > > > > > > > [   34.836781] ------------[ cut here ]------------
> > > > > > > > [   34.841401] WARNING: CPU: 2 PID: 204 at drivers/base/dev=
res.c:1064 devm_kfree+0x8c/0xfc
> > > > > > > > ...
> > > > > > > > [   35.024751] Call trace:
> > > > > > > > [   35.027199]  devm_kfree+0x8c/0xfc
> > > > > > > > [   35.030520]  devm_drm_panel_bridge_release+0x54/0x64 [dr=
m_kms_helper]
> > > > > > > > [   35.036990]  devres_release_group+0xe0/0x164
> > > > > > > > [   35.041264]  i2c_device_remove+0x38/0x9c
> > > > > > > > [   35.045196]  device_remove+0x4c/0x80
> > > > > > > > [   35.048774]  device_release_driver_internal+0x1d4/0x230
> > > > > > > > [   35.054003]  device_release_driver+0x18/0x24
> > > > > > > > [   35.058279]  bus_remove_device+0xcc/0x10c
> > > > > > > > [   35.062292]  device_del+0x15c/0x41c
> > > > > > > > [   35.065786]  device_unregister+0x18/0x34
> > > > > > > > [   35.069714]  i2c_unregister_device+0x54/0x88
> > > > > > > > [   35.073988]  of_i2c_notify+0x98/0x224
> > > > > > > > [   35.077656]  blocking_notifier_call_chain+0x6c/0xa0
> > > > > > > > [   35.082543]  __of_changeset_entry_notify+0x100/0x16c
> > > > > > > > [   35.087515]  __of_changeset_revert_notify+0x44/0x78
> > > > > > > > [   35.092398]  of_overlay_remove+0x114/0x1c4
> > > > > > > > ...
> > > > > > > >
> > > > > > > > By comparing the two versions I found that before removing =
the overlay:
> > > > > > > >
> > > > > > > >  * in the "working" case (with this patch reverted) I have:
> > > > > > > >
> > > > > > > >    # ls /sys/class/devlink/ | grep 002c
> > > > > > > >    platform:hpbr--i2c:13-002c
> > > > > > > >    platform:panel-dsi-lvds--i2c:13-002c
> > > > > > >
> > > > > > > Can you check the "status" and "sync_state_only" file in this=
 folder
> > > > > > > and tell me what it says?
> > > > > > >
> > > > > > > Since these devices have a cyclic dependency between them, it=
 should
> > > > > > > have been something other than "not tracked" and "sync_state_=
only"
> > > > > > > should be "1". But my guess is you'll see "active" and "0".
> > > > > > >
> > > > > > > >    platform:regulator-sys-1v8--i2c:13-002c
> > > > > > > >    regulator:regulator.31--i2c:13-002c
> > > > > > > >    #
> > > > > > > >
> > > > > > > >  * in the "broken" case (v6.8-rc5 + s/!index/index > 0/ as =
mentioned):
> > > > > > > >
> > > > > > > >    # ls /sys/class/devlink/ | grep 002c
> > > > > > > >    platform:hpbr--i2c:13-002c
> > > > > > > >    platform:regulator-sys-1v8--i2c:13-002c
> > > > > > > >    regulator:regulator.30--i2c:13-002c
> > > > > > > >    #
> > > > > > > >
> > > > > > > > So in the latter case the panel-dsi-lvds--i2c:13-002c link =
is missing.
> > > > > > > > I think it gets created but later on removed. Here's a snip=
pet of the
> > > > > > > > kernel log when that happens:
> > > > > > > >
> > > > > > > > [    9.578279] ----- cycle: start -----
> > > > > > > > [    9.578283] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i=
2c@3/dsi-lvds-bridge@2c: cycle: depends on /panel-dsi-lvds
> > > > > > > > [    9.578308] /panel-dsi-lvds: cycle: depends on /soc@0/bu=
s@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > > > > > [    9.578329] ----- cycle: end -----
> > > > > > > > [    9.578334] platform panel-dsi-lvds: Fixed dependency cy=
cle(s) with /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridg=
e@2c
> > > > > > > > ...
> > > > > > >
> > > > > > > Somewhere in this area, I'm thinking you'll also see "device:
> > > > > > > 'i2c:13-002c--platform:panel-dsi-lvds': device_add" do you no=
t? And if
> > > > > > > you enabled device link logs, you'll see that it was "sync st=
ate only"
> > > > > > > link.
> > > > > > >
> > > > > > > > [    9.590620] /panel-dsi-lvds Dropping the fwnode link to =
/soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > > > > > ...
> > > > > > > > [    9.597280] ----- cycle: start -----
> > > > > > > > [    9.597283] /panel-dsi-lvds: cycle: depends on /soc@0/bu=
s@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > > > > > [    9.602781] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i=
2c@3/dsi-lvds-bridge@2c: cycle: depends on /panel-dsi-lvds
> > > > > > > > [    9.607581] ----- cycle: end -----
> > > > > > > > [    9.607585] i2c 13-002c: Fixed dependency cycle(s) with =
/panel-dsi-lvds
> > > > > > > > [    9.614217] device: 'platform:panel-dsi-lvds--i2c:13-002=
c': device_add
> > > > > > > > ...
> > > > > > > > [    9.614277] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i=
2c@3/dsi-lvds-bridge@2c Dropping the fwnode link to /panel-dsi-lvds
> > > > > > > > [    9.614369] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i=
2c@3/dsi-lvds-bridge@2c Dropping the fwnode link to /regulator-dock-sys-1v8
> > > > > > > > ...
> > > > > > > > [    9.739840] panel-simple panel-dsi-lvds: Dropping the li=
nk to 13-002c
> > > > > > > > [    9.739846] device: 'i2c:13-002c--platform:panel-dsi-lvd=
s': device_unregister
> > > > > > >
> > > > > > > Oh yeah, see. The "device_add" I expected earlier is getting =
removed here.
> > > > > > >
> > > > > > > > [   10.247037] sn65dsi83 13-002c: Dropping the link to pane=
l-dsi-lvds
> > > > > > > > [   10.247049] device: 'platform:panel-dsi-lvds--i2c:13-002=
c': device_unregister
> > > > > > > >
> > > > > > > > And here's the relevant portion of my device tree overlay:
> > > > > > > >
> > > > > > > > --------------------8<--------------------
> > > > > > > >
> > > > > > >
> > > > > > > I think the eventual fix would be this series + adding a
> > > > > > > "post-init-providers" property to the device that's supposed =
to probe
> > > > > > > first and point it to the device that's supposed to probe nex=
t. Do
> > > > > > > this at the device node level, not the endpoint level.
> > > > > > > https://lore.kernel.org/lkml/20240221233026.2915061-1-saravan=
ak@google.com/
> > > > > >
> > > > > > I'm certainly going to look at this series in more detail and a=
t the
> > > > > > debugging you asked for, however I'm afraid I won't have access=
 to the
> > > > > > hardware this week and it's not going to be a quick task anyway=
.
> > > > > >
> > > > > > So in this moment I think it's quite clear that this specific p=
atch
> > > > > > creates a regression and there is no clear fix that is reasonab=
ly
> > > > > > likely to get merged before 6.8.
> > > > > >
> > > > > > I propose reverting this patch immediately, unless you have a b=
etter
> > > > > > short-term solution.
> > > > >
> > > > > It's just this one of the 3 patches that needs reverting?
> >
> > Just this patch. I reverted only this and the issue disappeared.
> >
> > > > I sent a fix. With the fix, it's just exposing a bug elsewhere.
> >
> > Exactly, this patch has two issues and only the easy one has a fix [0]
> > currently as far as I know.
> >
> > > You say apply the fix. Luca says revert. I say I wish I made this 6.9
> > > material. Which is it?
> > >
> > > If the overlay applying depends on out of tree code (likely as there
> > > are limited ways to apply an overlay in mainline), then I don't reall=
y
> > > care if there is still a regression.
> >
> > Obviously, to load and unload the overlays I'm using code not yet
> > in mainline. It is using of_overlay_fdt_apply() and of_overlay_remove()
> > via a driver underdevelopment that is similar to the one Herv=C3=A9 and
> > Lizhi Hou are working on [1][2].
> >
> > I see the point that "we are not breaking existing use cases as no code
> > is (un)loading overlays except unittest", sure.
> >
> > As I see it, we have a feature in the kernel that is not used, but it
> > will be, eventually: there are use cases, development is progressing an=
d
> > patches are being sent actively. My opinion is that we should not
> > put additional known obstacles that will make it even harder than it
> > already is.
>
> Well, I don't care to do extra work of applying things and then have
> to turn right around fix or revert them. It happens enough as-is with
> just mainline. And no one wants to step up and fix the problems with
> overlays, but are fine just carrying their out of tree patches. What's
> one more. This is the 2nd case of overlay problems with out of tree
> users *today*! Some days I'm tempted to just remove overlay support
> altogether given the only way to apply them is unittest.

Rob,

Sorry I couldn't reply yesterday. And sorry for getting this into 6.8
and causing headaches for you.

With [1], there are no more bugs to fix in fw_devlink wrt
remote-endpoints for sure.
[1] - https://lore.kernel.org/lkml/20240224052436.3552333-1-saravanak@googl=
e.com/

It's solely exposing a bug in another driver. If this was upstream
code, I might have been okay with reverting things just to make their
bug for now. I didn't realize this was downstream stuff until you
asked/Luca confirmed. We definitely shouldn't revert anything. Luca
can take my pointers and debug their driver and I'm happy to help
debug this further.

Also, post-init-providers should definitely help in this case. So,
Luca can use that once we land it.

> Given Geert is having issues too, I guess I'm going to revert.

It's just extra/explicit logging because as the original series was
meant to do, it improves remote-enpoint parsing.

-Saravana

