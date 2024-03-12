Return-Path: <linux-kernel+bounces-100306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5061187955D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7351C21CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8832D7A71A;
	Tue, 12 Mar 2024 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="A5Tmndt2"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEBDA939;
	Tue, 12 Mar 2024 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710251494; cv=none; b=qXLkli9s/i9g7bipNBBXoLqat3s33q0IXwZu7oIcdjxV7D7ftiohBOPBcEWBKFONYyiKdn7+f+OSqLuPGBw43I2FAyGX1F/efzpzxiUXGah2g5zhDFTZvhvk7wJK/RmEWibtMHddSYd9oSTTx1ZueY1PM7HX4/Kt1mAKcVTsDbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710251494; c=relaxed/simple;
	bh=qUIQDwVkNhqHGtVr61movIKhOxPIBocHfP0erjlEQiM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPlGX6FoEvlrGneP/gSpyLNRpKx+EIdGiQ+ARJ/eYEpm0tSwS5fkkKhIYx3DRmHMLenHeREhOxDyw06u+aOpHpOKbMXmOWcHMhtuRr5jM2amPV9OMDQU8cTQfmJER+hqwCREsX5XTm2nNxBCklFXhQxha68J5BVM9lCBwrvT6SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=A5Tmndt2; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C5Whac023805;
	Tue, 12 Mar 2024 08:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=RjYWwCJuJ3X8Wvm
	1CI3hmDo7m+jseERS+0GlvROE8Kc=; b=A5Tmndt2aHzDT+2CZeMaFbQIqLTM3ju
	wPOk12nxAgL0n/s2uV2mLf4UloOHaS55BpszAd6quy0ZF0QqDLm+3LcoS8KIuHuI
	YZh3wgMlhzdTx2rIaEDuyluSPpj3kwlbS/VTsmtzZu4jSIQpfT+z0Bqd3eVEOYiI
	rHI24Ii/QMRahjpoZuEDJuWxmMYK5C1Z48UWm/j0D1UldEp7cmSF+W91+nR/KWww
	S+lF6QAd5t6FMpukdg701hMKxzFW1FfwDK/8bt6VT3Nsj1koHhPkQyayZoupzNJU
	Ts4gbzHGm5qnzJYIEu97OxibGiDwPpa/DLiRLs7J+eSmhuFEeFeNeRQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3wrp22u7jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 08:51:06 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 12 Mar
 2024 13:51:03 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Tue, 12 Mar 2024 13:51:03 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id A0755820241;
	Tue, 12 Mar 2024 13:51:03 +0000 (UTC)
Date: Tue, 12 Mar 2024 13:51:02 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
CC: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>,
        <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        "Mark
 Brown" <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai
	<tiwai@suse.com>
Subject: Re: [RFC PATCH v1] ASoC: wm8904: enable fll with fixed mclk
Message-ID: <ZfBdxrzX3EnPuGOn@ediswmail9.ad.cirrus.com>
References: <20240308155831.141229-1-andrejs.cainikovs@gmail.com>
 <Ze7smWSeoCVIcxIo@ediswmail9.ad.cirrus.com>
 <ZfBG9IMFEjjIdgdi@toradex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZfBG9IMFEjjIdgdi@toradex.com>
X-Proofpoint-GUID: iZDarsVptUBAMHR0ZgPVsN7Fsdut8fUs
X-Proofpoint-ORIG-GUID: iZDarsVptUBAMHR0ZgPVsN7Fsdut8fUs
X-Proofpoint-Spam-Reason: safe

On Tue, Mar 12, 2024 at 01:13:40PM +0100, Andrejs Cainikovs wrote:
> On Mon, Mar 11, 2024 at 11:35:53AM +0000, Charles Keepax wrote:
> > On Fri, Mar 08, 2024 at 04:58:31PM +0100, Andrejs Cainikovs wrote:
> > > From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> With or without mclk-fs wm8904_set_sysclk() is called always during probe,
> with following parameters:
> 
> clk_id = 0
> dir = 0
> freq = 25000000
> mclk_freq = 25000000
> 
> When mclk-fs is set, wm8904_set_sysclk() is also called before each
> playback [1]. In case of 44.1kHz:
> 
> clk_id = 0
> dir = 0
> freq = 11289600
> mclk_freq = 11235955
> 
> In both scenarios, clk_id is always WM8904_CLK_AUTO.

Ah, ok I see what I was missing here. simple_card_utils calls
clk_set_rate if you specify mclk_fs. Which you don't want in this
case. My gut reaction is that really the problem here is the machine
driver doesn't support the clocking setup you have.

Having a quick look through the simple card stuff can you remove:

	clocks = <&audio_refclk1>;

From the machine driver DT stuff, and add mclk-fs. I think that
should cause the simple card to call the codec dai_set_sysclk
but without ever touching the audio_refclk. A small change in
simple_util_parse_clk might also be needed to allow it to return
without finding a clock. Which feels like a much simpler and less
scary change.

My only slight reservation is the automatic clocking thing only
really exists as a hack to support simple card anyway. But overal
I think it might be better to try to move the direction of travel
more to adding support for the clocking systems that exist into
simple-card rather than tweaking the codec driver to work around
it.

Thanks,
Charles

