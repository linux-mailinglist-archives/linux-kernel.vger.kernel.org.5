Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFF67D7C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343922AbjJZFx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjJZFxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:53:25 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474A4137
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:53:23 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231026055321epoutp0492d7102ed149fd01c8e27004117f96d3~Rkn1PvndA2131721317epoutp04d
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:53:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231026055321epoutp0492d7102ed149fd01c8e27004117f96d3~Rkn1PvndA2131721317epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698299601;
        bh=EEYBtchdbkxl6Kq3+Ho3IKQ/ZuMOvG204vsnrMfIiVk=;
        h=Date:Subject:Reply-To:From:To:CC:References:From;
        b=KJ7sNd2RoPytDdV7UpKBFkRBWb521Ba1OEQyCPHTw0Zwc4Ja+7vgs0PAMcyZtLrO7
         UCcWaS2BC8LJ9lN8E4e7QkVYobIE4INm5ux4gKuMd9F9BSRuFvIVeJIbRbPYXgGITg
         EGaSOmUu83SVV6y1u74id3lQtmw7dMHUMnSFdC3k=
Received: from epsmgec5p1new.samsung.com (unknown [182.195.42.68]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231026055321epcas5p46b788c0d829401189cc04a3355d0b3eb~Rkn05xG8s0921509215epcas5p4c;
        Thu, 26 Oct 2023 05:53:21 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-af-6539fed04caf
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.52.08567.0DEF9356; Thu, 26 Oct 2023 14:53:20 +0900 (KST)
Date:   Thu, 26 Oct 2023 11:23:20 +0530
Message-ID: <899376598.3134980.1698299600677@mail-kr5-0.mail-kr5.knoxportal-kr-prod-blue.svc.cluster.local>
Mime-Version: 1.0
Subject: [PATCH] input: gpio-keys - optimize wakeup sequence.
Reply-To: abhi1.singh@samsung.com
Sender: Abhishek Kumar Singh <abhi1.singh@samsung.com>
From:   Abhishek Kumar Singh <abhi1.singh@samsung.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SRI-N IT Security <sri-n.itsec@samsung.com>,
        Abhishek Kumar Singh <abhi1.singh@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
X-CMS-MailID: 20231026055320epcms5p4c45782863304460f6ac6f182e1dac15f
Content-Type: multipart/mixed;
        boundary="----=_Part_3134979_356400796.1698299600677"
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7bCmpu6Ff5apBut2W1osXPOX0eLwoheM
        Fjc/fWO1uLxrDpvF/z072C1O/NnE7MDmsXPWXXaPTas62Tz6tqxi9Pi8SS6AJYrLJiU1J7Ms
        tUjfLoEro//3T9aCRpWKBZvmMzcw3lfqYuTkkBAwkVh7v5eli5GLQ0hgN6PE+nsb2EASLAKq
        Ej+ffGAHsXkFsiX+HDgFZHMA2YISf3cIg4SFBWwllv5ewQRiCwkoSiya08EMETeT2Hz3HSNI
        ORvQ/BXbeUDCIgLWEgf2dbCBrGIWaGOS2Ha+hQ3iBl6JGe1PWSBsaYnty7cyQtiiEjdXv2WH
        sd8fmw8VF5FovXeWGcIWlHjwczcjTO/3A7egZtZLnPo+AewvCYEeRol5cz9BLTCXOPOrB8p2
        kZi25DtYA7NAmMT1hVNYIGw+id7fT5hgjtsxD8ZWldh/9h8zzLIdk1ZBHech8e/pUTZIQARK
        fPn1nW0Co+wsRHDNQrIBwtaWWLbwNTNICbOApsT6XfoQYTWJKf1f2CBsJ4lPZ/dA2YoSU7of
        si9gZF/FKJlaUJybnppsWmCYl1quV5yYW1yal66XnJ+7iRGcbLRcdjDemP9P7xAjEwfjIUYV
        oPZHG1ZfYJRiycvPS1US4Y30sUgV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvu6dW6KkEB6Yklq
        dmpqQWoRTJaJg1OqgclIIoOlYOY8h/XzHpeo9gYctLme6mLQph4wLePGrC8f1qu97/1+OeT/
        QrMvM9urHhTKt97y6A3dFsO07m34tV0GbF9P3XyZlHgmeoqo7u1Z+X0FO1aemcNWGPpre2ng
        Zp+/r53mKjxp2/M+LXXlyTgGsYdHI1Xs7y1Z2/u4opvNSUT+t94buZcCjYcOT3re1GN6IWfC
        rAVp04q6dYVtHzX3GDPpe1U75lo7i+xjqG98lrd3/x/Gt8c+Ood7HohX9ijvTV/RqWew5NPR
        M9ckxUJY5+0RKha13jZ5wuH1VQevfFvvpt4YeiAl6YFng3oLi3Ge1EOVtU3x19yZ/FYGbNtr
        G8DgkNz0aGlW85qlS5RYijMSDbWYi4oTAc2GwR+xAwAA
X-CMS-RootMailID: 20231017103415epcms5p2f8f5b28a8f5d71055622b82f71b0fc93
References: <CGME20231017103415epcms5p2f8f5b28a8f5d71055622b82f71b0fc93@epcms5p4>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3134979_356400796.1698299600677
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dear Mr. Dmitry,
Greetings=21


The patch removes unused many APIs call chain for every suspend/resume of t=
he device=C2=A0=0D=0Aif=20no=20key=20press=20event=20triggered.=0D=0A=0D=0A=
=0D=0AThere=20is=20a=20call=20back=20function=20gpio_keys_resume()=20called=
=20for=0D=0Aevery=20suspend/resume=20of=20the=20device.=20and=20whenever=20=
this=20function=20called,=20it=20is=0D=0Areading=20the=20status=20of=20the=
=20key.=20And=20gpio_keys_resume()=20API=20further=20calls=20the=0D=0Abelow=
=20chain=20of=20API=20irrespective=20of=20key=20press=20event=0D=0A=0D=0A=
=0D=0AAPIs=20call=20chain:=0D=0Astatic=20void=20gpio_keys_report_state(stru=
ct=20gpio_keys_drvdata=20*ddata)=0D=0Astatic=20void=20gpio_keys_gpio_report=
_event(struct=20gpio_button_data=20*bdata)=0D=0Agpiod_get_value_cansleep(bd=
ata->gpiod);=0D=0Ainput_event(input,=20type,=20*bdata->code,=20state);=0D=
=0Ainput_sync(input);=0D=0A=0D=0A=0D=0AThe=20patch=20avoid=20the=20above=20=
APIs=20call=20chain=20if=20there=20is=20no=20key=20press=20event=20triggere=
d.=0D=0AIt=20will=20save=20the=20device=20computational=20resources,=20powe=
r=20resources=20and=20optimize=20the=20suspend/resume=20time=0D=0A=0D=0A=0D=
=0ASigned-off-by:=20Abhishek=20Kumar=20Singh=20<abhi1.singh=40samsung.com>=
=0D=0A=0D=0A=0D=0A---=0D=0A=C2=A0linux-6.4.11/drivers/input/keyboard/gpio_k=
eys.c=20=7C=208=20++++++--=0D=0A=C2=A01=20file=20changed,=206=20insertions(=
+),=202=20deletions(-)=0D=0A=0D=0A=0D=0Adiff=20--git=20a/linux-6.4.11/drive=
rs/input/keyboard/gpio_keys.c=20b/linux-6.4.11/drivers/input/keyboard/gpio_=
keys.c=0D=0Aindex=2013a8ba5..cd1609e=20100644=0D=0A---=20a/linux-6.4.11/dri=
vers/input/keyboard/gpio_keys.c=0D=0A+++=20b/linux-6.4.11/drivers/input/key=
board/gpio_keys.c=0D=0A=40=40=20-687,8=20+687,12=20=40=40=20static=20void=
=20gpio_keys_report_state(struct=20gpio_keys_drvdata=20*ddata)=0D=0A=C2=A0=
=0D=0A=C2=A0=20=C2=A0for=20(i=20=3D=200;=20i=20<=20ddata->pdata->nbuttons;=
=20i++)=20=7B=0D=0A=C2=A0=20=C2=A0=20=C2=A0struct=20gpio_button_data=20*bda=
ta=20=3D=20&ddata->data=5Bi=5D;=0D=0A-=C2=A0=20=C2=A0=20if=20(bdata->gpiod)=
=0D=0A-=C2=A0=20=C2=A0=20=C2=A0=20gpio_keys_gpio_report_event(bdata);=0D=0A=
+=C2=A0=20=C2=A0=20if=20(bdata->gpiod)=20=7B=0D=0A+=C2=A0=20=C2=A0=20=C2=A0=
=20struct=20gpio_keys_button=20*button=20=3D=20bdata->button;=0D=0A+=C2=A0=
=20=C2=A0=20=C2=A0=20if(button->value)=20=7B=0D=0A+=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20gpio_keys_gpio_report_event(bdata);=0D=0A+=C2=A0=20=C2=A0=20=C2=
=A0=20=7D=0D=0A+=C2=A0=20=C2=A0=20=7D=0D=0A=C2=A0=20=C2=A0=7D=0D=0A=C2=A0=
=20=C2=A0input_sync(input);=0D=0A=C2=A0=7D=0D=0A---=0D=0A=0D=0A=0D=0A=0D=0A=
=0D=0AThanks=20and=20Regards,=0D=0AAbhishek=20Kumar=20Singh=0D=0ASr.=20Chie=
f=20Engineer,=20Samsung=20Electronics,=20Noida-India=0D=0A=C2=A0=0D=0A=C2=
=A0=C2=A0=0D=0A=C2=A0=0D=0A=0D=0A
------=_Part_3134979_356400796.1698299600677
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="input_keys_optimized.zip"
Content-Transfer-Encoding: base64

UEsDBBQAAAAIAIZaMlflZigaUAMAACkHAAAaAAAAaW5wdXRfa2V5c19vcHRpbWl6ZWQucGF0Y2it
VF1vIjcUfca/4j5VUJhPCBCyJEHbjRpVraKSPq1WyGN7wM1gz9oeWNrmv/faQ5ImTVdNVQTj8f04
9/j6XK6M3kJ2elIyejpNh5SNxlSUxYTn5ZizshwVo2LMR+U0H06m8KNWsBQ1ZBNI01n4Qp6mGblC
mBnML365vYqmF58vFsVG2o24m+fpD82WGlyXUq03yfJgndji9kbvhTffUONwSZY/X0c/ackv5uQJ
hiZLR8sS/R/UWiohTLKkW9uo9fx9Pl+kHyrBnNFKMot57yhWzWLrC13aNi5mentOvqNOzDz7AWTT
cII8zYeQZbNsMjsZQT89GaZk2RS/It4MPt4sbt9//wluN8IIkBYoMFpVUFB2B2WjmJPYiHUt9epO
HOzKCNtsRbcXogSHUhsidsIcwDa2FoonbQToEtxGABc7yUQMVHHYb4TysejAQo/gLdIApMP6xAjK
8VQh2TrqGvsAhfVjWCDOK2wWN9cIaDDMBDzrM0ghKr0HtqFSeRAfJA3m1Hh0uQscEQZqNFlAZsrF
hGCUbXsQEmfEs5AMdnhjz0rX2riVd4qudaZh7i9ebnacOgrfcr/0/gEjvB2BQvlnQEXjnFarFqdo
cbyDr9bCrXa0asSKUWUrIepu8Efnwd87I1LVzQNmeB+AO9RicASKzpnmuAvsH8PtQbE2Gk0okfVa
oIK574PCV3AaaDiBvw1aaOzgi2aBDFfVKknpl90FZySCGsFjcu1gLzHPUoR5UgqgiJEA9cqgFWCu
bgwTdgC1n6InQ1CUrp3cyt9agBcCRI8gURQRqKRqvkTjeBRnWcIN3ryxSThnggQLTQ1PHi8lZvAH
TKEfPj47g1JW4tgElOkYpLLCeIK22+8NIEfqlWj3UY8QLssSomiNeqbJW2sXb83Au+PiC2RDOi3o
SRwzno3TUwFZmo5HI9+At7MgePT/wOTyEqLxdDLA7vklywEt/8f0AIEO/tFAV8Ic0jOQ8A54q+O6
XVQ7LBZ9/X4PfseEztdnCZG+OWL450f56YxEnQ4K+PkseWPnayPbTuYZ6b+SjETQ3PnbAVs6yKRd
53DMavcBC8G67TY6D7P+APZvyXTu/fMeO+F/r0w43KM6gOTxKIvTeI860nsbZ4T8CVBLAQIUABQA
AAAIAIZaMlflZigaUAMAACkHAAAaAAAAAAAAAAEAIAAAAAAAAABpbnB1dF9rZXlzX29wdGltaXpl
ZC5wYXRjaFBLBQYAAAAAAQABAEgAAACIAwAAAAA=

------=_Part_3134979_356400796.1698299600677--
