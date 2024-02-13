Return-Path: <linux-kernel+bounces-64025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C37853919
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85DE51F24B68
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD2B60DD1;
	Tue, 13 Feb 2024 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A1gErUWs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0E960BB7;
	Tue, 13 Feb 2024 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846883; cv=none; b=sNEgp8oLjMXCIpLgRFn9ksYhL7rGkix3hJsFZXa70106sTo1UXsPBclhmyDr8dlvHe3ppty+JHPO8U9bsGf3o8dvWDbFJUTfLOazmCNEE+YBMc+grwHazkTizO45d8acHy86ZDA088CtsULoYFGI/Uxo2I2OHXz48GPPOuT/eJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846883; c=relaxed/simple;
	bh=OdZ/Y9zBfSGNYm4w6+scC4UUyi2R5zySwbdcyI1Rv/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHcn6IpHyUxs/1zKppo9XfMW9pulOQ6ibfTVeBSsDR7bsbgwkYWx+0D00Yg7os4ZV7u+SPGMTVrzRFEv4/GWsLKKuWWHQA81DfJhUKJgPYV9v5bLj3hnRv5CTTZPxombCmubElreRys6VFJDGz0pNHe6rO2ZoEDIUP+PqkseqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A1gErUWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DB7C433C7;
	Tue, 13 Feb 2024 17:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707846883;
	bh=OdZ/Y9zBfSGNYm4w6+scC4UUyi2R5zySwbdcyI1Rv/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1gErUWsOg8gH/lvFWBbzLLxlU1jyvekZ1tBQvuTJDyrYwpwuGaPu+tpxzOBKyE75
	 mBIs1z+RfZuuRITnmkhKkQEofH39UwFRCg1ArduHot2GjVf3JgotXfjJuvWv+dOxqS
	 i8cjNfsnToqCSbLecN4NelHVBzSxcAXMFiIm0OgY=
Date: Tue, 13 Feb 2024 18:29:10 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: apr: make aprbus const
Message-ID: <2024021301-request-residence-74d6@gregkh>
References: <20240213-bus_cleanup-apr-v1-1-50c824eec06d@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-apr-v1-1-50c824eec06d@marliere.net>

On Tue, Feb 13, 2024 at 11:44:01AM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the aprbus variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

