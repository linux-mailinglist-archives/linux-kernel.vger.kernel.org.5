Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F887EB6BD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjKNTHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKNTHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:07:37 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DE0FC;
        Tue, 14 Nov 2023 11:07:34 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2809a824bbbso4748127a91.3;
        Tue, 14 Nov 2023 11:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699988854; x=1700593654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTdxwqjsCHAfUHLS9E9O/GYEc/cGPlpr/fwvTx4EeE4=;
        b=BLYptecSPpNTtRzRt2nmFIAUgy0Wa4Di/cPdfXapr9X3A0tRMUHqYvtZR4XXNXPOHX
         Gy4099Z/YHg/P0p/ic+tuAui0IqCAXEJ/roPhchglylKrl9//Ad6B1hOTW8Cwe0n4geN
         igKYF7uGdXNOZ8xSEo2ysZinlflfVnbl18khnPmJ1g/VCqJ3iIh2drOQ6I78GOmJJ+zH
         7P26gXyQqeI7RsEbL0PCqhe7h6+AUzXa70OXliCC+fBqa4NsR7wRuRpyTiXSDtcH/jTd
         4ziwT5NR+I6gtYBKhAoDetewnuxHJ2j8+b90fcYBQr+sBpRX668AvT0QoMqNzr7aMRQJ
         3VFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699988854; x=1700593654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTdxwqjsCHAfUHLS9E9O/GYEc/cGPlpr/fwvTx4EeE4=;
        b=tR1RSa6Z+F6W3BSDadGSwjDBHt+kJci8p/CjPf+mhizv1ncy9iZnUiZOftYJ+TQtwO
         qrW4l94Cy8CyxLwOXNP9ZUPBleDGdCvNmVx9FnBvJNvt3B0UEu2/yAW2GF6eYU/Eyea6
         7gzsdgEBrRCF5UIb6dqJhswoQD6OT0iH6T1QOZGWjc1KaSlyto50kxq6l3M/AYA2eohp
         FHzy1ASXuKXWVsGWDDIGygQTpEh34t4OOnlrvUaw/wYZIX2XcPdnTd1wg2LhUT0tVuQ7
         II4XuMbdsFWeLcxndmt/wI8fsEbWPB1BruIU4jsbBRMX1ZMFxuowPQLXsXezcpR23Ur+
         UDxQ==
X-Gm-Message-State: AOJu0Yz25+QsqAGq0H+e40oG1AUL9ftRIxXLG1+4lCQIQEFYwgqj0XdI
        ydtYECDSQ+Bi7uexRapMZno=
X-Google-Smtp-Source: AGHT+IFaLpasVhp8zQGEXaSudejE6IuzaZWdVvddFYiCVKRvwmxTXkuG+a1PWyBjlc0LXrcPrSXP9Q==
X-Received: by 2002:a17:90b:1e03:b0:27d:8d42:6def with SMTP id pg3-20020a17090b1e0300b0027d8d426defmr8808064pjb.34.1699988853635;
        Tue, 14 Nov 2023 11:07:33 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090ad30c00b002790ded9c6dsm5568472pju.31.2023.11.14.11.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 11:07:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 14 Nov 2023 09:07:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH 12/36] sched_ext: Implement BPF extensible scheduler class
Message-ID: <ZVPFdKqUxmtW1jaJ@slm.duckdns.org>
References: <20231111024835.2164816-1-tj@kernel.org>
 <20231111024835.2164816-13-tj@kernel.org>
 <ZVKBSIPqJnAvrE3g@gpd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVKBSIPqJnAvrE3g@gpd>
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

On Mon, Nov 13, 2023 at 03:04:24PM -0500, Andrea Righi wrote:
> > +#ifdef CONFIG_SCHED_DEBUG
> > +static const char *scx_ops_enable_state_str[] = {
> > +	[SCX_OPS_PREPPING]	= "prepping",
> > +	[SCX_OPS_ENABLING]	= "enabling",
> > +	[SCX_OPS_ENABLED]	= "enabled",
> > +	[SCX_OPS_DISABLING]	= "disabling",
> > +	[SCX_OPS_DISABLED]	= "disabled",
> > +};
> 
> We may want to move scx_ops_enable_state_str[] outside of
> CONFIG_SCHED_DEBUG, because we're using it later in print_scx_info()
> ("sched_ext: Print sched_ext info when dumping stack"), or we make
> print_scx_info() dependent of CONFIG_SCHED_DEBUG.

Yeah, Changwoo noticed the same problem. Will fix and post an updated patch.

Thanks.

-- 
tejun
