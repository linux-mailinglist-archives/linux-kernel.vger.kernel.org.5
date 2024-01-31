Return-Path: <linux-kernel+bounces-45615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3264E84330A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30CE2844ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A97F5221;
	Wed, 31 Jan 2024 01:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="XL0aqdyC"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A0184F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706666227; cv=none; b=qANtS3ycQYzz+U7fzS1wzoScM9zwLSDU+aKi7IdjK+F4UBqUoAn7163icBXimyKIAUEEzcPKozQ4sDarQCedqBJuVIIgx8CZwK2Q1OAmtHo1ofwZp/pF/urv2zMpOdyDASLW3q40NgyMZFuYVgmvtpMpNAl1SY5Yje5yLOFCQuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706666227; c=relaxed/simple;
	bh=K/84cN/ps0As10kc8fbK5GDsfuU9GTJnRSP5dPCWViI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFG+16qbavB8iZ24cZmN6Ca3EP6wR9BLM8dwIpmMGsCb4F0X3LKpLtVmAD04Yj8Ja18bKs4Fu7F6bCiy+uXZvlNpvlORhdmGDjTpTl2ULONLqOozBAuskPmaQm/oxcPOdQxlrv7RuBZezbSaaf041dlQhvCscUvDXd6qP0KTGhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XL0aqdyC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d5ce88b51cso109185ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706666224; x=1707271024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAeraVxqEPQ74pgtGcNwk5LoLGlOeH0PBTBF1iwNrUI=;
        b=XL0aqdyC2UXOxYZTNeNuw7AVv5yUsT5xNrenpCpMbK1YahyG1mspRiJAgD0eiz8va3
         wf3uQVto6JrhjKk2+JHIxH5tsAcr33UOVr0Wq5sfM2/smeeTOruGb947VsuA66Kd3fP8
         ZTzqDNfpWI4KH5jIE6qj4jM2OM3hXfngxzMvO7EBb4KOBYMVHFdt28jL/EY8Tn0c2oJa
         Cpb1B9berf283M+qPMeSGjaSr1eHcYsSzIC0p69aw39MKnMbRv4x8M7XLXWoDRJtwYR+
         p1IdriO5wuzABAQpwNBUWRaxVCd1ya2xpPr4y3Jw4eNPR+4i6U9yGDNL2767iyaFAYuI
         Kp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706666224; x=1707271024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAeraVxqEPQ74pgtGcNwk5LoLGlOeH0PBTBF1iwNrUI=;
        b=kNeb6ySUni2jBRYepxQ69zKYzKs3iufWjugPH/UtJBhYXtA4l8+IW2vx5ZIHyjY84U
         iWTzSseldSmE9EzHoN3HV9x79WrEKOR4Qif3inrh5c9bcnDsGcREx3mFcXL7Fo4ko6yy
         fAXpHAkDNoUFRw8EkGM2wTLemVeqQ3R+TJgSFcZ2ZnB/0Cs7RQbrgMbb9Y+RpVy9cSLr
         AwMOgrpM0jkgrLjnTAMbhDFERn4JbbjTB4swGl/3q7JPgZs4eRXl6ZJeGbFdATYBWSBw
         g90sznXNDnI8NEEdO6i3+WBzybguRcqqW4W/ZfACW9vAK1bvTnacWBxKEnzuR+Atsmug
         92qg==
X-Gm-Message-State: AOJu0YylujI8cnd12c3YUq33osO8ZLKoRak42zKRNcwqCMfITWQAuKMO
	tIM3gAoLrxX+8Djd55Cgk2DdRG+NZc2wAAkdj9IfA0tf8LIUF8H92TCh0Rq2lHHXz4P0HkOSgAr
	kGGSi7nIQ0b6fwHXcLCSITiB8Zum7OZrRSdrR
X-Google-Smtp-Source: AGHT+IF4QOCWXZJrrTIyw1Ie6cINcZgIwsESxfS3O7L3E0mEoKMVY0sXx5jldBAnLFCJ0PAlccU0oVl2VLBz1foFvJY=
X-Received: by 2002:a17:902:f54a:b0:1d4:ca8c:aa6d with SMTP id
 h10-20020a170902f54a00b001d4ca8caa6dmr432481plf.0.1706666223595; Tue, 30 Jan
 2024 17:57:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129101433.2429536-1-xu.yang_2@nxp.com> <20240129101433.2429536-4-xu.yang_2@nxp.com>
In-Reply-To: <20240129101433.2429536-4-xu.yang_2@nxp.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Jan 2024 17:56:52 -0800
Message-ID: <CAP-5=fXdw-xVb453tc7nBTQd5c_F83ZcctDykJ4+M9+jrVCJ5A@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] perf vendor events arm64:: Add i.MX95 DDR
 Performane Monitor metrics
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank.li@nxp.com, will@kernel.org, mark.rutland@arm.com, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org, 
	namhyung@kernel.org, linux-imx@nxp.com, mike.leach@linaro.org, 
	leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 2:08=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Add JSON metrics for i.MX95 DDR Performane Monitor.
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Changes in v2:
>  - fix wrong AXI_MASK setting
>  - remove unnecessary metrics
>  - add bandwidth_usage, camera_all, disp_all metrics
> Changes in v3:
>  - no changes
> ---
>  .../arch/arm64/freescale/imx95/sys/ddrc.json  |   9 +
>  .../arm64/freescale/imx95/sys/metrics.json    | 778 ++++++++++++++++++
>  tools/perf/pmu-events/jevents.py              |   1 +
>  3 files changed, 788 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/=
ddrc.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/=
metrics.json
>
> diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.js=
on b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
> new file mode 100644
> index 000000000000..4dc9d2968bdc
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
> @@ -0,0 +1,9 @@
> +[
> +   {
> +           "BriefDescription": "ddr cycles event",
> +           "EventCode": "0x00",
> +           "EventName": "imx95_ddr.cycles",
> +           "Unit": "imx9_ddr",
> +           "Compat": "imx95"
> +   }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics=
json b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
> new file mode 100644
> index 000000000000..2bfcd4d574a8
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
> @@ -0,0 +1,778 @@
> +[
> +       {
> +               "BriefDescription": "bandwidth usage for lpddr5 evk board=
",
> +               "MetricName": "imx95_bandwidth_usage.lpddr5",
> +               "MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,cou=
nter\\=3D5\\,axi_mask\\=3D0x000\\,axi_id\\=3D0x000@ + imx9_ddr0@eddrtq_pm_w=
r_beat_filt\\,counter\\=3D2\\,axi_mask\\=3D0x000\\,axi_id\\=3D0x000@ ) * 32=
 / duration_time) / (6400 * 1000000 * 4)",
> +               "ScaleUnit": "1e2%",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of all masters read from ddr",
> +               "MetricName": "imx95_ddr_read.all",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x000\\,axi_id\\=3D0x000@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of all masters write to ddr",
> +               "MetricName": "imx95_ddr_write.all",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x000\\,axi_id\\=3D0x000@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of all a55 read from ddr",
> +               "MetricName": "imx95_ddr_read.a55_all",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x3fc\\,axi_id\\=3D0x000@ + imx9_ddr0@eddrtq_pm_rd=
_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x3fe\\,axi_id\\=3D0x004@ ) * 32=
",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of all a55 write to ddr (part1=
)",
> +               "MetricName": "imx95_ddr_write.a55_all_1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3fc\\,axi_id\\=3D0x000@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of all a55 write to ddr (part2=
)",
> +               "MetricName": "imx95_ddr_write.a55_all_2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3fe\\,axi_id\\=3D0x004@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 0 read from ddr",
> +               "MetricName": "imx95_ddr_read.a55_0",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x3ff\\,axi_id\\=3D0x000@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 0 write to ddr",
> +               "MetricName": "imx95_ddr_write.a55_0",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3ff\\,axi_id\\=3D0x000@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 1 read from ddr",
> +               "MetricName": "imx95_ddr_read.a55_1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,coun=
ter\\=3D4\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x001@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 1 write to ddr",
> +               "MetricName": "imx95_ddr_write.a55_1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x001@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 2 read from ddr",
> +               "MetricName": "imx95_ddr_read.a55_2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,coun=
ter\\=3D3\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x002@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 2 write to ddr",
> +               "MetricName": "imx95_ddr_write.a55_2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x002@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 3 read from ddr",
> +               "MetricName": "imx95_ddr_read.a55_3",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x003@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 3 write to ddr",
> +               "MetricName": "imx95_ddr_write.a55_3",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x003@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 4 read from ddr",
> +               "MetricName": "imx95_ddr_read.a55_4",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,coun=
ter\\=3D4\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x004@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 4 write to ddr",
> +               "MetricName": "imx95_ddr_write.a55_4",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x004@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 5 read from ddr",
> +               "MetricName": "imx95_ddr_read.a55_5",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,coun=
ter\\=3D3\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x005@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 5 write to ddr",
> +               "MetricName": "imx95_ddr_write.a55_5",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x005@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP=
 transactions read from ddr",
> +               "MetricName": "imx95_ddr_read.cortexa_dsu_l3",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x007@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP=
 transactions write to ddr",
> +               "MetricName": "imx95_ddr_write.cortexa_dsu_l3",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x007@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of m33 read from ddr",
> +               "MetricName": "imx95_ddr_read.m33",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x008@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of m33 write to ddr",
> +               "MetricName": "imx95_ddr_write.m33",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x008@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of m7 read from ddr",
> +               "MetricName": "imx95_ddr_read.m7",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,coun=
ter\\=3D4\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x009@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of m7 write to ddr",
> +               "MetricName": "imx95_ddr_write.m7",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x009@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of sentinel read from ddr",
> +               "MetricName": "imx95_ddr_read.sentinel",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,coun=
ter\\=3D3\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x00a@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of sentinel write to ddr",
> +               "MetricName": "imx95_ddr_write.sentinel",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x00a@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of edma1 read from ddr",
> +               "MetricName": "imx95_ddr_read.edma1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x00b@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of edma1 write to ddr",
> +               "MetricName": "imx95_ddr_write.edma1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x00b@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of edma2 read from ddr",
> +               "MetricName": "imx95_ddr_read.edma2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,coun=
ter\\=3D4\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x00c@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of edma2 write to ddr",
> +               "MetricName": "imx95_ddr_write.edma2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x00c@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of netc read from ddr",
> +               "MetricName": "imx95_ddr_read.netc",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,coun=
ter\\=3D3\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x00d@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of netc write to ddr",
> +               "MetricName": "imx95_ddr_write.netc",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x00d@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of npu read from ddr",
> +               "MetricName": "imx95_ddr_read.npu",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x010@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of npu write to ddr",
> +               "MetricName": "imx95_ddr_write.npu",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x010@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of gpu read from ddr",
> +               "MetricName": "imx95_ddr_read.gpu",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,coun=
ter\\=3D4\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x020@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of gpu write to ddr",
> +               "MetricName": "imx95_ddr_write.gpu",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x020@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of usdhc1 read from ddr",
> +               "MetricName": "imx95_ddr_read.usdhc1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,coun=
ter\\=3D3\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x0b0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of usdhc1 write to ddr",
> +               "MetricName": "imx95_ddr_write.usdhc1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x0b0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of usdhc2 read from ddr",
> +               "MetricName": "imx95_ddr_read.usdhc2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x0c0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of usdhc2 write to ddr",
> +               "MetricName": "imx95_ddr_write.usdhc2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x0c0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of usdhc3 read from ddr",
> +               "MetricName": "imx95_ddr_read.usdhc3",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,coun=
ter\\=3D4\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x0d0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of usdhc3 write to ddr",
> +               "MetricName": "imx95_ddr_write.usdhc3",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x0d0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of xspi read from ddr",
> +               "MetricName": "imx95_ddr_read.xspi",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,coun=
ter\\=3D3\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x0f0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of xspi write to ddr",
> +               "MetricName": "imx95_ddr_write.xspi",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x0f0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of pcie1 read from ddr",
> +               "MetricName": "imx95_ddr_read.pcie1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x100@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of pcie1 write to ddr",
> +               "MetricName": "imx95_ddr_write.pcie1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x100@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of pcie2 read from ddr",
> +               "MetricName": "imx95_ddr_read.pcie2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,coun=
ter\\=3D4\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x006@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of pcie2 write to ddr",
> +               "MetricName": "imx95_ddr_write.pcie2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x00f\\,axi_id\\=3D0x006@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of pcie3 read from ddr",
> +               "MetricName": "imx95_ddr_read.pcie3",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,coun=
ter\\=3D3\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x120@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of pcie3 write to ddr",
> +               "MetricName": "imx95_ddr_write.pcie3",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x120@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of pcie4 read from ddr",
> +               "MetricName": "imx95_ddr_read.pcie4",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x130@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of pcie4 write to ddr",
> +               "MetricName": "imx95_ddr_write.pcie4",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x130@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of usb1 read from ddr",
> +               "MetricName": "imx95_ddr_read.usb1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,coun=
ter\\=3D4\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x140@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of usb1 write to ddr",
> +               "MetricName": "imx95_ddr_write.usb1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x140@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of usb2 read from ddr",
> +               "MetricName": "imx95_ddr_read.usb2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,coun=
ter\\=3D3\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x150@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of usb2 write to ddr",
> +               "MetricName": "imx95_ddr_write.usb2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x150@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of vpu codec primary bus read =
from ddr",
> +               "MetricName": "imx95_ddr_read.vpu_primy",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x180@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of vpu codec primary bus write=
 to ddr",
> +               "MetricName": "imx95_ddr_write.vpu_primy",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x180@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of vpu codec secondary bus rea=
d from ddr",
> +               "MetricName": "imx95_ddr_read.vpu_secndy",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,coun=
ter\\=3D4\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x190@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of vpu codec secondary bus wri=
te to ddr",
> +               "MetricName": "imx95_ddr_write.vpu_secndy",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x190@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of jpeg decoder read from ddr"=
,
> +               "MetricName": "imx95_ddr_read.jpeg_dec",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,coun=
ter\\=3D3\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x1a0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of jpeg decoder write to ddr",
> +               "MetricName": "imx95_ddr_write.jpeg_dec",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x1a0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of jpeg encoder read from ddr"=
,
> +               "MetricName": "imx95_ddr_read.jpeg_dec",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x1b0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of jpeg encoder write to ddr",
> +               "MetricName": "imx95_ddr_write.jpeg_enc",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x1b0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of all vpu submodules read fro=
m ddr",
> +               "MetricName": "imx95_ddr_read.vpu_all",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,coun=
ter\\=3D4\\,axi_mask\\=3D0x380\\,axi_id\\=3D0x180@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of all vpu submodules write to=
 ddr",
> +               "MetricName": "imx95_ddr_write.vpu_all",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x380\\,axi_id\\=3D0x180@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of cortex m0+ read from ddr",
> +               "MetricName": "imx95_ddr_read.m0",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,coun=
ter\\=3D3\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x200@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of cortex m0+ write to ddr",
> +               "MetricName": "imx95_ddr_write.m0",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x200@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of camera edma read from ddr",
> +               "MetricName": "imx95_ddr_read.camera_edma",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x210@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of camera edma write to ddr",
> +               "MetricName": "imx95_ddr_write.camera_edma",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x210@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of isi rd read from ddr",
> +               "MetricName": "imx95_ddr_read.isi_rd",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,coun=
ter\\=3D4\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x220@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of isi rd write to ddr",
> +               "MetricName": "imx95_ddr_write.isi_rd",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x220@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of isi wr y read from ddr",
> +               "MetricName": "imx95_ddr_read.isi_wr_y",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,coun=
ter\\=3D3\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x230@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of isi wr y write to ddr",
> +               "MetricName": "imx95_ddr_write.isi_wr_y",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x230@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of isi wr u read from ddr",
> +               "MetricName": "imx95_ddr_read.isi_wr_u",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x240@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of isi wr u write to ddr",
> +               "MetricName": "imx95_ddr_write.isi_wr_u",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x240@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of isi wr v read from ddr",
> +               "MetricName": "imx95_ddr_read.isi_wr_v",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,coun=
ter\\=3D4\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x250@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of isi wr v write to ddr",
> +               "MetricName": "imx95_ddr_write.isi_wr_v",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x250@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of isp input dma1 read from dd=
r",
> +               "MetricName": "imx95_ddr_read.isp_in_dma1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,coun=
ter\\=3D3\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x260@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of isp input dma1 write to ddr=
",
> +               "MetricName": "imx95_ddr_write.isp_in_dma1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x260@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of isp input dma2 read from dd=
r",
> +               "MetricName": "imx95_ddr_read.isp_in_dma2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x270@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of isp input dma2 write to ddr=
",
> +               "MetricName": "imx95_ddr_write.isp_in_dma2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x270@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of isp output dma1 read from d=
dr",
> +               "MetricName": "imx95_ddr_read.isp_out_dma1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,coun=
ter\\=3D4\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x280@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of isp output dma1 write to dd=
r",
> +               "MetricName": "imx95_ddr_write.isp_out_dma1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x280@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of isp output dma2 read from d=
dr",
> +               "MetricName": "imx95_ddr_read.isp_out_dma2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,coun=
ter\\=3D3\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x290@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of isp output dma2 write to dd=
r",
> +               "MetricName": "imx95_ddr_write.isp_out_dma2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x290@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of all camera submodules read =
from ddr",
> +               "MetricName": "imx95_ddr_read.camera_all",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x380\\,axi_id\\=3D0x200@ + imx9_ddr0@eddrtq_pm_rd=
_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x280@ + imx9=
_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3D3\\,axi_mask\\=3D0x3f0\\,axi_id=
\\=3D0x290@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of all camera submodules write=
 to ddr (part1)",
> +               "MetricName": "imx95_ddr_write.camera_all_1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x380\\,axi_id\\=3D0x200@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of all camera submodules write=
 to ddr (part2)",
> +               "MetricName": "imx95_ddr_write.camera_all_2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x280@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of all camera submodules write=
 to ddr (part3)",
> +               "MetricName": "imx95_ddr_write.camera_all_3",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x290@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of display blitter store read =
from ddr",
> +               "MetricName": "imx95_ddr_read.disp_blit",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x2a0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of display blitter write to dd=
r",
> +               "MetricName": "imx95_ddr_write.disp_blit",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x2a0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of display command sequencer r=
ead from ddr",
> +               "MetricName": "imx95_ddr_read.disp_cmd",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,coun=
ter\\=3D4\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x2b0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of display command sequencer w=
rite to ddr",
> +               "MetricName": "imx95_ddr_write.disp_cmd",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3f0\\,axi_id\\=3D0x2b0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of all display submodules read=
 from ddr",
> +               "MetricName": "imx95_ddr_read.disp_all",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,coun=
ter\\=3D5\\,axi_mask\\=3D0x300\\,axi_id\\=3D0x300@ + imx9_ddr0@eddrtq_pm_rd=
_beat_filt1\\,counter\\=3D4\\,axi_mask\\=3D0x3a0\\,axi_id\\=3D0x2a0@ ) * 32=
",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of all display submodules writ=
e to ddr (part1)",
> +               "MetricName": "imx95_ddr_write.disp_all_1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x300\\,axi_id\\=3D0x300@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       },
> +       {
> +               "BriefDescription": "bytes of all display submodules writ=
e to ddr (part2)",
> +               "MetricName": "imx95_ddr_write.disp_all_2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,count=
er\\=3D2\\,axi_mask\\=3D0x3a0\\,axi_id\\=3D0x2a0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx95"
> +       }
> +]
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 53ab050c8fa4..be4b541a0820 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -284,6 +284,7 @@ class JsonEvent:
>            'hisi_sccl,hha': 'hisi_sccl,hha',
>            'hisi_sccl,l3c': 'hisi_sccl,l3c',
>            'imx8_ddr': 'imx8_ddr',
> +          'imx9_ddr': 'imx9_ddr',
>            'L3PMC': 'amd_l3',
>            'DFPMC': 'amd_df',
>            'UMCPMC': 'amd_umc',
> --
> 2.34.1
>

