Return-Path: <linux-kernel+bounces-96070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 411238756BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C071F22181
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE46F1369AD;
	Thu,  7 Mar 2024 19:07:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76534135A75
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838433; cv=none; b=jkm+Ow3s/LAMnCptH9SMR6KwH2iyktKRTmUaRm0tq7GGzF8DJupwnjdyTYXHqNAaArxN+WUumSd1S9/+jtJfrukP5zXEJkS643ZrzrgBMKRxkWwAwj83z23z9VVIDpTU37NMq9/4OvwVGGdtA4qlr8eNxZReVUPQUZGNZs6NHAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838433; c=relaxed/simple;
	bh=Lyu7iqd37tK2KplVnInLMebFUrfTWMiG+GzPElQoE3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8c6rM9G7BUwypT0QXQWuDfpoJutGnE16yI4vL8P0cpcV/O59T8yE0Wsrsv5yumwk42LcT4HT7lC1kaGGkM7iMs5mLktaq+1aFjvBRHxrURKE0Sodxr+o4ACyklN37V7pEfJ9a4ebv41VCHlwKm/e3SNvypL++vgmpZkZnHz6Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DB9C43390;
	Thu,  7 Mar 2024 19:07:09 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Rutland <mark.rutland@arm.com>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Will Deacon <will@kernel.org>,
	Jonathan.Cameron@huawei.com,
	Matteo.Carlini@arm.com,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	Eric Mackay <eric.mackay@oracle.com>,
	dave.kleikamp@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux@armlinux.org.uk,
	robin.murphy@arm.com,
	vanshikonda@os.amperecomputing.com,
	yang@os.amperecomputing.com,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase supported CPUs to 512
Date: Thu,  7 Mar 2024 19:07:07 +0000
Message-Id: <170983839495.1825460.8461454086733296317.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 06 Mar 2024 17:45:04 -0800, Christoph Lameter (Ampere) wrote:
> Currently defconfig selects NR_CPUS=256, but some vendors (e.g. Ampere
> Computing) are planning to ship systems with 512 CPUs. So that all CPUs on
> these systems can be used with defconfig, we'd like to bump NR_CPUS to 512.
> Therefore this patch increases the default NR_CPUS from 256 to 512.
> 
> As increasing NR_CPUS will increase the size of cpumasks, there's a fear that
> this might have a significant impact on stack usage due to code which places
> cpumasks on the stack. To mitigate that concern, we can select
> CPUMASK_OFFSTACK. As that doesn't seem to be a problem today with
> NR_CPUS=256, we only select this when NR_CPUS > 256.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

I dropped the config entry and comment, replaced it with a select as per
Mark's suggestion.

[1/1] ARM64: Dynamically allocate cpumasks and increase supported CPUs to 512
      https://git.kernel.org/arm64/c/0499a78369ad

-- 
Catalin


