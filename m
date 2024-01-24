Return-Path: <linux-kernel+bounces-36204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7C9839D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A671C22E55
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7535264E;
	Wed, 24 Jan 2024 00:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZkeeWfLd"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1D160
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706054805; cv=none; b=uLup8hXECaHBXtPhXw7Vj7wQp6I0BF0TiOiYFeqVbqZAlWLZiOiz9vOAqb77FGREpgU0UC5ryU4eL9bj9wRoMbZqGw205ONLctNptiOwtA1UVGENknAiAf7o+REpmI/YjK3H0Qsv4GNfiwtHGc6pUWk1bmgCUmcRzONkuTv/ZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706054805; c=relaxed/simple;
	bh=rZHhqpdV09RBjct+8rohdICosWf10vRtUg9dySs5lK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlmIy6nKchJSfr3LOgPCeU/hvHCL/wx3TOffeENsW/KUHJW6ZYrfDTq+23NSauWZDD68IopqwLMdthoJzchCnpbwTsVD3gFY3Wvcw6QxfQ1aLXzCnBTaS7MGoLTRMeT545L85ynCAMQ2r6dfRsYHdlidW1Gmd+CTvRu+1D6iQH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZkeeWfLd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d72043fa06so22935ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706054802; x=1706659602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fOkr01HhQ29nbxmHtjOefyIBnz5o1KkvNEjSppqfdE=;
        b=ZkeeWfLd0KCahbpHhKs3tmKmzbir7tmOoY6t2QNBU1z66Mu3U80ie59pghvaCJCGM3
         yxLUv2qil5EjxH1H+SNg6nLdtZg1+DB/ydI1VCoDZbbZ4MVqc3I25KgeADOfmIJ8JmcC
         rfZcjaF6KRQzWZE/b0bgKLKWvxZGliO0dtWCSQ5sJQRseWqp5ahqkYWDM7Ddnmoefz1b
         ta4+Cwr4G9qULs4ln0PjgB0D7mVYdVAPWG41mgHqqL7+0lJbNFtny0DMsCIT8XtbfHTS
         giKQlvvQR5QOQILH8xQmTplOm8JhAuR6HP2JHJEiTKfvvJbeh5tOlNE7lkZVfDRMTUS+
         lA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706054802; x=1706659602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fOkr01HhQ29nbxmHtjOefyIBnz5o1KkvNEjSppqfdE=;
        b=Emj5m2MM6VIpR4hZy5bUEMqtKfPwJOufKr9wtytBfruZ5/F0k0dhjaMQF7xYHt9wx2
         qFMiXeWr490xNJt9A8ePeP6q5qr9pt47CkDMilfvxt3oHZhIAJJ5acBFXtibiJ2pUQU6
         CZT46AQKW6PEoZEgqDXhA4Ziq/AZ7VnkY3q9o/V1AmmtvMDFGejq42EXpha2RqQT4bFz
         e9DDDHB7kq+IJumdCTCl+P+3k5D3gaJJKRyz/suQVtLsI5eUbPThvRiZYAlj19FMk4qK
         DlojM4iA2/5WcHgGdNXCcXOUY/S/HV4u2ewJEuGrwf449nfJHsFX3h0qNJar64ByxMOW
         Cwkg==
X-Gm-Message-State: AOJu0YyGXtfV/uQqpUS8ezDda/ZXGHTSWcHn/vf9FtNXBD4LuuNG0gJh
	yuWPdez9upCoKbq+3teS8yIm0lB+i66IJ1yzcsS+7pN5bcdlyRcVIDjuXiophMuin+DODVVcCbD
	bvXQF6PDeG4QmEN5F1HjkdF9vZWbtldNhwJeU
X-Google-Smtp-Source: AGHT+IE6dUzYilB/l8F+LR/PPKnPQlYXLpPxhwThU63K69TXLSurnGluE3q2YmTVbETmGowNPH7qrYX4RRU+spu5gLc=
X-Received: by 2002:a17:902:ea06:b0:1d7:48ef:e239 with SMTP id
 s6-20020a170902ea0600b001d748efe239mr4514plg.18.1706054801641; Tue, 23 Jan
 2024 16:06:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212230224.1473300-1-weilin.wang@intel.com> <20231212230224.1473300-5-weilin.wang@intel.com>
In-Reply-To: <20231212230224.1473300-5-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jan 2024 16:06:29 -0800
Message-ID: <CAP-5=fWXWH+X_XFwFgRtX4X3zquHRCJ4BiHTktQNwJT6zGy8rA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 03/18] perf pmu-events: Add functions in jevent.py
 to parse counter and event info for hardware aware grouping
To: weilin.wang@intel.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Yang Jihong <yangjihong1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 3:02=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> These functions are added to parse event counter restrictions and counter
> availability info from json files so that the metric grouping method coul=
d
> do grouping based on the counter restriction of events and the counters
> that are available on the system.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/pmu-events/jevents.py   | 171 ++++++++++++++++++++++++++++-
>  tools/perf/pmu-events/pmu-events.h |  25 ++++-
>  2 files changed, 188 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 0093c998cb6e..16f17d335f8e 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -23,6 +23,8 @@ _metric_tables =3D []
>  _sys_metric_tables =3D []
>  # Mapping between sys event table names and sys metric table names.
>  _sys_event_table_to_metric_table_mapping =3D {}
> +# List of regular PMU counter layout tables.
> +_pmu_layouts_tables =3D []
>  # Map from an event name to an architecture standard
>  # JsonEvent. Architecture standard events are in json files in the top
>  # f'{_args.starting_dir}/{_args.arch}' directory.
> @@ -31,6 +33,9 @@ _arch_std_events =3D {}
>  _pending_events =3D []
>  # Name of events table to be written out
>  _pending_events_tblname =3D None
> +# PMU counter layout to write out when the table is closed

nit: s/table/layout table/

> +_pending_pmu_counts =3D [] # Name of PMU counter layout table to be writ=
ten out
> +_pending_pmu_counts_tblname =3D None
>  # Metrics to write out when the table is closed
>  _pending_metrics =3D []
>  # Name of metrics table to be written out
> @@ -47,10 +52,17 @@ _json_event_attributes =3D [
>      'event',
>      # Short things in alphabetical order.
>      'compat', 'deprecated', 'perpkg', 'unit',
> +    # Counter this event could use
> +    'counter',
>      # Longer things (the last won't be iterated over during decompress).
>      'long_desc'
>  ]
>
> +# Attributes that are in pmu_unit_layout.
> +_json_layout_attributes =3D [
> +    'pmu', 'desc', 'size', 'fixed_size'
> +]
> +
>  # Attributes that are in pmu_metric rather than pmu_event.
>  _json_metric_attributes =3D [
>      'metric_name', 'metric_group', 'metric_expr', 'metric_threshold',
> @@ -58,7 +70,9 @@ _json_metric_attributes =3D [
>      'default_metricgroup_name', 'aggr_mode', 'event_grouping'
>  ]
>  # Attributes that are bools or enum int values, encoded as '0', '1',...
> -_json_enum_attributes =3D ['aggr_mode', 'deprecated', 'event_grouping', =
'perpkg']
> +_json_enum_attributes =3D ['aggr_mode', 'deprecated', 'event_grouping', =
'perpkg',
> +    'size', 'fixed_size'
> +]
>
>  def removesuffix(s: str, suffix: str) -> str:
>    """Remove the suffix from a string
> @@ -316,6 +330,9 @@ class JsonEvent:
>      if 'Errata' in jd:
>        extra_desc +=3D '  Spec update: ' + jd['Errata']
>      self.pmu =3D unit_to_pmu(jd.get('Unit'))
> +    self.counter =3D jd.get('Counter')
> +    self.size =3D jd.get('Size')
> +    self.fixed_size =3D jd.get('FixedSize')

nit: I think it is less than clear what the counter, size and fixed
size fields in JsonEvent are for. The code is derived from much older
code by Andi Kleen, for new fields I think it would be preferable to
document them.

>      filter =3D jd.get('Filter')
>      self.unit =3D jd.get('ScaleUnit')
>      self.perpkg =3D jd.get('PerPkg')
> @@ -386,8 +403,16 @@ class JsonEvent:
>          s +=3D f'\t{attr} =3D {value},\n'
>      return s + '}'
>
> -  def build_c_string(self, metric: bool) -> str:
> +  def build_c_string(self, metric: bool, layout: bool =3D False) -> str:
>      s =3D ''
> +    if layout:
> +      for attr in _json_layout_attributes:
> +        x =3D getattr(self, attr)
> +        if attr in _json_enum_attributes:
> +          s +=3D x if x else '0'
> +        else:
> +          s +=3D f'{x}\\000' if x else '\\000'
> +      return s
>      for attr in _json_metric_attributes if metric else _json_event_attri=
butes:
>        x =3D getattr(self, attr)
>        if metric and x and attr =3D=3D 'metric_expr':
> @@ -402,10 +427,10 @@ class JsonEvent:
>          s +=3D f'{x}\\000' if x else '\\000'
>      return s
>
> -  def to_c_string(self, metric: bool) -> str:
> +  def to_c_string(self, metric: bool, layout: bool =3D False) -> str:

nit: Removing the default argument would make the code less error prone.

>      """Representation of the event as a C struct initializer."""
>
> -    s =3D self.build_c_string(metric)
> +    s =3D self.build_c_string(metric, layout)
>      return f'{{ { _bcs.offsets[s] } }}, /* {s} */\n'
>
>
> @@ -442,6 +467,8 @@ def preprocess_arch_std_files(archpath: str) -> None:
>            _arch_std_events[event.name.lower()] =3D event
>          if event.metric_name:
>            _arch_std_events[event.metric_name.lower()] =3D event
> +        if event.size:
> +          _arch_std_events[event.pmu.lower()] =3D event
>
>
>  def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
> @@ -451,6 +478,8 @@ def add_events_table_entries(item: os.DirEntry, topic=
: str) -> None:
>        _pending_events.append(e)
>      if e.metric_name:
>        _pending_metrics.append(e)
> +    if e.size:
> +      _pending_pmu_counts.append(e)
>
>
>  def print_pending_events() -> None:
> @@ -564,6 +593,33 @@ const struct pmu_table_entry {_pending_metrics_tblna=
me}[] =3D {{
>  """)
>    _args.output_file.write('};\n\n')
>
> +def print_pending_pmu_counts() -> None:

nit: Perhaps "print_pending_pmu_counter_layout_tables" would be a
better name? A function description comment would be nice.

> +
> +  def pmu_counts_cmp_key(j: JsonEvent) -> Tuple[bool, str, str]:
> +    def fix_none(s: Optional[str]) -> str:
> +      if s is None:
> +        return ''
> +      return s
> +
> +    return (j.desc is not None, fix_none(j.pmu), fix_none(j.size))
> +
> +  global _pending_pmu_counts
> +  if not _pending_pmu_counts:
> +    return
> +
> +  global _pending_pmu_counts_tblname
> +  global pmu_layouts_tables
> +  _pmu_layouts_tables.append(_pending_pmu_counts_tblname)
> +
> +  _args.output_file.write(
> +      f'static const struct compact_pmu_event {_pending_pmu_counts_tblna=
me}[] =3D {{\n')
> +
> +  for pmu_layout in sorted(_pending_pmu_counts, key=3Dpmu_counts_cmp_key=
):
> +    _args.output_file.write(pmu_layout.to_c_string(metric=3DFalse, layou=
t=3DTrue))
> +    _pending_pmu_counts =3D []
> +
> +  _args.output_file.write('};\n\n')
> +
>  def get_topic(topic: str) -> str:
>    if topic.endswith('metrics.json'):
>      return 'metrics'
> @@ -604,6 +660,8 @@ def preprocess_one_file(parents: Sequence[str], item:=
 os.DirEntry) -> None:
>      if event.metric_name:
>        _bcs.add(pmu_name, metric=3DTrue)
>        _bcs.add(event.build_c_string(metric=3DTrue), metric=3DTrue)
> +    if event.size:
> +      _bcs.add(event.build_c_string(metric=3DFalse, layout=3DTrue), metr=
ic=3DFalse)
>
>  def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
>    """Process a JSON file during the main walk."""
> @@ -617,11 +675,14 @@ def process_one_file(parents: Sequence[str], item: =
os.DirEntry) -> None:
>    if item.is_dir() and is_leaf_dir(item.path):
>      print_pending_events()
>      print_pending_metrics()
> +    print_pending_pmu_counts()
>
>      global _pending_events_tblname
>      _pending_events_tblname =3D file_name_to_table_name('pmu_events_', p=
arents, item.name)
>      global _pending_metrics_tblname
>      _pending_metrics_tblname =3D file_name_to_table_name('pmu_metrics_',=
 parents, item.name)
> +    global _pending_pmu_counts_tblname
> +    _pending_pmu_counts_tblname =3D file_name_to_table_name('pmu_layouts=
_', parents, item.name)
>
>      if item.name =3D=3D 'sys':
>        _sys_event_table_to_metric_table_mapping[_pending_events_tblname] =
=3D _pending_metrics_tblname
> @@ -655,6 +716,12 @@ struct pmu_metrics_table {
>          uint32_t num_pmus;
>  };
>
> +/* Struct used to make the PMU counter layout table implementation opaqu=
e to callers. */
> +struct pmu_layouts_table {
> +        const struct compact_pmu_event *entries;
> +        size_t length;
> +};
> +
>  /*
>   * Map a CPU to its table of PMU events. The CPU is identified by the
>   * cpuid field, which is an arch-specific identifier for the CPU.
> @@ -668,6 +735,7 @@ struct pmu_events_map {
>          const char *cpuid;
>          struct pmu_events_table event_table;
>          struct pmu_metrics_table metric_table;
> +        struct pmu_layouts_table layout_table;
>  };
>
>  /*
> @@ -712,6 +780,12 @@ const struct pmu_events_map pmu_events_map[] =3D {
>                metric_size =3D '0'
>              if event_size =3D=3D '0' and metric_size =3D=3D '0':
>                continue
> +            layout_tblname =3D file_name_to_table_name('pmu_layouts_', [=
], row[2].replace('/', '_'))
> +            if layout_tblname in _pmu_layouts_tables:
> +              layout_size =3D f'ARRAY_SIZE({layout_tblname})'
> +            else:
> +              layout_tblname =3D 'NULL'
> +              layout_size =3D '0'
>              cpuid =3D row[0].replace('\\', '\\\\')
>              _args.output_file.write(f"""{{
>  \t.arch =3D "{arch}",
> @@ -723,6 +797,10 @@ const struct pmu_events_map pmu_events_map[] =3D {
>  \t.metric_table =3D {{
>  \t\t.pmus =3D {metric_tblname},
>  \t\t.num_pmus =3D {metric_size}
> +\t}},
> +\t.layout_table =3D {{
> +\t\t.entries =3D {layout_tblname},
> +\t\t.length =3D {layout_size}
>  \t}}
>  }},
>  """)
> @@ -733,6 +811,7 @@ const struct pmu_events_map pmu_events_map[] =3D {
>  \t.cpuid =3D 0,
>  \t.event_table =3D { 0, 0 },
>  \t.metric_table =3D { 0, 0 },
> +\t.layout_table =3D { 0, 0 },
>  }
>  };
>  """)
> @@ -821,6 +900,24 @@ static void decompress_metric(int offset, struct pmu=
_metric *pm)
>        _args.output_file.write('\twhile (*p++);')
>    _args.output_file.write("""}
>
> +static void decompress_layout(int offset, struct pmu_layout *pm)
> +{
> +\tconst char *p =3D &big_c_string[offset];
> +""")
> +  for attr in _json_layout_attributes:
> +    _args.output_file.write(f'\n\tpm->{attr} =3D ')
> +    if attr in _json_enum_attributes:
> +      _args.output_file.write("*p - '0';\n")
> +    else:
> +      _args.output_file.write("(*p =3D=3D '\\0' ? NULL : p);\n")
> +    if attr =3D=3D _json_layout_attributes[-1]:
> +      continue
> +    if attr in _json_enum_attributes:
> +      _args.output_file.write('\tp++;')
> +    else:
> +      _args.output_file.write('\twhile (*p++);')
> +  _args.output_file.write("""}
> +
>  static int pmu_events_table__for_each_event_pmu(const struct pmu_events_=
table *table,
>                                                  const struct pmu_table_e=
ntry *pmu,
>                                                  pmu_event_iter_fn fn,
> @@ -976,6 +1073,21 @@ int pmu_metrics_table__for_each_metric(const struct=
 pmu_metrics_table *table,
>          return 0;
>  }
>
> +int pmu_layouts_table__for_each_layout(const struct pmu_layouts_table *t=
able,
> +                                     pmu_layout_iter_fn fn,
> +                                     void *data) {
> +        for (size_t i =3D 0; i < table->length; i++) {
> +                struct pmu_layout pm;
> +                int ret;
> +
> +                decompress_layout(table->entries[i].offset, &pm);
> +                ret =3D fn(&pm, data);
> +                if (ret)
> +                        return ret;
> +        }
> +        return 0;
> +}
> +
>  static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
>  {
>          static struct {
> @@ -1071,6 +1183,33 @@ const struct pmu_metrics_table *perf_pmu__find_met=
rics_table(struct perf_pmu *pm
>          return NULL;
>  }
>
> +const struct pmu_layouts_table *perf_pmu__find_layouts_table(struct perf=
_pmu *pmu)
> +{
> +        const struct pmu_layouts_table *table =3D NULL;
> +        char *cpuid =3D perf_pmu__getcpuid(pmu);
> +        int i;
> +
> +        /* on some platforms which uses cpus map, cpuid can be NULL for
> +         * PMUs other than CORE PMUs.
> +         */
> +        if (!cpuid)
> +                return NULL;
> +
> +        i =3D 0;
> +        for (;;) {
> +                const struct pmu_events_map *map =3D &pmu_events_map[i++=
];
> +                if (!map->arch)
> +                        break;
> +
> +                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> +                        table =3D &map->layout_table;
> +                        break;
> +                }
> +        }
> +        free(cpuid);
> +        return table;
> +}
> +
>  const struct pmu_events_table *find_core_events_table(const char *arch, =
const char *cpuid)
>  {
>          for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
> @@ -1092,6 +1231,16 @@ const struct pmu_metrics_table *find_core_metrics_=
table(const char *arch, const
>          }
>          return NULL;
>  }
> +const struct pmu_layouts_table *find_core_layouts_table(const char *arch=
, const char *cpuid)
> +{
> +        for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
> +             tables->arch;
> +             tables++) {
> +                if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tab=
les->cpuid, cpuid))
> +                        return &tables->layout_table;
> +        }
> +        return NULL;
> +}
>
>  int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
>  {
> @@ -1120,6 +1269,19 @@ int pmu_for_each_core_metric(pmu_metric_iter_fn fn=
, void *data)
>          return 0;
>  }
>
> +int pmu_for_each_core_layout(pmu_layout_iter_fn fn, void *data)
> +{
> +        for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
> +             tables->arch;
> +             tables++) {
> +                int ret =3D pmu_layouts_table__for_each_layout(&tables->=
layout_table, fn, data);
> +
> +                if (ret)
> +                        return ret;
> +        }
> +        return 0;
> +}
> +
>  const struct pmu_events_table *find_sys_events_table(const char *name)
>  {
>          for (const struct pmu_sys_events *tables =3D &pmu_sys_event_tabl=
es[0];
> @@ -1276,6 +1438,7 @@ struct pmu_table_entry {
>      ftw(arch_path, [], process_one_file)
>      print_pending_events()
>      print_pending_metrics()
> +    print_pending_pmu_counts()
>
>    print_mapping_table(archs)
>    print_system_mapping_table()
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/p=
mu-events.h
> index f5aa96f1685c..65e0c5dd8bb4 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -45,6 +45,7 @@ struct pmu_event {
>         const char *desc;
>         const char *topic;
>         const char *long_desc;

nit: A comment/example for the counter value would be useful.

> +       const char *counter;
>         const char *pmu;
>         const char *unit;
>         bool perpkg;
> @@ -67,8 +68,16 @@ struct pmu_metric {
>         enum metric_event_groups event_grouping;
>  };
>
> +struct pmu_layout {
> +       const char *pmu;
> +       const char *desc;
> +       int size;
> +       int fixed_size;

So size is the number of generic counters and fixed size the number of
fixed counters? Perhaps num_counters and num_fixed_counters, comments
would be useful.

> +};
> +
>  struct pmu_events_table;
>  struct pmu_metrics_table;
> +struct pmu_layouts_table;
>
>  typedef int (*pmu_event_iter_fn)(const struct pmu_event *pe,
>                                  const struct pmu_events_table *table,
> @@ -78,15 +87,20 @@ typedef int (*pmu_metric_iter_fn)(const struct pmu_me=
tric *pm,
>                                   const struct pmu_metrics_table *table,
>                                   void *data);
>
> +typedef int (*pmu_layout_iter_fn)(const struct pmu_layout *pm,
> +                                 void *data);
> +
>  int pmu_events_table__for_each_event(const struct pmu_events_table *tabl=
e,
>                                     struct perf_pmu *pmu,
>                                     pmu_event_iter_fn fn,
>                                     void *data);
>  int pmu_events_table__find_event(const struct pmu_events_table *table,
> -                                 struct perf_pmu *pmu,
> -                                 const char *name,
> -                                 pmu_event_iter_fn fn,
> -                                void *data);
> +                               struct perf_pmu *pmu,
> +                               const char *name,
> +                               pmu_event_iter_fn fn,
> +                               void *data);

nit: I think this is just a whitespace difference and so should be avoided.

> +int pmu_layouts_table__for_each_layout(const struct pmu_layouts_table *t=
able, pmu_layout_iter_fn fn,
> +                                    void *data);

Perhaps we should cache the layout in the struct pmu and iterate those.

Thanks,
Ian

>  size_t pmu_events_table__num_events(const struct pmu_events_table *table=
,
>                                     struct perf_pmu *pmu);
>
> @@ -95,10 +109,13 @@ int pmu_metrics_table__for_each_metric(const struct =
pmu_metrics_table *table, pm
>
>  const struct pmu_events_table *perf_pmu__find_events_table(struct perf_p=
mu *pmu);
>  const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf=
_pmu *pmu);
> +const struct pmu_layouts_table *perf_pmu__find_layouts_table(struct perf=
_pmu *pmu);
>  const struct pmu_events_table *find_core_events_table(const char *arch, =
const char *cpuid);
>  const struct pmu_metrics_table *find_core_metrics_table(const char *arch=
, const char *cpuid);
> +const struct pmu_layouts_table *find_core_layouts_table(const char *arch=
, const char *cpuid);
>  int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data);
>  int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data);
> +int pmu_for_each_core_layout(pmu_layout_iter_fn fn, void *data);
>
>  const struct pmu_events_table *find_sys_events_table(const char *name);
>  const struct pmu_metrics_table *find_sys_metrics_table(const char *name)=
;
> --
> 2.39.3
>

