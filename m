Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EFF769BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjGaQGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGaQGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:06:10 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930D01BCC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:05:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE15BE0007;
        Mon, 31 Jul 2023 16:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690819534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dtnsSgdIFE3nvfrIp3Ekkqlk6qi/iH176UsC3eyjzqg=;
        b=QUFctZO/yKZIYSNQ0gF/bVbyEHezEI17EEZ0xAXGfnssmzBT3jwsKL0AzYllZzGNPGTpzT
        vIT/VPj7kr+U57pzZdtO6+Vw2U+1PR8JrLWU9rPL9Cc4SYSay2wcAeBJAD2TRCcsJVqzo9
        gPsKjVWKHYB+xcArjuOENzaG/8Tcwfe6srhxYORKTCqGaT58w9jSMKNRHg+/9ug5e05X9n
        B57A2ybRCkuz98R5oOC8CduSJeyHnBCwnMyq+2Wt3v5PdYuFnknPBaGYvLNVpHuxRBWEae
        mhQPAH/jqjw3T1MvACS1EBFjdkV3Tlsgb8me7rxf1mHQODoM9w7vJ/U+YA7i7w==
Date:   Mon, 31 Jul 2023 18:05:31 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 3/3] nvmem: core: Expose cells through sysfs
Message-ID: <20230731180531.7c616b3b@xps-13>
In-Reply-To: <20230718102617.GA982837@google.com>
References: <20230717075147.43326-1-miquel.raynal@bootlin.com>
        <20230717075147.43326-4-miquel.raynal@bootlin.com>
        <20230718102617.GA982837@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

> >  static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
> > @@ -1006,6 +1101,12 @@ struct nvmem_device *nvmem_register(const struct=
 nvmem_config *config)
> >  	if (rval)
> >  		goto err_remove_cells;
> > =20
> > +#ifdef CONFIG_NVMEM_SYSFS
> > +	rval =3D nvmem_populate_sysfs_cells(nvmem);
> > +	if (rval)
> > +		goto err_remove_cells; =20
>=20
> This breaks nvmem / efuse devices with multiple cells that share the
> same name. Something like this in DT:
>=20
> 	efuse: efuse@11f10000 {
> 		compatible =3D "mediatek,mt8183-efuse",
> 			     "mediatek,efuse";
> 		reg =3D <0 0x11f10000 0 0x1000>;
> 		#address-cells =3D <1>;
> 		#size-cells =3D <1>;
> 		thermal_calibration: calib@180 {
> 			reg =3D <0x180 0xc>;
> 		};
>=20
> 		mipi_tx_calibration: calib@190 {
> 			reg =3D <0x190 0xc>;
> 		};
>=20
> 		svs_calibration: calib@580 {
> 			reg =3D <0x580 0x64>;
> 		};
> 	};
>=20
> creates three cells, all named DT, and sysfs will complain:
>=20
>     sysfs: cannot create duplicate filename '/devices/platform/soc/11f100=
00.efuse/nvmem1/cells/calib'
>     mediatek,efuse: probe of 11f10000.efuse failed with error -17
>=20
> This causes the MT8183-based Chromebooks to lose display capability,
> among other things.

Sorry for the breakage, I did not identify this case, but you're right
this is incorrectly handled currently.

> The problem lies in the nvmem DT parsing code, where the cell name is
> derived from the node name, without including the address portion.
> However I'm not sure we can change that, since it could be considered
> ABI?

I would be in favor suffixing the cell names anyway as they have not
been exposed yet to userspace at all (well, not more than a couple of
days in -next).

Thanks,
Miqu=C3=A8l
