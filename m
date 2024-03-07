Return-Path: <linux-kernel+bounces-95788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581058752AB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB971B27A99
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835FC12EBFB;
	Thu,  7 Mar 2024 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSj0lvPM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B870F1EB2B;
	Thu,  7 Mar 2024 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823740; cv=none; b=I6kYeA5oqwyvPSRacH4rEfw5wqGpf1ylcGUc1GiQvPu8CotGTYOYJ+IDvnnvWjeFVqiIojyjlMIfm+IJvYuNjdfVjz5zhNGZluk+TWA1cRU+p7hZWr4+LkiKaAMhfjU8wDSk4VlpdSj42S5KvURjWrraYhReFWA8ovvPn3ojN4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823740; c=relaxed/simple;
	bh=9VC7+O+rQNT+TdZmSwKKLWafyvYxPhE1RSprAvBcpNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD6t+GwfCERpS7hv/tLagWNLeZ4lZNsroe3zd12AWXdjzdkooxVk1qunEb+uI5SAEJhHq/eoGmHgVL44T4QsrzYygGHCrGq90JIHvIbYHTIOOKdBNqCvpEm8jDem6B+FEqahP01qkb6EhHvDDKPABFpQdtVQA6OvaysJofOO1YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSj0lvPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08927C433F1;
	Thu,  7 Mar 2024 15:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709823740;
	bh=9VC7+O+rQNT+TdZmSwKKLWafyvYxPhE1RSprAvBcpNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSj0lvPM6MEjOjcLC8/euq4cCKnVpqWKSJ9rTTEDwzqfpQvK0MMG+BYSbyWg+U4ZH
	 HQglHkvO1ReWA5rjiEybv9jkFRC1f7uhatJj2uwDDJKKHtmWefrQONkEmWwFvbiLYx
	 QiruNgdqjn1jYYfGfKpsvWWCF0COSVhZ2IeJnJBGlyEDrBSVcuW39PTEfuydg/jeYr
	 xVQBDFvGfjXO6I4f3rbjxV0R/o8RocpiJ3icmU8U5r65+vSnzSYg8lnzk+VAoXmGxI
	 T3Y0+EaeGao4ncSQqNS4haHtCx0vjFkTJGq2/YPEhBwjBl97lEqxtTsUN9XyQCFGsP
	 dMm5cMvPcJkDQ==
Date: Thu, 7 Mar 2024 09:02:18 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	devicetree@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
	Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org,
	Tero Kristo <kristo@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Pawel Laszczak <pawell@cadence.com>, linux-usb@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Peter Chen <peter.chen@kernel.org>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4 1/9] dt-bindings: usb: ti,j721e-usb: fix compatible
 list
Message-ID: <170982373727.2593865.16228010059152907870.robh@kernel.org>
References: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
 <20240307-j7200-usb-suspend-v4-1-5ec7615431f3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240307-j7200-usb-suspend-v4-1-5ec7615431f3@bootlin.com>


On Thu, 07 Mar 2024 10:55:02 +0100, Théo Lebrun wrote:
> Compatible can be A or B+A, not A or B or A+B. B got added afterwards,
> we want B+A not A+B. A=ti,j721e-usb and B=ti,am64-usb.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


