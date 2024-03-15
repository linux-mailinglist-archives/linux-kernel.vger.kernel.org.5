Return-Path: <linux-kernel+bounces-103964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E222887C712
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8941C21E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A896253A0;
	Fri, 15 Mar 2024 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ru49e5Pn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA03E1870;
	Fri, 15 Mar 2024 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710465662; cv=none; b=YA+E4XVlrbaC3gfy7rATztfZapA13YEdu9Mfi1VPjw6qJA3NOc+MTbd/+V7ni+5wBhEzsrmWpfC4baP+QTeYluz+5f+U+tePdLwpGbZ7Qary0cUPiAL9YHZmRKWV/LfCxYfk2AlJm3JmL8yLUkvz5Savbho5MN4TJtDOsNbNQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710465662; c=relaxed/simple;
	bh=1xdJ3HdAN78ocHnoXuhLWvyY0aVJeqkpU7qV9STvrZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOEh2ADj0wIM8/Az81IgBPwtuKggxBqVpHA5JLPr+vlpc0yW3Kt7b24Lz3Iw6HXthu2VEO7YPpKiJqCwddbvHxCE2+cRyWTTe6mLXVA4CnsX1s14JZWp3AcETSS+l1GDRLL/NQzaLqUJjzX+lv3W+2tuslPjEw4eEh8W1vk1jR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ru49e5Pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454A6C433C7;
	Fri, 15 Mar 2024 01:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710465661;
	bh=1xdJ3HdAN78ocHnoXuhLWvyY0aVJeqkpU7qV9STvrZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ru49e5PnU1qD5UJimvvfLCz8W3T4guHd+ruFdmfKCdwj+PohcbMOKWVjNQ+ywKplI
	 dk/sU/hXGU9Amy3qDRtIjrJ+lufOzX6ZIU3gT8Cd89z5BiT1t28GagzKgk4/QfzlnG
	 h7xK+zC3OXbNMI2b/QNYn/qAEaHZ/IZsFOVh2irD7KU5Y13nUbKCqRxYM8eDr8rwoo
	 RSvDzddSo2gsDhYFTlU/H/X1scV9XvsaAFCVODrZK+bCNKa6KIc1Y8Qxqbcy5EF8hy
	 y6to2zPAWj7ohDxFC1/xVBedFPCTwKARM5EZq+jL5CwEsgtB26mjgw+Kh/So0Dq0be
	 dXP3xsxAUP2NQ==
Date: Fri, 15 Mar 2024 02:20:58 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Joel Fernandes <joel@joelfernandes.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	paulmck@kernel.org, mingo@kernel.org, rcu@vger.kernel.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, bigeasy@linutronix.de,
	chenzhongjin@huawei.com, yangjihong1@huawei.com,
	rostedt@goodmis.org, Justin Chen <justin.chen@broadcom.com>
Subject: Re: [PATCH] timer/migration: Remove buggy early return on
 deactivation [was Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU
 changes for v6.9]]
Message-ID: <ZfOielNSgWTRyDFB@lothringen>
References: <ZfIuRMo8oKbR08Af@lothringen>
 <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
 <ZfLUU+XuQC7W79tf@lothringen>
 <d6c8e4fe-17bf-443d-a6f5-54470390e1fd@gmail.com>
 <ZfNHNvzpqf8DOZd8@boqun-archlinux>
 <de038bee-cecd-4e76-b0f4-5822b68e439d@gmail.com>
 <87v85olez3.ffs@tglx>
 <87sf0sldbi.ffs@tglx>
 <ZfN0wY41pU5UjP8T@boqun-archlinux>
 <ZfOhB9ZByTZcBy4u@lothringen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfOhB9ZByTZcBy4u@lothringen>

On Fri, Mar 15, 2024 at 02:14:47AM +0100, Frederic Weisbecker wrote:
> This isn't proper to single level hierarchy though. A similar issue,
> although slightly different, may arise on multi-level:
> 
>                             [GRP1:0]
>                          migrator = GRP0:0
>                          active   = GRP0:0
>                          nextevt  = T0:0i, T0:1
>                          /              \
>               [GRP0:0]                  [GRP0:1]
>            migrator = 0              migrator = NONE
>            active   = 0              active   = NONE
>            nextevt  = T0i            nextevt  = T2
>            /         \                /         \
>           0 (T0i)     1 (T1)         2 (T2)      3
>         idle         idle            idle         idle

The "idle" below "0" above should be "active"...

