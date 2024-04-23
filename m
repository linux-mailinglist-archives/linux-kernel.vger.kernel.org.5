Return-Path: <linux-kernel+bounces-155418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 816398AEA1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228A21F229DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C8013CF83;
	Tue, 23 Apr 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D6lHXWPQ"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8AF13CF95
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884614; cv=none; b=Q/c57GRXdBx+5l5B5nfuf5gTw9CP93oyKwk7s7DEVrleSyZn2vtMYUnr52x+ClRc2zriZlnfHCZmCTZBl5ePdFfWdXihErguO0QQtity4KgudeEnubcGJ3dDXjRiMd9lpdKgZEBPczs/jRJ9PMv7Ql5dk2JU5I5TO3n8m2CxAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884614; c=relaxed/simple;
	bh=51vsz8FU2TrNqtjWCCIptttSlaJ0k772Dp64IyXLJeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pt5gGF7LnTIgPjh6V899Q6mlGpRjgh4m8bHtY2H7+vFMwW78LjcTru84WYUZ13ObTgsC7jrUOQGNTqjAZmLhKpgXSSO88M5GRyh+gmqZIbRtt01RUylJCZhlpqitbSXv1pBWq6xUnb9jpAbN67KNaovqK9NrENesCwFbhADbYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D6lHXWPQ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <96585fad-4d37-4020-a154-359ccf377906@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713884609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7TANHM5N3v2iElR/Xv0zvD1tTgG0PGeTr9gPXr/7U7k=;
	b=D6lHXWPQtgSvtHtv6p8phCCUjAPyRK7KFinWitycRCImX1LiSUPsEVl+6tIm2Y+txjyslX
	rSsGocLwVJsd0GMto2InAoqKZGQeWBxQx7LaCTxc/1n2vLCC0Mw+r3CXbc/GgdusLsArqa
	OS4qfKrLWmKOUV5RRa/GpLjo+jsOjxI=
Date: Tue, 23 Apr 2024 11:03:26 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] phy: zynqmp: Don't wait for PLL lock on nonzero PCIe
 lanes
To: Michal Simek <michal.simek@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Kishon Vijay Abraham I <kishon@kernel.org>
References: <20240422185803.3575319-1-sean.anderson@linux.dev>
 <20240422185803.3575319-3-sean.anderson@linux.dev>
 <691e50b7-1c1a-478a-815b-fb2a6bfdae8f@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <691e50b7-1c1a-478a-815b-fb2a6bfdae8f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/23/24 02:25, Michal Simek wrote:
> 
> 
> On 4/22/24 20:58, Sean Anderson wrote:
>> Similarly to DisplayPort, nonzero PCIe lanes never achieve PLL lock [1].
> 
> What is this [1] for?

I was originally going to have the comment below the fold in the commit
message as a footnote. I forgot to remove this after editing.

--Sean

