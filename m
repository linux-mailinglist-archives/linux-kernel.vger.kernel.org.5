Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDA97C644C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 07:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347036AbjJLFDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 01:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjJLFC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 01:02:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E435B7;
        Wed, 11 Oct 2023 22:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697086978; x=1728622978;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jG1dT9othqCwkOqyzv/5X7Fn/ARu2sl5yrw33fqWd5c=;
  b=oAIe2G9Bsi0cy5uoNjVW6mlv9ZTt8l31xC9CxOmePfLIv+f4RWq6Eknf
   u915CPYr0VylM7MkrHo6KTCTtCBTE5hCpOTv4zMnJmQeY31+SSVfSPauG
   NEVJ8xOifPDHa4a5a9vtfVQmLscJIdVrx90i/13gevzLj8hwlZZAurnbx
   XzHHoPu0R//fNjwdWcdQWykrWdqC2Yp1b/+IxqWjbtgqk4jiQdqTYDvTn
   1YBt5H7aLLm53XyjkHVAxbrhWdS2hgyKWKzILAAr/EkA6BYprx9TuBjbM
   A0AGI2fMtoG/aN0SJV++kBNCiaQDaE3TqSMYffBajBrzfhjfFN5FbmE8x
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="451324387"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="451324387"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 22:02:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="824441572"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="824441572"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.41.84])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 22:02:48 -0700
Message-ID: <54481503-67c6-40ec-a02a-31f4db4205f7@intel.com>
Date:   Thu, 12 Oct 2023 08:02:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Put the function return operation at the end
 of the function
To:     "Kunwu.Chan" <chentao@kylinos.cn>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        seanjc@google.com, kprateek.nayak@amd.com, robert.richter@amd.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunwu.chan@hotmail.com
References: <20231012031003.842368-1-chentao@kylinos.cn>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231012031003.842368-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/23 06:10, Kunwu.Chan wrote:
> Function return operations should be performed after resource release.
> 
> Fixes: 4e1b9c679fcb ("perf tools: Refactor print_event_desc()")
> Signed-off-by: Kunwu.Chan <chentao@kylinos.cn>
> ---
>  tools/perf/util/header.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index d812e1e371a7..5763f21844b1 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1998,13 +1998,14 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
>  			id++;
>  		}
>  	}
> -out:
> -	free(buf);
> -	return events;
> +
>  error:
>  	free_event_desc(events);
>  	events = NULL;

Always freeing the events is wrong.  That path is only for errors.

That would show up if this had been tested.

> -	goto out;
> +
> +out:
> +	free(buf);
> +	return events;
>  }
>  
>  static int __desc_attr__fprintf(FILE *fp, const char *name, const char *val,

