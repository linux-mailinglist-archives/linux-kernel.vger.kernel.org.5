Return-Path: <linux-kernel+bounces-21415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77906828ED4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235621F25183
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3E63DB8A;
	Tue,  9 Jan 2024 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmflrM0N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65D43DB80;
	Tue,  9 Jan 2024 21:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8CAC433F1;
	Tue,  9 Jan 2024 21:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704835324;
	bh=wc05eXzLAZHA4XJcdaJKh8o0upGkPyKt64W55IJkYEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmflrM0NA1BFhHvPv0ppqDOdQPA8QfEw+ATTo61a0bT63CqmeIadLGseGKpiQKXUH
	 tcm85TelA0P7Ol4NqYBMyKGaFcAM0XUpW8KBLM+wql3yBDLe+0dt3PXPITXD/o5Ciu
	 pnG1c/RvygLr+hiWm0yeErLXGMPi+K1BPD6y/dU3P16/rFACra5A0l26vzPmHqihO0
	 Tds9IUu2B6lPfIUeImzGZkpMmUXRikEvXVzDPAMN/ZTXXWxgi8zjLs8L3U1ymURDuj
	 DGPqZLtA2VBRmu5G88w689qC0VrTXRBFM418qFmwWvHaHfXZttt0kq9xZRhatqcRjS
	 v1H/UzcdB7Dcg==
Received: (nullmailer pid 3241456 invoked by uid 1000);
	Tue, 09 Jan 2024 21:22:02 -0000
Date: Tue, 9 Jan 2024 15:22:02 -0600
From: Rob Herring <robh@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com
Subject: Re: [PATCH] dt-bindings: mtd: Change the schema for nodename which
 includes "sram"
Message-ID: <20240109212202.GA3236341-robh@kernel.org>
References: <1704367382-29979-1-git-send-email-quic_zhenhuah@quicinc.com>
 <20240109184323.GA24189@hu-bjorande-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109184323.GA24189@hu-bjorande-lv.qualcomm.com>

On Tue, Jan 09, 2024 at 10:43:23AM -0800, Bjorn Andersson wrote:
> On Thu, Jan 04, 2024 at 07:23:02PM +0800, Zhenhua Huang wrote:
> > Node name which includes "sram" not only represents MTD devices, but also
> > lots of sram devices(eg, qcom,imem.yaml, rules in folder sram/*).
> > 
> > To avoid the conflicts, change the schema as:
> >  - if node name includes "sram", must select "compatible" to match
> > (I have listed all "comptible" string in mtd.yaml by searching
> > drivers/mtd/* to find applicable drivers)
> >  - if node name is nand/flash, use "nodename" to select.
> > 
> 
> You're right, it doesn't seem appropriate for the mtd binding to be
> selected for nodes intended to match e.g. the qcom,imem binding.
> 
> > Fixes: 7bdc671822e9 ("dt-bindings: mtd: physmap: Reuse the generic definitions")
> > Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> > ---
> > Hello,
> > 
> > Tested a few devicetree nodes, which confirms:
> > "qcom,imem.yaml" which in sram/ not matches with mtd.yaml anymore.
> > All nodes include string "sram" must have "compatible" which listed in
> > mtd.yaml to be matched.
> > 
> > Current I just modify the rule for "sram" as it is definitely conflicting with
> > rules in sram/*. I have not much backgrounds on nand/flash whether they may have
> > similar conflicts.
> > 
> >  Documentation/devicetree/bindings/mtd/mtd.yaml | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
> > index f322290..1704437 100644
> > --- a/Documentation/devicetree/bindings/mtd/mtd.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
> > @@ -10,10 +10,28 @@ maintainers:
> >    - Miquel Raynal <miquel.raynal@bootlin.com>
> >    - Richard Weinberger <richard@nod.at>
> >  
> > -properties:
> > -  $nodename:
> 
> The mtd binding is $ref'ed by other bindings, similar to how we do with
> other bindings of common properties.
> 
> So, I think the problem with mtd is that this ($nodename) turns into a
> "select" automatically, which causes this binding to match nodes by
> name, rather than just those $ref'ing it.
> 
> 
> We should be able to avoid the automatically created select from the
> $nodename, and rely on $ref, by just adding:
> 
> select: false

Yes.

Rob

