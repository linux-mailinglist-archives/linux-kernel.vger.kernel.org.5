Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8728E7E6FA3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344852AbjKIQq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344364AbjKIQqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:46:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D3A35BF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:45:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6098C433C7;
        Thu,  9 Nov 2023 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699548352;
        bh=/TMgD2FsXKux1Lc8LfTtqxrYiMDimiXal92g6Us2e7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5od+4b0BoLWRpWe5K2bofV7PU0++ewP+Lk5sHrYGW/3sHGGoh08eqkXxd/zr/Adp
         sXPHoZL8ip/OiVDawjtRDzaUxbqwCBwEtsT180Z575z1YvvtutPX7/0oo7vSq3UDjc
         AF4F1U6/fJ9VETvTePWvapY3BDXvK+vMxmCwc+kWKUPd0GhY0MSI+5k1fr915CGOas
         1n5zb6O37n7idWOFcT/8wEPyd0RKU9A6NBAuYVkYB65xzk4T3cRi3dp5o1fYSHdNTh
         Oj3/oK+wQWBbN16dkpjPiCtBe+yoF+n/WssdD6Pd25MXEnhni7lxWpdthaoI2gsdll
         /cR5WN194fxcg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 67CE840094; Thu,  9 Nov 2023 13:45:49 -0300 (-03)
Date:   Thu, 9 Nov 2023 13:45:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
Subject: Re: [PATCH V5 2/8] perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK
 flag
Message-ID: <ZU0MvXe1GF6xejlf@kernel.org>
References: <20231025201626.3000228-1-kan.liang@linux.intel.com>
 <20231025201626.3000228-2-kan.liang@linux.intel.com>
 <ZUlWuROfYcYJlRn4@kernel.org>
 <fb1ebf48-ac2f-499a-b480-ba8474b12200@linux.intel.com>
 <ZUpTtoCzJFHhnSdh@kernel.org>
 <ZUv+G+w5EvJgQS45@kernel.org>
 <a40ff4eb-5507-45b9-9f21-1d153a544e16@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a40ff4eb-5507-45b9-9f21-1d153a544e16@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 09, 2023 at 11:14:31AM -0500, Liang, Kan escreveu:
>=20
>=20
> On 2023-11-08 4:31 p.m., Arnaldo Carvalho de Melo wrote:
> > Em Tue, Nov 07, 2023 at 12:11:50PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> >> Em Mon, Nov 06, 2023 at 04:19:13PM -0500, Liang, Kan escreveu:
> >>> On 2023-11-06 4:12 p.m., Arnaldo Carvalho de Melo wrote:
> >>>> Em Wed, Oct 25, 2023 at 01:16:20PM -0700, kan.liang@linux.intel.com =
escreveu:
> >>> Ian has already reviewed the tool parts.
> >=20
> >>> But I still owe a test case for the feature. I will post a patch late=
r.
> >>> https://lore.kernel.org/lkml/acbb895a-475e-4679-98fc-6b90c05a00af@lin=
ux.intel.com/
> >=20
> >> I saw Ian's suggestion, and agree with it, we need to pair new features
> >> with regression tests in 'perf test', thanks for working on it!
> >=20
> > Kan,
> >=20
> > 	I still have to bisect, but can you check if this works for you?
>=20
> The branch counters feature requires all the events to belong to a
> group. There is no problem for the normal perf usage which usually
> initializes an evlist even for a single evsel.
> But perf test is special, which may not initialize an evlist. The Sample
> parsing test case is one of the examples. It crashes with the
> !evsel->evlist.
>=20
> The below change should fix it. I will post a complete patch shortly.

Thanks for the quick response, if all that is needed are the checks
below, I'll fold it into your original patch:

2ae01908298426e4 perf tools: Add branch counter knob

So that we don't regress, ok?

I'll add a note and the Link tag points to this discussion in case
people want to do historical digs in the future :-)

- Arnaldo
=20
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 58a9b8c82790..7a6a2d1f96db 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2355,6 +2355,10 @@ static inline bool
> evsel__has_branch_counters(const struct evsel *evsel)
>  {
>         struct evsel *cur, *leader =3D evsel__leader(evsel);
>=20
> +       /* The branch counters feature only supports group */
> +       if (!leader || !evsel->evlist)
> +               return false;
> +
>         evlist__for_each_entry(evsel->evlist, cur) {
>                 if ((leader =3D=3D evsel__leader(cur)) &&
>                     (cur->core.attr.branch_sample_type &
> PERF_SAMPLE_BRANCH_COUNTERS))
>=20
> Thanks,
> Kan
>=20
> >=20
> >=20
> > (gdb) run test -F -v 27
> > Starting program: /root/bin/perf test -F -v 27
> >=20
> >  27: Sample parsing                                                  :
> > --- start ---
> >=20
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x00000000004e4aa6 in evsel.parse_sample ()
> > Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.=
8-13.fc38.x86_64 cyrus-sasl-lib-2.1.28-9.fc38.x86_64 elfutils-debuginfod-cl=
ient-0.189-3.fc38.x86_64 elfutils-libelf-0.189-3.fc38.x86_64 elfutils-libs-=
0.189-3.fc38.x86_64 glib2-2.76.5-2.fc38.x86_64 glibc-2.37-13.fc38.x86_64 ke=
yutils-libs-1.6.1-6.fc38.x86_64 krb5-libs-1.21-3.fc38.x86_64 libbabeltrace-=
1.5.11-2.fc38.x86_64 libbrotli-1.0.9-11.fc38.x86_64 libcap-2.48-6.fc38.x86_=
64 libcom_err-1.46.5-4.fc38.x86_64 libcurl-8.0.1-5.fc38.x86_64 libevent-2.1=
=2E12-8.fc38.x86_64 libgcc-13.2.1-4.fc38.x86_64 libidn2-2.3.4-2.fc38.x86_64=
 libnghttp2-1.52.0-2.fc38.x86_64 libpfm-4.11.0-11.fc38.x86_64 libpsl-0.21.2=
-2.fc38.x86_64 libselinux-3.5-1.fc38.x86_64 libssh-0.10.5-1.fc38.x86_64 lib=
stdc++-13.2.1-4.fc38.x86_64 libtraceevent-1.7.2-1.fc38.x86_64 libunistring1=
=2E0-1.0-1.fc38.x86_64 libunwind-1.6.2-7.fc38.x86_64 libuuid-2.38.1-4.fc38.=
x86_64 libxcrypt-4.4.36-1.fc38.x86_64 libzstd-1.5.5-1.fc38.x86_64 opencsd-1=
=2E3.3-1.fc38.x86_64 openldap-2.6.6-1.fc38.x86_64 openssl-libs-3.0.9-2.fc38=
=2Ex86_64 perl-libs-5.36.1-497.fc38.x86_64 popt-1.19-2.fc38.x86_64 python3-=
libs-3.11.6-1.fc38.x86_64 slang-2.3.3-3.fc38.x86_64 zlib-1.2.13-3.fc38.x86_=
64
> > (gdb) bt
> > #0  0x00000000004e4aa6 in evsel.parse_sample ()
> > #1  0x00000000004b28dc in do_test ()
> > #2  0x00000000004b2acd in test.sample_parsing ()
> > #3  0x0000000000495348 in test_and_print.isra ()
> > #4  0x0000000000495f5d in cmd_test ()
> > #5  0x00000000004c2a29 in run_builtin ()
> > #6  0x000000000041053f in main ()
> > (gdb)
> >=20

--=20

- Arnaldo
