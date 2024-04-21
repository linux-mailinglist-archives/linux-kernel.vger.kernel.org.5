Return-Path: <linux-kernel+bounces-152639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F998AC1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA964B20947
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EA353E2C;
	Sun, 21 Apr 2024 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWORn+21"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF675380C;
	Sun, 21 Apr 2024 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738591; cv=none; b=ZfCJnUon6t7tVe7P8f/+PohCmhClwbM9NjbtGJ/pUWu4Y0NfD4J/HGlSkZpjtBua+kKH1FQTHT0LvXAVLZnJRcNrp9IhgdCIwpO1hvqcB3XtDkjfrfWPSMpk5xidjgiBTHRRUhuj3lys25yGiKvEDC53kpYTdDQYCSgx9dTfdgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738591; c=relaxed/simple;
	bh=chwvUZAfiMuzYfDIb9EmErWtqNS1Sdj426CZM21u8hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkS3udLDDixXnTNGx51l0FjuARk2uGqHDUn/wad+TwhA/rOqA0xVZIj5VogwR3ZZKbEbQbndNIsbQvLsFuaKzagUDSfxUIXLGtVj5EitI3RZxH8s5YQhCXpuWy8NVC7hAWkcxXa80069UUfcZnB43TozInhrb17ojPmWt92zK5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWORn+21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5277C113CE;
	Sun, 21 Apr 2024 22:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738591;
	bh=chwvUZAfiMuzYfDIb9EmErWtqNS1Sdj426CZM21u8hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uWORn+21dSzg4hKPT7AJIFAtSOcfhL34eSZTpEGiocdRppcQkuxY3Bp/FxKAHfHUP
	 iiuhr0cS4Bt6+qpd0bI/6JBFt/rgpyz6lTpaWUT9isb2ounnc+YfXYVedmzr+HAREN
	 V8BbdvQb+bJu19SlXN1w/8+fccUaji8La3VTp6unUED9Par5DRxN159Vagq1j/bmy7
	 BhZRvMA6b96FaxpZawlYci+JJNPhJJYWCLFxMqzJZELIJM4/xwzR2HlsZ5E6DevN74
	 ZoC4HZSteForgxstt424meSzjfxzjbPAzkP9WVQCx3BjQmWg6i7gHxH2KR3UtQz2nY
	 No37sJnRN6fJw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Maulik Shah <quic_mkshah@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_eberman@quicinc.com,
	quic_collinsd@quicinc.com,
	quic_lsrao@quicinc.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] soc: qcom: rpmh-rsc: Enhance check for VRM in-flight request
Date: Sun, 21 Apr 2024 17:29:25 -0500
Message-ID: <171373856763.1196479.12306109616414652379.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215-rpmh-rsc-fixes-v4-1-9cbddfcba05b@quicinc.com>
References: <20240215-rpmh-rsc-fixes-v4-1-9cbddfcba05b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 15 Feb 2024 10:55:44 +0530, Maulik Shah wrote:
> Each RPMh VRM accelerator resource has 3 or 4 contiguous 4-byte aligned
> addresses associated with it. These control voltage, enable state, mode,
> and in legacy targets, voltage headroom. The current in-flight request
> checking logic looks for exact address matches. Requests for different
> addresses of the same RPMh resource as thus not detected as in-flight.
> 
> Add new cmd-db API cmd_db_match_resource_addr() to enhance the in-flight
> request check for VRM requests by ignoring the address offset.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: rpmh-rsc: Enhance check for VRM in-flight request
      commit: f592cc5794747b81e53b53dd6e80219ee25f0611

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

