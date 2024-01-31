Return-Path: <linux-kernel+bounces-46454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9012E843FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368421F22BC9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9567A715;
	Wed, 31 Jan 2024 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bE50ISoq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971077BB00
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706083; cv=none; b=c+TE8MLkTy7c/zL2p9CJmBSDjtxSQXPHUx+8oVhhcVmStYaq6yhk56PIHXey/4hid/Ow3WXToYgT79nQpcmAXEPFlleG0xXh5wEK0AZxh0FaXz1ixMCfrSHvvWuxEXpYSOe2gDsHntEsfal9eYtsAnwZAGfP3T4iutGBLqPwjME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706083; c=relaxed/simple;
	bh=iuYZLMjnUbawOeR31xImNNYkq3C/7t4cRKUneiauhwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvZ8X/ky1w0CMslEfqE8EzHurEFnIBuSL4JCvBTijEWbW2ONh3gWvVz/0CXYau4XiPQ+cdOfJp/0iSNQ1IzwyaxN2s+gUT/B5dnPUAlcfPDKvMa3qC4+1aIWYVNjkUvo7h97t3Z1sjlCwKw29xVy4mWd9L6MtJi7s15d9AlXrRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bE50ISoq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706706075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qn+iYS2LlFcVqPLusRdTgDr/wHRlQ/SFpOgOHT1uyag=;
	b=bE50ISoqj0zymb0me/39Jhp5gXx0sMXMk1nGFGwF5j1Y8j4TJM4CxjTvNTJYUMUSR+VOlJ
	M8LhAJEZ16EV/7madZ4EglSF0y3P04xYQuQLHSCD2KluOtgSQAEBnuTFoezSl8Gy84H69T
	7lGJ5ArgOljWFo22aw5bBAi9eXUm5qY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-cc3A9somNTiWN3t6zQReMQ-1; Wed, 31 Jan 2024 08:01:13 -0500
X-MC-Unique: cc3A9somNTiWN3t6zQReMQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d06d6974f4so2923911fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706072; x=1707310872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qn+iYS2LlFcVqPLusRdTgDr/wHRlQ/SFpOgOHT1uyag=;
        b=HODrv79+gHzxW+QZZNstIUp4MKarGx/iy848r9vydgIYzwzuJNltBFn3Do2FqgmIvj
         NkFiXe7BDXMBDK5pc2QhEPXSAyxREKyI8bCd+bDXwOqeLmhEkMsrRhscEccAUNXUUaqM
         Z5df8eWpjVTbt3rUbYZYIvqe/HHl2rV8OOFC/Wz8xUg/YQUsHhM3hm0p3BLuQCy5C7EH
         O6YTgsh0fljF32W+96uvxWKff8tVTAw25kJJwjX5B2ToR5LClmqIFhUwfupfTfVE5STm
         kOBAdOOm/aLYwDrlPsQHnjsjBbpgoo9t+g6TtXOhHp7a7vNxc5XiR/nv5yQJXSnKV5Kf
         smSg==
X-Gm-Message-State: AOJu0YxE47tYc6+cZdPMslA3PLaUSIV+E8V7aoZznwZRPJfxyzO7BYuS
	5x4VAfdCaL1sDqktj3qr4vys10ieMn+3tzu7e/GyJwv34NisTO296XL0qA11ugBAaEXUtM9cd8n
	8zAiZgImKZPZAPUduuAjKNZsMkptzroB2Dzcg4WwvEIJ4c4O9ItnYQw8k2KkuaQ==
X-Received: by 2002:a2e:9e17:0:b0:2d0:41be:9eec with SMTP id e23-20020a2e9e17000000b002d041be9eecmr1035481ljk.6.1706706072141;
        Wed, 31 Jan 2024 05:01:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGd10SIDbQpNCUKVs442JD5KhAj1sVBAgs+wQitBw7307bQExUlPBMAPUZxnN2YGMnlXVZ5A==
X-Received: by 2002:a2e:9e17:0:b0:2d0:41be:9eec with SMTP id e23-20020a2e9e17000000b002d041be9eecmr1035460ljk.6.1706706071751;
        Wed, 31 Jan 2024 05:01:11 -0800 (PST)
Received: from localhost.localdomain ([151.29.75.172])
        by smtp.gmail.com with ESMTPSA id m12-20020a056000180c00b0033b08f52d46sm473547wrh.116.2024.01.31.05.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:01:11 -0800 (PST)
Date: Wed, 31 Jan 2024 14:01:09 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>
Subject: Re: [RFC PATCH 0/3] workqueue: Enable unbound cpumask update on
 ordered workqueues
Message-ID: <ZbpElS5sQV_o9NG1@localhost.localdomain>
References: <20240130183336.511948-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130183336.511948-1-longman@redhat.com>

Hi Waiman,

Thanks for working on this!

On 30/01/24 13:33, Waiman Long wrote:
> Ordered workqueues does not currently follow changes made to the
> global unbound cpumask because per-pool workqueue changes may break
> the ordering guarantee. IOW, a work function in an ordered workqueue
> may run on a cpuset isolated CPU.
> 
> This series enables ordered workqueues to follow changes made to the
> global unbound cpumask by temporaily saving the work items in an
> internal queue until the old pwq has been properly flushed and to be
> freed. At that point, those work items, if present, are queued back to
> the new pwq to be executed.

I took it for a quick first spin (on top of wq/for-6.9) and this is what
I'm seeing.

Let's take edac-poller ordered wq, as the behavior seems to be the same
for the rest.

Initially we have (using wq_dump.py)

wq_unbound_cpumask=0xffffffff 000000ff
..
pool[80] ref= 44 nice=  0 idle/workers=  2/  2 cpus=0xffffffff 000000ff pod_cpus=0xffffffff 000000ff
..
edac-poller                      ordered    80 80 80 80 80 80 80 80 ...
..
edac-poller                      0xffffffff 000000ff    345 0xffffffff 000000ff

after I

# echo 3 >/sys/devices/virtual/workqueue/cpumask

I get

wq_unbound_cpumask=00000003
..
pool[86] ref= 44 nice=  0 idle/workers=  2/  2 cpus=00000003 pod_cpus=00000003
..
edac-poller                      ordered    86 86 86 86 86 86 86 86 86 86 ...
..
edac-poller                      0xffffffff 000000ff    345 0xffffffff 000000ff

So, IIUC, the pool and wq -> pool settings are updated correctly, but
the wq.unbound_cpus (and its associated rescure affinity) are left
untouched. Is this expected or are we maybe still missing an additional
step?

Best,
Juri


