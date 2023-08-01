Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D188776A770
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 05:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjHADVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 23:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjHADVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 23:21:51 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BF61FC8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 20:21:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so7024a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 20:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690860108; x=1691464908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzO/1LcDVMRB/OrxjquBH6be8FG+byeJszof6FJNED4=;
        b=fJmuoGeTpbIWCHmssy9B43L0Xph9h/r7LrC/wEUz1j/QKNUPziFKWmoFYmjdhk2VWp
         aviEgUkM/uepWRCBpF2QCLMad2f/IPR8lyHFN3DV9gTHsNjd8+xDpNln29B2DA+4JqKb
         XhBhBZ/rOSOOOMi9PGwQgP6NhRxoqihZf3j/B95oKlIcTwvwiH9O684PFo1F96YhcTfX
         wFWpbFEULW1/w0J7cikWliw6Zx7u7WRaT/qLVT/Sh4I493hL66qbjIbxM9KAWZ3RZeTT
         +rc0w9oTuNxskYJjXtSW1jkEDfnDsmNt2KH22JqGAPla7Tzqy8cR1XtdEzohOvc6NAqV
         Ofow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690860108; x=1691464908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzO/1LcDVMRB/OrxjquBH6be8FG+byeJszof6FJNED4=;
        b=LGFfyl5bWuj1wD1SRAHbV2/Cj1gj5/IONwADE42q6USyHu2/5eGz5Quz5dWjPMrioP
         xGIXn5P2dnAEllZsFiRi4MI9yE5UWOCyHFA3xVde9nmsO3ubz2SgRKd6TetC9J1VZTvO
         T/hTksntuIoMFkH7mpoFBObb1hVvT6tcLWLyokTgZg5mhRQiXz9ekILlgWUljQaoLhIi
         /O2OPqsXU60Ul7Xl3rluLzU0+c7YDP3Vq3NrOrOzcd7iiz17CkUuKzcPZ+olelE3hX5l
         UPZPzeJwDXtoMtKMkCkVuaeHPkZ7voClcn0bs3/4gxNP7HbDl1eNB6su5IESAnbpg4qF
         pZjA==
X-Gm-Message-State: ABy/qLa9q0HamTjXrqs6F6ODaC0/0z3QvTSRafNE/DBbu5NMlEg/cOu9
        ZnedJRaHd4KOYYMqYMILT4sO3ezEZa6etwet8vJVBQ==
X-Google-Smtp-Source: APBJJlHiBDrGA9hMcrRbXx5+ScfnkbUYR2tzQ1Bn7KtqXKPaoSy5GWQRjVQXT3oVZs7I7SzJWvw7QJTQSvsHdvv8OkI=
X-Received: by 2002:a50:f69d:0:b0:519:7d2:e256 with SMTP id
 d29-20020a50f69d000000b0051907d2e256mr266704edn.0.1690860108303; Mon, 31 Jul
 2023 20:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230630065711.801569-1-hhhuuu@google.com> <ZMeVnbnIuf1bNuKQ@kuha.fi.intel.com>
In-Reply-To: <ZMeVnbnIuf1bNuKQ@kuha.fi.intel.com>
From:   Jimmy Hu <hhhuuu@google.com>
Date:   Tue, 1 Aug 2023 11:21:36 +0800
Message-ID: <CAJh=zjJBUb2JpEh4Tf6z0V9KTy2jufRQktuJt2oMYbeu52PXzg@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Add IS_ERR_OR_NULL check for port->partner
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, kyletso@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 7:06=E2=80=AFPM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> I'm sorry to keep you waiting.
>
> On Fri, Jun 30, 2023 at 06:57:11AM +0000, Jimmy Hu wrote:
> > port->partner may be an error or NULL, so we must check it with
> > IS_ERR_OR_NULL() before dereferencing it.
>
> Have you seen this happening? Maybe the partner check should happen
> earlier, before tcpm_pd_svdm() is even called?
>
> > Fixes: 5e1d4c49fbc8 ("usb: typec: tcpm: Determine common SVDM Version")
> > Signed-off-by: Jimmy Hu <hhhuuu@google.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcp=
m.c
> > index 829d75ebab42..cd2590eead04 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -1626,6 +1626,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, s=
truct typec_altmode *adev,
> >                               break;
> >
> >                       if (PD_VDO_SVDM_VER(p[0]) < svdm_version) {
> > +                             if (IS_ERR_OR_NULL(port->partner))
> > +                                     break;
> >                               typec_partner_set_svdm_version(port->part=
ner,
> >                                                              PD_VDO_SVD=
M_VER(p[0]));
> >                               svdm_version =3D PD_VDO_SVDM_VER(p[0]);
>
> Now you will still build a response? I'm pretty sure you don't want
> that.
>
> Do we need to do anything in this function if the partner is lost? If
> not, then why not just check the partner in the beginning of the
> function. Or just make sure we don't even call tcpm_pd_svdm() if
> there's no partner.
>
> thanks,
>
> --
> heikki

Yes, we've seen this. Here is part of the last kmsg.

[978098.478754][  T319] typec port0: failed to register partner (-17)
...
[978101.505668][  T319] Unable to handle kernel NULL pointer
dereference at virtual address 000000000000039f
[978101.864439][  T319] CPU: 5 PID: 319 Comm: i2c-max77759tcp Tainted:
G        W  O      5.10.66-android12-9-00229-gd736cbf8d9ac-ab7921439
#1
[978101.866919][ T1176] [07:31:46.926532][dhd][wlan]
[978101.876939][  T319] Hardware name: Raven DVT (DT)
[978101.876949][  T319] pstate: 80c00005 (Nzcv daif +PAN +UAO -TCO BTYPE=3D=
--)
[978101.876982][  T319] pc : tcpm_pd_data_request+0x310/0x13fc
[978101.876987][  T319] lr : tcpm_pd_data_request+0x298/0x13fc
...
978101.886481][  T319] Call trace:
[978101.886492][  T319]  tcpm_pd_data_request+0x310/0x13fc
[978101.886506][  T319]  tcpm_pd_rx_handler+0x100/0x9e8
[978101.898747][  T319]  kthread_worker_fn+0x178/0x58c
[978101.898756][  T319]  kthread+0x150/0x200
[978101.898769][  T319]  ret_from_fork+0x10/0x30

Since this happens when PD_VDO_SVDM_VER(p[0]) < svdm_version, I think
we can check the partner after the condition is met.
Or check it when entering CMD_DISCOVER_IDENT case. Just like:
case CMDT_RSP_ACK:
/* silently drop message if we are not connected */
if (IS_ERR_OR_NULL(port->partner))
break;

Thanks,
Jimmy
