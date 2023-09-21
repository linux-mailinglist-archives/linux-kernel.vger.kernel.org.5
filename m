Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB237A9F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjIUUU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjIUUUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A97F835
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695317040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8073cadbomZvzn1x3/jFCjzqqbS1eUbDSTmbFgCsS0=;
        b=ail57T0wAXAFyCDL691B7TuGjUyUx+JIdmcEVYJf5ApJj5tTEZHLWHxkHHSHxIq5pmuDGR
        kQxcTsb68F7K41Lw1YOlRCe1hFCDIXS4nRi85WBDVfE6DFvz9ijP1FwXq5vAvJ9WBui2ib
        IuctH1p2C9RZNUYvtUWpsfWuxt3Cw8A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-hYUE15ZtOPKP46EnavZSnA-1; Thu, 21 Sep 2023 03:55:19 -0400
X-MC-Unique: hYUE15ZtOPKP46EnavZSnA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae5f4ebe7eso12546266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 00:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695282918; x=1695887718;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M8073cadbomZvzn1x3/jFCjzqqbS1eUbDSTmbFgCsS0=;
        b=j8BVUmF4aCU0VkluNxWS2f7UoMFN81Beofl90xnWcivVsrXCeD+qkWWzF9PmaK54k2
         tlHvabSEXt+nkRg/Zj3iyn5uASmWJEW2AExZ0WizSQD6zjqTR/AkTN50Lr1TEGhw8h4H
         WtF6sjcKSeyRe0SffXcJ92A/fKDYOrRMDEyWYXgtHiS+5SqPHyKzrG+uEsxkzgz3SnZN
         68Rdy/OF+qRtjlFW/PpMp17J6JS8yKWGTxP+Laxk56cVkWIZVZiXcdh0JsyvFM1cbSAe
         rf2/JQZgPVflCptjY9Ddy98SYL1zhifMSLX4O6SQBWQl4mFLHCz192dopEw3BgUjVtsi
         yjhQ==
X-Gm-Message-State: AOJu0YyKvrcUyjHxgNPcjcDBGcUhSsiQmEbeMlhiMYbk5h2aEOjHuJAp
        D8gQ9Y3rd418czA6koTuqOezVOF8vVZVWobpI3NBucPVubS+nsR9v1iOz/nw6ZjZi/OoPk4KAlF
        VTLhBPLUxtPUPRAhCGLZqAsLX
X-Received: by 2002:a17:906:d3:b0:9a1:d915:6372 with SMTP id 19-20020a17090600d300b009a1d9156372mr3807375eji.4.1695282917999;
        Thu, 21 Sep 2023 00:55:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSF1UlZO3avrXPLFXBb/vxNsqsACyKLXNET84ThtyZNLMmNfBCh4PTxsgjk9xoZz4KcuIv7Q==
X-Received: by 2002:a17:906:d3:b0:9a1:d915:6372 with SMTP id 19-20020a17090600d300b009a1d9156372mr3807366eji.4.1695282917682;
        Thu, 21 Sep 2023 00:55:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090614c400b00992b510089asm647510ejc.84.2023.09.21.00.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 00:55:17 -0700 (PDT)
Message-ID: <9eac9749406d91fd42520479b4c463417717246f.camel@redhat.com>
Subject: Re: [PATCH 2/2] net: stmmac: dwmac-stm32: refactor clock config
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Christophe Roullier <christophe.roullier@st.com>
Date:   Thu, 21 Sep 2023 09:55:15 +0200
In-Reply-To: <20230919164535.128125-4-ben.wolsieffer@hefring.com>
References: <20230919164535.128125-2-ben.wolsieffer@hefring.com>
         <20230919164535.128125-4-ben.wolsieffer@hefring.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-19 at 12:45 -0400, Ben Wolsieffer wrote:
> Currently, clock configuration is spread throughout the driver and
> partially duplicated for the STM32MP1 and STM32 MCU variants. This makes
> it difficult to keep track of which clocks need to be enabled or disabled
> in various scenarios.
>=20
> This patch adds symmetric stm32_dwmac_clk_enable/disable() functions
> that handle all clock configuration, including quirks required while
> suspending or resuming. syscfg_clk and clk_eth_ck are not present on
> STM32 MCUs, but it is fine to try to configure them anyway since NULL
> clocks are ignored.
>=20
> Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>

This patch is for net-next, while the previous one targets the -net
tree: you can't bundle them in a single series. Please re-post the
first one individually, specifying the target tree into the subj.

If there is a code dependency, you can post this one for net-next,
after -net is merged back into -net-next (Usually within a week since
the net patch is applied).

Cheers,

Paolo

