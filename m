Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2FE7D4C14
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjJXJZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbjJXJZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A411D7D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698139478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zX4o0gBmLAaG4/9qtaFDnjVgsGB5Bz4c+S6DOjjDtvY=;
        b=BXrWV0r4SN8KIzf8syWIGVLrz8TRur552LaqCnVu8M7NgIMHKyQCk4iFMRaZegD52gQ2EL
        aSoVc1L7TcsrT0JyRaR7T3L9tGZHggzh9CJeEThx3NatAihDxdKPjoKbrefKNRPN2CYFVE
        82Pi9FUu689k61XNrWlgU/4toyNDbew=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-CuC1B5r_OvG33-QSa_1YLg-1; Tue, 24 Oct 2023 05:24:32 -0400
X-MC-Unique: CuC1B5r_OvG33-QSa_1YLg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5401004754cso631762a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698139471; x=1698744271;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zX4o0gBmLAaG4/9qtaFDnjVgsGB5Bz4c+S6DOjjDtvY=;
        b=D3APk2uZWdAQ7Op4TGSYabJmDh097oYMzr1cNakaKrYvW6hqOMsdSif+GyG1MoldUj
         rrJK0+MOrJVjHAb1VPGHXltscdMz2SwEAtUUBqWhHuhXF9izDGFycNb720DklErYSfXT
         Hm1+d7kI8uWr759i+01RvoXALZKBgWGyV9RD3nBO46HhaKcqqP+W2vaEXofDK9vUXJYu
         T78aPRPg+ODMgh1PseQeiAZuqxEIhczvJpasOSIpk5owyhWHViAM6VaPsBHy0ObQDQda
         FPxUV7YkLIrfQtX+jMRWFsRkHnJ3xZpjsK9EZxWzXubL/dF/4a3xz0NQnaol1BqEBEr2
         KGSQ==
X-Gm-Message-State: AOJu0YxspbukPAZvFbyR7bRRxlxc/YqPkhs5oqZNbLTWhW1jTnk+Lmfc
        xVh9Jmc/rtJwvF04B27tkE1wUiueUtcfbVRSeyfERPQSdpsXVR22qTF6wZs8KGFapVQwesuvSO6
        ufISikF4m/LsBq35nYjO7wXkW
X-Received: by 2002:a50:a6dc:0:b0:53f:9243:38e0 with SMTP id f28-20020a50a6dc000000b0053f924338e0mr9657109edc.0.1698139471118;
        Tue, 24 Oct 2023 02:24:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtllyxRIgJgPEKqqcoYxJwRzPOEeGahQKFzUjHLJqdGTZ7IGs2zYx6QZdzlrGyNA8GJ2SKfg==
X-Received: by 2002:a50:a6dc:0:b0:53f:9243:38e0 with SMTP id f28-20020a50a6dc000000b0053f924338e0mr9657095edc.0.1698139470817;
        Tue, 24 Oct 2023 02:24:30 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-243-191.dyn.eolo.it. [146.241.243.191])
        by smtp.gmail.com with ESMTPSA id s24-20020a50ab18000000b0053de19620b9sm7803671edc.2.2023.10.24.02.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 02:24:30 -0700 (PDT)
Message-ID: <796915d9964d6470dc035785b83d74b8753d8ca0.camel@redhat.com>
Subject: Re: [PATCH V2] net: ethernet: davinci_emac: Use MAC Address from
 Device Tree
From:   Paolo Abeni <pabeni@redhat.com>
To:     Adam Ford <aford173@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Cc:     netdev@vger.kernel.org, aford@beaconembedded.com,
        Andrew Lunn <andrew@lunn.ch>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 24 Oct 2023 11:24:28 +0200
In-Reply-To: <CAHCN7x+ttO7yLkrc80issyjum_P1rcK9d5Keoyfxa-3krz8ssg@mail.gmail.com>
References: <20231022151911.4279-1-aford173@gmail.com>
         <97e1f76a-3505-4783-838a-10b9cacee8bd@intel.com>
         <CAHCN7x+ttO7yLkrc80issyjum_P1rcK9d5Keoyfxa-3krz8ssg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-23 at 20:22 -0500, Adam Ford wrote:
> On Mon, Oct 23, 2023 at 7:14=E2=80=AFPM Jacob Keller <jacob.e.keller@inte=
l.com> wrote:
> > Looks like you didn't add the tag for which tree. Given the context, I
> > would assume net-next.
>=20
> That was my intent.  I sent the e-mail to netdev and CC'd others.  I
> thought that was enough.

For future submissions: there are 2 different netdev trees, one for new
features (net-next) and another one for bugfixes (net), and you should
specify the target explcitly in the patch prefix. See:=C2=A0

Documentation/process/maintainer-netdev.rst

for the more details.

Looks like this one is targeting net-next.

Cheers,

Paolo


