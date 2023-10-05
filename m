Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE97BA0CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbjJEOld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbjJEOhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:37:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4968983F6;
        Thu,  5 Oct 2023 07:03:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFC57150C;
        Thu,  5 Oct 2023 02:15:49 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A82223F5A1;
        Thu,  5 Oct 2023 02:15:09 -0700 (PDT)
Message-ID: <762f44d3-5dff-21c1-720c-3b5d43eb1fd4@arm.com>
Date:   Thu, 5 Oct 2023 10:15:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] perf cs-etm: Fix incorrect or missing decoder for raw
 trace
Content-Language: en-US
To:     Besar Wicaksono <bwicaksono@nvidia.com>, mike.leach@linaro.org,
        suzuki.poulose@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-tegra@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        rwiley@nvidia.com, ywan@nvidia.com,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <20231004003212.31554-1-bwicaksono@nvidia.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231004003212.31554-1-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/10/2023 01:32, Besar Wicaksono wrote:
> The decoder creation for raw trace uses metadata from the first CPU.
> On per-cpu mode, this metadata is incorrectly used for every decoder.
> On per-process/per-thread traces, the first CPU is CPU0. If CPU0 trace
> is not enabled, its metadata will be marked unused and the decoder is
> not created. Perf report dump skips the decoding part because the
> decoder is missing.
> 
> To fix this, use metadata of the CPU associated with sample object.
> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
> 
> Changes from v1:
>  * Update commit message
>  * Add fallback to CPU-0 metadata if sample CPU id is not available
>  * Preserve cs_etm__set_trace_param_* arguments and just breakdown the index
>    parameter into trace-param and metadata indexes
> Thanks to Mike and James for the feedback.
> v1: https://lore.kernel.org/lkml/20230919224553.1658-1-bwicaksono@nvidia.com/T/#u
> 
> ---
>  tools/perf/util/cs-etm.c | 106 ++++++++++++++++++++++++---------------
>  1 file changed, 65 insertions(+), 41 deletions(-)
> 

There is a trivial conflict on the perf-tools-next repo that it's
probably worth rebasing for, otherwise:

Reviewed-by: James Clark <james.clark@arm.com>

Also should probably include linux-perf-users@vger.kernel.org as tools
changes actually go through the perf tree rather than the coresight one.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 1419b40dfbe8..3abe68a9981e 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -293,22 +293,31 @@ static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
>  	})
>  
>  /*
> - * Get a metadata for a specific cpu from an array.
> + * Get a metadata index for a specific cpu from an array.
>   *
>   */
> -static u64 *get_cpu_data(struct cs_etm_auxtrace *etm, int cpu)
> +static int get_cpu_data_idx(struct cs_etm_auxtrace *etm, int cpu)
>  {
>  	int i;
> -	u64 *metadata = NULL;
>  
>  	for (i = 0; i < etm->num_cpu; i++) {
>  		if (etm->metadata[i][CS_ETM_CPU] == (u64)cpu) {
> -			metadata = etm->metadata[i];
> -			break;
> +			return i;
>  		}
>  	}
>  
> -	return metadata;
> +	return -1;
> +}
> +
> +/*
> + * Get a metadata for a specific cpu from an array.
> + *
> + */
> +static u64 *get_cpu_data(struct cs_etm_auxtrace *etm, int cpu)
> +{
> +	int idx = get_cpu_data_idx(etm, cpu);
> +
> +	return (idx != -1) ? etm->metadata[idx] : NULL;
>  }
>  
>  /*
> @@ -651,66 +660,80 @@ static void cs_etm__packet_dump(const char *pkt_string)
>  }
>  
>  static void cs_etm__set_trace_param_etmv3(struct cs_etm_trace_params *t_params,
> -					  struct cs_etm_auxtrace *etm, int idx,
> -					  u32 etmidr)
> +					  struct cs_etm_auxtrace *etm, int t_idx,
> +					  int m_idx, u32 etmidr)
>  {
>  	u64 **metadata = etm->metadata;
>  
> -	t_params[idx].protocol = cs_etm__get_v7_protocol_version(etmidr);
> -	t_params[idx].etmv3.reg_ctrl = metadata[idx][CS_ETM_ETMCR];
> -	t_params[idx].etmv3.reg_trc_id = metadata[idx][CS_ETM_ETMTRACEIDR];
> +	t_params[t_idx].protocol = cs_etm__get_v7_protocol_version(etmidr);
> +	t_params[t_idx].etmv3.reg_ctrl = metadata[m_idx][CS_ETM_ETMCR];
> +	t_params[t_idx].etmv3.reg_trc_id = metadata[m_idx][CS_ETM_ETMTRACEIDR];
>  }
>  
>  static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
> -					  struct cs_etm_auxtrace *etm, int idx)
> +					  struct cs_etm_auxtrace *etm, int t_idx,
> +					  int m_idx)
>  {
>  	u64 **metadata = etm->metadata;
>  
> -	t_params[idx].protocol = CS_ETM_PROTO_ETMV4i;
> -	t_params[idx].etmv4.reg_idr0 = metadata[idx][CS_ETMV4_TRCIDR0];
> -	t_params[idx].etmv4.reg_idr1 = metadata[idx][CS_ETMV4_TRCIDR1];
> -	t_params[idx].etmv4.reg_idr2 = metadata[idx][CS_ETMV4_TRCIDR2];
> -	t_params[idx].etmv4.reg_idr8 = metadata[idx][CS_ETMV4_TRCIDR8];
> -	t_params[idx].etmv4.reg_configr = metadata[idx][CS_ETMV4_TRCCONFIGR];
> -	t_params[idx].etmv4.reg_traceidr = metadata[idx][CS_ETMV4_TRCTRACEIDR];
> +	t_params[t_idx].protocol = CS_ETM_PROTO_ETMV4i;
> +	t_params[t_idx].etmv4.reg_idr0 = metadata[m_idx][CS_ETMV4_TRCIDR0];
> +	t_params[t_idx].etmv4.reg_idr1 = metadata[m_idx][CS_ETMV4_TRCIDR1];
> +	t_params[t_idx].etmv4.reg_idr2 = metadata[m_idx][CS_ETMV4_TRCIDR2];
> +	t_params[t_idx].etmv4.reg_idr8 = metadata[m_idx][CS_ETMV4_TRCIDR8];
> +	t_params[t_idx].etmv4.reg_configr = metadata[m_idx][CS_ETMV4_TRCCONFIGR];
> +	t_params[t_idx].etmv4.reg_traceidr = metadata[m_idx][CS_ETMV4_TRCTRACEIDR];
>  }
>  
>  static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_params,
> -					  struct cs_etm_auxtrace *etm, int idx)
> +					  struct cs_etm_auxtrace *etm, int t_idx,
> +					  int m_idx)
>  {
>  	u64 **metadata = etm->metadata;
>  
> -	t_params[idx].protocol = CS_ETM_PROTO_ETE;
> -	t_params[idx].ete.reg_idr0 = metadata[idx][CS_ETE_TRCIDR0];
> -	t_params[idx].ete.reg_idr1 = metadata[idx][CS_ETE_TRCIDR1];
> -	t_params[idx].ete.reg_idr2 = metadata[idx][CS_ETE_TRCIDR2];
> -	t_params[idx].ete.reg_idr8 = metadata[idx][CS_ETE_TRCIDR8];
> -	t_params[idx].ete.reg_configr = metadata[idx][CS_ETE_TRCCONFIGR];
> -	t_params[idx].ete.reg_traceidr = metadata[idx][CS_ETE_TRCTRACEIDR];
> -	t_params[idx].ete.reg_devarch = metadata[idx][CS_ETE_TRCDEVARCH];
> +	t_params[t_idx].protocol = CS_ETM_PROTO_ETE;
> +	t_params[t_idx].ete.reg_idr0 = metadata[m_idx][CS_ETE_TRCIDR0];
> +	t_params[t_idx].ete.reg_idr1 = metadata[m_idx][CS_ETE_TRCIDR1];
> +	t_params[t_idx].ete.reg_idr2 = metadata[m_idx][CS_ETE_TRCIDR2];
> +	t_params[t_idx].ete.reg_idr8 = metadata[m_idx][CS_ETE_TRCIDR8];
> +	t_params[t_idx].ete.reg_configr = metadata[m_idx][CS_ETE_TRCCONFIGR];
> +	t_params[t_idx].ete.reg_traceidr = metadata[m_idx][CS_ETE_TRCTRACEIDR];
> +	t_params[t_idx].ete.reg_devarch = metadata[m_idx][CS_ETE_TRCDEVARCH];
>  }
>  
>  static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
>  				     struct cs_etm_auxtrace *etm,
> +				     bool formatted,
> +				     int sample_cpu,
>  				     int decoders)
>  {
> -	int i;
> +	int t_idx, m_idx;
>  	u32 etmidr;
>  	u64 architecture;
>  
> -	for (i = 0; i < decoders; i++) {
> -		architecture = etm->metadata[i][CS_ETM_MAGIC];
> +	for (t_idx = 0; t_idx < decoders; t_idx++) {
> +		if (formatted)
> +			m_idx = t_idx;
> +		else {
> +			m_idx = get_cpu_data_idx(etm, sample_cpu);
> +			if (m_idx == -1) {
> +				pr_warning("CS_ETM: unknown CPU, falling back to first metadata\n");
> +				m_idx = 0;
> +			}
> +		}
> +
> +		architecture = etm->metadata[m_idx][CS_ETM_MAGIC];
>  
>  		switch (architecture) {
>  		case __perf_cs_etmv3_magic:
> -			etmidr = etm->metadata[i][CS_ETM_ETMIDR];
> -			cs_etm__set_trace_param_etmv3(t_params, etm, i, etmidr);
> +			etmidr = etm->metadata[m_idx][CS_ETM_ETMIDR];
> +			cs_etm__set_trace_param_etmv3(t_params, etm, t_idx, m_idx, etmidr);
>  			break;
>  		case __perf_cs_etmv4_magic:
> -			cs_etm__set_trace_param_etmv4(t_params, etm, i);
> +			cs_etm__set_trace_param_etmv4(t_params, etm, t_idx, m_idx);
>  			break;
>  		case __perf_cs_ete_magic:
> -			cs_etm__set_trace_param_ete(t_params, etm, i);
> +			cs_etm__set_trace_param_ete(t_params, etm, t_idx, m_idx);
>  			break;
>  		default:
>  			return -EINVAL;
> @@ -1026,7 +1049,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
>  }
>  
>  static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
> -						bool formatted)
> +						bool formatted, int sample_cpu)
>  {
>  	struct cs_etm_decoder_params d_params;
>  	struct cs_etm_trace_params  *t_params = NULL;
> @@ -1051,7 +1074,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
>  	if (!t_params)
>  		goto out_free;
>  
> -	if (cs_etm__init_trace_params(t_params, etm, decoders))
> +	if (cs_etm__init_trace_params(t_params, etm, formatted, sample_cpu, decoders))
>  		goto out_free;
>  
>  	/* Set decoder parameters to decode trace packets */
> @@ -1091,14 +1114,15 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
>  static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>  			       struct auxtrace_queue *queue,
>  			       unsigned int queue_nr,
> -			       bool formatted)
> +			       bool formatted,
> +			       int sample_cpu)
>  {
>  	struct cs_etm_queue *etmq = queue->priv;
>  
>  	if (list_empty(&queue->head) || etmq)
>  		return 0;
>  
> -	etmq = cs_etm__alloc_queue(etm, formatted);
> +	etmq = cs_etm__alloc_queue(etm, formatted, sample_cpu);
>  
>  	if (!etmq)
>  		return -ENOMEM;
> @@ -2826,7 +2850,7 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
>  		 * formatted in piped mode (true).
>  		 */
>  		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
> -					  idx, true);
> +					  idx, true, -1);
>  		if (err)
>  			return err;
>  
> @@ -3032,7 +3056,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>  		idx = auxtrace_event->idx;
>  		formatted = !(aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
>  		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
> -					   idx, formatted);
> +					   idx, formatted, sample->cpu);
>  	}
>  
>  	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
