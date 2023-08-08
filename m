Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9F5774E04
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjHHWJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjHHWJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:09:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DEEE64
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691532528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Flz2QBTccsxoey25RxtTx/5hBDUCLeV9Z2hlojIPFFo=;
        b=Enn6Qbh2WJ12eb8ezUIYCJeFyNLYULGRip0EJ15dG92Wc2qKEgQB6BhwwWV1ojeTYUp0ev
        AAEqFCJhj9M0JScAL/SNdGStzQhBapwT/sougvZ/REL3Qz3PVUrkN3D+QTyR+80Nq+hTth
        Y/bhHd9JYeblpujAfJrbgB8hGiRDScw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-mq0JE_2XNbWCUMgu0X1PCQ-1; Tue, 08 Aug 2023 18:08:47 -0400
X-MC-Unique: mq0JE_2XNbWCUMgu0X1PCQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76c888cc6cdso677413685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 15:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691532527; x=1692137327;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Flz2QBTccsxoey25RxtTx/5hBDUCLeV9Z2hlojIPFFo=;
        b=V0hQ6bx5SbWv9vqQjnI6Lhtt12Ftm5s3QfikhStxwXrdlyjUanwdg/vx6jxHey9jL5
         GEGxPzsi0NtFG15jJN/+GzHcgNhYyMMwzcMuqb1VKPWHPi60Ca1qhgZ8Nj9X4A9ITmQa
         PtmD9jogDAYeFbe0OE41r2tgFu28EfF2oaa79a84QIYUNrhXfTcjLrQ+IIrQu1nssjS5
         ctCB1G6BmQMNMxX3slZu0oiT1eWOpKDPVXNJCyxkrB/xlMr/sJTu7jt+BmN4lEdbQqdY
         k6NF8ZVgiOPSR7kjFrexybHZLSli649GdmDpZv5BsyJ5MvR5hh2oCzqaPIuot7Xhx4fu
         RNyg==
X-Gm-Message-State: AOJu0Yy9OGH2egsYgY4iOT3PevycO9P8jmOKliCTRAM11AsTVb0W+YI2
        +q4HRjTcFmx1bGkq+m3Nbu3WPhKhRAOW0b8RdFx/JJRsYXsB3DrKAn4OFoKHPgSiIyZblLP/M9Y
        B/I/FqlxfjAo8xQyKp2wEyIZl
X-Received: by 2002:a05:620a:2887:b0:765:874f:bd78 with SMTP id j7-20020a05620a288700b00765874fbd78mr1267635qkp.0.1691532527116;
        Tue, 08 Aug 2023 15:08:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEwD6r4Q/U9ptZw615hbG6h8Qqng+cLfnMRelRqVbSluN1hOYOG0F+SC/VQyf7P+6K/U677w==
X-Received: by 2002:a05:620a:2887:b0:765:874f:bd78 with SMTP id j7-20020a05620a288700b00765874fbd78mr1267623qkp.0.1691532526899;
        Tue, 08 Aug 2023 15:08:46 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c7d:5f00::feb? ([2600:4040:5c7d:5f00::feb])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a126800b0076c84240467sm3536896qkl.52.2023.08.08.15.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 15:08:46 -0700 (PDT)
Message-ID: <f9452c1fa9081ae44bb76eec48c6debd81ee0db7.camel@redhat.com>
Subject: Re: [PATCH] Revert "Input: synaptics - enable InterTouch for the
 ThinkPad P1 G3"
From:   Lyude Paul <lyude@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Sebastian Wick <sebastian.wick@redhat.com>,
        Aman Dhoot <amandhoot12@gmail.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Raul Rangel <rrangel@chromium.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andrew Duggan <aduggan@synaptics.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 08 Aug 2023 18:08:45 -0400
In-Reply-To: <ZNK8aG/y4ol7MXVp@google.com>
References: <20230808152817.304836-1-sebastian.wick@redhat.com>
         <f13f4ff7d46ecf887ca652b664860c4e07ec8b73.camel@redhat.com>
         <ZNK8aG/y4ol7MXVp@google.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-08 at 15:06 -0700, Dmitry Torokhov wrote:
> On Tue, Aug 08, 2023 at 05:49:23PM -0400, Lyude Paul wrote:
> > Hm, This looks fine to me (if not as a final fix, certainly as a workar=
ound)
> >=20
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> >=20
> > However, this is definitely something we probably should try to fix at =
some
> > point - as I imagine this must be happening because something regarding=
 how
> > clicks are reported must have changed again. Andrew, do you have any id=
ea?
>=20
> I would like to understand more about this. Is this with newer/older
> BIOS, or another hardware revision of the product, or something else?


oops, somehow when typing that response I totally forgot I was responding t=
o a
revert ._., which changes everything

so yes - we should definitely look into this a bit more, I still have acces=
s
to this machine so I'll try to take a look tomorrow and see what's up
>=20
> Lyude, do you still have access to the unit you originally developed
> the original change for? Is the behavior broken there as well?
>=20
> Thanks.
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

