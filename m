Return-Path: <linux-kernel+bounces-63346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 654C6852DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3FC1F2440E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332E324211;
	Tue, 13 Feb 2024 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko+lawr9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743DC224FD;
	Tue, 13 Feb 2024 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820306; cv=none; b=BaUrEz0DZgh2UXZFKh2hau1t+EGEWQOVkUbNZ+21UEdNveZKhAS8Zi7f44Ni5eiTuSYM9ZMVz+jFmEpDbGin7f1+N3J6R4vBDDcNZ3767Jjcv45TVWZoMgj8dOeNAPgUJ4+LfHd6gP6DKntaQ8kyLwIFAuOdOQ4hZmz3utahksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820306; c=relaxed/simple;
	bh=JDNHbbKp8STLxl2eJjaYZi1jIUAoP4cihuNPOeU+wfk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tNB1aRc8D8J2S2PgFFqqoiXt9txZFQyETFX2fro531drkw5fksbI2wHJD+GXAk6PWSn22sYhN/r2H99Rnd1oW+1NTbryWqmoiQiVbUrNX75NpjhnGXRJ3VC/Dc5n1hbwrv20r2piqQjwN97r5bd/dw6r/wK+/rt9CBHNN6F/DJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko+lawr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EE5C433C7;
	Tue, 13 Feb 2024 10:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707820305;
	bh=JDNHbbKp8STLxl2eJjaYZi1jIUAoP4cihuNPOeU+wfk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Ko+lawr9LKclRY33881h2C5+c+BCuJQONIjOypLerZY9awYs5Y08LQ/+9/BM38vGK
	 tCN9Ilctc5pnfGTC6xDv3ImChBAmYBCm3Xfba45i/Zmdyx8t+zl/7+Pj8lxpos6gDP
	 m7uwlFOVlh9O8qPDAPJzi4B8WET7HbzAR+c43AuPdlJ7NKuoG73dSN6QPZxOOOQsGn
	 7MWCt7cmVRl/e8nnEIVa2yV9k35PnBalVoXrOXijVQViNdYBtzooex7rhMrg3mKeE/
	 K+HSVbTwOZA0gLhAhhD+YIo86ZzEiV9jo5vZFkku1J34virneND8gTU0C/BoBdlip0
	 gfa7WgRdd0Wdg==
Date: Tue, 13 Feb 2024 11:31:46 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Even Xu <even.xu@intel.com>, benjamin.tissoires@redhat.com, 
    linux-input@vger.kernel.org, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: Intel-ish-hid: Ishtp: Fix sensor reads after ACPI
 S3 suspend
In-Reply-To: <64ee580b9969335d60966e23e9bd859e8f075953.camel@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.2402131131250.21798@cbobk.fhfr.pm>
References: <20240209065232.15486-1-even.xu@intel.com> <64ee580b9969335d60966e23e9bd859e8f075953.camel@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 9 Feb 2024, srinivas pandruvada wrote:

> > Fixes: f645a90e8ff7 ("HID: intel-ish-hid: ishtp-hid-client: use
> > helper functions for connection")
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218442
> > Signed-off-by: Even Xu <even.xu@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> Hi Jiri,
> 
> This regression is introduced with 6.8-rc1, so need a pull request for
> this rc cycle.

Right; now queued in hid.git#for-6.8/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs


