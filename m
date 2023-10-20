Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253D07D0622
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346780AbjJTBZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjJTBZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:25:08 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A453116
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:25:06 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so16605e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697765105; x=1698369905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4DExfMJZyf4aub9XNoOU1WM28O8RsrlbIYK7IDLbi4=;
        b=C3ObjXIzBZuc4epknE1jFRfQT1tRGHfDRWsGFBTNdq4Z2yKOIsmQTobeXLGaP2RJbk
         F+gFpRWM62b5AXMvllnDqXVhwdbzmjObcRu7K7xrrU6Vew3nUZR43/iUFBGqwzGa+FSm
         xvoG9SIRxDckjJY2hpLGG64qEC1osrdiEAn7AWjfCgfkVAfmVINd1Su038z2qQLFJRDb
         p+AYQBXIlpniztPmfATub7Er91B80rU8+JmT4swiMNQQTaX6NdHzGEwUE9loak7YUM0y
         kVYjwvNR4tuQCKM17iYA78t0ix2n/h5f/BIkNL33tbW6vHhw8LCV/+fsH+tmrIMHxw1t
         vHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697765105; x=1698369905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4DExfMJZyf4aub9XNoOU1WM28O8RsrlbIYK7IDLbi4=;
        b=irDytw3+fLp1dpKTMefzISCQeSqdlBGq1nbm6uEAEoOXbAieHXFVd4QznT1hSFvVnq
         H54Txz3pBuIUjy9cDwePlpzRWjvZNPhLuidDxGd0hUzoxtKDpPJXxendzs0DmOKvipZO
         jcgatyISZqF3Ceq/UAa9Y7ERTK4cmNPcD9kbBZbA21UJgd0v1G+Lw1txEKIyb+oRf8F3
         +lDwpASmYNZezakgY2gOSbzBxuvRR2VrOIh4UTH5oizwx2OHbFTyIvzafYK8uQ2L+Xn+
         hxL+yhUtMYNJPIe3O2yQhGAmYpDhsZPpViAx0MNaTfeU3K0XxG16CTfQRFdquPLqDiPM
         n2XQ==
X-Gm-Message-State: AOJu0YzYXDwuu6OY45cFQGArodkSyH5K6LfiFSMo7u5zgSzMYZGMnRj6
        GEHLuMaugVH3elDUs3uTdSg7xEYoC6zDeUnIZnAFsw==
X-Google-Smtp-Source: AGHT+IG4P81m4sXaBETHbG/hTD7nqRZU0MMz4d+KBW+zctkvGqxyMe9xAq8EyjU3DFVEgifwZ1yMa4Btc9BeM0Oug2s=
X-Received: by 2002:a05:600c:4e49:b0:404:7462:1f87 with SMTP id
 e9-20020a05600c4e4900b0040474621f87mr46010wmq.6.1697765104601; Thu, 19 Oct
 2023 18:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231019060616.1988631-1-hhhuuu@google.com> <ZTDnhbYDq7kq8vBj@kuha.fi.intel.com>
In-Reply-To: <ZTDnhbYDq7kq8vBj@kuha.fi.intel.com>
From:   Jimmy Hu <hhhuuu@google.com>
Date:   Fri, 20 Oct 2023 09:24:53 +0800
Message-ID: <CAJh=zjLtFmO4FWn8gzWWNQbfVggiq-K3O_WOcf=OV_ucybD7Yw@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix NULL pointer dereference in tcpm_pd_svdm()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, kyletso@google.com,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 4:24=E2=80=AFPM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Thu, Oct 19, 2023 at 06:06:16AM +0000, Jimmy Hu wrote:
> > It is possible that typec_register_partner() returns ERR_PTR on failure=
.
> > When port->partner is an error, a NULL pointer dereference may occur as
> > shown below.
> >
> > [91222.095236][  T319] typec port0: failed to register partner (-17)
> > ...
> > [91225.061491][  T319] Unable to handle kernel NULL pointer dereference
> > at virtual address 000000000000039f
> > [91225.274642][  T319] pc : tcpm_pd_data_request+0x310/0x13fc
> > [91225.274646][  T319] lr : tcpm_pd_data_request+0x298/0x13fc
> > [91225.308067][  T319] Call trace:
> > [91225.308070][  T319]  tcpm_pd_data_request+0x310/0x13fc
> > [91225.308073][  T319]  tcpm_pd_rx_handler+0x100/0x9e8
> > [91225.355900][  T319]  kthread_worker_fn+0x178/0x58c
> > [91225.355902][  T319]  kthread+0x150/0x200
> > [91225.355905][  T319]  ret_from_fork+0x10/0x30
> >
> > Add a check for port->partner to avoid dereferencing a NULL pointer.
> >
> > Fixes: 5e1d4c49fbc8 ("usb: typec: tcpm: Determine common SVDM Version")
> > Signed-off-by: Jimmy Hu <hhhuuu@google.com>
>
> No CC stable...?
Added in patch v2.
>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcp=
m.c
> > index 6e843c511b85..792ec4ac7d8d 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -1625,6 +1625,9 @@ static int tcpm_pd_svdm(struct tcpm_port *port, s=
truct typec_altmode *adev,
> >                       if (PD_VDO_VID(p[0]) !=3D USB_SID_PD)
> >                               break;
> >
> > +                     if (IS_ERR_OR_NULL(port->partner))
> > +                             break;
> > +
> >                       if (PD_VDO_SVDM_VER(p[0]) < svdm_version) {
> >                               typec_partner_set_svdm_version(port->part=
ner,
> >                                                              PD_VDO_SVD=
M_VER(p[0]));
>
> --
> heikki
