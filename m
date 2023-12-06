Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91588078BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442794AbjLFTiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379286AbjLFTiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:38:15 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE389D4B;
        Wed,  6 Dec 2023 11:38:21 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-28654179ec0so177993a91.2;
        Wed, 06 Dec 2023 11:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701891501; x=1702496301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3hX5NMSuRdxJ6nAzp41n5iuA2rkZ/CQ1l6SQPd6Q7g=;
        b=d4qR34YVC9b1wITAkmfFN+2RQEV++342zHZ0ErpTxHxjQHvVTNpgGM23T0Udm2HG0A
         69WOBg6osPLeuLKQj2ywcuwqxLHj/KxS/b/zbafnmQPy9sF7iAfJIjBhpsj5vbzmkSNk
         PzMPY+tVO1GxTue+skG4c7qOznJqshVRbyLjYMmfW6VIq8SPb+S24lxN0LbEs3k1j8gZ
         R1Ai9UHZha3Axdp9VUrdt4PPz37wYMIMJ3pK/GG2r/yzWbn1G6Y4BGBTJ6nAo5IFprGA
         t8+PDgzk6KYGIbrlGDkVmpAlJZ0Dgo8a2PKiE11045FTfNNtp+uSGuEWXd7UOgkY5SND
         T9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701891501; x=1702496301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3hX5NMSuRdxJ6nAzp41n5iuA2rkZ/CQ1l6SQPd6Q7g=;
        b=DWW6WuJYindsaAo2IGryjBXsldmkknIbXtPJ93/Ed5Ej0anqqUS6aoImeyP6YxmbgR
         k4HxqkNanNFWxt0aEFxT+9l+8jrVse44sSVFE8BkgM6qwiWnHqDgeFCd+cCEDrhfQYF/
         VHv+TuiR8/8dizf+CtdGb2IH9yvexGCEOosYJuN9z6oIrrzweL5ACAjsqDaO/+Kz19cI
         sv1g3XrUM6ng0X68FINhxMw46gGB4Holp7tKMWvXhb1GhibMPoDcqIfFHMl/BwcD2m9o
         L6J8hPWRXJIFBOkTIz99nnkp5atlNk4PyK0C2n8iw2e6eYosutbf8l7H0Ru9VbR0NfOY
         oFQA==
X-Gm-Message-State: AOJu0YwFyMeSGpaP3FUQ67+Dk+8+ut2Qebv5PRB6TFWt0AF3Y4mwfmBT
        Eh3UGEA9Y29Z3J3GFu0BHBs=
X-Google-Smtp-Source: AGHT+IF3psGFqZBe6gBP6OT1d+U1ZmQ7dTO+uxp+N8sF/rl1Rz8qYHZ0CwADi5hVhHP6btYP0zd8YA==
X-Received: by 2002:a17:90a:d48c:b0:286:c7af:b68e with SMTP id s12-20020a17090ad48c00b00286c7afb68emr1577344pju.72.1701891501198;
        Wed, 06 Dec 2023 11:38:21 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id fs3-20020a17090af28300b002801ca4fad2sm247255pjb.10.2023.12.06.11.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 11:38:20 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 6 Dec 2023 09:38:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>,
        Cestmir Kalina <ckalina@redhat.com>
Subject: Re: [PATCH-cgroup v2] cgroup/cpuset: Include isolated cpuset CPUs in
 cpu_is_isolated() check
Message-ID: <ZXDNq6n1XtY8U7Vp@slm.duckdns.org>
References: <20231205222114.773446-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205222114.773446-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 05:21:14PM -0500, Waiman Long wrote:
> Currently, the cpu_is_isolated() function checks only the statically
> isolated CPUs specified via the "isolcpus" and "nohz_full" kernel
> command line options. This function is used by vmstat and memcg to
> reduce interference with isolated CPUs by not doing stat flushing
> or scheduling works on those CPUs.
> 
> Workloads running on isolated CPUs within isolated cpuset
> partitions should receive the same treatment to reduce unnecessary
> interference. This patch introduces a new cpuset_cpu_is_isolated()
> function to be called by cpu_is_isolated() so that the set of dynamically
> created cpuset isolated CPUs will be included in the check.
> 
> Assuming that testing a bit in a cpumask is atomic, no synchronization
> primitive is currently used to synchronize access to the cpuset's
> isolated_cpus mask.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.8.

Thanks.

-- 
tejun
