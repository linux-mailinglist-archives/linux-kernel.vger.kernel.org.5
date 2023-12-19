Return-Path: <linux-kernel+bounces-5922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C20781918F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388DF1F27A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDA439AEA;
	Tue, 19 Dec 2023 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jgh7RScY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A227E1DFC6;
	Tue, 19 Dec 2023 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703018014; x=1734554014;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xypqY9y3pFNRuA97+GR/6JWtFugdT3Tz94S2dtfBnCw=;
  b=Jgh7RScYKIAlDYkHOytTRQCzLDHIvgXl0CmMpQkY/T1ih8oV+DXAzB01
   oTmDX5cu80bmiT+G8914uVusF4uyG44n05CeBWEPJmOqNIYfEkzX/4dhR
   R7kQuoh/oR4Ba1lWmXPAAtcpQvXfbNiXQaCKUA3N9LkVoClFu1VKlaqEl
   Ic2adsSgSss/3BDhjRB8zFF4/BidhXwtI6NBJvca8Vphp/tVm+hLjGkFy
   uqWGRItIl80MFuryyumGJWkwmygdDlTkokKT1sjfg1LapmqiilgXqOoXW
   x7yDF8hrl1OhaPFqFZyudB0FpzXaKj0OUumIsZ76uPjvaN/1S4AyiWZaI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="14408339"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="14408339"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 12:33:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="725834591"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="725834591"
Received: from vshanmug-mobl.amr.corp.intel.com (HELO [10.209.175.222]) ([10.209.175.222])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 12:33:33 -0800
Message-ID: <9adc18c94f160cad550e762571a952baa7f8df36.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Add Emerald Rapids support in
 no-HWP mode
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Zhenguo Yao
 <yaozhenguo1@gmail.com>
Cc: lenb@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yaozhenguo@jd.com
Date: Tue, 19 Dec 2023 15:33:32 -0500
In-Reply-To: <CAJZ5v0i4DAtzoJUyN0H-4rL=HR=cNntqrrJaDj12suF=7JiyeQ@mail.gmail.com>
References: <20231213102808.94695-1-yaozhenguo1@gmail.com>
	 <CAJZ5v0i4DAtzoJUyN0H-4rL=HR=cNntqrrJaDj12suF=7JiyeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-19 at 21:22 +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 13, 2023 at 11:28=E2=80=AFAM Zhenguo Yao <yaozhenguo1@gmail.c=
om>
> wrote:
> >=20
> > Users may disable HWP in firmware, in which case intel_pstate
> > wouldn't load
> > unless the CPU model is explicitly supported.
> >=20
> > See also the following past commits:
> >=20
> > commit df51f287b5de ("cpufreq: intel_pstate: Add Sapphire Rapids
> > support
> > in no-HWP mode")
> > commit d8de7a44e11f ("cpufreq: intel_pstate: Add Skylake servers
> > support")
> > commit 706c5328851d ("cpufreq: intel_pstate: Add Cometlake support
> > in
> > no-HWP mode")
> > commit fbdc21e9b038 ("cpufreq: intel_pstate: Add Icelake servers
> > support in
> > no-HWP mode")
> > commit 71bb5c82aaae ("cpufreq: intel_pstate: Add Tigerlake support
> > in
> > no-HWP mode")
> >=20
> > Signed-off-by: Zhenguo Yao <yaozhenguo1@gmail.com>
>=20
> Srinivas, any objections?
No.

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

>=20
> > ---
> > =C2=A0drivers/cpufreq/intel_pstate.c | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index a534a1f7f1ee..39e0a2cf7236 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2406,6 +2406,7 @@ static const struct x86_cpu_id
> > intel_pstate_cpu_ids[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH(ICELAKE_X,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 core_funcs),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH(TIGERLAKE,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 core_funcs),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH(SAPPHIRERAPIDS_X,=
=C2=A0=C2=A0=C2=A0=C2=A0 core_funcs),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH(EMERALDRAPIDS_X,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 core_funcs),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {}
> > =C2=A0};
> > =C2=A0MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
> > --
> > 2.39.3
> >=20


