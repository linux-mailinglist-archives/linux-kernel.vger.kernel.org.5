Return-Path: <linux-kernel+bounces-85230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4CA86B288
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8A01C254EF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B581215B98D;
	Wed, 28 Feb 2024 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHGCC82G"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE515B966
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132381; cv=none; b=opLAr5OxDQ6YT7dFPWjdAoq+L8sk+vrqmpXUnELsDiIwn2cyLsKlofC5gRRzEhkgrQ37KrLSUY0wXlMjS9O7XClge2krk5z1uS/0mT1uJRebEaeROm0fCrLO4i1Om0iUAAuaW44/MnyzbYMyHcjRBCny08s+IxvzvKcHIgT24Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132381; c=relaxed/simple;
	bh=DGibxGXROfONoqQx0DYX48YEs23do8kEJg5PaBmKah8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fg01V3xCK9fM+62NDzI+gg/7vvC6gDJaMYPUAeTrwo3GOZ4bTO8Re362fspFAjDoUgNNdCjaTgPVwGWl63OAarMZOqgVGdzO6ba4OMtsZxrlEh5oA9NNyJOakoIOiM9jUnPBB1tpiahl4euaiD7iEAGZQwOi+CRR16l/8iWG8dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yHGCC82G; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412949fd224so5936955e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709132377; x=1709737177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rbrx7HVa2y5fUE9QU+x+EKnMvXEJQXBHESgYcH8oieA=;
        b=yHGCC82GKurxUf1GMdZo7v8eQMvPo0SYB9A5P3+tWrRxZCGGp57JCZefy73yrc30Xm
         06b6GUF60XNXLtiLpH515CyWM8edfDpEyHZ4QVrga07VV4V8Pp/tIN2RQIlaRKdFGwjH
         J5isN3+YK5/RMeMochXSUcV5NIQ4OeNndG/MXoitUA86Dllyes1pL4DAJmrHF4ffC2KT
         iU7kLbUbVCM2sUG39gcpoJxENypeA0Es6K0mh53HsqlYbkg4/9DxzelzjAY0CMBWhlaN
         zmfy3dVyb7Qb8ltOsn4EPaB8fncQuDqpeDxiZBRiINxudo69oAAb2FAgdOHvCvyOx0ar
         oTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709132377; x=1709737177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbrx7HVa2y5fUE9QU+x+EKnMvXEJQXBHESgYcH8oieA=;
        b=wkq6DAk0t2fliuF3xHvVMdisn7Q5oT2IQqMIEgA62e1B4DEnzkzq2z4PN3AOTSSvL2
         xaIUUtXfkL8B3TIBUoo3XuZ7l6XCVAZjlLHdXiQlT5mgrFCgMKK56GnvAapKMeq19ALg
         c2B2xTVweeS9fYZlFYD69gRErx9sp/3HqrvTbMZhg5v+g5p70SkNGVDVCBpIBEm/ns2u
         D+3mMmm0XpYNAKXPlg/rIXg1XUB4ARezG6u77wP0Di00f+8ZzYRXm3GvRUyij+jbUG1F
         FUWWWM7d1mTDPhT1LtKvyLQX4PZx8+LgK3xqj5BLg6lEtBUQdOiciyatk0kky/vsj47Q
         s9ig==
X-Forwarded-Encrypted: i=1; AJvYcCUMASQ3wAw/jZECcNbukQHA836NLJas5gsvETzwbD/iUviV6lXXrgU7klbk962sJRuzVadL82MxbKC4iid0WR6S4X9mI94HetLUxKdQ
X-Gm-Message-State: AOJu0Yz6UJirlJ+NLCt5KP/PKzYL7rldxgxNwWbikhlPwY3CaYR9BrAu
	vi9b3yhF6tKpIcVcj+8DKSppt4W199+qAg2f6iwygWDW5gNDD2W+0BJxLA82X9s=
X-Google-Smtp-Source: AGHT+IFchycGMykpHbANjTJFoomdujpktccrhzPLJQUuqBou81fEAjdXv27WGdHHfvK2TAZOUqVLxg==
X-Received: by 2002:a05:600c:4f0c:b0:412:b431:eb31 with SMTP id l12-20020a05600c4f0c00b00412b431eb31mr1837067wmq.18.1709132376444;
        Wed, 28 Feb 2024 06:59:36 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id k8-20020a7bc408000000b00412b011458fsm2304389wmi.30.2024.02.28.06.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 06:59:36 -0800 (PST)
Date: Wed, 28 Feb 2024 17:59:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@seco.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: fman: Use common error handling code in dtsec_init()
Message-ID: <8e3b3338-d2f9-44ac-bcf6-e53ccc3c9cb2@moroto.mountain>
References: <9b879c8d-4c28-4748-acf6-18dc69d8ebdf@web.de>
 <20240227184657.76ec4e82@kernel.org>
 <Zd7mFe3-kbqjGpxh@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd7mFe3-kbqjGpxh@nanopsycho>

On Wed, Feb 28, 2024 at 08:51:49AM +0100, Jiri Pirko wrote:
> Wed, Feb 28, 2024 at 03:46:57AM CET, kuba@kernel.org wrote:
> >On Tue, 27 Feb 2024 14:14:52 +0100 Markus Elfring wrote:
> >> Adjust jump targets so that a bit of exception handling can be better
> >> reused at the end of this function implementation.
> >
> >Okay, but..
> >
> >>  .../net/ethernet/freescale/fman/fman_dtsec.c  | 19 +++++++++++--------
> >>  1 file changed, 11 insertions(+), 8 deletions(-)
> >
> >..you've added more lines than you've removed so what's the point.
> 
> To have cleaner error path? Not always lines of code is the correct
> indicator of patch quality :)
> 

I really don't like those goto e_nomem type of things.  When you're
laddering gotos you should do that kind of thing before the gotos so
that when people add new gotos it doesn't make a mess.  It's the same
for unlocks, do that before the goto unless it matches a lock at the
very start of the function.  Or if you're doing a goto from inside a
loop then clean up the partial iteration through the loop before the
goto.

regards,
dan carpenter


