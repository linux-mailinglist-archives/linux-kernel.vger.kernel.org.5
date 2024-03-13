Return-Path: <linux-kernel+bounces-102208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD4187AF6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883F41F26796
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF1F1A00DD;
	Wed, 13 Mar 2024 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCFsbMRE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8711A00CB;
	Wed, 13 Mar 2024 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349503; cv=none; b=CIOCr4EuNkebqaq+L9mce1k9psKtkB32Rte0aOo0w9zcc7/dbTUX3dIdgkTzMvu5VA/cZG8OqaZvFaajGNiwETPUlWYVoue7tWfnNl4j9VDztRl/L+nKyx5C44xBb/Y2Y6HxaXN/LakMLRSXIe30O7vMZ7D2MnqPB0O91W+c09c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349503; c=relaxed/simple;
	bh=3HkGt1kMjSGQ6a0wzmZyjXZ7wSJYIP5rRmWt5oIKzQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvPAZCvf9HLG3eBGZuWMQ7rzSHxDeJIsbYNi8yGrsEyfb587EjnXvpYr/iiFk+U6abkKrpyFahsA8iE7txPbsPABp4XnpwFdUc0l0DFV6A+G/s6SP1bjmT73DdVYiYZw4HT26rt8J8KeWiW4+I5zDJlTP4gl0V8ea8WYuieW1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCFsbMRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DDDC43394;
	Wed, 13 Mar 2024 17:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349502;
	bh=3HkGt1kMjSGQ6a0wzmZyjXZ7wSJYIP5rRmWt5oIKzQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCFsbMREntqbQyxFW7IZHwDCiJSAzCRCm383ZTlUeeYOrFSJ0xMNbY4z8PHNty62j
	 o+KHCHblGAauSmwSD22Ttvrf+uZ8NFu9paFkgN+L5Td6NieHZqA6E8ECnXN7zI3fFT
	 AmmMaOMk6s1OQdXDDsDAt+wxfDBFgr/yZThBQsWVeuVnSjvlAGXJHph04vCygHygtU
	 rqtK9I9KZDrEogvl9x/8xYVmbNHj+s/Y1o7PUrFsKeDVI4xCy5yMYh8USlNd+E276U
	 s5a3qG8BWlmyaK30YksYT2iT348U7w1Sv7+YTXShbjrWJGk379hAFcvPRiFNEyVrH1
	 o6JA806m9B6zw==
Date: Wed, 13 Mar 2024 18:05:00 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: paulmck@kernel.org, joel@joelfernandes.org, josh@joshtriplett.org,
	boqun.feng@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org
Subject: Re: [PATCH] rcu: Reduce synchronize_rcu() delays when all wait heads
 are in use
Message-ID: <ZfHcvI54IrbQTjbP@localhost.localdomain>
References: <20240313083228.233247-1-Neeraj.Upadhyay@amd.com>
 <ZfHDwPkPHulJHrD0@localhost.localdomain>
 <35e009c4-d52c-4b96-ba10-afa0be9dfd5e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35e009c4-d52c-4b96-ba10-afa0be9dfd5e@amd.com>

Le Wed, Mar 13, 2024 at 09:41:58PM +0530, Neeraj Upadhyay a écrit :
> > Also there is a risk that this non-wait-head gets later assigned as
> > rcu_state.srs_done_tail. And then this pending sr may not be completed
> > until the next grace period calling rcu_sr_normal_gp_cleanup()? (Because
> > the work doesn't take care of rcu_state.srs_done_tail itself). And then
> > the delay can be arbitrary.
> > 
> 
> That is correct. Only the first node suffers from deferred GP.
> If there are large number of callbacks which got added after
> last available wait head was queued, all those callbacks (except one)
> can still have a GP assigned to them.

Oh and yes I missed the fact that you still reissue a GP while queueing
a non wait-head as ->srs_wait_tail. That point looks good.

Thanks.

