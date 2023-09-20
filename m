Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8117A7639
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjITIqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjITIqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:46:16 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B518F94
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:46:07 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-578a62c088cso464486a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695199567; x=1695804367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pjMQLR6QiM78KOUDfp1B/C1Xl2bHb05tfsCLMS40xS0=;
        b=S4MWn4czFsB9bcZGNA0UutKy6t1jFTvSU2+8LFBik9BaMQGM9eZMo31onMXqAvcY5w
         ZL2F3jKZV5Ni364fJq/EU7FdX+Ped7joV7H2t9K9bdZT0Q+FFMhGVQMFR4/xjWwkCXf4
         cPrgPwn4AB0BrymtMkNyHk6FWO6ejG5mYSPbtTizDSxwTE+SF5sPvCMqWMEKL74eQVVr
         uQaqnGI992OdT0GeDNFg/WTp/dCXcqI/JakbQnZEHJm+OkAfDwGP4VmFpIecUrhNgDHL
         T/Z27hbSOchzethnOhMno6M1tq2yixZs6YPWZt6mGjrkNoi9U5Il9zzQMf78cl5PVaEL
         IDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695199567; x=1695804367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjMQLR6QiM78KOUDfp1B/C1Xl2bHb05tfsCLMS40xS0=;
        b=HlrkcOrwBraQiEMTZ8rDOlwYqsb5GkyD3qcOyYYnup+SItu41BAhnsLns8RXmKLFzF
         3jEnmKH7Em8MIVKUgT+6zFt6yW7qRQ2hBEPN8+UKMiNHhYr+gEoKlrrpd0QNgh2PwTsg
         NH7NFrYhI9pgYACQWbpbx4NSyjD1Nr6wpzIPOu3h8U6jSLlYPApQTCxR5c2f2TD/XjkT
         nsHAVwD2YXd82Ce989IL8jQXnflNGpcGt7vFU7zGmNAknIw8L0KRMGiSyQKgDGMsfeXC
         6fkZ82BMKcxom7NLg++AXb/ofy+Su2SFF0hPyyUDvJ61VPxJQ9MiFa6Pr/nUxaE7qKDg
         FeNw==
X-Gm-Message-State: AOJu0YxhHiLTiagD3+crR1+O4YEYezIXo0XBzMKbdwi/5MsDHPVWwVHV
        pfVVZ7pM9+DZMw/GzwfDP1X+cZDhaeTckx0azQuW7Q==
X-Google-Smtp-Source: AGHT+IEiudHtkKTfWb7gVr+IeWT9rQzLQs2XBXUILRzviMuJRtpdtWqTCTZXuG4hhcoq9uLQZCX1tsyAkBiMp8TEI/o=
X-Received: by 2002:a17:90b:1051:b0:274:77b3:64d0 with SMTP id
 gq17-20020a17090b105100b0027477b364d0mr6332650pjb.17.1695199567121; Wed, 20
 Sep 2023 01:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230919224553.1658-1-bwicaksono@nvidia.com>
In-Reply-To: <20230919224553.1658-1-bwicaksono@nvidia.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 20 Sep 2023 09:45:54 +0100
Message-ID: <CAJ9a7VgENH-_RrYhjctbbAT_ZWb5cuWwUUqtmEveN6z3ohidCA@mail.gmail.com>
Subject: Re: [PATCH] perf cs-etm: Fix missing decoder for per-process trace
To:     Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     james.clark@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-tegra@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        rwiley@nvidia.com, ywan@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can you provide a perf command line for both the record and decode
phases that demonstrates the problem you are having?

Also note the cpu / trace protocol types

On Tue, 19 Sept 2023 at 23:47, Besar Wicaksono <bwicaksono@nvidia.com> wrote:
>
> The decoder creation for raw trace uses metadata from the first CPU.
> On per-process/per-thread traces, the first CPU is CPU0. If CPU0 trace
> is not enabled, its metadata will be marked unused and the decoder is
> not created. Perf report dump skips the decoding part because the
> decoder is missing.
>
> To fix this, use metadata of the CPU associated with sample object.
>
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
>  tools/perf/util/cs-etm.c | 130 +++++++++++++++++++++++----------------
>  1 file changed, 77 insertions(+), 53 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 9729d006550d..3c3179a5eac6 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -640,71 +640,94 @@ static void cs_etm__packet_dump(const char *pkt_string)
>         fflush(stdout);
>  }
>
> -static void cs_etm__set_trace_param_etmv3(struct cs_etm_trace_params *t_params,
> -                                         struct cs_etm_auxtrace *etm, int idx,
> -                                         u32 etmidr)
> +static void cs_etm__set_trace_param_etmv3(struct cs_etm_trace_params *t_param,
> +                                         u64 *metadata, u32 etmidr)
>  {
> -       u64 **metadata = etm->metadata;
> -
> -       t_params[idx].protocol = cs_etm__get_v7_protocol_version(etmidr);
> -       t_params[idx].etmv3.reg_ctrl = metadata[idx][CS_ETM_ETMCR];
> -       t_params[idx].etmv3.reg_trc_id = metadata[idx][CS_ETM_ETMTRACEIDR];
> +       t_param->protocol = cs_etm__get_v7_protocol_version(etmidr);
> +       t_param->etmv3.reg_ctrl = metadata[CS_ETM_ETMCR];
> +       t_param->etmv3.reg_trc_id = metadata[CS_ETM_ETMTRACEIDR];
>  }
>

This is inherently incorrect - you are assuming that all trace devices
on a given system are the same and have the same parameters. This does
not have to be the case.


> -static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
> -                                         struct cs_etm_auxtrace *etm, int idx)
> +static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_param,
> +                                         u64 *metadata)
>  {
> -       u64 **metadata = etm->metadata;
> +       t_param->protocol = CS_ETM_PROTO_ETMV4i;
> +       t_param->etmv4.reg_idr0 = metadata[CS_ETMV4_TRCIDR0];
> +       t_param->etmv4.reg_idr1 = metadata[CS_ETMV4_TRCIDR1];
> +       t_param->etmv4.reg_idr2 = metadata[CS_ETMV4_TRCIDR2];
> +       t_param->etmv4.reg_idr8 = metadata[CS_ETMV4_TRCIDR8];
> +       t_param->etmv4.reg_configr = metadata[CS_ETMV4_TRCCONFIGR];
> +       t_param->etmv4.reg_traceidr = metadata[CS_ETMV4_TRCTRACEIDR];
> +}
>
> -       t_params[idx].protocol = CS_ETM_PROTO_ETMV4i;
> -       t_params[idx].etmv4.reg_idr0 = metadata[idx][CS_ETMV4_TRCIDR0];
> -       t_params[idx].etmv4.reg_idr1 = metadata[idx][CS_ETMV4_TRCIDR1];
> -       t_params[idx].etmv4.reg_idr2 = metadata[idx][CS_ETMV4_TRCIDR2];
> -       t_params[idx].etmv4.reg_idr8 = metadata[idx][CS_ETMV4_TRCIDR8];
> -       t_params[idx].etmv4.reg_configr = metadata[idx][CS_ETMV4_TRCCONFIGR];
> -       t_params[idx].etmv4.reg_traceidr = metadata[idx][CS_ETMV4_TRCTRACEIDR];
> +static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_param,
> +                                       u64 *metadata)
> +{
> +       t_param->protocol = CS_ETM_PROTO_ETE;
> +       t_param->ete.reg_idr0 = metadata[CS_ETE_TRCIDR0];
> +       t_param->ete.reg_idr1 = metadata[CS_ETE_TRCIDR1];
> +       t_param->ete.reg_idr2 = metadata[CS_ETE_TRCIDR2];
> +       t_param->ete.reg_idr8 = metadata[CS_ETE_TRCIDR8];
> +       t_param->ete.reg_configr = metadata[CS_ETE_TRCCONFIGR];
> +       t_param->ete.reg_traceidr = metadata[CS_ETE_TRCTRACEIDR];
> +       t_param->ete.reg_devarch = metadata[CS_ETE_TRCDEVARCH];
>  }
>

as above for ETE & ETMv4

> -static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_params,
> -                                         struct cs_etm_auxtrace *etm, int idx)
> +static int cs_etm__set_trace_param(struct cs_etm_trace_params *t_param,
> +                                  u64 *metadata)
>  {
> -       u64 **metadata = etm->metadata;
> +       u32 etmidr;
> +       u64 architecture = metadata[CS_ETM_MAGIC];
> +
> +       switch (architecture) {
> +       case __perf_cs_etmv3_magic:
> +               etmidr = metadata[CS_ETM_ETMIDR];
> +               cs_etm__set_trace_param_etmv3(t_param, metadata, etmidr);
> +               break;
> +       case __perf_cs_etmv4_magic:
> +               cs_etm__set_trace_param_etmv4(t_param, metadata);
> +               break;
> +       case __perf_cs_ete_magic:
> +               cs_etm__set_trace_param_ete(t_param, metadata);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
>
> -       t_params[idx].protocol = CS_ETM_PROTO_ETE;
> -       t_params[idx].ete.reg_idr0 = metadata[idx][CS_ETE_TRCIDR0];
> -       t_params[idx].ete.reg_idr1 = metadata[idx][CS_ETE_TRCIDR1];
> -       t_params[idx].ete.reg_idr2 = metadata[idx][CS_ETE_TRCIDR2];
> -       t_params[idx].ete.reg_idr8 = metadata[idx][CS_ETE_TRCIDR8];
> -       t_params[idx].ete.reg_configr = metadata[idx][CS_ETE_TRCCONFIGR];
> -       t_params[idx].ete.reg_traceidr = metadata[idx][CS_ETE_TRCTRACEIDR];
> -       t_params[idx].ete.reg_devarch = metadata[idx][CS_ETE_TRCDEVARCH];
> +       return 0;
>  }
>
>  static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
>                                      struct cs_etm_auxtrace *etm,
> +                                    bool formatted,
> +                                    int sample_cpu,
>                                      int decoders)
>  {
> -       int i;
> -       u32 etmidr;
> -       u64 architecture;
> -
> -       for (i = 0; i < decoders; i++) {
> -               architecture = etm->metadata[i][CS_ETM_MAGIC];
> +       int i, ret;
> +       struct cs_etm_trace_params *t_param;
> +       u64 *metadata;
>
> -               switch (architecture) {
> -               case __perf_cs_etmv3_magic:
> -                       etmidr = etm->metadata[i][CS_ETM_ETMIDR];
> -                       cs_etm__set_trace_param_etmv3(t_params, etm, i, etmidr);
> -                       break;
> -               case __perf_cs_etmv4_magic:
> -                       cs_etm__set_trace_param_etmv4(t_params, etm, i);
> -                       break;
> -               case __perf_cs_ete_magic:
> -                       cs_etm__set_trace_param_ete(t_params, etm, i);
> -                       break;
> -               default:
> +       if (!formatted) {
> +               /*
> +                * There is only one decoder when unformatted. Use metadata of
> +                * sample AUX cpu.
> +                */


Unformatted ETE data should not only have a single decoder - there
must be a decoder per CPU - as per all trace decode flows. The key
difference with ETE is that it usually has its own trace sink (TRBE),
so no formatting is needed, but per cpu decoder is still required.

Regards

Mike


> +               t_param = t_params;
> +               metadata = get_cpu_data(etm, sample_cpu);
> +               if (!metadata) {
> +                       pr_err("CS_ETM: invalid sample CPU: %d\n", sample_cpu);
>                         return -EINVAL;
>                 }
> +
> +               return cs_etm__set_trace_param(t_param, metadata);
> +       }
> +
> +       for (i = 0; i < decoders; i++) {
> +               t_param = &t_params[i];
> +               metadata = etm->metadata[i];
> +               ret = cs_etm__set_trace_param(t_param, metadata);
> +               if (ret)
> +                       return ret;
>         }
>
>         return 0;
> @@ -1016,7 +1039,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
>  }
>
>  static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
> -                                               bool formatted)
> +                                               bool formatted, int sample_cpu)
>  {
>         struct cs_etm_decoder_params d_params;
>         struct cs_etm_trace_params  *t_params = NULL;
> @@ -1041,7 +1064,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
>         if (!t_params)
>                 goto out_free;
>
> -       if (cs_etm__init_trace_params(t_params, etm, decoders))
> +       if (cs_etm__init_trace_params(t_params, etm, formatted, sample_cpu, decoders))
>                 goto out_free;
>
>         /* Set decoder parameters to decode trace packets */
> @@ -1081,14 +1104,15 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
>  static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>                                struct auxtrace_queue *queue,
>                                unsigned int queue_nr,
> -                              bool formatted)
> +                              bool formatted,
> +                              int sample_cpu)
>  {
>         struct cs_etm_queue *etmq = queue->priv;
>
>         if (list_empty(&queue->head) || etmq)
>                 return 0;
>
> -       etmq = cs_etm__alloc_queue(etm, formatted);
> +       etmq = cs_etm__alloc_queue(etm, formatted, sample_cpu);
>
>         if (!etmq)
>                 return -ENOMEM;
> @@ -2816,7 +2840,7 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
>                  * formatted in piped mode (true).
>                  */
>                 err = cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
> -                                         idx, true);
> +                                         idx, true, -1);
>                 if (err)
>                         return err;
>
> @@ -3022,7 +3046,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>                 idx = auxtrace_event->idx;
>                 formatted = !(aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
>                 return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
> -                                          idx, formatted);
> +                                          idx, formatted, sample->cpu);
>         }
>
>         /* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
> --
> 2.34.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
