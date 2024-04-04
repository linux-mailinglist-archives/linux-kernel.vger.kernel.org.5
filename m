Return-Path: <linux-kernel+bounces-131574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7638989A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00621F29D83
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB1A12A172;
	Thu,  4 Apr 2024 14:12:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F74129E8D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239957; cv=none; b=jFnAXyrQJ8jAY6GN2SLGNosbFBHLQCnTu/78Z0WhH/fz6yn6z5uLT2FYyWgFmAOEVlfvNUybRIuxlFcDbuR7HKGVwI591KB1tb0Ov+PjNd8R9lzRysU8Q0ePfsxN6leYdqCj3Qykam78gfWSZ8un4kA3TiCRdIndD9OJqmc/U6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239957; c=relaxed/simple;
	bh=lORFwPl3NMSZOhW/0VatvvCkLT890zc2MdJM71SHOXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gp9W30NgLQg7V2cVRBdlnLPpGLVeTumb6btZHZD3oJlMX02SJsRdk5YdfG2s51hnfL+broSL8xKDb/1JYU8M1Az+nZiSjxlEyK9H8yGmgz526pwfrc7eJAk+OguPCQaawY8k9HRVRwd2qNK04LOxVKUs4BLiHmSpGWyuzFsu2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2806FEC;
	Thu,  4 Apr 2024 07:13:05 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B9633F64C;
	Thu,  4 Apr 2024 07:12:33 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nikunj Kela <quic_nkela@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] firmware: arm_scmi: Avoid non-constant printk format strings
Date: Thu,  4 Apr 2024 15:12:21 +0100
Message-ID: <171223989405.451881.1515372166025152395.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240403111040.3924658-1-arnd@kernel.org>
References: <20240403111040.3924658-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 03 Apr 2024 13:10:24 +0200, Arnd Bergmann wrote:
> A recent rework changed the constant format strings to a local variable,
> which causes warnings from clang when -Wformat-security is enabled:
>
> drivers/firmware/arm_scmi/driver.c: In function 'scmi_probe':
> drivers/firmware/arm_scmi/driver.c:2936:25: error: format not a string literal and no format arguments [-Werror=format-security]
>  2936 |                         dev_err(dev, err_str);
>       |                         ^~~~~~~
> drivers/firmware/arm_scmi/driver.c:2993:9: error: format not a string literal and no format arguments [-Werror=format-security]
>  2993 |         return dev_err_probe(dev, ret, err_str);
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/1] firmware: arm_scmi: Avoid non-constant printk format strings
      https://git.kernel.org/sudeep.holla/c/495667d49c50
--
Regards,
Sudeep


