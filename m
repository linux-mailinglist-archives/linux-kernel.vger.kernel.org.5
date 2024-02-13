Return-Path: <linux-kernel+bounces-63589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0608531D8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B88283DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BF655E6D;
	Tue, 13 Feb 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OpSulyfP"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C5B200A9;
	Tue, 13 Feb 2024 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830854; cv=none; b=tsR3/QQC3Gv08gIujkcdbRzE7j/POGgrb6joN3AWyRDYZdWvmWGF02JCUWF8cDJGtlDKK84vqlKjwo6r2LhJjFdBPshHm34gB4tlb0YV+tJ4rFY95ScPGhzzicAKBdM9E/RJvOnryiPY1T8iUkevPkip2ZFSdKZk4L8eRhOiLQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830854; c=relaxed/simple;
	bh=GVfwibTK2AcJ+JgDKTu6n0xOvxOoa1ffq21TFqsOxls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pq3oJYNgsPepTVq9HbRv5atA1vatHoAJ8+aqLlq7olcbe5tC0it3Nt++crhARNnatFP9SOxlKg7WsSPyfTEs8kwurfPC9j1yGNtnNPFTOno13XMPLuNuwXezvDzDExxSsmMSlYv5xAHH8nkL7GRKqF74uEOY2mjxZ0ypmSL7CoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OpSulyfP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9oaXODuupT5BC/MIB3MV43QgTWz6N6vq/Qj6YnkKRmE=; b=OpSulyfPq9UjTf6N3SEC812nKs
	H0BUtTMy8+Acorj3pLGzP+l0Fk4VdjCfyXCtc04BJj07sBSyLsl2IeT46hElXqZKRI1pplcZcw9xq
	fP55U4jGTOguMX+QfzWEehPe7PFcaUHmehzqdZeJx+wJ450sE25HMSJmrQVbZ7KQzhmQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZsou-007gGZ-Uu; Tue, 13 Feb 2024 14:27:32 +0100
Date: Tue, 13 Feb 2024 14:27:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Robert Marko <robimarko@gmail.com>, andersson@kernel.org,
	konrad.dybcio@linaro.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: qca807x: move interface mode check to
 .config_init_once
Message-ID: <4210645b-4e03-4147-aa03-6fa55786f690@lunn.ch>
References: <20240212115043.1725918-1-robimarko@gmail.com>
 <c97d10fa-39c5-4e5e-93ce-1610635cb4d4@lunn.ch>
 <CAOX2RU6OwiymM_O_62VETgkBNUQP1TuOKJmm0D1ZUXBA7ZPJNA@mail.gmail.com>
 <7c5dd47c-26b9-4a12-af93-6139ae85e864@lunn.ch>
 <CAOX2RU79o_5KRJZUJKA_++rrFXn66oLU0jOVHZnA1wHf2kA7RA@mail.gmail.com>
 <65cb6864.5d0a0220.9cdaa.2449@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cb6864.5d0a0220.9cdaa.2449@mx.google.com>

> > Yes, that is correct and when SFP is plugged in it will be reconfigured
> > by the driver into combo mode as that port can actually be used for fiber and
> > copper at the same time by changing the priority.
> >
> 
> Hi Andrew, just to make sure this doesn't get confused.
> 
> There is a HW limitation here and it's described in Documentation:
> 
> - In QSGMII mode the SFP Cage can't be connected or mounted physically
>   as in this mode only 5 copper port can be connected, it would go
>   against the HW design of the chip. In this configuration the first 4
>   port are qsgmii and the 5th port is sgmii. (we enforce qsgmii on all
>   ports out of simplicity to make sure we have a sane configuration in
>   DT)
> 
> - In PSGMII mode the 5th port is always a combo port that can either be
>   a copper port or a fiber port (with SFP cage). To set the 5th port to
>   fiber mode, the mode has to be switched but the other 4 port are
>   always copper.
>   Also it's ok to set the initial PSGMII mode to 5 copper port as it
>   will be changed as soon as a SFP cage is connected. (can't happen to
>   have a device with both a copper port and a SFP cage connected to the
>   5th port, it's one or the other. Again it would go against the HW
>   design.
> 
> Hope it's clear now why the check was introduced and the HW limitation
> of it as with the previous message one might think the 5th port is
> totally separated and can go to his own mode (PSGMII or QSGMII)

Thanks for the explanation

I'm more used to it being like:

&eth2 {
        /* ethernet@34000 */
        bm,pool-long = <3>;
        bm,pool-short = <1>;
        buffer-manager = <&bm>;
        managed = "in-band-status";
        phys = <&comphy5 1>;
        phy-mode = "sgmii";
        sfp = <&sfp0>;
        status = "okay";
};

Here phy-mode is set to one of the modes the SFP will use, either
sgmii or 1000baseX. But i don't think it matters what value is used.

      Andrew

