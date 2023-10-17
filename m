Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F737CC185
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbjJQLHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjJQLHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4B9B0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697540783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYqRkp5nbhNy4codggZnLt08peOmFDnihVhb/KDpZ7g=;
        b=Gb+M/W9tuDEt4KK2P/TCxh1G0bPARWZnt9xbMs9CYu66RPy0NETLrO8WOtflo26dCRbR+0
        U7KUcug1C7mxi+fwJMO5f8cjvKyT+G8r1G/IdGyOAlcBJlgbKrPNLmqaZBsdvX+nnm48NI
        KiazX0V1lNWA3GxDfwcefeG8Ull3EiM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-zbEEszgLOiOyDgEA2n8Jgg-1; Tue, 17 Oct 2023 07:04:47 -0400
X-MC-Unique: zbEEszgLOiOyDgEA2n8Jgg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c439446b73so29625666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697540671; x=1698145471;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GYqRkp5nbhNy4codggZnLt08peOmFDnihVhb/KDpZ7g=;
        b=LEJYhOnGhx6R7XVI3PgiQoNM2p0beDDhLJ1rKB/TuCd/85ksuwUtDXfcSt16MZfVU9
         MMjXzK+haDVbVwXwk1eLzj1IB6Kfe8unYG0J4r0UrO5mlLYCOB3hXgRHWkX6kFCWfZBx
         UDhexie/o6dMJUmtOpIayhaRkzNFHyxw6/gwtMKVs87pTD35KuGc3fojeQZRtAMNt8h4
         ySFHNBqbpkNeNg099HGD4Z+BL1GBNxh4kq/bgGfc0PQ2YwuP+DZ8XT7L3kNHS4jyfr7w
         fhg21L/ZGVPXgGg88EyJBLr/lrXWbQcUCY/Q8CvJDj45IUhWfyze7JYsTWPc+gPJxL7n
         HyMw==
X-Gm-Message-State: AOJu0YxeN3d540etQPDM8xK9bsc0PsFTqt1omZEs1s401R28wE+eX/+z
        Cy8qdMoelX2lrQVC4IG9zoJ1FyqQjAk3WhA5xu68ZjEY5lXNIEQ7AIgWgVWNmAq95UjPZixFXx9
        xqWlsl/k2Ov/dCLCqWN5m9ZP0
X-Received: by 2002:a17:907:94c3:b0:9c4:409:6d42 with SMTP id dn3-20020a17090794c300b009c404096d42mr1341004ejc.3.1697540670837;
        Tue, 17 Oct 2023 04:04:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESTIhEc9vD0Ik4h6NFgWxMULaxTEBNNmO1WfnFCd7dcXYuY3RUp7VoDu/Rw9S2hN4rrq8jTQ==
X-Received: by 2002:a17:907:94c3:b0:9c4:409:6d42 with SMTP id dn3-20020a17090794c300b009c404096d42mr1340990ejc.3.1697540670506;
        Tue, 17 Oct 2023 04:04:30 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-87.dyn.eolo.it. [146.241.233.87])
        by smtp.gmail.com with ESMTPSA id i5-20020a1709061cc500b0099315454e76sm1021589ejh.211.2023.10.17.04.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 04:04:30 -0700 (PDT)
Message-ID: <a3612d9fce07dffc1029cf49286f16913d2e2df8.camel@redhat.com>
Subject: Re: [PATCH net] net: ethernet: ti: Fix mixed module-builtin object
From:   Paolo Abeni <pabeni@redhat.com>
To:     MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Simon Horman <horms@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
        r-gunasekaran@ti.com, Roger Quadros <rogerq@kernel.org>
Date:   Tue, 17 Oct 2023 13:04:28 +0200
In-Reply-To: <20231013100549.3198564-1-danishanwar@ti.com>
References: <20231013100549.3198564-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

On Fri, 2023-10-13 at 15:35 +0530, MD Danish Anwar wrote:
> With CONFIG_TI_K3_AM65_CPSW_NUSS=3Dy and CONFIG_TI_ICSSG_PRUETH=3Dm,
> k3-cppi-desc-pool.o is linked to a module and also to vmlinux even though
> the expected CFLAGS are different between builtins and modules.
>=20
> The build system is complaining about the following:
>=20
> k3-cppi-desc-pool.o is added to multiple modules: icssg-prueth
> ti-am65-cpsw-nuss
>=20
> Introduce the new module, k3-cppi-desc-pool, to provide the common
> functions to ti-am65-cpsw-nuss and icssg-prueth.
>=20
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Given that you target the -net tree, please include a suitable fixes
tag, thanks!

Paolo

