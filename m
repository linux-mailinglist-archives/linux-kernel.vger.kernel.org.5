Return-Path: <linux-kernel+bounces-59209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD0984F343
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5678CB25B93
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E997C69954;
	Fri,  9 Feb 2024 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D4Eu92ap"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172AB664C3;
	Fri,  9 Feb 2024 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474129; cv=none; b=Iho9DokJYNdDfdhgVvaymmXE8bwgMeVHAteWRgQFMoZPAvf6mIZm14TpAaD1cfg0Gcf7+S52+4Zf+u5gy92+dh5Si5gpf/KcT5ImKRa1/bgFdO6F2do/KcsorjwgrWMT4oLZiBiKjf61H5tJRMuzgGVPmsvNM1nxdmADPrgrkOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474129; c=relaxed/simple;
	bh=S+SbbCAcBABXGFkQer3pBk4+WoT2/puAu+LdvJ7pTj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOuKORMt2sXSQRHJnrpbx3lTLOVRfAYEzY/nFukx8AnkSuaqRCay7BoHRltoSLGILHMJ/pSXonnZNap13KLX2bfl/AiurRp4+nmnURsxnj1Q2/2IS38TPYsF5cfIHrDeqOh3G0UPGOT75gBrhNflc9QjhSak0/zEzqEqslHnqeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D4Eu92ap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5900CC433C7;
	Fri,  9 Feb 2024 10:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707474128;
	bh=S+SbbCAcBABXGFkQer3pBk4+WoT2/puAu+LdvJ7pTj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4Eu92apEOQ82YPVTi+YMOU16LsZpp6imJXtcAx1iRLCUVlkKfxhEzCh+O5k0BwIo
	 sWGTV9g/y441/l+WQLeKZzCCnqqpfDzPMD/K6soB6StIVWRBYRBgTIoiAgaby6gY3W
	 g++76qdF3AtyVkYOvArRL2qcdnKOpBiw/tvam0U0=
Date: Fri, 9 Feb 2024 10:22:06 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, mathias.nyman@intel.com, perex@perex.cz,
	conor+dt@kernel.org, corbet@lwn.net, lgirdwood@gmail.com,
	andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	Thinh.Nguyen@synopsys.com, broonie@kernel.org, bgoswami@quicinc.com,
	tiwai@suse.com, robh+dt@kernel.org, konrad.dybcio@linaro.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH v14 00/53] Introduce QC USB SND audio offloading support
Message-ID: <2024020950-eel-opt-58cd@gregkh>
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
 <852cc2e0-4e61-3b8a-428f-7623ceade463@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <852cc2e0-4e61-3b8a-428f-7623ceade463@quicinc.com>

On Thu, Feb 08, 2024 at 03:33:06PM -0800, Wesley Cheng wrote:
> Hi Mark/Takashi,
> 
> On 2/8/2024 3:13 PM, Wesley Cheng wrote:
> <snip>
> 
> Would it be possible to see if we could start pulling some of these non
> offloading dependent changes into your repos?  It would really be helpful
> since the # of patches is getting a little cumbersome to maintain.  If we
> need to make any follow ups, I can address them as a separate patch and add
> it to the series w/ the other changes that are still pending.

Or if someone gives me acks, I can take them through my usb tree as
well.

thanks,

greg k-h

