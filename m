Return-Path: <linux-kernel+bounces-110982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C00488866A6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73BF1C21CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5338E10971;
	Fri, 22 Mar 2024 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQtSKAmA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90830101C1;
	Fri, 22 Mar 2024 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711088198; cv=none; b=S9c3NpgtLamRoof7YPtY7bs11ctusMFsFfZMNK6yaI+cxNUhiX9lc0/n9k814BW8HZL+iFoXJHpFa1voJF3/7e+hyCJBdya/KpAZhssXPHwGmOJoU8175u9j+Tb3/x4BbNdRvUV2L4fW2B/S3AJuqHCKl6tCcVnlD8gBjnSw18E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711088198; c=relaxed/simple;
	bh=LrKxP3gm3uo3ToMeUXgziplcc6id5nTLO7X+pOXUayc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szdEdL9ZLS4jFACksX9t8Y7ngEf59ngxrCGeV+96xzMXkIuT+PetVgF5kb0IYd0zuUiBW3atgr6CZy9QFXIkpsutljWMWgxYTbkeV4Qo4iF2TpEfxbuDTv01s+jB92rHNC3xZFJaW5+CJSzbezD72/qm2WPQ29bDKmrf3XgdNiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQtSKAmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52942C43390;
	Fri, 22 Mar 2024 06:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711088198;
	bh=LrKxP3gm3uo3ToMeUXgziplcc6id5nTLO7X+pOXUayc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQtSKAmAk0cKGUFhHQ+JW6Wm6UGuBD6ww5PLgK2/IZtltY5+Dki2bf5/Wv9QLWMYN
	 XUikuAIsCQOQWag0bM3/jKybttyCf8q9dURrF8Z887Tp/+LunpV7Y2G0nF2GSgsXD5
	 6zvB3BXFfM2G9N+6SkKR1RZoChB3g3LNqEBOnWyAS5all7n+yD0DDgUwje9oXUavPD
	 kIU7HS3tVvKXVcki/fUEfvpE/QnmOzl4+cQWFoAW8kEa+0kAnUgPKw1VCo5aWZ2471
	 MKj1U4ngpZwjm0CzaetQ0iL4nWzXt/RWMOSRyz+604MyQoeG5p4Tbn7uC7HxYqqbcz
	 Nz3PNcznGYDaw==
Date: Fri, 22 Mar 2024 14:16:34 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mathieu.poirier@linaro.org, andersson@kernel.org,
	matthias.bgg@gmail.com, tinghan.shen@mediatek.com,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wenst@chromium.org,
	kernel@collabora.com
Subject: Re: [PATCH 1/2] remoteproc: mediatek: Make sure IPI buffer fits in
 L2TCM
Message-ID: <Zf0iQikMyerbWVMG@google.com>
References: <20240321084614.45253-1-angelogioacchino.delregno@collabora.com>
 <20240321084614.45253-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321084614.45253-2-angelogioacchino.delregno@collabora.com>

On Thu, Mar 21, 2024 at 09:46:13AM +0100, AngeloGioacchino Del Regno wrote:
> The IPI buffer location is read from the firmware that we load to the
> System Companion Processor, and it's not granted that both the SRAM
> (L2TCM) size that is defined in the devicetree node is large enough
> for that, and while this is especially true for multi-core SCP, it's
> still useful to check on single-core variants as well.
> 
> Failing to perform this check may make this driver perform R/W
> oeprations out of the L2TCM boundary, resulting (at best) in a
> kernel panic.
> 
> To fix that, check that the IPI buffer fits, otherwise return a
> failure and refuse to boot the relevant SCP core (or the SCP at
> all, if this is single core).
> 
> Fixes: 3efa0ea743b7 ("remoteproc/mediatek: read IPI buffer offset from FW")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

