Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D5D757725
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjGRIwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjGRIws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:52:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECABF7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689670324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5KOR8rz1HcIaKvEfrXa81rmXVE1uZtoJjHifNrWIaLY=;
        b=VO+mU3uv0EaA6zXGtBwn69BrK3atslcjn4LP63WEP9gH68H2Hc1qrpuRaKS2n5080fz9td
        jams7WfiqtijFlirGgp2qpQToGgMPSf5PwOxhrL4x/b1zgeQ78lJ3k15iB8AYHW281I8fV
        /VGL4DXgtPSJDRV6XlCFpoSm+1iKd8w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-biBte5FlN_C33GzyZp-dEQ-1; Tue, 18 Jul 2023 04:52:03 -0400
X-MC-Unique: biBte5FlN_C33GzyZp-dEQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-765ad67e690so130776885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689670322; x=1690275122;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5KOR8rz1HcIaKvEfrXa81rmXVE1uZtoJjHifNrWIaLY=;
        b=i3Ibkkj5QRnDGtKRvNzss/JxoqFv+75WoK3IJYW9qD6JT4UC8vZx2XVeADUaBhJKrl
         xTRxunwLibLHrr3cUP0/SLt1ud+cSzNgxXnMtBcs1iPkAr7d2vCiBAWwLmdUfBalpDIE
         MlLPdym91oVP++y+sxEFnblFoHxPihS/62wIT9Pfrv5fdWVu39j7wBOnHOg8w6AqW4na
         mFCqdujmQSRulPjqRnuOkBboJqNgsLG5BZBZAHFjN0TCYeP3JvLXTOxfG04fEvUaZ39o
         t4BbhZa+8+YgQc7QfOJ2bxrgU6uCEARZ0bBnfsyg3MKyG5g6R/9Dgo1YrZiOG5q/KkEp
         mvmQ==
X-Gm-Message-State: ABy/qLYfK7jCpzEQVhAQALaQDYN/qD8OxTs34+Te+QsV4auT0qQLS2HY
        ITMwh5aXvJLDBYENwWOqNJCXP//x5Da01fSI9Ze09XpJuOz0r11C1sfOIv9m6lEQPzg+odEXTmx
        OQbfsT01plRmcgRd75t9lmtCY
X-Received: by 2002:a05:6214:29ca:b0:625:77a1:2a5f with SMTP id gh10-20020a05621429ca00b0062577a12a5fmr15751331qvb.5.1689670322557;
        Tue, 18 Jul 2023 01:52:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGyNfUCGibD1hyFQuxDmLGTOedRmloVQAyvYLT0e0Z7YsxX73m1Q+O8jquOzWtrmPF93zyMiA==
X-Received: by 2002:a05:6214:29ca:b0:625:77a1:2a5f with SMTP id gh10-20020a05621429ca00b0062577a12a5fmr15751310qvb.5.1689670322278;
        Tue, 18 Jul 2023 01:52:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id a24-20020a0cb358000000b0062dfdafa0b7sm564703qvf.136.2023.07.18.01.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 01:52:01 -0700 (PDT)
Message-ID: <befe05762b714948ad1f71a5d038334100f84cd0.camel@redhat.com>
Subject: Re: [PATCH net v3] net: thunder: bgx: Fix resource leaks in
 device_for_each_child_node() loops
From:   Paolo Abeni <pabeni@redhat.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        Wang Ming <machel@vivo.com>, opensource.kernel@vivo.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        David Daney <david.daney@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sunil Goutham <sgoutham@marvell.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Minjie Du <duminjie@vivo.com>
Date:   Tue, 18 Jul 2023 10:51:58 +0200
In-Reply-To: <be87c113-f975-9607-1f9d-5db304e0b1b9@web.de>
References: <20230714100010.12035-1-machel@vivo.com>
         <be87c113-f975-9607-1f9d-5db304e0b1b9@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-14 at 15:06 +0200, Markus Elfring wrote:
> > The device_for_each_child_node() loop in bgx_init_of_phy()
> > function should have fwnode_handle_put() before break which could
> > avoid resource leaks. This patch could fix this bug.
>=20
> Are imperative change descriptions still preferred?

Yes. The commit message should be re-phrased.

More importantly, it looks like the relevant reference is already
released by of_node_put() and the additional fwnode_handle_put() will
cause a reference underflow.

This patch does not look correct to me.

Cheers,

Paolo

