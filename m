Return-Path: <linux-kernel+bounces-131225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5578984D5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353BB1C2661C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCFF3D96B;
	Thu,  4 Apr 2024 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CX4l+JUq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725873177;
	Thu,  4 Apr 2024 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225551; cv=none; b=dH2rweNZHXC86+UTn3Sr7IqrvhoPH/Xo+gq1I/5a6ZIZ+8gWowPTVi62IeCXLMBzN5V/B5Mvr70ZZdiojOi66vT7vOrXNImipFh7gEq43tl8Hg1pH/+rKbp7xP+IXTqMEafiJ23kvOzhf/ITtM6Pp+ptTx8ZVqKj0l0Dco2kwzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225551; c=relaxed/simple;
	bh=sh6vMvCh7dRXhXNmhb02Vd2ORWWM0S+qssTbnri6+oc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=pj+njkzUdvXM4yLJHTpDwlj50cTgFN7w2iRHq0ce6yWSkme5hLMWN35y3N4mZwLydnRghiVITI5ZUJKMZwdDiVhTjJwluvOJVCSl5AiYyUpCEiwLNSFDD5MyrHXGVEA1y13LYndqNW+fSQf9AzJorynSS1SA4mmnyWZiP/vjww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CX4l+JUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F7AC433C7;
	Thu,  4 Apr 2024 10:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712225550;
	bh=sh6vMvCh7dRXhXNmhb02Vd2ORWWM0S+qssTbnri6+oc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=CX4l+JUqzKln48BcTkuOrhwMXxiSLWKwCr+DMiBeBjG+95DUZoIewGs8b2pI/O5Ej
	 kJrIiEqb4sHeoeMGS8RvVbVTq6/ilPrbzJSxRSNQiU5iO83YQMejMR8+E2hWLoFfE1
	 8kHbJJ1OSKoGd98UUZH5fujXCJnX6hF3qCdDHaDZyiM0Zk8xeDOyiwPvSvG235vjeo
	 RztCfhjT/EYCbNOd+aYA7iXIBGpbvS5TZ2WDjE67KYUOJJPgoyOxXusMUHMUzkuKSg
	 vjyPxmpJKYyl+oqzbi7JQCN6ck4Olk/qevE65wHGlgpZBstQTSjW6DUpOYPX0vz3++
	 lLpcgvTcqMfiQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2][next] wifi: wil6210: wmi: Use __counted_by() in struct
 wmi_set_link_monitor_cmd and avoid -Wfamnae warning
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZgSTCmdP+omePvWg@neat>
References: <ZgSTCmdP+omePvWg@neat>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171222554691.1806092.8730005090791383928.kvalo@kernel.org>
Date: Thu,  4 Apr 2024 10:12:28 +0000 (UTC)

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time
> via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
> getting ready to enable it globally.
> 
> So, use the `DEFINE_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> drivers/net/wireless/ath/wil6210/wmi.c:4018:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

cbb0697e0ded wifi: wil6210: wmi: Use __counted_by() in struct wmi_set_link_monitor_cmd and avoid -Wfamnae warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZgSTCmdP+omePvWg@neat/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


