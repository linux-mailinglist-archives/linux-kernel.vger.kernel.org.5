Return-Path: <linux-kernel+bounces-65365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2BB854BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74AB1C2142B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA535B1FB;
	Wed, 14 Feb 2024 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJrlBLRb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944CD5577F;
	Wed, 14 Feb 2024 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922343; cv=none; b=Egp1FS2m9NsU3kjTgdYfE6u7Lxi/9sqPCdiewhSRPj7zwoH2G7WuT0mdJsmT4BEdEPpDYO9CDHOm8tMRF2V2zzydu/Wd9ZrdAV9hPui0qS+nU1VqrEX+V79hM7Lt8MG53dSjxN4dfB5HQBphN8lannDkSgYMI85MJK5oDMGSZkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922343; c=relaxed/simple;
	bh=AUsGwVxdcSJ4yflKQ95EUqOTrDxALmQmVMERNZYi0EI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKtkLB9Dabu7zkyqi14g7jisUqK3C8YWZMVivKhh4zXS/f3BzKqcEeIt9GwSmF9DFPAui2ekL8EyTQIcTTovhf6jL01+h6YpjhOLtopgmw92SRdIc5oPtcVUVODA01vzhEwzWJYewoBzQROGI93hWl3regr0YvYnhgcBbVwbCuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJrlBLRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA48C433F1;
	Wed, 14 Feb 2024 14:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707922343;
	bh=AUsGwVxdcSJ4yflKQ95EUqOTrDxALmQmVMERNZYi0EI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aJrlBLRbWut0IVot0ZcO6fS2BWbCIuIN0wXOrOa0awHRjwQzMpfPSXdk8gzOnwLuy
	 xIyQKy5HrIydgYNI+QPPa0l3qRWJsE7Umva200frg1A3JRTMByEZufSBNHP2VYad4H
	 qxcniRqi3/LoZqmZkxoEgNBwpUNSTl7vCJZr6vQWWu5oC0FpYBA6bSbOuA01Kio+Sa
	 zMScesDjPfZ4SdC7U0jmRjhd3O89QPtsjUqw/3JDPbkaiO8aAGfa04ofeC8BLLiM5M
	 VVTVzskbvEHYYXpyzZnjtscgTFRe4YxYrx2oo6NYLNHDdnYWiuHhyIDcYYUTfP0L/p
	 TqsYz5eDuQ74Q==
Date: Wed, 14 Feb 2024 06:52:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Ernberg <john.ernberg@actia.se>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, "Clark
 Wang" <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: fec: Always call fec_restart() in resume
 path
Message-ID: <20240214065221.26d71ed0@kernel.org>
In-Reply-To: <5aba2c2b-b712-4827-acb2-d586508a3bd6@actia.se>
References: <20240212105010.2258421-1-john.ernberg@actia.se>
	<20240213184427.5af2d7eb@kernel.org>
	<5aba2c2b-b712-4827-acb2-d586508a3bd6@actia.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 08:27:02 +0000 John Ernberg wrote:
> You are correct, we thought so too at [1], but bisection is really hard 
> because we need a whole bunch of patches on top to even boot the system 
> (imx8qxp specific stuff in the NXP vendor tree that's difficult to 
> rebase), we left it a bit open ended.
> 
> Over the course of the weekend I lost all confidence in my bisection 
> after being confident for 4-5 days, because the more I thought about it 
> the less it made sense for that commit to be the culprit.
> 
> I should probably have both followed up on that mail with that, and been 
> clearer here. I apologize for failing that.

Is it perhaps possible that upstream 5.10 also didn't work?
I'm not saying the change itself is incorrect, indeed there 
is fec_restart() on probe and open paths, as you say.
Did you try reverting as many of the changes that happened
in the meantime as possible (instead of bisection)?

The other question is whether we need to enable any of the
clocks or runtime resume before calling fec_restart()?

