Return-Path: <linux-kernel+bounces-137347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D640389E0E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920BC283A9F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DED155399;
	Tue,  9 Apr 2024 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbmep2Qo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CD3153BDD;
	Tue,  9 Apr 2024 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681988; cv=none; b=lvLl4A4BYvQm4hkD5p+tPgFmtW+OSNOmrysjSIaI7ZsyXQmXgze4jdfo1S8siHEChlxMnRRSnGUukp4+IbGZgbQWZB09cU3ccCrwy2i8hq0O6RBsMlvr7bnGrJix3B/ax+9C/8S3laCjanybwHBaOnFQ0JKZmWXzqc5+zYJQwzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681988; c=relaxed/simple;
	bh=OfB6tGykzMHeswgiZrzSekncrZkg0/ET1ay/s698coQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/8bjJsIfQlPuPQnOqI+Uzy9Mob8Y1YYm9AuIJf9VNzQanMFg1JdPcpDw+940U/FBR1ZnSHMoYYVrcbEMCnnuKNBT427Ggwm8b5LX4ImuWRtrvj6WA9ztIJ8h3meZJFab9XvUQL2+zZXMrnQUP2PEcQlI39En+abhn3BuomN2nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbmep2Qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CD5C433F1;
	Tue,  9 Apr 2024 16:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712681987;
	bh=OfB6tGykzMHeswgiZrzSekncrZkg0/ET1ay/s698coQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qbmep2QoaZf+3Rc+hKtmmzPMIgxVrlF6W/j+caIWfAISByNO/fOeFv/S64d/RDBth
	 pkJs1FiiHiQkpQGVBOAMNwPkiMWmpsdhkDz+jLUIQQ6KG75GY6IwlTvYlC0NLpvnXe
	 LxswgBmF8qoOsz1BfEoQ5+PLf7/HfLMTyeegKQ0S+HO+36QlqcZ+bGGA/Jb5u0Sbyk
	 uYR0V1y/dwB9hF59lcUbwHtENFRTl+czimRGz4InAU6wGO8+Bu2RUs8s9Jhhbam30X
	 3phVPBhix7IjsX0mSOgY4ijUt62CumGNS0CX0LyGh5od92UtxOyOSCd31NfkJOLU7w
	 9bNM+/oKDaADA==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	Dawei Li <dawei.li@shingroup.cn>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com,
	jonathan.cameron@huawei.com,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 00/10] perf: Avoid placing cpumask on the stack
Date: Tue,  9 Apr 2024 17:59:34 +0100
Message-Id: <171267763689.3170646.3275447262486662731.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240403155950.2068109-1-dawei.li@shingroup.cn>
References: <20240403155950.2068109-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 03 Apr 2024 23:59:40 +0800, Dawei Li wrote:
> This is v3 of previous series on elimination of placing cpumask var on
> stack.
> 
> Change since v2:
> - Update commit message for patch[2-10]. [Mark]
> - Add Reviewed-by from Mark for patch[2-10].
> 
> [...]

Applied to will (for-next/perf), thanks!

[01/10] cpumask: add cpumask_any_and_but()
        https://git.kernel.org/will/c/897fa2c38c07
[02/10] perf/alibaba_uncore_drw: Avoid placing cpumask on the stack
        https://git.kernel.org/will/c/2f6589df124e
[03/10] perf/arm-cmn: Avoid placing cpumask on the stack
        https://git.kernel.org/will/c/60c73240f304
[04/10] perf/arm_cspmu: Avoid placing cpumask on the stack
        https://git.kernel.org/will/c/b5310fa1fe8e
[05/10] perf/arm_dsu: Avoid placing cpumask on the stack
        https://git.kernel.org/will/c/bea2a13b207e
[06/10] perf/dwc_pcie: Avoid placing cpumask on the stack
        https://git.kernel.org/will/c/cf276ee46bc4
[07/10] perf/hisi_pcie: Avoid placing cpumask on the stack
        https://git.kernel.org/will/c/d7df79e6af29
[08/10] perf/hisi_uncore: Avoid placing cpumask on the stack
        https://git.kernel.org/will/c/b78d0fa25462
[09/10] perf/qcom_l2: Avoid placing cpumask on the stack
        https://git.kernel.org/will/c/fc85cee97029
[10/10] perf/thunderx2: Avoid placing cpumask on the stack
        https://git.kernel.org/will/c/595275ca4984

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

