Return-Path: <linux-kernel+bounces-41062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172F883EB0D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 05:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A11D1C224C8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 04:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FF513AE2;
	Sat, 27 Jan 2024 04:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S55sBXu6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0558311CAF;
	Sat, 27 Jan 2024 04:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706330665; cv=none; b=H4WHhdPODo+gd0QNh6fqdFl53RKDqrH0Bf1HOjxtKPZ63pSXqbh+RNZgjqhqj6TwlfTDwkck400THWzhED2rAC6YnbipZA5+9f/gdGJkQgOodRcQNZREsCIWfieLXhlp9IE9dILeKMMD0kb3Efc/AMlZX6/8lv3J6RVQN5NSce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706330665; c=relaxed/simple;
	bh=EEVrPSo++7IeRvcKVZvtophgR0qotpsnHk5/F/gDV48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1cC5vCoYOIsH0mFPMX19gj1R7rt/PgeUhckw+efpiz+pz7vm5wB3DWDQ5MSVLpKW3jIZZ1dWlOqKrZz2K6Ov5Kj0NULOO2XOJTxlHsJiA2IrgDkRyabcviz4h1MfpnZXSmJzTOpqVwUSQK++iQz+Ui92FHRXymlVMISB/Wf6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S55sBXu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168CBC433F1;
	Sat, 27 Jan 2024 04:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706330664;
	bh=EEVrPSo++7IeRvcKVZvtophgR0qotpsnHk5/F/gDV48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S55sBXu6TUvYGGufO1tVf8KqBEjEXUI2su1UTJtcQpFr9zgF6U1HVdAQ16Mj6BH3Y
	 tYmBQ0qQ6EtAJTCYYMSI26IvkMFyCHiWZXE/FQ74GaK3mWAIqgtFU82FcBtudv9l8m
	 xW9Mlr+ur7Gob7zP1S2ZEwZ4u7fWUYW1bLPnJeCxv7TKRL4nqr5xR/rIwhRyw77Nu9
	 pYrNBBHD5IXo0MCpxtm15jr2LaYDaerW+jg5A+JtoK9Y4xTRy264Su6SRO6ogGQ2Fz
	 zm10OvKmTJ8TxX0Flu5QqOTGzuvVpV5I9yuD98n5zM1aOaZmzhuccyWI05T8bctQTS
	 iXSKqcrtuZfqg==
Date: Fri, 26 Jan 2024 20:44:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Brett Creeley <brett.creeley@amd.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <shannon.nelson@amd.com>
Subject: Re: [PATCH v2 net-next 0/10] pds_core: Various improvements and AQ
 race condition cleanup
Message-ID: <20240126204423.47c20ef6@kernel.org>
In-Reply-To: <20240126174255.17052-1-brett.creeley@amd.com>
References: <20240126174255.17052-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 09:42:45 -0800 Brett Creeley wrote:
> This series includes the following changes:
> 
> There can be many users of the pds_core's adminq. This includes
> pds_core's uses and any clients that depend on it. When the pds_core
> device goes through a reset for any reason the adminq is freed
> and reconfigured. There are some gaps in the current implementation
> that will cause crashes during reset if any of the previously mentioned
> users of the adminq attempt to use it after it's been freed.
> 
> Issues around how resets are handled, specifically regarding the driver's
> error handlers.

Patches 1, 2 and 4 look like fixes. Is there any reason these are
targeting net-next? If someone deploys this device at scale rare
things will happen a lot..

