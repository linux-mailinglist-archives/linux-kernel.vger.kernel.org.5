Return-Path: <linux-kernel+bounces-154939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAF98AE350
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531991F22019
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E92E76048;
	Tue, 23 Apr 2024 11:03:32 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD67569944;
	Tue, 23 Apr 2024 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870211; cv=none; b=ekzAxmeubfbNvAs5liulkrQKGpsUb1MD+ti3vYAFT0d3EUhrJTWAE14omPPOjRYjWaXAF2utOzCW2DZOLOW08Z+aQQ90s26M1zzlZW9aEXg15UcPV+w8xPRjYUo3UNthT4wTP1veOLtesQ94lidZZ0QVhNKGAztQ/pQnvoXHzX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870211; c=relaxed/simple;
	bh=2oE7qiEBTlPxS3EMJQmUOb6edRHb4fcMo/8D+mOUUF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zm5KAKSZ/iCOKmjIAYVnmGIRUs0ep5HSl53KnLuWQjZ4heTzSmZ9k4mA6PVO5pfElOwIwjzEKHK7W9Vl+VqgxBLTfCxbUTgaeeODqTDyLfkpyl3Lmv75Gbdkmx+sYjZcKnQGhXeBgbjPv40eJ4avqmPwYZQRpsia1QUqxhOGLBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d9e.versanet.de ([94.134.29.158] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rzDvd-0005B9-6h; Tue, 23 Apr 2024 13:03:13 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Michael Riesch <michael.riesch@wolfvision.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 devicetree <devicetree@vger.kernel.org>
Subject:
 Re: [PATCH] arm64: dts: rockchip: fix nodename warning on
 wolfvision-pf5-display
Date: Tue, 23 Apr 2024 13:03:12 +0200
Message-ID: <5189813.GXAFRqVoOG@diego>
In-Reply-To: <3f93ecb0-a649-4492-8798-a00de26236c8@wolfvision.net>
References:
 <20240423082941.2626102-1-heiko@sntech.de>
 <3f93ecb0-a649-4492-8798-a00de26236c8@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 23. April 2024, 11:39:26 CEST schrieb Michael Riesch:
> On 4/23/24 10:29, Heiko Stuebner wrote:
> > The dtbs check throws a warning about node naming with the recently
> > added pf5-display-overlay:
> > rockchip/rk3568-wolfvision-pf5-display.dtsi:113.6-121.3: Warning (graph_port): /fragment@4/__overlay__: graph port node name should be 'port'
> > 
> > This comes from the overlay just referencing the vp2-port-node via
> > its phandle and then adding an endpoint beneath it.
> > 
> > While this is possible something to handle inside the dtbs check,
> > carrying around the warning is not pretty, so change the description
> > to go around it.
> 
> What is the rationale behind that check? Describing a port in a SoC dtsi
> or board dts and using the reference in an overlay is quite convenient
> and above all concise.

I guess this is mainly a problem of the overlay thing.
Also it does not change with or without the "-@" option to dtc.

So I guess the main thing seems to be that overlays and the whole
checks don't seem to be well-trodden paths yet.


> Cc: device tree list
> > Starting from the vop_out phandle and then referencing the port
> > via its generic port@2 nodename will satisfy the port<->endpoint
> > naming dependency while keeping the same structure once the overlay
> > is applied.
> > 
> > Reported-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  .../rockchip/rk3568-wolfvision-pf5-display.dtsi    | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display.dtsi
> > index b22bb543ecbb..18c807c39e56 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display.dtsi
> > @@ -110,12 +110,14 @@ &pwm10 {
> >  	status = "okay";
> >  };
> >  
> > -&vp2 {
> > -	#address-cells = <1>;
> > -	#size-cells = <0>;
> > +&vop_out {
> > +	port@2 {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> >  
> > -	vp2_out_rgb: endpoint@ROCKCHIP_VOP2_EP_RGB0 {
> > -		reg = <ROCKCHIP_VOP2_EP_RGB0>;
> > -		remote-endpoint = <&panel_in_vp2>;
> > +		vp2_out_rgb: endpoint@ROCKCHIP_VOP2_EP_RGB0 {
> > +			reg = <ROCKCHIP_VOP2_EP_RGB0>;
> > +			remote-endpoint = <&panel_in_vp2>;
> > +		};
> >  	};
> >  };
> 
> With this patch applied the DTC warning "Warning (graph_port):
> /fragment@4/__overlay__: graph port node name should be 'port'"
> vanishes, but a different DTC warning "Warning (unit_address_vs_reg):
> /fragment@4/__overlay__/port@2: node has a unit name, but no reg or
> ranges property" appears. Can you reproduce this?
> 
> I tried to fix that by adding the reg property, but then DTC complained
> about "Warning (graph_port): /fragment@9/__overlay__/ports/port@0: graph
> node '#size-cells' is -1, must be 0"
> 
> Then, I added the #size-cells property to avoid this. However, DTC
> complained about this property not being necessary as there is only one
> port. I stopped at this point.
> 
> I would say the real question is how this hardware should look like in
> the device tree (overlay). Then, the compiler and/or build scripts can
> be adjusted to tolerate this.

When I checked, my "workaround" the check was silent, but I guess I
need to update the schema python module again and would get that
rabbit hole you went down.

But yes definitly. Especially with those follow up problems you
encountered, this makes it a problem to solve in the checker.

So the original layout is the best one to represent the endpoint and
I guess with the parent node being named "__overlay__" it should be
somewhat ok for the checker going "nah, it'll be fine - we're an overlay"



