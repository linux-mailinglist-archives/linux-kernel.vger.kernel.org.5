Return-Path: <linux-kernel+bounces-30043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDB883183D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B90289606
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2152377A;
	Thu, 18 Jan 2024 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzcIPV/g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E208822068;
	Thu, 18 Jan 2024 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576466; cv=none; b=YDb8ddgz6PTZKWSseTWw7doRHEfveldetryEKyK1/TGVAhn1ZiRWvfSP003NJWX9RE4m8/bYxe+pHhPw0MJ8xgyuze3o7ecZgVMwFkQLHPvv/xbOYEYkheDkAF3LCtjvfA1rVuq5mMCNX4lgbWugKSNC2Sq+yML4sZNDrfkQhv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576466; c=relaxed/simple;
	bh=BkzJYAYQgD2+iSXa+2q/zYdRmPKlL7wyGiHR8aVNN4g=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:References:Date:
	 In-Reply-To:Message-ID:User-Agent:MIME-Version:Content-Type; b=qxpZSIUyPM9qT8EN/Uuf/FS12MsAP0+RmmZ/F1oX4b5wqYmeJ9cmgDYaVOSymlhOwZO79YTimBBREj9RXCoKtq4SYLnM7WzWh+y2fy70nNl4JozN6GId6oRGmoOqP9QgowVhz9WC1xMZ///hVvZV+0f3LNppL4m0UeoPy4ePHOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzcIPV/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250BCC433F1;
	Thu, 18 Jan 2024 11:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705576465;
	bh=BkzJYAYQgD2+iSXa+2q/zYdRmPKlL7wyGiHR8aVNN4g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OzcIPV/gWl6CabGnDEMnseP1mKLqiGDBskbxq0RxpBZvS0ZCi7NXpzAfovpNFOn5z
	 PlgFwuOxYc5HCboVmBC9a4sbslrzg2Byedi7cvYX413GkmDC1GyvtkY7kgFSMQZoKq
	 qNYeJO7fOj6J6xRuV8Q61qWUCpkCGBSvvI+gxNzYUn0Lzp9A7X9MdpsNA21fxHpBm6
	 J3lHLDvutO+OJ2qbIAQ6YL1rHZPi5wDmYSEtZkxVpZZCHTuF3UxCnsapRYkbzOuISf
	 m54biY+Qc+5HaDB0gnvQZDveAC7cdmudFriG9XH5X9q0EKatpqsGk6R0OYPyUds/6C
	 gUsnEfVSdgXPQ==
From: Kalle Valo <kvalo@kernel.org>
To: "Nicolas Escande" <nico.escande@gmail.com>
Cc: "Jeff Johnson" <quic_jjohnson@quicinc.com>,
  <linux-wireless@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <ath11k@lists.infradead.org>
Subject: Re: [PATCH] wifi: ath11k: fix layout of scan_flags in struct
 scan_req_params
References: <20231127180559.1696041-1-nico.escande@gmail.com>
	<bdcdbd06-e9bd-4a92-b27b-d94b2d8fb52d@quicinc.com>
	<CX9YPUDTAT1N.23DMRB5O9FEAO@gmail.com>
	<20c7a367-2243-4e13-b023-9999dc6c6790@quicinc.com>
	<CXC03GYAN4VN.2PQ88Q1S7IL6H@gmail.com>
	<CYFAYRP5MWTZ.Q272WWLLE7MW@gmail.com>
Date: Thu, 18 Jan 2024 13:14:22 +0200
In-Reply-To: <CYFAYRP5MWTZ.Q272WWLLE7MW@gmail.com> (Nicolas Escande's message
	of "Mon, 15 Jan 2024 14:09:28 +0100")
Message-ID: <871qae51wx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Nicolas Escande" <nico.escande@gmail.com> writes:

> On Thu Nov 30, 2023 at 9:24 AM CET, Nicolas Escande wrote:
>> On Tue Nov 28, 2023 at 1:57 AM CET, Jeff Johnson wrote:
>> > On 11/27/2023 2:54 PM, Nicolas Escande wrote:
>> [...]
>> > > So either we should not use WMI_SCAN_XXX with scan_req_params.scan_flags ever
>> > > and only use the bitfield to set scan parameters or if we use WMI_SCAN_XXX with
>> > > scan_req_params.scan_flags they need to match the corresponding bitfield.
>> >
>> > IMO the correct thing to do is to remove the unions from that struct and
>> > only leave behind the bitfields and not use the WMI_SCAN_XXX masks
>> > except when filling the firmware structure.
>> >
>> > But don't spin an update to your patches until Kalle has a chance to
>> > give his opinion. I'm new to maintaining these drivers and Kalle may
>> > have a different opinion on this.
>> >
>> > /jeff
>>
>> No problem, I'll wait for Kalle's input on this before doing anything.
>> As soon as we decide which way is the right way, I'll work on this. I only care
>> that this gets resolved.
>
> Hi Kalle/Jeff,
>
> Any new input on this so I can move forward on fixing this ?

Sorry, too many patches...

> Otherwise I think I'll end up going on with Jeff's proposal of only using the
> bitfield for intra driver representation & then converting the bitfields to
> their corresponding WMI_SCAN_XXX when transmiting the req to the hw with wmi.

Yeah, I only took a quick glimpse but Jeff's proposal does make sense.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

