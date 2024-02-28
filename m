Return-Path: <linux-kernel+bounces-85860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8814186BC66
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D2FB242FB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E070874432;
	Wed, 28 Feb 2024 23:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTeSkY5k"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E2413D306
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164730; cv=none; b=c64GHb+4dYa1EFkBttEHGx51FvZp2WaXXI8Ysgisl6tEhfsniSzcxg95BcbjFv6bMAbTy/jIhdtlHKpRA3ovZTJQIe5vidTRQ7QmubUxIQsdpnKY8TVTAZPPxCmCqTMvh1TxOwlXGmLCDEGp9SOm1VKkkShp2PxJaM/QnkYQcXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164730; c=relaxed/simple;
	bh=H5wvBKz9h0kysWWktvs2v+6AaelShiBroaLPvuO0NBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOAWYSxle2PfOfnZA/lOyF7vKDyVI3KnBYHw2ZAhn4mfdxQY3XmXfa6qb287td3SrPQuGZIf0CptljwQcBpJGHe1JPdxASrBDICmRbRPHeVjJ0jUYeQvbFqqfoCzBZEb5hpWgQaYWU/0PqNsvEqKiUtkHoiTbu9k6io/YfRmHUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTeSkY5k; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42e6939d34fso145201cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709164728; x=1709769528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9GL3KVcxZMDzTLhBowP7aS3uOumXN5zp/D5c/hG52k=;
        b=YTeSkY5kXeYlzKMQKRA7KANCERfM/sK+1turRXpWGTEmUDkFaq5yHSPvtB3cGC7+I6
         h7ls6IepWJ/t8K08CocJN7x/CMkPCyjfVz/Y9iN9YN1qVC/0q0CqKl74EJKgBpnWgdNI
         Mdmsbco5iUIK3x1rcvTTNxRKtsINZojaj5LbWjcwQdHOaeomsJus+DHkWSrKKX4kbK66
         EiDyBV1XAFckrbTSkAXPMXzswbDXTKMG4LUZbZFRiayWXhJgx3K0+Xx3gIA5YbDWisVJ
         pOXLJF3fLnUCfqGA/UFCW4EmYJ2PXRaeSsZX0nTOcuWLc8qXaKZ9x2u0f34A3IPHekWH
         cddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709164728; x=1709769528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9GL3KVcxZMDzTLhBowP7aS3uOumXN5zp/D5c/hG52k=;
        b=ES0/bkzYCzDUNHuGpXys7BmiJJp8IjSK+8J7m2R2ZXNeHqLCpSVuE9pT4bV8d0kWgR
         S2wKermj36Y4Gxj9Nro02yBS0FqGJHcBbGIlXyZK+AdDHQF9fNVytIJJei1RH91gzcW1
         yqBRYhWx/ajfQZvRAWSf7n6kJEZMt/GpuXRQIijnnchjgS/NUe31r7l/lBTFN07+Zt9P
         138RewmCHzR0ap5/yqWN+74zm+JN4ndZ86J3vpw5atcIgEKv4vW1begG+RxnW1u+w1a6
         JkUbLzvZ4tQBUWyHCQnDDk96vEre3xtMQPE0RigWBGnGpY5KXsibhg7OfEXMEVjaju8o
         q1eg==
X-Forwarded-Encrypted: i=1; AJvYcCU3wGWCTfW3FUwOSTBG46+ogKWv80uHss+MGAuJxT8PjnKlITMElGwHZTpzWulB0sbacNByQI2zyoUF6SzHiZBBubJQ27kiTPPR9FTU
X-Gm-Message-State: AOJu0YzIQHaF44Pz2//NXn6S03vZXnLov/4Ixa8Bp0m+D9xFWbhNvzsQ
	WwlAfD4k9R6/eCImhT4vCN7d18StddpSMn2zx12tEgHqsRp7+Qj6cb4lHtzqfT479la934I2jp9
	idj/6CTnNNlC9F8hzQzVbhF9aF4E4aBqrtdWi
X-Google-Smtp-Source: AGHT+IGaII6zh6CCElAERfFr8yWsitDYYJBNS4UIWcMhZi4QjBibAu6QsBu6qW4/xaMNDwZePg8zxsm1N0owgocDCbY=
X-Received: by 2002:a05:622a:2681:b0:42e:824f:6d44 with SMTP id
 kd1-20020a05622a268100b0042e824f6d44mr33556qtb.23.1709164727788; Wed, 28 Feb
 2024 15:58:47 -0800 (PST)
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
In-Reply-To: <CAL_JsqLMY94KmiEUcOYT4p1HdHENffOFgRJ+Tv6RDH7ewVbyig@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 28 Feb 2024 15:58:08 -0800
Message-ID: <CAGETcx_6UEpOJteQ0Gmfb=NgU+9MZumtmyLbn++C=uj7nOon=g@mail.gmail.com>
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

On Wed, Feb 28, 2024 at 1:56=E2=80=AFPM Rob Herring <robh+dt@kernel.org> wr=
ote:
>
> On Mon, Feb 26, 2024 at 5:52=E2=80=AFAM Luca Ceresoli <luca.ceresoli@boot=
lin.com> wrote:
> >
> > Hello Saravana,
> >
> > On Fri, 23 Feb 2024 17:35:24 -0800
> > Saravana Kannan <saravanak@google.com> wrote:
> >
> > > On Fri, Feb 23, 2024 at 8:18=E2=80=AFAM Luca Ceresoli <luca.ceresoli@=
bootlin.com> wrote:
> > > >
> > > > Hello Saravana,
> > > >
> > > > [+cc Herv=C3=A9 Codina]
> > > >
> > > > On Tue,  6 Feb 2024 17:18:01 -0800
> > > > Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > > After commit 4a032827daa8 ("of: property: Simplify of_link_to_pha=
ndle()"),
> > > > > remote-endpoint properties created a fwnode link from the consume=
r device
> > > > > to the supplier endpoint. This is a tiny bit inefficient (not bug=
gy) when
> > > > > trying to create device links or detecting cycles. So, improve th=
is the
> > > > > same way we improved finding the consumer of a remote-endpoint pr=
operty.
> > > > >
> > > > > Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_phandle()=
")
> > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > >
> > > > After rebasing my own branch on v6.8-rc5 from v6.8-rc1 I started
> > > > getting unexpected warnings during device tree overlay removal. Aft=
er a
> > > > somewhat painful bisection I identified this patch as the one that
> > > > triggers it all.
> > >
> > > Thanks for the report.
> > >
> > > >
> > > > > ---
> > > > > --- a/drivers/of/property.c
> > > > > +++ b/drivers/of/property.c
> > > > > @@ -1232,7 +1232,6 @@ DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5", N=
ULL)
> > > > >  DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
> > > > >  DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
> > > > >  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> > > > > -DEFINE_SIMPLE_PROP(remote_endpoint, "remote-endpoint", NULL)
> > > > >  DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
> > > > >  DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
> > > > >  DEFINE_SIMPLE_PROP(leds, "leds", NULL)
> > > > > @@ -1298,6 +1297,17 @@ static struct device_node *parse_interrupt=
s(struct device_node *np,
> > > > >       return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_=
args.np;
> > > > >  }
> > > > >
> > > > > +static struct device_node *parse_remote_endpoint(struct device_n=
ode *np,
> > > > > +                                              const char *prop_n=
ame,
> > > > > +                                              int index)
> > > > > +{
> > > > > +     /* Return NULL for index > 0 to signify end of remote-endpo=
ints. */
> > > > > +     if (!index || strcmp(prop_name, "remote-endpoint"))
> > > >
> > > > There seem to be a bug here: "!index" should be "index > 0", as the
> > > > comment suggests. Otherwise NULL is always returned.
> > >
> > > Ah crap, I think you are right. It should have been "index". Not
> > > "!index". But I tested this! Sigh. I probably screwed up my testing.
> > >
> > > Please send out a Fix for this.
> > >
> > > Geert, we got excited too soon. :(
> > >
> > > > I am going to send a quick patch for that, but haven't done so yet
> > > > because it still won't solve the problem, so I wanted to open the t=
opic
> > > > here without further delay.
> > > >
> > > > Even with the 'index > 0' fix I'm still getting pretty much the sam=
e:
> > >
> > > This part is confusing though. If I read your DT correctly, there's a
> > > cycle between platform:panel-dsi-lvds and i2c:13-002c. And fw_devlink
> > > should not be enforcing any ordering between those devices ever.
> > >
> > > I'm surprised that in your "working" case, fw_devlink didn't detect
> > > any cycle. It should have. If there's any debugging to do, that's the
> > > one we need to debug.
> > >
> > > >
> > > > [   34.836781] ------------[ cut here ]------------
> > > > [   34.841401] WARNING: CPU: 2 PID: 204 at drivers/base/devres.c:10=
64 devm_kfree+0x8c/0xfc
> > > > ...
> > > > [   35.024751] Call trace:
> > > > [   35.027199]  devm_kfree+0x8c/0xfc
> > > > [   35.030520]  devm_drm_panel_bridge_release+0x54/0x64 [drm_kms_he=
lper]
> > > > [   35.036990]  devres_release_group+0xe0/0x164
> > > > [   35.041264]  i2c_device_remove+0x38/0x9c
> > > > [   35.045196]  device_remove+0x4c/0x80
> > > > [   35.048774]  device_release_driver_internal+0x1d4/0x230
> > > > [   35.054003]  device_release_driver+0x18/0x24
> > > > [   35.058279]  bus_remove_device+0xcc/0x10c
> > > > [   35.062292]  device_del+0x15c/0x41c
> > > > [   35.065786]  device_unregister+0x18/0x34
> > > > [   35.069714]  i2c_unregister_device+0x54/0x88
> > > > [   35.073988]  of_i2c_notify+0x98/0x224
> > > > [   35.077656]  blocking_notifier_call_chain+0x6c/0xa0
> > > > [   35.082543]  __of_changeset_entry_notify+0x100/0x16c
> > > > [   35.087515]  __of_changeset_revert_notify+0x44/0x78
> > > > [   35.092398]  of_overlay_remove+0x114/0x1c4
> > > > ...
> > > >
> > > > By comparing the two versions I found that before removing the over=
lay:
> > > >
> > > >  * in the "working" case (with this patch reverted) I have:
> > > >
> > > >    # ls /sys/class/devlink/ | grep 002c
> > > >    platform:hpbr--i2c:13-002c
> > > >    platform:panel-dsi-lvds--i2c:13-002c
> > >
> > > Can you check the "status" and "sync_state_only" file in this folder
> > > and tell me what it says?
> > >
> > > Since these devices have a cyclic dependency between them, it should
> > > have been something other than "not tracked" and "sync_state_only"
> > > should be "1". But my guess is you'll see "active" and "0".
> > >
> > > >    platform:regulator-sys-1v8--i2c:13-002c
> > > >    regulator:regulator.31--i2c:13-002c
> > > >    #
> > > >
> > > >  * in the "broken" case (v6.8-rc5 + s/!index/index > 0/ as mentione=
d):
> > > >
> > > >    # ls /sys/class/devlink/ | grep 002c
> > > >    platform:hpbr--i2c:13-002c
> > > >    platform:regulator-sys-1v8--i2c:13-002c
> > > >    regulator:regulator.30--i2c:13-002c
> > > >    #
> > > >
> > > > So in the latter case the panel-dsi-lvds--i2c:13-002c link is missi=
ng.
> > > > I think it gets created but later on removed. Here's a snippet of t=
he
> > > > kernel log when that happens:
> > > >
> > > > [    9.578279] ----- cycle: start -----
> > > > [    9.578283] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi=
-lvds-bridge@2c: cycle: depends on /panel-dsi-lvds
> > > > [    9.578308] /panel-dsi-lvds: cycle: depends on /soc@0/bus@308000=
00/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > [    9.578329] ----- cycle: end -----
> > > > [    9.578334] platform panel-dsi-lvds: Fixed dependency cycle(s) w=
ith /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > ...
> > >
> > > Somewhere in this area, I'm thinking you'll also see "device:
> > > 'i2c:13-002c--platform:panel-dsi-lvds': device_add" do you not? And i=
f
> > > you enabled device link logs, you'll see that it was "sync state only=
"
> > > link.
> > >
> > > > [    9.590620] /panel-dsi-lvds Dropping the fwnode link to /soc@0/b=
us@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > ...
> > > > [    9.597280] ----- cycle: start -----
> > > > [    9.597283] /panel-dsi-lvds: cycle: depends on /soc@0/bus@308000=
00/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > [    9.602781] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi=
-lvds-bridge@2c: cycle: depends on /panel-dsi-lvds
> > > > [    9.607581] ----- cycle: end -----
> > > > [    9.607585] i2c 13-002c: Fixed dependency cycle(s) with /panel-d=
si-lvds
> > > > [    9.614217] device: 'platform:panel-dsi-lvds--i2c:13-002c': devi=
ce_add
> > > > ...
> > > > [    9.614277] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi=
-lvds-bridge@2c Dropping the fwnode link to /panel-dsi-lvds
> > > > [    9.614369] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi=
-lvds-bridge@2c Dropping the fwnode link to /regulator-dock-sys-1v8
> > > > ...
> > > > [    9.739840] panel-simple panel-dsi-lvds: Dropping the link to 13=
-002c
> > > > [    9.739846] device: 'i2c:13-002c--platform:panel-dsi-lvds': devi=
ce_unregister
> > >
> > > Oh yeah, see. The "device_add" I expected earlier is getting removed =
here.
> > >
> > > > [   10.247037] sn65dsi83 13-002c: Dropping the link to panel-dsi-lv=
ds
> > > > [   10.247049] device: 'platform:panel-dsi-lvds--i2c:13-002c': devi=
ce_unregister
> > > >
> > > > And here's the relevant portion of my device tree overlay:
> > > >
> > > > --------------------8<--------------------
> > > >
> > >
> > > I think the eventual fix would be this series + adding a
> > > "post-init-providers" property to the device that's supposed to probe
> > > first and point it to the device that's supposed to probe next. Do
> > > this at the device node level, not the endpoint level.
> > > https://lore.kernel.org/lkml/20240221233026.2915061-1-saravanak@googl=
e.com/
> >
> > I'm certainly going to look at this series in more detail and at the
> > debugging you asked for, however I'm afraid I won't have access to the
> > hardware this week and it's not going to be a quick task anyway.
> >
> > So in this moment I think it's quite clear that this specific patch
> > creates a regression and there is no clear fix that is reasonably
> > likely to get merged before 6.8.
> >
> > I propose reverting this patch immediately, unless you have a better
> > short-term solution.
>
> It's just this one of the 3 patches that needs reverting?

I sent a fix. With the fix, it's just exposing a bug elsewhere.

-Saravana

