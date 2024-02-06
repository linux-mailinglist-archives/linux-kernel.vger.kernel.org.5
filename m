Return-Path: <linux-kernel+bounces-55672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016DC84BFCD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346561C21DE4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5209F1BF20;
	Tue,  6 Feb 2024 22:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwO/K19o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8076A1C698;
	Tue,  6 Feb 2024 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257199; cv=none; b=V+qKIxrkSv+FoG8UwWh5cTAUrtur0ye8f7Gqg/2VpJYQQ9m8Zns7KppWp32FRyiiPTchF615HRVkF1Q+Ysm6fL8UioSXr1iT8OkYw8XhOD/tQtBCwGeKfX82/hynvvsCyOA1Z3XWCo4GhMUCSt/podtv7Ko0rk1Zp521ygH2GzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257199; c=relaxed/simple;
	bh=UZGZYo3rQF8ZQt1Q1DO6QY0N+zaL6JsoCk2GwJ5HiIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCfJLH7F/HPbWCSn4MvGoJmhnpRu52QyUxQK+rJ8XAuCssEwfP0E7C2PFvBJQBqKDEgs9cUT65MaeCteMJne52im+u3PveqZ5OaVJYBMEmSaGBROBjFWpOKuzTfcbflNdqOJUvVMM4tdACxWh3u8VjgPVt+QA0m9kryN1z3B2TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwO/K19o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DD8C433C7;
	Tue,  6 Feb 2024 22:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707257198;
	bh=UZGZYo3rQF8ZQt1Q1DO6QY0N+zaL6JsoCk2GwJ5HiIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwO/K19oOMhIFA05HctRHnCNinzvDTEPi6r/OPZCpX6ODROincXYZIvFUe9tG6VAo
	 45smlY0+UFtPN2QC0xdZqny1b3KP2nNLylVIJLW+keZdmoUNuYlzLQjNtqipSWzVzb
	 JSK+y2MlwrWJL+PF5lBe2vsNyrZMNhtK/ODjWE6K9R+FiuCy5IdXAKiOZ7jX6YnHmA
	 1BuEzcln71eQ6ARbFYWn5NSojNYyUuccwYIKGz/Bv6ipnbxu7cLMSm3d78GF/zmBMF
	 faQYnNiKH7FXNJejU5AeFK24fONgNcBgicsrI7b2w+AMyh5rrWAiZWC6rCVbSkhxbx
	 Bn6LnGkEx/SKw==
Date: Tue, 6 Feb 2024 23:06:35 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/5] sched/vtime: remove confusing
 arch_vtime_task_switch() declaration
Message-ID: <ZcKtaw6udrihSsKw@localhost.localdomain>
References: <cover.1706470223.git.agordeev@linux.ibm.com>
 <443aebea9128f7f455c76479f161bb6a2c956db5.1706470223.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <443aebea9128f7f455c76479f161bb6a2c956db5.1706470223.git.agordeev@linux.ibm.com>

Le Sun, Jan 28, 2024 at 08:58:50PM +0100, Alexander Gordeev a écrit :
> Callback arch_vtime_task_switch() is only defined when
> CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is selected. Yet, the
> function prototype forward declaration is present for
> CONFIG_VIRT_CPU_ACCOUNTING_GEN variant. Remove it.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

