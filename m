Return-Path: <linux-kernel+bounces-127019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 688548945E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F22FEB21D93
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6C253E16;
	Mon,  1 Apr 2024 20:11:20 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F263D9E;
	Mon,  1 Apr 2024 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712002280; cv=none; b=Il0Eysg8vU3BjpMS8EHqJKx1iqlT/YxnPqZuvX2GMr/3JgYc08s59tcOlChTIsGFi65HhzN9XtbuB74iEnpxIkxnYKcITpVVa1XlJ5FixhU42I0PQk/XIvm8i6Z4mAZL17EXq+vBTS1/8W+c1LTb9CZ35kp04moF0Y9OqTgitdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712002280; c=relaxed/simple;
	bh=mTjSvBAb6pXJhpMPHUFNtRHrMSDKZAtpuNulj6i8YiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bl8l3dzyNkCTI8nTBxgGLRi7vFPXO78rgK+wJHvW7/gIlLDqXTEqCmvsor2iDRXjMG/I6fcKbyWUAUQuz29HDZ8ObJlLkZwQP6XugdRNm2+wbCYJFa4FSd71xBdgOkBQOr1l7VEjn1FRFSGy+RTwp8XMwsZ8Z9cI9yCHKEZ9WJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 566CE140246; Mon,  1 Apr 2024 22:11:08 +0200 (CEST)
Date: Mon, 1 Apr 2024 22:11:08 +0200
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Prashant Malani <pmalani@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-usb@vger.kernel.org, Kenneth Crudup <kenny@panix.com>
Subject: Re: [PATCH 2/5] usb: typec: ucsi: Check for notifications after init
Message-ID: <ZgsU3HsfDJzjPCWA@cae.in-ulm.de>
References: <20240320073927.1641788-1-lk@c--e.de>
 <20240320073927.1641788-3-lk@c--e.de>
 <ZgbqdBd1OiWgDN-_@eriador.lumag.spb.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgbqdBd1OiWgDN-_@eriador.lumag.spb.ru>


Hi,

On Fri, Mar 29, 2024 at 06:21:08PM +0200, Dmitry Baryshkov wrote:
> On Wed, Mar 20, 2024 at 08:39:23AM +0100, Christian A. Ehrhardt wrote:
> > The completion notification for the final SET_NOTIFICATION_ENABLE
> > command during initialization can include a connector change
> > notification.  However, at the time this completion notification is
> > processed, the ucsi struct is not ready to handle this notification.
> > As a result the notification is ignored and the controller
> > never sends an interrupt again.
> > 
> > Re-check CCI for a pending connector state change after
> > initialization is complete. Adjust the corresponding debug
> > message accordingly.
> > 
> > Fixes: 71a1fa0df2a3 ("usb: typec: ucsi: Store the notification mask")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > ---
> >  drivers/usb/typec/ucsi/ucsi.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > index 8a6645ffd938..dceeed207569 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -1237,7 +1237,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num)
> >  	struct ucsi_connector *con = &ucsi->connector[num - 1];
> >  
> >  	if (!(ucsi->ntfy & UCSI_ENABLE_NTFY_CONNECTOR_CHANGE)) {
> > -		dev_dbg(ucsi->dev, "Bogus connector change event\n");
> > +		dev_dbg(ucsi->dev, "Early connector change event\n");
> >  		return;
> >  	}
> >  
> > @@ -1636,6 +1636,7 @@ static int ucsi_init(struct ucsi *ucsi)
> >  {
> >  	struct ucsi_connector *con, *connector;
> >  	u64 command, ntfy;
> > +	u32 cci;
> >  	int ret;
> >  	int i;
> >  
> > @@ -1688,6 +1689,13 @@ static int ucsi_init(struct ucsi *ucsi)
> >  
> >  	ucsi->connector = connector;
> >  	ucsi->ntfy = ntfy;
> > +
> > +	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
> > +	if (ret)
> > +		return ret;
> > +	if (UCSI_CCI_CONNECTOR(READ_ONCE(cci)))
> > +		ucsi_connector_change(ucsi, cci);
> > +
> 
> I think this leaves place for the race. With this patchset + "Ack
> connector change early" in place Neil triggered the following backtrace
> on sm8550 HDK while testing my UCSI-qcom-fixes patchset:

Sorry, but this seems to be a brown paper bag change.
- The READ_ONCE is bogus and a remnant of a prevoius verion of the
  change.
- Calling ->read should probably be done with the PPM lock held.
- The argument to ucsi_connector_change() must be
  UCSI_CCI_CONNECTOR(cci) instead of the plain cci.
I'll send a fix.

> What happens:
[ ... ]
> 
> [   10.595807] ------------[ cut here ]------------
> [   10.595808] WARNING: CPU: 6 PID: 101 at kernel/workqueue.c:2384 __queue_work+0x374/0x474
> 
> [skipped the register dump]
> 
> [   10.595953]  __queue_work+0x374/0x474
> [   10.595956]  queue_work_on+0x68/0x84
> [   10.595959]  ucsi_connector_change+0x54/0x88 [typec_ucsi]
> [   10.595963]  ucsi_init_work+0x834/0x85c [typec_ucsi]
> [   10.595968]  process_one_work+0x148/0x29c
> [   10.595971]  worker_thread+0x2fc/0x40c
> [   10.595974]  kthread+0x110/0x114
> [   10.595978]  ret_from_fork+0x10/0x20
> [   10.595985] ---[ end trace 0000000000000000 ]---
> 
> Warning, because the work is already scheduled.

No, the reason is the wrong connector number. Scheduling a work that
is already scheduled is fine.

Best regards
Christian


