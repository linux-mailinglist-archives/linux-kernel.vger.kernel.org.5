Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1387BA303
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbjJEPui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjJEPtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:49:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8920A8690;
        Thu,  5 Oct 2023 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696518574; x=1728054574;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jpcWaEz7B26fb8p/m9yTGm1Sg1FRrUAivyKn3XZFmUo=;
  b=nmRlPngEzhc132Ips5FS1/9djdzS/HgZ8a8z6EuiaziABaroJEw9vX4D
   cFN6ZMYSZZbRBN7pegwyKZRRFjIS+SuPcv4PoyM7N1/u99ubVs224lcOd
   Qw7rOfI7PnggqmpWfdi5FgGZASIOftEj7I2lMli+qoUpyVUUIyWL0v+u1
   oSciTjyILpaCqSw67573b9Q2ysrLy+xt1heyhlNBiQxHOy/Z97JxYDSzx
   ardJ8oPzM9M0IUL4ISYxtu9sCulFaJ9mE2KHeXPzFNiZDwaiA1ph7QONR
   IJaO63xaIiCs6EojtnEJyD5/SRXSHETWl3CiKsvwSTXSwuoHj5+3E65B4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="373880505"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="373880505"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 08:09:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="745479250"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="745479250"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.88.30])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 08:09:34 -0700
Message-ID: <ff3f7c023d73c2c8216cff2910e4965a026cdd98.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: intel: powerclamp: fix mismatch in get
 function for max_idle
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     David Arcari <darcari@redhat.com>, linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date:   Thu, 05 Oct 2023 08:09:34 -0700
In-Reply-To: <20231005111757.1293740-1-darcari@redhat.com>
References: <20231005111757.1293740-1-darcari@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-05 at 07:17 -0400, David Arcari wrote:
> KASAN reported this
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ 444.853098] BUG: KASAN: global-out-of-bo=
unds in
> param_get_int+0x77/0x90
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ 444.853111] Read of size 4 at addr fffff=
fffc16c9220 by task
> cat/2105
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ 444.853442] The buggy address belongs to=
 the variable:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ 444.853443] max_idle+0x0/0xffffffffffffc=
de0
> [intel_powerclamp]
>=20
> There is a mismatch between the param_get_int and the definition of
> max_idle.=C2=A0 Replacing param_get_int with param_get_byte resolves this
> issue.
>=20
> Fixes: ebf519710218 ("thermal: intel: powerclamp: Add two module
> parameters")
>=20
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: David Arcari <darcari@redhat.com>
> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: David Arcari <darcari@redhat.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/thermal/intel/intel_powerclamp.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/intel/intel_powerclamp.c
> b/drivers/thermal/intel/intel_powerclamp.c
> index 36243a3972fd..5ac5cb60bae6 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -256,7 +256,7 @@ static int max_idle_set(const char *arg, const
> struct kernel_param *kp)
> =C2=A0
> =C2=A0static const struct kernel_param_ops max_idle_ops =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.set =3D max_idle_set,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.get =3D param_get_int,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.get =3D param_get_byte,
> =C2=A0};
> =C2=A0
> =C2=A0module_param_cb(max_idle, &max_idle_ops, &max_idle, 0644);

