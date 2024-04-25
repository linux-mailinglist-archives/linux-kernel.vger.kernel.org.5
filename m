Return-Path: <linux-kernel+bounces-158509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E28D8B2177
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629E81C213C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884C012BF17;
	Thu, 25 Apr 2024 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n47zh4n6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C084812C46D;
	Thu, 25 Apr 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047463; cv=none; b=MpxhThw/sLEINCtRUxoJi09wuIM7jPG8/2+ltX4n3L8GHelWaLkZESKwe7//GeuPb+FTO+BGu7j8/k9CxzsSNQHjRN2UZBEQqv8siAZ0kDV5/CPqAZb7IC6slC7IX/uXnkQ0PjsNbt0zJ9B/M6z2GnHpSxxNmMPKw/OtbK5vyy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047463; c=relaxed/simple;
	bh=9qw8mw8cRq2pIoUpumnN13h5GTULZh/nYCoUByN5pLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiTWE9uwCq9MXpFSeK4Kzrns6fQnAqBOCKYw5ANxko7HmjRBgt3huG2X1nXgsi5uNSgqvVjKh46RABF/QyuLdGkxJYF2y4bVAMNJo4IEQP43rpdMh7IhVUCjdTNInxD8R70ktJynAHDgb0Ko8RAv+Jch0aBB6AuoLN4CJvsiYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n47zh4n6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C70C113CE;
	Thu, 25 Apr 2024 12:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714047462;
	bh=9qw8mw8cRq2pIoUpumnN13h5GTULZh/nYCoUByN5pLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n47zh4n6wXIBltmcJ4jjW33nz0KvtVQQOy8aEBnp5quBpNq+fAPysAsCHRxDJA6WS
	 tyzzkidxPukVJpwSNWRCtnWUGSD8u6LR5cN/rfc4XQL4lWm5TWezBL3fIkiTRvI9R/
	 R6Xj+GFF73EL5kmwnWZ+eDpuqpU/M2qPeTB5cgh452HerG6iAHoW1xued258PIL1H7
	 PP0mmHchmL7ngzNwKK9xnduhGdXAbYYRv9vxxyqZctHSdiLRcs7+mubis8aCE7TK5w
	 zXcKt1GPeXKqUBBr71aOx3njVnMlW5oaaXQqTh3K2g4XH5CWWxXGiomj02IgSjl93Z
	 YLT7Lh5yVRhoA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rzy2n-000000002CT-1Kly;
	Thu, 25 Apr 2024 14:17:42 +0200
Date: Thu, 25 Apr 2024 14:17:41 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v4] usb: typec: qcom-pmic-typec: split HPD bridge alloc
 and registration
Message-ID: <ZipJ5WVuxPY7dK21@hovoldconsulting.com>
References: <20240424-qc-pmic-typec-hpd-split-v4-1-f7e10d147443@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424-qc-pmic-typec-hpd-split-v4-1-f7e10d147443@linaro.org>

On Wed, Apr 24, 2024 at 05:16:57AM +0300, Dmitry Baryshkov wrote:
> If a probe function returns -EPROBE_DEFER after creating another device
> there is a change of ending up in a probe deferral loop, (see commit
> fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER"). In case
> of the qcom-pmic-typec driver the tcpm_register_port() function looks up
> external resources (USB role switch and inherently via called
> typec_register_port() USB-C muxes, switches and retimers).
> 
> In order to prevent such probe-defer loops caused by qcom-pmic-typec
> driver, use the API added by Johan Hovold and move HPD bridge
> registration to the end of the probe function.
> 
> The devm_drm_dp_hpd_bridge_add() is called at the end of the probe
> function after all TCPM start functions. This is done as a way to
> overcome a different problem, the DRM subsystem can not properly cope
> with the DRM bridges being destroyed once the bridge is attached. Having
> this function call at the end of the probe function prevents possible
> DRM bridge device creation followed by destruction in case one of the
> TCPM start functions returns an error.

As I mentioned again off-list yesterday, I would have preferred to see
an explanation why registering the bridge after starting the port and
phy is ok as it's not obvious to someone not familiar with the driver.

But given that bridge registration only registers an aux device which
may not have been probed by the time the function returns I guess that
implies that the old driver did not actually rely on it being registered
before starting either. So I'm fine with this as-is.

> Reported-by: Caleb Connolly <caleb.connolly@linaro.org>
> Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Dependency: https://lore.kernel.org/lkml/20240418145730.4605-2-johan+linaro@kernel.org/
> ---
> Changes in v4:
> - Rebased on top of Johan's patches
> - Link to v3: https://lore.kernel.org/r/20240416-qc-pmic-typec-hpd-split-v3-1-fd071e3191a1@linaro.org

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan

