Return-Path: <linux-kernel+bounces-112584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDDD887BAD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8489AB210B2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F40134B0;
	Sun, 24 Mar 2024 04:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F/TulGzw"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C02944F
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 04:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711255787; cv=none; b=XF/9ztplI5z8rEj8qOc2TPXo95ykNZr7hHTQ2+R47xalBWsFoqZihSBJjJBTPgMIJ3EcYqKQwZ5Zs6qZKml/WZkzD76t0znICo5+nmRe4YPZ4h9l1tsqxHL8fcMjiBr8E45QE36IlB0P8BCDK75EODOAoAySuXrfK+h4b+fw29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711255787; c=relaxed/simple;
	bh=DqkpH8yuDjWEdpR1lj9mSljayz6W0+sayQ8/DIe4mW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrUXIh95EE+5+Y6HCnKA5Kr+jYW/NmL7cB0BaFDb4/32ORNmjIIard1IODh4FfYP/rcvZJeiyprMp+76KjwWcnoMhvXWny0HRF6PT04wIlf64aK7fGH5IWL8wHZeQZnaXWNrksYFzq+72i3EgDIIsDpPRg4+26sywalE73UsZls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F/TulGzw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1deddb82b43so87905ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 21:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711255780; x=1711860580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wm1fuADS5SfoKIPdJanbaO/Xj5QzXxgyybYQWU8+LUU=;
        b=F/TulGzwU8sGzu1La8lJypXeFLx+FCobDxx+/LrDvcz2dvqMlLAny7J3I9fD/BCxVe
         LVNI/X5RAjPYr1oB3LH62qLWsOma0YBsNGAQwYCtRg3iAaQp9MradTH0nTA41WhuLbUk
         rUuUU3XTxhlufjxTRz2iDW88pbYrCulqU6FM20il/VddNiHUFD56KInWIM9cZ3ulp9sm
         06hkxd06ipEo2gtggH60mCoWkGy40c+D4PUzA9v9YuSOM9sCgY3VUewO/ywCToR+8uHj
         ZpzrtMZSFrCSukkIxfNArdgyNJ8uTRPdb8YWnlrF2GHNy6Upj+h5RxDAiO8bZKr8a1KM
         iOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711255780; x=1711860580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wm1fuADS5SfoKIPdJanbaO/Xj5QzXxgyybYQWU8+LUU=;
        b=X8MXMrisg289/dAB4Yiq71aEjIRdHPMLT3WPiHwMh3SenJn/JIvFtfywyZY6eaDG+x
         XzD7eJdxwe9BjkW2HItTRrbAgq3aV7qLuSS7Jj41IFlWcgrikIjoOIlA04WeqlpzyLwn
         m1DATpTgErwgiiKXqJ/pRDmcSBQBsMTtXwmkZhJ0emAYWbSLYfac0roX6hHMQgAtepBW
         rR9FOAq52X+wbgMpwG1aKGbzV/eMtF+EsnfIdiLeEhJSS8dA2XZ74qZs/mCsoxu54yPx
         b080HhLWvo5+zOArbLFcOKbugJGF8lTp6xw6YLdrmTCrOlL+VG0ION/hEGbNvm6+oaGU
         gs6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMaIqnfZZCydUvELxaMLQj3/Q7KhQIGyv8kWLubNzuTGsjK8MuH+txn2JgLNuXfD20B0bCkqQs2sy7pLkWBHNwxMhj5HO09hJpR+am
X-Gm-Message-State: AOJu0YyjtWMD7qFSWcjWArcwvAOIYzoTnVHTb3c9SMUX0TIoBJ9KMijQ
	D7hbSUahFQkRbiHwGxq+HDouhjdapLxZElbYOlwFU17AG6Qg/v4lXjyKxApCRKcqeB826d7/Yuf
	uQUY9XElGuB4riPkAz4gs/hB9ZM6RrgBtJOpt
X-Google-Smtp-Source: AGHT+IFSdTP7DO3VLVsWwGhHWEjWitkpWhK/sY2Rp/D1DqyrcgM8sWQsgmijlt7LRJmfsxELJOisM8zOXJL/BWCcIeM=
X-Received: by 2002:a17:902:c144:b0:1e0:4ec2:cbcd with SMTP id
 4-20020a170902c14400b001e04ec2cbcdmr768490plj.14.1711255779652; Sat, 23 Mar
 2024 21:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209031441.943012-1-weilin.wang@intel.com> <20240209031441.943012-4-weilin.wang@intel.com>
In-Reply-To: <20240209031441.943012-4-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 21:49:26 -0700
Message-ID: <CAP-5=fVsKadQfF9ejqjZRzHQoTRvXJB8mktPKSZDydjNeidwYA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 03/15] perf pmu-events: Add functions in jevent.py
 to parse counter and event info for hardware aware grouping
To: weilin.wang@intel.com
Cc: Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 7:14=E2=80=AFPM <weilin.wang@intel.com> wrote:
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
>  tools/perf/pmu-events/jevents.py   | 185 +++++++++++++++++++++++++++--
>  tools/perf/pmu-events/pmu-events.h |  34 +++++-
>  2 files changed, 207 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 2c7e5d61ce92..bc91b7efa49a 100755
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
> @@ -31,6 +33,10 @@ _arch_std_events =3D {}
>  _pending_events =3D []
>  # Name of events table to be written out
>  _pending_events_tblname =3D None
> +# PMU counter layout to write out when the layout table is closed
> +_pending_pmu_counts =3D []
> +# Name of PMU counter layout table to be written out
> +_pending_pmu_counts_tblname =3D None
>  # Metrics to write out when the table is closed
>  _pending_metrics =3D []
>  # Name of metrics table to be written out
> @@ -47,10 +53,17 @@ _json_event_attributes =3D [
>      'event',
>      # Short things in alphabetical order.
>      'compat', 'deprecated', 'perpkg', 'unit',
> +    # The list of counter(s) this event could use
> +    'counters',
>      # Longer things (the last won't be iterated over during decompress).
>      'long_desc'
>  ]
>
> +# Attributes that are in pmu_unit_layout.
> +_json_layout_attributes =3D [
> +    'pmu', 'desc', 'num_counters', 'num_fixed_counters'
> +]
> +
>  # Attributes that are in pmu_metric rather than pmu_event.
>  _json_metric_attributes =3D [
>      'metric_name', 'metric_group', 'metric_expr', 'metric_threshold',
> @@ -58,7 +71,9 @@ _json_metric_attributes =3D [
>      'default_metricgroup_name', 'aggr_mode', 'event_grouping'
>  ]
>  # Attributes that are bools or enum int values, encoded as '0', '1',...
> -_json_enum_attributes =3D ['aggr_mode', 'deprecated', 'event_grouping', =
'perpkg']
> +_json_enum_attributes =3D ['aggr_mode', 'deprecated', 'event_grouping', =
'perpkg',
> +    'num_counters', 'num_fixed_counters'
> +]
>
>  def removesuffix(s: str, suffix: str) -> str:
>    """Remove the suffix from a string
> @@ -334,6 +349,12 @@ class JsonEvent:
>      if 'Errata' in jd:
>        extra_desc +=3D '  Spec update: ' + jd['Errata']
>      self.pmu =3D unit_to_pmu(jd.get('Unit'))
> +    # The list of counter(s) the event could be collected with
> +    self.counters =3D jd.get('Counter')
> +    # Number of generic counter
> +    self.num_counters =3D jd.get('NumCounters')
> +    # Number of fixed counter
> +    self.num_fixed_counters =3D jd.get('NumFixedCounters')

I'm not a fan of counters vs fixed_counters, perhaps in the python:

self.counters['generic'].list =3D jd.get('Counter')
self.counters['generic'].num =3D jd.get('NumCounters')
self.counters['fixed'].num =3D jd.get('NumFixedCounters')

Would make things a bit more intention revealing. Fwiw, the json name
is worse as Counter is really for a plural of things. I don't think we
can update this in the Intel perfmon events, but maybe we can do it in
the create_perf_json.py converter script and its generated json.

This is pretty trivial as clean up so I'd prefer it before my
Reviewed-by unless there's something I'm overlooking.

Thanks,
Ian

>      filter =3D jd.get('Filter')
>      self.unit =3D jd.get('ScaleUnit')
>      self.perpkg =3D jd.get('PerPkg')
> @@ -405,8 +426,16 @@ class JsonEvent:
>          s +=3D f'\t{attr} =3D {value},\n'
>      return s + '}'
>
> -  def build_c_string(self, metric: bool) -> str:
> +  def build_c_string(self, metric: bool, layout: bool) -> str:
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
> @@ -421,10 +450,10 @@ class JsonEvent:
>          s +=3D f'{x}\\000' if x else '\\000'
>      return s
>
> -  def to_c_string(self, metric: bool) -> str:
> +  def to_c_string(self, metric: bool, layout: bool) -> str:
>      """Representation of the event as a C struct initializer."""
>
> -    s =3D self.build_c_string(metric)
> +    s =3D self.build_c_string(metric, layout)
>      return f'{{ { _bcs.offsets[s] } }}, /* {s} */\n'
>
>
> @@ -461,6 +490,8 @@ def preprocess_arch_std_files(archpath: str) -> None:
>            _arch_std_events[event.name.lower()] =3D event
>          if event.metric_name:
>            _arch_std_events[event.metric_name.lower()] =3D event
> +        if event.num_counters:
> +          _arch_std_events[event.pmu.lower()] =3D event
>
>
>  def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
> @@ -470,6 +501,8 @@ def add_events_table_entries(item: os.DirEntry, topic=
: str) -> None:
>        _pending_events.append(e)
>      if e.metric_name:
>        _pending_metrics.append(e)
> +    if e.num_counters:
> +      _pending_pmu_counts.append(e)
>
>
>  def print_pending_events() -> None:
> @@ -510,7 +543,7 @@ def print_pending_events() -> None:
>        last_pmu =3D event.pmu
>        pmus.add((event.pmu, pmu_name))
>
> -    _args.output_file.write(event.to_c_string(metric=3DFalse))
> +    _args.output_file.write(event.to_c_string(metric=3DFalse, layout=3DF=
alse))
>    _pending_events =3D []
>
>    _args.output_file.write(f"""
> @@ -565,7 +598,7 @@ def print_pending_metrics() -> None:
>        last_pmu =3D metric.pmu
>        pmus.add((metric.pmu, pmu_name))
>
> -    _args.output_file.write(metric.to_c_string(metric=3DTrue))
> +    _args.output_file.write(metric.to_c_string(metric=3DTrue, layout=3DF=
alse))
>    _pending_metrics =3D []
>
>    _args.output_file.write(f"""
> @@ -583,6 +616,35 @@ const struct pmu_table_entry {_pending_metrics_tblna=
me}[] =3D {{
>  """)
>    _args.output_file.write('};\n\n')
>
> +def print_pending_pmu_counter_layout_table() -> None:
> +  '''Print counter layout data from counter.json file to counter layout =
table in
> +    c-string'''
> +
> +  def pmu_counts_cmp_key(j: JsonEvent) -> Tuple[bool, str, str]:
> +    def fix_none(s: Optional[str]) -> str:
> +      if s is None:
> +        return ''
> +      return s
> +
> +    return (j.desc is not None, fix_none(j.pmu), fix_none(j.num_counters=
))
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
> @@ -619,10 +681,12 @@ def preprocess_one_file(parents: Sequence[str], ite=
m: os.DirEntry) -> None:
>      pmu_name =3D f"{event.pmu}\\000"
>      if event.name:
>        _bcs.add(pmu_name, metric=3DFalse)
> -      _bcs.add(event.build_c_string(metric=3DFalse), metric=3DFalse)
> +      _bcs.add(event.build_c_string(metric=3DFalse, layout=3DFalse), met=
ric=3DFalse)
>      if event.metric_name:
>        _bcs.add(pmu_name, metric=3DTrue)
> -      _bcs.add(event.build_c_string(metric=3DTrue), metric=3DTrue)
> +      _bcs.add(event.build_c_string(metric=3DTrue, layout=3DFalse), metr=
ic=3DTrue)
> +    if event.num_counters:
> +      _bcs.add(event.build_c_string(metric=3DFalse, layout=3DTrue), metr=
ic=3DFalse)
>
>  def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
>    """Process a JSON file during the main walk."""
> @@ -636,11 +700,14 @@ def process_one_file(parents: Sequence[str], item: =
os.DirEntry) -> None:
>    if item.is_dir() and is_leaf_dir(item.path):
>      print_pending_events()
>      print_pending_metrics()
> +    print_pending_pmu_counter_layout_table()
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
> @@ -674,6 +741,12 @@ struct pmu_metrics_table {
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
> @@ -687,6 +760,7 @@ struct pmu_events_map {
>          const char *cpuid;
>          struct pmu_events_table event_table;
>          struct pmu_metrics_table metric_table;
> +        struct pmu_layouts_table layout_table;
>  };
>
>  /*
> @@ -731,6 +805,12 @@ const struct pmu_events_map pmu_events_map[] =3D {
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
> @@ -742,6 +822,10 @@ const struct pmu_events_map pmu_events_map[] =3D {
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
> @@ -752,6 +836,7 @@ const struct pmu_events_map pmu_events_map[] =3D {
>  \t.cpuid =3D 0,
>  \t.event_table =3D { 0, 0 },
>  \t.metric_table =3D { 0, 0 },
> +\t.layout_table =3D { 0, 0 },
>  }
>  };
>  """)
> @@ -840,6 +925,24 @@ static void decompress_metric(int offset, struct pmu=
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
> @@ -995,6 +1098,21 @@ int pmu_metrics_table__for_each_metric(const struct=
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
> @@ -1090,6 +1208,33 @@ const struct pmu_metrics_table *perf_pmu__find_met=
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
> @@ -1111,6 +1256,16 @@ const struct pmu_metrics_table *find_core_metrics_=
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
> @@ -1139,6 +1294,19 @@ int pmu_for_each_core_metric(pmu_metric_iter_fn fn=
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
> @@ -1295,6 +1463,7 @@ struct pmu_table_entry {
>      ftw(arch_path, [], process_one_file)
>      print_pending_events()
>      print_pending_metrics()
> +    print_pending_pmu_counter_layout_table()
>
>    print_mapping_table(archs)
>    print_system_mapping_table()
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/p=
mu-events.h
> index f5aa96f1685c..e245e4738970 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -45,6 +45,11 @@ struct pmu_event {
>         const char *desc;
>         const char *topic;
>         const char *long_desc;
> +       /**
> +        * The list of counter(s) the event could be collected on.
> +        * eg., "0,1,2,3,4,5,6,7".
> +        */
> +       const char *counters;
>         const char *pmu;
>         const char *unit;
>         bool perpkg;
> @@ -67,8 +72,20 @@ struct pmu_metric {
>         enum metric_event_groups event_grouping;
>  };
>
> +struct pmu_layout {
> +       const char *pmu;
> +       const char *desc;
> +       /** Total number of generic counters*/
> +       int num_counters;
> +       /**
> +        * Total number of fixed counters.
> +        * Set to zero if no fixed counter on the unit.*/
> +       int num_fixed_counters;
> +};
> +
>  struct pmu_events_table;
>  struct pmu_metrics_table;
> +struct pmu_layouts_table;
>
>  typedef int (*pmu_event_iter_fn)(const struct pmu_event *pe,
>                                  const struct pmu_events_table *table,
> @@ -78,15 +95,21 @@ typedef int (*pmu_metric_iter_fn)(const struct pmu_me=
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
> +int pmu_layouts_table__for_each_layout(const struct pmu_layouts_table *t=
able,
> +                                       pmu_layout_iter_fn fn,
> +                                       void *data);
>  size_t pmu_events_table__num_events(const struct pmu_events_table *table=
,
>                                     struct perf_pmu *pmu);
>
> @@ -95,10 +118,13 @@ int pmu_metrics_table__for_each_metric(const struct =
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
> 2.42.0
>

