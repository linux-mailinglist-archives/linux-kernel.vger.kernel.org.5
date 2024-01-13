Return-Path: <linux-kernel+bounces-25260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A34F82CBD1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 11:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA34B1F22E2D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C5819BD1;
	Sat, 13 Jan 2024 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3PCvLUm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2183118E38;
	Sat, 13 Jan 2024 10:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371DDC433F1;
	Sat, 13 Jan 2024 10:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705141616;
	bh=JFI/sg9PG8bnP6shSEl0PaqRN8tCMbNQeFxvpUYK4tU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=j3PCvLUmYJFRYZIniSh4Vb51WLTdh9rzhALwc4E+Xmuzk37yJU3u3xFKcKB5inpTl
	 dQ6lcf8I0iSHk5+9ZHifVBhNp1/jGC2L6pzO9hzdFFteQi00Muw2CnaMG+MaNyOkOS
	 RJpuoKU45iQfqdWJ0jblk+EZQUNyGdR7+JYZhusJDCaZC4uLYbDHHjpDeYUceCS38+
	 NWCfN/85UD0KJ2O5DC05YEYdzliR6OpnFRPkeMGIsBfhE51pHv+jX2Bs/22UXjvSeM
	 ivZVD93M3fZbOkayTKoh/o88yKvrKWBlspoIjBwNavs9+Vom9kKWAA1RY/LOCPuMNa
	 +O1uruxECWEaw==
From: Kalle Valo <kvalo@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  ath11k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: ath11k: checking RCU usage
References: <20231019153115.26401-1-johan+linaro@kernel.org>
	<87o7goxget.fsf@kernel.org> <ZTfgJCBxsNv3bVjv@hovoldconsulting.com>
Date: Sat, 13 Jan 2024 12:26:53 +0200
In-Reply-To: <ZTfgJCBxsNv3bVjv@hovoldconsulting.com> (Johan Hovold's message
	of "Tue, 24 Oct 2023 17:17:56 +0200")
Message-ID: <87zfx98r6a.fsf_-_@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

(old discussion, changing title)

Johan Hovold <johan@kernel.org> writes:

> On Tue, Oct 24, 2023 at 05:07:38PM +0300, Kalle Valo wrote:
>
>> Johan Hovold <johan+linaro@kernel.org> writes:
>> 
>> > RCU lockdep reported suspicious RCU usage when accessing the temperature
>> > sensor. Inspection revealed that the DFS radar event code was also
>> > missing the required RCU read-side critical section marking.
>> >
>> > Johan
>> >
>> >
>> > Changes in v2
>> >  - add the missing rcu_read_unlock() to an
>> >    ath11k_wmi_pdev_temperature_event() error path as noticed by Jeff
>> >
>> >
>> > Johan Hovold (2):
>> >   wifi: ath11k: fix temperature event locking
>> >   wifi: ath11k: fix dfs radar event locking
>> 
>> Thanks for the fixes. I really like using lockdep_assert_held() to
>> document if a function requires some lock held, is there anything
>> similar for RCU?
>
> Not really, but the checking is instead built into the primitives like
> rcu_dereference() and enabled whenever CONFIG_PROVE_RCU is set.
>
> For some special cases, we have open-coded checks like:
>
> 	RCU_LOCKDEP_WARN(!rcu_read_lock_held());
>
> which similarly depend on CONFIG_PROVE_RCU or simply
>
> 	WARN_ON_ONCE(!rcu_read_lock_held());

I just found out that sparse has __must_hold():

https://lore.kernel.org/linux-wireless/87sf31hhfp.fsf@kernel.org/

That looks promising, should we start using that in ath11k and ath12k to
check our RCU usage?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

