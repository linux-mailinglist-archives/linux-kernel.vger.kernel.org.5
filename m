Return-Path: <linux-kernel+bounces-149770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57548A959A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40A30B2173F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CDA15A499;
	Thu, 18 Apr 2024 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBrmcrLk"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC377BAF0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431144; cv=none; b=SSVkPyQpkRyvBqNqVK9dMIiSLZcsV9MS+4UU9jIx5kHuH+5s9CiWyqkL8hp7Yh9KWfUuaILadB21ONvxzSWUHA9JMN9GVvAbviq6MxXo4HD5qSMTFPh4d0Kw6brbcLypffZVjQevqMfD1QLOTwvnwvndJzSQEfA14MnL1bGnnys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431144; c=relaxed/simple;
	bh=ePckogndbT/HMJ6Dkb0NZIGm65xXskRus//486LRAjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhWGSCZJ+433OOUQ5SA3i1K2KFwXro8+NknTqo/kWJ6u5dsAsZBrnb+QF9MDVX3AE1D6lE7gkzDYzZ1axMCiV7PbdZ0sH3xKsQwqbU2yoBqr1GAsHYgWTIEYAhL4kt/FQYc03MTBra0t4483K57OnIg0HXVyPxx4/Tg3Rw7tkA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CBrmcrLk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4167fce0a41so10074395e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713431141; x=1714035941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=euB3vcyNRkqSsujp1rBWtIUz95ZDQeOsD0X15ArXVN8=;
        b=CBrmcrLk/ovs2ABxT0cXYt1PpOu/cfPoycdKTlppbhZT93KsoSc8My+yyDEZbQNzJA
         jCZkh0arON1rZoxu25X062rq4XjS6rYmlR25CBUTuH5H0F02UPDlPm7FObx+wZWUj6fG
         DkahhAJcYdfybPWs2olLJw9gGh3oCrRoxt6MRNLi98WitTuG784kINf/H1uYyxJeRB+f
         kvcFaRRo9LP1uzj0Flq4U7Dls0+uxOMO/1s7Ud6FvY33Swyh6SASXpO1vvhBk8KewF6a
         HveSTyE4+d5IpFeyY+eA5/siXbs1V2dP2Y2neU69jEsT3+iAOSzufHkngoP8daKBPBpU
         K4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713431141; x=1714035941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euB3vcyNRkqSsujp1rBWtIUz95ZDQeOsD0X15ArXVN8=;
        b=NsfCJIes7F+FFOw336Rw04SWM1tGvNGcRUvxtMpAO23DZy8SfWcjqchchdbVdF33gw
         eFP4xbttnpvjwK4kEs4taUVVmMqEkfBhQiM7vZOR7+v+ZRRacYsWCNfffp88h9vs9AYa
         l7mUO+AFlxo+HMYiKUXkGCg/8rC0Q7kOyvDBINnBEd8W5zjXNnDzezcYzipOKL7zOSXM
         3FJzIvGZJz+G2lD6slFtZRB+VZRDoD143YjFEeIhASMYcusT+3I5Iko4S8qVaHsNtHJj
         2Cve5kVWX7ljWIa8bPYCLa4S85TsNM83lLu+JvB3vqTJYsiG99jJ0RIvIKvYJzAJJmlS
         mMNA==
X-Forwarded-Encrypted: i=1; AJvYcCW5R7XXp6Y9e4+u0poZlfXYcQeeS7gwU3YH2NHaRyZpigWY/mVgrj/W+UVBTCoW6V42v7mqjZDadx6xKUeNi71JCBXn63jK9tQ5WB6d
X-Gm-Message-State: AOJu0Yw57sKzqYUwSlLgDJ2+CyZy4dpLyxoeJS3bg1jED9obXasxkqKf
	aCfQt+6CIOsuv56e0nnNJMG5YOT9SkAq4cDoUFBxn++B499i8rADjNAWLnue7Yo=
X-Google-Smtp-Source: AGHT+IG5HhSMVcn1nLDLtOfxsytHEqcveQ4MV1aOv60X6+6dklq/C+iAIIstaQcJbkGV6ywa6bgoKQ==
X-Received: by 2002:a05:600c:3554:b0:418:3ad0:742 with SMTP id i20-20020a05600c355400b004183ad00742mr1223954wmq.4.1713431141344;
        Thu, 18 Apr 2024 02:05:41 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05600c3d8b00b00418effbc4f7sm557536wmb.38.2024.04.18.02.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 02:05:40 -0700 (PDT)
Date: Thu, 18 Apr 2024 10:05:43 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Liuye <liu.yeC@h3c.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	"dianders@chromium.org" <dianders@chromium.org>,
	"jason.wessel@windriver.com" <jason.wessel@windriver.com>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: =?utf-8?B?UmXvvJpbUEFUQw==?= =?utf-8?Q?H?= V11] kdb: Fix the
 deadlock issue in KDB debugging.
Message-ID: <20240418090543.GC162404@aspen.lan>
References: <186cdeea58094d06b351b07eefa2189d@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <186cdeea58094d06b351b07eefa2189d@h3c.com>

On Wed, Apr 17, 2024 at 11:01:56AM +0000, Liuye wrote:
> >---
> >V10 -> V11: Revert to V9
> >V9 -> V10 : Add Signed-off-by of Greg KH and Andy Shevchenko, Acked
> >            by of Daniel Thompson
> >V8 -> V9: Modify call trace format and move irq_work.h before module.h
> >V7 -> V8: Update the description information and comments in the code.
> >	   : Submit this patch based on version linux-6.9-rc2.
> >V6 -> V7: Add comments in the code.
> >V5 -> V6: Replace with a more professional and accurate answer.
> >V4 -> V5: Answer why schedule another work in the irq_work and not do
> >          the job directly.
> >V3 -> V4: Add changelogs
> >V2 -> V3: Add description information
> >V1 -> V2: using irq_work to solve this properly.
> >---
>
> What is the current status of PATCH V11? Are there any additional
> modifications needed?

I understood that is blocked pending outcome of the legal matters
raised by v10...  and that this is why you were asked not to post
v11 until they had been resolved.

To be honest given that [I wrote all of the C code][1] for the most
recent version of the patch and that I'd like to see the bug fixed,
then I will probably have to give up on co-authorship. Instead I can
post my code with a new comment and patch description and credit you
with a Reported-by:. That should take the pressure off in terms of
landing this bug fix.

However, the legal issues do still need to be resolved or there is a
risk that other upstream contributions from your company will be
delayed.


Daniel.


[1]: https://lore.kernel.org/all/20240314130916.GE202685@aspen.lan/

