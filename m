Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806BC7D975F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345810AbjJ0MLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345780AbjJ0MLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:11:31 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5081210A;
        Fri, 27 Oct 2023 05:11:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 10011E0005;
        Fri, 27 Oct 2023 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698408686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eg44jLmdOZ+FXq7ngD2IgZpYJKNtLh6V9L+riPizDlA=;
        b=PN9i3vmCEofP/kUbZFEwj9h89b57cX7ru1I5L4eIg4GAaTtIHh6IcIAoVqzWwnVIzE9ADT
        dYFz+Nea7RAUM5/Qs8OUoC0KSlQASC3re4Cg7MDeMzM20B7r44b4CHa2aAFvWuOGaxtUQQ
        eAVgCzKNvxK7ewJFT9uX7NkQ2FcIN4n4LB/3W8fO5Lz110JO9QOBN7S9EKrs8CsISGrfAs
        afXGDkLCeaL8OSZMdYinVUh6kRA/rT5bzvAUYE2UBK/KZcHKEsXZ4C843/QdNaCa9G5QY0
        dtAcPPKmMab2OyMt/00Ma19z1CKrSVfPX3o4HCpqniX2bVh3JNg8dAJtlBvs6Q==
Date:   Fri, 27 Oct 2023 14:11:22 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Edward Chow <equu@openmail.cc>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lech Perczak <lech.perczak@camlingroup.com>
Subject: Re: [PATCH v2 0/2] dt-bindings: mtd: partitions: Export special
 values
Message-ID: <20231027141122.4a0882c1@xps-13>
In-Reply-To: <20231027094610.1022114-1-equu@openmail.cc>
References: <20231025052937.830813-1-equu@openmail.cc>
        <20231027094610.1022114-1-equu@openmail.cc>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Edward,

equu@openmail.cc wrote on Fri, 27 Oct 2023 17:46:08 +0800:

> There are special "offset" and "size" values defined and documented in
> linux/mtd/partitions.h:
>=20
> /* consume as much as possible, leaving size after the end of partition. =
*/
>  #define MTDPART_OFS_RETAIN (uint64_t)(-3)
>=20
> /* the partition will start at the next erase block. */
>  #define MTDPART_OFS_NXTBLK (uint64_t)(-2)
>=20
> /* the partition will start where the previous one ended. */
>  #define MTDPART_OFS_APPEND (uint64_t)(-1)
>=20
> (Though not explicitly, they are compared against variables in uint64_t
> in drivers/mtd/mtdpart.c, so they had better be considered as such.)
>=20
> /* the partition will extend to the end of the master MTD device. */
>  #define MTDPART_SIZ_FULL (0)
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
>=20
> Edward Chow (2):
>   dt-bindings: mtd: partitions: Export special values
>   dt-bindings: mtd: partitions: Document special values
>=20
>  .../mtd/partitions/fixed-partitions.yaml      | 30 +++++++++++++++++++
>  MAINTAINERS                                   |  2 ++
>  include/dt-bindings/mtd/partitions.h          | 15 ++++++++++
>  3 files changed, 47 insertions(+)
>  create mode 100644 include/dt-bindings/mtd/partitions.h
>=20
> --
> 2.42.0

I've expressed my feelings regarding this series in your v1 but it
feels like you are completely ignoring them. As a reminder, I am
opposed to exporting these flags. They are outdated, legacy, have
never been used in DT and were never meant to be.

Thanks, Miqu=C3=A8l
