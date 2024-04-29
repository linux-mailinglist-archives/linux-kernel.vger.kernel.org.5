Return-Path: <linux-kernel+bounces-162818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDF48B60F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29921C213D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA746128832;
	Mon, 29 Apr 2024 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nl6h1rwq"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763A5127E2A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714414575; cv=none; b=fmY5jBK4lXpB/xOdEqUvUdfkc9RvrS1/spRauILSXah5McLJLp8UqPjEavOvuksEzFPHp3KfJUjj1gJnekOnrFD75L4ayICYaxiEKFeIGxecssTlk2bH6EmTP5Jca66+ydEL8LSOOq4+/DxNIj3d7/jLTtAESZra5keVwz5gV7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714414575; c=relaxed/simple;
	bh=WcXW/buP9MAu0vMBF5Js5v7YGSUnlUAbpElCKfwLszc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwahWS6+eGWGXqZu/f6N/KLjQv1tf/H3T0aDKj/Dw6/S+mdiWpgx8IZBKculmj5mEwp4O3t72+IDoKKG0KuZquEwxBa7B3qTEjpDzHNCKK7l8fmawpOyWg07Z9NkRvNBTrWPqPFBHJbvQ8y/wSYDUc52rcxiHqNRZ+QMmMg/cnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nl6h1rwq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e3ff14f249so36684775ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714414573; x=1715019373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OnZ1vLukMpdqrqD0r/VM8L5RpjpCprM81qtpwZ8cNP0=;
        b=nl6h1rwq3iLZfIjRmHtoR1qqzAcLmll+mg0FsLNREaFSsDODhKtJ7QFSou821XFhTx
         OwNqRW5epiElYi7zNZ6RXxyKWoEfuS6Jn/axupB5fxPOrAOloqoE+RNH+MLLTTkFpT8w
         K8IvudBhrFEfLYsEn1LZqQ0j+KDmDoDBBPRfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714414573; x=1715019373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnZ1vLukMpdqrqD0r/VM8L5RpjpCprM81qtpwZ8cNP0=;
        b=aS8oQPqYS55nfB9RDYY21+ERqdYU9QdzUlJBGReEDeMvL9pfoNYYz3DC29abJ2Ny3l
         GLu5Yj6bHy485JXZS8EGZpmM+uM7dy8Duu+wC/bUpZezMnx9/lvq9Kg34plK62wuXIlf
         9LktxV+4D6G68pKSPxOYGteNsBJIi0ApVpwVybpFWxRbi/pj0ai+eCu7cic76MNZ5RHH
         TxdEje3nHiiQHpjlSUwUPYHIcydO/XDDUlxal7h6CZSYCyFLOtJD+scMLNE2bBqWUvUK
         KsNeEevhf0n2fI2b2xcXOnhHGpSQDGqK0cvsDIMF5Pis2E51AB5fuS6gV9nFP2Idz8qD
         W4dw==
X-Forwarded-Encrypted: i=1; AJvYcCVIfimPb2otAT4PvPlo2/GnZsWw36JoYf5z1RqZCyZxGpuh3EdkHyW0MGsDXbLUUGtuv3uuiTnpIcmzgDK+GsYKitxl6fDE/50SagqS
X-Gm-Message-State: AOJu0YyrRaM9K+KbI4ewmSsCR+5S8d0m9J/iHR9wsgLivnB4sYOMGr9J
	Ti7E3H3biExDPa9nh6BoJa2zE3jWvP0e0NMKNjmdI2E3FpId1c7kWaLmXApVd7UM41DBi8LdzyA
	=
X-Google-Smtp-Source: AGHT+IFHuanPGgh9O4MDAeEUubDx/pf+02lBFuayRPoTqeON76gFZdZ04TBnnFcYIylPNzk4FROTQQ==
X-Received: by 2002:a17:903:1c8:b0:1e4:320b:4311 with SMTP id e8-20020a17090301c800b001e4320b4311mr562818plh.34.1714414572641;
        Mon, 29 Apr 2024 11:16:12 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001eb3d459143sm5154929ple.48.2024.04.29.11.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:16:11 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:16:11 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] Bluetooth: hci_conn, hci_sync: Use
 __counted_by() in multiple structs and avoid -Wfamnae warnings
Message-ID: <202404291110.6159F7EA5@keescook>
References: <ZiwwPmCvU25YzWek@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiwwPmCvU25YzWek@neat>

On Fri, Apr 26, 2024 at 04:52:46PM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time
> via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
> getting ready to enable it globally.
> 
> So, use the `DEFINE_FLEX()` helper for multiple on-stack definitions
> of a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> Notice that, due to the use of `__counted_by()` in `struct
> hci_cp_le_create_cis`, the for loop in function `hci_cs_le_create_cis()`
> had to be modified. Once the index `i`, through which `cp->cis[i]` is
> accessed, falls in the interval [0, cp->num_cis), `cp->num_cis` cannot
> be decremented all the way down to zero while accessing `cp->cis[]`:
> 
> net/bluetooth/hci_event.c:4310:
> 4310    for (i = 0; cp->num_cis; cp->num_cis--, i++) {
>                 ...
> 4314            handle = __le16_to_cpu(cp->cis[i].cis_handle);
> 
> otherwise, only half (one iteration before `cp->num_cis == i`) or half
> plus one (one iteration before `cp->num_cis < i`) of the items in the
> array will be accessed before running into an out-of-bounds issue. So,
> in order to avoid this, set `cp->num_cis` to zero just after the for
> loop.
> 
> Also, make use of `aux_num_cis` variable to update `cmd->num_cis` after
> a `list_for_each_entry_rcu()` loop.
> 
> With these changes, fix the following warnings:
> net/bluetooth/hci_sync.c:1239:56: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> net/bluetooth/hci_sync.c:1415:51: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> net/bluetooth/hci_sync.c:1731:51: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> net/bluetooth/hci_sync.c:6497:45: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Update `cmd->num_cis` after `list_for_each_entry_rcu()` loop.
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/ZiwqqZCa7PK9bzCX@neat/
> 
>  include/net/bluetooth/hci.h |  8 ++--
>  net/bluetooth/hci_event.c   |  3 +-
>  net/bluetooth/hci_sync.c    | 84 +++++++++++++++----------------------
>  3 files changed, 40 insertions(+), 55 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index fe23e862921d..c4c6b8810701 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -2026,7 +2026,7 @@ struct hci_cp_le_set_ext_adv_data {
>  	__u8  operation;
>  	__u8  frag_pref;
>  	__u8  length;
> -	__u8  data[];
> +	__u8  data[] __counted_by(length);
>  } __packed;

I noticed some of the other structs here aren't flexible arrays, so it
made me go take a look at these ones. I see that the only user of struct
hci_cp_le_set_ext_adv_data uses a fixed-size array:

        struct {
                struct hci_cp_le_set_ext_adv_data cp;
                u8 data[HCI_MAX_EXT_AD_LENGTH];
        } pdu;

Let's just change this from a flex array to a fixed-size array?

>  
>  #define HCI_OP_LE_SET_EXT_SCAN_RSP_DATA		0x2038
> @@ -2035,7 +2035,7 @@ struct hci_cp_le_set_ext_scan_rsp_data {
>  	__u8  operation;
>  	__u8  frag_pref;
>  	__u8  length;
> -	__u8  data[];
> +	__u8  data[] __counted_by(length);
>  } __packed;

Same for this one:

        struct {
                struct hci_cp_le_set_ext_scan_rsp_data cp;
                u8 data[HCI_MAX_EXT_AD_LENGTH];
        } pdu;

>  
>  #define HCI_OP_LE_SET_EXT_ADV_ENABLE		0x2039
> @@ -2061,7 +2061,7 @@ struct hci_cp_le_set_per_adv_data {
>  	__u8  handle;
>  	__u8  operation;
>  	__u8  length;
> -	__u8  data[];
> +	__u8  data[] __counted_by(length);
>  } __packed;

And this one. :P

        struct {
                struct hci_cp_le_set_per_adv_data cp;
                u8 data[HCI_MAX_PER_AD_LENGTH];
        } pdu;

>  
>  #define HCI_OP_LE_SET_PER_ADV_ENABLE		0x2040
> @@ -2162,7 +2162,7 @@ struct hci_cis {
>  
>  struct hci_cp_le_create_cis {
>  	__u8    num_cis;
> -	struct hci_cis cis[];
> +	struct hci_cis cis[] __counted_by(num_cis);
>  } __packed;

This one isn't as obvious, so I'd say keep your changes for this one.

>  
>  #define HCI_OP_LE_REMOVE_CIG			0x2065
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 9a38e155537e..9a7ca084302e 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4307,7 +4307,7 @@ static void hci_cs_le_create_cis(struct hci_dev *hdev, u8 status)
>  	hci_dev_lock(hdev);
>  
>  	/* Remove connection if command failed */
> -	for (i = 0; cp->num_cis; cp->num_cis--, i++) {
> +	for (i = 0; i < cp->num_cis; i++) {
>  		struct hci_conn *conn;
>  		u16 handle;
>  
> @@ -4323,6 +4323,7 @@ static void hci_cs_le_create_cis(struct hci_dev *hdev, u8 status)
>  			hci_conn_del(conn);
>  		}
>  	}
> +	cp->num_cis = 0;

Yeah, this loop never leaves early, and if it did, it processing the
array forward, so having num_cis reduced during the loop iteration
doesn't make sense. What you have looks right to me!


>  
>  	if (pending)
>  		hci_le_create_cis_pending(hdev);
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 9092b4d59545..6e15594d3565 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -1235,31 +1235,27 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
>  
>  static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
>  {
> -	struct {
> -		struct hci_cp_le_set_ext_scan_rsp_data cp;
> -		u8 data[HCI_MAX_EXT_AD_LENGTH];
> -	} pdu;
> +	DEFINE_FLEX(struct hci_cp_le_set_ext_scan_rsp_data, pdu, data, length,
> +		    HCI_MAX_EXT_AD_LENGTH);
>  	u8 len;
>  	struct adv_info *adv = NULL;
>  	int err;
>  
> -	memset(&pdu, 0, sizeof(pdu));

These become much easier, just:

	struct hci_cp_le_set_ext_scan_rsp_data cp = { };

etc...


-- 
Kees Cook

