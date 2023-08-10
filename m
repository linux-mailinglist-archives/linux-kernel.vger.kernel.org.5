Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC4C776CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 02:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjHJAMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 20:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjHJAM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 20:12:29 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2928E5F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 17:12:28 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-76d1dc1ebfdso72336585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 17:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691626348; x=1692231148;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5uOVqVWqPz+ojEEhEhryKkkf49SNrsxUtFxYnP4qxc=;
        b=X0d6Azmti9neGezYKOXsrfgkr82DJTRLyMkLgFfxKqitAWDmRgbTTipT1w0zLcLtJc
         WWJR6WFArH0IpEjwcead1ujq3za6/0QknKs0Sa9r5vEYZyNc923ZHIo012XLDgR/Oq+3
         pkSOI4E+CuUNAsjZb1g9S0DeBOq5Xk/78F+b02XYMWUY8jRYFzu5IwaPPE95iaICW7/m
         8R31xFTtgRNSQqcBLstIFYHv418CviturXhrjHRnFbx9mZtQT01JYCRrh8c0XJseY2e0
         czE89ushy3gsBDPB5ZcHTbsR759q0Y2fzshUjIw+WInXMogvRF2FpsnNr5hDzAFQeicl
         VkiA==
X-Gm-Message-State: AOJu0YysbsHMDk8Mrc+/9fc7Yd03JYGEkOCmYZcaEwLff691kraSNg88
        CKh1tY5nQ9M6KD0Bz6zwXSE=
X-Google-Smtp-Source: AGHT+IHe3nbetZPK9iWXTtqUu+9Lk/g0GoPger/cQi6c5kYym9FBp6r39B0FLwgMoydV/Elhiodm3Q==
X-Received: by 2002:a0c:e445:0:b0:636:1275:8419 with SMTP id d5-20020a0ce445000000b0063612758419mr622014qvm.13.1691626347726;
        Wed, 09 Aug 2023 17:12:27 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:ed08])
        by smtp.gmail.com with ESMTPSA id u8-20020a0cdd08000000b006360778f314sm57180qvk.105.2023.08.09.17.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 17:12:27 -0700 (PDT)
Date:   Wed, 9 Aug 2023 19:12:24 -0500
From:   David Vernet <void@manifault.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com,
        wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: Re: [PATCH v3 7/7] sched: Shard per-LLC shared runqueues
Message-ID: <20230810001224.GA194574@maniforge>
References: <20230809221218.163894-8-void@manifault.com>
 <202308100717.LGL1juJR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308100717.LGL1juJR-lkp@intel.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 07:46:37AM +0800, kernel test robot wrote:
> Hi David,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on tip/sched/core]
> [cannot apply to linus/master v6.5-rc5 next-20230809]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/David-Vernet/sched-Expose-move_queued_task-from-core-c/20230810-061611
> base:   tip/sched/core
> patch link:    https://lore.kernel.org/r/20230809221218.163894-8-void%40manifault.com
> patch subject: [PATCH v3 7/7] sched: Shard per-LLC shared runqueues
> config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230810/202308100717.LGL1juJR-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230810/202308100717.LGL1juJR-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308100717.LGL1juJR-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/sched/fair.c:198: warning: expecting prototype for struct shared_runq. Prototype was for struct shared_runq_shard instead

I'll split this comment up in v4.
