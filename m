Return-Path: <linux-kernel+bounces-34125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8508A8373FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BA81C263EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E6547784;
	Mon, 22 Jan 2024 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5+LMjx8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CBF27715;
	Mon, 22 Jan 2024 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955939; cv=none; b=qeG6LmZi37Uwy3hC19Zy0TIDciGM7s+wuZKGdurMI/EiHHbD4oY6LemmRU3Q//6Y7CZ7nAJjkwboGqz6X1pIApI8vOMsnlecWnMvlewlGDMFwfMnjFP2lga0SVaNyo/q6RZmKWCWxh5qn2p7xJNmPjXlOIttirr04dNIG54C3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955939; c=relaxed/simple;
	bh=FQ+sdLeplOxrn9/DH/O38WJnft5mXMsR0iIQhToqjik=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hh5jfQ4V8+EcGVh7nNFrO3liBSoQarGldGEn75FqxETTzHm8CtctUIqN8voASX9Ovac+4caHQMBBEvAlRTFq6fg0Dt02lgdQZigmbfjWQpb7wCl3ML+V5fERA/inbuPp051KKeBTDyUrJ5dW3G99gpnQ51rt2h60CFV3p/IO5Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5+LMjx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16913C433F1;
	Mon, 22 Jan 2024 20:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705955939;
	bh=FQ+sdLeplOxrn9/DH/O38WJnft5mXMsR0iIQhToqjik=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p5+LMjx8gxQTPrhDNhZXB+kJfLaXoNhEnT4Q4zpohFX0wdAHZppVHhFXmf6A/PJjy
	 ZWdZDrtZcQGM1bnNxyYwlpOWvoo6JCrREYhCWWH4LTk//1mpe3I8RiJ4aQTzW1HkBR
	 7cebAFx1l8p7Yzsn8vHa9S/H9QVu3WKm+RDNuE4k+cuLA3Yv5Odt5Z8D9/pUmLEx1A
	 YTmg8VbFydtvYOtck1/nsU/7xVylr9Ha8Yrpyu49qFZGwSg9uKNrI3YfcR6wL8y02v
	 DwqM3jX3equmLvLklrJv987cQiO+A6nRFyGo4Jy6Z2ggozJJbH1dD3KjM2dHGSwPxF
	 g2d1XEoCbkbEg==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	Yang Jihong <yangjihong1@huawei.com>,
	adrian.hunter@intel.com,
	acme@kernel.org
Subject: Re: [PATCH 0/3] perf record: Fix segfault with '--timestamp-filename' option and pipe mode
Date: Mon, 22 Jan 2024 12:38:56 -0800
Message-ID: <170595558520.377262.4040178885633671225.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119040304.3708522-1-yangjihong1@huawei.com>
References: <20240119040304.3708522-1-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 19 Jan 2024 04:03:01 +0000, Yang Jihong wrote:
> When perf record uses '--timestamp-filename' option and pipe mode,
> will occur segfault:
> 
>   # perf record --timestamp-filename -o- true 1>/dev/null
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Dump -.2024011813361681 ]
>   perf: Segmentation fault
>   Segmentation fault (core dumped)
> 
> [...]

Applied to perf-tools-next, thanks!

Namhyung

