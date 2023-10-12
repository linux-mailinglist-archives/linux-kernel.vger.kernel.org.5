Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1138B7C6E18
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378723AbjJLM14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347226AbjJLM1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:27:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E5DBE;
        Thu, 12 Oct 2023 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697113671; x=1728649671;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AZ7oKYWOBQVcSulh2u8ttvivltav8khjEB1RfHASx+M=;
  b=AkeSvH2cGnmCqzKrHVQX+SbThceaxvzIa4dh/fSWzA0g1OoOFXpc2MVa
   NWz1ULRcPgNzXGiSGrHmTKf9a/v+C29b8izmfG8nHldYXjzxVGAkbj5Q8
   abg0uT3Bw10mSezkpnGvftNbaVfiEA9uT+5v7S2/LwJe5NGVVD9l65ErO
   SdsE+lJ06tqc+qXiOpUlCmgFVlDnDkU+NAb8ptBMvvBXMwVUw9ps5ItbD
   lJRjG6rDf6i/NKOOE9ETpja6id01qTiR81iFR26gP272xIHzJSpPPlWE0
   TDm8VHT8JugxymlQFOInlMMERdY6rJK9qoVVkTzsPFpM3ifLZyU4fda86
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="471165615"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="471165615"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="789377300"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="789377300"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.41.84])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:27:47 -0700
Message-ID: <6452eca3-e8de-40b5-8e04-2e37892880f7@intel.com>
Date:   Thu, 12 Oct 2023 15:27:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf intel-pt: pkt-decoder: Fix alignment issues
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20231002221909.2958708-1-irogers@google.com>
 <CAP-5=fX-VOeCkOJY5xeW67x0+A0tGAHM4VYBBz46L-g2eRCR+w@mail.gmail.com>
 <93afcf44-5f8b-49c1-abc5-5304cba5f991@intel.com>
 <CAP-5=fXzcR6QKKhFG5PS1pFYi5JsO4AOUoH_-Bv0O+11YzEkkw@mail.gmail.com>
 <CAM9d7cjQZvZm+Vyrx9PTUYMFN5RjE+i-Kq1kbffyVp2hGKF6sg@mail.gmail.com>
 <CAP-5=fUo-vuLofC4jgHC9z=BTe80OEiY_PoQWqQtyVdvHcf+KQ@mail.gmail.com>
 <CAM9d7cjdb5WE-xdSdKD=p_EtsS7OSVEWL+GL3RVwczu-+1JvFQ@mail.gmail.com>
 <CAP-5=fVe9v=KOxJE5TfmivBQCD=7SRFpnqkob7e05U76d_bSPQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fVe9v=KOxJE5TfmivBQCD=7SRFpnqkob7e05U76d_bSPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 09:50, Ian Rogers wrote:
> On Tue, Oct 10, 2023 at 10:56 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> On Mon, Oct 9, 2023 at 8:31 AM Ian Rogers <irogers@google.com> wrote:
>>>
>>> On Sun, Oct 8, 2023 at 10:29 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>>
>>>> On Thu, Oct 5, 2023 at 2:24 PM Ian Rogers <irogers@google.com> wrote:
>>>>>
>>>>> On Thu, Oct 5, 2023 at 12:06 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>
>>>>>> On 5/10/23 18:48, Ian Rogers wrote:
>>>>>>> On Mon, Oct 2, 2023 at 3:19 PM Ian Rogers <irogers@google.com> wrote:
>>>>>>>>
>>>>>>>> The byte aligned buffer is cast to large types and dereferenced
>>>>>>>> causing misaligned pointer warnings from undefined behavior sanitizer.
>>>>>>>> Fix the alignment issues with memcpy which may require the
>>>>>>>> introduction of temporaries.
>>>>>>>>
>>>>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>>>>>> ---
>>>>>>>
>>>>>>> This is a relatively small change that fixes building with
>>>>>>> -fsanitize=alignment -fsanitize-undefined-trap-on-error. Adrian, as
>>>>>>> this is Intel-PT could you take a look?
>>>>>>
>>>>>> Thanks! This has been down my list of things to do for ages,
>>>>>> but using get_unaligned_le16() etc seems nicer.  I sent a patch
>>>>>> set for that.
>>>>>
>>>>> Thanks Adrian! Your patch set looks good and I think after Arnaldo's
>>>>> comment is addressed we should go with it.
>>>>
>>>> I think it can be done as a later step as long as the interface is the
>>>> same.  Can I add your Ack's to the Adrian's patchset?
>>>
>>> I think addressing Arnaldo's comment:
>>> https://lore.kernel.org/lkml/ZR8QnasisGEsaaDR@kernel.org/
>>> will need some changes to the patch series, and so I was waiting to
>>> see the outcome of that.
>>
>> It seems it's done without further changes.  Can I get your Ack's now?
> 
> With the unaligned.h patch on its own, I think patch 1 of 5 needs
> dropping. For the rest I'm happy to acked-by.

The new patch is on top of the others, so patch 1 is still needed.

