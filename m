Return-Path: <linux-kernel+bounces-123033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80394890149
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BFF295CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18B612F5B4;
	Thu, 28 Mar 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fN/F3QvQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C40281AD2;
	Thu, 28 Mar 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634919; cv=none; b=Ii0L1mEfjl+BoaXpxlNr8C7yRM5/TriPVnXrEf/xWnsURqZZvaS6ghveCoBRU/9jJ6P1wJgG9s/2a/jirnBVRupDSPLslVBP3o5VMoWhITPQdDjx9Mfz88lUI5gwAKWAcEzsB8qqg7z0chQtLzNc+43E3/6sn/wLY5EpHUqENZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634919; c=relaxed/simple;
	bh=MmbZ0ahCCHtV5qsDRCOojRvFo+8CrnG/5V4HvoQ4sLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVpSsDupXpTiwxAD55+nLzQkoqYUbb0p/aYB9xxThSm5Ji5+pBcJ2/2B7zqjrtDjAPDVLGJ+SdlzW6fz7CTxlOubBJ2w3mOwED2djHSWOqL6ibCmYMlmA4IA8kktc+0ahxG0FMhGdj/VDqF/SAt5la0+ZwVsnVkba+UTMvgJIiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fN/F3QvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B198C433C7;
	Thu, 28 Mar 2024 14:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634918;
	bh=MmbZ0ahCCHtV5qsDRCOojRvFo+8CrnG/5V4HvoQ4sLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fN/F3QvQlBi8eZVq3NKCdhtmZbUoZjzW8WGEEdaVMOZlmaGnXzMItzA0w9E3fP8UZ
	 ez8QJ8HulpC6NHE0wpGKTxzvVCwA7DIQiuWYlLPK//qcWdYNAy2GRObzU1CmJAruCk
	 UtIBBTnL9lXaOwwPCx1m/ZswYzrfnfCY4tdVXruE2poqOsXL4v4Y6WQB9y8Ld3KAn/
	 Do8BbKbfbWbrRJG7nvHT0iAeMqJkswl7OEae31BdeRMHFrENH2yIHZrculLln+zPS7
	 MfH3vcNciBjkj3xMPBRoXDnAU2TlNicQ3AOeJbzUuOG3lZN+1aIzZXbuTflbJ5LgN3
	 ajMoIhMXoEMQQ==
Date: Thu, 28 Mar 2024 14:08:34 +0000
From: Simon Horman <horms@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Sai Krishna Gajula <saikrishnag@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com" <syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com>
Subject: Re: [PATCH net-next] usbnet: fix cyclical race on disconnect with
 work queue
Message-ID: <20240328140834.GM403975@kernel.org>
References: <20240321124758.6302-1-oneukum@suse.com>
 <SA1PR18MB470955BBB332D3A9F9A6F247A0312@SA1PR18MB4709.namprd18.prod.outlook.com>
 <04cfa214-4d45-48b1-87ba-500e3e501977@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04cfa214-4d45-48b1-87ba-500e3e501977@suse.com>

On Wed, Mar 27, 2024 at 04:10:36PM +0100, Oliver Neukum wrote:
> 
> 
> On 3/22/24 18:43, Sai Krishna Gajula wrote:
> > 
> > > -----Original Message-----
> > > From: Oliver Neukum <oneukum@suse.com>
> > > Sent: Thursday, March 21, 2024 6:17 PM
> > > To: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > > pabeni@redhat.com; netdev@vger.kernel.org; linux-usb@vger.kernel.org;
> > > linux-kernel@vger.kernel.org
> > > Cc: Oliver Neukum <oneukum@suse.com>;
> > > syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com
> > > Subject: [PATCH net-next] usbnet: fix cyclical race on disconnect
> > > with work queue
> > 
> > This patch seems to be a fix, in that case the subject need to be with [PATCH net]
> 
> OK
> > 
> > > 
> > > The work can submit URBs and the URBs can schedule the work.
> > > This cycle needs to be broken, when a device is to be stopped.
> > > Use a flag to do so.
> > > 
> > > Fixes: f29fc259976e9 ("[PATCH] USB: usbnet (1/9) clean up framing")
> > 
> > Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: f29fc259976e ("[PATCH] USB: usbnet (1/9) clean up framing")'
> 
> Ehm, what exactly did I do differently

I think the point being made is that the hash has 13 rather than 12
characters. But, IMHO, that is fine because my understanding is that the
requirement is that the hash is at least, not exactly, 12 characters long.

..

