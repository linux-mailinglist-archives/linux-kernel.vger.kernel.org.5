Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DFF7AB2B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjIVNaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbjIVNa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:30:27 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7465CCD5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:30:19 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77386822cfbso131399685a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695389418; x=1695994218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=25YXU+FGYNokEvJDmLWZ05x6wqgiem9ZONDjs8ENa1c=;
        b=ZNJq6jp9DefnePgPuCmCs8gyBxPoJiP6uO5D4CI6qNIUBMeZDLz7RYKD7p5hxiU/rl
         ArtLg5StznbjQkNt5E4Jd3n0xBp7/7BIGKlmwo4RWldZqOgLU4LWQ0Jd8BqGogLEHjxf
         tSFV18dJJ7Cq7tfX76DqbH8OSirC31Ha6jIbxdC+fRq3OnurdUaeywOU3H8cdk6tJMFE
         g2e0Rjon7a7ZE8wpDbtbySrA0WG2NE2B8VvKoLaYOlsWJWP73aKlESG2sam0l4m1Kh4c
         Quk12lYxj2O96AZKy9KAEFUgUQx0FmS/tPOt7BIHUY8aYe7tZ5nDHNQrEF2bNzbxc/DP
         NsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695389418; x=1695994218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25YXU+FGYNokEvJDmLWZ05x6wqgiem9ZONDjs8ENa1c=;
        b=Hs4ccJSCUYMn4+UXDTsglto9s8YcFjntTNgnRbLupldqsMleqnzMLxzVGCSkFRc99e
         Jh4TBthqt/GM9F4RxmlASDwv05awmXCAfsIY9C0D3LCkvbcznePvnaSVpV64IkMJtd/w
         Muf1fWIDd/m7hvY8lO0a0NBgGrL1MSMhuYoA/k5hMsRWshdxsd/moMfOxRRsJJQV64fy
         k4BTqAW8zvtGsACp+H+ydYIwzE/UZORkncAw9PvrzZRbD8a810FfxUlx+DwYNzBb5I/f
         DzK4y794aU0drgcrmZXSzPd9wgWpaTPMTLJfzo8Z9E0IRjl6iQ0QbDZZ4MJod/P7QEQY
         l2dw==
X-Gm-Message-State: AOJu0YxSPr397r/i9QWvDS+rhKQUCvo9Ph6rDDW8jq3pNvMh+iq8gmGa
        DvNtYtmId1KhW/wd1WYBGTESww==
X-Google-Smtp-Source: AGHT+IGXdvy0h/AAP4iGOiWzOq4RBdacLRt7M19j/1maM6/SRiZF/MBIleQ4bgzfkum4End6z3qCgQ==
X-Received: by 2002:a05:620a:795:b0:76d:9b15:de71 with SMTP id 21-20020a05620a079500b0076d9b15de71mr7888694qka.31.1695389418545;
        Fri, 22 Sep 2023 06:30:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ba06])
        by smtp.gmail.com with ESMTPSA id p13-20020a05620a056d00b007740c0e52edsm1240421qkp.89.2023.09.22.06.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 06:30:18 -0700 (PDT)
Date:   Fri, 22 Sep 2023 09:30:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        mathieu.tortuyaux@gmail.com
Subject: Re: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop
 kmem.limit_in_bytes
Message-ID: <20230922133017.GD124289@cmpxchg.org>
References: <4eb47d6a-b127-4aad-af30-896c3b9505b4@linux.microsoft.com>
 <ZQr3+YfcBM2Er6F7@dhcp22.suse.cz>
 <CALvZod7E_Jm9y+40OKtLs5EFA0ptKGjoe2BU58SY29pUiPc93g@mail.gmail.com>
 <ZQskGGAwlsr1YxAp@dhcp22.suse.cz>
 <CALvZod6b3=+=xXEUeWOQW3t_URJpeeVX46WjBHv5BS+436KoFA@mail.gmail.com>
 <ZQtRKzUOfdaVKRCF@dhcp22.suse.cz>
 <CALvZod5DSMoEGY0CwGz=P-2=Opbr4SmMfwHhZRROBx7yCaBdDA@mail.gmail.com>
 <ZQv2MXOynlEPW/bX@dhcp22.suse.cz>
 <f01b5d93-0f43-41c8-b3d8-40ef9696dcf8@linux.microsoft.com>
 <ZQwnUpX7FlzIOWXP@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQwnUpX7FlzIOWXP@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 01:21:54PM +0200, Michal Hocko wrote:
> @@ -3097,6 +3097,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
>  static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
>  				   unsigned int nr_pages)
>  {
> +	struct page_counter *counter;
>  	struct mem_cgroup *memcg;
>  	int ret;
>  
> @@ -3107,6 +3108,10 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
>  		goto out;
>  
>  	memcg_account_kmem(memcg, nr_pages);
> +
> +	/* There is no way to set up kmem hard limit so this operation cannot fail */
> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +		WARN_ON(!page_counter_try_charge(&memcg->kmem, nr_pages, &counter));

This hunk doesn't look quite right.

static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
{
	mod_memcg_state(memcg, MEMCG_KMEM, nr_pages);
	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
		if (nr_pages > 0)
			page_counter_charge(&memcg->kmem, nr_pages);
		else
			page_counter_uncharge(&memcg->kmem, -nr_pages);
	}
}

Other than that, please add

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
