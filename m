Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178B57F347C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbjKURGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKURGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:06:12 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD64510E;
        Tue, 21 Nov 2023 09:06:04 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C440BFF81A;
        Tue, 21 Nov 2023 17:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700586363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9OlDSO/6KbnGCD41BC35yjBL1rC+a7EqniQWve6Dfd8=;
        b=W+ZDKXrSmia4ht5KtC8bLOg0gZ67cnEIeiRrysNdOHASGu3yrD1W8ZcbeiBa30t9Yfm3yW
        Uu3sCwQAQuGwffWLP2aG1tDAu7cyZZ0UkuqDG+JTsiI7/8gg5hA7zAoMOF1pJzXDqQId7Z
        zkVUi/N0NVzhZyJcay7o2Wta5QF0dAnxWz1iTk4oanU67TZwX2TzMI7yJnFSzhrVaJlDfa
        6xFBH3ddxTQ8uiA+p5pgK83B1SwiwOHkmLjC2H9XoKk3BRNJ/D1ezvTnbJ56hkNg5bNXvM
        aPjFXxwPaX3ZN3ZhdSOQpsEVnmwoE8fSXy/a0KTbWR2IhWojaJ6Etdok1X0yMA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 21 Nov 2023 18:06:01 +0100
Subject: Re: [PATCH v2 6/7] usb: cdns3-ti: signal reset-on-resume to xHCI
 for J7200 platform
Cc:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>
To:     "Roger Quadros" <rogerq@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Peter Chen" <peter.chen@kernel.org>,
        "Pawel Laszczak" <pawell@cadence.com>,
        "Nishanth Menon" <nm@ti.com>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Tero Kristo" <kristo@kernel.org>
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Message-Id: <CX4NJXCYMSJ1.AF8FQLHU77RU@tleb-bootlin-xps13-01>
X-Mailer: aerc 0.15.2
References: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
 <20231120-j7200-usb-suspend-v2-6-038c7e4a3df4@bootlin.com>
 <d2bd89f1-a86b-4fe4-a7ad-20c7e8caf9b6@kernel.org>
In-Reply-To: <d2bd89f1-a86b-4fe4-a7ad-20c7e8caf9b6@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue Nov 21, 2023 at 5:53 PM CET, Roger Quadros wrote:
> On 20/11/2023 19:06, Th=C3=A9o Lebrun wrote:
> > Pass CDNS3_RESET_ON_RESUME as platform data to cdns3 host role. It will
> > in turn pass it down to xHCI platform data as XHCI_RESET_ON_RESUME.
> >=20
> > Avoid this warning on resume:
> >=20
> >   [   16.017462] xhci-hcd xhci-hcd.1.auto: xHC error in resume, USBSTS =
0x401, Reinit
> >=20
> > When used, remote wakeup is not expected to work.
> >=20
> > Only focus J7200 as other SoC are untested.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  drivers/usb/cdns3/cdns3-ti.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.=
c
> > index 84f93c2fcd5c..7d56a1acbc54 100644
> > --- a/drivers/usb/cdns3/cdns3-ti.c
> > +++ b/drivers/usb/cdns3/cdns3-ti.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/property.h>
> > +#include "core.h"
> > =20
> >  /* USB Wrapper register offsets */
> >  #define USBSS_PID		0x0
> > @@ -128,6 +129,7 @@ static int cdns_ti_probe(struct platform_device *pd=
ev)
> >  {
> >  	struct device *dev =3D &pdev->dev;
> >  	struct device_node *node =3D pdev->dev.of_node;
> > +	const struct of_dev_auxdata *auxdata;
> >  	struct cdns_ti *data;
> >  	unsigned long rate;
> >  	int error, i;
> > @@ -177,7 +179,8 @@ static int cdns_ti_probe(struct platform_device *pd=
ev)
> > =20
> >  	cdns_ti_init_hw(data);
> > =20
> > -	error =3D of_platform_populate(node, NULL, NULL, dev);
> > +	auxdata =3D of_device_get_match_data(dev);
> > +	error =3D of_platform_populate(node, NULL, auxdata, dev);
> >  	if (error) {
> >  		dev_err(dev, "failed to create children: %d\n", error);
> >  		return error;
> > @@ -222,8 +225,20 @@ static const struct dev_pm_ops cdns_ti_pm_ops =3D =
{
> > =20
> >  #endif /* CONFIG_PM */
> > =20
> > +static struct cdns3_platform_data cdns_ti_j7200_pdata =3D {
> > +	.quirks =3D CDNS3_RESET_ON_RESUME,
> > +};
>
> We will need to introduce a new data structure "struct cdns_ti_platform_d=
ata"
> and add platform specific details like "reset_on_resume" to it.
> This is to address what Krzysztof pointed to in patch 4.

Yes I've got it locally following Krzysztof's review. Below my signature
is a sneak peak as I'll wait a bit more before a V3. First we implement
resume behavior in the wrapper driver using match data then we add
auxdata passed to the subdevices.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


------------------------------------------------------------------------


From 69a59e3408668dfa06d3790cb20948961708791d Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Th=3DC3=3DA9o=3D20Lebrun?=3D <theo.lebrun@bootlin.com>
Date: Mon, 20 Nov 2023 16:47:29 +0100
Subject: [PATCH 05/13] usb: cdns3-ti: add suspend/resume procedures for J72=
00
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Hardware initialisation is only done at probe. The J7200 USB controller
is reset at resume because of power-domains toggling off & on. We
therefore reconfigure the hardware at resume.

Reuse the newly extracted cdns_ti_init_hw() function that contains the
register write sequence.

Only focus J7200 as other SoC are untested. If the controller does not
reset we do not want to redo reg writes.

Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/cdns3-ti.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index d4232b440e4e..7530b6b5159d 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -58,6 +58,11 @@ struct cdns_ti {
   struct clk *usb2_refclk;
   struct clk *lpm_clk;
   int usb2_refclk_rate_code;
+  const struct cdns_ti_match_data *match_data;
+};
+
+struct cdns_ti_match_data {
+  bool reset_on_resume;
 };

 static const int cdns_ti_rate_table[] =3D {   /* in KHZ */
@@ -138,6 +143,7 @@ static int cdns_ti_probe(struct platform_device *pdev)
   platform_set_drvdata(pdev, data);

   data->dev =3D dev;
+  data->match_data =3D of_device_get_match_data(dev);

   data->usbss =3D devm_platform_ioremap_resource(pdev, 0);
   if (IS_ERR(data->usbss)) {
@@ -202,7 +208,30 @@ static void cdns_ti_remove(struct platform_device *pde=
v)
   platform_set_drvdata(pdev, NULL);
 }

+#ifdef CONFIG_PM
+
+static int cdns_ti_resume(struct device *dev)
+{
+  struct cdns_ti *data =3D dev_get_drvdata(dev);
+
+  if (data->match_data && data->match_data->reset_on_resume)
+     cdns_ti_init_hw(data);
+
+  return 0;
+}
+
+static const struct dev_pm_ops cdns_ti_pm_ops =3D {
+  SET_SYSTEM_SLEEP_PM_OPS(NULL, cdns_ti_resume)
+};
+
+#endif /* CONFIG_PM */
+
+static const struct cdns_ti_match_data cdns_ti_j7200_match_data =3D {
+  .reset_on_resume =3D true,
+};
+
 static const struct of_device_id cdns_ti_of_match[] =3D {
+  { .compatible =3D "ti,j7200-usb", .data =3D &cdns_ti_j7200_match_data, }=
,
   { .compatible =3D "ti,j721e-usb", },
   { .compatible =3D "ti,am64-usb", },
   {},
@@ -213,8 +242,9 @@ static struct platform_driver cdns_ti_driver =3D {
   .probe      =3D cdns_ti_probe,
   .remove_new =3D cdns_ti_remove,
   .driver     =3D {
-     .name =3D "cdns3-ti",
+     .name    =3D "cdns3-ti",
      .of_match_table   =3D cdns_ti_of_match,
+     .pm      =3D pm_ptr(&cdns_ti_pm_ops),
   },
 };

--
2.42.0


------------------------------------------------------------------------


From 4ff91a036da297e9e8585980c6133bee9c45d9a6 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Th=3DC3=3DA9o=3D20Lebrun?=3D <theo.lebrun@bootlin.com>
Date: Mon, 20 Nov 2023 17:02:44 +0100
Subject: [PATCH 07/13] usb: cdns3-ti: signal reset-on-resume to xHCI for J7=
200
 platform
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Pass CDNS3_RESET_ON_RESUME as platform data to cdns3 host role. It will
in turn pass it down to xHCI platform data as XHCI_RESET_ON_RESUME.

Avoid this warning on resume:

  [   16.017462] xhci-hcd xhci-hcd.1.auto: xHC error in resume, USBSTS 0x40=
1, Reinit

When used, remote wakeup is not expected to work.

Only focus J7200 as other SoC are untested.

Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/cdns3-ti.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index 7530b6b5159d..da2648ebc179 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -16,6 +16,7 @@
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include "core.h"

 /* USB Wrapper register offsets */
 #define USBSS_PID      0x0
@@ -62,7 +63,8 @@ struct cdns_ti {
 };

 struct cdns_ti_match_data {
-  bool reset_on_resume;
+  bool           reset_on_resume;
+  const struct of_dev_auxdata   *auxdata;
 };

 static const int cdns_ti_rate_table[] =3D {   /* in KHZ */
@@ -132,6 +134,7 @@ static int cdns_ti_probe(struct platform_device *pdev)
 {
   struct device *dev =3D &pdev->dev;
   struct device_node *node =3D pdev->dev.of_node;
+  const struct of_dev_auxdata *auxdata =3D NULL;
   struct cdns_ti *data;
   unsigned long rate;
   int error, i;
@@ -181,7 +184,9 @@ static int cdns_ti_probe(struct platform_device *pdev)

   cdns_ti_init_hw(data);

-  error =3D of_platform_populate(node, NULL, NULL, dev);
+  if (data->match_data)
+     auxdata =3D data->match_data->auxdata;
+  error =3D of_platform_populate(node, NULL, auxdata, dev);
   if (error) {
      dev_err(dev, "failed to create children: %d\n", error);
      return error;
@@ -226,8 +231,21 @@ static const struct dev_pm_ops cdns_ti_pm_ops =3D {

 #endif /* CONFIG_PM */

+static struct cdns3_platform_data cdns_ti_j7200_pdata =3D {
+  .quirks =3D CDNS3_RESET_ON_RESUME,
+};
+
+static const struct of_dev_auxdata cdns_ti_j7200_auxdata[] =3D {
+  {
+     .compatible =3D "cdns,usb3",
+     .platform_data =3D &cdns_ti_j7200_pdata,
+  },
+  {},
+};
+
 static const struct cdns_ti_match_data cdns_ti_j7200_match_data =3D {
   .reset_on_resume =3D true,
+  .auxdata =3D cdns_ti_j7200_auxdata,
 };

 static const struct of_device_id cdns_ti_of_match[] =3D {
--
2.42.0

