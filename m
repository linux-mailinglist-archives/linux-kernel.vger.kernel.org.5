Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CDA7B52C3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbjJBMN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbjJBMNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:13:13 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D4A3584
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:12:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47CCDE0003;
        Mon,  2 Oct 2023 12:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696248729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhprkMPkS6qsImRy6W6yD41h8GmwyEwpRYEXzX0JD58=;
        b=GHF5gaegWFK5T/2iN2ILLf9N1xBfeyfNCSEEHRiceuS/wDMVym86qm63nqG7UxapsRlupt
        0h/ZmTwLleXaR4nJ1WWKkceRluLSysXP/j1TBMKvogEExebtyWsCd5gdIydxildd94wL/f
        eZ4bGe0r/ODfrj2aHH3H3Huxu6hUqyqIk7L8VI8L+9Hupg/QxWhoAPkcWxqTKqf/3Pe04H
        BCDLe00nKz46B2ypo/5xBzQOmZlv8C4ifukd9AhCBs663FVl0VwSPplloVQRKp9D2acP8Q
        PViOmfUCNURrycr5RvkwJ53TZ4kqrETQaLeMIL5nY7yuyglu1LeX0p361I7nzw==
Date:   Mon, 2 Oct 2023 14:12:04 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     dregan@mail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        william.zhang@broadcom.com, frieder.schrempf@kontron.de,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at,
        bbrezillon@kernel.org, kdasu.kdev@gmail.com
Subject: Re: [PATCH] mtd: rawnand: brcmnand: Initial exec_op implementation
Message-ID: <20231002141204.167a9cc6@xps-13>
In-Reply-To: <trinity-ad65aa5d-e930-4f11-ac86-e18f90f5092c-1696016842791@3c-app-mailcom-lxa02>
References: <trinity-bb7db9f1-d34d-4fe2-bed3-814d3a63476a-1694571881792@3c-app-mailcom-lxa03>
        <20230922162424.4a7b27ec@xps-13>
        <trinity-ad65aa5d-e930-4f11-ac86-e18f90f5092c-1696016842791@3c-app-mailcom-lxa02>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> > > +
> > > +	for (i =3D 0; i < subop->ninstrs; i++) {
> > > +		instr =3D &subop->instrs[i];
> > > +
> > > +		if ((instr->type =3D=3D NAND_OP_CMD_INSTR) &&
> > > +			(instr->ctx.cmd.opcode =3D=3D NAND_CMD_STATUS))
> > > +			status =3D 1;
> > > +		else if (status && (instr->type =3D=3D NAND_OP_DATA_IN_INSTR)) {
> > > +			/*
> > > +			 * need to fake the nand device write protect because nand_base d=
oes a
> > > +			 * nand_check_wp which calls nand_status_op NAND_CMD_STATUS which=
 checks
> > > +			 * that the nand is not write protected before an operation start=
s.
> > > +			 * The problem with this is it's done outside exec_op so the nand=
 is
> > > +			 * write protected and this check will fail until the write or er=
ase
> > > +			 * or write back operation actually happens where we turn off wp.
> > > +			 */ =20
> >=20
> > If there is a problem with the core it needs to be handled in the core,
> > not workarounded here. The whole logic with the status property seems
> > really wrong.
> >  =20
>=20
> I'm trying to change our current code functionality as little as
> possible by having this function in the same way as it always has
> and I do not want to make changes too much outside the scope
> of this exec_op change.

I understand, and this is probably the best first approach, but if
there is really an issue here with the behavior of the core (or one of
its helpers) we need to fix it properly rather than workarounding it.

Thanks,
Miqu=C3=A8l
