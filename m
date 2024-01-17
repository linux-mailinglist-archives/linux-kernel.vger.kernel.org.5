Return-Path: <linux-kernel+bounces-28612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56798300B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084C91C23D26
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD70125D1;
	Wed, 17 Jan 2024 07:45:38 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B36125C0;
	Wed, 17 Jan 2024 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705477537; cv=none; b=B0svbNU3az1Ib/USr45Czd4ld+no8iAROie7BpCU7UX1WhAqiHa7a+ai4qe4qOVBAmhnwOtTbqTL+r48AqAyhPxXlV9CjavsGH9QW/iu5UM4Pb9jZZjbfQy6tQ+Y8J0eJqMLA1y3UUywkSTEdqF9SwZQ2BMsEgdsDr9iwh4BcJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705477537; c=relaxed/simple;
	bh=XTlJMeq1LcRVPc4P3E1fOfdg//1N2HH8XnYT7USTq14=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=O4/8dr3JjrfZKeMiKepOHGp+1e2V4n4IV8fUVRwU6ZG5Y6wM9dRCzsZKbJq/1F+prZJxk3wW8peay2PVZbUlqUMB7tRqzwQFdYrHyIeEBUaQZ73fsw7gL7V9JexlNDFYEu+pk1S1uX1nDiU9SMlicR1WWf0ODzl1+iKW8sPHR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 4EE1D140327; Wed, 17 Jan 2024 08:45:32 +0100 (CET)
Date: Wed, 17 Jan 2024 08:45:32 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, Dell.Client.Kernel@dell.com,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jack Pham <quic_jackp@quicinc.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: ucsi: Add missing ppm_lock
Message-ID: <ZaeFnId6Ln3VUE5n@cae.in-ulm.de>
References: <20240116224041.220740-1-lk@c--e.de>
 <20240116224041.220740-2-lk@c--e.de>
 <2024011726-exhaust-writing-29d4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024011726-exhaust-writing-29d4@gregkh>

On Wed, Jan 17, 2024 at 06:44:40AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 16, 2024 at 11:40:39PM +0100, Christian A. Ehrhardt wrote:
> > Calling ->sync_write must be done while holding the PPM lock as the
> > mailbox logic does not support concurrent commands.
> > 
> > Thus protect the only call to ucsi_acknowledge_connector_change
> > with the PPM lock as it calls ->sync_write. All other calls to
> > ->sync_write already happen under the PPM lock.
> > 
> > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > ---
> > NOTE: This is not a theoretical issue. I've seen problems resulting
> > from the missing lock on real hardware.
> 
> What commit id does this fix?

It's hard to tell (due to rewrites, logic and API changes). After
digging a bit more I think it is at least a theoretical issues since
the introduction of partner tasks.

I'll wait a bit for additional feedback and fix this and other issues
noticed by your patch bot (sorry for those) in the next iteration.

> Should it be cc: stable?

Not sure. The race is triggered much more ofter after the quirk added
in patch 3/3, so this may not be a practical issue before that.
I'll add the tag in the next iteration, though.

   thanks   Christian


