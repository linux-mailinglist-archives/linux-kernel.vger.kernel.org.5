Return-Path: <linux-kernel+bounces-159080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248568B2914
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95B51F24149
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FAB152531;
	Thu, 25 Apr 2024 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SBPi6X7j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676B14B06B;
	Thu, 25 Apr 2024 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714073763; cv=none; b=a330YUQH1yJzvm1DpdNQUK9Aa2EkgvGJo1GwIQXnCER9hnAqvilidwqCuXJdChc017AnSbeU9LTsN0yECCjJKyxqrimwGkZY+f4R3//91LemfVpj8+Qc9ohRnX8k9MVn9fr29q7hUQt6Lacc1/j4Jff/9ZuwIL2p4qoiioGpGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714073763; c=relaxed/simple;
	bh=3XoAGM27SwQ826jd9GUf1h0gsd40woJCFWyFu1z9JSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQFLRCN45POl9UVNQ0vuaSo77oDnveROknvduRIPHpQsaiMnUnBf8WNTNdM5jIHrWGGIhVtcVOw0kskQUnddiiuIaYTpO/Z2scnCg7AZs9uRst3BOP4hvuFhDVInMjKgFa07mB/jXwN67xeummu20UM8JwsA+dueJ0KybVcWVqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SBPi6X7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C083FC113CC;
	Thu, 25 Apr 2024 19:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714073763;
	bh=3XoAGM27SwQ826jd9GUf1h0gsd40woJCFWyFu1z9JSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBPi6X7j3mS1YlotJ7b5PyR7HNJpWtrX4axZQaYWSCVAzbvETHjpFDskeMugy8QT4
	 9zlvonL4E9oTlrOfzM0rdRb6+3MrU46UkPNnsc4i9zCayVX8sV2j4rntEi7Em52lnK
	 9Z0TjRUVViu6DWWLRW8OuqcIt7jVvj1loE8/8Ig8=
Date: Thu, 25 Apr 2024 12:35:53 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jameson Thies <jthies@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Benson Leung <bleung@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashant Malani <pmalani@chromium.org>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/4] usb: typec: ucsi: Fix null deref in trace
Message-ID: <2024042547-shimmy-guileless-c7f2@gregkh>
References: <20240424014821.4154159-2-jthies@google.com>
 <6e028bfa-9063-42ac-b40f-cf17a81c2af2@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e028bfa-9063-42ac-b40f-cf17a81c2af2@web.de>

On Thu, Apr 25, 2024 at 10:51:53AM +0200, Markus Elfring wrote:
> …
> > ucsi_register_altmode checks IS_ERR on returned pointer and treats
> > NULL as valid. This results in a null deref when
> > trace_ucsi_register_altmode is called.
> …
> 
> Can it be nicer to use the term “null pointer dereference” for
> the commit message here?
> 
> Regards,
> Markus

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

