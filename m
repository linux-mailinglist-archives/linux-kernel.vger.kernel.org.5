Return-Path: <linux-kernel+bounces-48837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AFE846235
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F0D1C247A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806C83CF52;
	Thu,  1 Feb 2024 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpTfagR9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57DD3CF40
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821084; cv=none; b=ttEWrfRQw2vJew+T0EaWmEf3WNnQblOxlIYrPblz5p07cRKb6kFCTjqJyBLh8zpeI9Sl2yPcX1nzVgSkR1OHNDHr6/XPeB5NAHRFdHa8LstcDi3GMAA/Qwfekf2DDC0RhxicCWD8i3QShVRvclVc58hxIKKVHSADyqpizIbCbVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821084; c=relaxed/simple;
	bh=cAZOQMB+5stUlPLiaxUjv3QJ12+R1RpYYPqAjIoF2e4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=J8yIPDYrlbYQfb3YwNiBPoFnu6+mxHzfFqZiVxo2NDcNqc+W0kRsaQnqvfORy6vLVnME1OMqpgCYaiWgOPHPJpfFwQXXx8v7oZwmQNX+/2DDWPcFVWbq5YMKP0jLhpdUvFk98XHYVtJtShNlQeqQSaW1olpaNl/OHypznY9Zwuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpTfagR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D01C433F1;
	Thu,  1 Feb 2024 20:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706821084;
	bh=cAZOQMB+5stUlPLiaxUjv3QJ12+R1RpYYPqAjIoF2e4=;
	h=Date:To:Cc:From:Subject:From;
	b=YpTfagR963fmb5mao58fYwE8Iar0QjBsE38XMnxAIFC2P2We+7Dq1AcN/0+LBzsfA
	 PNX74jSyo8ZPGfHnciWicycD20SJf6Cbzc1hsvK3t4X5zazFlknISAJc2IHMRTOvR3
	 gP7zU3y0UvXW371bYlvhMnWUZz7ACbYzDBoB6qIjDQLhtcjlg3RtuUMVz5595LaevN
	 e3In9cXXrvBTF9n2eFu0ERbNeaPaSSnviHLT15Zn8SeFAMYg6iQ88XeCYJKxMcB1RM
	 /c/qPu/CJD58CQ0It4HjqY656s5thDI5Q8pVM6zqEzXB70Q26WPU394Lo4EhVRQTSs
	 gSghX8T5uGqJQ==
Message-ID: <b3d08cd8-d77f-45dd-a2c3-4a4db5a98dfa@kernel.org>
Date: Thu, 1 Feb 2024 21:57:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
 Naohiro.Aota@wdc.com, kernel-team@meta.com
Cc: Bjorn Andersson <andersson@kernel.org>
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: Workqueue regression
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

So, commit "Implement system-wide nr_active enforcement for unbound workqueues"
broke *something* and now performing a suspend-wakeup cycle on a Qualcomm
SC8280XP-based (arm64) platform hangs when performing the resume tasks,
presumably somewhere near PCIe reinitialization (but that may be a red herring).

Reverting the commit (and the ones on top of it due to conflicts) fixes
the issue on next-20240130 and later (plus some out-of-tree patches that
are largely unrelated).

Not sure where to start looking.

Konrad

