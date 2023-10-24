Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489527D4E9D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjJXLMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJXLME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:12:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F147CD7F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698145878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2H7Y3L+wO4O4PCAdKbwK4BPdzk6P9AjMRpwDaWWqLDQ=;
        b=NmZC/QQcLLpRvvcP2hUYT4nQc6raTjaIvwCSEIQODozYAmQC78XTnZ4AFGqqeG/RTLk2px
        iGuiLA6XfqctScuNW+aWwEn1aJUzCOmvFyzmXab4xrjhlH8KK0B/fCoVnvv7spuAuUBCbP
        N1kNprwM3Xgo0XC6h5fk8XpOis3SJ2o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-Z8UP6zHhMIKJLu-QtIHkQw-1; Tue, 24 Oct 2023 07:11:16 -0400
X-MC-Unique: Z8UP6zHhMIKJLu-QtIHkQw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9c167384046so44444266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698145875; x=1698750675;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2H7Y3L+wO4O4PCAdKbwK4BPdzk6P9AjMRpwDaWWqLDQ=;
        b=iVj+3CkgHEdkucF3oVs6dc2/KbkQJEaAALlHFOf7H/lNnlxwdBORj39CEEwf8dmeWL
         s0ZVBRNBVsIqPcO6ngOrHytlwfdqwl2l3TEx5aRSb6SsCyW4i/By9EZwJQ579JHHW7Xu
         XcWhsSi+UhVtB1q56dB6aDiVxL4ULgSlnhtokVKqsVmuYvDHCQyW87/S4nGNYx0ciCa7
         Olx9x1n167HtI6D4daX/gnrt/PGstMP0UWdHz7e1uUBI4YG9RPQ5f6Z1JhF4nW2MFjcG
         SxtY1KGBp4zSXjX0d+N2Zf4MwiAHYaIBss+6VPBV2VmXySt15kCQAcHOIZS/2ICR9BuZ
         7zpg==
X-Gm-Message-State: AOJu0YznXKUqPZHko0xWAb7CX89iPE30TmGvrI3u9LJofMpkg7OLdRr0
        EPoROEcCyYt9yFVo0MkJRfy6VLwBuyK3YiTo1MSd91jtvTrZlBxISdCfra+XEOw0NbvxsEqy3yc
        NXUnAnuB6bBQeTPe9m1bSJ6tB
X-Received: by 2002:a17:906:f50:b0:9cb:b737:e469 with SMTP id h16-20020a1709060f5000b009cbb737e469mr1904600ejj.4.1698145875551;
        Tue, 24 Oct 2023 04:11:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbm6fF0XWXv8tlBeoO6lS6nrzwyNW4FLJl6hKfbijCy2f0/nuEpU6IezwHCF7SzoFNY107dQ==
X-Received: by 2002:a17:906:f50:b0:9cb:b737:e469 with SMTP id h16-20020a1709060f5000b009cbb737e469mr1904578ejj.4.1698145875194;
        Tue, 24 Oct 2023 04:11:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-180.dyn.eolo.it. [146.241.242.180])
        by smtp.gmail.com with ESMTPSA id d13-20020a1709064c4d00b009a5f1d15642sm8026369ejw.158.2023.10.24.04.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 04:11:14 -0700 (PDT)
Message-ID: <f44e4fd716729f1f35ef58895b1acde53adb9b35.camel@redhat.com>
Subject: Re: [PATCH net 2/2] liquidio: Simplify octeon_download_firmware()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        veerasenareddy.burru@cavium.com
Cc:     felix.manlunas@cavium.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Tue, 24 Oct 2023 13:11:13 +0200
In-Reply-To: <0278c7dfbc23f78a2d85060369132782f8466090.1698007858.git.christophe.jaillet@wanadoo.fr>
References: <cover.1698007858.git.christophe.jaillet@wanadoo.fr>
         <0278c7dfbc23f78a2d85060369132782f8466090.1698007858.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-10-22 at 22:59 +0200, Christophe JAILLET wrote:
> In order to remove the usage of strncat(), write directly at the rigth
> place in the 'h->bootcmd' array and check if the output is truncated.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The goal is to potentially remove the strncat() function from the kernel.
> Their are only few users and most of them use it wrongly.
>=20
> This patch is compile tested only.

Then just switch to strlcat, would be less invasive.

Thanks,

Paolo

