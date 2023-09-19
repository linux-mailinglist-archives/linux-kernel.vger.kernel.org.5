Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F057A5EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjISJ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjISJzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:55:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021E1E8;
        Tue, 19 Sep 2023 02:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695117275; x=1726653275;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=oZY5PqJtGsR5HLvU2+7WLtxKxYPxhkEGf7BAAURrFH0=;
  b=Xm3aMPFVfoRlSDM4kr06NamoTuGpbBUhwsL2PPzU12NnpUyaaMscpHT+
   TOayRc10uxBUuuicoZ/WYo+PVsagFiiEl3XGgGpnj8LD0gnrYN0BgaZVH
   b8aSS/K9QxqlTCWH4+82t9DqaSt8GWntIPfR3QOrrCRYNRkrlTgwVzpQp
   GV3bZizP1nEsDP+1a07Q+ptiXhzw9Yrrg2u7cQFda/JI+Segxd9dUEUWf
   kUnUC+qHJSbRdmdcc4B7nRFSYvtrH4WGytiTV6jW7nqw2j2tnTPk2KB4N
   g6SPlsBCu4Zz1ylWp/MwRUKa3JKJVn+iCaaffHItgHnCxTugonVPbd/mS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="382651720"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="382651720"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 02:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="836378075"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="836378075"
Received: from laichele-mobl1.ger.corp.intel.com ([10.252.38.7])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 02:54:32 -0700
Date:   Tue, 19 Sep 2023 12:54:31 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] tty: n_tty: invert the condition in
 copy_from_read_buf()
In-Reply-To: <20230919085156.1578-5-jirislaby@kernel.org>
Message-ID: <2f8f7e-d0bd-b8c3-a8b8-d14fd0221e4d@linux.intel.com>
References: <20230919085156.1578-1-jirislaby@kernel.org> <20230919085156.1578-5-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1147994577-1695117248=:1920"
Content-ID: <38ab972a-d4c6-b9dc-d589-998d4d42451e@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1147994577-1695117248=:1920
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <911640b0-635e-e7bf-2f3d-667cb0d328e9@linux.intel.com>

On Tue, 19 Sep 2023, Jiri Slaby (SUSE) wrote:

> Make "no numbers available" a fast quit from the function. And do the

Did you really intend to write "numbers" and not e.g. characters?

The change itself looks good,

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

> heavy work outside the 'if'. This makes the code more understandable and
> conforming to the common kernel coding style.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/n_tty.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index 6a112910c058..922fb61b587a 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -1966,24 +1966,26 @@ static bool copy_from_read_buf(const struct tty_struct *tty, u8 **kbp,
>  	size_t tail = MASK(ldata->read_tail);
>  
>  	n = min3(head - ldata->read_tail, N_TTY_BUF_SIZE - tail, *nr);
> -	if (n) {
> -		u8 *from = read_buf_addr(ldata, tail);
> -		memcpy(*kbp, from, n);
> -		is_eof = n == 1 && *from == EOF_CHAR(tty);
> -		tty_audit_add_data(tty, from, n);
> -		zero_buffer(tty, from, n);
> -		smp_store_release(&ldata->read_tail, ldata->read_tail + n);
> -		/* Turn single EOF into zero-length read */
> -		if (L_EXTPROC(tty) && ldata->icanon && is_eof &&
> -		    (head == ldata->read_tail))
> -			return false;
> -		*kbp += n;
> -		*nr -= n;
> -
> -		/* If we have more to copy, let the caller know */
> -		return head != ldata->read_tail;
> -	}
> -	return false;
> +	if (!n)
> +		return false;
> +
> +	u8 *from = read_buf_addr(ldata, tail);
> +	memcpy(*kbp, from, n);
> +	is_eof = n == 1 && *from == EOF_CHAR(tty);
> +	tty_audit_add_data(tty, from, n);
> +	zero_buffer(tty, from, n);
> +	smp_store_release(&ldata->read_tail, ldata->read_tail + n);
> +
> +	/* Turn single EOF into zero-length read */
> +	if (L_EXTPROC(tty) && ldata->icanon && is_eof &&
> +	    head == ldata->read_tail)
> +		return false;
> +
> +	*kbp += n;
> +	*nr -= n;
> +
> +	/* If we have more to copy, let the caller know */
> +	return head != ldata->read_tail;
>  }
>  
>  /**
> 
--8323329-1147994577-1695117248=:1920--
