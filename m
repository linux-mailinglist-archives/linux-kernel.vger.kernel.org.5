Return-Path: <linux-kernel+bounces-152469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3778ABEE2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 11:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C058C1F210D5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 09:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA9710979;
	Sun, 21 Apr 2024 09:37:28 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1429C625;
	Sun, 21 Apr 2024 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713692248; cv=none; b=nRXqMLcUazcaHwkCieANqM0gR5VbcYKkLTEsatC780P0ji+NCnpfD4ysZG8K5Heyfw3fQQdF9m+q1jsDFBgBR53qw8DvGje2r87zU21+t+lCGDLtlZI2Es81Sy5jL5g0lkJVhVxomeJygo3NY7fJDbm/2Jt3hiF59xeNmW6Bf/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713692248; c=relaxed/simple;
	bh=gRcDq0NrGX6/1/kSuxwyYx9WNXiEK2e2hJwS1DZI4W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqnG689eUA0qZwsuDfN0iNg6zJm5nuPzckzf7o0hE/LHYzUns07UWmJ42dZ0jVa05jjAX6wkZaxcCyk4WCl6rNHbLfBFDz4Jvvm/Zl4xnBF2r01XliudsecbcG0au8Ju2sbYu1dHnqlhfMI5DYlkM5kWibkbm7Yqc4Gm8uLvjYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 715C014026B; Sun, 21 Apr 2024 11:30:17 +0200 (CEST)
Date: Sun, 21 Apr 2024 11:30:17 +0200
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	pmalani@chromium.org, bleung@google.com,
	abhishekpandit@chromium.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com,
	gregkh@linuxfoundation.org, hdegoede@redhat.com,
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com,
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] usb: typec: ucsi: Fix null deref in trace
Message-ID: <ZiTcqZYS53ITwNLy@cae.in-ulm.de>
References: <20240419211650.2657096-1-jthies@google.com>
 <20240419211650.2657096-2-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419211650.2657096-2-jthies@google.com>


Hi Jameson,

On Fri, Apr 19, 2024 at 09:16:47PM +0000, Jameson Thies wrote:
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> 
> ucsi_register_altmode checks IS_ERR on returned pointer and treats
> NULL as valid. This results in a null deref when
> trace_ucsi_register_altmode is called.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
>  drivers/usb/typec/ucsi/ucsi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index c4d103db9d0f8..c663dce0659ee 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -496,7 +496,7 @@ ucsi_register_displayport(struct ucsi_connector *con,
>  			  bool override, int offset,
>  			  struct typec_altmode_desc *desc)
>  {
> -	return NULL;
> +	return ERR_PTR(-EOPNOTSUPP);
>  }

Hm. This does not look correct to me. Ignoring trace the old code
would have returned success if displayport is not compiled in and
all altmodes (except for display port) would be registered.

With your code ucsi_register_altmodes will always fail and abort
altmode registration if it finds a displayport altmode and
CONFIG_TYPEC_DP_ALTMODE is not set. I don't think this is what we want.

Maybe it is better to guard the trace call with an if?

Am I missing something?

Best regards,
Christian


