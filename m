Return-Path: <linux-kernel+bounces-70253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2C3859547
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE901C21390
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA4BE544;
	Sun, 18 Feb 2024 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXLL0McN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1330A746B
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708242330; cv=none; b=ktzPDSGpCXc15YK0n41FkspGkeQtWl9Lcu+kDOyo5XZUKG3wh1OfaTLxI5nscxUOD3GozTRHIgWYpzm0jYKpHUUwT+Fn0mnRKIfVxfvWJpt80me/UwbwoWlHqDA7/gWhxezc0o2PXMZO9BZtIBzaRklP1FjOtYcGalHDtHyJ3Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708242330; c=relaxed/simple;
	bh=ftV4kdXCrIriQxTbvh2OAHv7Gk37s4RDaZuoclRtX6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TCeJ5vbm+pCIf7nllwF4SEbHeUz+HJ9Ogv84R7vLA8P13E58ycJJHjlRPxnlXGCW6ZGTIjwOQkUhUXrlfW02WaMQbLbdR03Y3qL82NZajq9LgCMMfNqC9fIwxuwe9jExGNNf3M2t+NrlAT78hgdF+WHKAmjOjkJ3xT6OFeIt2pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXLL0McN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708242329; x=1739778329;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ftV4kdXCrIriQxTbvh2OAHv7Gk37s4RDaZuoclRtX6c=;
  b=nXLL0McNiQpDdzJrNERFgt6wxvlI5HURJ3WNy69YYM6ySlIXXEx8m/Bb
   2NC/xn/MUWdPp5LgVj1p284+NzTeIX9RB0sXs8WplEVchAVnFfjnB/edo
   agsF80ja+HN3jyuht76w1G4gwCwJyOB3vobUkqMOwDx/DLZr87Gmu09qS
   GKRma2D+/M9neW0/pt/9OwTla2UtHU3AgiOOvefaaRUGcAGAIghKZA66T
   xyJg2Ex5THerpucMtUCZ5O8Q2+V604qhDt4OUWl4Q8WiQjHsr6w2bphpB
   GwNixgl0vJgqSxlXJRrVdc8tB4vSX490o7KB4JD+5rjM6BHfGPKkp1LP6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2195669"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2195669"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 23:45:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="936092066"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="936092066"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 23:45:25 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: liqiang <liqiang64@huawei.com>
Cc: <akpm@linux-foundation.org>,  <paulmck@linux.vnet.ibm.com>,
  <neilb@suse.de>,  <chuck.lever@oracle.com>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] llist: Make llist_del_first return only the
 first node
In-Reply-To: <20240218065750.1241-1-liqiang64@huawei.com> (liqiang's message
	of "Sun, 18 Feb 2024 14:57:50 +0800")
References: <20240218065750.1241-1-liqiang64@huawei.com>
Date: Sun, 18 Feb 2024 15:43:30 +0800
Message-ID: <875xymtdy5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

liqiang <liqiang64@huawei.com> writes:

> Set the next of the returned node of llist_del_first
> to NULL, which can prevent subsequent nodes in llist
> from being exposed, and is more consistent with the
> logic of this interface.
>
> Signed-off-by: liqiang <liqiang64@huawei.com>
> ---
>  lib/llist.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/llist.c b/lib/llist.c
> index f21d0cf..c33fff5 100644
> --- a/lib/llist.c
> +++ b/lib/llist.c
> @@ -61,6 +61,7 @@ struct llist_node *llist_del_first(struct llist_head *head)
>  		next = READ_ONCE(entry->next);
>  	} while (!try_cmpxchg(&head->first, &entry, next));
>  
> +	entry->next = NULL;
>  	return entry;
>  }
>  EXPORT_SYMBOL_GPL(llist_del_first);

This isn't needed for functionality correctness.  Many users of llist
ask for performance.  So, it may be better to let the users to decide
whether to set entry->next to NULL.

--
Best Regards,
Huang, Ying

