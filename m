Return-Path: <linux-kernel+bounces-151080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A468C8AA8D4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20E2BB21234
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA60B3C47D;
	Fri, 19 Apr 2024 07:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IobtuWfw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFuRCP08"
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78105171AF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510183; cv=none; b=pkhbpw9kA4yNkbU2NFL42FI1Vvm0Mvl3E7Nyofi3VyuD30Jr55Jbu6WB+y67dwjevbywlber7Z878ls7+DM3ABewi6+mfkO+woQ9phvQGQI7SNsiLoHtxWk2n+D/TZLSr51fDGwxgTZGnjkwwS5YglTQTkK7yp5ogljsg3Ve3K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510183; c=relaxed/simple;
	bh=xGgMLDuz/rrktqSSCqnQhSwLJiqFpG+/qepJMM3iD1c=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=D5D9Tv/0irW+M9nuTjZSO6U5fKuNiaO28MQJAqMUPAP6gPC+iEDi1qpkf8TvG2GJxxFEvJfpAmo+d3Ixz7oWkYUbPnXFHj1iJGLm6ApoNBwikUKs+JPVF+DT9we31RnCpZZcWzSWIKy6sm0yxdEAwa9gkj9nYFy5xCFyO/mSiHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IobtuWfw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XFuRCP08; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id AE7951C00091;
	Fri, 19 Apr 2024 03:02:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 19 Apr 2024 03:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713510178; x=1713596578; bh=zaw9vbMVge
	SusjxjvLW2R0v983eLJic4pmYEHo2JBGE=; b=IobtuWfw2BGG7hCKF3eU5/zgnH
	9cceIs1ycAvI1XRiVE54sJ55A6dxV9339JpXhH09QnCJI+mZLKYXu1FEVStmDQ9Q
	E76l2mTjTqHjutK+5RLiEr8/x1P8At1pubpMm79VFAw8+ordhb19KFNzb2okDpCm
	VU/iY/Gfw5ptyE6ULTEgkIiejEwhdnGzokMHOcQsC9p6p7UZA4jc2mtKsWXPvElZ
	fgTVqMTOmqlv+eZCM0MPXTGxPGL0MH3Rozu5Wu2wK92/HzDox36ZzqsKPKpIPbPe
	T7xBGggxFnbegpzoJT33MRHSBi9sYYAhTUTvtT1VvUyI+DW0XIXKCUYO8Qww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713510178; x=1713596578; bh=zaw9vbMVgeSusjxjvLW2R0v983eL
	Jic4pmYEHo2JBGE=; b=XFuRCP0878g/Dgwz6Z6kkrnyrvWEJpEn+VAN3fEk7uzZ
	BRSpiU6P0hnN1NpBEtXJ2pyjFATcb+gX4+W8WaQH2vJmmp4CHWyLOawEnNeLN6h6
	PyY5zNcmKRl8wDuI/p38FIp6CKFVh/CQRsUpBoRIMrE5aeGusUA9+kjYhsUNI7rh
	j75+L6Eqb376YiXCUQPdrVPAcgqLi+yGnicD9wo2muzR/HuP+akTnki5GuRpMDTg
	Z+gAb6q6vKBUHt1AACZvfB0SGTYpjATSPYAFvTk/0O98n/QGBEKAf3Cwv0Q38hP9
	HqntTvzLqgZAgNourEoAcyg+O4LLoj+u+inaKga9Cw==
X-ME-Sender: <xms:IRciZl1Qcg455TzkfnUY3lyhc7K1w-ckgm-5xTEmyHJ-12RMHC3CUw>
    <xme:IRciZsHhkd7MIdaINBYx1yAD94pDa5Vwgl4mcZuICTaxMq64AcUserwd0nU2r9Ire
    sBX4N6yyTC1hKchWUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekuddguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:IRciZl7dPEiqqqVxbFI5IrsCu47YgnFmlL-fTrD7eHB9Xn1ocahltg>
    <xmx:IRciZi0hWExZLuREf-0iQMmsFUuixUItY_CMWm6Q5Ip8y8ZUbcHhIA>
    <xmx:IRciZoFSFIdP31yvc1PK-cNZUUoC8AfqBvPr_ioqZVxnWOg-5OvxfA>
    <xmx:IRciZj-jmTN4g4SeNaiUoPlwCEIBh3EU7feJ0kkBiJ0oqqUtsImAdg>
    <xmx:IhciZg-HqMdrDuRUDJXrEE2lEKjqmtN3sX-7vkbH6tXZvSX27XYxI5Wx>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 97E40B6008D; Fri, 19 Apr 2024 03:02:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4c448e78-11e8-497b-8e98-c227b9fa273e@app.fastmail.com>
In-Reply-To: <2bcdf17c-c640-7c87-88eb-f465f8c78263@ti.com>
References: <20240419060013.14909-1-r-gunasekaran@ti.com>
 <4d63cbaa-63d9-49fa-bbf0-b3bc62ebfb36@app.fastmail.com>
 <2bcdf17c-c640-7c87-88eb-f465f8c78263@ti.com>
Date: Fri, 19 Apr 2024 09:02:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ravi Gunasekaran" <r-gunasekaran@ti.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Nishanth Menon" <nm@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Tero Kristo" <kristo@kernel.org>
Cc: "Bjorn Andersson" <quic_bjorande@quicinc.com>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 srk@ti.com
Subject: Re: [PATCH] arm64: defconfig: Enable HSR driver
Content-Type: text/plain

On Fri, Apr 19, 2024, at 08:25, Ravi Gunasekaran wrote:
> On 4/19/24 11:32 AM, Arnd Bergmann wrote:
>> On Fri, Apr 19, 2024, at 08:00, Ravi Gunasekaran wrote:
>>> HSR is a redundancy protocol that can be realized with any
>>> two port ethernet controller.
>>>
>>> Many of TI's K3 SoCs support multi port ethernet controller.
>>> So enable HSR driver inorder to support this protocol on
>>> such SoCs.
>>>
>>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> 
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> 
>> The normal way this gets picked up into mainline is that you
>> send it to the K3 platform maintainers (added to Cc) and they
>> send me a pull request or forward the patch to soc@kernel.org.
>> 
>
> I usually do that for TI specific patches. This one seemed like a
> generic one as HSR protocol can be run on any multi port ethernet
> controller. So I wasn't sure about including TI maintainers. 
>
> But no harm in Cc'ing them. I will follow this advice for future
> patches.

Ah, I think I misread this as being much more hardware specific.
In a case like this, going through either a platform maintainer
or sending the patch directly to soc@kernel.org (with the usual
Ccs) is equally fine.

    Arnd

