Return-Path: <linux-kernel+bounces-44888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDAB842890
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59E51F28EB5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064738613F;
	Tue, 30 Jan 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRElqKAs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DC86129
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630436; cv=none; b=nz9vsAn0IgZpOouh5ju9vpfZ6uxOEFrnMQSuMH6Bu6uNrXVRHhWUEI1kjsch1vBgJH32geaqiPVBflsZVIGmCRmh4u3nNwI/MZAyURC9LxlnW5MMdfIaX/cGcS5waM5kfdTj4nkfTCZidF7h6coGBDtGIYIuQblBCdeE6p6yxS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630436; c=relaxed/simple;
	bh=BQnJxt/6OS3FdXXe/qYzui9WFCJCw4J5sxKUD01/dHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZaQ+X90vP10sHwI2Zkof8nUF519buvBFmeaO0oHEzxZn1077xAkaJ2R5PNSqqamdJ1od8VwO6Ffr8Yjgs8qwgvtnyZcEvObXYR2SCBX+LMX3rqLnU3oFMRqYCEW1NBbN6THf6LhbjHshBVbeXQwnxWDH7LWCl1aLjytzX3Jpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRElqKAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06BAC433F1;
	Tue, 30 Jan 2024 16:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706630436;
	bh=BQnJxt/6OS3FdXXe/qYzui9WFCJCw4J5sxKUD01/dHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FRElqKAsjwznPAch1h3vrxzOFMRH5el1GKZjblMKFSM7PkGTgYZs70vvstZC7VjRh
	 s34ZZo9RYewygXrZfW2eYO7ogmY4BMWiTpoSGrW63oa4E+cGsUdhkaEV4gG3tck2zx
	 D7/aLnmWiwIVPgwvedvv1m+6XeV2wUUBG7lMNHg9wnRgOBYkUUJqI3PkEYGOu9s83U
	 amxgtZAq7RMQ7ccug70sW71+KgzclBQ34QBYTywE50nLfpSnDA21I5rhA4o1m3Df5H
	 SHr1h8pH0CJXVQbu4X5pVKiYog0EJrfsbhYhBjBhweqHEKuZ4fJjmskkNvKSQ7uJ1u
	 4rqpmnOQzTXPg==
Date: Tue, 30 Jan 2024 21:30:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, vinod.koul@intel.com,
	venkataprasad.potturu@amd.com,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 05/13] soundwire: amd: refactor soundwire pads enable
Message-ID: <ZbkdINFRDNr2KDWD@matsya>
References: <20240129055147.1493853-1-Vijendar.Mukunda@amd.com>
 <20240129055147.1493853-6-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129055147.1493853-6-Vijendar.Mukunda@amd.com>

On 29-01-24, 11:21, Vijendar Mukunda wrote:
> As sdw pads enable sequence is executed only once, invoke it from probe
> sequence.
> 
> Program required pads for both manager instances based on link_mask during
> probe sequence. This will avoid acquiring mutex lock.
> Remove unnecessary delay after programming ACP_SW_PAD_KEEPER_EN register.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

