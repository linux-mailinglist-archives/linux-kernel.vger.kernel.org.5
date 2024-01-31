Return-Path: <linux-kernel+bounces-45609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237E28432FC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C47E1F26179
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBFE63A9;
	Wed, 31 Jan 2024 01:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="P5MurSmp"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B1063D8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706665719; cv=none; b=g59uUsJU6BeNQn2P4NfnvvvNJElvJQLpBFjHNBavg/oTB6FTsDgVunBV0vSt+MmA7ntwHNQ/gqTw9PiW3bkgb39Rup6n+C930HP93jI7+3Le8n0pDs8AoW1xkZYwQ3jIORmHaOSibeDhX8+WiSL+STBtJgu6rWMbTJ7eISzu584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706665719; c=relaxed/simple;
	bh=JarJS3bZjspurVZb8KA+0SRgpTC4wN80erlzrOZXAR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKWIAQpFNVo9M69QOkKMVVhyFNNuw/Zi2epLSccPxT55/vxGJO0A/ZWl7upQosA58FH+oUX11c9Yzve6KZThxb39q9t5aF7PHc4g/n3iV53DsZgWcjhMqswp1T+ijep2ebp2Fd5zuGHMg5TrNcRwXq1nZdbpYec8TVlrBXk8P+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5MurSmp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d89f0ab02bso31485ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706665716; x=1707270516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Daz8dG0g7MiTYRhAXRpcwovsA3py38xa0LOYlxNvKk=;
        b=P5MurSmpQ8clPAsaWVFx89k5uloz+S+mimKXasjUt6eaGyLtU8gREyoEbtsmTli2jV
         gBSYSn+LMcssiSioyQvj1m1+hN2v6GnCcsDhJ/yj44PAeZqe8S/FrMMbpA1zhlVAmBlf
         BPLMsjcY2i/oHpymPjVJ5Cx68ePcs79NIYhEFtkBQrQ15yWWKnEoxUrmCcQCGnjJG3d+
         ZNvBq2e6Vt5v8pq6VuRi61DEqbGls4ICxq5TH20FatNL+0GO7zEb8WNZSR1fMAKpkZaE
         yl4nXHd3UUSz2N4ZXA+6zvm0Ijuay92OoM1e/LI7TDWZ5eKjcA93AZdyO2MWFPkCUmP3
         gmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706665716; x=1707270516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Daz8dG0g7MiTYRhAXRpcwovsA3py38xa0LOYlxNvKk=;
        b=DR+Hx4MeYKz1qVhohjZb+Tt38cy05c0qF293eGkBJRr1tZcNH9To0AHMGFavay0NlW
         nhBLxiyubDSjtW13A81lvSJBV9AKL5kowPszIoBvv/RZ999KU4th7K1n/gF+95UsPXdt
         SP274TWQ779etlV6RvApo+h4fi4gCheG4z3DNJ4qtwPkkcBxQfIYpoDFRrhli5AZV+4Q
         +YySi5cHdEd8hNt9Ym3oQpmJcqgHbQYAGMNnmu+55ygNwLG0EGOM6EKQN57QbG9iQ8QI
         A/qciA7ocBmCYOWI9TKxaCL7J+2+Jg5S2aUuT2CYE80wFhtKg4rl0kSxhL4grI2d6EUu
         /PQg==
X-Gm-Message-State: AOJu0YwCDyL16pwmNKBAovXerU9HKVxh6Kd29CCccV/clMHq7Cp0mJt3
	Jldr7a5AvNAdaIyepAMZPXw5lPR9bLPV4+jOInPa+F96A+jWCnhxkjK7ndWoyHaeb/y13ZPzIo6
	PjJsFmeuadCufv7DLLHe9/JlVa5w52EWwmm8+
X-Google-Smtp-Source: AGHT+IEQMz3lE8pWi8Ryp9ldVLGSndr1j/JJmqwndAAtGeSvS9vGGRQ4B1xV2B0+nMXxArPmOIMTrDCsDvoSNBJENxI=
X-Received: by 2002:a17:902:fb43:b0:1d6:fa14:e9fe with SMTP id
 lf3-20020a170902fb4300b001d6fa14e9femr428365plb.8.1706665715856; Tue, 30 Jan
 2024 17:48:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130180907.639729-1-weilin.wang@intel.com>
In-Reply-To: <20240130180907.639729-1-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Jan 2024 17:48:24 -0800
Message-ID: <CAP-5=fXPxbj5bzTKvS6CLtmE62LYfTjpXPSp0+6DWqgR8CFG9A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] perf test: Simplify metric value validation test
 final report
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 10:09=E2=80=AFAM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> The original test report was too complicated to read with information
> that not really useful. This new update simplify the report which should
> largely improve the readibility.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../tests/shell/lib/perf_metric_validation.py | 231 ++++++++++--------
>  tools/perf/tests/shell/stat_metrics_values.sh |   4 +-
>  2 files changed, 127 insertions(+), 108 deletions(-)
>
> diff --git a/tools/perf/tests/shell/lib/perf_metric_validation.py b/tools=
/perf/tests/shell/lib/perf_metric_validation.py
> index 50a34a9cc040..a2d235252183 100644
> --- a/tools/perf/tests/shell/lib/perf_metric_validation.py
> +++ b/tools/perf/tests/shell/lib/perf_metric_validation.py
> @@ -1,4 +1,4 @@
> -#SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: GPL-2.0
>  import re
>  import csv
>  import json
> @@ -6,36 +6,61 @@ import argparse
>  from pathlib import Path
>  import subprocess
>
> +
> +class TestError:
> +    def __init__(self, metric: list[str], wl: str, value: list[float], l=
ow: float, up=3Dfloat('nan'), description=3Dstr()):
> +        self.metric: list =3D metric  # multiple metrics in relationship=
 type tests
> +        self.workloads =3D [wl]  # multiple workloads possible
> +        self.collectedValue: list =3D value
> +        self.valueLowBound =3D low
> +        self.valueUpBound =3D up
> +        self.description =3D description
> +
> +    def __repr__(self) -> str:
> +        if len(self.metric) > 1:
> +            return "\nMetric Relationship Error: \tThe collected value o=
f metric {0}\n\
> +                \tis {1} in workload(s): {2} \n\
> +                \tbut expected value range is [{3}, {4}]\n\
> +                \tRelationship rule description: \'{5}\'".format(self.me=
tric, self.collectedValue, self.workloads,
> +                                                                 self.va=
lueLowBound, self.valueUpBound, self.description)
> +        elif len(self.collectedValue) =3D=3D 0:
> +            return "\nNo Metric Value Error: \tMetric {0} returns with n=
o value \n\
> +                    \tworkload(s): {1}".format(self.metric, self.workloa=
ds)
> +        else:
> +            return "\nWrong Metric Value Error: \tThe collected value of=
 metric {0}\n\
> +                    \tis {1} in workload(s): {2}\n\
> +                    \tbut expected value range is [{3}, {4}]"\
> +                        .format(self.metric, self.collectedValue, self.w=
orkloads,
> +                                self.valueLowBound, self.valueUpBound)
> +
> +
>  class Validator:
>      def __init__(self, rulefname, reportfname=3D'', t=3D5, debug=3DFalse=
, datafname=3D'', fullrulefname=3D'', workload=3D'true', metrics=3D''):
>          self.rulefname =3D rulefname
>          self.reportfname =3D reportfname
>          self.rules =3D None
> -        self.collectlist:str =3D metrics
> +        self.collectlist: str =3D metrics
>          self.metrics =3D self.__set_metrics(metrics)
>          self.skiplist =3D set()
>          self.tolerance =3D t
>
>          self.workloads =3D [x for x in workload.split(",") if x]
> -        self.wlidx =3D 0 # idx of current workloads
> -        self.allresults =3D dict() # metric results of all workload
> -        self.allignoremetrics =3D dict() # metrics with no results or ne=
gative results
> -        self.allfailtests =3D dict()
> +        self.wlidx =3D 0  # idx of current workloads
> +        self.allresults =3D dict()  # metric results of all workload
>          self.alltotalcnt =3D dict()
>          self.allpassedcnt =3D dict()
> -        self.allerrlist =3D dict()
>
> -        self.results =3D dict() # metric results of current workload
> +        self.results =3D dict()  # metric results of current workload
>          # vars for test pass/failure statistics
> -        self.ignoremetrics=3D set() # metrics with no results or negativ=
e results, neg result counts as a failed test
> -        self.failtests =3D dict()
> +        # metrics with no results or negative results, neg result counts=
 failed tests
> +        self.ignoremetrics =3D set()
>          self.totalcnt =3D 0
>          self.passedcnt =3D 0
>          # vars for errors
>          self.errlist =3D list()
>
>          # vars for Rule Generator
> -        self.pctgmetrics =3D set() # Percentage rule
> +        self.pctgmetrics =3D set()  # Percentage rule
>
>          # vars for debug
>          self.datafname =3D datafname
> @@ -69,10 +94,10 @@ class Validator:
>                        ensure_ascii=3DTrue,
>                        indent=3D4)
>
> -    def get_results(self, idx:int =3D 0):
> +    def get_results(self, idx: int =3D 0):
>          return self.results[idx]
>
> -    def get_bounds(self, lb, ub, error, alias=3D{}, ridx:int =3D 0) -> l=
ist:
> +    def get_bounds(self, lb, ub, error, alias=3D{}, ridx: int =3D 0) -> =
list:
>          """
>          Get bounds and tolerance from lb, ub, and error.
>          If missing lb, use 0.0; missing ub, use float('inf); missing err=
or, use self.tolerance.
> @@ -85,7 +110,7 @@ class Validator:
>                    tolerance, denormalized base on upper bound value
>          """
>          # init ubv and lbv to invalid values
> -        def get_bound_value (bound, initval, ridx):
> +        def get_bound_value(bound, initval, ridx):
>              val =3D initval
>              if isinstance(bound, int) or isinstance(bound, float):
>                  val =3D bound
> @@ -113,10 +138,10 @@ class Validator:
>
>          return lbv, ubv, denormerr
>
> -    def get_value(self, name:str, ridx:int =3D 0) -> list:
> +    def get_value(self, name: str, ridx: int =3D 0) -> list:
>          """
>          Get value of the metric from self.results.
> -        If result of this metric is not provided, the metric name will b=
e added into self.ignoremetics and self.errlist.
> +        If result of this metric is not provided, the metric name will b=
e added into self.ignoremetics.
>          All future test(s) on this metric will fail.
>
>          @param name: name of the metric
> @@ -142,7 +167,7 @@ class Validator:
>          Check if metrics value are non-negative.
>          One metric is counted as one test.
>          Failure: when metric value is negative or not provided.
> -        Metrics with negative value will be added into the self.failtest=
s['PositiveValueTest'] and self.ignoremetrics.
> +        Metrics with negative value will be added into self.ignoremetric=
s.
>          """
>          negmetric =3D dict()
>          pcnt =3D 0
> @@ -155,25 +180,27 @@ class Validator:
>              else:
>                  pcnt +=3D 1
>              tcnt +=3D 1
> +        # The first round collect_perf() run these metrics with simple w=
orkload
> +        # "true". We give metrics a second chance with a longer workload=
 if less
> +        # than 20 metrics failed positive test.
>          if len(rerun) > 0 and len(rerun) < 20:
>              second_results =3D dict()
>              self.second_test(rerun, second_results)
>              for name, val in second_results.items():
> -                if name not in negmetric: continue
> +                if name not in negmetric:
> +                    continue
>                  if val >=3D 0:
>                      del negmetric[name]
>                      pcnt +=3D 1
>
> -        self.failtests['PositiveValueTest']['Total Tests'] =3D tcnt
> -        self.failtests['PositiveValueTest']['Passed Tests'] =3D pcnt
>          if len(negmetric.keys()):
>              self.ignoremetrics.update(negmetric.keys())
> -            negmessage =3D ["{0}(=3D{1:.4f})".format(name, val) for name=
, val in negmetric.items()]
> -            self.failtests['PositiveValueTest']['Failed Tests'].append({=
'NegativeValue': negmessage})
> +            self.errlist.extend(
> +                [TestError([m], self.workloads[self.wlidx], negmetric[m]=
, 0) for m in negmetric.keys()])
>
>          return
>
> -    def evaluate_formula(self, formula:str, alias:dict, ridx:int =3D 0):
> +    def evaluate_formula(self, formula: str, alias: dict, ridx: int =3D =
0):
>          """
>          Evaluate the value of formula.
>
> @@ -187,10 +214,11 @@ class Validator:
>          sign =3D "+"
>          f =3D str()
>
> -        #TODO: support parenthesis?
> +        # TODO: support parenthesis?
>          for i in range(len(formula)):
>              if i+1 =3D=3D len(formula) or formula[i] in ('+', '-', '*', =
'/'):
> -                s =3D alias[formula[b:i]] if i+1 < len(formula) else ali=
as[formula[b:]]
> +                s =3D alias[formula[b:i]] if i + \
> +                    1 < len(formula) else alias[formula[b:]]
>                  v =3D self.get_value(s, ridx)
>                  if not v:
>                      errs.append(s)
> @@ -228,49 +256,49 @@ class Validator:
>          alias =3D dict()
>          for m in rule['Metrics']:
>              alias[m['Alias']] =3D m['Name']
> -        lbv, ubv, t =3D self.get_bounds(rule['RangeLower'], rule['RangeU=
pper'], rule['ErrorThreshold'], alias, ridx=3Drule['RuleIndex'])
> -        val, f =3D self.evaluate_formula(rule['Formula'], alias, ridx=3D=
rule['RuleIndex'])
> +        lbv, ubv, t =3D self.get_bounds(
> +            rule['RangeLower'], rule['RangeUpper'], rule['ErrorThreshold=
'], alias, ridx=3Drule['RuleIndex'])
> +        val, f =3D self.evaluate_formula(
> +            rule['Formula'], alias, ridx=3Drule['RuleIndex'])
> +
> +        lb =3D rule['RangeLower']
> +        ub =3D rule['RangeUpper']
> +        if isinstance(lb, str):
> +            if lb in alias:
> +                lb =3D alias[lb]
> +        if isinstance(ub, str):
> +            if ub in alias:
> +                ub =3D alias[ub]
> +
>          if val =3D=3D -1:
> -            self.failtests['RelationshipTest']['Failed Tests'].append({'=
RuleIndex': rule['RuleIndex'], 'Description':f})
> +            self.errlist.append(TestError([m['Name'] for m in rule['Metr=
ics']], self.workloads[self.wlidx], [],
> +                                lb, ub, rule['Description']))
>          elif not self.check_bound(val, lbv, ubv, t):
> -            lb =3D rule['RangeLower']
> -            ub =3D rule['RangeUpper']
> -            if isinstance(lb, str):
> -                if lb in alias:
> -                    lb =3D alias[lb]
> -            if isinstance(ub, str):
> -                if ub in alias:
> -                    ub =3D alias[ub]
> -            self.failtests['RelationshipTest']['Failed Tests'].append({'=
RuleIndex': rule['RuleIndex'], 'Formula':f,
> -                                                                       '=
RangeLower': lb, 'LowerBoundValue': self.get_value(lb),
> -                                                                       '=
RangeUpper': ub, 'UpperBoundValue':self.get_value(ub),
> -                                                                       '=
ErrorThreshold': t, 'CollectedValue': val})
> +            self.errlist.append(TestError([m['Name'] for m in rule['Metr=
ics']], self.workloads[self.wlidx], [val],
> +                                lb, ub, rule['Description']))
>          else:
>              self.passedcnt +=3D 1
> -            self.failtests['RelationshipTest']['Passed Tests'] +=3D 1
>          self.totalcnt +=3D 1
> -        self.failtests['RelationshipTest']['Total Tests'] +=3D 1
>
>          return
>
> -
>      # Single Metric Test
> -    def single_test(self, rule:dict):
> +    def single_test(self, rule: dict):
>          """
>          Validate if the metrics are in the required value range.
>          eg. lower_bound <=3D metrics_value <=3D upper_bound
>          One metric is counted as one test in this type of test.
>          One rule may include one or more metrics.
>          Failure: when the metric value not provided or the value is outs=
ide the bounds.
> -        This test updates self.total_cnt and records failed tests in sel=
f.failtest['SingleMetricTest'].
> +        This test updates self.total_cnt.
>
>          @param rule: dict with metrics to validate and the value range r=
equirement
>          """
> -        lbv, ubv, t =3D self.get_bounds(rule['RangeLower'], rule['RangeU=
pper'], rule['ErrorThreshold'])
> +        lbv, ubv, t =3D self.get_bounds(
> +            rule['RangeLower'], rule['RangeUpper'], rule['ErrorThreshold=
'])
>          metrics =3D rule['Metrics']
>          passcnt =3D 0
>          totalcnt =3D 0
> -        faillist =3D list()
>          failures =3D dict()
>          rerun =3D list()
>          for m in metrics:
> @@ -286,25 +314,20 @@ class Validator:
>              second_results =3D dict()
>              self.second_test(rerun, second_results)
>              for name, val in second_results.items():
> -                if name not in failures: continue
> +                if name not in failures:
> +                    continue
>                  if self.check_bound(val, lbv, ubv, t):
>                      passcnt +=3D 1
>                      del failures[name]
>                  else:
> -                    failures[name] =3D val
> +                    failures[name] =3D [val]
>                      self.results[0][name] =3D val
>
>          self.totalcnt +=3D totalcnt
>          self.passedcnt +=3D passcnt
> -        self.failtests['SingleMetricTest']['Total Tests'] +=3D totalcnt
> -        self.failtests['SingleMetricTest']['Passed Tests'] +=3D passcnt
>          if len(failures.keys()) !=3D 0:
> -            faillist =3D [{'MetricName':name, 'CollectedValue':val} for =
name, val in failures.items()]
> -            self.failtests['SingleMetricTest']['Failed Tests'].append({'=
RuleIndex':rule['RuleIndex'],
> -                                                                       '=
RangeLower': rule['RangeLower'],
> -                                                                       '=
RangeUpper': rule['RangeUpper'],
> -                                                                       '=
ErrorThreshold':rule['ErrorThreshold'],
> -                                                                       '=
Failure':faillist})
> +            self.errlist.extend([TestError([name], self.workloads[self.w=
lidx], val,
> +                                rule['RangeLower'], rule['RangeUpper']) =
for name, val in failures.items()])
>
>          return
>
> @@ -312,19 +335,11 @@ class Validator:
>          """
>          Create final report and write into a JSON file.
>          """
> -        alldata =3D list()
> -        for i in range(0, len(self.workloads)):
> -            reportstas =3D {"Total Rule Count": self.alltotalcnt[i], "Pa=
ssed Rule Count": self.allpassedcnt[i]}
> -            data =3D {"Metric Validation Statistics": reportstas, "Tests=
 in Category": self.allfailtests[i],
> -                    "Errors":self.allerrlist[i]}
> -            alldata.append({"Workload": self.workloads[i], "Report": dat=
a})
> -
> -        json_str =3D json.dumps(alldata, indent=3D4)
> -        print("Test validation finished. Final report: ")
> -        print(json_str)
> +        print(self.errlist)
>
>          if self.debug:
> -            allres =3D [{"Workload": self.workloads[i], "Results": self.=
allresults[i]} for i in range(0, len(self.workloads))]
> +            allres =3D [{"Workload": self.workloads[i], "Results": self.=
allresults[i]}
> +                      for i in range(0, len(self.workloads))]
>              self.json_dump(allres, self.datafname)
>
>      def check_rule(self, testtype, metric_list):
> @@ -342,13 +357,13 @@ class Validator:
>          return True
>
>      # Start of Collector and Converter
> -    def convert(self, data: list, metricvalues:dict):
> +    def convert(self, data: list, metricvalues: dict):
>          """
>          Convert collected metric data from the -j output to dict of {met=
ric_name:value}.
>          """
>          for json_string in data:
>              try:
> -                result =3Djson.loads(json_string)
> +                result =3D json.loads(json_string)
>                  if "metric-unit" in result and result["metric-unit"] !=
=3D "(null)" and result["metric-unit"] !=3D "":
>                      name =3D result["metric-unit"].split("  ")[1] if len=
(result["metric-unit"].split("  ")) > 1 \
>                          else result["metric-unit"]
> @@ -365,9 +380,10 @@ class Validator:
>          print(" ".join(command))
>          cmd =3D subprocess.run(command, stderr=3Dsubprocess.PIPE, encodi=
ng=3D'utf-8')
>          data =3D [x+'}' for x in cmd.stderr.split('}\n') if x]
> +        if data[0][0] !=3D '{':
> +            data[0] =3D data[0][data[0].find('{'):]
>          return data
>
> -
>      def collect_perf(self, workload: str):
>          """
>          Collect metric data with "perf stat -M" on given workload with -=
a and -j.
> @@ -385,14 +401,18 @@ class Validator:
>              if rule["TestType"] =3D=3D "RelationshipTest":
>                  metrics =3D [m["Name"] for m in rule["Metrics"]]
>                  if not any(m not in collectlist[0] for m in metrics):
> -                    collectlist[rule["RuleIndex"]] =3D [",".join(list(se=
t(metrics)))]
> +                    collectlist[rule["RuleIndex"]] =3D [
> +                        ",".join(list(set(metrics)))]
>
>          for idx, metrics in collectlist.items():
> -            if idx =3D=3D 0: wl =3D "true"
> -            else: wl =3D workload
> +            if idx =3D=3D 0:
> +                wl =3D "true"
> +            else:
> +                wl =3D workload
>              for metric in metrics:
>                  data =3D self._run_perf(metric, wl)
> -                if idx not in self.results: self.results[idx] =3D dict()
> +                if idx not in self.results:
> +                    self.results[idx] =3D dict()
>                  self.convert(data, self.results[idx])
>          return
>
> @@ -412,7 +432,8 @@ class Validator:
>          2) create metric name list
>          """
>          command =3D ['perf', 'list', '-j', '--details', 'metrics']
> -        cmd =3D subprocess.run(command, stdout=3Dsubprocess.PIPE, stderr=
=3Dsubprocess.PIPE, encoding=3D'utf-8')
> +        cmd =3D subprocess.run(command, stdout=3Dsubprocess.PIPE,
> +                             stderr=3Dsubprocess.PIPE, encoding=3D'utf-8=
')
>          try:
>              data =3D json.loads(cmd.stdout)
>              for m in data:
> @@ -453,12 +474,12 @@ class Validator:
>          rules =3D data['RelationshipRules']
>          self.skiplist =3D set([name.lower() for name in data['SkipList']=
])
>          self.rules =3D self.remove_unsupported_rules(rules)
> -        pctgrule =3D {'RuleIndex':0,
> -                    'TestType':'SingleMetricTest',
> -                    'RangeLower':'0',
> +        pctgrule =3D {'RuleIndex': 0,
> +                    'TestType': 'SingleMetricTest',
> +                    'RangeLower': '0',
>                      'RangeUpper': '100',
>                      'ErrorThreshold': self.tolerance,
> -                    'Description':'Metrics in percent unit have value wi=
th in [0, 100]',
> +                    'Description': 'Metrics in percent unit have value w=
ith in [0, 100]',
>                      'Metrics': [{'Name': m.lower()} for m in self.pctgme=
trics]}
>          self.rules.append(pctgrule)
>
> @@ -469,8 +490,9 @@ class Validator:
>              idx +=3D 1
>
>          if self.debug:
> -            #TODO: need to test and generate file name correctly
> -            data =3D {'RelationshipRules':self.rules, 'SupportedMetrics'=
: [{"MetricName": name} for name in self.metrics]}
> +            # TODO: need to test and generate file name correctly
> +            data =3D {'RelationshipRules': self.rules, 'SupportedMetrics=
': [
> +                {"MetricName": name} for name in self.metrics]}
>              self.json_dump(data, self.fullrulefname)
>
>          return
> @@ -482,20 +504,17 @@ class Validator:
>          @param key: key to the dictionaries (index of self.workloads).
>          '''
>          self.allresults[key] =3D self.results
> -        self.allignoremetrics[key] =3D self.ignoremetrics
> -        self.allfailtests[key] =3D self.failtests
>          self.alltotalcnt[key] =3D self.totalcnt
>          self.allpassedcnt[key] =3D self.passedcnt
> -        self.allerrlist[key] =3D self.errlist
>
> -    #Initialize data structures before data validation of each workload
> +    # Initialize data structures before data validation of each workload
>      def _init_data(self):
>
> -        testtypes =3D ['PositiveValueTest', 'RelationshipTest', 'SingleM=
etricTest']
> +        testtypes =3D ['PositiveValueTest',
> +                     'RelationshipTest', 'SingleMetricTest']
>          self.results =3D dict()
> -        self.ignoremetrics=3D set()
> +        self.ignoremetrics =3D set()
>          self.errlist =3D list()
> -        self.failtests =3D {k:{'Total Tests':0, 'Passed Tests':0, 'Faile=
d Tests':[]} for k in testtypes}
>          self.totalcnt =3D 0
>          self.passedcnt =3D 0
>
> @@ -525,32 +544,33 @@ class Validator:
>                  testtype =3D r['TestType']
>                  if not self.check_rule(testtype, r['Metrics']):
>                      continue
> -                if  testtype =3D=3D 'RelationshipTest':
> +                if testtype =3D=3D 'RelationshipTest':
>                      self.relationship_test(r)
>                  elif testtype =3D=3D 'SingleMetricTest':
>                      self.single_test(r)
>                  else:
>                      print("Unsupported Test Type: ", testtype)
> -                    self.errlist.append("Unsupported Test Type from rule=
: " + r['RuleIndex'])
> -            self._storewldata(i)
>              print("Workload: ", self.workloads[i])
> -            print("Total metrics collected: ", self.failtests['PositiveV=
alueTest']['Total Tests'])
> -            print("Non-negative metric count: ", self.failtests['Positiv=
eValueTest']['Passed Tests'])
>              print("Total Test Count: ", self.totalcnt)
>              print("Passed Test Count: ", self.passedcnt)
> -
> +            self._storewldata(i)
>          self.create_report()
> -        return sum(self.alltotalcnt.values()) !=3D sum(self.allpassedcnt=
values())
> +        return len(self.errlist) > 0
>  # End of Class Validator
>
>
>  def main() -> None:
> -    parser =3D argparse.ArgumentParser(description=3D"Launch metric valu=
e validation")
> -
> -    parser.add_argument("-rule", help=3D"Base validation rule file", req=
uired=3DTrue)
> -    parser.add_argument("-output_dir", help=3D"Path for validator output=
 file, report file", required=3DTrue)
> -    parser.add_argument("-debug", help=3D"Debug run, save intermediate d=
ata to files", action=3D"store_true", default=3DFalse)
> -    parser.add_argument("-wl", help=3D"Workload to run while data collec=
tion", default=3D"true")
> +    parser =3D argparse.ArgumentParser(
> +        description=3D"Launch metric value validation")
> +
> +    parser.add_argument(
> +        "-rule", help=3D"Base validation rule file", required=3DTrue)
> +    parser.add_argument(
> +        "-output_dir", help=3D"Path for validator output file, report fi=
le", required=3DTrue)
> +    parser.add_argument("-debug", help=3D"Debug run, save intermediate d=
ata to files",
> +                        action=3D"store_true", default=3DFalse)
> +    parser.add_argument(
> +        "-wl", help=3D"Workload to run while data collection", default=
=3D"true")
>      parser.add_argument("-m", help=3D"Metric list to validate", default=
=3D"")
>      args =3D parser.parse_args()
>      outpath =3D Path(args.output_dir)
> @@ -559,8 +579,8 @@ def main() -> None:
>      datafile =3D Path.joinpath(outpath, 'perf_data.json')
>
>      validator =3D Validator(args.rule, reportf, debug=3Dargs.debug,
> -                        datafname=3Ddatafile, fullrulefname=3Dfullrule, =
workload=3Dargs.wl,
> -                        metrics=3Dargs.m)
> +                          datafname=3Ddatafile, fullrulefname=3Dfullrule=
, workload=3Dargs.wl,
> +                          metrics=3Dargs.m)
>      ret =3D validator.test()
>
>      return ret
> @@ -569,6 +589,3 @@ def main() -> None:
>  if __name__ =3D=3D "__main__":
>      import sys
>      sys.exit(main())
> -
> -
> -
> diff --git a/tools/perf/tests/shell/stat_metrics_values.sh b/tools/perf/t=
ests/shell/stat_metrics_values.sh
> index 7ca172599aa6..279f19c5919a 100755
> --- a/tools/perf/tests/shell/stat_metrics_values.sh
> +++ b/tools/perf/tests/shell/stat_metrics_values.sh
> @@ -19,6 +19,8 @@ echo "Output will be stored in: $tmpdir"
>  $PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir -wl "${work=
load}"
>  ret=3D$?
>  rm -rf $tmpdir
> -
> +if [ $ret -ne 0 ]; then
> +       echo "Metric validation return with erros. Please check metrics r=
eported with errors."
> +fi
>  exit $ret
>
> --
> 2.42.0
>

