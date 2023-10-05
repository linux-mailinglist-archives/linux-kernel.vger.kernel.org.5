Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5177BA9B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjJETGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjJETGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:06:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D0CCE;
        Thu,  5 Oct 2023 12:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696532783; x=1728068783;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8wmQQQEAyfIgaiwNoCxjih7ulwNQvERiiLm+ajXy3tk=;
  b=LxZlNzIOIz5e8Zw9iThWFVGAFdRkUOXYwTr+lc43d/6dz3HpLHM95fYJ
   NoJkw7oBmrqfWYwOo7wM24YYTtckStvkwzC8+ZUrfvzjz67izTSfat0cW
   +0t60rbuTkNhlbhsZBA3e87hIruFOldpgbwDP5AcYf4rQzKrVIC2xIbmU
   b0JaYRtbjxiM+GTefCRDReEgXqxjkfJHqRKuqMjtJub3sE9SNqpxDuLTM
   /WGJLFJiG9ooZtjqiTHG7IJAFqOCG0A9RnKbpunuvVy8ZIufV1EREdvph
   rf5YDJHyzAg9Spm2tEV2BekCg3APG+H9tBbCetksjIc5CRon3KQKUiFl8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="383488114"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="383488114"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:04:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="999054769"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="999054769"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.35.8])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:04:43 -0700
Message-ID: <93afcf44-5f8b-49c1-abc5-5304cba5f991@intel.com>
Date:   Thu, 5 Oct 2023 22:04:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf intel-pt: pkt-decoder: Fix alignment issues
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20231002221909.2958708-1-irogers@google.com>
 <CAP-5=fX-VOeCkOJY5xeW67x0+A0tGAHM4VYBBz46L-g2eRCR+w@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fX-VOeCkOJY5xeW67x0+A0tGAHM4VYBBz46L-g2eRCR+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/23 18:48, Ian Rogers wrote:
> On Mon, Oct 2, 2023 at 3:19 PM Ian Rogers <irogers@google.com> wrote:
>>
>> The byte aligned buffer is cast to large types and dereferenced
>> causing misaligned pointer warnings from undefined behavior sanitizer.
>> Fix the alignment issues with memcpy which may require the
>> introduction of temporaries.
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> ---
> 
> This is a relatively small change that fixes building with
> -fsanitize=alignment -fsanitize-undefined-trap-on-error. Adrian, as
> this is Intel-PT could you take a look?

Thanks! This has been down my list of things to do for ages,
but using get_unaligned_le16() etc seems nicer.  I sent a patch
set for that.

> 
> Thanks,
> Ian
> 
>>  .../intel-pt-decoder/intel-pt-pkt-decoder.c   | 21 ++++++++++++-------
>>  1 file changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
>> index af9710622a1f..28659874d84e 100644
>> --- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
>> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
>> @@ -83,7 +83,7 @@ static int intel_pt_get_long_tnt(const unsigned char *buf, size_t len,
>>         if (len < 8)
>>                 return INTEL_PT_NEED_MORE_BYTES;
>>
>> -       payload = le64_to_cpu(*(uint64_t *)buf);
>> +       memcpy_le64(&payload, buf, sizeof(payload));
>>
>>         for (count = 47; count; count--) {
>>                 if (payload & BIT63)
>> @@ -220,6 +220,8 @@ static int intel_pt_get_3byte(const unsigned char *buf, size_t len,
>>  static int intel_pt_get_ptwrite(const unsigned char *buf, size_t len,
>>                                 struct intel_pt_pkt *packet)
>>  {
>> +       uint32_t tmp;
>> +
>>         packet->count = (buf[1] >> 5) & 0x3;
>>         packet->type = buf[1] & BIT(7) ? INTEL_PT_PTWRITE_IP :
>>                                          INTEL_PT_PTWRITE;
>> @@ -228,12 +230,13 @@ static int intel_pt_get_ptwrite(const unsigned char *buf, size_t len,
>>         case 0:
>>                 if (len < 6)
>>                         return INTEL_PT_NEED_MORE_BYTES;
>> -               packet->payload = le32_to_cpu(*(uint32_t *)(buf + 2));
>> +               memcpy(&tmp, buf + 2, sizeof(tmp));
>> +               packet->payload = le32_to_cpu(tmp);
>>                 return 6;
>>         case 1:
>>                 if (len < 10)
>>                         return INTEL_PT_NEED_MORE_BYTES;
>> -               packet->payload = le64_to_cpu(*(uint64_t *)(buf + 2));
>> +               memcpy_le64(&packet->payload, buf + 2, sizeof(packet->payload));
>>                 return 10;
>>         default:
>>                 return INTEL_PT_BAD_PACKET;
>> @@ -258,7 +261,7 @@ static int intel_pt_get_mwait(const unsigned char *buf, size_t len,
>>         if (len < 10)
>>                 return INTEL_PT_NEED_MORE_BYTES;
>>         packet->type = INTEL_PT_MWAIT;
>> -       packet->payload = le64_to_cpu(*(uint64_t *)(buf + 2));
>> +       memcpy_le64(&packet->payload, buf + 2, sizeof(packet->payload));
>>         return 10;
>>  }
>>
>> @@ -454,6 +457,8 @@ static int intel_pt_get_ip(enum intel_pt_pkt_type type, unsigned int byte,
>>                            struct intel_pt_pkt *packet)
>>  {
>>         int ip_len;
>> +       uint16_t tmp16;
>> +       uint32_t tmp32;
>>
>>         packet->count = byte >> 5;
>>
>> @@ -465,13 +470,15 @@ static int intel_pt_get_ip(enum intel_pt_pkt_type type, unsigned int byte,
>>                 if (len < 3)
>>                         return INTEL_PT_NEED_MORE_BYTES;
>>                 ip_len = 2;
>> -               packet->payload = le16_to_cpu(*(uint16_t *)(buf + 1));
>> +               memcpy(&tmp16, buf + 1, sizeof(tmp16));
>> +               packet->payload = le16_to_cpu(tmp16);
>>                 break;
>>         case 2:
>>                 if (len < 5)
>>                         return INTEL_PT_NEED_MORE_BYTES;
>>                 ip_len = 4;
>> -               packet->payload = le32_to_cpu(*(uint32_t *)(buf + 1));
>> +               memcpy(&tmp32, buf + 1, sizeof(tmp32));
>> +               packet->payload = le32_to_cpu(tmp32);
>>                 break;
>>         case 3:
>>         case 4:
>> @@ -484,7 +491,7 @@ static int intel_pt_get_ip(enum intel_pt_pkt_type type, unsigned int byte,
>>                 if (len < 9)
>>                         return INTEL_PT_NEED_MORE_BYTES;
>>                 ip_len = 8;
>> -               packet->payload = le64_to_cpu(*(uint64_t *)(buf + 1));
>> +               memcpy_le64(&packet->payload, buf + 1, sizeof(packet->payload));
>>                 break;
>>         default:
>>                 return INTEL_PT_BAD_PACKET;
>> --
>> 2.42.0.582.g8ccd20d70d-goog
>>

