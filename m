Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142757D71F5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjJYRA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjJYRAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:00:54 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE98185;
        Wed, 25 Oct 2023 10:00:50 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-564af0ac494so9206a12.0;
        Wed, 25 Oct 2023 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698253250; x=1698858050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzSR5In4fR40gc6Nrvk8Uaxy++KNDgIqpKptmOCtfzQ=;
        b=KQOpts/5EI9PgTV0OQReCRZhdnM7xYjiGmGLk3BotCqJN5sAf1S9kTCdeviNpd4J7H
         5oY2suHs5rnFE8RRpSZalu9+LABfcE4/hVWyfuH4b2+aJ2L/qx/FlcgkYj6StNIjgaBs
         VB2uZjWCqePPEmDwWR/Ax8NftpEtC8KKcROcfro28epNrQKM82GMPbhwk9VFC5Ow6Ifk
         q8WDsGy3mOtfH7L6th5E+rYqGRR1a9qRkUDAeWAhm1MJcUGfimoDwhblNS3tZqwaXhZ7
         5a6YmgUzpAdz3gn95D8BVf5XquEJrAwu/AMXl5qrT1ez+iqCBSP+71ro56Kr1qqsTIov
         4HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698253250; x=1698858050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzSR5In4fR40gc6Nrvk8Uaxy++KNDgIqpKptmOCtfzQ=;
        b=CMs93FzjPZxlaYXXJVS/T1/VULDzEv3/WIGhKOlgZb9xdoE3uMm6AjIeMUuF9QfRV0
         UKXvIKCcccreTq28GcAAN4zKi9Rz0zNvBU+6rYSADzA7PDkabrIAK/KSW8ohOYwlprIQ
         Bc3r0cq83h5uH9WagC8h2oD9dvqn/UhlXI4977uqLIGw8FsXl2iOj/HiUBqXOJFuRCYE
         ePXaJl5wE5rOyCP5NU56pxqtx2UYip3wiaBC8/AL9V6h8bWirGSDLzIkvjLIHsjGvEP4
         Lo8XuQy018KZw+AWoEbnXHVgKu77X8Gvk8fnDC+3hlWamUfiOp7JS4nwE1WvAxhesLDy
         3wlg==
X-Gm-Message-State: AOJu0YxIzXBNq0xRtpZSxdTGHEuN+ejd4LJ25Ltug0ECwyu2lYaiF81L
        p2x6tYlCNi7b/ozgRE+R4by3FoTJgIyNuUuWDYo=
X-Google-Smtp-Source: AGHT+IFBeEjWTolpUeWDbtCnXhmEJl3tdiSiAhMrIb0EDKT9T0hgpS7jZITYbk22VdtHQdeyWeLx7Yna0ES+vbkEpT8=
X-Received: by 2002:a17:90b:30ca:b0:27d:3a3e:3a45 with SMTP id
 hi10-20020a17090b30ca00b0027d3a3e3a45mr12402526pjb.44.1698253249923; Wed, 25
 Oct 2023 10:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231024091729.4180034-1-tmricht@linux.ibm.com>
In-Reply-To: <20231024091729.4180034-1-tmricht@linux.ibm.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Wed, 25 Oct 2023 10:00:38 -0700
Message-ID: <CAM9d7cgzDrO-mU9A6twYqgZ1JFaU1Lj-RC+Lmz3gpxU7gFUr=g@mail.gmail.com>
Subject: Re: [PATCH] perf report: Add s390 raw data interpretation for PAI counters
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Oct 24, 2023 at 2:17=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> commit 1bf54f32f525 ("s390/pai: Add support for cryptography counters")
> added support for Processor Activity Instrumentation Facility (PAI)
> counters.  These counters values are added as raw data with the perf
> sample during perf record.
> Now add support to display these counters in perf report command.
> The counter number, its assigned name and value is now printed in
> addition to the hexadecimal output.
>
> Output before:
>  # perf report -D
>
>  6 514766399626050 0x7b058 [0x48]: PERF_RECORD_SAMPLE(IP, 0x1):
>                                 303977/303977: 0 period: 1 addr: 0
>  ... thread: paitest:303977
>  ...... dso: <not found>
>
>  0x7b0a0@/root/perf.data.paicrypto [0x48]: event: 9
>  .
>  . ... raw event: size 72 bytes
>  . 0000:  00 00 00 09 00 01 00 48 00 00 00 00 00 00 00 00  .......H......=
..
>  . 0010:  00 04 a3 69 00 04 a3 69 00 01 d4 2d 76 de a0 bb  ...i...i...-v.=
..
>  . 0020:  00 00 00 00 00 01 5c 53 00 00 00 06 00 00 00 00  ......\S......=
..
>  . 0030:  00 00 00 00 00 00 00 01 00 00 00 0c 00 07 00 00  ..............=
..
>  . 0040:  00 00 00 53 96 af 00 00                          ...S....
>
> Output after:
>  # perf report -D
>
>  6 514766399626050 0x7b058 [0x48]: PERF_RECORD_SAMPLE(IP, 0x1):
>                                 303977/303977: 0 period: 1 addr: 0
>  ... thread: paitest:303977
>  ...... dso: <not found>
>
>  0x7b0a0@/root/perf.data.paicrypto [0x48]: event: 9
>  .
>  . ... raw event: size 72 bytes
>  . 0000:  00 00 00 09 00 01 00 48 00 00 00 00 00 00 00 00  .......H......=
..
>  . 0010:  00 04 a3 69 00 04 a3 69 00 01 d4 2d 76 de a0 bb  ...i...i...-v.=
..
>  . 0020:  00 00 00 00 00 01 5c 53 00 00 00 06 00 00 00 00  ......\S......=
..
>  . 0030:  00 00 00 00 00 00 00 01 00 00 00 0c 00 07 00 00  ..............=
..
>  . 0040:  00 00 00 53 96 af 00 00                          ...S....
>
>         Counter:007 km_aes_128 Value:0x00000000005396af     <--- new
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/util/s390-cpumcf-kernel.h |  2 +
>  tools/perf/util/s390-sample-raw.c    | 89 ++++++++++++++++++++++++++--
>  2 files changed, 85 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/s390-cpumcf-kernel.h b/tools/perf/util/s390-=
cpumcf-kernel.h
> index f55ca07f3ca1..74b36644e384 100644
> --- a/tools/perf/util/s390-cpumcf-kernel.h
> +++ b/tools/perf/util/s390-cpumcf-kernel.h
> @@ -12,6 +12,8 @@
>  #define        S390_CPUMCF_DIAG_DEF    0xfeef  /* Counter diagnostic ent=
ry ID */
>  #define        PERF_EVENT_CPUM_CF_DIAG 0xBC000 /* Event: Counter sets */
>  #define PERF_EVENT_CPUM_SF_DIAG        0xBD000 /* Event: Combined-sampli=
ng */
> +#define PERF_EVENT_PAI_CRYPTO_ALL      0x1000 /* Event: CRYPTO_ALL */
> +#define PERF_EVENT_PAI_NNPA_ALL        0x1800 /* Event: NNPA_ALL */
>
>  struct cf_ctrset_entry {       /* CPU-M CF counter set entry (8 byte) */
>         unsigned int def:16;    /* 0-15  Data Entry Format */
> diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sam=
ple-raw.c
> index 115b16edb451..f360aed3bf0a 100644
> --- a/tools/perf/util/s390-sample-raw.c
> +++ b/tools/perf/util/s390-sample-raw.c
> @@ -125,6 +125,9 @@ static int get_counterset_start(int setnr)
>                 return 128;
>         case CPUMF_CTR_SET_MT_DIAG:             /* Diagnostic counter set=
 */
>                 return 448;
> +       case PERF_EVENT_PAI_NNPA_ALL:           /* PAI NNPA counter set *=
/
> +       case PERF_EVENT_PAI_CRYPTO_ALL:         /* PAI CRYPTO counter set=
 */
> +               return setnr;
>         default:
>                 return -1;
>         }
> @@ -212,27 +215,101 @@ static void s390_cpumcfdg_dump(struct perf_pmu *pm=
u, struct perf_sample *sample)
>         }
>  }
>
> +/*
> + * Check for consistency of PAI_CRYPTO/PAI_NNPA raw data.
> + */
> +struct pai_data {              /* Event number and value */
> +       u16 event_nr;
> +       u64 event_val;
> +} __packed;
> +
> +/*
> + * Test for valid raw data. At least one PAI event should be in the raw
> + * data section.
> + */
> +static bool s390_pai_all_test(struct perf_sample *sample)
> +{
> +       unsigned char *buf =3D sample->raw_data;
> +       size_t len =3D sample->raw_size;
> +
> +       if (len < 0xa || !buf)
> +               return false;
> +       return true;
> +}
> +
> +static void s390_pai_all_dump(struct evsel *evsel, struct perf_sample *s=
ample)
> +{
> +       size_t len =3D sample->raw_size, offset =3D 0;
> +       unsigned char *p =3D sample->raw_data;
> +       const char *color =3D PERF_COLOR_BLUE;
> +       struct pai_data pai_data;
> +       char *ev_name;
> +
> +       evsel->pmu =3D perf_pmus__find_by_type(evsel->core.attr.type);

Does it need to find evsel->pmu everytime?

Thanks,
Namhyung


> +       while (offset < len) {
> +               memcpy(&pai_data.event_nr, p, sizeof(pai_data.event_nr));
> +               pai_data.event_nr =3D be16_to_cpu(pai_data.event_nr);
> +               p +=3D sizeof(pai_data.event_nr);
> +               offset +=3D sizeof(pai_data.event_nr);
> +
> +               memcpy(&pai_data.event_val, p, sizeof(pai_data.event_val)=
);
> +               pai_data.event_val =3D be64_to_cpu(pai_data.event_val);
> +               p +=3D sizeof(pai_data.event_val);
> +               offset +=3D sizeof(pai_data.event_val);
> +
> +               ev_name =3D get_counter_name(evsel->core.attr.config,
> +                                          pai_data.event_nr, evsel->pmu)=
;
> +               color_fprintf(stdout, color, "\tCounter:%03d %s Value:%#0=
18lx\n",
> +                             pai_data.event_nr, ev_name ?: "<unknown>",
> +                             pai_data.event_val);
> +
> +               if (offset + 0xa > len)
> +                       break;
> +       }
> +       color_fprintf(stdout, color, "\n");
> +}
> +
>  /* S390 specific trace event function. Check for PERF_RECORD_SAMPLE even=
ts
>   * and if the event was triggered by a counter set diagnostic event disp=
lay
>   * its raw data.
>   * The function is only invoked when the dump flag -D is set.
>   */
> -void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *ev=
ent, struct perf_sample *sample)
> +void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *ev=
ent,
> +                            struct perf_sample *sample)
>  {
> +       const char *pai_name;
>         struct evsel *evsel;
>
>         if (event->header.type !=3D PERF_RECORD_SAMPLE)
>                 return;
>
>         evsel =3D evlist__event2evsel(evlist, event);
> -       if (evsel =3D=3D NULL ||
> -           evsel->core.attr.config !=3D PERF_EVENT_CPUM_CF_DIAG)
> +       if (evsel =3D=3D NULL)
>                 return;
>
>         /* Display raw data on screen */
> -       if (!s390_cpumcfdg_testctr(sample)) {
> -               pr_err("Invalid counter set data encountered\n");
> +       if (evsel->core.attr.config =3D=3D PERF_EVENT_CPUM_CF_DIAG) {
> +               evsel->pmu =3D perf_pmus__find("cpum_cf");
> +               if (!s390_cpumcfdg_testctr(sample))
> +                       pr_err("Invalid counter set data encountered\n");
> +               else
> +                       s390_cpumcfdg_dump(evsel->pmu, sample);
>                 return;
>         }
> -       s390_cpumcfdg_dump(evsel->pmu, sample);
> +
> +       switch (evsel->core.attr.config) {
> +       case PERF_EVENT_PAI_NNPA_ALL:
> +               pai_name =3D "NNPA_ALL";
> +               break;
> +       case PERF_EVENT_PAI_CRYPTO_ALL:
> +               pai_name =3D "CRYPTO_ALL";
> +               break;
> +       default:
> +               return;
> +       }
> +
> +       if (!s390_pai_all_test(sample))
> +               pr_err("Invalid %s raw data encountered\n", pai_name);
> +       else
> +               s390_pai_all_dump(evsel, sample);
>  }
> --
> 2.41.0
>
>
