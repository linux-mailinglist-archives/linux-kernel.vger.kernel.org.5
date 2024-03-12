Return-Path: <linux-kernel+bounces-100758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 400D1879CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CADB1C213B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DA5142911;
	Tue, 12 Mar 2024 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEn1iOLN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6041386AA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275116; cv=none; b=n1dAhSPlzH7L+YyoHo4G0l+77uVxWdawIAkjkHN8JsZMIrIVKjArIEY/5+h05tcv2/tcpbkL5suCUXJcuO7gHOimzzWR/6iNW1fiJTPaK5ywKYQRmfarD9KbwF+2jpT9Tq5lOZABKV1ejDvtpONv1W0fbZ/SfMA5psNAcx7mZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275116; c=relaxed/simple;
	bh=rSNSvxiZSQWXgjIt9kA8y08rpxtYHSeBq2jVU2yann0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUxGEgzAqXdUSiXphrtsH7XNC+WVZK9I8NVmWbHVesCNI3THwGjfAxariMiHJGaogWefel2nw6qfIhZ59Q+UhaE3d/vElz/r+NNvRXd5JJs52wiuX+Iop/826wgVl4N0f+BQPl0WpHaNSPt8+ewqy3uwtxnl1BOPVk7Zp60lFyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEn1iOLN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710275114; x=1741811114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rSNSvxiZSQWXgjIt9kA8y08rpxtYHSeBq2jVU2yann0=;
  b=JEn1iOLNtPhAnHLF2msRdBMhhCxDRrgRKpx0U0i9u1SmziWhgyk8yl2u
   jC/wQpjyFmJ4PJvhfh78SmZOrIa59LjUMm2jpELsGgdhmjc7jmboM5It4
   G4na8xtdLkAoAtJN0vQG/cjxNsPz38NwABSjCtjaXcrpcrUCeo1mC3tm3
   MGR3W37Dz04UVLh6RWSYB6EffYIMLgXFRR2I2Z89eToVYhtvtybkoEZ6+
   4CF4RadMsCfY3nd8D4g5mCLKNZxWSOlOYSuCrZwsT0+VaM0oixz+vIX1u
   EnIjEmWu7bP4cntKd054gXVeokW3pmjCXXq3aAZLtZI7kjneHbQbSib6k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5618040"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5618040"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 13:25:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11588394"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.10.107])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 13:25:11 -0700
Date: Tue, 12 Mar 2024 13:25:09 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Felix N. Kimbu" <felixkimbu1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH v3] staging: wlan-ng: Rename 'foo' to 'rc' in p80211conv.c
Message-ID: <ZfC6JeVBa9weWBSU@aschofie-mobl2>
References: <ZfCM2RyeEpxooKz+@MOLeToid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfCM2RyeEpxooKz+@MOLeToid>

On Tue, Mar 12, 2024 at 06:11:53PM +0100, Felix N. Kimbu wrote:

Hi Felix,
Thanks for sending this v3 as a new patch. Now, I'm going to ask
you to create a v4 to straighten out a bit more of the patch
format.

The commit message below includes some revision history that only
belongs below the '---',  Your commit message will be with this
patch when it is committed, and the changelog will fall away.
The changelog benefits reviewers today, and it also is always
retrievable in Lore for folks curious about the patches journey.

So, I'll make some edits directly below indicating what I think
v4 should look like.

Caveat 1: I didn't test the patch. I expect it applies, compiles,
and passes checkpatch.  Double check that all on v4.

Caveat 2: I don't know if GregKH is going to accept this trivial
patch. That's OK.  By the time we get though v4 you will have 
applied a bunch of patching practices that you can take forward
to your next patches.

> Rename identifer 'foo' to 'rc' Suggested-by Alison Schofield in functions
> skb_p80211_to_ether() and skb_ether_to_p80211().
> 

Replace above with:
Rename identifier 'foo' to 'rc' in skb_p80211_to_ether() and
skb_ether_to_p80211() to match the common kernel coding style.

(Try to get the spell checker running with checkpatch to catch things
like the misspelled 'identifer' above.)


Delete from here:
> Fix indentation necessitated by above rename Suggested-by Dan Carpenter
> and Philipp Hortmann.
> 
> This change adds intuitive meaning to the idenfier, adhering to best
> practices and coding style.
> 
to here.

> 
> Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>
> ---

(The names in parens is optional. Folks often do it to make
it easier for reviewers to find what they last commented, and
also it is a bit of a nod, appreciating your reviewers)

Changes in v4:
- Remove changelog comments from commit log (AlisonS)

Changes in v3:
- Create a proper new patch revision (AlisonS)
- Use 'rc' instead of 'decrypt_check' (AlisonS)

Changes in v2:
- Fix wrong indentation introduced in v1 (DanC)
- Correct subject to include driver (PhilippH)


> 
>  drivers/staging/wlan-ng/p80211conv.c | 30 ++++++++++++++--------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/p80211conv.c b/drivers/staging/wlan-ng/p80211conv.c
> index 8336435eccc2..7401a6cacb7f 100644
> --- a/drivers/staging/wlan-ng/p80211conv.c
> +++ b/drivers/staging/wlan-ng/p80211conv.c
> @@ -93,7 +93,7 @@ int skb_ether_to_p80211(struct wlandevice *wlandev, u32 ethconv,
>  	struct wlan_ethhdr e_hdr;
>  	struct wlan_llc *e_llc;
>  	struct wlan_snap *e_snap;
> -	int foo;
> +	int rc;
>  
>  	memcpy(&e_hdr, skb->data, sizeof(e_hdr));
>  
> @@ -185,14 +185,14 @@ int skb_ether_to_p80211(struct wlandevice *wlandev, u32 ethconv,
>  		p80211_wep->data = kmalloc(skb->len, GFP_ATOMIC);
>  		if (!p80211_wep->data)
>  			return -ENOMEM;
> -		foo = wep_encrypt(wlandev, skb->data, p80211_wep->data,
> -				  skb->len,
> -				  wlandev->hostwep & HOSTWEP_DEFAULTKEY_MASK,
> -				  p80211_wep->iv, p80211_wep->icv);
> -		if (foo) {
> +		rc = wep_encrypt(wlandev, skb->data, p80211_wep->data,
> +				 skb->len,
> +				 wlandev->hostwep & HOSTWEP_DEFAULTKEY_MASK,
> +				 p80211_wep->iv, p80211_wep->icv);
> +		if (rc) {
>  			netdev_warn(wlandev->netdev,
>  				    "Host en-WEP failed, dropping frame (%d).\n",
> -				    foo);
> +				    rc);
>  			kfree(p80211_wep->data);
>  			return 2;
>  		}
> @@ -265,7 +265,7 @@ int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
>  	struct wlan_llc *e_llc;
>  	struct wlan_snap *e_snap;
>  
> -	int foo;
> +	int rc;
>  
>  	payload_length = skb->len - WLAN_HDR_A3_LEN - WLAN_CRC_LEN;
>  	payload_offset = WLAN_HDR_A3_LEN;
> @@ -305,15 +305,15 @@ int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
>  				   "WEP frame too short (%u).\n", skb->len);
>  			return 1;
>  		}
> -		foo = wep_decrypt(wlandev, skb->data + payload_offset + 4,
> -				  payload_length - 8, -1,
> -				  skb->data + payload_offset,
> -				  skb->data + payload_offset +
> -				  payload_length - 4);
> -		if (foo) {
> +		rc = wep_decrypt(wlandev, skb->data + payload_offset + 4,
> +				 payload_length - 8, -1,
> +				 skb->data + payload_offset,
> +				 skb->data + payload_offset +
> +				 payload_length - 4);
> +		if (rc) {
>  			/* de-wep failed, drop skb. */
>  			netdev_dbg(netdev, "Host de-WEP failed, dropping frame (%d).\n",
> -				   foo);
> +				   rc);
>  			wlandev->rx.decrypt_err++;
>  			return 2;
>  		}
> -- 
> 2.34.1
> 
> 

