Return-Path: <linux-kernel+bounces-58400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE3284E5FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68FB51F22937
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B7B823B8;
	Thu,  8 Feb 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb9Rnp1n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7048002C;
	Thu,  8 Feb 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411807; cv=none; b=LiXspCG8E/CwdKl+HN868X/hmu+lGi4xpGg98cYVs7J7fK+eVbjFRZ9mH7urtr9Rifvh/riZeidBp7ktVKAvseJ0lYIPpFWzkq8Q3DLIVxEndNLcaMeUBf/c++pBEhliFKOhZUGLiWgaBY5QFFiVOtDulnhtZX7C2O6nGlSy24g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411807; c=relaxed/simple;
	bh=EwFD4KJxeu0ZL/NCu3s0G5gqCU2g+oX3eJxt7Iddfmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9cxbBxItrH08fYNrPW2HZmof53wKGbFt9QLfAK06HUNaBMsZ9TP6xokh6H8672hzOcBN7WOQ0SFBLb1znYSewIUhgkcIl45dKMsBbY7KSMKid4lNZj/TfmvjEteu6xqBFFjp/zrId2ofkb06V47VN1hTT75wCPt0IuJX5fan9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb9Rnp1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ED5C433C7;
	Thu,  8 Feb 2024 17:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707411806;
	bh=EwFD4KJxeu0ZL/NCu3s0G5gqCU2g+oX3eJxt7Iddfmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tb9Rnp1nKxm9F8zc2OVEPYN2/HUCrZ/i1GOxJWFWwEggLwgvcatx5p3OPgBO3ZwcB
	 Wy4+WH/clsLMOSk9Qf99vssfuR3J70ULVg003+Ny2wlYND/g7ZwY3K1RClA4JSi8kd
	 7oQeUwsyZbIwzd54M/vkuf6Y+G0lKfe9sluSUl2U9cerHfyYVIlFrqSn2JPEDljxPJ
	 J4PZMxBpznU+3D23h7kP25Ams9Els/YDv57w/90kvLRrEDPDZpwmxRTSvQoA+tEVgZ
	 F4YEMLLlTw5MMIva+gzP1Q4V+/TtrTazrcYeXZxlxKPH9Fi5XHdWhPga+eQCzUtV02
	 KSifvNhuq9EOg==
Date: Thu, 8 Feb 2024 18:03:23 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 6/7] cpuidle: Handle TIF_NR_POLLING on behalf of
 CPUIDLE_FLAG_POLLING_HARD states
Message-ID: <ZcUJW2UynuEsxT9-@localhost.localdomain>
References: <20231124223226.24249-1-frederic@kernel.org>
 <20231124223226.24249-7-frederic@kernel.org>
 <CAJZ5v0gUp9DrzSnSdDYq36YGqKGTc3-fu1PN74WSC8-6fj3rKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gUp9DrzSnSdDYq36YGqKGTc3-fu1PN74WSC8-6fj3rKw@mail.gmail.com>

Le Tue, Dec 12, 2023 at 02:21:52PM +0100, Rafael J. Wysocki a écrit :
> On Fri, Nov 24, 2023 at 11:32 PM Frederic Weisbecker
> > -}
> > -
> > -static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> > -                     int next_state)
> 
> Since you are removing call_cpuidle(), you may as well remove
> call_cpuidle_s2idle() which only has one caller anyway.

Doing so in a seperate patch. Thanks!

