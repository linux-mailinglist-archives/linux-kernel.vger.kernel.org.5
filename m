Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7338B7BE6FF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377760AbjJIQvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377340AbjJIQux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:50:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA10101;
        Mon,  9 Oct 2023 09:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696870251; x=1728406251;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=b9iN2UIUY+MXlviHrRmhLSxxQW0LQqi0mfJzqOW6BhY=;
  b=PW49u8fot8c3hLC3gTN7UY41gWcXUNCk7NDCFPkLFEqWo4B5HM94Lo8+
   V4BQ0MUN7m03eOBVhMJYOcSPOA+b51KCYqbVTT2TlZ3OT47Zlfjdr8FKf
   SuvqBbCAewEyjJQFrGYKELaEm+SuQL+ZChYv+oIjeQlKYLEfwoquPVwpu
   vmufQxykvNMSkIe/BnYjoZgv/RxFO0OIO0cAiXakB5hr4y0K3FecWkPYD
   9/4csnT8ABQMCwbYNuWgAs67YrAjvqw/vYyS2GIHcQfntzXvW/7MxCLMK
   QHcNw1QlZ2fbUISa/haI/XcfyuVfrGHA7L6kvEz6xt1A8Sle+y2mnnSqM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="2782000"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="2782000"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 09:50:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="788228855"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="788228855"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.103.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 09:50:49 -0700
Message-ID: <8fa4856c8511d9aaae386e8074c7782733e61c46.camel@linux.intel.com>
Subject: Re: [PATCH 2/5] modpost: fix ishtp MODULE_DEVICE_TABLE built on big
 endian host
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Date:   Mon, 09 Oct 2023 09:50:49 -0700
In-Reply-To: <79f74670-768b-46f7-b484-a45ddcd9dc6f@t-8ch.de>
References: <20231007170448.505487-1-masahiroy@kernel.org>
         <20231007170448.505487-2-masahiroy@kernel.org>
         <79f74670-768b-46f7-b484-a45ddcd9dc6f@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-10-08 at 09:51 +0200, Thomas Wei=C3=9Fschuh wrote:
> On 2023-10-08 02:04:45+0900, Masahiro Yamada wrote:
> > When MODULE_DEVICE_TABLE(ishtp, ) is built on a host with a
> > different
> > endianness from the target architecture, it results in an incorrect
> > MODULE_ALIAS().
> >=20
> > For example, see a case where
> > drivers/platform/x86/intel/ishtp_eclite.c
> > is built as a module.
>=20
> Nitpick:
>=20
> ... [as a module] for x86.
>=20
> So the statements below can be interpreted correctly.
>=20
> >=20
> > If you build it on a little endian host, you will get the correct
> > MODULE_ALIAS:
> >=20
> > =C2=A0=C2=A0=C2=A0 $ grep MODULE_ALIAS
> > drivers/platform/x86/intel/ishtp_eclite.mod.c
> > =C2=A0=C2=A0=C2=A0 MODULE_ALIAS("ishtp:{6A19CC4B-D760-4DE3-B14D-F25EBD0=
FBCD9}");
> >=20
> > However, if you build it on a big endian host, you will get a wrong
> > MODULE_ALIAS:
> >=20
> > =C2=A0=C2=A0=C2=A0 $ grep MODULE_ALIAS
> > drivers/platform/x86/intel/ishtp_eclite.mod.c
> > =C2=A0=C2=A0=C2=A0 MODULE_ALIAS("ishtp:{BD0FBCD9-F25E-B14D-4DE3-D7606A1=
9CC4B}");
> >=20
> > This issue has been unnoticed because the x86 kernel is most likely
> > built
> > natively on an x86 host.
> >=20
> > The guid field must not be reversed because guid_t is an array of
> > __u8.
> >=20
> > Fixes: fa443bc3c1e4 ("HID: intel-ish-hid: add support for
> > MODULE_DEVICE_TABLE()")
>=20
> + Cc: stable@vger.kernel.org
>=20
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>=20
> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks,
Srinivas

>=20
> Thanks!
>=20
> > ---
> >=20
> > =C2=A0scripts/mod/file2alias.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> > index 70bf6a2f585c..6583b36dbe69 100644
> > --- a/scripts/mod/file2alias.c
> > +++ b/scripts/mod/file2alias.c
> > @@ -1401,10 +1401,10 @@ static int do_mhi_ep_entry(const char
> > *filename, void *symval, char *alias)
> > =C2=A0/* Looks like: ishtp:{guid} */
> > =C2=A0static int do_ishtp_entry(const char *filename, void *symval, cha=
r
> > *alias)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DEF_FIELD(symval, ishtp_devi=
ce_id, guid);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DEF_FIELD_ADDR(symval, ishtp=
_device_id, guid);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strcpy(alias, ISHTP_MOD=
ULE_PREFIX "{");
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0add_guid(alias, guid);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0add_guid(alias, *guid);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strcat(alias, "}");
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 1;
> > --=20
> > 2.39.2
> >=20

