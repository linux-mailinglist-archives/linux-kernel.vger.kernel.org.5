Return-Path: <linux-kernel+bounces-16433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFD3823E86
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B891F2507D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6371B2032E;
	Thu,  4 Jan 2024 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPu7cp9c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9540208A3;
	Thu,  4 Jan 2024 09:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADABC433C8;
	Thu,  4 Jan 2024 09:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704360230;
	bh=2fYZ6vaziMzDK3ZftjJ0AmNeenr6pb42FNCCdQQvYiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPu7cp9cxtIIG1PRxcIJdOhLA6FUGpW7QzSfbPkf0PueMHM+lJzeF3FwQK9trx81U
	 LRkdE9B4uqDF+PPyXUfVdL85no+50qV16hVtknSb6FBRAUH8TDkvFdZ0HwlU8S9/aM
	 tmfK7ar37/9KzWV4+cFvWt7adzUSWRVNl3YNOe7DpdV+7LLEpT1JG3sCML5/GyhLzm
	 H+QrG7G+Rf8tXF27aP5LjSTUA5DW8RpRJvjtUL7dmmZ4XEwGdSCy7afQcI0ksORauL
	 oqz6YFwnK2dd3X8gEKZgrx2WSJRm8BbaicGYSDNhcUf18L86mWeiEekGaDvkwriE8e
	 ZHSp50zPl2kNg==
Date: Thu, 4 Jan 2024 09:23:44 +0000
From: Simon Horman <horms@kernel.org>
To: Chris Lew <quic_clew@quicinc.com>
Cc: Sarannya S <quic_sarannya@quicinc.com>, quic_bjorande@quicinc.com,
	andersson@kernel.org, mathieu.poirier@linaro.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH V1] net: qrtr: ns: Ignore ENODEV failures in ns
Message-ID: <20240104092344.GE31813@kernel.org>
References: <1703153211-3717-1-git-send-email-quic_sarannya@quicinc.com>
 <20231223135333.GA201037@kernel.org>
 <3e017f77-87dd-78e1-321d-90c3e57a68d9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e017f77-87dd-78e1-321d-90c3e57a68d9@quicinc.com>

On Tue, Dec 26, 2023 at 04:20:03PM -0800, Chris Lew wrote:
> 
> 
> On 12/23/2023 5:56 AM, Simon Horman wrote:
> > [Dropped bjorn.andersson@kernel.org, as the correct address seems
> >   to be andersson@kernel.org, which is already in the CC list.
> >   kernel.org rejected sending this email without that update.]
> > 
> > On Thu, Dec 21, 2023 at 03:36:50PM +0530, Sarannya S wrote:
> > > From: Chris Lew <quic_clew@quicinc.com>
> > > 
> > > Ignore the ENODEV failures returned by kernel_sendmsg(). These errors
> > > indicate that either the local port has been closed or the remote has
> > > gone down. Neither of these scenarios are fatal and will eventually be
> > > handled through packets that are later queued on the control port.
> > > 
> > > Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> > > Signed-off-by: Sarannya Sasikumar <quic_sarannya@quicinc.com>
> > > ---
> > >   net/qrtr/ns.c | 11 +++++++----
> > >   1 file changed, 7 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
> > > index abb0c70..8234339 100644
> > > --- a/net/qrtr/ns.c
> > > +++ b/net/qrtr/ns.c
> > > @@ -157,7 +157,7 @@ static int service_announce_del(struct sockaddr_qrtr *dest,
> > >   	msg.msg_namelen = sizeof(*dest);
> > >   	ret = kernel_sendmsg(qrtr_ns.sock, &msg, &iv, 1, sizeof(pkt));
> > > -	if (ret < 0)
> > > +	if (ret < 0 && ret != -ENODEV)
> > >   		pr_err("failed to announce del service\n");
> > >   	return ret;
> > 
> > Hi,
> > 
> > The caller of service_announce_del() ignores it's return value.
> > So the only action on error is the pr_err() call above, and so
> > with this patch -ENODEV is indeed ignored.
> > 
> > However, I wonder if it would make things clearer to the reader (me?)
> > if the return type of service_announce_del was updated void. Because
> > as things stand -ENODEV may be returned, which implies something might
> > handle that, even though it doe not.
> > 
> > The above notwithstanding, this change looks good to me.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > ...
> 
> Hi Simon, thanks for the review and suggestion. We weren't sure whether we
> should change the function prototype on these patches on the chance that
> there will be something that listens and handles this in the future. I think
> it's a good idea to change it to void and we can change it back if there is
> such a usecase in the future.

Hi Chris,

yes, I think that would be a good approach.

