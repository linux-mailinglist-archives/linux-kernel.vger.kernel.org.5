Return-Path: <linux-kernel+bounces-30396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 632C3831E30
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69FF1F2434F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE4A2C852;
	Thu, 18 Jan 2024 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b="DEmK8Grs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lG5a/Mr6"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF002C1BD;
	Thu, 18 Jan 2024 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597728; cv=none; b=d5hS2SO6qNq/RqxzUyjOX0zT3iPF0IhTxsgr24dTGwQ9fNmF7lIRTJRIHAlOz+ufkPrvXPV74RvNOaf13hZhpJlO419wI4H5mGsAhsv27yYwHoFtCs0y7+KZeNrdtg8Ads6wJRxvTS0c8CLhRa5odTEgJ7TSgNxQhnCRTarz75A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597728; c=relaxed/simple;
	bh=nun7CVrlbfMsxjr7/Oap+qbtMJz2N76j4now6j1Y7TY=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=Tr9QWjpV/LXKDIJtOt3a36CNRecCxc+kNpZWQ8oy7OSvEvO5EXJ0B/TQjdW43XQu2NI48KJaH/9kBYXM5QymnWnsPyIEJYBDvrTp6R5RJDhSIpzTBxUrS3Ys0JxFdxu+97XTQ1rxTJPF46AcA7hmZNatBwv8L+ETJETGcmbDnHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me; spf=pass smtp.mailfrom=beims.me; dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b=DEmK8Grs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lG5a/Mr6; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beims.me
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 464BA3200BA3;
	Thu, 18 Jan 2024 12:08:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 18 Jan 2024 12:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1705597723;
	 x=1705684123; bh=8sntM+596LygG3Vj4Vssmwad9I6YP2iwpKYRodCOP2M=; b=
	DEmK8GrsKvWom/HkuIBGzX+ksc6kHrpNMwYiRERmTu9hxOWf1bLIWnM51KscxF4s
	nhKSd44jJ2lGVBQNM6c3nbNUg3CXUpt8+d4xkMLBs6xR6HMNAUnTckFUueRh9YFi
	vYkW1XpeC3CC/0mF/QcA3PzZJ8d+fFEumUiO1zXzbWaRjWRiNWAlXeqxmmF/ThBd
	/yvaRbUHvDl3RO7JztQS4IcFQiB+N5YrEYbuWnBTv4DI8my/aI/9j1Z5DzFZePrk
	VkABx+Kz+ssAPFodSd8PUzM/fhegJwVupLnqCClevrTGPa3bokHYX08XKSPViBg6
	du8ZahU3O1xxvN1mCYcNhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705597723; x=
	1705684123; bh=8sntM+596LygG3Vj4Vssmwad9I6YP2iwpKYRodCOP2M=; b=l
	G5a/Mr6KzJQbFpfIN748dfEVxrvndCV+qwVuQELYEINSmyS41iV4IKU+U+usgEfP
	B1H2Lc/P5THzQo6YpkXNcIkrQiBhLzq67uLXNTl3pUjpnaKxhBYbQ+LyfwdluK2n
	/CR6TF59uqL7e8K8xOV4oo077e9e20F2JI78qHi1qgDFmmgt/BK6/lvHU1U3QivQ
	e6ZT0tQoWqovfGJ+yCSKjIaXhcfXD/qAkMPIxc5buVNlsmRkvRp1b/RHB2S1Pi9V
	WKQHLz4BS18MVnYblg2Gvh4JjDHbxcQMsPnrFUtuH6Ge8qgq33Ejsp0/FLfYP5qs
	x261f7PqOMv/+2Hvbiwdw==
X-ME-Sender: <xms:G1upZTAcK9LHaxtJXcBof93L13mguq4uMfWqMsyb5bK1UYkJ7c__fw>
    <xme:G1upZZg85BtzifW8azhb_YwmuMtEQR-23fd4ujMh22tq7nmJN-Aj5W4o-hKec1p49
    dM8fKEE8YtF0bk4gu4>
X-ME-Received: <xmr:G1upZem0HpJsP3rzQ7wj63Q8dlOK2aO0Bj73vqtZ7ymW_hvW-9OmAKCTd0UDC5Vx4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesth
    ejredttddvjeenucfhrhhomheptfgrfhgrvghluceuvghimhhsuceorhgrfhgrvghlsegs
    vghimhhsrdhmvgeqnecuggftrfgrthhtvghrnhepjeeijedvleegudevjeegledtveeife
    etjeelieeijeegiefhleelhedtgeduieeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheprhgrfhgrvghlsegsvghimhhsrdhmvg
X-ME-Proxy: <xmx:G1upZVzJS-f0AN5VkUP4UfOioCvHtbNs7phYJD4pmcHGKwOAFTNpXg>
    <xmx:G1upZYQoQTepoeooCNOOIxp509jO_oBAjwpUBMO_ReVy5chgdaEbrA>
    <xmx:G1upZYZ0u2PbbZwvrwLqeTg2YZdjHTiCbbNo_L3kYKKBuYLAGZIcug>
    <xmx:G1upZdK70_5ooonArVQgps3bzYSW2q96bWNXWLFcwvmuDn-Hk5rMgw>
Feedback-ID: idc214666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 12:08:41 -0500 (EST)
Message-ID: <97bb3869-3b82-4b64-87cd-9b63d4516649@beims.me>
Date: Thu, 18 Jan 2024 14:08:39 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host mlme
To: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org, kvalo@kernel.org,
 francesco@dolcini.it, tsung-hsien.hsieh@nxp.com
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
Content-Language: pt-BR
From: Rafael Beims <rafael@beims.me>
In-Reply-To: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/12/2023 00:21, David Lin wrote:

> This series add host based MLME support to the mwifiex driver, this
> enables WPA3 support in both client and AP mode.
> To enable WPA3, a firmware with corresponding V2 Key API support is
> required.
> The feature is currently only enabled on NXP IW416 (SD8978), and it
> was internally validated by the NXP QA team. Other NXP Wi-Fi chips
> supported in current mwifiex are not affected by this change.
>
> v8:
>     - Separate 6/12 from patch v7.
>       As it's a bug fix not part of host MLME feature.
>     - Rearrnage MLME feature into 2 patches:
>       a. Add host based MLME support for STA mode.
>       b. Add host based MLME support for AP mode.
>
> v7:
>     - Fix regression: Downlink throughput degraded by 70% in AP mode.
>     - Fix issue: On STAUT, kernel Oops occurs when there is no association
>       response from AP.
>     - Fix issue: On STAUT, if AP leaves abruptly and deauth is missing,
>       STA can't connect to AP anymore.
>     - Fix regression: STA can't connect to AP when host_mlme is disabled
>       (impact all chips).
>     - Address reviewer comments.
>
> v6:
>     - Correct mailing sequence.
>
> v5:
>     - Add host base MLME support to enable WPA3 functionalities for both
>       STA and AP mode.
>     - This feature (WPA3) required a firmware with corresponding Key API V2
>       support.
>     - QA validation and regression have been covered for IW416.
>     - This feature (WPA3) is currently enabled and verified only for IW416.
>     - Changelogs since patch V4:
>       a. Add WPA3 support for AP mode.
>       b. Bug fix: In WPA3 STA mode, deice gets disconnected from AP
>          when group rekey occurs.
>       c. Bug fix: STAUT doesn't send WMM IE in association request when
>          associate to a WMM-AP.
>
> v4:
>     - Refine code segment per review comment.
>     - Add API to check firmware encryption key command version when
>       host_mlme is enabled.
>
> v3:
>     - Cleanup commit message.
>
> v2:
>     - Fix checkpatch error (pwe[1] -> pwe[0]).
>     - Move module parameter 'host_mlme' to mwifiex_sdio_device structure.
>       Default only enable for IW416.
>     - Disable advertising NL80211_FEATURE_SAE if host_mlme is not enabled.
>
> David Lin (2):
>    wifi: mwifiex: add host mlme for client mode
>    wifi: mwifiex: add host mlme for AP mode
>
>   .../net/wireless/marvell/mwifiex/cfg80211.c   | 394 +++++++++++++++++-
>   drivers/net/wireless/marvell/mwifiex/cmdevt.c |  27 ++
>   drivers/net/wireless/marvell/mwifiex/decl.h   |  22 +
>   drivers/net/wireless/marvell/mwifiex/fw.h     |  54 +++
>   drivers/net/wireless/marvell/mwifiex/init.c   |   6 +
>   drivers/net/wireless/marvell/mwifiex/ioctl.h  |   5 +
>   drivers/net/wireless/marvell/mwifiex/join.c   |  66 ++-
>   drivers/net/wireless/marvell/mwifiex/main.c   |  54 +++
>   drivers/net/wireless/marvell/mwifiex/main.h   |  17 +
>   drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
>   drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
>   drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
>   .../wireless/marvell/mwifiex/sta_cmdresp.c    |   2 +
>   .../net/wireless/marvell/mwifiex/sta_event.c  |  36 +-
>   .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   3 +-
>   drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
>   .../net/wireless/marvell/mwifiex/uap_cmd.c    | 171 ++++++++
>   drivers/net/wireless/marvell/mwifiex/util.c   | 104 +++++
>   18 files changed, 974 insertions(+), 17 deletions(-)
>
>
> base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c

I applied the two commits of this series on top of v6.7 but 
unfortunately the AP is failing to start with the patches. I get this 
output from "hostapd -d" (running on a Verdin AM62 with IW416):

nl80211: kernel reports: Match already configured
nl80211: Register frame command failed (type=176): ret=-114 (Operation 
already in progress)
nl80211: Register frame match - hexdump(len=0): [NULL]

If I run the same hostapd on v6.7 without the patches, the AP is started 
with no issues.


Is there anything else that should be done in order to test this?


Rafael


