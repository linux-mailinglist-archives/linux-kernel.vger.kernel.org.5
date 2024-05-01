Return-Path: <linux-kernel+bounces-165030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EBE8B86D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0551C22A64
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED234F5FA;
	Wed,  1 May 2024 08:23:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9440FEED6;
	Wed,  1 May 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714551805; cv=none; b=G/+5HGpyc9Qmjp9YcR/84d77k+56iBn4SuBAd19jvWwa2M1Z/rde3Ab+ZcGMUb0BHXMq96/68Jmh3nfDat2VeNDjJ6IA6NfaD9RRShwSpyMSJugJDB5lzIrpv5hrWcNydf7kZMN6axBPiY5/0GTkLAZcLjReOwdRQybof4F+TBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714551805; c=relaxed/simple;
	bh=qaZBnxUZ5S0bVfgwUGcHBQ0gs7CzVQ16TCSiSrMnagE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTOz12hpqHuwucA+eJw1FTfpG1aRNpyiR7M29ih4IJqTkVFtzCYd8AFK4GE99MERXIn5YFYtHPk93qDZfLMGSQiqMoeMzB5wobrqq5mfgHtP6SijCoSnLtT8t82fvC4SPY076G7X+1/PnRs9Orlq5rw6eZzFtil5JSjnM+ANrvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 118A02F4;
	Wed,  1 May 2024 01:23:49 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96B0F3F793;
	Wed,  1 May 2024 01:23:20 -0700 (PDT)
Message-ID: <e5b5e30d-4e48-4f88-89a4-0b199c1db44b@arm.com>
Date: Wed, 1 May 2024 09:23:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf cs-etm: Improve version detection and error
 reporting
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240430133221.250811-1-james.clark@arm.com>
 <CAP-5=fX2NMSE1ThznMnNo0ne7FuaxMuDGEaCieWGxZotB8XODg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fX2NMSE1ThznMnNo0ne7FuaxMuDGEaCieWGxZotB8XODg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/04/2024 17:22, Ian Rogers wrote:
> On Tue, Apr 30, 2024 at 6:32 AM James Clark <james.clark@arm.com> wrote:
>>
>> When the config validation functions are warning about ETMv3, they do it
>> based on "not ETMv4". If the drivers aren't all loaded or the hardware
>> doesn't support Coresight it will appear as "not ETMv4" and then Perf
>> will print the error message "... not supported in ETMv3 ..." which is
>> wrong and confusing.
>>
>> cs_etm_is_etmv4() is also misnamed because it also returns true for
>> ETE because ETE has a superset of the ETMv4 metadata files. Although
>> this was always done in the correct order so it wasn't a bug.
>>
>> Improve all this by making a single get version function which also
>> handles not present as a separate case. Change the ETMv3 error message
>> to only print when ETMv3 is detected, and add a new error message for
>> the not present case.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/arch/arm/util/cs-etm.c | 64 +++++++++++++++++++++++--------
>>  1 file changed, 48 insertions(+), 16 deletions(-)
>>
>> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
>> index 07be32d99805..2763c6758b91 100644
>> --- a/tools/perf/arch/arm/util/cs-etm.c
>> +++ b/tools/perf/arch/arm/util/cs-etm.c
>> @@ -66,9 +66,25 @@ static const char * const metadata_ete_ro[] = {
>>         [CS_ETE_TS_SOURCE]              = "ts_source",
>>  };
>>
>> -static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
>> +enum cs_etm_version { CS_NOT_PRESENT, CS_ETMV3, CS_ETMV4, CS_ETE };
>> +
>> +static bool cs_etm_pmu_file_present(struct auxtrace_record *itr, int cpu,
>> +                                      const char *file);
>>  static bool cs_etm_is_ete(struct auxtrace_record *itr, int cpu);
>>
>> +static enum cs_etm_version cs_etm_get_version(struct auxtrace_record *itr,
>> +                                             int cpu)
> 
> nit: perhaps use "struct perf_cpu" rather than "int cpu" for a little
> bit of type safety. Fwiw, most of the tool uses an index into a CPU
> map but then have labelled that index "cpu" which is confusing
> particularly in the uncore case, whilst a perf_cpu is never an index.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 

Yeah I will make that change. There are quite a few early conversions
from the struct to the int that can be pushed all the way down to file open.

>> +{
>> +       if (cs_etm_is_ete(itr, cpu))
>> +               return CS_ETE;
>> +       else if (cs_etm_pmu_file_present(itr, cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0]))
>> +               return CS_ETMV4;
>> +       else if (cs_etm_pmu_file_present(itr, cpu, metadata_etmv3_ro[CS_ETM_ETMCCER]))
>> +               return CS_ETMV3;
>> +
>> +       return CS_NOT_PRESENT;
>> +}
>> +
>>  static int cs_etm_validate_context_id(struct auxtrace_record *itr,
>>                                       struct evsel *evsel, int cpu)
>>  {
>> @@ -87,7 +103,7 @@ static int cs_etm_validate_context_id(struct auxtrace_record *itr,
>>                 return 0;
>>
>>         /* Not supported in etmv3 */
>> -       if (!cs_etm_is_etmv4(itr, cpu)) {
>> +       if (cs_etm_get_version(itr, cpu) == CS_ETMV3) {
>>                 pr_err("%s: contextid not supported in ETMv3, disable with %s/contextid=0/\n",
>>                        CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
>>                 return -EINVAL;
>> @@ -154,7 +170,7 @@ static int cs_etm_validate_timestamp(struct auxtrace_record *itr,
>>               perf_pmu__format_bits(cs_etm_pmu, "timestamp")))
>>                 return 0;
>>
>> -       if (!cs_etm_is_etmv4(itr, cpu)) {
>> +       if (cs_etm_get_version(itr, cpu) == CS_ETMV3) {
>>                 pr_err("%s: timestamp not supported in ETMv3, disable with %s/timestamp=0/\n",
>>                        CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
>>                 return -EINVAL;
>> @@ -218,6 +234,11 @@ static int cs_etm_validate_config(struct auxtrace_record *itr,
>>         }
>>
>>         perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
>> +               if (cs_etm_get_version(itr, cpu.cpu) == CS_NOT_PRESENT) {
>> +                       pr_err("%s: Not found on CPU %d. Check hardware and firmware support and that all Coresight drivers are loaded\n",
>> +                              CORESIGHT_ETM_PMU_NAME, cpu.cpu);
>> +                       return -EINVAL;
>> +               }
>>                 err = cs_etm_validate_context_id(itr, evsel, cpu.cpu);
>>                 if (err)
>>                         break;
>> @@ -548,13 +569,13 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>>                 /* Event can be "any" CPU so count all online CPUs. */
>>                 intersect_cpus = perf_cpu_map__new_online_cpus();
>>         }
>> +       /* Count number of each type of ETM. Don't count if that CPU has CS_NOT_PRESENT. */
>>         perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
>> -               if (cs_etm_is_ete(itr, cpu.cpu))
>> -                       ete++;
>> -               else if (cs_etm_is_etmv4(itr, cpu.cpu))
>> -                       etmv4++;
>> -               else
>> -                       etmv3++;
>> +               enum cs_etm_version v = cs_etm_get_version(itr, cpu.cpu);
>> +
>> +               ete   += v == CS_ETE;
>> +               etmv4 += v == CS_ETMV4;
>> +               etmv3 += v == CS_ETMV3;
>>         }
>>         perf_cpu_map__put(intersect_cpus);
>>
>> @@ -564,7 +585,8 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>>                (etmv3 * CS_ETMV3_PRIV_SIZE));
>>  }
>>
>> -static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu)
>> +static bool cs_etm_pmu_file_present(struct auxtrace_record *itr, int cpu,
>> +                                      const char *file)
>>  {
>>         bool ret = false;
>>         char path[PATH_MAX];
>> @@ -574,9 +596,7 @@ static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu)
>>                         container_of(itr, struct cs_etm_recording, itr);
>>         struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
>>
>> -       /* Take any of the RO files for ETMv4 and see if it present */
>> -       snprintf(path, PATH_MAX, "cpu%d/%s",
>> -                cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
>> +       snprintf(path, PATH_MAX, "cpu%d/%s", cpu, file);
>>         scan = perf_pmu__scan_file(cs_etm_pmu, path, "%x", &val);
>>
>>         /* The file was read successfully, we have a winner */
>> @@ -735,21 +755,26 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
>>         struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
>>
>>         /* first see what kind of tracer this cpu is affined to */
>> -       if (cs_etm_is_ete(itr, cpu)) {
>> +       switch (cs_etm_get_version(itr, cpu)) {
>> +       case CS_ETE:
>>                 magic = __perf_cs_ete_magic;
>>                 cs_etm_save_ete_header(&info->priv[*offset], itr, cpu);
>>
>>                 /* How much space was used */
>>                 increment = CS_ETE_PRIV_MAX;
>>                 nr_trc_params = CS_ETE_PRIV_MAX - CS_ETM_COMMON_BLK_MAX_V1;
>> -       } else if (cs_etm_is_etmv4(itr, cpu)) {
>> +               break;
>> +
>> +       case CS_ETMV4:
>>                 magic = __perf_cs_etmv4_magic;
>>                 cs_etm_save_etmv4_header(&info->priv[*offset], itr, cpu);
>>
>>                 /* How much space was used */
>>                 increment = CS_ETMV4_PRIV_MAX;
>>                 nr_trc_params = CS_ETMV4_PRIV_MAX - CS_ETMV4_TRCCONFIGR;
>> -       } else {
>> +               break;
>> +
>> +       case CS_ETMV3:
>>                 magic = __perf_cs_etmv3_magic;
>>                 /* Get configuration register */
>>                 info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
>> @@ -767,6 +792,13 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
>>                 /* How much space was used */
>>                 increment = CS_ETM_PRIV_MAX;
>>                 nr_trc_params = CS_ETM_PRIV_MAX - CS_ETM_ETMCR;
>> +               break;
>> +
>> +       default:
>> +       case CS_NOT_PRESENT:
>> +               /* Unreachable, CPUs already validated in cs_etm_validate_config() */
>> +               assert(true);
>> +               return;
>>         }
>>
>>         /* Build generic header portion */
>> --
>> 2.34.1
>>

