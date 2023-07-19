Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E10075A199
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjGSWQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGSWQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:16:35 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABD91FE2;
        Wed, 19 Jul 2023 15:16:33 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qMFSz-0008T6-1P;
        Wed, 19 Jul 2023 22:16:17 +0000
Date:   Wed, 19 Jul 2023 23:16:09 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Ungerer <gerg@kernel.org>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 2/9] dt-bindings: net: mediatek,net: add
 mt7988-eth binding
Message-ID: <ZLhgqSaAfTwYGlxn@makrotopia.org>
References: <cover.1689714290.git.daniel@makrotopia.org>
 <584b459ebb0a74a2ce6ca661f1148f59b9014667.1689714291.git.daniel@makrotopia.org>
 <20230719221320.GA865753-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719221320.GA865753-robh@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 04:13:20PM -0600, Rob Herring wrote:
> On Tue, Jul 18, 2023 at 10:30:33PM +0100, Daniel Golle wrote:
> > Introduce DT bindings for the MT7988 SoC to mediatek,net.yaml.
> > The MT7988 SoC got 3 Ethernet MACs operating at a maximum of
> > 10 Gigabit/sec supported by 2 packet processor engines for
> > offloading tasks.
> > The first MAC is hard-wired to a built-in switch which exposes
> > four 1000Base-T PHYs as user ports.
> > It also comes with built-in 2500Base-T PHY which can be used
> > with the 2nd GMAC.
> > The 2nd and 3rd GMAC can be connected to external PHYs or provide
> > SFP(+) cages attached via SGMII, 1000Base-X, 2500Base-X, USXGMII,
> > 5GBase-KR or 10GBase-KR.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  .../devicetree/bindings/net/mediatek,net.yaml | 74 +++++++++++++++++--
> >  1 file changed, 69 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> > index 38aa3d97ee234..ae2062f3c1833 100644
> > --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
> > +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> > @@ -24,6 +24,7 @@ properties:
> >        - mediatek,mt7629-eth
> >        - mediatek,mt7981-eth
> >        - mediatek,mt7986-eth
> > +      - mediatek,mt7988-eth
> >        - ralink,rt5350-eth
> >  
> >    reg:
> > @@ -61,6 +62,12 @@ properties:
> >        Phandle to the mediatek hifsys controller used to provide various clocks
> >        and reset to the system.
> >  
> > +  mediatek,infracfg:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to the syscon node that handles the path from GMAC to
> > +      PHY variants.
> > +
> >    mediatek,sgmiisys:
> >      $ref: /schemas/types.yaml#/definitions/phandle-array
> >      minItems: 1
> > @@ -229,11 +236,7 @@ allOf:
> >              - const: sgmii_ck
> >              - const: eth2pll
> >  
> > -        mediatek,infracfg:
> > -          $ref: /schemas/types.yaml#/definitions/phandle
> > -          description:
> > -            Phandle to the syscon node that handles the path from GMAC to
> > -            PHY variants.
> > +        mediatek,infracfg: true
> 
> You don't need this. What you need is 'mediatek,infracfg: false' in the 
> if/then schemas for the cases it should not be present.
> 

Ack, will do in the next round. Thanks!
