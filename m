Return-Path: <linux-kernel+bounces-25203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E09B82CA41
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 07:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26DF1F239E7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 06:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D901168C2;
	Sat, 13 Jan 2024 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERuGwVMN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF1E574;
	Sat, 13 Jan 2024 06:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB52AC433F1;
	Sat, 13 Jan 2024 06:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705127550;
	bh=2iJy/IbcVSngH7U5FJKIAQpRVXxlDL+ZrRZ3nGMmnv0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ERuGwVMND9FQF8XVkStT34HR626Nz5XACBfcQn0Hzhl8FbkAFyXeuGrZpyDSzUK/D
	 KcQtY0n7pARwbPlxBtZHT9AuZGDKx+LMvb9UnUNaIxTg5SW5mwp6LK6YIo1xXA0teC
	 vGZPj/8Yz+6ldD7/OKOipQiddjWdiz+I71xPpzZslpCBOK2haas3SdtfLbegjVujx5
	 sxqY9MXRIHiumh9dVJvreaH1mjV+Qe8YjvpZvjdkXhK6c8nG62GVSA3fC/afonYeSg
	 sORtiMn1y8uKxDUPdEYzN3DwDuSjsvXg/NbwQIYpQRyi5V0m+nbemqQ//3gUCHtiTC
	 exBGzSMpZ1Hlw==
From: Kalle Valo <kvalo@kernel.org>
To: Brent Pappas <bpappas@pappasbrent.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: tx: Add __must_hold() annotation
References: <20240113011145.10888-2-bpappas@pappasbrent.com>
Date: Sat, 13 Jan 2024 08:32:26 +0200
In-Reply-To: <20240113011145.10888-2-bpappas@pappasbrent.com> (Brent Pappas's
	message of "Fri, 12 Jan 2024 20:11:45 -0500")
Message-ID: <87sf31hhfp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brent Pappas <bpappas@pappasbrent.com> writes:

> Annotates ieee80211_set_beacon_cntdwn() with a __must_hold() annotation to
> make it clear that ieee80211_set_beacon_cntdwn() is only intended to be
> called when the caller has a lock on the argument "link."
>
> Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
> ---
>
> Currently, ieee80211_set_beacon_cntdwn() calls rcu_dereference(), but
> without calling rcu_read_lock() beforehand and rcu_read_unlock()
> afterward.  At first I thought this was a bug, since (if I understand the
> RCU API correctly) rcu_dereference() should only be called in RCU
> read-side critical sections. However, upon closer inspection of the code,
> I realized that ieee80211_set_beacon_cntdwn() is only ever called inside
> critical sections. Therefore it seems appropriate to me to annotate
> ieee80211_set_beacon_cntdwn() with a __must_hold() annotation to make this
> apparent precondition explicit.
>
> This is my first time submitting an RCU-related patch so please tell me if
> I am misunderstanding the RCU API.
>
>  net/mac80211/tx.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 314998fdb1a5..7245f2e641ba 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -10,6 +10,7 @@
>   * Transmit and frame generation functions.
>   */
>  
> +#include "linux/compiler_types.h"
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/skbuff.h>
> @@ -4974,6 +4975,7 @@ static int ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
>  static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
>  					struct beacon_data *beacon,
>  					struct ieee80211_link_data *link)
> +	__must_hold(link)

Oh, never seen __must_hold() before and looks very useful. So does this
work with RCU, mutexes and spinlocks?

In case others are interested, here's the documentation I was able to find:

https://docs.kernel.org/dev-tools/sparse.html#using-sparse-for-lock-checking

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

