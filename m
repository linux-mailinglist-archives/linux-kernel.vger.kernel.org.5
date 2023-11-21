Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969807F2357
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjKUB4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjKUB4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:56:07 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57657C3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 17:56:03 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1f060e059a3so3041294fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 17:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1700531762; x=1701136562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQ56/e9gIXdSgfNSGdgWVptzKqn8eJWnAkxf2mpd0zs=;
        b=JLJnoaR0oWJz8AKB6i7Sedxl3umnNTuHEcq6cgCx6jzFM3oaxGg+KT4ofOL3McpQoH
         yapaXYX9oRI5iAfGF4AAqO6gWRsy9uLvFxmIm1NP86zMFxXSu4uBsSXCCM6H5nA7fSsX
         yyDjkLEsC+cC5ONxZrd7EzJN8/YHcPgpx1hPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700531762; x=1701136562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ56/e9gIXdSgfNSGdgWVptzKqn8eJWnAkxf2mpd0zs=;
        b=orJjp1rIi0jQZJ907cl5bH8bHXdYTkyj1FGoLk6ywxhf4KcAeaA99dWM6+upShQaiq
         f7f1RAff/fwLliml1g3ZAiXYkXA45SXQZ3s9SF4BHqzNqGrqXx0mIWxxxxuCW+6yX9Cg
         j44oudm/7llChg2F0CQRPO/oKyaW3kJsc/XrdDwFH7RyrKoe1jLTWs7XItiAw3QYJ00Z
         7IjjIs9rT07jAj7xVVO0u5q+Hw0NlNixOwJXI0jJOmuVnw+D+vsVq+tFrWtipUMkxvt8
         lFY+rnedhWCXDV7TCTU/IGZryt7BLPqDZUjEPvgioV78YiiSEmtLOLgY0ghRpGXeXjuS
         DXtA==
X-Gm-Message-State: AOJu0YwXMkSVMQQqVpOKGk0tYWzruEgoh0PqNHuge9RAD4TCRDn6kNHr
        vFMDMLYlKJR8DFU4nGxiY0Y0QPeK4BMQhxZapBVA/Q==
X-Google-Smtp-Source: AGHT+IH0fBRLchJxCRhVoAf6immLgQYjvq1pVQPEvi6I95SQNpe9lMarDAxipV+rtV+96QOE+fW49ggtHWk6IL7ar2Q=
X-Received: by 2002:a05:6870:b514:b0:1d6:5133:2f37 with SMTP id
 v20-20020a056870b51400b001d651332f37mr10374711oap.48.1700531762538; Mon, 20
 Nov 2023 17:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20231023171444.322311-1-dregan@broadcom.com> <20231023171444.322311-4-dregan@broadcom.com>
 <20231120112816.15a19e05@xps-13>
In-Reply-To: <20231120112816.15a19e05@xps-13>
From:   David Regan <dregan@broadcom.com>
Date:   Mon, 20 Nov 2023 17:55:51 -0800
Message-ID: <CAA_RMS4H3qxHehN5uZdeV9KKXEZqONAsyJHrBjgt57+2kQVqsg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mtd: rawnand: brcmnand: exec_op implementation
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Regan <dregan@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, Joel Peshkin <joel.peshkin@broadcom.com>,
        computersforpeace@gmail.com,
        Dan Beygelman <dan.beygelman@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>,
        frieder.schrempf@kontron.de, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, richard@nod.at, bbrezillon@kernel.org,
        kdasu.kdev@gmail.com, JaimeLiao <jaimeliao.tw@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miqu=C3=A8l,

On Mon, Nov 20, 2023 at 2:28=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hello,
>
> dregan@broadcom.com wrote on Mon, 23 Oct 2023 10:14:44 -0700:
>
> > From: David Regan <dregan@broadcom.com>
> >
> > exec_op implementation for Broadcom STB, Broadband and iProc SoC
> > This adds exec_op and removes the legacy interface. Based on changes
> > proposed by Boris Brezillon.
> >
> > https://github.com/bbrezillon/linux/commit/4ec6f8d8d83f5aaca5d1877f02d4=
8da96d41fcba
> > https://github.com/bbrezillon/linux/commit/11b4acffd761c4928652d7028d19=
fcd6f45e4696
> >
> > Signed-off-by: David Regan <dregan@broadcom.com>
>
> I'm fine with patches 1-3, a few minor nits on this version as well,
> nothing big. I guess I'll let some time to Florian as well to give his
> feedback and perhaps test the ->exec_op() implementation.

Thank you very much for your time, sorry for my missteps.
In the meantime I'll update and everyone can have additional
time to look.

>
> ...
>
> > +static int brcmnand_exec_instr(struct brcmnand_host *host, int i,
> > +                             const struct nand_operation *op)
> > +{
> > +     struct brcmnand_controller *ctrl =3D host->ctrl;
> > +     const struct nand_op_instr *instr =3D &op->instrs[i];
> > +     const u8 *out;
> > +     u8 *in;
> > +     int ret =3D 0;
> > +     bool last_op;
> > +
> > +     /*
> > +      * if we are on the last command in the sequence (not including
> > +      * waitrdy which is not a NAND command) then flag the controller
>
> May I suggest:
>
>         /*
>          * The controller needs to be aware of the last command in the op=
eration
>          * (WAITRDY excepted).
>          */
>

Will change.

> > +      */
> > +     last_op =3D (((i =3D=3D (op->ninstrs - 1)) &&
> > +                     (instr->type !=3D NAND_OP_WAITRDY_INSTR)) ||
>
> You can cross the 80 chars boundary. Please use this form:
>
>         last_op =3D ((i =3D=3D (op->ninstrs - 1)) && (instr->type !=3D NA=
ND_OP_WAITRDY_INSTR)) ||
>                   ((i =3D=3D (op->ninstrs - 2)) && (op->instrs[i+1].type =
=3D=3D NAND_OP_WAITRDY_INSTR));
>

Will do.

...

> > +static int brcmnand_exec_op_is_status(const struct nand_operation *op)
>
> brcmnand_op_is_status() would make more sense
>
> > +{
> > +     if ((op->ninstrs =3D=3D 2) &&
> > +             (op->instrs[0].type =3D=3D NAND_OP_CMD_INSTR) &&
> > +             (op->instrs[0].ctx.cmd.opcode =3D=3D NAND_CMD_STATUS) &&
> > +             (op->instrs[1].type =3D=3D NAND_OP_DATA_IN_INSTR))
> > +             return 1;
> > +
> > +     return 0;
> > +}
> > +
> > +static int brcmnand_exec_op_is_reset(const struct nand_operation *op)
>
> same here, please s/exec_//
>

I'll update the names.

> > +{
> > +     if ((op->ninstrs =3D=3D 1) &&
> > +             (op->instrs[0].type =3D=3D NAND_OP_CMD_INSTR) &&
> > +             (op->instrs[0].ctx.cmd.opcode =3D=3D NAND_CMD_RESET))
> > +             return 1;
> > +
> > +     return 0;
> > +}
> > +
> > +static int brcmnand_exec_op(struct nand_chip *chip,
> > +                         const struct nand_operation *op,
> > +                         bool check_only)
> > +{
> > +     struct brcmnand_host *host =3D nand_get_controller_data(chip);
> > +     struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +     u8 *status;
> > +     unsigned int i;
> > +     int ret =3D 0;
> > +
> > +     if (check_only)
> > +             return 0;
> > +
> > +     if (brcmnand_exec_op_is_status(op)) {
> > +             status =3D op->instrs[1].ctx.data.buf.in;
> > +             *status =3D brcmnand_status(host);
> > +
> > +             return 0;
> > +     }
>
> I would add the below chunk here:
>
>         } else if (brcmnand_exec_op_is_reset(op)) {
>                 ...
>
>                 return ...
>         }

Good idea will do.

...

>
> Thanks,
> Miqu=C3=A8l

Thanks!

-Dave
