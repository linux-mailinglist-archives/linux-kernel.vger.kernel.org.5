Return-Path: <linux-kernel+bounces-146849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA7D8A6BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D821F215FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B7312C462;
	Tue, 16 Apr 2024 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecCh7swT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7AB12882C;
	Tue, 16 Apr 2024 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272826; cv=none; b=mnkon/eKgj/jg1V/hC3P/+eZY3skYUOqQbYUxiW23KYoxFrHiJjsEh6P2VMm9ad14fPnZTf+Df/X1lTNj+NSWT5f6bgeiDg7OhZmP34J/BQxe/C7iZopQQxoDSgRpsrRjAL787ukfB3M/I3mjFUdnqoEm+6IPV0NqFOOMsKVBAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272826; c=relaxed/simple;
	bh=P/HPomrIVTOMU1OFfPX9hmOeQB5uLwyIa2hpgQujMeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEl3uCRFWickxZadSoorXJtkjKIJQ1iknf3qWd0yE/PN3Lasmwbn2tyFCdz8x0NJvvfayN8Kie374STfl1GkyGgfzq813gf9DP/borky7mtEOGbyAcJEOuRHBmqO1WnCKcMBR0ZWgGn+yZEno6HQycNUq+5UWgEGocKRi8iWFL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecCh7swT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846BDC113CE;
	Tue, 16 Apr 2024 13:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713272825;
	bh=P/HPomrIVTOMU1OFfPX9hmOeQB5uLwyIa2hpgQujMeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecCh7swTXz2FNCSrCWahCDgRZzR2S5fOM+BKjrcQeqhCKxjKIOXC8HTyhJMP/1Xxv
	 Dlk6Dx5qf6dBd1EYsJGjcJyUJsCtW3o1fUkXDwyGF4ldWQxC8cVs7NWPtZyEPHyjGv
	 xZyjl9CPjG545ktRwmHoEDKlS4X0/iNruvm9Ra9fKDwgUWozbVkbziemqxGBcpzedH
	 NAwXHZ73TCqN+/5V/rlspgwd770KttrbBla9S6V+iaHjFCtWhCeld+HswVGFMBtCBe
	 A84KJ4m8GAE2fd7XRX80EvgO0Vm/IRutwVBoLC27wtKCOS+3Opj7yhMBp0anyQ2xm5
	 obeZUoLScCdrw==
Date: Tue, 16 Apr 2024 08:07:03 -0500
From: Rob Herring <robh@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] dt-bindings: firmware: add i.MX95 SCMI Extension
 protocol
Message-ID: <20240416130703.GA1992329-robh@kernel.org>
References: <20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com>
 <20240412-imx95-bbm-misc-v2-v3-2-4380a4070980@nxp.com>
 <20240412133400.GA2282201-robh@kernel.org>
 <PA4PR04MB941680A7FCBCDF926417F6A388042@PA4PR04MB9416.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB941680A7FCBCDF926417F6A388042@PA4PR04MB9416.eurprd04.prod.outlook.com>

On Fri, Apr 12, 2024 at 01:50:37PM +0000, Peng Fan wrote:
> Hi Rob,
> 
> > Subject: Re: [PATCH v3 2/6] dt-bindings: firmware: add i.MX95 SCMI
> > Extension protocol
> > 
> > On Fri, Apr 12, 2024 at 06:47:08PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Add i.MX SCMI Extension protocols bindings for:
> > >  - Battery Backed Module(BBM) Protocol
> > >    This contains persistent storage (GPR), an RTC, and the ON/OFF button.
> > >    The protocol can also provide access to similar functions implemented via
> > >    external board components.
> > >  - MISC Protocol.
> > >    This includes controls that are misc settings/actions that must be exposed
> > >    from the SM to agents. They are device specific and are usually define to
> > >    access bit fields in various mix block control modules, IOMUX_GPR, and
> > other
> > >    GPR/CSR owned by the SM.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  .../devicetree/bindings/firmware/arm,scmi.yaml     | 21 +++++++++++++
> > >  .../bindings/firmware/nxp,imx95-scmi.yaml          | 36
> > ++++++++++++++++++++++
> > >  2 files changed, 57 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > index 93fb7d05f849..fa2cc910c485 100644
> > > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > @@ -247,6 +247,27 @@ properties:
> > >        reg:
> > >          const: 0x18
> > >
> > > +  protocol@81:
> > > +    $ref: '#/$defs/protocol-node'
> > > +    unevaluatedProperties: false
> > > +
> > > +    properties:
> > > +      reg:
> > > +        const: 0x81
> > > +
> > > +  protocol@84:
> > > +    type: object
> > > +    anyOf:
> > > +      - allOf:
> > > +          - $ref: /schemas/firmware/nxp,imx95-scmi.yaml
> > > +          - $ref: '#/$defs/protocol-node'
> > 
> > If you put the ref under the protocol node, then it's 1 schema file per protocol
> > per vendor. Also, we then have to list every possible protocol node here, and
> > every one listed here will be valid for every vendor.
> > What we discussed is putting the list of vendor protocol schemas at the top-
> > level here and then the vendor schemas can list out all the protocol nodes.
> > 
> > Also, move "$ref: '#/$defs/protocol-node'" to nxp,imx95-scmi.yaml.
> 
> In arm,scmi.yaml top level, add below:
> +anyOf:
> +  - $ref: /schemas/firmware/nxp,imx95-scmi.yaml
> 
> And also add a protocol node:
>   protocol@84:                                                                                      
>     $ref: '#/$defs/protocol-node'                                                                   
>                                                                                                     
>     properties:                                                                                     
>       reg:                                                                                          
>         const: 0x84
> But here I not add unevaludatedProperties = false; otherwise the vendor
> yaml new properties will not work.

Just drop 'protocol@84' entirely here and change the top-level 
additionalProperties to unevaluatedProperties.

> 
> In nxp,imx95-scmi.yaml:
> properties:                                                                                         
>   protocol@84:                                                                                      
>     $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'                                    
>     unevaluatedProperties: false                                                                    
>                                                                                                     
>     properties:                                                                                     
>       reg:                                                                                          
>         const: 0x84                                                                                 
>                                                                                                     
>       nxp,wakeup-sources:                                                                           
>         description:                                                                                
>           Each entry consists of 2 integers, represents the source and electric signal edge         
>         items:                                                                                      
>           items:                                                                                    
>             - description: the wakeup source                                                        
>             - description: the wakeup electric signal edge                                          

Constraints on the items values?

>         minItems: 1                                                                                 
>         maxItems: 32                                                                                
>         $ref: /schemas/types.yaml#/definitions/uint32-matrix                                        
>                                                                                                     
> additionalProperties: true
> 
> Are the upper looks good to you?

Yes, other than the one comment.

Rob

