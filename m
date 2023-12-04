Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ADE803960
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344430AbjLDQAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344542AbjLDQAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:00:43 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F20114
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:00:49 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b422a274dso111165e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701705647; x=1702310447; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Oek/9adewYrMTdVVCF3MHax10zoLd6vLDc2vCLCDhs=;
        b=Xt4utiirFq8QqDIpnruwm1Xd6DQdaPHBNDISvnywoXe0g7pF6USZjIU6FmM2j74LGK
         k8wPn60Xu3hlNnVfCRux80VaYPSQ1rj4J9WmcNHCT2Dw7+DyjsCSidIiZwoQ8bcetkyP
         vsRObfJUNbuVMBzt7Xpz63Cd2Ff8OjeOEPyCOWvOpx/dMovT06+oo5+75dQ4gD6NEm6y
         pKrFvV9m64Lff5kHvAe0qXQWiLiaAxWh5GNryb1K9Q51+KoKlm9LEH93Y8qPeQWwtAS+
         eeKiNW6x6vLPgh93p9dFuCylF2zuntQvKhNZY3NKwr2HrL1xCm4qZjOVgIKzawqInmpX
         AY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701705647; x=1702310447;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Oek/9adewYrMTdVVCF3MHax10zoLd6vLDc2vCLCDhs=;
        b=tCDHCVyimAHN4HY2uRu5II0/Ttwlmc5gBr3quwYXusYkQZwMEnflMoOViWVQBsJ3vO
         d1uRTBn8yd7HDdnC92ZGAC3olnAYATQ8Kx6xyilWxj64vCzy9eEgupwlBTGL+A3+IZnK
         dloR9/I7mKaf68ZMoiIAV+wfNKpxlR2faOLJBwSVFT40BK80Ov9RSEpJD8c6rpfmZnnD
         IOwKqcFE5YhcIJJnJwB8+TsPARVUu5ujsGiqbMIHchF7PJYQ1f2GFe2bvW5ZCscjDPA7
         fjJ5HOk7Z/zGGbQ8ltm206gsPl3jgGVT51ZFS2Yvr195Wl8xEQ2JOuncAiNtHeB1QUxZ
         fTrA==
X-Gm-Message-State: AOJu0YyXFgM2PtNQ0RTqHP1cME/kkJapw2KFIzbHSmZvqK7N3xr95DLC
        bWoWYZ/ulOOKaiay7fLoLWCiZohqHC3QTRAaAc3nMA==
X-Google-Smtp-Source: AGHT+IFEcWCSv6Vb78pMjr9udL29Qc/KXWtLxMO2JzcC7JqLi/GWAPBYp57zMlFInlL2DmQKspfwVy32iGu2HiDjqR8=
X-Received: by 2002:a05:600c:5247:b0:405:320a:44f9 with SMTP id
 fc7-20020a05600c524700b00405320a44f9mr408459wmb.5.1701705647377; Mon, 04 Dec
 2023 08:00:47 -0800 (PST)
MIME-Version: 1.0
References: <20231120190408.281826-1-irogers@google.com>
In-Reply-To: <20231120190408.281826-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 4 Dec 2023 08:00:35 -0800
Message-ID: <CAP-5=fWvADeeHVQObwk-eVNeOSC=eTTv2q8Rz4j3UtL5-6Getw@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Add basic perf diff test
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        atrajeev@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 11:04=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> There are some old bug reports on perf diff crashing:
> https://rhaas.blogspot.com/2012/06/perf-good-bad-ugly.html
>
> Happening across them I was prompted to add two very basic tests that
> will give some perf diff coverage.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/diff.sh | 101 +++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100755 tools/perf/tests/shell/diff.sh
>
> diff --git a/tools/perf/tests/shell/diff.sh b/tools/perf/tests/shell/diff=
.sh
> new file mode 100755
> index 000000000000..213185763688
> --- /dev/null
> +++ b/tools/perf/tests/shell/diff.sh
> @@ -0,0 +1,101 @@
> +#!/bin/sh
> +# perf diff tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +err=3D0
> +perfdata1=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +perfdata2=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +perfdata3=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +testprog=3D"perf test -w thloop"
> +testsym=3D"test_loop"
> +
> +cleanup() {
> +  rm -rf "${perfdata1}"
> +  rm -rf "${perfdata1}".old
> +  rm -rf "${perfdata2}"
> +  rm -rf "${perfdata2}".old
> +  rm -rf "${perfdata3}"
> +  rm -rf "${perfdata3}".old
> +
> +  trap - EXIT TERM INT
> +}
> +
> +trap_cleanup() {
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +make_data() {
> +  file=3D"$1"
> +  if ! perf record -o "${file}" ${testprog} 2> /dev/null
> +  then
> +    echo "Workload record [Failed record]"
> +    echo 1
> +    return
> +  fi
> +  if ! perf report -i "${file}" -q | grep -q "${testsym}"
> +  then
> +    echo "Workload record [Failed missing output]"
> +    echo 1
> +    return
> +  fi
> +  echo 0
> +}
> +
> +test_two_files() {
> +  echo "Basic two file diff test"
> +  err=3D$(make_data "${perfdata1}")
> +  if [ $err !=3D 0 ]
> +  then
> +    return
> +  fi
> +  err=3D$(make_data "${perfdata2}")
> +  if [ $err !=3D 0 ]
> +  then
> +    return
> +  fi
> +
> +  if ! perf diff "${perfdata1}" "${perfdata2}" | grep -q "${testsym}"
> +  then
> +    echo "Basic two file diff test [Failed diff]"
> +    err=3D1
> +    return
> +  fi
> +  echo "Basic two file diff test [Success]"
> +}
> +
> +test_three_files() {
> +  echo "Basic three file diff test"
> +  err=3D$(make_data "${perfdata1}")
> +  if [ $err !=3D 0 ]
> +  then
> +    return
> +  fi
> +  err=3D$(make_data "${perfdata2}")
> +  if [ $err !=3D 0 ]
> +  then
> +    return
> +  fi
> +  err=3D$(make_data "${perfdata3}")
> +  if [ $err !=3D 0 ]
> +  then
> +    return
> +  fi
> +
> +  if ! perf diff "${perfdata1}" "${perfdata2}" "${perfdata3}" | grep -q =
"${testsym}"
> +  then
> +    echo "Basic three file diff test [Failed diff]"
> +    err=3D1
> +    return
> +  fi
> +  echo "Basic three file diff test [Success]"
> +}
> +
> +test_two_files
> +test_three_files
> +
> +cleanup
> +exit $err
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
