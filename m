Return-Path: <linux-kernel+bounces-59801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B0684FBDD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5F82819B8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2357084A26;
	Fri,  9 Feb 2024 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0sIaZ+P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD8684A2C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503488; cv=none; b=cvA3m+fFVOvaLtmJ/qNsOQbXmkOKxlmKYqtyBDYs/Z4P8adTPxFqvQAnTAlOElBiy82ZJdKIRko7n27IJ+kY8po02E3r5IrgYsAfYerEFvTwYYQUvXmHJKCK9cg2UDD77L8SWUJNGfz9NV58QE1dMYV+4BvgKlMcIRWBuWQyMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503488; c=relaxed/simple;
	bh=/9X0hRhI5nIpe5SdFlRIXHa7O6pYtTGF1Yby6JipvVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXnZVEjFCFtZQAyc+C7IGCmYgffKQ7vd52/05u0L32hDE/Hd+VpHV6OF9YfKgAWT2xOXqJg/Vl8TCw5r5penMW/zvEVYmpaHhFJ9GbCLYfonULrTg8o5sfdhNJbJuygaG7tlCEW3FF5YKleo294i+rWkDzXKtoyuY5WgBs7Xr3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0sIaZ+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7B6C433C7;
	Fri,  9 Feb 2024 18:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707503488;
	bh=/9X0hRhI5nIpe5SdFlRIXHa7O6pYtTGF1Yby6JipvVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0sIaZ+PZSATp6+R9lKDDcTfziovbjlfiUifxVD4mqOJQtTEJ8za/8QSoqHfLtk3f
	 fPjnGhBvIogjkzab2sd8/1yyWuO3O2WPbXMSK58Ohvsa0h4v+MG8WTlreIRqDN4bgF
	 F+b8+6eFohWcOX4RnNKrC+S9Z8qwbe9s7Xs2+Th7dbYgQlGOGBaiABE3XIES/AKR4o
	 rHsY+KJePu3N0q57iLpfv4u3RCPPmFMgJykb5WMCiISPktzHupBFGGgYLjMBjxDVBs
	 XZ/KKg+QjXNV5C6ZFPDeXc4Hp/mOi3YgI+ByUJFrBdVrdpf0nA8Y+7/fUHYOFxbV/+
	 gFvQLkqPrCEmQ==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	ilkka@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf/arm-cmn: Workaround AmpereOneX errata AC04_MESH_1 (incorrect child count)
Date: Fri,  9 Feb 2024 18:31:10 +0000
Message-Id: <170749884475.2631468.4908638699561214515.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <ce4b1442135fe03d0de41859b04b268c88c854a3.1707498577.git.robin.murphy@arm.com>
References: <ce4b1442135fe03d0de41859b04b268c88c854a3.1707498577.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 9 Feb 2024 17:11:09 +0000, Robin Murphy wrote:
> From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> 
> AmpereOneX mesh implementation has a bug in HN-P nodes that makes them
> report incorrect child count. The failing crosspoints report 8 children
> while they only have two.
> 
> When the driver tries to access the inexistent child nodes, it believes it
> has reached an invalid node type and probing fails. The workaround is to
> ignore those incorrect child nodes and continue normally.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] perf/arm-cmn: Workaround AmpereOneX errata AC04_MESH_1 (incorrect child count)
      https://git.kernel.org/arm64/c/50572064ec71

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

