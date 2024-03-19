Return-Path: <linux-kernel+bounces-107389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D025E87FBDA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82146283784
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A614F8A9;
	Tue, 19 Mar 2024 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+gA29L5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20603257D;
	Tue, 19 Mar 2024 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710844440; cv=none; b=rt180VtcJ9vx95caRBbeYxs1iG6IYXegxHZf2TjVriDLIdxPOmnfgcz2khmgX/muiwtiNXb36k+YqAX0QOWJPxqp/ba/I9SJc9Q6pdijMOpV4LaL8q8XAmspuaF0rYKnMU9A047wa2SDbkqJGkjPAzktR9Cc6efJ8tTQLV+opUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710844440; c=relaxed/simple;
	bh=r0OjygzfBeFACEPBphQJgceCg2rQsdAGACWMzfN0J7E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=siAe/Dcw42bj4xtsd5Hn+ApWcACP48L58aUNvL8P22aXKTK8BXdCGTSifKmWB5sR0JDLctJMRQOXnnvi5zY+u7cF63edgvv+HLp+quIYengFEhSwNQ+2yZom24X4Y1t88QZ6/D47LWoFzLTu23on559cyCAe/g5+GBLLjMHKsDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+gA29L5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02EAC433C7;
	Tue, 19 Mar 2024 10:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710844439;
	bh=r0OjygzfBeFACEPBphQJgceCg2rQsdAGACWMzfN0J7E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=j+gA29L5bIWpUaZ3Y5w2nuifg6IQ7MC1PsAWxK7dY6e4moz3aOts++ygaJ48dmMxF
	 GAsPFRLWste4qxxru+BG1Sd3MQzammvCqMz1qJogQ3a60qbTHpGdJVLP7ksRf04LiI
	 2zmmIeLGc4rvsCmlsG1AZshM6O717efpf1lSVqIcz6/uixB5q3PZSdWsabM0I+QGKJ
	 bgsPVxyiO1NPyUJmK1sdlI8IWE7WAhO8u0mqqpDFygCqOz2Q1xhbewtYWmJSnM+jTq
	 0R2bK2liztzu7YWyYh/mzD4F4vfpzcXW0DxGTEi8FYhhEN1TvBOCBOmTkorCqmEySA
	 6JVzLJNggtyww==
From: Kalle Valo <kvalo@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,  David Lin
 <yu-hao.lin@nxp.com>,  tsung-hsien.hsieh@nxp.com,
  rafael.beims@toradex.com,  Francesco Dolcini
 <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host mlme
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
	<20240315094927.GA6624@francesco-nb> <ZfTg1xKT-Mxmpf9w@google.com>
	<20240318112830.GA9565@francesco-nb>
Date: Tue, 19 Mar 2024 12:33:55 +0200
In-Reply-To: <20240318112830.GA9565@francesco-nb> (Francesco Dolcini's message
	of "Mon, 18 Mar 2024 12:28:30 +0100")
Message-ID: <87r0g6bje4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Francesco Dolcini <francesco@dolcini.it> writes:

> On Fri, Mar 15, 2024 at 04:59:19PM -0700, Brian Norris wrote:
>> On Fri, Mar 15, 2024 at 10:49:27AM +0100, Francesco Dolcini wrote:
>> > On Wed, Mar 06, 2024 at 10:00:51AM +0800, David Lin wrote:
>> > > This series add host based MLME support to the mwifiex driver, this
>> > > enables WPA3 support in both client and AP mode.
>> > 
>> > What's your plan for this series? I know you raised some concern when
>> > this started months ago and I'd love to know if there is something that
>> > would need to be addressed to move forward here.
>> 
>> My plan was (especially given the "Odd Fixes" status in MAINTAINERS) to
>> wait until a 2nd party was happy with things here. From my cursory
>> following of things, that has now occurred -- thanks for all the review
>> Francesco.
>
> Brian/Kalle, would be ok for you to add myself as reviewer for mwifiex?
> The patch flow on the driver is pretty limited, but I care about it
> and I am happy to help out if needed (and I have some hardware available
> for testing).
>
> If you agree I'll send a patch to the MAINTAINERS file.

At least from my point of view that sounds like a good idea, you have
provided good review comments for this driver. But let's wait what Brian
says.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

