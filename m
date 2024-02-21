Return-Path: <linux-kernel+bounces-74997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D6785E12C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D9E1F24989
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FED7FBBD;
	Wed, 21 Feb 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="L3Fwy4oo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A/G8dDHP"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9F16994A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529516; cv=none; b=Sw7AKB5NHjQ3A1qQ61S2yGItoF49z9m3w8EQqIXhNBbe8wdMxO0thIUrb5z3zTGH2gz2iCwDB0P7OHNc8Sftbws6pbed43A+Tbzn41WRl+1BjcimTqKxchL5OLgGvhDQqM1Jq8MGvlKyhy4zo/gyUmtj3FBTsEboSydsImBk/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529516; c=relaxed/simple;
	bh=IUMkpkpNENytfDwcvi3R5/n+NMLmSvrAO7/RQnV4HUE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PZX760ABbJn15lvLbXsCfn70P1AO9F0WZpkqXm/qORh4awRDddEed89x9A8akLFQMiLTIYeQmYob/rIm90vrd9cAlGpG704xWjrs6jrh1ku7X5qHf6digabqMtEdeKWKWQtO3WqHVEubejO0WeyJ9doye5wMIvx21W3mx0kfk0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=L3Fwy4oo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A/G8dDHP; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 770CE1380078;
	Wed, 21 Feb 2024 10:31:53 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 21 Feb 2024 10:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708529513; x=1708615913; bh=Wr4q51VXV1
	X1WQ/ImwDcofrGMRHvVclPbH/ftg+EtTQ=; b=L3Fwy4ooFQSnChZztiglz2l+U/
	bOh1DoxC5xgRIpf//ClHpKASf1+jf2QYSbOtUkE1u2tDPW1BtFdol+iW+96zzgl9
	PRgZqMyIryuAzn3ZQnyExGGOxnDwFAEfM0t0MMKXC7MbK5OE+YaCbz9hNqpkfxzs
	oiMtuOt6iBso3B7mGXXBvPQ3upscb4NK3GrUvC3q9DuqrFA3M0P0Z6i8aslbhSHj
	4MF9ZChLaHUW2Wsok2s62d+Snu595aSOfsxBZC/79F4lwdEWZQ0aiUZ73CUaQ+Tg
	H6KdFSQgE491yexbNlO2ribGs1g1OQ3jDzzKqwmiU43w48UyHlqAXwvTDfsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708529513; x=1708615913; bh=Wr4q51VXV1X1WQ/ImwDcofrGMRHv
	VclPbH/ftg+EtTQ=; b=A/G8dDHPhhRn09nyXxGwrnb/6/d7teku+n2wXBVXBQYz
	d0bfdoTIMXp21MKbJvhd5oZV953BcG8Fr7pL4gbMxoH69N2FcMujQBckqLV5aeoE
	NWn3JuFPKQWKaVfzpiJp1gWf6vpNmAvNowO8W6+gDBOGBu9TA2tABl9ruFV4bjQX
	4RUiQVHT4LQmnIOtWewFUp40TkuJKOl+TViuraMcpMC2etXDBMEwyk+DtEtBCToT
	0D+MaP+JFT+zmQyEuQ5GbAetXjofEkK+BxgRUNfKF4OWDjKi5QvD4azTic449hL0
	g1w9bdn8V3GrPaWHmW3mbiS5sweqLfBrPNJQP2LFqw==
X-ME-Sender: <xms:aBfWZXD0dXvjzV1jLTiGXTI8QRIaA-noUXU7Jc45wHe3EjnLpzVDmw>
    <xme:aBfWZdjPC0qDIDO5QPhLZND8fyw_z-dKfcB04MJVBgFVKpekCFSOFnYxXuQUhIb6E
    zAbOWMOibKSHglyH7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:aBfWZSnnQwYY5LcRbivuE9Fs3RnYToJlhPN9ZYlq5cVEFvXa9TQMVw>
    <xmx:aBfWZZyuR5nlgZsWUEDOTuEx8G0hHs0izK2dK1jo_IJZ98GZU70Nrw>
    <xmx:aBfWZcREeSacOFuQ2dMPryYrBNmruRmVfwd5sKBt-R0T3aOWdc1a-g>
    <xmx:aRfWZYri9F_67CKVXe39upgb6Z_jI8R_dqoKT5rO5W7GHMzOzrZx8A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 22515B6008D; Wed, 21 Feb 2024 10:31:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9f419e86-6e14-42a1-84e1-31cab62d8ea2@app.fastmail.com>
In-Reply-To: <20240221125928.3711050-1-javierm@redhat.com>
References: <20240221125928.3711050-1-javierm@redhat.com>
Date: Wed, 21 Feb 2024 16:31:29 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Javier Martinez Canillas" <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: "Maxime Ripard" <mripard@redhat.com>,
 "Erico Nunes" <nunes.erico@gmail.com>,
 "Enric Balletbo i Serra" <eballetbo@redhat.com>,
 "Brian Masney" <bmasney@redhat.com>,
 "Bjorn Andersson" <quic_bjorande@quicinc.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Konrad Dybcio" <konrad.dybcio@linaro.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Will Deacon" <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: defconfig: Enable zram, xfs and loading compressed FW
 support
Content-Type: text/plain

On Wed, Feb 21, 2024, at 13:59, Javier Martinez Canillas wrote:
> These options are needed by some Linux distributions (e.g: Fedora), so
> let's enable them to make it easier for developers using such distros.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>

> @@ -1595,6 +1599,7 @@ CONFIG_HTE_TEGRA194_TEST=m
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
> +CONFIG_XFS_FS=m
>  CONFIG_BTRFS_FS=m
>  CONFIG_BTRFS_FS_POSIX_ACL=y

Unfortunately this will increase build time noticeably, but
I agree it is the right thing to do.

Can you send it (with any other acks) to soc@kernel.org so
I can merge it from there?

        Arnd

