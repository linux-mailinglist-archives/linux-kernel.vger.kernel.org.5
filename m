Return-Path: <linux-kernel+bounces-156153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E92AB8AFE97
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD6628706E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D5683CB8;
	Wed, 24 Apr 2024 02:43:36 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EB6F9F7;
	Wed, 24 Apr 2024 02:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926616; cv=none; b=rx2PbGUi/0GebdLWGFvGB6aA53RQTu8huPLwwRMgygRi3EsnfqzGGbui8QJeMPkiwqUGyWGwBB6e4qII3TN6DYUcgrmdfYDmW/Wj+91cGHI8gdUFm1QtIKttNHd0Rs2wpFbdltMOJSDWYQ+/Xy+V7h4Sb243d6VyxseyXuYua0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926616; c=relaxed/simple;
	bh=X07JE13bwYp9ndIC30NnRn8SItpbd3Zk1lPQS3RHTrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cx2CmZB1/FYsKXUotVjkOhYzdaXPozZiAQLMv7LZaHuzEmaR3kOgCMyOd5My7+zGJJMJAuTBe887JP+00EkY3J1kzxcyIvzXbEG3vmRSPmfJ6a6jOalfo0kmtEZqCCpYJFlVL+SaQYCudKY29jH2L07sPvF8C72wgYEHC3iEcRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VPNW10pKXzXl9Q;
	Wed, 24 Apr 2024 10:39:57 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 107ED1403D1;
	Wed, 24 Apr 2024 10:43:26 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 24 Apr 2024 10:43:25 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.028;
 Wed, 24 Apr 2024 10:43:25 +0800
From: duchangbin <changbin.du@huawei.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: duchangbin <changbin.du@huawei.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] perf trace beauty: Always show param if show_zero
 is set
Thread-Topic: [PATCH v2 1/2] perf trace beauty: Always show param if show_zero
 is set
Thread-Index: AQHalSEPbci0v0XBjkWgl90QLSVND7F1y8oAgADsOoA=
Date: Wed, 24 Apr 2024 02:43:25 +0000
Message-ID: <1b548158ce844e239dbc1e42ceeb8d0a@huawei.com>
References: <20240423015330.2206892-1-changbin.du@huawei.com>
 <20240423015330.2206892-2-changbin.du@huawei.com> <ZigcEg1inS1JoSr5@x1>
In-Reply-To: <ZigcEg1inS1JoSr5@x1>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.028)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B55AE6CB1F354F45A08874B57F72AE86@huawei.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Apr 23, 2024 at 05:37:38PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 23, 2024 at 09:53:29AM +0800, Changbin Du wrote:
> > For some parameters, it is best to also display them when they are 0,
> > e.g. flags.
>=20
> Please provide examples of what you're changing, to understand your
> change one has to know what are strarrays and what they handle in 'perf
> trace', i.e. if the value is zero but the argument has a string array
> associated, it probably will translate zero into some string.
>=20
How about only check the show_zero property? The field itself knows exactly=
 what it
wants.

			if (val =3D=3D 0 &&
			    !trace->show_zeros &&
			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].show_zero))
				continue;

> So I did:
>=20
> root@x1:~# perf trace -e syscalls:sys_enter_mmap --filter prot=3D=3D0
>      0.000 gnome-shell/2293 syscalls:sys_enter_mmap(addr: 0x10afec7e1000,=
 len: 65536, flags: PRIVATE|FIXED|ANONYMOUS)
> ^Croot@x1:~#
>=20
> And this is _before_ this patch, after this patch we get:
>=20
>=20
> root@x1:~# perf trace -e syscalls:sys_enter_mmap --filter prot=3D=3D0
>      0.000 Isolated Web C/25530 syscalls:sys_enter_mmap(addr: 0x7f27df529=
000, len: 4096, flags: PRIVATE|FIXED|ANONYMOUS)
>     40.267 DOM Worker/1105511 syscalls:sys_enter_mmap(addr: 0x1c9faec4800=
0, len: 65536, flags: PRIVATE|FIXED|ANONYMOUS)
>    270.145 firefox/3447 syscalls:sys_enter_mmap(addr: 0x7fa0ed343000, len=
: 4096, flags: PRIVATE|FIXED|ANONYMOUS)
>   2194.686 firefox/3447 syscalls:sys_enter_mmap(addr: 0x7fa0ed39f000, len=
: 4096, flags: PRIVATE|FIXED|ANONYMOUS)
>   2461.709 Isolated Web C/21794 syscalls:sys_enter_mmap(addr: 0x7fdc3e100=
000, len: 1048576, flags: PRIVATE|FIXED|ANONYMOUS)
>   4476.053 firefox/3447 syscalls:sys_enter_mmap(addr: 0x7fa0ed3a1000, len=
: 4096, flags: PRIVATE|FIXED|ANONYMOUS)
> ^Croot@x1:~#
>=20
It doesn't seem to be effective on your perf. Here is my example.

Before: PROT_NONE is not shown.
$ sudo perf trace -e syscalls:sys_enter_mmap --filter prot=3D=3D0  -- ls
     0.000 ls/2979231 syscalls:sys_enter_mmap(len: 4220888, flags: PRIVATE|=
ANONYMOUS)

After: PROT_NONE is displayed.
$ sudo perf trace -e syscalls:sys_enter_mmap --filter prot=3D=3D0  -- ls
     0.000 ls/2975708 syscalls:sys_enter_mmap(len: 4220888, prot: NONE, fla=
gs: PRIVATE|ANONYMOUS)


> Because 'mmap's 'prot' is not set directly as an strarray, see:
>=20
>         { .name     =3D "mmap",       .hexret =3D true,
> /* The standard mmap maps to old_mmap on s390x */
> #if defined(__s390x__)
>         .alias =3D "old_mmap",
> #endif
>           .arg =3D { [2] =3D { .scnprintf =3D SCA_MMAP_PROT,  /* prot */ =
},
>                    [3] =3D { .scnprintf =3D SCA_MMAP_FLAGS, /* flags */
>                            .strtoul   =3D STUL_STRARRAY_FLAGS,
>                            .parm      =3D &strarray__mmap_flags, },
>                    [5] =3D { .scnprintf =3D SCA_HEX,        /* offset */ =
}, }, },
>=20
> static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size, str=
uct syscall_arg *arg)
> {
>         unsigned long prot =3D arg->val;
>=20
>         if (prot =3D=3D 0)
>                 return scnprintf(bf, size, "%sNONE", arg->show_string_pre=
fix ? strarray__mmap_prot.prefix : "");
>=20
>         return mmap__scnprintf_prot(prot, bf, size, arg->show_string_pref=
ix);
> }
>=20
> #define SCA_MMAP_PROT syscall_arg__scnprintf_mmap_prot
>=20
> So can you please provide an example that shows before/after your patch?
>=20
> - Arnaldo
> =20
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > ---
> >  tools/perf/builtin-trace.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index e5fef39c34bf..a8407eee58a3 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2099,9 +2099,9 @@ static size_t syscall__scnprintf_args(struct sysc=
all *sc, char *bf, size_t size,
> >  			    !trace->show_zeros &&
> >  			    !(sc->arg_fmt &&
> >  			      (sc->arg_fmt[arg.idx].show_zero ||
> > -			       sc->arg_fmt[arg.idx].scnprintf =3D=3D SCA_STRARRAY ||
> > -			       sc->arg_fmt[arg.idx].scnprintf =3D=3D SCA_STRARRAYS) &&
> > -			      sc->arg_fmt[arg.idx].parm))
> > +			        ((sc->arg_fmt[arg.idx].scnprintf =3D=3D SCA_STRARRAY ||
> > +			          sc->arg_fmt[arg.idx].scnprintf =3D=3D SCA_STRARRAYS) &&
> > +			         sc->arg_fmt[arg.idx].parm))))
> >  				continue;
> > =20
> >  			printed +=3D scnprintf(bf + printed, size - printed, "%s", printed =
? ", " : "");
> > @@ -2803,8 +2803,8 @@ static size_t trace__fprintf_tp_fields(struct tra=
ce *trace, struct evsel *evsel,
> >  		 */
> >  		if (val =3D=3D 0 &&
> >  		    !trace->show_zeros &&
> > -		    !((arg->show_zero ||
> > -		       arg->scnprintf =3D=3D SCA_STRARRAY ||
> > +		    !arg->show_zero &&
> > +		    !((arg->scnprintf =3D=3D SCA_STRARRAY ||
> >  		       arg->scnprintf =3D=3D SCA_STRARRAYS) &&
> >  		      arg->parm))
> >  			continue;
> > --=20
> > 2.34.1

--=20
Cheers,
Changbin Du

