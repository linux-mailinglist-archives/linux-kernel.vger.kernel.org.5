Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E1A812D04
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443673AbjLNKeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443655AbjLNKeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:34:09 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FCB114;
        Thu, 14 Dec 2023 02:34:14 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B26C3240008;
        Thu, 14 Dec 2023 10:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702550052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jugSzKA5RANlnPt+1c8lwCcp54ROkWZ7TeiH8CT7p/A=;
        b=brU8mEhL7FkhQ9ky50byWcLBDM0D5qpw0kEMSokgUJptsEhuGASnYkJylJIguGZ6nO/q5J
        FVbxguP1/E1tO9XDiuTLGfldOsfc1FU4ii0sRUurXO/55O7AXbGT89jWBc+J7WVxs2w79q
        2QtfsWgH7gzMiZPFWmwUC1JzHH/bLPKnS+4d0kNRG1yZgoJqPzgqgQwkO4FXsqlo4xa/yl
        jTYFvc/Sf9BuQTy8+ZkRNEvv0ynT3nNW18Y796+iQIBUbNCr+ZVPDtWI8HLD3zWC22fhb7
        Z6myHK497Hh5VFtbSEr1R1E7GtDYKK4nPwYj7nf4pyOjEAD3W0B+Pa8LBbu5WA==
Date:   Thu, 14 Dec 2023 11:34:07 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Romain Gantois <romain.gantois@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Add GPT parser to MTD layer
Message-ID: <20231214113407.484e24a5@xps-13>
In-Reply-To: <cykfpuff32nuq3t27vd5tv463cx32phri473fjnrruvom5dk5u@uao5e3ml73ai>
References: <20231211151244.289349-1-romain.gantois@bootlin.com>
 <cykfpuff32nuq3t27vd5tv463cx32phri473fjnrruvom5dk5u@uao5e3ml73ai>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davidlohr,

dave@stgolabs.net wrote on Mon, 11 Dec 2023 16:43:58 -0800:

> On Mon, 11 Dec 2023, Romain Gantois wrote:
>=20
> >Hello everyone,
> >
> >MTD devices were historically partitioned using fixed partitions schemes
> >defined in the kernel device tree or on the cmdline. More recently, a bu=
nch
> >of dynamic parsers have been introduced, allowing partitioning informati=
on
> >to be stored in-band. However, unlike disks, parsers for MTD devices do =
not
> >support runtime discovery of the partition format. This format is instead
> >named in the device-tree using a compatible string.
> >
> >The GUID Partition Table is one of the most common ways of partitioning a
> >block device. As of now, there is no support in the MTD layer for parsing
> >GPT tables. Indeed, use cases for layouts like GPT on raw Flash devices =
are
> >rare, and for good reason since these partitioning schemes are sensitive=
 to
> >bad blocks in strategic locations such as LBA 2.  Moreover, they do not
> >allow proper wear-leveling to be performed on the full span of the devic=
e.
> >
> >However, allowing GPT to be used on MTD devices can be practical in some
> >cases. In the context of an A/B OTA upgrade that can act on either NOR of
> >eMMC devices, having the same partition table format for both kinds of
> >devices can simplify the task of the update software.
> >
> >This series adds a fully working MTD GPT parser to the kernel. Use of the
> >parser is restricted to NOR flash devices, since NAND flashes are too
> >susceptible to bad blocks. To ensure coherence and code-reuse between
> >subsystems, I've factored device-agnostic code from the block layer GPT
> >parser and moved it to a new generic library in lib/gpt.c. No functional
> >change is intended in the block layer parser.
> >
> >I understand that this can seem like a strange feature for MTD devices, =
but
> >with the restriction to NOR devices, the partition table can be fairly
> >reliable. Moreover, this addition fits nicely into the MTD parser model.
> >Please tell me what you think. =20
>=20
> I am not a fan of this. The usecase seems very hacky and ad-hoc to justify
> decoupling from the block layer,

The use case indeed is a bit ad-hoc, as it is an OTA tool which makes
it painful to handle two separate types of partitioning between blocks
and mtd devices, so being able to parse a GPT on an mtd device would
help a lot.

> not to mention move complexity out of
> userspace and into the kernel (new parser) for something that is already
> being done/worked around.

This is the part I don't fully agree with. There is no added
complexity, the parser exists and is kept untouched (apart from the
cosmetic changes). For a long time mtd partitioning information was
kept out of the storage (through fixed-partitions) but it's been quite
some time since the need for more flexible approaches arised, so we do
have "dynamic" partition parsers already and the one proposed by Romain
looks very straightforward and is thus not a problem to me. It
basically just extends the list of partition tables mtd devices know
about with a very common and popular format.

To be honest I do not have a strong opinion on whether this should be
merged or not but my reluctance is more about the mix of styles between
'block' and 'mtd'. People shall not treat them similarly for a number
of reasons, and this parser is an obvious step towards a more common
handling, knowing that it's been exclusively used on blocks for
decades.

> Also, what other user would consume this new gpt
> lib abstraction in the future? I don't think it is worth it.

Well, again I don't feel like this is a problem, sharing code between
two parties is already a win and the choice for a lib sounds rational
to me. The question being, shall we do it/do we want to do it.

Thanks,
Miqu=C3=A8l
