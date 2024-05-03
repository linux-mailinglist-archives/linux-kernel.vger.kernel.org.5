Return-Path: <linux-kernel+bounces-167805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 231948BAF62
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C1F1F23032
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCE34B5A6;
	Fri,  3 May 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmQj3FgQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B842B9C0;
	Fri,  3 May 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748874; cv=none; b=uYkfFSBtyqg/iY6dft88D6dzTnfEJZZ1sjDTTpMp+ULp9enj/09o7p5PL4WO60RyvZ/6KN1gwRIA6tqEb2UBL72JjjZQsRuZDY4cAvfmzGWjKa56C/SWG61Sqk8lidmWaUSyKzkBw4Q882Y5puDqw+XMtG0xkJim8zdJQ1p8i70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748874; c=relaxed/simple;
	bh=KHw1jpQWTItXJP+LUq93GYr6K3+KcdpxHjWxkmV9Pds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ef2dmMXjxX4RshJSrkdHAD0xJbv51/j7l2h+SG8+bEYm7WZbkPKMpaS1cedE6OK9xtTql0mdEfNsavIz6IqG90kkkE7n+BlHS4ji2Ax22Dn4Cog5opmyv2koTSA8w7zKeFDIyvKPi1uE0BCuJ+U3KPMXG0j5wl/RchcGbMFAiww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmQj3FgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BD9C116B1;
	Fri,  3 May 2024 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714748874;
	bh=KHw1jpQWTItXJP+LUq93GYr6K3+KcdpxHjWxkmV9Pds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmQj3FgQVSSyr+5lMGK3XaET7pSMaT0s4Jmne7pm4HMvunyevBMEUGfxk5LZi6T7f
	 Go79Q8UTu8Bp3RIGm6VlJ9gD/SZXSnF4+sLD39F/nKlHaO+TUxpJU98fpHvAcORjWo
	 Fd7+URG7ISR4qdOEDb/RD+VvFF52Jn077CRVRphUk9MklqhDNr7fSOalgIEyeZYSEo
	 0gKXBgy+rX0i1wsu3yZ145HxLWDUuD8TxbeEHKhJ+jFYagi5L9548nzXl/GE87Kbx5
	 G1iA3AZEZMq0zcgx6Gftwa5POW+2x3fc/kVpz1+HCfvPGWTC7a/Mke7uMf2aYAdqGY
	 LStSg2BMKWsAg==
Date: Fri, 3 May 2024 16:07:47 +0100
From: Will Deacon <will@kernel.org>
To: Sebastian Ene <sebastianene@google.com>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com,
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
	tabba@google.com, yuzenghui@huawei.com, lpieralisi@kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 3/4] KVM: arm64: Fix the identification range for the
 FF-A smcs
Message-ID: <20240503150747.GC18656@willie-the-truck>
References: <20240418163025.1193763-2-sebastianene@google.com>
 <20240418163025.1193763-5-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418163025.1193763-5-sebastianene@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Apr 18, 2024 at 04:30:25PM +0000, Sebastian Ene wrote:
> The FF-A spec 1.2 reserves the following ranges for identifying FF-A
> calls:
> 0x84000060-0x840000FF: FF-A 32-bit calls
> 0xC4000060-0xC40000FF: FF-A 64-bit calls.
> 
> Use the range identification according to the spec and allow calls that
> are currently out of the range(eg. FFA_MSG_SEND_DIRECT_REQ2) to be
> identified correctly.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/ffa.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/ffa.h b/arch/arm64/kvm/hyp/include/nvhe/ffa.h
> index d9fd5e6c7d3c..146e0aebfa1c 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/ffa.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/ffa.h
> @@ -9,7 +9,7 @@
>  #include <asm/kvm_host.h>
>  
>  #define FFA_MIN_FUNC_NUM 0x60
> -#define FFA_MAX_FUNC_NUM 0x7F
> +#define FFA_MAX_FUNC_NUM 0xFF
>  
>  int hyp_ffa_init(void *pages);
>  bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id);
> -- 
> 2.44.0.769.g3c40516874-goog

Acked-by: Will Deacon <will@kernel.org>

Will

