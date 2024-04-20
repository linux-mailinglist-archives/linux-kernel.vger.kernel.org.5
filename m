Return-Path: <linux-kernel+bounces-152274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 111938ABBB8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4400D1C20860
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0475920B27;
	Sat, 20 Apr 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ddEQwPfo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B2625;
	Sat, 20 Apr 2024 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713619211; cv=none; b=tx4lIyu54wTgGqDvOC/z1xSdVIm1eAcNwzmRt333kKemEOK9CHb8yX8rbwhg+SloIBEy50jwqP29Sazy0vh+iDYcqvxPr6buHOR1l++NFW0qeJJ/EzMNaAZniPQArpdio0ovITLzegetjbYuoC25eCrPsVGZGpo5t+/vSLWCZV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713619211; c=relaxed/simple;
	bh=Xlegqb+NHNk2snlw+uC2jpp9KfrY4Egw4o7LZfUbZ8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQHmh6QbVIyd3klXlzcKPRZzx7m5/FGn7PCCwGBtUXERJkG18OqgWM4ULj4Yd7WcGM1w2+W9/w6dIrJT0BkE0tOjBuBjVJkXKS6bhb8iKtOR+3vM9ZNoL4E8BZk+0A6btzoQv+imyIUwFNPEWylURWbxOBdutDmVSWq0/d5f768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ddEQwPfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041B9C072AA;
	Sat, 20 Apr 2024 13:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713619210;
	bh=Xlegqb+NHNk2snlw+uC2jpp9KfrY4Egw4o7LZfUbZ8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddEQwPfo0RVLM/2l9o1NRgV0zEEyg2YtVLLLdmfmVJRnVu/vnS4VD9GcIGXo2J+3E
	 42aGHUgoz9qUto913qpZw2fpevHAk4e9Z7k49K+rItyF+NvgW37ZlODlgUjzIpgIU8
	 ofH8IOBOozBvdGlLgeJQ8z5ndxfEO5ykrWCxRNa0=
Date: Sat, 20 Apr 2024 15:20:01 +0200
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
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>
Subject: Re: [PATCH 1/4] usb: typec: ucsi: Fix null deref in trace
Message-ID: <2024042056-shortlist-grope-0216@gregkh>
References: <20240419211650.2657096-2-jthies@google.com>
 <aa12c80c-9769-424a-ba2b-8c0f68b1c1e6@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa12c80c-9769-424a-ba2b-8c0f68b1c1e6@web.de>

On Sat, Apr 20, 2024 at 03:15:16PM +0200, Markus Elfring wrote:
> > ucsi_register_altmode checks IS_ERR on returned pointer and treats
> > NULL as valid. This results in a null deref when
> > trace_ucsi_register_altmode is called.
> 
> I find that the change description can be improved further.
> Is another imperative wording desirable?
> 
> Can it be nicer to use the term “dereference” for the final commit message?

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

