Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B805A8057D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345663AbjLEOn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjLEOnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:43:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8609196
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701787410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wm0ITqw2DU4e2VWwVFECygR4LDXbZjwyDzaWgvJfF0=;
        b=U/l/138RQpVbF1uZ5NrwfRwjrdYiw1h83c2IFOIPqQB6xipG70glVN9GIFU9sfhVGA74IT
        tYDCMlTH2JI+Xrf2xipZ4oa331Db8RwYTh17P1nQ5Cwmffsoc+L+GCRdZtKrZ/C8B0f4h3
        uugMhfuEqbjodV5jIS2bfMAKt6Cavmo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-Eu8kEfszOhizlqN9zftcNg-1; Tue, 05 Dec 2023 09:43:28 -0500
X-MC-Unique: Eu8kEfszOhizlqN9zftcNg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a18a4b745b2so79478466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 06:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701787407; x=1702392207;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wm0ITqw2DU4e2VWwVFECygR4LDXbZjwyDzaWgvJfF0=;
        b=djLatyka0iwI5zbV/4bljrn56Qx50+qgKZqry4xxTj3DA3foVHtG0CYmmHeYPkMbJR
         I1DQ7UFDJxlwRbCWiUGn7wm+a89oymNMBivEdwhWyZwF/bOKl5Kmh4rMtpsEiiRtVP4n
         lVX5hyv8W+fvR37/GRSzcUH7eROe30xDruhgGWsJKy6N1HTSS0CK0b8CwtFsbh4bw9hV
         7wyjkjUXK0ve2gngdJIcYqDjcquk2jl7k3n5sQ0SLbTPaK3oEgUi5jDlbbfXY1yMlwL0
         ukQsJvJDiVFQygCXHJix7XiniEDu5SaCl68Nb6jy4iXP+efkb7zx9tzwM5FsgaD7A2Pa
         9ZKw==
X-Gm-Message-State: AOJu0YztlTz0Eo6ealKlEFsxjZU0LG4Lp5PLiMKRIjn3A0oAvdfWhWcf
        zCnKfWXdksq5GAeE//3kg7XI5WXOzEsNuUqCZA6Ne1mjmsW+7dJhkU+CNe3596WuiOlhZ/CYt6p
        q/lEPBqTDkkcwKur5+U7I+txT
X-Received: by 2002:a17:906:3c4e:b0:a1c:7661:d603 with SMTP id i14-20020a1709063c4e00b00a1c7661d603mr1236188ejg.4.1701787407347;
        Tue, 05 Dec 2023 06:43:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTVwX4BoJTERHhYpuGgK7LnHRpXrWl+hzwooY5ZTjkhx74NN8Pxxz0TreVROkv5bngH7CHxQ==
X-Received: by 2002:a17:906:3c4e:b0:a1c:7661:d603 with SMTP id i14-20020a1709063c4e00b00a1c7661d603mr1236173ejg.4.1701787406923;
        Tue, 05 Dec 2023 06:43:26 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-54.dyn.eolo.it. [146.241.241.54])
        by smtp.gmail.com with ESMTPSA id g26-20020a170906199a00b009fdd2c6d042sm6836584ejd.148.2023.12.05.06.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:43:26 -0800 (PST)
Message-ID: <e9939ee50ffefe518862bf5616252f84c4c22d5b.camel@redhat.com>
Subject: Re: [EXT] Re: [PATCH] octeontx2-af: fix a use-after-free in
 rvu_npa_register_reporters
From:   Paolo Abeni <pabeni@redhat.com>
To:     Geethasowjanya Akula <gakula@marvell.com>
Cc:     Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Jerin Jacob Kollanukkaran <jerinj@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        George Cherian <gcherian@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhipeng Lu <alexious@zju.edu.cn>
Date:   Tue, 05 Dec 2023 15:43:24 +0100
In-Reply-To: <DM6PR18MB2602D6C118100B0AC5F7D35FCD85A@DM6PR18MB2602.namprd18.prod.outlook.com>
References: <20231202095902.3264863-1-alexious@zju.edu.cn>
         <6bb19e86b3f5c83bbc85c09b845e52208ce424d7.camel@redhat.com>
         <DM6PR18MB2602D6C118100B0AC5F7D35FCD85A@DM6PR18MB2602.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-12-05 at 13:13 +0000, Geethasowjanya Akula wrote:
> > -----Original Message-----
> > From: Paolo Abeni <pabeni@redhat.com>
> > Sent: Tuesday, December 5, 2023 6:05 PM
> > LGTM
> >=20
> > Acked-by: Paolo Abeni <pabeni@redhat.com>
> >=20
> > but allow some little more time for Marvel's people to have a better lo=
ok.
> >=20
> > Cheers,
> >=20
> > Paolo
> Ack. Thanks for the patch.=20

Thanks for the review!=20

Next time, please use the formal tag:

Acked-by: <you> <your email address>=20

so that the tools we use will propagate it automatically.

Cheers,

Paolo

