Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BA17A9A77
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjIUSkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjIUSkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EBD9D45A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695318962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GW0FxKMlEbyyqLVslDTbsm2PoLR7WFqvyt3jzMjJMK8=;
        b=ZxZsTbgiy8MZrdvhje9koE7PDxY8+EC6ow+UufsyPt6kEwtvSyHEnN8YkPQk7C0278duGl
        cIuqf2pKgZj9Q2xm62cNQ0Hx4T1VT6H97AsnyVwXXHnbs8v9lTrjAwkyakwGtQ4/knNlcE
        ghfsYF/3I3AqTn9n3NBtJaBdvcXkAig=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-nqIuOoHYOrWF8IglgSmfTA-1; Thu, 21 Sep 2023 09:39:19 -0400
X-MC-Unique: nqIuOoHYOrWF8IglgSmfTA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3214d1d4bbcso71364f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 06:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695303558; x=1695908358;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GW0FxKMlEbyyqLVslDTbsm2PoLR7WFqvyt3jzMjJMK8=;
        b=JjLnjcme98zoT8YMWkct6n3MaeSbdk8AbfS5Gc9C/YTwGzz7r7sa9hmdp/ohvhzxWf
         rOJae/0s5SxMbJ2p9HeP+dsHko3tozRHI6gvZqfTJAkIZ8/yUlvefDo1K3Zlq9jrG4RX
         SfGDniIHofT1uHEDvdIJX5IrpgHrp8YCmBpgc7o6H6lc1LDvbvBbUbnNNmRR/T/HlFbu
         RbdKHAoZDAn203fW38HO6DrXRO0705kTzaq2FTH+PgS1l6ba0Fa7PFAy7TTo8W8r96cr
         +Bsae7gTMsQ3uv/syX+qiVINVbTPXjFPkF9otb2UZZRc83jCstLpJ5YjIaXA7O1NMPck
         85Qw==
X-Gm-Message-State: AOJu0YzXiGObu7PVNP53+8pSClkGBbFXWo7uF23a9g9aD7NNeh6itONy
        q0mUH6Ob+Z9pMMbtozbn9pMirU/N0EnVY/2U/tWbwGVYP/QiRGmQZPrFekTZgBN2kq3SYYYsfZm
        JLgXgesQY2Bkoe634LQ6itAHX
X-Received: by 2002:adf:f688:0:b0:319:7624:4ca2 with SMTP id v8-20020adff688000000b0031976244ca2mr4576722wrp.0.1695303558367;
        Thu, 21 Sep 2023 06:39:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF17zexuhF9lQgbUMZlJkczKiweixlp/YM0Tz4cyQ9l/8XZueYGNkMJfqJ937KA3+cIlKRGKg==
X-Received: by 2002:adf:f688:0:b0:319:7624:4ca2 with SMTP id v8-20020adff688000000b0031976244ca2mr4576712wrp.0.1695303557921;
        Thu, 21 Sep 2023 06:39:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id y2-20020adffa42000000b0031423a8f4f7sm1824147wrr.56.2023.09.21.06.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 06:39:17 -0700 (PDT)
Message-ID: <50a8ec7dece0100c931fd187e19e14dd1ca1a0e9.camel@redhat.com>
Subject: Re: [PATCH net-next v2 1/2] r8152: remove queuing rx packets in
 driver
From:   Paolo Abeni <pabeni@redhat.com>
To:     Hayes Wang <hayeswang@realtek.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "bjorn@mork.no" <bjorn@mork.no>
Date:   Thu, 21 Sep 2023 15:39:15 +0200
In-Reply-To: <1a57cf3f867d4dfd991ef1d4024c931b@realtek.com>
References: <20230919031351.7334-429-nic_swsd@realtek.com>
         <20230919031351.7334-430-nic_swsd@realtek.com>
         <369f3139-4e63-4327-8745-2d72d7dfea8f@lunn.ch>
         <1a57cf3f867d4dfd991ef1d4024c931b@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-19 at 12:26 +0000, Hayes Wang wrote:
> Andrew Lunn <andrew@lunn.ch>
> > Sent: Tuesday, September 19, 2023 8:08 PM
> [...]
> > > -     return work_done;
> > > +     if (work_done > budget)
> > > +             return budget;
> > > +     else
> > > +             return work_done;
> > >  }
> >=20
> > I don't know NAPI too well. Are there implications of not telling it
> > the truth?
>=20
> You could check the reply from Jakub Kicinski, as following link.
> https://www.spinics.net/lists/netdev/msg933846.html
> https://www.spinics.net/lists/netdev/msg933923.html
>=20
> If the work_done is more than budget, I should return budget.

One of the key points in Jakub's reply is that the burst must exceed
the budget by a limited number of packets:

"Nothing will explode if we process a few more packets than budget
(assuming budget > 0)"

How many packets can contain at most a single URB?

If that number can be significant greater then the napi budget, I think
we are better off keeping the packet in the queue - otherwise the whole
system latency/stability would be affected.

Cheers,

Paolo

