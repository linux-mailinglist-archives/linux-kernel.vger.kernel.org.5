Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF447CF40D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbjJSJ27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjJSJ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:28:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6807BA3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JHd0ZN4OkAXDPqWpGVCUvAOm6bdfijxr28zsL2qtGDg=; b=GKzFE/7w1NtdhLKNKz6RBsX/oT
        ZupSTF0Vw7mu4VbrATzZOCktNkCHM1Wua5udNwwHcaknuEatj+UX3JNzhwIrMTS9IZ7Ck8Mgr/TyK
        awZ0HvwyfCfiYfxHheGyV0AzbMpjCBpy0+LYLbuM9iFUBeLDTuj8tpfIScSjMXA4//BksT5DgoSXS
        Ix8JLZdEFXgUPPG+jdxqvU0paMksy6TyUgRPawGQLHw9XWhtTuO4idJwSQAaEQQnWDe+lpijZwqPK
        FOXP8+c+kmeSf3jPf8APdJ4qEhsNRtZlzJ2yuJ1UuLhAyZWkZkPof12tt2CNY/WOfR1QoCYOIPo44
        YIp+V7Mw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qtPIi-009kg5-13;
        Thu, 19 Oct 2023 09:28:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03257300338; Thu, 19 Oct 2023 11:26:44 +0200 (CEST)
Date:   Thu, 19 Oct 2023 11:26:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
Subject: Re: [PATCH V4 4/7] perf/x86/intel: Support LBR event logging
Message-ID: <20231019092643.GF36211@noisy.programming.kicks-ass.net>
References: <20231004184044.3062788-1-kan.liang@linux.intel.com>
 <20231004184044.3062788-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004184044.3062788-4-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 11:40:41AM -0700, kan.liang@linux.intel.com wrote:

> +
>  static struct attribute *lbr_attrs[] = {
>  	&dev_attr_branches.attr,
> +	&dev_attr_branch_counter_nr.attr,
> +	&dev_attr_branch_counter_width.attr,
>  	NULL
>  };
>  
> @@ -5590,7 +5665,11 @@ mem_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>  static umode_t
>  lbr_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>  {
> -	return x86_pmu.lbr_nr ? attr->mode : 0;
> +	/* branches */
> +	if (i == 0)
> +		return x86_pmu.lbr_nr ? attr->mode : 0;
> +
> +	return (x86_pmu.flags & PMU_FL_LBR_EVENT) ? attr->mode : 0;
>  }

As in the patch this is fairly readable, but I just checked and in the
code lbr_attrs and lbr_is_visible() are rather far away from one another
which makes the whole i thing hard to interpret.

Should we re-organize that a little?
