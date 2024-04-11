Return-Path: <linux-kernel+bounces-140595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F698A16A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E61D28A28A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E900D14D458;
	Thu, 11 Apr 2024 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVsrSYXW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3242C14E2F3;
	Thu, 11 Apr 2024 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844303; cv=none; b=tRvgYi74XtH57iCRfYAV23WfG8maRW8bxHd49BgQ3WgZKBaR5TiZB/atlMv+Gppu8wGTbIffFhwc+ZQG7g3Dgajrxr+O7sW7iTwPej2Oty19xDg1koxiPvpRb9S43gpEzl7fs3qb0yux8NvXLX11TVv/zefOv7VUnas6zR7JSQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844303; c=relaxed/simple;
	bh=ytIt7aVICYWiSyBTJMxhm3EFDHA6cIURV9v2+R6cvIc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OdzCRdEo4JDR0vnXakr8q7otbC2g7YafzcCUdi53NXNWfc1E7fmUZ3yhLe55tsEmE166oCDKPSNzYCvpCS78o6DZdajEzBBdYixOVdS/++WlJvFFY/Yg4Sum7WnBlUp8/QCCf1v/8LrN39Vgpg1/7pHHXVgtBLb1V95UqIcqAxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVsrSYXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2B5C072AA;
	Thu, 11 Apr 2024 14:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712844302;
	bh=ytIt7aVICYWiSyBTJMxhm3EFDHA6cIURV9v2+R6cvIc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iVsrSYXWr51w1eCDiSWsBTICrua+FhVQs6GssL9kKYTkVuvr0xUJjARwWZlRY0QNk
	 O8NLnNjSqQM3mpG/KRdCxDGmoZLLtDK0uMaydAbl7PuLSCc+0Is5vopQ9ZZ2RlhgAx
	 qD3/jTq2t6UGPev8dazEbSxqfeQzSk6asLloIbvReAwmPvQEByfsfIndWYghexy8EY
	 wGdwS7FowsWglgW7jafMiTBSi1xEznEBexTSvrS4ZnXSpuTukb2se8iVXMeK5hnPgM
	 9S+IZBddqvQEJqMTeQH+nLgsN8xDlyqJm1O2IAm6L0EoW0t5fdp4jfnc3KZTwPO9F1
	 d85bTEPbF3lkQ==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240411-fix-hid-bpf-v1-1-4ae913031a8c@kernel.org>
References: <20240411-fix-hid-bpf-v1-1-4ae913031a8c@kernel.org>
Subject: Re: [PATCH] HID: bpf: fix hid_bpf_input_report() when hid-core is
 not ready
Message-Id: <171284430162.439729.14775529796667980544.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 16:05:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

On Thu, 11 Apr 2024 09:05:56 +0200, Benjamin Tissoires wrote:
> Reported by linux-next:
> After merging the hid tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> x86_64-linux-gnu-ld: vmlinux.o: in function `hid_bpf_input_report':
> (.text+0x1c75181): undefined reference to `hid_input_report'
> 
> [...]

Applied to hid/hid.git (for-6.10/hid-bpf), thanks!

[1/1] HID: bpf: fix hid_bpf_input_report() when hid-core is not ready
      https://git.kernel.org/hid/hid/c/b912cf042072

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


