Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB85807230
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378892AbjLFOUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378956AbjLFOUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:20:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5190D5A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701872451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f2RBSpfnLYJCeC3HZ4ObHjBnT7unowhTzn5c96YDfUw=;
        b=Vdw2ST3VI7Q59KHR9aM2nNXFxUCPoTw2R92F1J/BNI+wDe8FPkymWNcmW9W09QUOuOPyWn
        ICexkE7oHG3tus5l9oLsr9df/BmPrTBsQUAvQ7m5+yQQ0PGOh23oncQryJ8dKI3PFAepGC
        R9Ft5iGQNeImcPCndP7nAodlczMqeSk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-pxs_C41RNU23qcXPYIibfQ-1; Wed, 06 Dec 2023 09:20:49 -0500
X-MC-Unique: pxs_C41RNU23qcXPYIibfQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5400c8c6392so4737082a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 06:20:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701872448; x=1702477248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2RBSpfnLYJCeC3HZ4ObHjBnT7unowhTzn5c96YDfUw=;
        b=BW72aMVpgR1tHHn459uvkUGsmYJ6VzMbvKxRAVs6NISE5ZDTQNkH1W6zfGyZlriM2U
         DJwyG81Bdou8F2HFuzNEDleDMtHZVP5IJBqissteQ1E40knQHCvwgDcSnenGqix/XTRw
         by+baBTbkiVIvgWvZUN9gi+8r2X1HV7MWNlXbW5VO6RB+GtqodB9hGknjZkQpADVB3uU
         yiszWtMNPspgnKytPBrT8ICFISTjvJb9z0tctbajj5wLc0hucqc4CRXoccQgoJZZaw3X
         UvmJNej0kUbnbQv08kwYjzyDTD2ibRkOibilq1FGKDE66qeP9bgmQwU68cE6eNDTq32w
         oonQ==
X-Gm-Message-State: AOJu0YxZmpP97Sl/X169rIWuoihzLHHTKphAavIkSJffu6gH2LwEkxnH
        X09cd5Ei1kLfJrti+mynShJCDYwC6he49aftWNhqORuxDrTsVweIRVUOBujZ9+3jL6CM4/QdApB
        Y6bfVNWSWyeq2OeOivWYUyMRpEQaHUAieDzJ2uZ7L
X-Received: by 2002:a50:9fa7:0:b0:54c:5492:da0f with SMTP id c36-20020a509fa7000000b0054c5492da0fmr843677edf.0.1701872448379;
        Wed, 06 Dec 2023 06:20:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrmXvuOGDykGx+e9jdLrCjlRHBBpcHDPjXsnIPrvIMNa4bvVVPqa1dBZZgWoHW6gm3P141RSTRWu7oU5Gygsk=
X-Received: by 2002:a50:9fa7:0:b0:54c:5492:da0f with SMTP id
 c36-20020a509fa7000000b0054c5492da0fmr843670edf.0.1701872448067; Wed, 06 Dec
 2023 06:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20231206063549.2590305-1-srasheed@marvell.com>
 <CADEbmW32rjDJgr4xEArasguWfsSNTJpw__AgsE9n8mwE3qXwFA@mail.gmail.com> <PH0PR18MB473488E1ABF01D5E35A4AAF0C784A@PH0PR18MB4734.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB473488E1ABF01D5E35A4AAF0C784A@PH0PR18MB4734.namprd18.prod.outlook.com>
From:   Michal Schmidt <mschmidt@redhat.com>
Date:   Wed, 6 Dec 2023 15:20:36 +0100
Message-ID: <CADEbmW1R64YsLxjZV3FPZDR597OmJQ6J5FaMP0=QHsoEwFCaWA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH net v1] octeon_ep: explicitly test for firmware
 ready value
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani <hgani@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh B Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        Satananda Burla <sburla@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 3:12=E2=80=AFPM Shinas Rasheed <srasheed@marvell.com=
> wrote:
>
> Hi Michal
>
> > -----Original Message-----
> > From: Michal Schmidt <mschmidt@redhat.com>
> > Sent: Wednesday, December 6, 2023 7:28 PM
> > To: Shinas Rasheed <srasheed@marvell.com>
> > >                 pci_read_config_byte(pdev, (pos + 8), &status);
> > >                 dev_info(&pdev->dev, "Firmware ready status =3D %u\n"=
, status);
> > > -               return status;
> > > +#define FW_STATUS_READY 1ULL
> > > +               return (status =3D=3D FW_STATUS_READY) ? true : false=
;
> >
> > "status =3D=3D FW_STATUS_READY" is already the bool value you want. You
> > don't need to use the ternary operator here.
> >
>
> In some abnormal cases, the driver can read the firmware ready status as =
2. Hence this need for explicitly checking if status
> is indeed 1 or not. If it is 2, the function should understand it as the =
firmware is not ready. (It has to be strictly 1 for the driver
> to understand it as ready)

I'm not disputing that. I'm saying that this:
  return (status =3D=3D FW_STATUS_READY) ? true : false;
is equivalent to:
  return status =3D=3D FW_STATUS_READY;

Michal

