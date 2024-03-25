Return-Path: <linux-kernel+bounces-116828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F14788A450
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D112C4F97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534CD156991;
	Mon, 25 Mar 2024 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRu+jECm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CE112BF1C;
	Mon, 25 Mar 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362355; cv=none; b=JXE2dM/fOUGU6tBbNN78U09UYoKKyCCR4LeasZIfIFKvPpyvIbqlv1RaMEo6mgRPLEru4bzC0suAOFDDskTQB/KhQNeKBHKVxtqaUsRf9wvWeBdyQET7rZHNGOH8jXKKx8IxjcnHy0Pi1Xaw19brTs/0sSbW2pJyZrKh/NKH5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362355; c=relaxed/simple;
	bh=rgKrPMeIinA+Y9vEAPkdP4HEQqq6d2MoOEynV9a6Y7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJXuz6F/dYr0ZYszd8GwIXj9vJ0zVChBFtXhVdjusRABvF3SFXwG5V6UYJA+dLdrVnFn/Taw9hZvDgKbA1WRCHnQJ8wDZea74nDbDf9DDn7g6c2uSrZMYAq6nN0JLeo5uyvXwDPA/it9RNyY/9ObAmIDi9isY2mstS45q7B1Ecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRu+jECm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAD6C433C7;
	Mon, 25 Mar 2024 10:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711362354;
	bh=rgKrPMeIinA+Y9vEAPkdP4HEQqq6d2MoOEynV9a6Y7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qRu+jECmQwTaKa8Gb0BeCm7gDSyx2qjSYQiak14PNH8+PmPNjENAELcNDC7XoZw9S
	 YNjsmiJAAij5d5YfS7l7GiaD4fHfqLMMFbbkO03Ddix7mod4pHOPuIQY3qKIeCakRA
	 WM1bMxq1YVRUg4awMcV1HdKqX7cob6a29zSX88j28lLuI5IWuuEF72KlrHWhCZFN28
	 7gVmLnOYahCteB3YAFw7bd7Yri8RYI6TqB3/ZsNbZkHmexUaHZ9tACxbySScfyhRMF
	 cd3UjlUSnkh/iDREMlHHZrQA7XiwfVEz0KJxdKbfJQWSvoUHdzY+oJuHACHGsBO6u+
	 HTN9D7nUCRp/g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rohWj-0000000016n-1mKx;
	Mon, 25 Mar 2024 11:26:01 +0100
Date: Mon, 25 Mar 2024 11:26:01 +0100
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: fix mlme_link_id_dbg()
Message-ID: <ZgFROaFARFytQPMM@hovoldconsulting.com>
References: <20240325085948.26203-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325085948.26203-1-johan+linaro@kernel.org>

On Mon, Mar 25, 2024 at 09:59:48AM +0100, Johan Hovold wrote:
> Make sure that the new mlme_link_id_dbg() macro honours
> CONFIG_MAC80211_MLME_DEBUG as intended to avoid spamming the log with
> messages like:
> 
> 	wlan0: no EHT support, limiting to HE
> 	wlan0: determined local STA to be HE, BW limited to 160 MHz
> 	wlan0: determined AP xx:xx:xx:xx:xx:xx to be VHT
> 	wlan0: connecting with VHT mode, max bandwidth 160 MHz
> 
> Fixes: 310c8387c638 ("wifi: mac80211: clean up connection process")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Sorry about the resend. The original patch is here:

	https://lore.kernel.org/linux-wireless/20240324160559.18861-1-johan+linaro@kernel.org/

Lore appears to be acting up, but before I realised that I thought I'd
messed up my mail setup.

Johan

