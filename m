Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16EE7C006D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjJJPdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjJJPda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:33:30 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F0597
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:33:27 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1dd8304b980so3953912fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20230601.gappssmtp.com; s=20230601; t=1696952005; x=1697556805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGlpVdouqGa9tjwhATNKF2y55bHjxSTMENocH/RFUw0=;
        b=29V3MrYo6/qr3cFxlteTW6hlqY+bPCXPU69VLYmx4MMAgR06rMkk+H9AG6lJgzdlRJ
         SuYWfyQoILpISM+J6MGjgmaY6uGc6+8wddK3sEsC2Zi+RTnZHnURUsiKxLJz07UJNjOl
         NgSunq2agriDhumGaJNjPbgx/FgFT40Kutb6SOIpG5U0yEcilIsqNTJfGUX2G92Mf/8d
         dLACrVSPr9quXSKbisvvHyO5yZJG5+YM9MZztlMezyfz3pvPSzs63bLYf8ByEwq4fBhb
         qDi8AgmebAzwCScYVi4LPQfJvdNDwSgdx+v4k9kIQnvIR+3bKq0zsjFBKjpapjph08EB
         6ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696952005; x=1697556805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGlpVdouqGa9tjwhATNKF2y55bHjxSTMENocH/RFUw0=;
        b=wtiNlxW4PPnUtiwBKHknIJU9fq/pGHE34pjHx4HvfLRYVtZw8zsZKBPvNgX6MOLsLc
         QKO+pCteChT2y1dhPZrc8wfZMRfpGArqWd6qafpsl6Za0nnVfFPLordaZpEKIx4EwBlC
         Q+L7MW4PN9A5LZ3SipNns/cvJcqTEKokMZnv5VhP6OP4mC/zHOYfCCUDndIe0Dm123QW
         OVfhBZ1Shr873yyyElSnoOyP0qrXiTLrb3b5lhfYpLwmMhrb9PFG45oLglgBtp6RtZ7Q
         H+MY5K16Vw+yLCB0m62CG1hkqIqGuSOjuZsfq4Pii2/GsPq+dOMxA60KbGnLdwAORu2P
         saaQ==
X-Gm-Message-State: AOJu0YwMaaMkZf55JmKi9esPNT2ZbaF/WUTmhpWxgSqHpYARFSmmQBNK
        CVO6TUn9l8EMk58ckt9SrkNoaA==
X-Google-Smtp-Source: AGHT+IHaVjBX/KKQCZ+08ab9lVXi9B7/NzADTcWcYhQJpdODEVyyVsyCdZOr1780dfWB9WEehXuuBw==
X-Received: by 2002:a05:6870:ac1f:b0:1bf:50e0:95d9 with SMTP id kw31-20020a056870ac1f00b001bf50e095d9mr22193563oab.26.1696952005357;
        Tue, 10 Oct 2023 08:33:25 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a684:4100:8ac9:b3ff:febf:a2f8])
        by smtp.gmail.com with ESMTPSA id w9-20020a0cb549000000b0065b14fcfca6sm4862356qvd.118.2023.10.10.08.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 08:33:24 -0700 (PDT)
Date:   Tue, 10 Oct 2023 11:33:17 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Max Hawking <maxahawking@sonnenkinder.org>
Cc:     Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Minjie Du <duminjie@vivo.com>, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ntb_perf: Fix printk format
Message-ID: <ZSVuvSh0B4usJkMX@kudzu.us>
References: <2ad3273e-1212-428d-b598-e6a82c2bc570@sonnenkinder.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ad3273e-1212-428d-b598-e6a82c2bc570@sonnenkinder.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 08:45:16PM -0700, Max Hawking wrote:
> The correct printk format is %pa or %pap, but not %pa[p].
> 
> Fixes: 99a06056124d ("NTB: ntb_perf: Fix address err in perf_copy_chunk")
> Signed-off-by: Max Hawking <maxahawking@sonnenkinder.org>

Applied to my ntb branch

Thanks,
Jon

> ---
>  drivers/ntb/test/ntb_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 553f1f46bc66..72bc1d017a46 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -1227,7 +1227,7 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
>  			"\tOut buffer addr 0x%pK\n", peer->outbuf);
> 
>  		pos += scnprintf(buf + pos, buf_size - pos,
> -			"\tOut buff phys addr %pa[p]\n", &peer->out_phys_addr);
> +			"\tOut buff phys addr %pap\n", &peer->out_phys_addr);
> 
>  		pos += scnprintf(buf + pos, buf_size - pos,
>  			"\tOut buffer size %pa\n", &peer->outbuf_size);
> --
> 2.41.0
> 
