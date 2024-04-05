Return-Path: <linux-kernel+bounces-132461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C9F89951B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C1D1C20FCA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701042C1BA;
	Fri,  5 Apr 2024 06:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb8XDxKR"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C80B22EE0;
	Fri,  5 Apr 2024 06:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297444; cv=none; b=iipGTR72dOITxDAr7HWsWDDDF4tB7qq0bpT89f0WciKPOgad8LSnlF0XQsRanLCVdVmd+F7mQ3DxorGHG0G66aCoNVfMRXh3MQMEYFpQuJOhTGowhCh7UJLfKgUajIBh4BtU/nG0Kx/bKGb1zWd74w3ZT1I//EvhIQTenZ/Vej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297444; c=relaxed/simple;
	bh=3tB2g5iMmewRkm6z0W92HXk/VHQFgGDTBWD0WulWP10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrgNi1obYddZqiUj29lThjb58HhzsFjYidEtCIEsGfZEgm++cG2+4LdqNhbAzJWhh8G+rTQJHYsMrPHXTu1DsADnWEZdTRpvrdLTZYtN/Gnr3SrjkZ0hoHICyDBmkUprG2S6qU6V8mQGTFS8cUye1MByjPNmLw3iASvZ33nvQ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb8XDxKR; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516d0161e13so1535152e87.3;
        Thu, 04 Apr 2024 23:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712297440; x=1712902240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bURAN+SNkUnF0guTkLMOb2v1X6SDPYFLJ7IBd70PeE=;
        b=Kb8XDxKR6H9Sb14QjlyE0JrOGQyS4Vp7rhgLbqq86380xD5tRPQN0O2lwHwikReAUU
         3HAlTJZi7X5eWlQQc8TGCTaC7qPA+oupEf5VJdkG3PzaNl4QHaeOYSh+IUr6w6vusd84
         jLTck9hyZvZkRJ3xF2F7f3eMeAo8DhEx5F9kMXIQnq/8OkO0YWgLqpRiaAhc64jvd6Ei
         sm5FScRpk29apAwkSv238D9qBwIbW4rHA+DmJyGL5qK8e5Z/orVPn4SWhEV27zDVtg0+
         txbxa10gut1bPio3UYDNubVicKe0YHE5hH5CwDMhxuhT4+AFVEbLMXRmvdAxd174YYG/
         cejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712297440; x=1712902240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bURAN+SNkUnF0guTkLMOb2v1X6SDPYFLJ7IBd70PeE=;
        b=GpjjBgdHy56F6EihEKdM1CjTluw3GqO3OnU7DUTs7KR33vtj4rb83EdPuRYWJyZ3ad
         /ZrqHwVJHwXXTo90AbFIrMp0eMA+osQ0jrTPdwe6nPD635NecOE7ekjs3uG/rx5AoSbh
         FjwIyQTMD/tjHB9Vi5YMULLCy1S1FeOSk4XLkfjxOBNdwYRXB2CkoumrBSaL0rl8aNTz
         yMF+skENTlSfiLuzkQAg6DJadqO+1RW46VOxiQC5Mk9Ihf3iA2JxeV+F2sKPGvfpvKxz
         zz8xn6jmQTWreQd3MTeJxfJsXRldn7goXX8UybHUTcUIL4S1dx40qPeBtsaaPGQCaTgv
         95LA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ/KlrewVFmTVwLcDNwkHIyGr55kQdxCxP+3NUT+v3J7v1ILRQ62jbpiiAQQC6OnwLuuk6LwTahabnloG/HyuiUbWmqB0lflePl8UrJrzqTq6HXugRxm03oHXY+LTm0Hf1T5HoHgIwpzizAd8Sh6d3Zdk+u36mQeN5xIJNyCBR2K00YtrgO7WIkQI=
X-Gm-Message-State: AOJu0YyXs5nqgzeRbBPOdpKTnZzELV/DnlxF80q5e0UcMcjG3ZLJa2N2
	aCfGGvqWFO+85dNCYFmRZEVjd/bso8yuP3XWL0MdYKlW4QtSiZMZT0bi1Covk/ziqUkH6DkANQ+
	nMQY2PykZBzoOuvGBkNjuIkw8ceg=
X-Google-Smtp-Source: AGHT+IEoDfH1OzGI9nAQfKxv27s0mLaOKlb8IYQonarRn14h9ogjVkS49No290AIbaHezxkOhen8+L2rgsslSl3gpcY=
X-Received: by 2002:a19:9155:0:b0:513:ba98:36a with SMTP id
 y21-20020a199155000000b00513ba98036amr357217lfj.10.1712297439801; Thu, 04 Apr
 2024 23:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301193831.3346-1-linux.amoon@gmail.com> <20240301193831.3346-4-linux.amoon@gmail.com>
 <52158bf6-16fe-4ce2-b9b6-bbc6550a6e14@wanadoo.fr> <CANAwSgTCaSSMN2QCw5fr=RBp0WwWaLuebzQDO=scnABNFNctJQ@mail.gmail.com>
 <e85ad80f-af7d-4eaf-9d14-dff13451f7e5@wanadoo.fr> <CANAwSgRrOw+6MHLPDP8RwLwzwB1EVGBTovtR2ChhqR3b5uWowA@mail.gmail.com>
In-Reply-To: <CANAwSgRrOw+6MHLPDP8RwLwzwB1EVGBTovtR2ChhqR3b5uWowA@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 5 Apr 2024 11:40:18 +0530
Message-ID: <CANAwSgQk10=K6Z5OzvT3OUncfr6BWyx7oH2JKN5CJAnS+uO7QQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] usb: dwc3: exynos: Use devm_regulator_bulk_get_enable()
 helper function
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Hi Christophe, Krzysztof,

On Mon, 4 Mar 2024 at 17:16, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Christophe,
>
> On Sun, 3 Mar 2024 at 00:07, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> >
> > Le 02/03/2024 =C3=A0 17:48, Anand Moon a =C3=A9crit :
> > > Hi Christophe,
> > >
> > > On Sat, 2 Mar 2024 at 21:20, Christophe JAILLET
> > > <christophe.jaillet@wanadoo.fr> wrote:
> > >>
> > >> Le 01/03/2024 =C3=A0 20:38, Anand Moon a =C3=A9crit :
> > >>> Use devm_regulator_bulk_get_enable() instead of open coded
> > >>> 'devm_regulator_get(), regulator_enable(), regulator_disable().
> > >>>
> > >>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > >>> ---
> > >>>    drivers/usb/dwc3/dwc3-exynos.c | 49 +++-------------------------=
------
> > >>>    1 file changed, 4 insertions(+), 45 deletions(-)
> > >>>
> > >>> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3=
-exynos.c
> > >>> index 5d365ca51771..7c77f3c69825 100644
> > >>> --- a/drivers/usb/dwc3/dwc3-exynos.c
> > >>> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> > >>> @@ -32,9 +32,6 @@ struct dwc3_exynos {
> > >>>        struct clk              *clks[DWC3_EXYNOS_MAX_CLOCKS];
> > >>>        int                     num_clks;
> > >>>        int                     suspend_clk_idx;
> > >>> -
> > >>> -     struct regulator        *vdd33;
> > >>> -     struct regulator        *vdd10;
> > >>>    };
> > >>>
> > >>>    static int dwc3_exynos_probe(struct platform_device *pdev)
> > >>> @@ -44,6 +41,7 @@ static int dwc3_exynos_probe(struct platform_devi=
ce *pdev)
> > >>>        struct device_node      *node =3D dev->of_node;
> > >>>        const struct dwc3_exynos_driverdata *driver_data;
> > >>>        int                     i, ret;
> > >>> +     static const char * const regulators[] =3D { "vdd33", "vdd10"=
 };
> > >>>
> > >>>        exynos =3D devm_kzalloc(dev, sizeof(*exynos), GFP_KERNEL);
> > >>>        if (!exynos)
> > >>> @@ -78,27 +76,9 @@ static int dwc3_exynos_probe(struct platform_dev=
ice *pdev)
> > >>>        if (exynos->suspend_clk_idx >=3D 0)
> > >>>                clk_prepare_enable(exynos->clks[exynos->suspend_clk_=
idx]);
> > >>>
> > >>> -     exynos->vdd33 =3D devm_regulator_get(dev, "vdd33");
> > >>> -     if (IS_ERR(exynos->vdd33)) {
> > >>> -             ret =3D PTR_ERR(exynos->vdd33);
> > >>> -             goto vdd33_err;
> > >>> -     }
> > >>> -     ret =3D regulator_enable(exynos->vdd33);
> > >>> -     if (ret) {
> > >>> -             dev_err(dev, "Failed to enable VDD33 supply\n");
> > >>> -             goto vdd33_err;
> > >>> -     }
> > >>> -
> > >>> -     exynos->vdd10 =3D devm_regulator_get(dev, "vdd10");
> > >>> -     if (IS_ERR(exynos->vdd10)) {
> > >>> -             ret =3D PTR_ERR(exynos->vdd10);
> > >>> -             goto vdd10_err;
> > >>> -     }
> > >>> -     ret =3D regulator_enable(exynos->vdd10);
> > >>> -     if (ret) {
> > >>> -             dev_err(dev, "Failed to enable VDD10 supply\n");
> > >>> -             goto vdd10_err;
> > >>> -     }
> > >>> +     ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regula=
tors), regulators);
> > >>> +     if (ret)
> > >>> +             return dev_err_probe(dev, ret, "Failed to enable regu=
lators\n");
> > >>>
> > >>>        if (node) {
> > >>>                ret =3D of_platform_populate(node, NULL, NULL, dev);
> > >>> @@ -115,10 +95,6 @@ static int dwc3_exynos_probe(struct platform_de=
vice *pdev)
> > >>>        return 0;
> > >>>
> > >>>    populate_err:
> > >>> -     regulator_disable(exynos->vdd10);
> > >>> -vdd10_err:
> > >>> -     regulator_disable(exynos->vdd33);
> > >>> -vdd33_err:
> > >>>        for (i =3D exynos->num_clks - 1; i >=3D 0; i--)
> > >>>                clk_disable_unprepare(exynos->clks[i]);
> > >>>
> > >>> @@ -140,9 +116,6 @@ static void dwc3_exynos_remove(struct platform_=
device *pdev)
> > >>>
> > >>>        if (exynos->suspend_clk_idx >=3D 0)
> > >>>                clk_disable_unprepare(exynos->clks[exynos->suspend_c=
lk_idx]);
> > >>> -
> > >>> -     regulator_disable(exynos->vdd33);
> > >>> -     regulator_disable(exynos->vdd10);
> > >>>    }
> > >>>
> > >>>    static const struct dwc3_exynos_driverdata exynos5250_drvdata =
=3D {
> > >>> @@ -196,9 +169,6 @@ static int dwc3_exynos_suspend(struct device *d=
ev)
> > >>>        for (i =3D exynos->num_clks - 1; i >=3D 0; i--)
> > >>>                clk_disable_unprepare(exynos->clks[i]);
> > >>>
> > >>> -     regulator_disable(exynos->vdd33);
> > >>> -     regulator_disable(exynos->vdd10);
> > >>
> > >> Hi,
> > >>
> > >> Same here, I don't think that removing regulator_[en|dis]able from t=
he
> > >> suspend and resume function is correct.
> > >>
> > >> The goal is to stop some hardware when the system is suspended, in o=
rder
> > >> to save some power.
> > > Ok,
> > >>
> > >> Why did you removed it?
> > >
> > > As per the description of the function  devm_regulator_bulk_get_enabl=
e
> > >
> > > * This helper function allows drivers to get several regulator
> > >   * consumers in one operation with management, the regulators will
> > >   * automatically be freed when the device is unbound.  If any of the
> > >   * regulators cannot be acquired then any regulators that were
> > >   * allocated will be freed before returning to the caller.
> >
> > The code in suspend/resume is not about freeing some resources. It is
> > about enabling/disabling some hardware to save some power.
> >
> > Think to the probe/remove functions as the software in the kernel that
> > knows how to handle some hardawre, and the suspend/resume as the on/off
> > button to power-on and off the electrical chips.
> >
> > When the system is suspended, the software is still around. But some
> > hardware can be set in a low consumption mode to save some power.
> >
> > IMHO, part of the code you removed changed this behaviour and increase
> > the power consumption when the system is suspended.
> >
>
> You are correct, I have changed the regulator API from
> devm_regulator_get_enable to devm_regulator_bulk_get_enable
> which changes this behavior.
> I will fix it in the next version.
>
> > CJ

I could not find any example in the kernel to support
devm_regulator_bulk_disable
but here is my modified file.

If you have any suggestions for this plz let me know.
-----8<----------8<----------
diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.=
c
index 6d07592ad022..2f808cb9a006 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -34,6 +34,8 @@ struct dwc3_exynos {
        int                     suspend_clk_idx;
 };

+static const char * const regulators[] =3D { "vdd33", "vdd10" };
+
 static int dwc3_exynos_probe(struct platform_device *pdev)
 {
        struct dwc3_exynos      *exynos;
@@ -41,7 +43,6 @@ static int dwc3_exynos_probe(struct platform_device *pdev=
)
        struct device_node      *node =3D dev->of_node;
        const struct dwc3_exynos_driverdata *driver_data;
        int                     i, ret;
-       static const char * const regulators[] =3D { "vdd33", "vdd10" };

        exynos =3D devm_kzalloc(dev, sizeof(*exynos), GFP_KERNEL);
        if (!exynos)
@@ -166,6 +167,8 @@ static int __maybe_unused
dwc3_exynos_suspend(struct device *dev)
        struct dwc3_exynos *exynos =3D dev_get_drvdata(dev);
        int i;

+       devm_regulator_bulk_disable(dev);
+
        for (i =3D exynos->num_clks - 1; i >=3D 0; i--)
                clk_disable_unprepare(exynos->clks[i]);

@@ -177,6 +180,11 @@ static int __maybe_unused
dwc3_exynos_resume(struct device *dev)
        struct dwc3_exynos *exynos =3D dev_get_drvdata(dev);
        int i, ret;

+       ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
+                                               regulators);
+       if (ret)
+               dev_err(dev, "Failed to enable regulators\n");
+
        for (i =3D 0; i < exynos->num_clks; i++) {
                ret =3D clk_prepare_enable(exynos->clks[i]);
                if (ret) {

To support these changes we need to export the
devm_regulator_bulk_disable function.
-----8<----------8<----------
diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 90bb0d178885..97eed739f929 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -318,7 +318,7 @@ void devm_regulator_bulk_put(struct
regulator_bulk_data *consumers)
 }
 EXPORT_SYMBOL_GPL(devm_regulator_bulk_put);

-static void devm_regulator_bulk_disable(void *res)
+void devm_regulator_bulk_disable(void *res)
 {
        struct regulator_bulk_devres *devres =3D res;
        int i;
@@ -326,6 +326,7 @@ static void devm_regulator_bulk_disable(void *res)
        for (i =3D 0; i < devres->num_consumers; i++)
                regulator_disable(devres->consumers[i].consumer);
 }
+EXPORT_SYMBOL_GPL(devm_regulator_bulk_disable);

 /**
  * devm_regulator_bulk_get_enable - managed get'n enable multiple regulato=
rs
diff --git a/include/linux/regulator/consumer.h
b/include/linux/regulator/consumer.h
index 4660582a3302..ce7d28306b17 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -214,6 +214,7 @@ int __must_check regulator_bulk_enable(int num_consumer=
s,
                                       struct regulator_bulk_data *consumer=
s);
 int devm_regulator_bulk_get_enable(struct device *dev, int num_consumers,
                                   const char * const *id);
+void devm_regulator_bulk_disable(void *res);
 int regulator_bulk_disable(int num_consumers,
                           struct regulator_bulk_data *consumers);
 int regulator_bulk_force_disable(int num_consumers,
--------------------------------------------------------------------------

Thanks
-Anand

