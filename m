Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700077BFF53
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjJJO3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjJJO3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:29:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35628B8;
        Tue, 10 Oct 2023 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696948192; x=1728484192;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bwcccih+85LcRR3P8PEAEmLPsjPYsJI0cHUlrWYDZwc=;
  b=QG9x+DTEDIIIaLaXS9SQgElRqo0GLOZkySqaZEvkOh7xk3u4kFo5HGC/
   fSv4mUqMDixQy/Zug1YW0xWZGpm/4MQ4v3iM0rHBgQk83h91D88BhK93W
   TzAKFLUDk2G60LLi0M1fK33Fi95gHEx4+CjhHg3Yak8QSsUtt9cYKX6SK
   YKVKwApXQSfiWB05vzqOZGAY8X9S5J7zqjyUe2GaHJVy2VsKM5j1b5rfl
   dJv0AUaXFIoGs7Tb9XLltaQtUKmDbKy3FRZUbYoY4qt5EBX4t2Utq8+kQ
   cn4zfgvMbqPlWVVgso3GmLc4PsIjp1HryIjrxaQJ0snMFkLjEjCdLaFd5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387246731"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="387246731"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 07:29:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1000716138"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="1000716138"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.36.106])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 07:29:48 -0700
Message-ID: <d6fbab05-1279-46a7-98ef-32b11f578bba@intel.com>
Date:   Tue, 10 Oct 2023 17:29:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] perf tools: Add get_unaligned_leNN()
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20231005190451.175568-1-adrian.hunter@intel.com>
 <20231005190451.175568-2-adrian.hunter@intel.com>
 <ZR8QnasisGEsaaDR@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZR8QnasisGEsaaDR@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/23 22:38, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 05, 2023 at 10:04:47PM +0300, Adrian Hunter escreveu:
>> Add get_unaligned_le16(), get_unaligned_le32 and get_unaligned_le64, same
>> as include/asm-generic/unaligned.h.
>>
>> Use diagnostic pragmas to ignore -Wpacked used by perf build.
> 
> Can we get the tools copy of include/asm-generic/unaligned.h closer and
> have it in check-headers.sh?

I sent another patch for that
