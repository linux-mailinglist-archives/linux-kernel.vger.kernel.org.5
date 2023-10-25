Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1D97D63AD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjJYHmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbjJYHmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:42:21 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4551FEC;
        Wed, 25 Oct 2023 00:41:44 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66F98FF805;
        Wed, 25 Oct 2023 07:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698219703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rczZnqmf2oJWEm+utFuMjU8M9oOjD9zBSJMHjBMd3Yg=;
        b=SQ6wcvydOl+EbbCwlao/yg42LxLjOgNbvxFhi1TAviQhp47LC+0zS1vX0CVsm8mP0q/mhm
        e8YkylyHcVOA8MNDtAQipZYZDEmkE8Q2bRortE8oBpkKvYTa6fQJzdsofbtW6129c6QNZI
        kaMSnJaC/ff6Zip4gRnTBTTtlNqgQdOK8SY0SH6asFFhz15bMtmcDNCjaA37WgwmD+RdYd
        iU/8ZEKKA9I9NHaDOvhXx69pgRtqPoawGDQ1inilN/UMnDViiP+zx88OvSoGUQke9oomCo
        JLe7dzVSd6Awjvcbo+EN35gF7KcZBRpKKKgcth3OOWlqk14qxuqrnnzD0jtc0g==
Date:   Wed, 25 Oct 2023 09:41:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Edward Chow <equu@openmail.cc>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd-partitions: Export special values
Message-ID: <20231025094140.3da9ad71@xps-13>
In-Reply-To: <20231025052937.830813-1-equu@openmail.cc>
References: <20231025052937.830813-1-equu@openmail.cc>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Edward,

Thanks for the proposal!

equu@openmail.cc wrote on Wed, 25 Oct 2023 13:29:37 +0800:

> There are special "offset" and "size" values defined and documented in
> linux/mtd/partitions.h:
>=20
> // consume as much as possible, leaving size after the end of partition.
>=20
> // the partition will start at the next erase block.
>=20
> // the partition will start where the previous one ended.
>=20
> (Though not explicitly, they are compared against variables in uint64_t
> in drivers/mtd/mtdpart.c, so they had better be considered as such.)
>=20
> // the partition will extend to the end of the master MTD device.
>=20
> These special values could be used to define partitions automatically
> fitting to the size of the master MTD device at runtime.
>=20
> However, these values used not to be exported to dt-bindings, thus
> seldom used before, since they might have been only used in numeric form,
> such as "(-1) (-3)" for MTDPART_OFS_RETAIN.
>=20
> Now, they are exported in dt-bindings/mtd/partitions.h as 32-bit cell
> values, so 2-cell addressed should be defined to use special offset value=
s,
> such as "MTDPART_OFS_SPECIAL MTDPART_OFS_RETAIN" for MTDPART_OFS_RETAIN in
> linux/mtd/partitions.h. An example is added to fixed-partitions.yaml.

I don't think this has ever been used in DT, it comes from a previous
era where everything was declared in machine code and was never
intended to be part of the official bindings.

We've been trying to clarify the partitions binding to make them clean
and easily usable and I believe this comes from old times and is
way too legacy and backwards to be exposed.

Typically, this comes from times where the storage devices were so
small that an erase block boundary would be way too big and one would
want to store different "partitions" in a single block. It is close to
impossible to find such devices today so I don't think it really
matters and, as a general advice, should not be used anymore.

> Signed-off-by: Edward Chow <equu@openmail.cc>
> ---
>  .../mtd/partitions/fixed-partitions.yaml      | 29 +++++++++++++++++++
>  MAINTAINERS                                   |  2 ++
>  include/dt-bindings/mtd/partitions.h          | 15 ++++++++++
>  3 files changed, 46 insertions(+)
>  create mode 100644 include/dt-bindings/mtd/partitions.h
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-parti=
tions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partiti=
ons.yaml
> index 331e564f29dc..a939fb52ef76 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.y=
aml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.y=
aml
> @@ -164,3 +164,32 @@ examples:
>              read-only;
>          };
>      };
> +
> +  - |
> +    partitions {
> +        compatible =3D "fixed-partitions";
> +        #address-cells =3D <2>;
> +        #size-cells =3D <1>;
> +
> +        partition@0 {
> +            label =3D "bootloader";
> +            reg =3D <0 0x000000 0x020000>;
> +            read-only;
> +        };
> +
> +        firmware@1 {
> +            label =3D "firmware";
> +            /* From the end of the last partition, occupying as mush
> +             * as possible, retaining 0x010000 after it,
> +             * "MTDPART_OFS_SPECIAL MTDPART_OFS_NXTBLK" similar to
> +             * this, but always beginning at erase block boundary. */
> +            reg =3D <MTDPART_OFS_SPECIAL MTDPART_OFS_RETAIN 0x010000>;
> +        };
> +
> +        calibration@2 {
> +            compatible =3D "fixed-partitions";
> +            label =3D "calibration";
> +            /* Appending to the last partition, occupying 0x010000 */
> +            reg =3D <MTDPART_OFS_SPECIAL MTDPART_OFS_APPEND 0x010000>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 668d1e24452d..7d6beadc8b36 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13771,9 +13771,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel=
/git/mtd/linux.git mtd/fixes
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/n=
ext
>  F:	Documentation/devicetree/bindings/mtd/
>  F:	drivers/mtd/
> +F:	include/dt-bindings/mtd/
>  F:	include/linux/mtd/
>  F:	include/uapi/mtd/

This is a nice addition but totally unrelated, please make a separated
patch.

> =20
> +
>  MEMSENSING MICROSYSTEMS MSA311 DRIVER
>  M:	Dmitry Rokosov <ddrokosov@sberdevices.ru>
>  L:	linux-iio@vger.kernel.org
> diff --git a/include/dt-bindings/mtd/partitions.h b/include/dt-bindings/m=
td/partitions.h
> new file mode 100644
> index 000000000000..456a54a1259a
> --- /dev/null
> +++ b/include/dt-bindings/mtd/partitions.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Device Tree constants identical to those in include/linux/mtd/partiti=
ons.h
> + */
> +
> +#ifndef _DT_BINDINGS_MTD_PARTITIONS_H
> +#define _DT_BINDINGS_MTD_PARTITIONS_H
> +
> +#define MTDPART_OFS_SPECIAL	(-1)

This one does not exist, maybe -1 is hardcoded in the code and defining
it close to the existing definitions (not shared with the bindings)
make sense, but that is a different patch.

> +#define MTDPART_OFS_RETAIN	(-3)
> +#define MTDPART_OFS_NXTBLK	(-2)
> +#define MTDPART_OFS_APPEND	(-1)
> +#define MTDPART_SIZ_FULL	(0)

Just as an FYI, I would have expected the existing definitions to be
dropped if we were to take the patch.

Thanks,
Miqu=C3=A8l
