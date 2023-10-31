Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934E67DD276
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346707AbjJaQpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346306AbjJaQov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:44:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556251BD3;
        Tue, 31 Oct 2023 09:34:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a6190af24aso918176066b.0;
        Tue, 31 Oct 2023 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698770082; x=1699374882; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=npROlWWHLd9eG8P7dCgq4irOOFIkyMuBg6D6zLA4SMA=;
        b=X8ZqAomZ/bF42tIkKKkMdrPuoOhhCr6dllw6SZFKcB1X7wm4mQouYKLYaI07VwRV9J
         J3BYFZ0NTBA+5oyebgA3PuOdrAg8Rp+AnzJUUze/3HgPSoX893fPttYWBWghKGk5+sWC
         37c+pcXU/MO/wbyb3GD7JExLdWszs0zycQthtw/PEbMRkn6wvwkDi14SX9tnpL/hofx5
         UEMx+rvaNGvHWeASlMdgI7GkAkRfvapiCo0RubYM1inKmaPg8ZkTcGzdAvyO5Zqef61R
         BlZkR3ey6neZ06pC7XQqNYpk2rW/5Y16fxau+tvDjWwNCKy72/5f8Q3D/Y8AHAkERUXr
         30Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698770082; x=1699374882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=npROlWWHLd9eG8P7dCgq4irOOFIkyMuBg6D6zLA4SMA=;
        b=AGBNAELniBgXRNXrT+PpydvMNgxz3gT2vSQ/zxOg/T+EX/P63DcEam6PheCOMllMYC
         GfjtmOECwb5cZCPm8ud1T8/75OqYxkyzpF9dJoiZ62yHDNj0UAV4Mu8CKa0gbvmytfLq
         1WzQcchrM6BGPnVtGZtXXNsKP4jFUrVRPAiWIXfUBNrHAKjFMQyk953OeXQJjlu5C4uu
         FDpL9eKKg/FNEtVKb6SId+12dk4LIDtZR6yijDnaXMZPP0G9XvaHw6tSXcdI+eZHYcIB
         VxL7l9nFA19GKy1hoSiZUenrPelygz3Mx9ule4dNf4V3+RQSlwivYU9R0VgbIVxHjpHG
         wqsw==
X-Gm-Message-State: AOJu0YyQTriqEd4PdH3xoGKg3u68tEcRuTmekPRDWt6y6t71wVXysAGL
        Njz8pAbp5h07XeIVflZvetw=
X-Google-Smtp-Source: AGHT+IH5USwQhwT8MSNugtJz/VViP8UM4cwRku7P9ocJAQmWum5AXQA72zfDiIRxnh4dXacOdD3dag==
X-Received: by 2002:a17:907:6e93:b0:9b9:facb:d950 with SMTP id sh19-20020a1709076e9300b009b9facbd950mr11850982ejc.72.1698770082298;
        Tue, 31 Oct 2023 09:34:42 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id l19-20020a170906a41300b009ad81554c1bsm1215532ejz.55.2023.10.31.09.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 09:34:41 -0700 (PDT)
Date:   Tue, 31 Oct 2023 18:34:39 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231031163439.tqab5axhk5q2r62i@skbuf>
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
 <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf>
 <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf>
 <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 03:16:50PM +0100, Linus Walleij wrote:
> On Tue, Oct 31, 2023 at 12:33 AM Vladimir Oltean <olteanv@gmail.com> wrote:
> > On Mon, Oct 30, 2023 at 11:57:33PM +0100, Linus Walleij wrote:
> > > Here you can incidentally also see what happens if we don't pad the big packets:
> > > the packet gets truncated.
> >
> > Are we sure we are debugging a switch problem? On how many platforms
> > with the RTL8366RB can the issue be seen? Is the conduit interface the
> > same on all these platforms, or is it different and that makes no
> > difference?
> 
> I don't have any other RTL8366RB systems than the D-Link DIR-685.
> 
> I however have several systems with the same backing ethernet controller
> connected directly to a PHY and they all work fine.
> 
> Yours,
> Linus Walleij

Ok, so we don't have a confirmation of breakage with other conduit
interface than the Gemini driver, either. So a problem there is still
not off the table.

So on the gemini-dlink-dir-685.dts platform, you can also use &gmac1 as
a plain Ethernet port, right?

If possible, could you set up dsa_loop (enable CONFIG_NET_DSA_LOOP, replace
"eth0" in dsa_loop_pdata with the netdev name of &gmac1, replace DSA_TAG_PROTO_NONE
in dsa_loop_get_protocol() with your tagging protocol) and put a tcpdump
on the remote end of the gmac1 port, to see if the issue isn't, in fact,
somewhere else, maybe gmac_start_xmit()?

With dsa_loop, you turn &gmac1 into a conduit interface of sorts, except
for the fact that there is no switch to process the DSA-tagged packets,
you see those packets on the remote end, and you can investigate there
whether it's the switch who's corrupting/truncating, or if they're
somehow sent corrupted/truncated by Gemini on the wire (which would not
be visible in a local tcpdump).
