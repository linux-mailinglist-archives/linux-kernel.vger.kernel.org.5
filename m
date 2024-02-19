Return-Path: <linux-kernel+bounces-71923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C2685AC90
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB0A2821E7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB8B524A6;
	Mon, 19 Feb 2024 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j/Tf0rg/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2824F203;
	Mon, 19 Feb 2024 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372602; cv=none; b=DHLIqOk/1zuzODK1TxZr8HGfHB52qeawYpUb5R33su4WXZ7wdq7O2KolJPgkr2eqLkkWeEvHV8GVRLtQQdsExja5sSo+f0n/e8XW2CN82kSlPyndDGcq0ClHn8UHxy/5/ZU8qRSb0n/Zd7VcoM2HgXXm4qtvBfDPwLB3sqsujww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372602; c=relaxed/simple;
	bh=OaAEMFvFDN1qhJ4t5nXfrOCymw4TroM52J1E3WnfAP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CH4YqlWQDjRZLjxA9JEkwaaOqLi/mrjBUUS/3yaX83WK06PFr8FxyNJBd91I6uSMOnjWDsIJ91rhDKrrmpit9Vhy8jb01pRudRtDZ9VQ3Rq0HhgzI/meluSTxcDYa/e5ovNASbEkGksYmoyofeDx5Fm7G3IfRDji4+O9hTZ2GkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j/Tf0rg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB28C433F1;
	Mon, 19 Feb 2024 19:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708372601;
	bh=OaAEMFvFDN1qhJ4t5nXfrOCymw4TroM52J1E3WnfAP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/Tf0rg/52VRU0RdqcIIbgIp34hsAGhLLM6UEzs4f8XeRAe8Pe0ZnvuYgjEaedKPh
	 XzolqPbpGuyslO57mb26R3nPLHjlPXFweVZOqmQ+StxE+IHfCDJsSFchYOb0ECw4Ej
	 9bic7JeKdiqsqqJlLXwCDhAwxYe5B/OGUhUOFkGU=
Date: Mon, 19 Feb 2024 20:56:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
	mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
	corbet@lwn.net, lgirdwood@gmail.com, andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, Thinh.Nguyen@synopsys.com,
	broonie@kernel.org, bgoswami@quicinc.com, tiwai@suse.com,
	robh+dt@kernel.org, konrad.dybcio@linaro.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH v17 00/51] Introduce QC USB SND audio offloading support
Message-ID: <2024021929-catching-subheader-d51b@gregkh>
References: <20240217001017.29969-1-quic_wcheng@quicinc.com>
 <2024021754-unengaged-saggy-6ab1@gregkh>
 <96ab6033-2cb9-daa7-ddad-090138896739@linux.intel.com>
 <2024021922-privatize-runt-495e@gregkh>
 <d82c8955-6793-7544-0013-1033abd9f1e9@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d82c8955-6793-7544-0013-1033abd9f1e9@linux.intel.com>

On Mon, Feb 19, 2024 at 01:03:31PM +0200, Mathias Nyman wrote:
> > > 
> > > Patch 10/10 is based on an old POC patch by me, but it's heavily modified.
> > > 
> > > It looks like it does a few minor things that are not optimal, like extra
> > > spinlock/unlock, and wait_for_completion_timeout() with magical timeout value.
> > > I haven't tested this version, but I guess any fixes or cleanups can be done
> > > later on top of it.
> > 
> > I can revert it now if you want, just let me know.
> > 
> 
> Maybe reverting it would be better yes.

Ok, will do, thanks for letting me know.

greg k-h

