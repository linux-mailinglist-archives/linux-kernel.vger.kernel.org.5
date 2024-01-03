Return-Path: <linux-kernel+bounces-15925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 071548235C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8962875F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906851CF9C;
	Wed,  3 Jan 2024 19:43:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BCD1399;
	Wed,  3 Jan 2024 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id A6513140915; Wed,  3 Jan 2024 20:43:12 +0100 (CET)
Date: Wed, 3 Jan 2024 20:43:12 +0100
From: Christian Ehrhardt <lk@c--e.de>
To: RD Babiera <rdbabiera@google.com>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] usb: typec: class: fix typec_altmode_put_partner to
 put plugs
Message-ID: <ZZW40CsR+Ruu8dDS@cae.in-ulm.de>
References: <20240103181754.2492492-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103181754.2492492-2-rdbabiera@google.com>

On Wed, Jan 03, 2024 at 06:17:55PM +0000, RD Babiera wrote:
> When typec_altmode_put_partner is called by a plug altmode upon release,
> the port altmode the plug belongs to will not remove its reference to the
> plug. The check to see if the altmode being released is a plug evaluates
> against the released altmode's partner instead of the calling altmode, so
> change adev in typec_altmode_put_partner to properly refer to the altmode
> being released.
> 
> Because typec_altmode_set_partner calls get_device() on the port altmode,
> add partner_adev that points to the port altmode in typec_put_partner to
> call put_device() on. typec_altmode_set_partner is not called for port
> altmodes, so add a check in typec_altmode_release to prevent
> typec_altmode_put_partner() calls on port altmode release.
> 
> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> Cc: stable@vger.kernel.org
> Co-developed-by: Christian A. Ehrhardt <lk@c--e.de>
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> Signed-off-by: RD Babiera <rdbabiera@google.com>

I was able to reproduce the bug of the original report from here

https://lore.kernel.org/all/CAP-bSRb3SXpgo_BEdqZB-p1K5625fMegRZ17ZkPE1J8ZYgEHDg@mail.gmail.com/

(with some hacks) and verified that this change on top of a revert
of b17b7fe6dd (already in linux-usb) fixes the original bug.
The test does not excercise the code that deals with cable plugs,
though. Thus:

Tested-by: Christian A. Ehrhardt <lk@c--e.de>

Given that this is otherwise a 6.7 regression it might be
a good idea to consider this for 6.7?

> ---
> Changes since v3:
> * added partner_adev to properly put_device() on port altmode.
> ---
>  drivers/usb/typec/class.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 4d11f2b536fa..015aa9253353 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -263,11 +263,13 @@ static void typec_altmode_put_partner(struct altmode *altmode)
>  {
>  	struct altmode *partner = altmode->partner;
>  	struct typec_altmode *adev;
> +	struct typec_altmode *partner_adev;
>  
>  	if (!partner)
>  		return;
>  
> -	adev = &partner->adev;
> +	adev = &altmode->adev;
> +	partner_adev = &partner->adev;
>  
>  	if (is_typec_plug(adev->dev.parent)) {
>  		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
> @@ -276,7 +278,7 @@ static void typec_altmode_put_partner(struct altmode *altmode)
>  	} else {
>  		partner->partner = NULL;
>  	}
> -	put_device(&adev->dev);
> +	put_device(&partner_adev->dev);
>  }
>  
>  /**
> @@ -497,7 +499,8 @@ static void typec_altmode_release(struct device *dev)
>  {
>  	struct altmode *alt = to_altmode(to_typec_altmode(dev));
>  
> -	typec_altmode_put_partner(alt);
> +	if (!is_typec_port(dev->parent))
> +		typec_altmode_put_partner(alt);
>  
>  	altmode_id_remove(alt->adev.dev.parent, alt->id);
>  	kfree(alt);
> 
> base-commit: e7d3b9f28654dbfce7e09f8028210489adaf6a33
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
> 

regards   Christian


