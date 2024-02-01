Return-Path: <linux-kernel+bounces-48794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3763084618B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D741C25E63
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BD685278;
	Thu,  1 Feb 2024 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTRQ4Hna"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE14285286
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706817377; cv=none; b=W2YRzMs9m251kVrdWuu/qHgW1pV2ABYwbD/DzeqZzbEsaBwJqx66kSee9zwt1scBNwdb4li/sWujcpLpLDb+vyGDn+6dUh+g/Zr3ebVavPalxYcgkr1w4BbVZ9zS45Y2RX1hh2JANlzW0fOjIB479D/eEsvlxlGS5V6JQSfWA98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706817377; c=relaxed/simple;
	bh=TyvARfG5cdiLS3Lx957Ua1EFLe1TpBHS0WmMWNXQHGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InTWaVbt+IAU+dWdH8qX+H8Ug1nMQx1oK8UBjp31EyFXsnkZmATUuNAwC0ooC/V4fRHlFbBIWxWrU0jjmrF5x2eI3aD4pYWDAa5fHPmDaKmjo2MpvP7MHkM/TOQcdpVd/2HNG7Q8hCRaRgZWGtYsbILtcKmLvnD1OT0traoCVSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTRQ4Hna; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706817374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iN9wTYAiEZqmVZSRGp3IE12Ur++dFYxvXqv8nbWcyFg=;
	b=DTRQ4Hnaubahspwx54qtR7ubNcdJwXU4sKmDD/SKuTVJ92bACyRN2QF/mLHMqCxK+X8sFm
	+5hoDjhjXOUgzDAirYLhJoUp9DydRg7ncYio7FxVq8nrBmZJen7XkEh21adiZ6WKM+k+t6
	elDp2D1qSB9OdS3AJgQCoDQauTbkWiw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-2hoVCHGRMSqXp1LTv0T2SA-1; Thu, 01 Feb 2024 14:56:11 -0500
X-MC-Unique: 2hoVCHGRMSqXp1LTv0T2SA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E92FF8489F7;
	Thu,  1 Feb 2024 19:56:10 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B007A2026D66;
	Thu,  1 Feb 2024 19:56:10 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id CA31C402492AA; Thu,  1 Feb 2024 15:45:01 -0300 (-03)
Date: Thu, 1 Feb 2024 15:45:01 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Parshuram Sangle <parshuram.sangle@intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, jaishankar.rajendran@intel.com
Subject: Re: [PATCH] cpuidle: do not shrink guest poll_limit_ns below
 grow_start
Message-ID: <ZbvmrdBkeOK71KGg@tpad>
References: <20240111135950.17016-1-parshuram.sangle@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111135950.17016-1-parshuram.sangle@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Thu, Jan 11, 2024 at 07:29:50PM +0530, Parshuram Sangle wrote:
> While adjusting guest halt poll limit, grow block starts at
> guest_halt_poll_grow_start without taking intermediate values.
> Similar behavior is expected while shrinking the value. This
> avoids short interval values which are really not required.
> 
> VCPU1 trace (guest_halt_poll_shrink equals 2):
> 
> VCPU1 grow 10000
> VCPU1 shrink 5000
> VCPU1 shrink 2500
> VCPU1 shrink 1250
> VCPU1 shrink 625
> VCPU1 shrink 312
> VCPU1 shrink 156
> VCPU1 shrink 78
> VCPU1 shrink 39
> VCPU1 shrink 19
> VCPU1 shrink 9
> VCPU1 shrink 4
> 
> Similar change is done in KVM halt poll flow with below patch:
> Link: https://lore.kernel.org/kvm/20211006133021.271905-3-sashal@kernel.org/
> 
> Co-developed-by: Rajendran Jaishankar <jaishankar.rajendran@intel.com>
> Signed-off-by: Rajendran Jaishankar <jaishankar.rajendran@intel.com>
> Signed-off-by: Parshuram Sangle <parshuram.sangle@intel.com>
> ---
>  drivers/cpuidle/governors/haltpoll.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
> index 1dff3a52917d..663b7f164d20 100644
> --- a/drivers/cpuidle/governors/haltpoll.c
> +++ b/drivers/cpuidle/governors/haltpoll.c
> @@ -98,10 +98,15 @@ static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
>  		unsigned int shrink = guest_halt_poll_shrink;
>  
>  		val = dev->poll_limit_ns;
> -		if (shrink == 0)
> +		if (shrink == 0) {
>  			val = 0;
> -		else
> +		} else {
>  			val /= shrink;
> +			/* Reset value to 0 if shrunk below grow_start */
> +			if (val < guest_halt_poll_grow_start)
> +				val = 0;
> +		}
> +
>  		trace_guest_halt_poll_ns_shrink(val, dev->poll_limit_ns);
>  		dev->poll_limit_ns = val;
>  	}
> -- 
> 2.17.1
> 
> 
> 

Looks good.

Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>


