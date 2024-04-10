Return-Path: <linux-kernel+bounces-138943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C9C89FC59
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309A91C20E39
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5CD1791E6;
	Wed, 10 Apr 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbsrkI75"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F85517277C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764722; cv=none; b=KGT96qVdY/m71Puvu/1zDkB5+VosrWCRZop4yJEFvWVlrRm88mo2ef7+0DCxBjMjP8smcyXlCnTZW+pf0CjEDWSaEWcrwtm0iU5gld3Hrnj3R8Jj+NAG+rFHp5mN/Gu6kcaW0kKYC3TcCofs+1ijTCgze8KJV4oWvpU76L8XmsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764722; c=relaxed/simple;
	bh=5OFpvQ7sARFF0Aq/La90VMmVD94267fOZ0zX4PhSRuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPrz2sNHNsc6t+3GRkFGMMEpBr8AoLNGJlDeVwL8FcJqCmMq4eV/8i1QH4S0J2HvPwykUmWX/+7zoekZJBeEMYbLsQTdzFyFRMuvz7cQL4YHMkjZJns3DgD9QeD9irYz2s9f/+FYLkbnqgyYl4X2vKyPOmWwUl04YCxeuIMLXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbsrkI75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFC4C433C7;
	Wed, 10 Apr 2024 15:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712764722;
	bh=5OFpvQ7sARFF0Aq/La90VMmVD94267fOZ0zX4PhSRuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AbsrkI75tksZiDB7RarqJYbww+tP4mDLQ5ollG32q+3KKaJEdSJlph/CCti//7UGQ
	 oXAWzWc1LZCOX3/IDAgdaC7EFJj+yaq9Zvoh+RULoiiBJ8urBoB55gT2HXfiMsCmOH
	 SreWrk7vXlPWkqUY8kmwtAkBh7ei9tKr6K2A9J5BoKgIMZxMYMSTp6Wik/A6cEzUfq
	 pkcuzdChOeiRMESzNTVQZg57s3aPGGzS19iJHLNYop32vfsBzuyzaGcdxsiCXkAbtj
	 AuCjMTf8CZZsdltXwKGg4QWAUPeIhRkvWuo7yrAhxkAMR+kZHsojWkwObRLlfNPOIK
	 ynJygTQz/B+sQ==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Set PMU device parent
Date: Wed, 10 Apr 2024 16:58:37 +0100
Message-Id: <171276409864.68229.327132746666014118.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <25d4428df1ddad966c74a3ed60171cd3ca6c8b66.1712682917.git.robin.murphy@arm.com>
References: <25d4428df1ddad966c74a3ed60171cd3ca6c8b66.1712682917.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 09 Apr 2024 18:15:17 +0100, Robin Murphy wrote:
> Now that perf supports giving the PMU device a parent, we can use our
> platform device to make the relationship between CMN instances and PMU
> IDs trivially discoverable, from either nominal direction:
> 
> root@crazy-taxi:~# ls /sys/devices/platform/ARMHC600:00 | grep cmn
> arm_cmn_0
> root@crazy-taxi:~# realpath /sys/bus/event_source/devices/arm_cmn_0/..
> /sys/devices/platform/ARMHC600:00
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Set PMU device parent
      https://git.kernel.org/will/c/8f9f5041c646

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

