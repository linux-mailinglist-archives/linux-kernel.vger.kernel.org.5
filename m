Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DC275804D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjGRPBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjGRPBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:01:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F347FFC;
        Tue, 18 Jul 2023 08:01:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-992dcae74e0so800711766b.3;
        Tue, 18 Jul 2023 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689692496; x=1692284496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqWEL4gA+1//2T1ckqDIBEn8jdYuaWNUVSaFCkbjTy4=;
        b=UIlJfa9WgyAeucS0mrkbJNHs69E40J7mc9nvpDE6mIWq6XaHDh3CNiWxkOEQQHHpx4
         mh+LT/ZeNjziLzNHxQLrwWaPAX4f7QQ5ZAEfzDOO7vdz7zHCJzM6m3PQ1MbuM53jZSx7
         QwoNo5ASRMaPZBt2/gccjQnocx8yDcGs96JXm0giZe4XsCWTQlAflYFrImcBXMNGB+uC
         +YBj6anl0tEdrz3YfqU44Ipo+mQVhIY1dD2/Zmexhqi2S/kLB3+oMdt0P7M1SNEonJmG
         7OIHR5HtnniFBWb9ZAmvUg3ctUfhWDy3ecKmE50kZJqbXFonKt2h/QSI7U4cKpwQmAQi
         5CZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689692496; x=1692284496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqWEL4gA+1//2T1ckqDIBEn8jdYuaWNUVSaFCkbjTy4=;
        b=V0oDZHPNX4rBFA2xldGQix1gdkFrgrHs3hfteAK3tvg9hJI99yWfKqXo/OhdWOcLBa
         vo0qcYFOi4CHLIR4XwItmaKByMM/wm/AXs3ceWkB+QrMPGt4u6Oki1KVolYOGwG8CIEe
         abG3jmWY5dh6028b7SBFu2M0DpZo6lDbdtD3+ifW9xLpKVrTeH/k8PS+GjuZTMIW5vQb
         OJKNTSYqjzrLS9Vdwg/0pSMjdMCKRoIEjhtxvUA/LciJ/1NRw0ct+UgIKL8TBdlOu8Gu
         bkMNuSVhQ60ME6cQwqlKTTqjbv64+3QoAQFRQ6WIMjNzJDs2DwHrD7O6d9Vo66TOAUXV
         ScSA==
X-Gm-Message-State: ABy/qLZpaDGYyKhAg7LvvYHZiq8jDGoYcJ1WHrJ87EvXBs1u7BJNnFwR
        2fDrrZtxd4pP3z3LpjtzA0k=
X-Google-Smtp-Source: APBJJlGK/wVcWLMHMzyNtH3SfBTKgPWrbopg5cdW4tjynCluTYcMUcGQ8nDCMizMDsbl2RGsIf/GCA==
X-Received: by 2002:a17:907:7805:b0:994:5303:a1ec with SMTP id la5-20020a170907780500b009945303a1ecmr108385ejc.43.1689692496031;
        Tue, 18 Jul 2023 08:01:36 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id lj1-20020a170906f9c100b00992ed412c74sm1129950ejb.88.2023.07.18.08.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 08:01:35 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:33 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     pabeni@redhat.com, andrew@lunn.ch, davem@davemloft.net,
        edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
Message-ID: <20230718150133.4wpnmtks46yxg5lz@skbuf>
References: <164e816460523a9b54b06b1586f89b3bd2d09fc9.camel@redhat.com>
 <20230718144310.4887-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718144310.4887-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 04:43:10PM +0200, Ante Knezic wrote:
> > It does not apply cleanly to net-next. Please respin. You can retain
> > Andrew's Reviewed-by tag.
> 
> Respin might need a complete rework of the patch as with the
> conversion of 88e639x to phylink_pcs (introduced with commit
> e5b732a275f5fae0f1342fb8cf76de654cd51e50) the original code flow
> has completely changed so it will not be as simple as finding a new
> place to stick the patch. 
> The new phylink mostly hides away mv88e6xxx_chip struct which is needed 
> to identify the correct device and writing to relevant registers has also
> changed in favor of mv88e639x_pcs struct etc.
> I think you can see where I am going with this. In this sense I am not sure 
> about keeping the Reviewed-by tag, more likely a complete rewrite 
> should be done.
> I will repost V3 once I figure out how to make it work with the new
> framework.
> 

Can't you simply replicate the positioning of mv88e6393x_erratum_4_6()
from mv88e6393x_pcs_init()?
