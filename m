Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10BC80B2A6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 08:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbjLIGxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 01:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjLIGxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 01:53:39 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6676710C9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 22:53:45 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c19467a63so31346145e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 22:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702104824; x=1702709624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27fCHLUa4kUDvPQVbE+1w2YS5g7FkXV060e7T4s0mZE=;
        b=IcCEiMQH2n3L75SQrVA7vpTcARnEyYGXR6LjBV9TxesIPDKDQS3PJnRtQTZTELwe7U
         Z7gAgCEyjbOT+KJeEYc1GQDT2uOq1sl4psQBD1JYndyGMxAaExUleUVHs3ALWE5OjApm
         JGbc4jI94ihREqYx0UdQ1bylRJFNe+0zJ4mPsl76ZVMOQNUSzbEQo2I01lYZ6oNCkkSO
         Ai2+Ah2PXbMzkxcs0QswWjnTlOahIEaP/dKWHWzQUZrxZrIbv8CpA3o4Nm+MIdoi0NIa
         JD99Ndr4hkZt0alPMZTr2xAcI3uOYCjJqiscejq5WQvYGTDkrfIovDB9BRHNMBj6PbjK
         Dzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702104824; x=1702709624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27fCHLUa4kUDvPQVbE+1w2YS5g7FkXV060e7T4s0mZE=;
        b=hZMJhsCRk0dwBk8aPa1XPpPksdSBFwhdOp+p+8Fcen7V8mj9gIWEpJuxiHrxEHixXe
         ptZbHzQcmerMjf7uiwzX4qrWU5kSB7npRJB/8Tnwh9U6JKoO7x+Z8v2S4TwpMz+jowC/
         dHZAakTBHimMsrLQ/U4twFozg9CQZPLFVkKI3WG3DZemAnZPNIrpeFW2gXEOpo63RAlG
         7EBoQ8ziCWfDis9SI8v2NweZNjgwCiKVeJ9XMZEIt/Z84lXixRKLAev66rtjL9cwrj9a
         9NApE363/DH23gcpsePLpMuCKQsiIhkBoaqYV4MPRjxzCUwuj+jZ+A9SJI3fCsdTXpA1
         k2QA==
X-Gm-Message-State: AOJu0Ywbestf+sEsM0R+yTGlbLQ6BR3GIKUYkFeD+yO7rt3O0sQdWtD3
        XeBu5LBppDXBpI6by7m0saaeOQ==
X-Google-Smtp-Source: AGHT+IEIQ1SNS311RaYj5If/4xi5+/rSPck3nXd3hzicSBW8VuZz6UwTsNjF2kXqF810V0JsNEX7dQ==
X-Received: by 2002:a7b:c7d5:0:b0:40c:2bab:3d27 with SMTP id z21-20020a7bc7d5000000b0040c2bab3d27mr481651wmk.8.1702104823906;
        Fri, 08 Dec 2023 22:53:43 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b0040b2c195523sm7393926wmo.31.2023.12.08.22.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 22:53:43 -0800 (PST)
Date:   Sat, 9 Dec 2023 09:53:40 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: Re: arch/arc/kernel/setup.c:203 arcv2_mumbojumbo() error:
 uninitialized symbol 'release'.
Message-ID: <2fe769ff-a6f9-468e-9449-28731f8f966d@suswa.mountain>
References: <c2148229-bea9-40ef-bbf3-6019555f3f1a@suswa.mountain>
 <b78607e5-6965-4e7f-b43a-c1ca58eecf89@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b78607e5-6965-4e7f-b43a-c1ca58eecf89@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 04:33:44PM -0800, Vineet Gupta wrote:
> On 11/27/23 22:22, Dan Carpenter wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
> > commit: fad84e39f116035ae8d550c6020107b8ac113b45 ARC: boot log: eliminate struct cpuinfo_arc #4: boot log per ISA
> > config: arc-randconfig-r071-20231128 (https://download.01.org/0day-ci/archive/20231128/202311280906.VAIwEAfT-lkp@intel.com/config)
> > compiler: arceb-elf-gcc (GCC) 13.2.0
> > reproduce: (https://download.01.org/0day-ci/archive/20231128/202311280906.VAIwEAfT-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <error27@gmail.com>
> > | Closes: https://lore.kernel.org/r/202311280906.VAIwEAfT-lkp@intel.com/
> >
> > New smatch warnings:
> > arch/arc/kernel/setup.c:203 arcv2_mumbojumbo() error: uninitialized symbol 'release'.
> 
> Thx, I've posted a fix.
> 
> > Old smatch warnings:
> > arch/arc/include/asm/thread_info.h:62 current_thread_info() error: uninitialized symbol 'sp'.
> 
> This seems like a false warning. Its a register variable and thus can't
> possibly be initialized.

Yeah.  Sorry, I normally delete these but I somehow forgot this time.

regards,
dan carpenter

