Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3701A7BE7BC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377545AbjJIRWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377314AbjJIRWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:22:50 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D119C94;
        Mon,  9 Oct 2023 10:22:48 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5984640E0187;
        Mon,  9 Oct 2023 17:22:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2onc4DUkx6ea; Mon,  9 Oct 2023 17:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696872162; bh=NF4pkh18gERZNC65SP0lDqSWBct4bpFu8AYIpbYT9pA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ai2gB5/gWdA9EowCMp6zxNapvlmpQfH1MTphR6K2X1NKST00iOkZ1CgO+2tP5RvXK
         b5jdyAYq/dSrXdfY4IBdzgJ+dCPBSqfHL6bzTOryzFSAeY5ihu1MbfBZvXpVq6RiO0
         FJiBiMccFDNz5VaLE9MEHSZLOk7HcUlWpUpCNjvZq97ykakxQOcFIo3IGyl8pt1iAK
         eq04LB/xgMXs9un5IeezLTUcaBjg5IcUIMc7n9w+sgvanEAFlS6SxB86IlNC7UZQd4
         sWVenHiwhTBx0hgFB92awnFPZvzfEdvHgpzz5onLscRf4gdqzipb5Ax2YExiO+nMnf
         p4oRZ1Kc+GY1x0eAw4gS29UwZEn0TFZfS7JoCnKLsi78M2+lMxet66Ey8J6EkkTXqK
         oYN10d6K0itaGw6vv+BU+hVUzKF0shZYEJFQ9u3LYJz4vZYmE9dOGmBHIeJG5ifqLo
         O6WhW9ASoz3TewD433pJx+k28/sTvh1ZsgQNn/kJkHylcs1TKR0iCM79aV8kMcQ1e+
         UFEsOlyp+iu3NPCSRaUXaxg2m9xLaeco6Vr2t2RGZ+KjXPAe0o5Vtt8J0fPYZav4q4
         ihMzB/LDpQ0vWuhpxhWXE5vslNwjpcvtK3fhIFgXm+f7efttE9mOGE95ER4VVG7Jld
         Gebyd1Y8aHOcNG8TIFHFyKsE=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF50040E01A5;
        Mon,  9 Oct 2023 17:22:07 +0000 (UTC)
Date:   Mon, 9 Oct 2023 19:22:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Babu Moger <babu.moger@amd.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
Subject: Re: [PATCH v11 04/10] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Message-ID: <20231009172207.GQZSQ2vyKLm660U5o6@fat_crate.local>
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-5-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003235430.1231238-5-babu.moger@amd.com>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 06:54:24PM -0500, Babu Moger wrote:
> resctrl uses RFTYPE flags for creating resctrl directory structure.
>=20
> Definitions and directory structures are not documented. Add
> comments to improve the readability and help future additions.
>=20
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h | 58 ++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/c=
pu/resctrl/internal.h
> index f71bc82c882f..b47a5906f952 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -240,6 +240,64 @@ struct rdtgroup {
> =20
>  /*
>   * Define the file type flags for base and info directories.

Why is this lengthy comment explaining internals in a header and not in
the perfectly fine

Documentation/arch/x86/resctrl.rst

file?

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
