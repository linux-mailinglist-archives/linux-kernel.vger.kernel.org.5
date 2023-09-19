Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F207A6A49
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjISR4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjISR4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:56:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3AC9E;
        Tue, 19 Sep 2023 10:56:03 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68bed2c786eso5162218b3a.0;
        Tue, 19 Sep 2023 10:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695146163; x=1695750963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzonaQ79d7wJ9qs7WU1NKwWXIzHEEFCVZuaiuHwUSFg=;
        b=DwWhvgQr9IHx/G8f5qKouJuv+45w3EpB2r/ZoougWWpLYR3DMjFcpPr3uTKaXNCTfz
         OnWWVX9UQtdjzeP8jd7G2Wqeua/JW2IVWROzZ3QD4pwSOZePvrrOZ9OR5Qywm98RRo/t
         YKmzRtAScEIduAZv56LTdcIyLvs2f5CUCeHUcfDgNPmIZ3gl+WNSXBoVv27lUjVdG5pT
         4KIM90EcGIGpYkQEqtmsGFWlrFyVwi9bPSoG2FB8xU/Iim05aw7Ei8v9LEwAk6dLwgfV
         Iai49uzf0w3WBfGP6FZbHZSwhy7EZIh3/p/6iXmL88CLMo57BV6rnCfgtqqz1uIiCr7v
         6NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695146163; x=1695750963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzonaQ79d7wJ9qs7WU1NKwWXIzHEEFCVZuaiuHwUSFg=;
        b=VsEQT+IqnHAq/mnPGvtoojzLI0xEZUaCiX6jl3OfPwVXSPmnPJDz0Q4juoVVsX2DwU
         wwfwM0MC4uHsVX4S8bNJ9Pg9cBtztkjvmXf4QEywYBbChgGTeFDuYcIBU2WlSfbg/fLr
         LGWqkrkR3YlLVuW6u1ukGQVuTNYjS3nvRN8T+urJlX9AA9guogHXjGOiY2B/gZVd4lP8
         evRDB0BFKYvx7pDdDnyceN/Bw4KJDocdAnj2YfftoRN6bwwMezzREYvdjyIpLULDhlY0
         dNeHti7YYgD4p6bUh3Rhjo13gSCqZhk6qyXZ+Jho/Tm4RtSGWBm5AfPDALQfTcys4V8f
         9cWg==
X-Gm-Message-State: AOJu0Ywc2vDYSJ4hzf00T/o5KTN5ghtxgzmd1DJ4TTo7EwaJQRbuuj9C
        NzkmO2iCsCoWmof8ssx351M=
X-Google-Smtp-Source: AGHT+IFSOm++lO4qiGpS1SSP68TVsim82fK5+KFumC+bmZ0Wb1uqJABLU69ifDwKZ3w8Bhmne67umQ==
X-Received: by 2002:a17:903:228b:b0:1bf:5df2:8e97 with SMTP id b11-20020a170903228b00b001bf5df28e97mr198428plh.4.1695146162885;
        Tue, 19 Sep 2023 10:56:02 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b001bbbbda70ccsm10247033plh.158.2023.09.19.10.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:56:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Sep 2023 07:56:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHSET v4] sched: Implement BPF extensible scheduler class
Message-ID: <ZQngsfCdj0TJbEUL@slm.duckdns.org>
References: <20230711011412.100319-1-tj@kernel.org>
 <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
 <20230726091752.GA3802077@hirez.programming.kicks-ass.net>
 <ZMMH1WiYlipR0byf@slm.duckdns.org>
 <20230817124457.b5dca734zcixqctu@suse.de>
 <ZOfMNEoqt45Qmo00@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOfMNEoqt45Qmo00@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Mel.

I don't think the discussion has reached a point where the points of
disagreements are sufficiently laid out from both sides. Do you have any
further thoughts?

Thanks.

-- 
tejun
