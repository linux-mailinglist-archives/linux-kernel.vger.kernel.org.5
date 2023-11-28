Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C65C7FC1B4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344996AbjK1Q4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbjK1Q4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:56:05 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8152810DF;
        Tue, 28 Nov 2023 08:56:10 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cbe68095a3so4377898b3a.3;
        Tue, 28 Nov 2023 08:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701190570; x=1701795370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9nMu2b9XnNdD7wwpc++nEgEZUAhRsWBPvFZ/Lzv9fU=;
        b=Lo4QXgCvx2WCiRB8oO6oxd3mjwdJW7Qj69j9JAJ4ldMooqv9h4PDFoSNj91Yx5DGqZ
         O4qFChXx/gU7fFlT5uQhBit77Biv+YGjYDTKk28nambdWyirKPlaTtzqm57T8Iq4pWOp
         wtzr1fHQBfHvTcrHhYBMHDOfyDo4RFKezw5mlZvzpT45JUbZOTzhJq/tXvO0KCcVguj8
         Jgx/8Ld0i75T6SpTSr0r+KoleJdps/9J/Fox8g0t4rvYOHysZxMyAFYTMXdGPsHM2+4M
         FWPGBi2KRs2s0Hsf9RaCORB+5C5QEFZkRqKSwWO2GnGBxC3tu6ltLBpkGyZ63Y0+Dmmg
         0AjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190570; x=1701795370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9nMu2b9XnNdD7wwpc++nEgEZUAhRsWBPvFZ/Lzv9fU=;
        b=UK2Svwi/7VtHoU0H8LKiG7O7FwiXPEFemZp5IkcbowSHW5Hvn0R1agbQAZLPQFS6XO
         hw9WZQimZfqBt2AanauY7zL1U/7vQT5awjPsOA5yZBPYfGMpFifgm/fhM1rBmchQ0DUs
         xLTRTlMMPHbIPc81XcJXjF/GMpp4fN/HB412jmmvlwiNwuvHNh7dh9rSA+5cBd2raeYZ
         QYL/gORjFqESwDnUyQxFfBmEAid0Vxi0gNrKIX89XfNjlaZl4Wvwio73Ax9ApK6QjsI0
         qLZS2zY+uv7+cGvY91kfmO7ykrxZIbniXw1qP8CT0kqvAtZ7zYAAvUdt46VqJY5AD2Te
         iJEA==
X-Gm-Message-State: AOJu0Yz9RWUesLIvGzmcUWNf4QgK316qYBDKP/6rmWi+e8MNwdbs3q8W
        FwcXAFsmECDsCMtYIYi5mZs=
X-Google-Smtp-Source: AGHT+IECbePOLzsM4J0Ktx1r5sk5ABhCCoNJdirIjQQSp8+v1zuJzbqUDRkvRuvPh0n2Sq5li0OJfQ==
X-Received: by 2002:a05:6a00:4396:b0:6cb:8bb7:dfb5 with SMTP id bt22-20020a056a00439600b006cb8bb7dfb5mr17375576pfb.25.1701190569871;
        Tue, 28 Nov 2023 08:56:09 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id q4-20020a631f44000000b005acd5d7e11bsm9690803pgm.35.2023.11.28.08.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:56:09 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 28 Nov 2023 06:56:08 -1000
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
        Peter Hunt <pehunt@redhat.com>
Subject: Re: [PATCH-cgroup 2/2] cgroup/cpuset: Include isolated cpuset CPUs
 in cpu_is_isolated() check
Message-ID: <ZWYbqNnnt6gQOssK@slm.duckdns.org>
References: <20231127041956.266026-1-longman@redhat.com>
 <20231127041956.266026-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127041956.266026-3-longman@redhat.com>
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

Hello,

On Sun, Nov 26, 2023 at 11:19:56PM -0500, Waiman Long wrote:
> +bool cpuset_cpu_is_isolated(int cpu)
> +{
> +	unsigned int seq;
> +	bool ret;
> +
> +	do {
> +		seq = read_seqcount_begin(&isolcpus_seq);
> +		ret = cpumask_test_cpu(cpu, isolated_cpus);
> +	} while (read_seqcount_retry(&isolcpus_seq, seq));
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cpuset_cpu_is_isolated);

We're testing a bit in a bitmask. I don't think we need to worry about value
integrity from RMW updates being broken up. ie. We can just test the bit
without seqlock and drop the first patch?

Thanks.

-- 
tejun
