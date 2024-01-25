Return-Path: <linux-kernel+bounces-39405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A3F83D07B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81759B26821
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3820E12E72;
	Thu, 25 Jan 2024 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D4YIkH+d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8812B8A;
	Thu, 25 Jan 2024 23:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224619; cv=none; b=GHUPLudzOcFgqoKKHuFlHgePzBf2cvJ6uYUruGRbQjgqMLW7ug0TaRBLB7kksbmKaZIDv0RyviYfxQC7sPtIf19yxdq6R9C5waKeiDDJWN0weDRB/OLrhtU/52nQsoA5verm9gyXMCqQwbs7XIiaZgMfIKa30jtAWq2H+ScLj2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224619; c=relaxed/simple;
	bh=w6n+4zYW5jcdy7UBPVyDYjQxKJRG04RqjbfZ0iNojFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qspafZLn2H3PzHfPf6hLbvVBWJU94Q4BY6yNaQEwJTcAVlINDei+wAB/rGKsQ9OevGmjq7tHUPz7UIjPsxbP4Z8EkdD5NpU5hyYy0TSFfexhKsn02Z9w4+dFxQIx7TVASimesC1+hsNBKXjAJmbO8x+fv/PbvhtzG/9J5mcEdOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D4YIkH+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E184BC433C7;
	Thu, 25 Jan 2024 23:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706224618;
	bh=w6n+4zYW5jcdy7UBPVyDYjQxKJRG04RqjbfZ0iNojFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4YIkH+dcmFoFF98kqSYLlPEJOBM4/If4VjCt0kvc6RsC+yuM3VldLrHRkOVpnVs0
	 dCWXZntbw5db1Y9h5LsbgtYEpkngcoFWy2An2FBvGKK+CBD3BUh5OLhbFLgzMrZ8Ej
	 e5ayQWZJpLCWN6h5gpLD0YTBe8GkVbOBPn7iXANE=
Date: Thu, 25 Jan 2024 15:16:56 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Prashant Malani <pmalani@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@google.com>,
	linux-usb@vger.kernel.org, jthies@google.com,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] usb: typec: ucsi: Limit read size on v1.2
Message-ID: <2024012525-alienate-frown-916b@gregkh>
References: <20240123223039.1471557-1-abhishekpandit@google.com>
 <20240123143026.v1.1.Iacf5570a66b82b73ef03daa6557e2fc0db10266a@changeid>
 <CACeCKaftJSGba3ebs58=cB5aRLuOnbvhQX2V6+5=t9GPC08_Uw@mail.gmail.com>
 <ZbEV/qp/EhUkHVhA@kuha.fi.intel.com>
 <2024012405-stung-freckles-e196@gregkh>
 <CANFp7mVEF36TCb_4vGbF-0wM-Vn4agT6NXVOrnnDSC0JVpnLmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANFp7mVEF36TCb_4vGbF-0wM-Vn4agT6NXVOrnnDSC0JVpnLmg@mail.gmail.com>

On Wed, Jan 24, 2024 at 10:59:28AM -0800, Abhishek Pandit-Subedi wrote:
> Ack. Will make dev_dbg on the next iteration.
> 
> This seems like a good addition to the style guide too:
> https://www.kernel.org/doc/html/v6.7/process/coding-style.html#printing-kernel-messages.
> "When drivers are working properly, they are quiet. Prefer to use
> DEBUG messages unless something is wrong."
> 
> What do you think Greg?

I think you need to stop top-posting :)

But yes, that would be nice, hopefully people actually notice it there.
Would you have read this and seen it?

thanks,

greg k-h

