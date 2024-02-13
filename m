Return-Path: <linux-kernel+bounces-64027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE4885391C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CF61F260EF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFB860ED2;
	Tue, 13 Feb 2024 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xgifEv1b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71F860EC1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846889; cv=none; b=asiMQ/6y1Aj0eWGxaWnV7dncZ3YScuLGjeR/kj6/251QmFZ8mAqD88cuPfn865gsvOR/fgKXahyR6sWp6lkknKGsV8i899AMjdnzh6WjxBB44LI0pnUajurNYkmlGZ+VitxlQho3XHO/NQznPx4UG1ISqek8L16OxmyQeex9sUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846889; c=relaxed/simple;
	bh=Fpat39sCKC0M/T0N7Xrv5bT2WB5EUj8Z2VGFq0l5oCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkjAdlnMxFVETb7Srj1pFQEt8RncUvTouy9piKFEVwIUPiL62cw/bO0pFyykHrSSUplbhLUbbewGHlO1wc1m1ArmeWpqSdIXGZsNlotHLp7UM9e//i8jwFGa5CN2iwIuUF+8X9KsY1f625BsDke1x12x/eBfrcg6Sf/3ZTDqy+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xgifEv1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC359C433F1;
	Tue, 13 Feb 2024 17:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707846889;
	bh=Fpat39sCKC0M/T0N7Xrv5bT2WB5EUj8Z2VGFq0l5oCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xgifEv1bwXhoJlsctQxA8caAXj3U4+DtQHuKl0JYKmd/aTZz2EvuJ3k8HCoW9G7Bz
	 /h6aM8+2qOzCAHxef1tzTqxSmegsBM8wEhnZxPZkpV6w0i0blKHabVQVCUDQvOdO2D
	 jPLgAwanDvHOt29LWBfF00E0Lmjf0dVRO9odef4E=
Date: Tue, 13 Feb 2024 18:29:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slimbus: core: make slimbus_bus const
Message-ID: <2024021326-swimwear-onshore-e3f4@gregkh>
References: <20240213-bus_cleanup-slimbus-v1-1-34f06d82de6e@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-slimbus-v1-1-34f06d82de6e@marliere.net>

On Tue, Feb 13, 2024 at 11:40:35AM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the slimbus_bus variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

