Return-Path: <linux-kernel+bounces-117532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256AF88B4FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47278C211CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B916BFDD;
	Mon, 25 Mar 2024 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HVnyuDHn"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DAB3DABE3;
	Mon, 25 Mar 2024 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386083; cv=none; b=nXNEZ4lTf9I2gpcQ195cRmIUjEzBpmC0D774Fx6Hji+v7+nZW5sem+2UqSINuRGKG0yhtWzY55thWHynPkAx5rr/UYwB5kkRyeFuMMVQC8Q1Slsdl+0sqba3Egwv0MwsXYhPLPvMMETWaFO4VxcMQ+PVZBkIv/+PoBo0kPcoeRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386083; c=relaxed/simple;
	bh=J65GG3qBBSnWUcbMSJgEcFyXxA8qwEWeK8c+V32sdPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9Chsd0UrPvGzGH0czMXJFWksk34hyApTc8VzsDMGjHFWyWokSrfrEhmzW1ogfVT6czPl242BdGwdkKsJRDkTQARzXApSHL1uLlcuDRzt9a9il3JhGcndkqEj0Ooay4vSLyDS0bheUqh9ozl6bXj1f3evBa6JH8cwu/kvcyuOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HVnyuDHn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711386079;
	bh=J65GG3qBBSnWUcbMSJgEcFyXxA8qwEWeK8c+V32sdPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HVnyuDHnc+yeAIvf6f4BgaiUKTqwveBDuAHewSzDfehGNtTWgFvi9HHkYe4poG3d2
	 aMk3M2gVgAH0oOWxeJaYHmdmK4/xNzs9Z20IPWiq4V/mBtEMQx1D2RDT043Uq42W0M
	 fiBpin06pwJv0c7BSdI9LDnlr8vHFPJf8eO04IWMSM/z8iO/i1HqkgLfN5STnoXdH6
	 y+Zs2t6cv5vjfog2PSPj279F4ofNvIPbLalnwUYHavrI29Zp2NaOzQDu2tN+4vr5AY
	 nk/NOMZPm6H5R/GUxpzFejsuonOVIQY/EglTHfsmPycijd+FSXvVGjtwEBTVEQAVjO
	 sIayP/IXBvgbQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D353837820E1;
	Mon, 25 Mar 2024 17:01:18 +0000 (UTC)
Date: Mon, 25 Mar 2024 18:01:17 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v1 3/4] arm64: dts: rockchip: rk3588-rock5b: Enable GPU
Message-ID: <20240325180117.39d72749@collabora.com>
In-Reply-To: <a6uu7b3y7d4nirxbplc5cj4oeuyblx2grpvvldeovofhx3tnqc@dlse3vixhpws>
References: <20240325153850.189128-1-sebastian.reichel@collabora.com>
	<20240325153850.189128-4-sebastian.reichel@collabora.com>
	<20240325164441.1dab4018@collabora.com>
	<a6uu7b3y7d4nirxbplc5cj4oeuyblx2grpvvldeovofhx3tnqc@dlse3vixhpws>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 16:58:47 +0100
Sebastian Reichel <sebastian.reichel@collabora.com> wrote:

> Hi,
> 
> On Mon, Mar 25, 2024 at 04:44:41PM +0100, Boris Brezillon wrote:
> > On Mon, 25 Mar 2024 16:37:20 +0100
> > Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
> >   
> > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > 
> > > Enable the Mali GPU in the Rock 5B.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>  
> > 
> > I don't remember writing this patch ;-), maybe I screwed authorship at
> > some point, dunno.  
> 
> mh, I cherry-picked the DT patches from your branch before
> cleaning them up.

Yep,  I probably wrote this patch and asked someone else to test. I
couldn't find any traces of this patch where I'm not flagged as the
author in any of my local branches.

> 
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > > index 1fe8b2a0ed75..096ee7a98b89 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > > @@ -180,6 +180,11 @@ &cpu_l3 {
> > >  	cpu-supply = <&vdd_cpu_lit_s0>;
> > >  };
> > >  
> > > +&gpu {
> > > +	mali-supply = <&vdd_gpu_s0>;
> > > +	status = "okay";
> > > +};
> > > +
> > >  &i2c0 {
> > >  	pinctrl-names = "default";
> > >  	pinctrl-0 = <&i2c0m2_xfer>;
> > > @@ -470,6 +475,7 @@ rk806_dvs3_null: dvs3-null-pins {
> > >  
> > >  		regulators {
> > >  			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> > > +				regulator-always-on;  
> > 
> > Hm, should we mention why the regulator is always on here?  
> 
> In case of the EVB1 it's needed because the generic coupler driver
> cannot handle regulators that are not always on.

Ah, okay. I thought I added that for a different reason.

> I'm not sure why
> it was added for the Rock 5B. I will check if it works without that
> flag.

