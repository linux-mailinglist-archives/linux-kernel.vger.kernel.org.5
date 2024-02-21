Return-Path: <linux-kernel+bounces-73921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5CA85CD9C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5834F1F24606
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874FA522C;
	Wed, 21 Feb 2024 01:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOjCVPQ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90E17D5;
	Wed, 21 Feb 2024 01:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480660; cv=none; b=lmAYMWZ5jwlRKtlamyNRxaCfG7EMwdv9HSt0AXIDUIzHD6XR8FaDbDWIinwvluLF/EpyZLlutzUme0ba7CdAqANhsDpHioVX5o92kbVjkxmEel8Z7x52TnUJYSxYFriJXr4QBnI4aeuX1ocS+4c2FmoMngz9efA7FUKNXQerWrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480660; c=relaxed/simple;
	bh=29cDjeGYWwPeOqy1mXFXsySR1RaE/+QRIcZrSNrCEOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gi3t+glZmlOmO14Y3CUXqkKPVemH7MzJrsdFjwI1eRk24uKlGY28Wxn1Q/FEIYv2He+3iY7mxybln7PtRcz4dMnqvOWuiwQp3ZeIqH8DLQ6fhz67OmRFCREcfNZbNojL2D2r9QxI/4j5CpcanmBepI4dCfnjxMjMACTl4jBzGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOjCVPQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A69C433F1;
	Wed, 21 Feb 2024 01:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708480660;
	bh=29cDjeGYWwPeOqy1mXFXsySR1RaE/+QRIcZrSNrCEOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOjCVPQ4s01mnS+ZJmNVlr8/mFTghg+nUk7973C+wKN5nvs+ASyErkEmokWLPUXjw
	 P1mbsALYWbhq/93XBua8uB1dT6D9winJVkmbblMJKgd1GfpZhxzPJaQERS+4EWVejw
	 xmWQBjHWrCJaeIFlBZWlWeusuQRUAg7ZPp2YsSa22lWW+BaTyP7B3LG7uIk2segxpC
	 fXC6/2fvUkarHeY61Eqcevub+Xe5Z4zog/8xvQ47n9LFjG/78OXTtmkuS2h8bpKsdb
	 Q4bTl3QzQDIB4AO25MpPDVfZC0fZl8Uz9WgR6X40MESKhd2vGXL+EILxjP6riO09h0
	 ca+3qZPfe9U5g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf test: Enable Symbols test to work with a current module dso
Date: Tue, 20 Feb 2024 17:57:37 -0800
Message-ID: <170848061716.1313505.4005156314579304167.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240131192416.16387-1-adrian.hunter@intel.com>
References: <20240131192416.16387-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 31 Jan 2024 21:24:16 +0200, Adrian Hunter wrote:
> The test needs a struct machine and creates one for the current host,
> but a side-effect is that struct machine has set up kernel maps
> including module maps.
> 
> If the 'Symbols' test --dso option specifies a current kernel module,
> it will already be present as a kernel dso, and a map with kmaps needs
> to be used otherwise there will be a segfault - see below.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

