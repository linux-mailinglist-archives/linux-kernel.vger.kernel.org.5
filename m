Return-Path: <linux-kernel+bounces-73135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B1985BE08
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B7E284800
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB16A8C1;
	Tue, 20 Feb 2024 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yn09JOMy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8874F6A8D5;
	Tue, 20 Feb 2024 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437888; cv=none; b=XwVEqGZ/h9i+mlcp3U/7Eu+D+7+z/3EVYPAW4dlc6mRygQypIXRIhL8zx2Bp5vJzmtMMgFQHZEfRDr7ZuNKfLWCX9cyC4z6eykNxUPQi1eCXOQZJ6UnOjQXs9C6qc9Uxd1l2THslDHx5GYbYym2fKBows0LwQtCe0CLgoHHuStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437888; c=relaxed/simple;
	bh=+DcNQ5b7LggalgRTToCWl0v9dRAJnGofw1+yMleHhpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DP1QxVJkwS97w5qqTiTK5o3OzkLDkqQKsOT93bM/ASBHzN0sEsGV5Du2ifOekzDFr59vl8OGS9ZU86ScYwiUkt06AiHjSyDDaWMtiD8xge+diQu9t/hl+Cpl5Zqc1MY7mpKzOSr9tiZ4Xqt6y48/6kWe8IpEve1JlNKqx4e2YRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yn09JOMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60AAC43390;
	Tue, 20 Feb 2024 14:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708437888;
	bh=+DcNQ5b7LggalgRTToCWl0v9dRAJnGofw1+yMleHhpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yn09JOMyRXKoxpREqz+RRmA7flJ0OlpSjXeiCVrWjuGgUnSxUvJvP5aQcBcJ8hWO5
	 imjk8ThAzKoWZqnY5/PDQ6OwTgtxO1FWAT7aw7CQF7tcOq2jnF9Rg22iInfU3jyrRY
	 BLnbv6Nge+Delhb5RnSeTdEhiGcweBZ+5cg6AQpkxTT8IauKhoqVg2rpbPRIrKZEAw
	 jwSry43jl8lOzDKqUl2s11KIQuanyKovW1UFs5FsTu/mMUGGY9Wkowv2j/VxISwjje
	 +kqrpUO4VDqcLYcF5FbahyCCJFCJg0CZgPHpAyMbqEq32tUvoiaTpwBcpw0htzNRpG
	 QIkf3rMJrcNWw==
From: Will Deacon <will@kernel.org>
To: hj96.nam@samsung.com
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	wj28.lee@samsung.com,
	jonathan.cameron@huawei.com,
	mark.rutland@arm.com,
	ks0204.kim@samsung.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] perf: CXL: fix CPMU filter value mask length
Date: Tue, 20 Feb 2024 14:04:39 +0000
Message-Id: <170843064764.2617406.4906791201590222748.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240216014522.32321-1-hj96.nam@samsung.com>
References: <CGME20240216014507epcas2p41686c0ccb1fa73715499e45bbbc7d7e9@epcas2p4.samsung.com> <20240216014522.32321-1-hj96.nam@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 16 Feb 2024 10:45:22 +0900, hj96.nam@samsung.com wrote:
> From: Hojin Nam <hj96.nam@samsung.com>
> 
> CPMU filter value is described as 4B length in CXL r3.0 8.2.7.2.2.
> However, it is used as 2B length in code and comments.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] perf: CXL: fix CPMU filter value mask length
      https://git.kernel.org/arm64/c/802379b8f9e1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

