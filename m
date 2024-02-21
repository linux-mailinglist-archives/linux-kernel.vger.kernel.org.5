Return-Path: <linux-kernel+bounces-73917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B029485CD95
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1DE1C22DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40326FBF;
	Wed, 21 Feb 2024 01:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qv6zTSYt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A6A63DD;
	Wed, 21 Feb 2024 01:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480435; cv=none; b=U0B4jN67OSgd39l/oif4+S3fU7jRyCaihGnt7Tba9yOkvRKQnf/G4RjLtbowdLKC3/uqQDIBwvw19EasgMHPEEg6bHfOCBoSgLJYebot8IybrwDLIm3BoetcTBuH/k8+Y++XilIfaoYkvJEMc93MVnna1JLCzqa2/aKQcMO89WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480435; c=relaxed/simple;
	bh=L/2v3iSlKNPFRF36MqloXyokn7cW8/ARD/Ff7gqonv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izx77VIgcxXm3ITYS8fFrq6AOG24W+7Iv8J0IAUhkkHsDDHIcYnLv8ewl16wG0PVzl6JZWdd/r4aqwn9GZe949taSGNJVqGzW/OkOmLSnK88GMBKb/VEyvWtisajp0cxffNWSP89BwDp/+CqkMyZ02RbTODLd573mBvaMKcyzAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qv6zTSYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A93EC433F1;
	Wed, 21 Feb 2024 01:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708480434;
	bh=L/2v3iSlKNPFRF36MqloXyokn7cW8/ARD/Ff7gqonv4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qv6zTSYtxVinYMnQP0hRlpxBBkWbrJEemqismf8LJk9epGMh5ze+QpHGSqRy2EZDk
	 lTtY5ULt0EAWt3kf6ywzCk+HEZeTSkQ299rNV9cEabM+xq5pp3Im5QF9l2eAd3f+AA
	 mIwA1Z1kpYLJcMPYeURHdsy4ReBrX2ulCOaxMcqIn/lZGyhvrgNav8thOjZvV4oYAw
	 tnLnpXP3sDKwBYh9yzjUBlyCM6a35xQgALQBBEolOhCSzgKoiF5F6dDdjfpshm75d8
	 3nB08FyqdFkURV9xbX2qJcTD6uDxSV+mU1Jbsqdm1Skxlf2UiBZCxEbvOkkbORUI1u
	 /a0nOBP4iTPkg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 08BFDCE16C6; Tue, 20 Feb 2024 17:53:54 -0800 (PST)
Date: Tue, 20 Feb 2024 17:53:54 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v5 0/4] Reduce synchronize_rcu() latency(v5)
Message-ID: <70c597d0-7c4f-4b55-bdea-f6bc411862f6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240220183115.74124-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220183115.74124-1-urezki@gmail.com>

On Tue, Feb 20, 2024 at 07:31:11PM +0100, Uladzislau Rezki (Sony) wrote:
> This is a v5 that tends to improve synchronize_rcu() call in terms of
> latency reduction. This has been developed together with Neeraj Upadhyay.
> The delta between previous v4 and v5 is rather small. Main difference
> are cosmetic changes related to patch squashing and data structures
> splitting.
> 
> It is based on Paul's dev branch.

Very good, thank you!

Queued for further review and testing.

							Thanx, Paul

> v4 -> v5:
>  - furthers squashing to reduce number of patches;
>  - remove the CONFIG_RCU_SR_NORMAL_DEBUG_GP Kconfig option and
>    reuse already existing debug option which is CONFIG_PROVE_RCU;
>  - add data structures in a separate patch.
> 
> v4: https://lore.kernel.org/lkml/ZZ2bi5iPwXLgjB-f@google.com/T/
> v3: https://lore.kernel.org/lkml/cd45b0b5-f86b-43fb-a5f3-47d340cd4f9f@paulmck-laptop/T/
> v2: https://lore.kernel.org/all/20231030131254.488186-1-urezki@gmail.com/T/
> v1: https://lore.kernel.org/lkml/20231025140915.590390-1-urezki@gmail.com/T/
> 
> Uladzislau Rezki (Sony) (4):
>   rcu: Add data structures for synchronize_rcu()
>   rcu: Reduce synchronize_rcu() latency
>   rcu: Add a trace event for synchronize_rcu_normal()
>   rcu: Support direct wake-up of synchronize_rcu() users
> 
>  .../admin-guide/kernel-parameters.txt         |  14 +
>  include/trace/events/rcu.h                    |  27 ++
>  kernel/rcu/tree.c                             | 363 +++++++++++++++++-
>  kernel/rcu/tree.h                             |  20 +
>  kernel/rcu/tree_exp.h                         |   2 +-
>  5 files changed, 424 insertions(+), 2 deletions(-)
> 
> -- 
> 2.39.2
> 

