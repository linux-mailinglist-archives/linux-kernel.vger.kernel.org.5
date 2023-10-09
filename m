Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CD97BE39D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjJIOyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376348AbjJIOyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:54:01 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C639E;
        Mon,  9 Oct 2023 07:53:59 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S426Q5Zzhz1M8sM;
        Mon,  9 Oct 2023 22:51:26 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 9 Oct 2023 22:53:57 +0800
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf hisi-ptt: Fix memory leak in lseek failure handling
To:     Kuan-Wei Chiu <visitorckw@gmail.com>, <yangyicong@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <namhyung@kernel.org>
References: <20230930072719.1267784-1-visitorckw@gmail.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <7e27ac27-c53e-0039-d195-5cd787d9df43@huawei.com>
Date:   Mon, 9 Oct 2023 22:53:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230930072719.1267784-1-visitorckw@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/30 15:27, Kuan-Wei Chiu wrote:
> In the previous code, there was a memory leak issue where the previously
> allocated memory was not freed upon a failed lseek operation. This patch
> addresses the problem by releasing the old memory before returning -errno
> in case of a lseek failure. This ensures that memory is properly managed
> and avoids potential memory leaks.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  tools/perf/util/hisi-ptt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
> index 45b614bb73bf..43bd1ca62d58 100644
> --- a/tools/perf/util/hisi-ptt.c
> +++ b/tools/perf/util/hisi-ptt.c
> @@ -108,8 +108,10 @@ static int hisi_ptt_process_auxtrace_event(struct perf_session *session,
>  		data_offset = 0;
>  	} else {
>  		data_offset = lseek(fd, 0, SEEK_CUR);
> -		if (data_offset == -1)
> +		if (data_offset == -1) {
> +			free(data);
>  			return -errno;
> +		}

Sorry for the late reply, this looks correct to me:

Acked-by: Yicong Yang <yangyicong@hisilicon.com>

This patch makes me think whether data_offset is necessary for PTT.
The PTT only supports dump raw trace data and since this is an
uncore PMU we only have one single data source so we are not using
the auxtrace_queues for sorting or ordering the buffers. It seems
there's no need to record the data_offset for later mmap(),
just read trace data out and dump them is enough. I'll further check
and have some tests on this.

I see Namhyung has already taken this. Thanks for the fix.

>  	}
>  
>  	err = readn(fd, data, size);
> 
