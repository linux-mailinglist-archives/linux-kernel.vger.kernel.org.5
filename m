Return-Path: <linux-kernel+bounces-99633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E412878AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BDEA1C2168A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11C358ABD;
	Mon, 11 Mar 2024 22:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="km9pNuoL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E052658AAC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197559; cv=none; b=VyFIk6s2cYqOjNngwHgDPO3X3V5xCaQNmYtlw8VLEyhDdsbUAV4rmKTIajktkUV89qkdV/LSyn8TmCeF87xlPQPNpwXMV31XfQtfmwxiIlHPWQbDKCvZm6GSvlyrKyHFAVIrlU55XcgQPnchVOzt+t7Awro4vsDIdvDl6Wz2Hj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197559; c=relaxed/simple;
	bh=rgIDmib4C1pcvItR/XIbt9mkxni+eJsX9EEpTmbMCyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWoP3cphZsKGy0VGAjlmxpRmEgaD1cXk6ahxbr+GYCI9SkjAX4Ivlp/I+103InhFeAJs2KBK0983IcRmlf7MEAWLJuF8I9K2aJ5ZIPhb6aHEDSB+sjS6ycxU3jnQ2adPVNEKR0AWmYns3nQ+y1YBps/wEJ4Q8UXWBeBFMkB3Hdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=km9pNuoL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710197558; x=1741733558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rgIDmib4C1pcvItR/XIbt9mkxni+eJsX9EEpTmbMCyM=;
  b=km9pNuoLiHz/G6nLpvOVWoki5zJx/SFrK0az82LPEY6V2twett8xb464
   KzI36izMTur5OSQNI7ByFfdeF/ZgaTXQ+w+WblujtLwPv3GtLDGttcaGi
   9O2j/ZSGybWS36NYxgnDBH3odyYFSsTPyhm+7tsSzCQnuMY7GfOyJ5ROT
   gE8WZ6380H6gowyTdgdYmjxevgRJF68WiU76QU1tOiTeikUuO3ezgCQTS
   RJD9N2++t5J66fyt4xPOVL6LWgtMHv30uvl2cs6zB7ANvgZ+a9ePJB5JA
   XUAhuBwzuXaFSaNwfFIbJ9j1Gs9xKBgCnJjIwxMV3symnx5JqdjQwl35c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4743660"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="4743660"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 15:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="11908088"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.137.71])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 15:52:36 -0700
Date: Mon, 11 Mar 2024 15:52:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Felix N. Kimbu" <felixkimbu1@gmail.com>
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: wlan-ng: p80211conv: fix indentation
 problems, introduced by previous commit
Message-ID: <Ze+LMgwYYK6LN79O@aschofie-mobl2>
References: <Ze9Ie67PCSvBU+og@MOLeToid>
 <6d643351-8924-4c86-9fb5-9951e016f5db@gmail.com>
 <b9cc75d2-3e06-43d6-8b70-38d1c97124d2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9cc75d2-3e06-43d6-8b70-38d1c97124d2@gmail.com>

On Mon, Mar 11, 2024 at 10:34:20PM +0100, Felix N. Kimbu wrote:
> Thank for you the feedback Philipp, I have checked
> 
> and corrected the checkpatch warnings.
> 

Please follow process for revisioning patches here:
First Patch Tutorial Section: Revising your patches
when you send a v3.

> 
> Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>
> ---
>  drivers/staging/wlan-ng/p80211conv.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/p80211conv.c
> b/drivers/staging/wlan-ng/p80211conv.c
> index a0413928a843..e48a80df87a6 100644
> --- a/drivers/staging/wlan-ng/p80211conv.c
> +++ b/drivers/staging/wlan-ng/p80211conv.c
> @@ -186,9 +186,9 @@ int skb_ether_to_p80211(struct wlandevice *wlandev, u32
> ethconv,
>          if (!p80211_wep->data)
>              return -ENOMEM;
>          decrypt_check = wep_encrypt(wlandev, skb->data, p80211_wep->data,
> -                                      skb->len,
> -                                    wlandev->hostwep &
> HOSTWEP_DEFAULTKEY_MASK,
> -                                    p80211_wep->iv, p80211_wep->icv);
> +                        skb->len,
> +                        wlandev->hostwep & HOSTWEP_DEFAULTKEY_MASK,
> +                        p80211_wep->iv, p80211_wep->icv);
>          if (decrypt_check) {
>              netdev_warn(wlandev->netdev,
>                      "Host en-WEP failed, dropping frame (%d).\n",
> @@ -306,10 +306,10 @@ int skb_p80211_to_ether(struct wlandevice *wlandev,
> u32 ethconv,
>              return 1;
>          }
>          decrypt_check = wep_decrypt(wlandev, skb->data + payload_offset +
> 4,
> -                                    payload_length - 8, -1,
> -                                    skb->data + payload_offset,
> -                                    skb->data + payload_offset +
> -                                    payload_length - 4);
> +                        payload_length - 8, -1,
> +                        skb->data + payload_offset,
> +                        skb->data + payload_offset +
> +                        payload_length - 4);
>          if (decrypt_check) {
>              /* de-wep failed, drop skb. */
>              netdev_dbg(netdev, "Host de-WEP failed, dropping frame
> (%d).\n",
> -- 
> 2.34.1
> 
> On 3/11/24 20:31, Philipp Hortmann wrote:
> > On 3/11/24 19:07, Felix N. Kimbu wrote:
> > > This change renames the local variable foo to decrypt_check in functions
> > > skb_ether_to_p80211(...) and skb_p80211_to_ether(...), giving intuitive
> > > meaning to the identifier.
> > > 
> > > It also indents the parameters to match the the opening parentheses.
> > > 
> > > Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>
> > 
> > Hi Felix,
> > 
> > I think the subject names the subsystem "staging" and then the driver
> > which is "wlan-ng" the file can follow but you cannot omit the driver
> > name.
> > 
> > 
> > Please check the following checkpatch warnings:
> > File Nr: 0    Patch: ../../../Downloads/20240311-[PATCH] staging_
> > p80211conv_ Rename local foo to decrypt_check-15036.txt
> > WARNING: Possible repeated word: 'the'
> > #11:
> > It also indents the parameters to match the the opening parentheses.
> > 
> > ERROR: code indent should use tabs where possible
> > #41: FILE: drivers/staging/wlan-ng/p80211conv.c:189:
> > +^I^I^I^I  ^I^I^I^I^Iskb->len,$
> > 
> > WARNING: please, no space before tabs
> > #41: FILE: drivers/staging/wlan-ng/p80211conv.c:189:
> > +^I^I^I^I  ^I^I^I^I^Iskb->len,$
> > 
> > CHECK: Alignment should match open parenthesis
> > #41: FILE: drivers/staging/wlan-ng/p80211conv.c:189:
> > +        decrypt_check = wep_encrypt(wlandev, skb->data,
> > p80211_wep->data,
> > +                                      skb->len,
> > 
> > WARNING: line length of 115 exceeds 100 columns
> > #42: FILE: drivers/staging/wlan-ng/p80211conv.c:190:
> > +                                    wlandev->hostwep &
> > HOSTWEP_DEFAULTKEY_MASK,
> > 
> > WARNING: line length of 105 exceeds 100 columns
> > #43: FILE: drivers/staging/wlan-ng/p80211conv.c:191:
> > +                                    p80211_wep->iv, p80211_wep->icv);
> > 
> > CHECK: Alignment should match open parenthesis
> > #72: FILE: drivers/staging/wlan-ng/p80211conv.c:309:
> > +        decrypt_check = wep_decrypt(wlandev, skb->data + payload_offset
> > + 4,
> > +                                    payload_length - 8, -1,
> > 
> > total: 1 errors, 4 warnings, 2 checks, 58 lines checked
> > 
> > Thanks for your support.
> > 
> > Bye Philipp
> > 
> > 
> > > ---
> > >   drivers/staging/wlan-ng/p80211conv.c | 30 ++++++++++++++--------------
> > >   1 file changed, 15 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/staging/wlan-ng/p80211conv.c
> > > b/drivers/staging/wlan-ng/p80211conv.c
> > > index 8336435eccc2..a0413928a843 100644
> > > --- a/drivers/staging/wlan-ng/p80211conv.c
> > > +++ b/drivers/staging/wlan-ng/p80211conv.c
> > > @@ -93,7 +93,7 @@ int skb_ether_to_p80211(struct wlandevice
> > > *wlandev, u32 ethconv,
> > >       struct wlan_ethhdr e_hdr;
> > >       struct wlan_llc *e_llc;
> > >       struct wlan_snap *e_snap;
> > > -    int foo;
> > > +    int decrypt_check;
> > >         memcpy(&e_hdr, skb->data, sizeof(e_hdr));
> > >   @@ -185,14 +185,14 @@ int skb_ether_to_p80211(struct wlandevice
> > > *wlandev, u32 ethconv,
> > >           p80211_wep->data = kmalloc(skb->len, GFP_ATOMIC);
> > >           if (!p80211_wep->data)
> > >               return -ENOMEM;
> > > -        foo = wep_encrypt(wlandev, skb->data, p80211_wep->data,
> > > -                  skb->len,
> > > -                  wlandev->hostwep & HOSTWEP_DEFAULTKEY_MASK,
> > > -                  p80211_wep->iv, p80211_wep->icv);
> > > -        if (foo) {
> > > +        decrypt_check = wep_encrypt(wlandev, skb->data,
> > > p80211_wep->data,
> > > +                                      skb->len,
> > > +                                    wlandev->hostwep &
> > > HOSTWEP_DEFAULTKEY_MASK,
> > > +                                    p80211_wep->iv, p80211_wep->icv);
> > > +        if (decrypt_check) {
> > >               netdev_warn(wlandev->netdev,
> > >                       "Host en-WEP failed, dropping frame (%d).\n",
> > > -                    foo);
> > > +                    decrypt_check);
> > >               kfree(p80211_wep->data);
> > >               return 2;
> > >           }
> > > @@ -265,7 +265,7 @@ int skb_p80211_to_ether(struct wlandevice
> > > *wlandev, u32 ethconv,
> > >       struct wlan_llc *e_llc;
> > >       struct wlan_snap *e_snap;
> > >   -    int foo;
> > > +    int decrypt_check;
> > >         payload_length = skb->len - WLAN_HDR_A3_LEN - WLAN_CRC_LEN;
> > >       payload_offset = WLAN_HDR_A3_LEN;
> > > @@ -305,15 +305,15 @@ int skb_p80211_to_ether(struct wlandevice
> > > *wlandev, u32 ethconv,
> > >                      "WEP frame too short (%u).\n", skb->len);
> > >               return 1;
> > >           }
> > > -        foo = wep_decrypt(wlandev, skb->data + payload_offset + 4,
> > > -                  payload_length - 8, -1,
> > > -                  skb->data + payload_offset,
> > > -                  skb->data + payload_offset +
> > > -                  payload_length - 4);
> > > -        if (foo) {
> > > +        decrypt_check = wep_decrypt(wlandev, skb->data +
> > > payload_offset + 4,
> > > +                                    payload_length - 8, -1,
> > > +                                    skb->data + payload_offset,
> > > +                                    skb->data + payload_offset +
> > > +                                    payload_length - 4);
> > > +        if (decrypt_check) {
> > >               /* de-wep failed, drop skb. */
> > >               netdev_dbg(netdev, "Host de-WEP failed, dropping frame
> > > (%d).\n",
> > > -                   foo);
> > > +                   decrypt_check);
> > >               wlandev->rx.decrypt_err++;
> > >               return 2;
> > >           }
> > 
> 

