Return-Path: <linux-kernel+bounces-102595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B063087B45C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23001C215DD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FDF5A7A3;
	Wed, 13 Mar 2024 22:30:10 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00525A0F2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369010; cv=none; b=KYuBb4SHPOeJetMHcDyw1uEFbwU+hpv+Wd1IRyPQxv863D/p7t6I7Sl/kAYXH6gyIAEUK+OCPf6AyY4t5EJ08ySYB3YvFZty7HW5tLEL/RxvVSe5C1yB3GKJzyEcML/96SPqHwldBV2yav50H9qjvEN426AGBy60PnXPRtqaOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369010; c=relaxed/simple;
	bh=zA8L9dl/wSQf3LOsBJYCnKq9EQ/7B4f8HMex6+vNx78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kabxQ37AsPBhv5TqfZOrs26ahZD3GyBtVvQtj/1O5X8TUuerGmbBvY50Pf0bySWKsRRpqg3Br1ADz3z9kShNcPI0Nh5R9e0fG3z3mH9uYXtySpOR46rdVHv3k/THbNRrYfSgmNyKNCk7ygrQhhSekGnSfku5I/lsxRybzIRJ4Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-690d7a8f904so12008676d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369007; x=1710973807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypwN72D6WSiCXDEdFEW1ml1qZjShXgvR6WGCfg4MWiw=;
        b=Xjuww8nOr5dwk0OThwi9kqKzQFHpldYkav2JCLxLlvDocNR9K4yL16HiUhQnn35OxY
         FvQqeHatVwSOs1sx/LNT82Ftft88zhUNg+JwB5UiYFPEX3hDmo4Rap0upDiqqq7ezXsy
         TZB0RHlzkQHqlfWaqxRDYShGEWosULjDEITGuzqCBiCMdyJ44kL3US4H4VGAVRzjzR8n
         m8GEJIRQp5B0yEiWjEDlPO72CC8hkHqt8Ap4dRL/wcsLhjGm0JxEdkZdRznXYs/7E3fv
         +spf/VhO3VD/IpJuly6Vewh0A/PRV630MkjF9O43ILGXcqLQmmi+hQLtgRiS+WkSttJh
         l2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwbSyVC8FNbWnlO+zoscXn/j9+31uosOXa0MrRxsm3HFzTaL+47VfxZnEfy2zyBaSFyThkRa0AR8ot6u5YBHsBK5LpQFQmUBT9sJnH
X-Gm-Message-State: AOJu0Yxe5LVciFvyYW3BLuY5HxV4iE66iDJwTUJID0DPqfL6qLKh/5z7
	ogj+AV1YLIlRGxVpRZF/dZYjhX9Pxk8o/cbRn2AWdHsykXiNukmVEKKkB38Blw==
X-Google-Smtp-Source: AGHT+IGnCLzp/F/J8tCSNp7XYXpPLqx0Zr077oVBAbRRQhX+oK2RKVWjZjJUrYBSm9qIIENOAZUndA==
X-Received: by 2002:a05:6214:2589:b0:690:abe6:b6d3 with SMTP id fq9-20020a056214258900b00690abe6b6d3mr2319628qvb.4.1710369007658;
        Wed, 13 Mar 2024 15:30:07 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id 7-20020a05621420a700b00690bfb6aac7sm115430qvd.51.2024.03.13.15.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 15:30:07 -0700 (PDT)
Date: Wed, 13 Mar 2024 18:30:06 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Alasdair G Kergon <agk@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the device-mapper tree
Message-ID: <ZfIo7nbWA3pSeY3z@redhat.com>
References: <20240314084050.2fe3eb9f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314084050.2fe3eb9f@canb.auug.org.au>

On Wed, Mar 13 2024 at  5:40P -0400,
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
> 
>   2da6b3c1317e ("Revert "dm: use queue_limits_set"")
> 
> This is commit
> 
>   bff4b74625fe ("Revert "dm: use queue_limits_set"")
> 
> in Linus' tree.

Sorry about that, fixed it up.

