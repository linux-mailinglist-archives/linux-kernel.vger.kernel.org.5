Return-Path: <linux-kernel+bounces-163497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 189638B6C21
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDEF1F22CB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA61405EC;
	Tue, 30 Apr 2024 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h0J2wFff"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D1D3EA83;
	Tue, 30 Apr 2024 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463371; cv=none; b=AAxHiz8fXJJadvh3A+FQrgqXdL3XQ7vgZJrj9wkE33hTbRSI1SIN6/ZBpCFhVzVgIaekJua/Z9kE5xPTdJhGaAECHiKza+iv7QGzKeTI9TahrvXBMmuBZiaJ6EFvNO4B2l7QQddpF/H31YHv8a3wRY6ydpjtQrpeA/BZyFYhli8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463371; c=relaxed/simple;
	bh=9lZZOXS6fkMpxo39DRq1VQOFG2hH7klC9A0gcrDL9EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9WZKw2dy7FIdqbnp5BYyvbhA7V73F60R+kNBV6c+ZFniRU7Iln6yum0Le6RIAJUpHkuoG9pU/h7MnYqKZoj1M/GyPn8IKXs84dkluUV/Dno1sOTVy5jNNn+aDq/2XuXaISPhsiPjnZTxBCxU3dVP/JoTD+fC7PQxaK/kU276Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h0J2wFff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0A3C2BBFC;
	Tue, 30 Apr 2024 07:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714463370;
	bh=9lZZOXS6fkMpxo39DRq1VQOFG2hH7klC9A0gcrDL9EY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h0J2wFffa3IssrxgNxiRuV3289mztpmGlxJnKsHgp8T4NWG+47stevX64C06I8AbJ
	 gdczYJDvPnT4dYU/n/U7em6DeYKvNcogG4Zu5GbHphb3JXVRy3vr/NK0+47BHOsmJv
	 Vz84udsE7MdV55mPKNuTJuyqRk8y/H38gjcTPePk=
Date: Tue, 30 Apr 2024 09:49:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: stable@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 6.8.y] phy: qcom: qmp-combo: fix VCO div offset on v5_5nm
 and v6
Message-ID: <2024043015-steadying-ogle-eefa@gregkh>
References: <2024042918-jet-harmonica-e767@gregkh>
 <20240429194612.3412821-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429194612.3412821-1-swboyd@chromium.org>

On Mon, Apr 29, 2024 at 12:46:12PM -0700, Stephen Boyd wrote:
> From: Johan Hovold <johan+linaro@kernel.org>
> 
> Commit 5abed58a8bde ("phy: qcom: qmp-combo: Fix VCO div offset on v3")
> fixed a regression introduced in 6.5 by making sure that the correct
> offset is used for the DP_PHY_VCO_DIV register on v3 hardware.
> 
> Unfortunately, that fix instead broke DisplayPort on v5_5nm and v6
> hardware as it failed to add the corresponding offsets also to those
> register tables.
> 
> Fixes: 815891eee668 ("phy: qcom-qmp-combo: Introduce orientation variable")
> Fixes: 5abed58a8bde ("phy: qcom: qmp-combo: Fix VCO div offset on v3")
> Cc: stable@vger.kernel.org	# 6.5: 5abed58a8bde
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Link: https://lore.kernel.org/r/20240408093023.506-1-johan+linaro@kernel.org
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> (cherry picked from commit 025a6f7448f7bb5f4fceb62498ee33d89ae266bb)
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Both now queued up, thanks.

greg k-h

