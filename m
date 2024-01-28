Return-Path: <linux-kernel+bounces-41835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD2583F837
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D236A1F2120E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D813731A89;
	Sun, 28 Jan 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AquRfRat"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2710031A7E;
	Sun, 28 Jan 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706459287; cv=none; b=ABoZ+NMxPS6SQzJJOat1QT3iQlNRNVPdhebDZTDuC00xxmA+55Hd26uPZP3D8kk3aGzXzc/Re9IKC0g8Sx+JOHQpDqTF/fwPU38DeVoyBLDOurRobIttWMCZCTgwe8nxcIt97yobDifxxEx/amkd5j4TMyw+YD8IXD5t+QQIdx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706459287; c=relaxed/simple;
	bh=/W2K331dVIKg1A5n58BV8W/mEY0UJaxcXNBQ+I1OcYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ai/pxUQVqfAT1NeTA745AI5OQfnPVZWEhgeCDxKvsqoK8+p6bvRfsF+0oU0hFld/kVG6dsuoPlI2uvjwjLNKvipjouDcXTSmU4MtU4x2YXuXINmkODSHfez902MHAY/+e25CdG25Xon/JXJUBrZjC/nap7ZHXiTtyV3eFCcSeAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AquRfRat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EA5C433C7;
	Sun, 28 Jan 2024 16:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706459286;
	bh=/W2K331dVIKg1A5n58BV8W/mEY0UJaxcXNBQ+I1OcYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AquRfRat1KOj7piVyl+sFa7F8s3phwllA7jHYvPOtsqPq1ozuXMsu/C42RmHIRzSf
	 5fxuwbfZ/2V9/IoKlUdQvnxsrsD/6/SNpjt2E/K/II1DIpNG6xb+sWc5HctqJ8und2
	 cd9xVu3L97GlW5qNazkFrkKywY4HHl9JhpjUqVvVoSfMA3CYBwBpbphECxGaV2zHaB
	 IpFafXZKa32vDwlxjecKQ+/WvKDZYCUw+iHF/9FeUvrogroeNPFtrv5b1RLLujcD8r
	 bazrqpR6bHbw3BNTbdYMQwxFGHyZAUQlsd2H2pEPlagKyVGQ/+y2VHZyC7LngojsJD
	 QIqn7+jxu34eA==
From: SeongJae Park <sj@kernel.org>
To: cuiyangpei <cuiyangpei@gmail.com>
Cc: SeongJae Park <sj38.park@gmail.com>,
	sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Date: Sun, 28 Jan 2024 08:28:04 -0800
Message-Id: <20240128162804.17866-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZbYanPU16klwz0HA@cyp-ubuntu>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 28 Jan 2024 17:13:00 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:

> On Fri, Jan 26, 2024 at 12:04:54AM -0800, SeongJae Park wrote:
[...]
> > So, 'update_schemes_tried_regions' command is firstly handled by
> > 'damon_sysfs_cmd_request_callback()', which is registered as
> > after_wmarks_check() and after_aggregation() callback.  Hence
> > 'update_schemes_tried_regions' command is still effectively working in
> > aggregation interval granularity.  I think this is what you found, right?
> > 
> Yes.
> > If I'm not wrongly understanding your point, I think the concern is valid.  I
> > think we should make it works in sampling interval granularity.  I will try to
> > make so.  Would that work for your use case?
> > 
> It's much better than working in aggregation interval.

Thank you for confirming.  I will start working on this.

> 
> I have a question. Why does the 'update_schemes_tried_regions' command need to work
> in the sampling time or aggregation time? 'update_schemes_tried_regions' is a
> relatively special state that updates the regions that corresponding operation scheme.
> Can it be separated from other states and controlled by sysfs node to respond immediately
> after being written?

Mainly because the region data is updated by a kdamond thread.  To safely
access the region, the accessor should do some kind of synchronization with the
kdamond thread.  To minimize such synchronization overhead, DAMON let the API
users (kernel components) to register callbacks which kdamond invokes under
specific events including 'after_sampling' or 'after_aggregate'.  Because the
callback is executed in the kdamond thread, callbacks can safely access the
data without additional synchronization.  DAMON sysfs interface is using the
callback mechanism, and hence need to work in the sampling or aggregation
times.


Thanks,
SJ

[...]

