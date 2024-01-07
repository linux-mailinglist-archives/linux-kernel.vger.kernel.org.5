Return-Path: <linux-kernel+bounces-18994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A360982663C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E841F210EE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CC111CB3;
	Sun,  7 Jan 2024 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNJLO2vB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5168311720;
	Sun,  7 Jan 2024 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e43e48a16so7862345e9.2;
        Sun, 07 Jan 2024 13:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704664577; x=1705269377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yGQrMzQwX3MNC9JbNg8EA6tHHf/BKd21HsDSgP8Zeb0=;
        b=mNJLO2vBn8gBvbQU0ahZjasWKNze3VQjLUEk1cKtzkYTXk+ecPxgWUybF+6FZoTH/n
         IZew+akY1NHylMG6uviwf2g7HwamxckaTcH54FlUnyIJMh8hbWRFtnOWelyLW1O0VNLe
         Oc6e6ZhzjFVzKyE4Y5dlQjtIL/bHhNSMVM5yrvXn3n9CMz8vwr0pIyCT1oCFbpJZURJf
         7377aQtnto2RjMyqy1ScP44LMu16byMieYZPDQNs7Qh6aauSPc7DzbXmYRc3qDQHHih/
         6NUbl/Tm9rG17vCnFV7YlzhcTREHYkgd5VaC5+oKCf4cBcA/2AUGPcbfaNlIS8WUpBAK
         wj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704664577; x=1705269377;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGQrMzQwX3MNC9JbNg8EA6tHHf/BKd21HsDSgP8Zeb0=;
        b=e78TXIyzIeIvvqvFvnuxFpNtunkEqgSgKkEl+DVusdJUctIjYQUl+m7yuwlJ+OU+Q3
         ju2KkfPCOFb6BZLM6g4aeaggAfoZHrU3P8k98xy1ojt5RabYUeDYXwvw4SyJT44QgzEH
         F0nC+IFVg3vhRx37bVH9qqLs/kbPra1eApcV5DCaTGDuYy0zhv11r72TQcQKn2UAfJOY
         wRuSwXaJmdy8ZT4gvaTJyCGCNs2suFk3wMnwr8qzJeL2amsKmPJMB69h6fYwdYQf1o4m
         ZyPcDaUWX4OjmzjMPvMRX7faGgn7J5zRgX40BkVZKQ/L28Q0wSuAjbpUz2w6zMCWunsF
         TUHg==
X-Gm-Message-State: AOJu0Yzvv8MBoLSy7VSSQS0UrdlDi5Sk9beW51CwmoI/ekVsuy17nUvc
	rrE4tb3qHvuy2FIt8iBCkfY=
X-Google-Smtp-Source: AGHT+IFakyNMH8G9SPyri+zfxnohlZ+ZcaDcznmCmQmTQnvJni921zfAca1Y8hoHWTgEIqykmPKB5w==
X-Received: by 2002:a05:600c:5407:b0:40e:4358:cd60 with SMTP id he7-20020a05600c540700b0040e4358cd60mr859060wmb.21.1704664577192;
        Sun, 07 Jan 2024 13:56:17 -0800 (PST)
Received: from Ansuel-xps. (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.gmail.com with ESMTPSA id jb13-20020a05600c54ed00b0040d86e89abfsm8675217wmb.43.2024.01.07.13.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 13:56:16 -0800 (PST)
Message-ID: <659b1e00.050a0220.ba6d3.9ff3@mx.google.com>
X-Google-Original-Message-ID: <ZZsbbXz5MRUjR8MT@Ansuel-xps.>
Date: Sun, 7 Jan 2024 22:45:17 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Robert Marko <robert.marko@sartura.hr>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, Luo Jie <quic_luoj@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next PATCH RFC v3 1/8] dt-bindings: net: document ethernet
 PHY package nodes
References: <20231126015346.25208-1-ansuelsmth@gmail.com>
 <20231126015346.25208-2-ansuelsmth@gmail.com>
 <0926ea46-1ce4-4118-a04c-b6badc0b9e15@gmail.com>
 <659aedb1.df0a0220.35691.1853@mx.google.com>
 <0f4ec2ff-4ef7-4667-adef-d065cfbc0a91@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f4ec2ff-4ef7-4667-adef-d065cfbc0a91@gmail.com>

On Sun, Jan 07, 2024 at 11:49:12PM +0200, Sergey Ryazanov wrote:
> Hi Christian,
> 
> On 07.01.2024 20:30, Christian Marangi wrote:
> > On Sun, Jan 07, 2024 at 08:00:33PM +0200, Sergey Ryazanov wrote:
> > > On 26.11.2023 03:53, Christian Marangi wrote:
> > > > Document ethernet PHY package nodes used to describe PHY shipped in
> > > > bundle of 4-5 PHY. The special node describe a container of PHY that
> > > > share common properties. This is a generic schema and PHY package
> > > > should create specialized version with the required additional shared
> > > > properties.
> > > > 
> > > > Example are PHY package that have some regs only in one PHY of the
> > > > package and will affect every other PHY in the package, for example
> > > > related to PHY interface mode calibration or global PHY mode selection.
> > > > 
> > > > The PHY package node MUST declare the base address used by the PHY driver
> > > > for global configuration by calculating the offsets of the global PHY
> > > > based on the base address of the PHY package and declare the
> > > > "ethrnet-phy-package" compatible.
> > > > 
> > > > Each reg of the PHY defined in the PHY package node is absolute and will
> > > > reference the real address of the PHY on the bus.
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >    .../bindings/net/ethernet-phy-package.yaml    | 75 +++++++++++++++++++
> > > >    1 file changed, 75 insertions(+)
> > > >    create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > > > new file mode 100644
> > > > index 000000000000..244d4bc29164
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > > > @@ -0,0 +1,75 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/net/ethernet-phy-package.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Ethernet PHY Package Common Properties
> > > > +
> > > > +maintainers:
> > > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > > +
> > > > +description:
> > > > +  This schema describe PHY package as simple container for
> > > > +  a bundle of PHYs that share the same properties and
> > > > +  contains the PHYs of the package themself.
> > > > +
> > > > +  Each reg of the PHYs defined in the PHY package node is
> > > > +  absolute and describe the real address of the PHY on the bus.
> > > > +
> > > > +properties:
> > > > +  $nodename:
> > > > +    pattern: "^ethernet-phy-package(@[a-f0-9]+)?$"
> > > > +
> > > > +  compatible:
> > > > +    const: ethernet-phy-package
> > > > +
> > > > +  reg:
> > > > +    minimum: 0
> > > > +    maximum: 31
> > > > +    description:
> > > > +      The base ID number for the PHY package.
> > > > +      Commonly the ID of the first PHY in the PHY package.
> > > > +
> > > > +      Some PHY in the PHY package might be not defined but
> > > > +      still exist on the device (just not attached to anything).
> > > > +      The reg defined in the PHY package node might differ and
> > > > +      the related PHY might be not defined.
> > > > +
> > > > +  '#address-cells':
> > > > +    const: 1
> > > > +
> > > > +  '#size-cells':
> > > > +    const: 0
> > > > +
> > > > +patternProperties:
> > > > +  ^ethernet-phy(@[a-f0-9]+)?$:
> > > > +    $ref: ethernet-phy.yaml#
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +
> > > > +additionalProperties: true
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    mdio {
> > > > +        #address-cells = <1>;
> > > > +        #size-cells = <0>;
> > > > +
> > > > +        ethernet-phy-package@16 {
> > > > +            #address-cells = <1>;
> > > > +            #size-cells = <0>;
> > > > +            compatible = "ethernet-phy-package";
> > > > +            reg = <0x16>;
> > > > +
> > > > +            ethernet-phy@16 {
> > > > +              reg = <0x16>;
> > > > +            };
> > > > +
> > > > +            phy4: ethernet-phy@1a {
> > > > +              reg = <0x1a>;
> > > > +            };
> > > > +        };
> > > > +    };
> > > 
> > > So, we ended up on a design where we use the predefined compatible string
> > > 'ethernet-phy-package' to recognize a phy package inside the
> > > of_mdiobus_register() function. During the V1 discussion, Vladimir came up
> > > with the idea of 'ranges' property usage [1]. Can we use 'ranges' to
> > > recognize a phy package in of_mdiobus_register()? IMHO this will give us a
> > > clear DT solution. I mean 'ranges' clearly indicates that child nodes are in
> > > the same address range as the parent node. Also we can list all child
> > > addresses in 'reg' to mark them occupied.
> > > 
> > >    mdio {
> > >      ...
> > > 
> > >      ethernet-phy-package@16 {
> > >        compatible = "qcom,qca8075";
> > >        reg = <0x16>, <0x17>, <0x18>, <0x19>, <0x1a>;
> > >        ranges;
> > >        ...
> > > 
> > >        ethernet-phy@16 {
> > >          reg = <0x16>;
> > >        };
> > > 
> > >        ethernet-phy@1a {
> > >          reg = <0x1a>;
> > >        };
> > >      };
> > >    };
> > > 
> > > Did you find some issues with the 'ranges' conception?
> > 
> > Nope it's ok but it might pose some confusion with the idea that the
> > very first element MUST be THE STARTING ADDR of the PHY package. (people
> > might think that it's just the list of the PHYs in the package and
> > remove the hardware unconnected ones... but that would be fault of who
> > write the DT anyway.)
> 
> Make sense. I do not insist on addresses listing. Mainly I'm thinking of a
> proper way to show that child nodes are accessible directly on the parent
> bus, and introducing the special compatibility string, while we already have
> the 'ranges' property.
> 
> But it's good to know Rob's opinion on whether it is conceptually right to
> use 'ranges' here.
>

I like the ideas of ranges and I will try to propose it... Another idea
might be declare something like <0x16 0x4> where the additional cell
would declare the amount of address occupiaed by the package. But I
think your way is much better and less ""custom"". Yes would also love
some feedback from Rob about this.

> > > And I would like to ask you about another issue raised by Vladimir [1].
> > > These phy chips become SoC with all these built-in PHYs, PCSs, clocks,
> > > interrupt controllers, etc. Should we address this now? Or should we go with
> > > the proposed solution for now and postpone modeling of other peripherals
> > > until we get a real hardware, as Andrew suggested?
> > 
> > Honestly I would postpone untile we have a clear idea of what is
> > actually part of the PHY and what can be handled externally... Example
> > setting the clock in gcc, writing a specific driver...
> > 
> > It's a random idea but maybe most of the stuff required for that PHY is
> > just when it's connected to a switch... In that case it would all be
> > handled in the switch driver (tobe extended qca8k) and all these extra
> > stuff would be placed in that node instead of bloating phy nodes with
> > all kind of clk and other stuff.
> > 
> > This series still require 2 more series (at803x splint and cleanup) to be
> > actually proposed so we have some time to better define this.
> > 
> > What do you think?
> 
> Fair enough! Let's postpone until we really need it. I noticed this
> PHY-like-SoC discussion in the V1 comments, and it was not finished there
> neither addressed in the latest patch comment. So I asked just to be sure
> that we were finished with this. Thank you for the clarification.
> 
> --
> Sergey
> 

-- 
	Ansuel

