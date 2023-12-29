Return-Path: <linux-kernel+bounces-13141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48497820042
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302221C22703
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BF5125BF;
	Fri, 29 Dec 2023 15:32:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEA6125AB;
	Fri, 29 Dec 2023 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 671A71402F9; Fri, 29 Dec 2023 16:32:16 +0100 (CET)
Date: Fri, 29 Dec 2023 16:32:16 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: RD Babiera <rdbabiera@google.com>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	badhri@google.com, stable@vger.kernel.org,
	Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: Re: [PATCH v1] usb: typec: class: fix typec_altmode_put_partner to
 put plugs
Message-ID: <ZY7mgMkoaZDZGua4@cae.in-ulm.de>
References: <20231121203954.173364-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121203954.173364-2-rdbabiera@google.com>


Hi,

I found this mail in the archives after looking at a bug report
that was bisected to the change that resulted from the following
analysis:

https://lore.kernel.org/all/CAP-bSRb3SXpgo_BEdqZB-p1K5625fMegRZ17ZkPE1J8ZYgEHDg@mail.gmail.com/

AFAICS the analysis below is partially flawed

On Tue, Nov 21, 2023 at 08:39:55PM +0000, RD Babiera wrote:
> When releasing an Alt Mode, typec_altmode_release called by a plug device
> will not release the plug Alt Mode, meaning that a port will hold a
> reference to a plug Alt Mode even if the port partner is unregistered.
> As a result, typec_altmode_get_plug() can return an old plug altmode.
> 
> Currently, typec_altmode_put_partner does not raise issues
> when unregistering a partner altmode. Looking at the current
> implementation:
> 
> > static void typec_altmode_put_partner(struct altmode *altmode)
> > {
> >	struct altmode *partner = altmode->partner;
> 
> When called by the partner Alt Mode, then partner evaluates to the port's
> Alt Mode. When called by the plug Alt Mode, this also evaluates to the
> port's Alt Mode.
> 
> >	struct typec_altmode *adev;
> >
> >	if (!partner)
> >		return;
> >
> >	adev = &partner->adev;
> 
> This always evaluates to the port's typec_altmode
> 
> >	if (is_typec_plug(adev->dev.parent)) {
> >		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
> >
> >		partner->plug[plug->index] = NULL;
> 
> If the routine is called to put the plug's Alt mode and altmode refers to
> the plug, then adev referring to the port can never be a typec_plug. If
> altmode refers to the port, adev will always refer to the port partner,
> which runs the block below.
> 
> >	} else {
> >		partner->partner = NULL;
> >	}
> >	put_device(&adev->dev);
> > }

So far everything is fine.

> When calling typec_altmode_set_partner, a registration always calls
> get_device() on the port partner or the plug being registered,

This is wrong. It is the altmode of the plug or partner
that holds a reference to the altmode of the port not the other
way around. The port's altmode has (back) pointers to the altmodes
of its partner and the cable plugs but these are weak references that
do not contribute to the refcount.

> therefore
> typec_altmode_put_partner should put_device() the same device. By changing

Thus this conclusion is wrong. The put_device() used to be correct.

> adev to altmode->adev, we make sure to put the correct device and properly
> unregister plugs. The reason port partners are always properly
> unregistered is because even when adev refers to the port, the port
> partner gets nullified in the else block. The port device currently gets
> put().

Please correct me if I missed something.

       regards    Christian


