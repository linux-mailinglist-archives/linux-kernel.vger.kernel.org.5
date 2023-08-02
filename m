Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8478D76C202
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjHBBQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHBBQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:16:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BFB270E;
        Tue,  1 Aug 2023 18:16:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA83C61781;
        Wed,  2 Aug 2023 01:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF80FC433C9;
        Wed,  2 Aug 2023 01:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690938985;
        bh=dRzi47V4F6qPxi+cL2DryDVpLxM7n0DuJBJlfEIFBIg=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=tBbtTP9CBi915qLC9iXHCjyT7rc3f8Nk+Hcr/mS1PKSKmi2Dfsg2PosL1W+bsB9QA
         CRiKPbMjCmcGJX4Hriop8MBFOX2XnNdhExe0WDQf5C470iLQhX2LZArTarFZsgmeBI
         0TQIjuzxfbF8+GFWmPOM2UtUX3OWuNT6whAgQ3wQ4T5ebe3k4VLb1MAqW5G329f87G
         esFhZZVmOobzuuVQFus4EKfcRQypshHOaUhGIsVf+Is7htcEFukhTvO5EXze9dDqwy
         kACuaP5bkxAvXbgJ42ixxUAVnoiwt3vgNR8XQfPqgnyIgNGIKqfOcmRDfDuQSheX+L
         rHulLxjQpv3OQ==
Date:   Tue, 01 Aug 2023 18:16:18 -0700
From:   Kees Cook <kees@kernel.org>
To:     Justin Stitt <justinstitt@google.com>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
CC:     Kees Cook <keescook@chromium.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: ipw2x00: refactor to use kstrtoul
User-Agent: K-9 Mail for Android
In-Reply-To: <20230802-wifi-ipw2x00-refactor-v1-1-6047659410d4@google.com>
References: <20230802-wifi-ipw2x00-refactor-v1-1-6047659410d4@google.com>
Message-ID: <86B2408D-BB52-4B29-BE4A-A6A12A129121@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 1, 2023 5:51:59 PM PDT, Justin Stitt <justinstitt@google=2Ecom> w=
rote:
>The current implementation seems to reinvent what `kstrtoul` already does
>in terms of functionality and error handling=2E Remove uses of `simple_st=
rtoul()`
>in favor of `kstrtoul()`=2E
>
>There is the following note at `lib/vsprintf=2Ec:simple_strtoull()` which
>further backs this change:
>| * This function has caveats=2E Please use kstrtoull (or kstrtoul) inste=
ad=2E
>
>And here, simple_str* are explicitly deprecated [3]=2E
>
>This patch also removes an instance of the deprecated `strncpy` which hel=
ps [2]=2E
>
>Link: https://lore=2Ekernel=2Eorg/all/202308011602=2E3CC1C0244C@keescook/=
 [1]
>Link: https://github=2Ecom/KSPP/linux/issues/90 [2]
>Link: https://docs=2Ekernel=2Eorg/process/deprecated=2Ehtml#simple-strtol=
-simple-strtoll-simple-strtoul-simple-strtoull [3]
>Cc: linux-hardening@vger=2Ekernel=2Eorg
>Suggested-by: Kees Cook <keescook@chromium=2Eorg>
>Signed-off-by: Justin Stitt <justinstitt@google=2Ecom>
>---
>
>
>Link: https://lore=2Ekernel=2Eorg/all/20230801-drivers-net-wireless-intel=
-ipw2x00-v1-1-ffd185c91292@google=2Ecom/
>---
> drivers/net/wireless/intel/ipw2x00/ipw2200=2Ec | 43 +++++++++-----------=
--------
> 1 file changed, 14 insertions(+), 29 deletions(-)
>
>diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200=2Ec b/drivers/net=
/wireless/intel/ipw2x00/ipw2200=2Ec
>index dfe0f74369e6=2E=2Eac10633f593e 100644
>--- a/drivers/net/wireless/intel/ipw2x00/ipw2200=2Ec
>+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200=2Ec
>@@ -1176,23 +1176,20 @@ static ssize_t debug_level_show(struct device_dri=
ver *d, char *buf)
> static ssize_t debug_level_store(struct device_driver *d, const char *bu=
f,
> 				 size_t count)
> {
>-	char *p =3D (char *)buf;
>-	u32 val;
>+	unsigned long *val =3D NULL;
>=20
>-	if (p[1] =3D=3D 'x' || p[1] =3D=3D 'X' || p[0] =3D=3D 'x' || p[0] =3D=
=3D 'X') {
>-		p++;
>-		if (p[0] =3D=3D 'x' || p[0] =3D=3D 'X')
>-			p++;
>-		val =3D simple_strtoul(p, &p, 16);
>-	} else
>-		val =3D simple_strtoul(p, &p, 10);
>-	if (p =3D=3D buf)
>+	int result =3D kstrtoul(buf, 0, val);

kstrtoul needs somewhere to write the value, so val need to be actually un=
signed long, and a pointer passed to that:

unsigned long val;
=2E=2E=2E
=2E=2E=2E kstrtoul(but, 0, &val);

But otherwise, yeah, this looks like the right direction to me=2E

>+
>+	if (result =3D=3D -EINVAL)
> 		printk(KERN_INFO DRV_NAME
> 		       ": %s is not in hex or decimal form=2E\n", buf);
>+	else if (result =3D=3D -ERANGE)
>+		printk(KERN_INFO DRV_NAME
>+			 ": %s has overflowed=2E\n", buf);
> 	else
>-		ipw_debug_level =3D val;
>+		ipw_debug_level =3D *val;
>=20
>-	return strnlen(buf, count);
>+	return count;=2E

It might be worth mentioning this return value change, but I think it's co=
rrect: we're communicating how much was consumed (we consumed it all)=2E Wh=
en the return value !=3D count, this function may be called again with the =
"rest" of the input=2E As this is a sysfs interface, that kind of behavior =
is very rare bordering on actively unwanted=2E :) So, I think these should =
either return a negative error or count=2E

-Kees

> }
> static DRIVER_ATTR_RW(debug_level);
>=20
>@@ -1461,33 +1458,21 @@ static ssize_t scan_age_store(struct device *d, s=
truct device_attribute *attr,
> {
> 	struct ipw_priv *priv =3D dev_get_drvdata(d);
> 	struct net_device *dev =3D priv->net_dev;
>-	char buffer[] =3D "00000000";
>-	unsigned long len =3D
>-	    (sizeof(buffer) - 1) > count ? count : sizeof(buffer) - 1;
>-	unsigned long val;
>-	char *p =3D buffer;
>=20
> 	IPW_DEBUG_INFO("enter\n");
>=20
>-	strncpy(buffer, buf, len);
>-	buffer[len] =3D 0;
>+	unsigned long *val =3D NULL;
>+	int result =3D kstrtoul(buf, 0, val);
>=20
>-	if (p[1] =3D=3D 'x' || p[1] =3D=3D 'X' || p[0] =3D=3D 'x' || p[0] =3D=
=3D 'X') {
>-		p++;
>-		if (p[0] =3D=3D 'x' || p[0] =3D=3D 'X')
>-			p++;
>-		val =3D simple_strtoul(p, &p, 16);
>-	} else
>-		val =3D simple_strtoul(p, &p, 10);
>-	if (p =3D=3D buffer) {
>+	if (result =3D=3D -EINVAL || result =3D=3D -ERANGE) {
> 		IPW_DEBUG_INFO("%s: user supplied invalid value=2E\n", dev->name);
> 	} else {
>-		priv->ieee->scan_age =3D val;
>+		priv->ieee->scan_age =3D *val;
> 		IPW_DEBUG_INFO("set scan_age =3D %u\n", priv->ieee->scan_age);
> 	}
>=20
> 	IPW_DEBUG_INFO("exit\n");
>-	return len;
>+	return count;
> }
>=20
> static DEVICE_ATTR_RW(scan_age);
>
>---
>base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
>change-id: 20230801-wifi-ipw2x00-refactor-fa6deb6c67ea
>
>Best regards,
>--
>Justin Stitt <justinstitt@google=2Ecom>
>


--=20
Kees Cook
