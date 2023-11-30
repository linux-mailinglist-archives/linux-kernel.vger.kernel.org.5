Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58657FF90D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346728AbjK3SH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346708AbjK3SH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:07:56 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AD6197
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:08:03 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6d81173a219so801738a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701367682; x=1701972482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RqXrTtRpLY0xEwP46IWeCwGF6Cga1FD0321b6TGHFA=;
        b=UREQY/fF7EdtHkFwYVgX7VnxIQjQUIJxDgFtFh2s7P6dBeOmjWrCkZqg3NEv10z8mO
         Z3bjDufIVOPPl0KJyaV+1vc7CfaIKXcgIYKSt4hHnGQqs+UatBInm73AIhEwc7D1lhY1
         GR4UX6ydwdLkofQ2VLJSf3uPPQq6S9wu2en3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701367682; x=1701972482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RqXrTtRpLY0xEwP46IWeCwGF6Cga1FD0321b6TGHFA=;
        b=pz5tYGjhHk/eW4dQ827SdBObMMj8HS8hAJ/N1KHnjjj0BsF/Nesb4H9cIcX2V27bXD
         MHR/4OccrnP+ceu4Cu6VCjD6D5JMbGM/nJgnq8AEdMz/5BsD+3KQbUmUlQbUnUeB6jqo
         971nCW8QCokEoP2fw4mUq8GrH97mPoPDXuM/ZXSyKV4PrnB5V5QdvzcmkeSlYNoen7+i
         4qNjxQMVR6q43soyZeClkxY+CDWdfWK5UAcREK5ptp0HknYLwZwKhH3L0iIzI40/RQ85
         wIPgJE7n/NadWaXOeSNDCeWn4drub1X8f0nhPqKg7zPsLnLwL4vJZbbdVdtX2/IdHIrr
         3m9A==
X-Gm-Message-State: AOJu0YzBwabUWo7awlkRgIoM7VAEOyepsEaM9sHU5pwPfT4EKcbMNeaZ
        5FQegwRo5TY97M+YDKfImMxmAGcvN5UeQgW3/5apAQ==
X-Google-Smtp-Source: AGHT+IG4aBr/tAwmP6nCezecVsZDHDlKUWxFTxpSHXwjWQor/sq5NSYpbvinssBA0j0F0Db5XDswfZ2QIuGFaXEx6xA=
X-Received: by 2002:a9d:68cd:0:b0:6d6:4972:b7ae with SMTP id
 i13-20020a9d68cd000000b006d64972b7aemr448347oto.13.1701367682342; Thu, 30 Nov
 2023 10:08:02 -0800 (PST)
MIME-Version: 1.0
References: <20231125012438.15191-4-dregan@broadcom.com> <20231130103624.715263-1-miquel.raynal@bootlin.com>
 <20231130113840.10500927@xps-13>
In-Reply-To: <20231130113840.10500927@xps-13>
From:   David Regan <dregan@broadcom.com>
Date:   Thu, 30 Nov 2023 10:07:51 -0800
Message-ID: <CAA_RMS4Z6TuEL_DFjpX9bXk_rz=1vqOYT95ccQf5+COsGVcq=g@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mtd: rawnand: brcmnand: exec_op implementation
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     dregan@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        william.zhang@broadcom.com, frieder.schrempf@kontron.de,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at,
        bbrezillon@kernel.org, kdasu.kdev@gmail.com,
        JaimeLiao <jaimeliao.tw@gmail.com>,
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

Thank you very much for all your good work!

-Dave


On Thu, Nov 30, 2023 at 2:38=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hello,
>
> miquel.raynal@bootlin.com wrote on Thu, 30 Nov 2023 11:36:24 +0100:
>
> > On Sat, 2023-11-25 at 01:24:38 UTC, dregan@broadcom.com wrote:
> > > From: David Regan <dregan@broadcom.com>
> > >
> > > exec_op implementation for Broadcom STB, Broadband and iProc SoC
> > > This adds exec_op and removes the legacy interface. Based on changes
> > > proposed by Boris Brezillon.
> > >
> > > https://github.com/bbrezillon/linux/commit/4ec6f8d8d83f5aaca5d1877f02=
d48da96d41fcba
> > > https://github.com/bbrezillon/linux/commit/11b4acffd761c4928652d7028d=
19fcd6f45e4696
> > >
> > > Signed-off-by: David Regan <dregan@broadcom.com>
> >
> > Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.gi=
t nand/next, thanks.
>
> FYI, I've applied misc style fixes on top of this patch.
>
> Thanks,
> Miqu=C3=A8l
