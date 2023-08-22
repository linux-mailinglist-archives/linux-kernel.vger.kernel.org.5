Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F09784026
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbjHVLyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbjHVLyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:54:18 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC52CE9;
        Tue, 22 Aug 2023 04:53:59 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qYPg5-0006wL-27;
        Tue, 22 Aug 2023 11:36:06 +0000
Date:   Tue, 22 Aug 2023 12:35:47 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: mt76: support setting
 per-band MAC address
Message-ID: <ZOSdk6LyTlCayG4i@makrotopia.org>
References: <d3130584b64309da28a04826100643ff6239f9ca.1690841657.git.daniel@makrotopia.org>
 <20230811190944.GA3730441-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811190944.GA3730441-robh@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 01:09:44PM -0600, Rob Herring wrote:
> On Mon, Jul 31, 2023 at 11:23:16PM +0100, Daniel Golle wrote:
> > Introduce support for setting individual per-band MAC addresses using
> > NVMEM cells by adding a 'bands' object with enumerated child nodes
> > representing the 2.4 GHz, 5 GHz and 6 GHz bands.
> > 
> > In case it is defined, call of_get_mac_address for the per-band child
> > node, otherwise try with of_get_mac_address on the main device node and
> > fall back to a random address like it used to be.
> > 
> > While at it, add MAC address related properties also for the main node.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> > Changes since v2:
> >  * drop items list with only a single item
> > 
> > Changes since v1:
> >  * add dt-bindings
> > 
> >  .../bindings/net/wireless/mediatek,mt76.yaml  | 58 ++++++++++++++++++-
> >  1 file changed, 57 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> > index 252207adbc54c..7eafed53da1de 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> > @@ -37,6 +37,12 @@ properties:
> >      description:
> >        MT7986 should contain 3 regions consys, dcm, and sku, in this order.
> >  
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> >    interrupts:
> >      maxItems: 1
> >  
> > @@ -72,13 +78,23 @@ properties:
> >  
> >    ieee80211-freq-limit: true
> >  
> > +  address: true
> 
> What's this? Not a documented property.

Maybe it should be documented then...?
See
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/core/of_net.c#n140

```
int of_get_mac_address(struct device_node *np, u8 *addr)
{
	int ret;

	if (!np)
		return -ENODEV;

	ret = of_get_mac_addr(np, "mac-address", addr);
	if (!ret)
		return 0;

	ret = of_get_mac_addr(np, "local-mac-address", addr);
	if (!ret)
		return 0;

	ret = of_get_mac_addr(np, "address", addr);
	if (!ret)
		return 0;

	return of_get_mac_address_nvmem(np, addr);
}
EXPORT_SYMBOL(of_get_mac_address);
```

> 
> 
> > +
> > +  local-mac-address: true
> > +
> > +  mac-address: true
> 
> You really need a ref to the schema defining these. But first we need to 
> split them out from ethernet-controller.yaml. Which I think there were 
> patches for, but it stalled out.
> 

I understand, so have a schema to include whenever of_net.c is used to
assign a MAC address, and then use that for ethernet-controller.yaml and
in places such as here.

If you point me to the existing patches I can pick them up and address
whatever needs to be addressed to get them merged.

> Anyways, it's fine for now if you're not up for that.

So just remove the (supposedly deprecated) "address: true" for now and
then create an of_net MAC-address related schema and move things there
after that?

> 
> > +
> >    nvmem-cells:
> > +    minItems: 1
> >      items:
> >        - description: NVMEM cell with EEPROM
> > +      - description: NVMEM cell with the MAC address
> >  
> >    nvmem-cell-names:
> > +    minItems: 1
> >      items:
> >        - const: eeprom
> > +      - const: mac-address
> >  
> >    mediatek,eeprom-data:
> >      $ref: /schemas/types.yaml#/definitions/uint32-array
> > @@ -213,6 +229,29 @@ properties:
> >                      description:
> >                        Half-dBm power delta for different numbers of antennas
> >  
> > +patternProperties:
> > +  '^band@[0-2]+$':
> > +    type: object
> > +    additionalProperties: false
> > +    properties:
> > +      reg:
> > +        maxItems: 1
> > +
> > +      address: true
> > +      local-mac-address: true
> > +      mac-address: true
> > +
> > +      nvmem-cells:
> > +        description: NVMEM cell with the MAC address
> > +
> > +      nvmem-cell-names:
> > +        const: mac-address
> > +
> > +    required:
> > +      - reg
> > +
> > +    unevaluatedProperties: false
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -225,10 +264,13 @@ examples:
> >        #address-cells = <3>;
> >        #size-cells = <2>;
> >        wifi@0,0 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> >          compatible = "mediatek,mt76";
> >          reg = <0x0000 0 0 0 0>;
> >          ieee80211-freq-limit = <5000000 6000000>;
> > -        mediatek,mtd-eeprom = <&factory 0x8000>;
> > +        nvmem-cells = <&factory_eeprom>;
> > +        nvmem-cell-names = "eeprom";
> >          big-endian;
> >  
> >          led {
> > @@ -257,6 +299,20 @@ examples:
> >               };
> >            };
> >          };
> > +
> > +        band@0 {
> > +          /* 2.4 GHz */
> > +          reg = <0>;
> > +          nvmem-cells = <&macaddr 0x4>;
> > +          nvmem-cell-names = "mac-address";
> > +        };
> > +
> > +        band@1 {
> > +          /* 5 GHz */
> > +          reg = <1>;
> > +          nvmem-cells = <&macaddr 0xa>;
> > +          nvmem-cell-names = "mac-address";
> > +        };
> >        };
> >      };
> >  
> > -- 
> > 2.41.0
