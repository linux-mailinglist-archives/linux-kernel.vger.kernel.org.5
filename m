Return-Path: <linux-kernel+bounces-33877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D88C837186
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55E91B34765
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4C95024F;
	Mon, 22 Jan 2024 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C99ZHiti"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1450243;
	Mon, 22 Jan 2024 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946175; cv=none; b=Rzq8BZCvebcfjKtY5EQbtGNUAwMnWA1XdOG5veTV3Aw1w5yBKtJwvUBvo8p4f6oxKxxEksbg3hB2vVvNEJ8dhOQMm9ihSUVXBt1Q2rqnr/rtYgQy55AUT6H5QhMrtbpO2QKKVhk9ylcDEtL9+KC1c+RBuSaSm09Spm4FELAPGn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946175; c=relaxed/simple;
	bh=TV6kmzHej1eOV5PjQSphBRoan0WDagVe/CDQQutnVms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g5GItIKu4dEmhL7cbTOhxKrA/cesNX3HnVGZ3PhNrSnSIEc4AUcFa5wYvr3lB1xhMn0ChVG2fim/AdHnUCDGBJ9Np18pY07YD/An96BKF36r09pVFH9D0JCi6xfro1FIjDpUl6R09EGVeVSU0GimtyU9eJDhV/6Jf1PYS7EvkVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C99ZHiti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA75C43394;
	Mon, 22 Jan 2024 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705946174;
	bh=TV6kmzHej1eOV5PjQSphBRoan0WDagVe/CDQQutnVms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C99ZHitiFHDxHhxnoMTF5gAzLE7++CpQpMeXRlUQsFxHsUB8CvFe+EmaQnDkm1LxZ
	 xTl8o7x6lP4TVp7f0WkAAmI+YG0zgsWuX8zny8qcmgY+I08A5Fkkbdu04b4nKgKRJG
	 ASFLI8sp8Ske/N5O6nArJFNZP/pkaccnQR5XXDv5fCxOtZjk4hC6UE/i3ytTP05HXn
	 DkSNQjk1tLz9gennB6lKei8WX947rjoz1FG1geXSR9xsLI6agR45ErxBZiTKYd/vo4
	 agzQTg0fSaMXdekwuD3zWHOT5xRKRhboUT4Ht1j9+IHayslRyyJzjdECJ4QEpDfyKB
	 fknoz4UgvnHAQ==
From: SeongJae Park <sj@kernel.org>
To: cuiyangpei <cuiyangpei@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Date: Mon, 22 Jan 2024 09:56:11 -0800
Message-Id: <20240122175611.46371-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122054631.GA7880@cuiyangpei>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi cuiyangpei,

On Mon, 22 Jan 2024 13:46:31 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:

> On Sun, Dec 03, 2023 at 07:37:45PM +0000, SeongJae Park wrote:
> > On 2023-12-03T13:43:13+08:00 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > 
> > > On Fri, Dec 01, 2023 at 05:31:12PM +0000, SeongJae Park wrote:
> > > > Hi Cuiyangpei,
> > > > 
> > > > On Fri, 1 Dec 2023 20:25:07 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > > 
> > > > > On Thu, Nov 30, 2023 at 07:44:20PM +0000, SeongJae Park wrote:
> > > > > > Hi Cuiyangpei,
> > > > > > 
> > > > > > On Thu, 30 Nov 2023 17:14:26 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
[...]
> 
> Hi SeongJae,
> 
> We set 'access_pattern' and 'stat' action in schemes when apps are on
> foreground, record apps' memory access pattern when they are switched
> to the background with 'update_schemes_tried_regions' state. But it
> catch the snapshot after next aggregation interval. DAMON is still
> sampling during the app switches to the background and the next
> aggregation time, which can cause the value of "age" to change. The
> sampling results during this period cannot accurately reflect the app's
> foreground access pattern.
> 
> Is there any way to catch sampling result immediately after setting the
> "update_schemes_tried_regions" state?

There is no way for exactly doing this.  You would need to proactively collect
snapshots while the app is foreground, and use the latest one that collected
before the app goes background, like recording-based approach would do.

I think recent DAMON changes might make an alternative approach available,
though.  From v6.7, DAMON provides pseudo-moving-average monitoring result in
sampling interval granualrity, since patchset "mm/damon: provide pseudo-moving
sum based access rate".  And a followup patchset, namely "mm/damon: implement
DAMOS apply intervals", has made DAMOS works in the sampling interval
granualrity.  Both patchsets are merged into v6.7-rc1.

Hence, I think you could use 'update_schemes_tried_regions' after you noticed
the app's state transition, with DAMOS apply interval of one sampling interval.
Then you will get the monitoring results after one sampling interval.  Of
course, the snapshot may contain some of background access pattern, but
wouldn't made it changed significantly, unless you set aggregation interval too
short.

> Alternatively, can it return the "last_nr_accesses" and "last_age" values in
> tried_regions/<N> directory?

This could also be a good alternative in my think.  Nice idea.  But, because
the previously mentioned alternative is already available while this require a
bit small but additional changes, could we check if the previously one make
sense and works first?  We could revisit this idea if it turns out the previous
alternative is not suffice in my opinion.

> 
> Do you have any other suggestions?

As I mentioned above, I'd suggest the DAMOS apply interval of single sampling
interval for now.


Thanks,
SJ

> 
> Thanks.

