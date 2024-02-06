Return-Path: <linux-kernel+bounces-55422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BBC84BC7F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE371C22F73
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BD9DDCF;
	Tue,  6 Feb 2024 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="y3xsTXbl"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13861D517
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241808; cv=none; b=MO4T2BIrlbz0t19p5n5JaGYupCfXq8X73p+zuwQLw+Teps7iB6dkiL0J9HDChEVEUdCjVpcbGOcG5YylLHik5pJWEG9/C6ux0/62tGO/djQkfz/29XtkNa1NtkpRHWwrWOHhknmw2QL3pE9nVKZpiEzBs4vimHUQWkAcj8CX6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241808; c=relaxed/simple;
	bh=71CJ/2o7DiKE/fEpf3QubuVJQUce46v57PBM/VXMQqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBo6+OoJWdjzQ4hs6AYAX3qu3ZivtuY2yHtkpyXSZUTSD4VSD+GWaIsXyiNGwGkgo2BWPGuXR2ypVYBgK0x4+l9Duxbv7L66a/PhkGh0xqM5Tfx+/NoPx7i8+5dP7rp53mLZWN6fsT0P1lE/Ss9TXV9/XPIX9dEx7VOo1g2j4AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y3xsTXbl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d5ce88b51cso4375ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 09:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707241805; x=1707846605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LYcihhiOkPDyxJpi/Txx7HKEtnp87JX9zt2+rA2dyA=;
        b=y3xsTXblplQVpzU2F47g+pnLoDMBaaPuPW8iH5kOxGC1zxqQFe65Mzbmo0+xQQETZ8
         zLNlvmt7CKWq6h3StPV4CfXnrY3J82faFFdi1WNdD260SpWMQzZXR8Yq/LWMUF/UPash
         z8h2EWGqm2BVbZHjBQRqBvFciIEdzzt/8xaSheO1Q6MdhxrSkIG4V+nCq6Q/4DT56D0B
         cZe2/ERs/CiOGBNs81FB6vjuueUc+SxYz0Lm9YxuBl6jgtSkGU36RThQpaEtIppOGJb/
         C2EnbxBd0jv87H2S3xbEBU2FdFQ2sTcHYwtWo1M+7tkkeH07sIgFDRHnBFF6VYVPfkHD
         JP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707241805; x=1707846605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LYcihhiOkPDyxJpi/Txx7HKEtnp87JX9zt2+rA2dyA=;
        b=L8nZ1O+b0BG9MP4w2dktxPN/a5GBKhJXSZX2vALE9h7+k8NnE8SYaVXmssTmaYf0LY
         VgcAKbm+mJ1VQRB204a5mz7FoWLMKPzqbkkJ+vI7AnwWRyz2Cr/IdihtFFRXqCKAUQw4
         xUkJ/tgA+b53HS5y5a/xfrkFsH6urhx3w2nRGF+V5Hdhr/LwJMucGZYyI+afxg4xH8o6
         l5fbE45JDvmVA3o1hrFQlJrM5htQ1Ga2tFsOOPTCmORWN5+vkXer8PqUSPiPn6rhj56w
         i/MfDqgUXtguw5iGMJDssiKmoTzEPW1sV8jeInmxn8nI9A8EXun9ePDIUiY8DbFG7+7M
         wdYw==
X-Gm-Message-State: AOJu0YxnCO21vVhEutTEBgPEse6F4XwYqUIhUbOly6q+3nAcXlAHzI59
	qjoOsgvUw4H4bdj1tw4v+hM0piCRel59CpX2wYqTQO/P/CDbAfbKfeHdqLY9hz+zCvBYi4KZN5B
	msQEVCfzjk1zMmgQW8feX+au2s2aypmx2OHx+
X-Google-Smtp-Source: AGHT+IEqO2XEf52UWQCeyrf9whURBclOTubqe560y5aRcnvsAHNaqR9fvzEnaST3GnluJR2FxdRnUF15Oqw0LloT8IA=
X-Received: by 2002:a17:903:44:b0:1d8:d6f2:5ecc with SMTP id
 l4-20020a170903004400b001d8d6f25eccmr143pla.20.1707241804850; Tue, 06 Feb
 2024 09:50:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206082016.22292-1-yangyicong@huawei.com>
In-Reply-To: <20240206082016.22292-1-yangyicong@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 6 Feb 2024 09:49:53 -0800
Message-ID: <CAP-5=fUaJSF1R_yDTeNwiNbm0isGTEpZSbp2m0q7BJox+TdRwg@mail.gmail.com>
Subject: Re: [RESEND v4] perf stat: Support per-cluster aggregation
To: Yicong Yang <yangyicong@huawei.com>
Cc: acme@kernel.org, mark.rutland@arm.com, peterz@infradead.org, 
	mingo@redhat.com, james.clark@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, zhanjie9@hisilicon.com, 21cnbao@gmail.com, 
	tim.c.chen@intel.com, prime.zeng@hisilicon.com, fanghao11@huawei.com, 
	linuxarm@huawei.com, yangyicong@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 12:24=E2=80=AFAM Yicong Yang <yangyicong@huawei.com>=
 wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> Some platforms have 'cluster' topology and CPUs in the cluster will
> share resources like L3 Cache Tag (for HiSilicon Kunpeng SoC) or L2
> cache (for Intel Jacobsville). Currently parsing and building cluster
> topology have been supported since [1].
>
> perf stat has already supported aggregation for other topologies like
> die or socket, etc. It'll be useful to aggregate per-cluster to find
> problems like L3T bandwidth contention.
>
> This patch add support for "--per-cluster" option for per-cluster
> aggregation. Also update the docs and related test. The output will
> be like:
>
> [root@localhost tmp]# perf stat -a -e LLC-load --per-cluster -- sleep 5
>
>  Performance counter stats for 'system wide':
>
> S56-D0-CLS158    4      1,321,521,570      LLC-load
> S56-D0-CLS594    4        794,211,453      LLC-load
> S56-D0-CLS1030    4             41,623      LLC-load
> S56-D0-CLS1466    4             41,646      LLC-load
> S56-D0-CLS1902    4             16,863      LLC-load
> S56-D0-CLS2338    4             15,721      LLC-load
> S56-D0-CLS2774    4             22,671      LLC-load
> [...]
>
> On a legacy system without cluster or cluster support, the output will
> be look like:
> [root@localhost perf]# perf stat -a -e cycles --per-cluster -- sleep 1
>
>  Performance counter stats for 'system wide':
>
> S56-D0-CLS0   64         18,011,485      cycles
> S7182-D0-CLS0   64         16,548,835      cycles
>
> Note that this patch doesn't mix the cluster information in the outputs
> of --per-core to avoid breaking any tools/scripts using it.
>
> Note that perf recently supports "--per-cache" aggregation, but it's not
> the same with the cluster although cluster CPUs may share some cache
> resources. For example on my machine all clusters within a die share the
> same L3 cache:
> $ cat /sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_list
> 0-31
> $ cat /sys/devices/system/cpu/cpu0/topology/cluster_cpus_list
> 0-3
>
> [1] commit c5e22feffdd7 ("topology: Represent clusters of CPUs within a d=
ie")
> Tested-by: Jie Zhan <zhanjie9@hisilicon.com>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
> Change since v3:
> - Rebase on v6.7-rc4 and resolve the conflicts
> Link: https://lore.kernel.org/all/20230404104951.27537-1-yangyicong@huawe=
i.com/
>
> Change since v2:
> - Use 0 as cluster ID on legacy system without cluster support, keep cons=
istenct
>   with what --per-die does.
> Link: https://lore.kernel.org/all/20230328112717.19573-1-yangyicong@huawe=
i.com/
>
> Change since v1:
> - Provides the information about how to map the cluster to the CPUs in th=
e manual
> - Thanks the review from Tim and test from Jie.
> Link: https://lore.kernel.org/all/20230313085911.61359-1-yangyicong@huawe=
i.com/
>
>  tools/perf/Documentation/perf-stat.txt        | 11 ++++
>  tools/perf/builtin-stat.c                     | 52 +++++++++++++++++--
>  .../tests/shell/lib/perf_json_output_lint.py  |  4 +-
>  tools/perf/tests/shell/lib/stat_output.sh     | 12 +++++
>  tools/perf/tests/shell/stat+csv_output.sh     |  2 +
>  tools/perf/tests/shell/stat+json_output.sh    | 13 +++++
>  tools/perf/tests/shell/stat+std_output.sh     |  2 +
>  tools/perf/util/cpumap.c                      | 32 +++++++++++-
>  tools/perf/util/cpumap.h                      | 19 +++++--
>  tools/perf/util/env.h                         |  1 +
>  tools/perf/util/stat-display.c                | 13 +++++
>  tools/perf/util/stat.h                        |  1 +
>  12 files changed, 153 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Document=
ation/perf-stat.txt
> index 5af2e432b54f..29756a87ab6f 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -308,6 +308,14 @@ use --per-die in addition to -a. (system-wide).  The=
 output includes the
>  die number and the number of online processors on that die. This is
>  useful to gauge the amount of aggregation.
>
> +--per-cluster::
> +Aggregate counts per processor cluster for system-wide mode measurement.=
  This
> +is a useful mode to detect imbalance between clusters.  To enable this m=
ode,
> +use --per-cluster in addition to -a. (system-wide).  The output includes=
 the
> +cluster number and the number of online processors on that cluster. This=
 is
> +useful to gauge the amount of aggregation. The information of cluster ID=
 and
> +related CPUs can be gotten from /sys/devices/system/cpu/cpuX/topology/cl=
uster_{id, cpus}.
> +
>  --per-cache::
>  Aggregate counts per cache instance for system-wide mode measurements.  =
By
>  default, the aggregation happens for the cache level at the highest inde=
x
> @@ -396,6 +404,9 @@ Aggregate counts per processor socket for system-wide=
 mode measurements.
>  --per-die::
>  Aggregate counts per processor die for system-wide mode measurements.
>
> +--per-cluster::
> +Aggregate counts perf processor cluster for system-wide mode measurement=
s.
> +
>  --per-cache::
>  Aggregate counts per cache instance for system-wide mode measurements.  =
By
>  default, the aggregation happens for the cache level at the highest inde=
x
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 5fe9abc6a524..6bba1a89d030 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1238,6 +1238,8 @@ static struct option stat_options[] =3D {
>                      "aggregate counts per processor socket", AGGR_SOCKET=
),
>         OPT_SET_UINT(0, "per-die", &stat_config.aggr_mode,
>                      "aggregate counts per processor die", AGGR_DIE),
> +       OPT_SET_UINT(0, "per-cluster", &stat_config.aggr_mode,
> +                    "aggregate counts per processor cluster", AGGR_CLUST=
ER),
>         OPT_CALLBACK_OPTARG(0, "per-cache", &stat_config.aggr_mode, &stat=
_config.aggr_level,
>                             "cache level", "aggregate count at this cache=
 level (Default: LLC)",
>                             parse_cache_level),
> @@ -1428,6 +1430,7 @@ static struct aggr_cpu_id aggr_cpu_id__cache(struct=
 perf_cpu cpu, void *data)
>  static const char *const aggr_mode__string[] =3D {
>         [AGGR_CORE] =3D "core",
>         [AGGR_CACHE] =3D "cache",
> +       [AGGR_CLUSTER] =3D "cluster",
>         [AGGR_DIE] =3D "die",
>         [AGGR_GLOBAL] =3D "global",
>         [AGGR_NODE] =3D "node",
> @@ -1455,6 +1458,12 @@ static struct aggr_cpu_id perf_stat__get_cache_id(=
struct perf_stat_config *confi
>         return aggr_cpu_id__cache(cpu, /*data=3D*/NULL);
>  }
>
> +static struct aggr_cpu_id perf_stat__get_cluster(struct perf_stat_config=
 *config __maybe_unused,
> +                                                struct perf_cpu cpu)
> +{
> +       return aggr_cpu_id__cluster(cpu, /*data=3D*/NULL);
> +}
> +
>  static struct aggr_cpu_id perf_stat__get_core(struct perf_stat_config *c=
onfig __maybe_unused,
>                                               struct perf_cpu cpu)
>  {
> @@ -1507,6 +1516,12 @@ static struct aggr_cpu_id perf_stat__get_die_cache=
d(struct perf_stat_config *con
>         return perf_stat__get_aggr(config, perf_stat__get_die, cpu);
>  }
>
> +static struct aggr_cpu_id perf_stat__get_cluster_cached(struct perf_stat=
_config *config,
> +                                                       struct perf_cpu c=
pu)
> +{
> +       return perf_stat__get_aggr(config, perf_stat__get_cluster, cpu);
> +}
> +
>  static struct aggr_cpu_id perf_stat__get_cache_id_cached(struct perf_sta=
t_config *config,
>                                                          struct perf_cpu =
cpu)
>  {
> @@ -1544,6 +1559,8 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum a=
ggr_mode aggr_mode)
>                 return aggr_cpu_id__socket;
>         case AGGR_DIE:
>                 return aggr_cpu_id__die;
> +       case AGGR_CLUSTER:
> +               return aggr_cpu_id__cluster;
>         case AGGR_CACHE:
>                 return aggr_cpu_id__cache;
>         case AGGR_CORE:
> @@ -1569,6 +1586,8 @@ static aggr_get_id_t aggr_mode__get_id(enum aggr_mo=
de aggr_mode)
>                 return perf_stat__get_socket_cached;
>         case AGGR_DIE:
>                 return perf_stat__get_die_cached;
> +       case AGGR_CLUSTER:
> +               return perf_stat__get_cluster_cached;
>         case AGGR_CACHE:
>                 return perf_stat__get_cache_id_cached;
>         case AGGR_CORE:
> @@ -1737,6 +1756,21 @@ static struct aggr_cpu_id perf_env__get_cache_aggr=
_by_cpu(struct perf_cpu cpu,
>         return id;
>  }
>
> +static struct aggr_cpu_id perf_env__get_cluster_aggr_by_cpu(struct perf_=
cpu cpu,
> +                                                           void *data)
> +{
> +       struct perf_env *env =3D data;
> +       struct aggr_cpu_id id =3D aggr_cpu_id__empty();
> +
> +       if (cpu.cpu !=3D -1) {
> +               id.socket =3D env->cpu[cpu.cpu].socket_id;
> +               id.die =3D env->cpu[cpu.cpu].die_id;
> +               id.cluster =3D env->cpu[cpu.cpu].cluster_id;
> +       }
> +
> +       return id;
> +}
> +
>  static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(struct perf_cpu=
 cpu, void *data)
>  {
>         struct perf_env *env =3D data;
> @@ -1744,12 +1778,12 @@ static struct aggr_cpu_id perf_env__get_core_aggr=
_by_cpu(struct perf_cpu cpu, vo
>
>         if (cpu.cpu !=3D -1) {
>                 /*
> -                * core_id is relative to socket and die,
> -                * we need a global id. So we set
> -                * socket, die id and core id
> +                * core_id is relative to socket, die and cluster, we nee=
d a
> +                * global id. So we set socket, die id, cluster id and co=
re id.
>                  */
>                 id.socket =3D env->cpu[cpu.cpu].socket_id;
>                 id.die =3D env->cpu[cpu.cpu].die_id;
> +               id.cluster =3D env->cpu[cpu.cpu].cluster_id;
>                 id.core =3D env->cpu[cpu.cpu].core_id;
>         }
>
> @@ -1805,6 +1839,12 @@ static struct aggr_cpu_id perf_stat__get_die_file(=
struct perf_stat_config *confi
>         return perf_env__get_die_aggr_by_cpu(cpu, &perf_stat.session->hea=
der.env);
>  }
>
> +static struct aggr_cpu_id perf_stat__get_cluster_file(struct perf_stat_c=
onfig *config __maybe_unused,
> +                                                     struct perf_cpu cpu=
)
> +{
> +       return perf_env__get_cluster_aggr_by_cpu(cpu, &perf_stat.session-=
>header.env);
> +}
> +
>  static struct aggr_cpu_id perf_stat__get_cache_file(struct perf_stat_con=
fig *config __maybe_unused,
>                                                     struct perf_cpu cpu)
>  {
> @@ -1842,6 +1882,8 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr_file(e=
num aggr_mode aggr_mode)
>                 return perf_env__get_socket_aggr_by_cpu;
>         case AGGR_DIE:
>                 return perf_env__get_die_aggr_by_cpu;
> +       case AGGR_CLUSTER:
> +               return perf_env__get_cluster_aggr_by_cpu;
>         case AGGR_CACHE:
>                 return perf_env__get_cache_aggr_by_cpu;
>         case AGGR_CORE:
> @@ -1867,6 +1909,8 @@ static aggr_get_id_t aggr_mode__get_id_file(enum ag=
gr_mode aggr_mode)
>                 return perf_stat__get_socket_file;
>         case AGGR_DIE:
>                 return perf_stat__get_die_file;
> +       case AGGR_CLUSTER:
> +               return perf_stat__get_cluster_file;
>         case AGGR_CACHE:
>                 return perf_stat__get_cache_file;
>         case AGGR_CORE:
> @@ -2398,6 +2442,8 @@ static int __cmd_report(int argc, const char **argv=
)
>                      "aggregate counts per processor socket", AGGR_SOCKET=
),
>         OPT_SET_UINT(0, "per-die", &perf_stat.aggr_mode,
>                      "aggregate counts per processor die", AGGR_DIE),
> +       OPT_SET_UINT(0, "per-cluster", &perf_stat.aggr_mode,
> +                    "aggregate counts perf processor cluster", AGGR_CLUS=
TER),
>         OPT_CALLBACK_OPTARG(0, "per-cache", &perf_stat.aggr_mode, &perf_s=
tat.aggr_level,
>                             "cache level",
>                             "aggregate count at this cache level (Default=
: LLC)",
> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/=
perf/tests/shell/lib/perf_json_output_lint.py
> index ea55d5ea1ced..abc1fd737782 100644
> --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> @@ -15,6 +15,7 @@ ap.add_argument('--event', action=3D'store_true')
>  ap.add_argument('--per-core', action=3D'store_true')
>  ap.add_argument('--per-thread', action=3D'store_true')
>  ap.add_argument('--per-cache', action=3D'store_true')
> +ap.add_argument('--per-cluster', action=3D'store_true')
>  ap.add_argument('--per-die', action=3D'store_true')
>  ap.add_argument('--per-node', action=3D'store_true')
>  ap.add_argument('--per-socket', action=3D'store_true')
> @@ -49,6 +50,7 @@ def check_json_output(expected_items):
>        'cgroup': lambda x: True,
>        'cpu': lambda x: isint(x),
>        'cache': lambda x: True,
> +      'cluster': lambda x: True,
>        'die': lambda x: True,
>        'event': lambda x: True,
>        'event-runtime': lambda x: isfloat(x),
> @@ -88,7 +90,7 @@ try:
>      expected_items =3D 7
>    elif args.interval or args.per_thread or args.system_wide_no_aggr:
>      expected_items =3D 8
> -  elif args.per_core or args.per_socket or args.per_node or args.per_die=
 or args.per_cache:
> +  elif args.per_core or args.per_socket or args.per_node or args.per_die=
 or args.per_cluster or args.per_cache:
>      expected_items =3D 9
>    else:
>      # If no option is specified, don't check the number of items.
> diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests=
/shell/lib/stat_output.sh
> index 3cc158a64326..c81d6a9f7983 100644
> --- a/tools/perf/tests/shell/lib/stat_output.sh
> +++ b/tools/perf/tests/shell/lib/stat_output.sh
> @@ -97,6 +97,18 @@ check_per_cache_instance()
>         echo "[Success]"
>  }
>
> +check_per_cluster()
> +{
> +       echo -n "Checking $1 output: per cluster "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat --per-cluster -a $2 true
> +       echo "[Success]"
> +}
> +
>  check_per_die()
>  {
>         echo -n "Checking $1 output: per die "
> diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests=
/shell/stat+csv_output.sh
> index f1818fa6d9ce..fc2d8cc6e5e0 100755
> --- a/tools/perf/tests/shell/stat+csv_output.sh
> +++ b/tools/perf/tests/shell/stat+csv_output.sh
> @@ -42,6 +42,7 @@ function commachecker()
>         ;; "--per-socket")      exp=3D8
>         ;; "--per-node")        exp=3D8
>         ;; "--per-die")         exp=3D8
> +       ;; "--per-cluster")     exp=3D8
>         ;; "--per-cache")       exp=3D8
>         esac
>
> @@ -79,6 +80,7 @@ then
>         check_system_wide_no_aggr "CSV" "$perf_cmd"
>         check_per_core "CSV" "$perf_cmd"
>         check_per_cache_instance "CSV" "$perf_cmd"
> +       check_per_cluster "CSV" "$perf_cmd"
>         check_per_die "CSV" "$perf_cmd"
>         check_per_socket "CSV" "$perf_cmd"
>  else
> diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/test=
s/shell/stat+json_output.sh
> index 3bc900533a5d..2b9c6212dffc 100755
> --- a/tools/perf/tests/shell/stat+json_output.sh
> +++ b/tools/perf/tests/shell/stat+json_output.sh
> @@ -122,6 +122,18 @@ check_per_cache_instance()
>         echo "[Success]"
>  }
>
> +check_per_cluster()
> +{
> +       echo -n "Checking json output: per cluster "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoia and not root"
> +               return
> +       fi
> +       perf stat -j --per-cluster -a true 2>&1 | $PYTHON $pythonchecker =
--per-cluster
> +       echo "[Success]"
> +}
> +
>  check_per_die()
>  {
>         echo -n "Checking json output: per die "
> @@ -200,6 +212,7 @@ then
>         check_system_wide_no_aggr
>         check_per_core
>         check_per_cache_instance
> +       check_per_cluster
>         check_per_die
>         check_per_socket
>  else
> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests=
/shell/stat+std_output.sh
> index 4fcdd1a9142c..16f61e86afc5 100755
> --- a/tools/perf/tests/shell/stat+std_output.sh
> +++ b/tools/perf/tests/shell/stat+std_output.sh
> @@ -40,6 +40,7 @@ function commachecker()
>         ;; "--per-node")        prefix=3D3
>         ;; "--per-die")         prefix=3D3
>         ;; "--per-cache")       prefix=3D3
> +       ;; "--per-cluster")     prefix=3D3
>         esac
>
>         while read line
> @@ -99,6 +100,7 @@ then
>         check_system_wide_no_aggr "STD" "$perf_cmd"
>         check_per_core "STD" "$perf_cmd"
>         check_per_cache_instance "STD" "$perf_cmd"
> +       check_per_cluster "STD" "$perf_cmd"
>         check_per_die "STD" "$perf_cmd"
>         check_per_socket "STD" "$perf_cmd"
>  else
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 0581ee0fa5f2..5907456d42a2 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -222,6 +222,8 @@ static int aggr_cpu_id__cmp(const void *a_pointer, co=
nst void *b_pointer)
>                 return a->socket - b->socket;
>         else if (a->die !=3D b->die)
>                 return a->die - b->die;
> +       else if (a->cluster !=3D b->cluster)
> +               return a->cluster - b->cluster;
>         else if (a->cache_lvl !=3D b->cache_lvl)
>                 return a->cache_lvl - b->cache_lvl;
>         else if (a->cache !=3D b->cache)
> @@ -309,6 +311,29 @@ struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu =
cpu, void *data)
>         return id;
>  }
>
> +int cpu__get_cluster_id(struct perf_cpu cpu)
> +{
> +       int value, ret =3D cpu__get_topology_int(cpu.cpu, "cluster_id", &=
value);

nit: normal coding style is for a whitespace newline here.

Thanks,
Ian

> +       return ret ?: value;
> +}
> +
> +struct aggr_cpu_id aggr_cpu_id__cluster(struct perf_cpu cpu, void *data)
> +{
> +       int cluster =3D cpu__get_cluster_id(cpu);
> +       struct aggr_cpu_id id;
> +
> +       /* There is no cluster_id on legacy system. */
> +       if (cluster =3D=3D -1)
> +               cluster =3D 0;
> +
> +       id =3D aggr_cpu_id__die(cpu, data);
> +       if (aggr_cpu_id__is_empty(&id))
> +               return id;
> +
> +       id.cluster =3D cluster;
> +       return id;
> +}
> +
>  int cpu__get_core_id(struct perf_cpu cpu)
>  {
>         int value, ret =3D cpu__get_topology_int(cpu.cpu, "core_id", &val=
ue);
> @@ -320,8 +345,8 @@ struct aggr_cpu_id aggr_cpu_id__core(struct perf_cpu =
cpu, void *data)
>         struct aggr_cpu_id id;
>         int core =3D cpu__get_core_id(cpu);
>
> -       /* aggr_cpu_id__die returns a struct with socket and die set. */
> -       id =3D aggr_cpu_id__die(cpu, data);
> +       /* aggr_cpu_id__die returns a struct with socket die, and cluster=
 set. */
> +       id =3D aggr_cpu_id__cluster(cpu, data);
>         if (aggr_cpu_id__is_empty(&id))
>                 return id;
>
> @@ -683,6 +708,7 @@ bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, =
const struct aggr_cpu_id *b
>                 a->node =3D=3D b->node &&
>                 a->socket =3D=3D b->socket &&
>                 a->die =3D=3D b->die &&
> +               a->cluster =3D=3D b->cluster &&
>                 a->cache_lvl =3D=3D b->cache_lvl &&
>                 a->cache =3D=3D b->cache &&
>                 a->core =3D=3D b->core &&
> @@ -695,6 +721,7 @@ bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *=
a)
>                 a->node =3D=3D -1 &&
>                 a->socket =3D=3D -1 &&
>                 a->die =3D=3D -1 &&
> +               a->cluster =3D=3D -1 &&
>                 a->cache_lvl =3D=3D -1 &&
>                 a->cache =3D=3D -1 &&
>                 a->core =3D=3D -1 &&
> @@ -708,6 +735,7 @@ struct aggr_cpu_id aggr_cpu_id__empty(void)
>                 .node =3D -1,
>                 .socket =3D -1,
>                 .die =3D -1,
> +               .cluster =3D -1,
>                 .cache_lvl =3D -1,
>                 .cache =3D -1,
>                 .core =3D -1,
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index 9df2aeb34d3d..26cf76c693f5 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -20,6 +20,8 @@ struct aggr_cpu_id {
>         int socket;
>         /** The die id as read from /sys/devices/system/cpu/cpuX/topology=
/die_id. */
>         int die;
> +       /** The cluster id as read from /sys/devices/system/cpu/cpuX/topo=
logy/cluster_id */
> +       int cluster;
>         /** The cache level as read from /sys/devices/system/cpu/cpuX/cac=
he/indexY/level */
>         int cache_lvl;
>         /**
> @@ -86,6 +88,11 @@ int cpu__get_socket_id(struct perf_cpu cpu);
>   * /sys/devices/system/cpu/cpuX/topology/die_id for the given CPU.
>   */
>  int cpu__get_die_id(struct perf_cpu cpu);
> +/**
> + * cpu__get_cluster_id - Returns the cluster id as read from
> + * /sys/devices/system/cpu/cpuX/topology/cluster_id for the given CPU
> + */
> +int cpu__get_cluster_id(struct perf_cpu cpu);
>  /**
>   * cpu__get_core_id - Returns the core id as read from
>   * /sys/devices/system/cpu/cpuX/topology/core_id for the given CPU.
> @@ -127,9 +134,15 @@ struct aggr_cpu_id aggr_cpu_id__socket(struct perf_c=
pu cpu, void *data);
>   */
>  struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data);
>  /**
> - * aggr_cpu_id__core - Create an aggr_cpu_id with the core, die and sock=
et
> - * populated with the core, die and socket for cpu. The function signatu=
re is
> - * compatible with aggr_cpu_id_get_t.
> + * aggr_cpu_id__cluster - Create an aggr_cpu_id with cluster, die and so=
cket
> + * populated with the cluster, die and socket for cpu. The function sign=
ature
> + * is compatible with aggr_cpu_id_get_t.
> + */
> +struct aggr_cpu_id aggr_cpu_id__cluster(struct perf_cpu cpu, void *data)=
;
> +/**
> + * aggr_cpu_id__core - Create an aggr_cpu_id with the core, cluster, die=
 and
> + * socket populated with the core, die and socket for cpu. The function
> + * signature is compatible with aggr_cpu_id_get_t.
>   */
>  struct aggr_cpu_id aggr_cpu_id__core(struct perf_cpu cpu, void *data);
>  /**
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 7c527e65c186..2a2c37cc40b7 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -12,6 +12,7 @@ struct perf_cpu_map;
>  struct cpu_topology_map {
>         int     socket_id;
>         int     die_id;
> +       int     cluster_id;
>         int     core_id;
>  };
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 8c61f8627ebc..4dfe7d9517a9 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -201,6 +201,9 @@ static void print_aggr_id_std(struct perf_stat_config=
 *config,
>                 snprintf(buf, sizeof(buf), "S%d-D%d-L%d-ID%d",
>                          id.socket, id.die, id.cache_lvl, id.cache);
>                 break;
> +       case AGGR_CLUSTER:
> +               snprintf(buf, sizeof(buf), "S%d-D%d-CLS%d", id.socket, id=
die, id.cluster);
> +               break;
>         case AGGR_DIE:
>                 snprintf(buf, sizeof(buf), "S%d-D%d", id.socket, id.die);
>                 break;
> @@ -251,6 +254,10 @@ static void print_aggr_id_csv(struct perf_stat_confi=
g *config,
>                 fprintf(config->output, "S%d-D%d-L%d-ID%d%s%d%s",
>                         id.socket, id.die, id.cache_lvl, id.cache, sep, a=
ggr_nr, sep);
>                 break;
> +       case AGGR_CLUSTER:
> +               fprintf(config->output, "S%d-D%d-CLS%d%s%d%s",
> +                       id.socket, id.die, id.cluster, sep, aggr_nr, sep)=
;
> +               break;
>         case AGGR_DIE:
>                 fprintf(output, "S%d-D%d%s%d%s",
>                         id.socket, id.die, sep, aggr_nr, sep);
> @@ -300,6 +307,10 @@ static void print_aggr_id_json(struct perf_stat_conf=
ig *config,
>                 fprintf(output, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"aggr=
egate-number\" : %d, ",
>                         id.socket, id.die, id.cache_lvl, id.cache, aggr_n=
r);
>                 break;
> +       case AGGR_CLUSTER:
> +               fprintf(output, "\"cluster\" : \"S%d-D%d-CLS%d\", \"aggre=
gate-number\" : %d, ",
> +                       id.socket, id.die, id.cluster, aggr_nr);
> +               break;
>         case AGGR_DIE:
>                 fprintf(output, "\"die\" : \"S%d-D%d\", \"aggregate-numbe=
r\" : %d, ",
>                         id.socket, id.die, aggr_nr);
> @@ -1248,6 +1259,7 @@ static void print_header_interval_std(struct perf_s=
tat_config *config,
>         case AGGR_NODE:
>         case AGGR_SOCKET:
>         case AGGR_DIE:
> +       case AGGR_CLUSTER:
>         case AGGR_CACHE:
>         case AGGR_CORE:
>                 fprintf(output, "#%*s %-*s cpus",
> @@ -1550,6 +1562,7 @@ void evlist__print_counters(struct evlist *evlist, =
struct perf_stat_config *conf
>         switch (config->aggr_mode) {
>         case AGGR_CORE:
>         case AGGR_CACHE:
> +       case AGGR_CLUSTER:
>         case AGGR_DIE:
>         case AGGR_SOCKET:
>         case AGGR_NODE:
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 4357ba114822..d6e5c8787ba2 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -48,6 +48,7 @@ enum aggr_mode {
>         AGGR_GLOBAL,
>         AGGR_SOCKET,
>         AGGR_DIE,
> +       AGGR_CLUSTER,
>         AGGR_CACHE,
>         AGGR_CORE,
>         AGGR_THREAD,
> --
> 2.24.0
>

