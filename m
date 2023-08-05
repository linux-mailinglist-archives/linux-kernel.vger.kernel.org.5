Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035D4771025
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 16:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjHEO3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 10:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjHEO3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 10:29:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F33E70
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691245714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mJ/4D/Qg65ZCUuaf44TQpRMfki/rntMf9hKDhlgTcAw=;
        b=AXV9ilZlL5q72H+X0ANvIxzQqAkDOhZRLmF7YkdiJMvJphn/87W+oeBml+58AXQsuK/qR7
        K0orLax+DPRiR+pwIv5F0RgDNWivcfgx7QnXW7r9paslf0OK2QHB0yaGjMqGprUDmi87dR
        8P3YZasxyfZEZy9vEbJzvy0pwDOUb2c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-EiFThzleOAugCqp5tcRRXg-1; Sat, 05 Aug 2023 10:28:33 -0400
X-MC-Unique: EiFThzleOAugCqp5tcRRXg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76ca8263c45so378331185a.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 07:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691245713; x=1691850513;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJ/4D/Qg65ZCUuaf44TQpRMfki/rntMf9hKDhlgTcAw=;
        b=Xm0RYAL5runYQPvZN0/c5ZVlgLAQjLxqhL9TQBzH1X1CeoneWxnXPMEmYWq9mo1t94
         NgjAU43GG3fbkjuflL/EwOKEPMIf32HMEDietQ5ATQDpkJAG1HURYCnzNLnidgxv3uFG
         VqbEjlsuXks4syc7Xnr5dQPiTDVINDgC8HvNMHlyrtiz+GTJhK+n4bw5a0JAxuk4+NXo
         OsE8/ZSUreW/dQH9Sx96+dTdhEOxldB/M4/QUywlluJloJJb/BTltq3agtzpUWFZvfO+
         JpvRw7m+6S5khNx5GbjzibCwksDDPWvez18s86p8ZzHpxyoFKLv8t3MC/901T5EO4gtm
         z0Cg==
X-Gm-Message-State: AOJu0YwtXutFM+su3gmCX8LywGdXXY+D8qknV5YSMeisDAa0AqxVK9lP
        HQe8vvylNtmrhnZ6nhLOLHIevOnToLOfbiWQTFOaSnOnLnjfmoPUMBRnS0IVXvG/Bh0ARgPb44C
        WV0ROZHf++xdGHeXtl1DpIZb1
X-Received: by 2002:a05:620a:22d5:b0:75d:4e8b:9d19 with SMTP id o21-20020a05620a22d500b0075d4e8b9d19mr4656008qki.26.1691245713382;
        Sat, 05 Aug 2023 07:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoiSI+Bc32VDbO7RD7jSyr25Vif/Iyhn2CmM/WECkpQPX9VjRRxQaaw3sEj+baed1iBnE5PQ==
X-Received: by 2002:a05:620a:22d5:b0:75d:4e8b:9d19 with SMTP id o21-20020a05620a22d500b0075d4e8b9d19mr4655983qki.26.1691245713140;
        Sat, 05 Aug 2023 07:28:33 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id p14-20020ae9f30e000000b0076768dfe53esm1365165qkg.105.2023.08.05.07.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 07:28:32 -0700 (PDT)
Message-ID: <b1452f78dc433a9cab4c94c9751e0e4a149cff01.camel@redhat.com>
Subject: Re: [PATCH v3 1/3] cacheinfo: Allocate memory for memory if not
 done from the primary CPU
From:   Radu Rendec <rrendec@redhat.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org
Cc:     Andreas Herrmann <aherrmann@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Pu Wen <puwen@hygon.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        stable@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Sat, 05 Aug 2023 10:28:30 -0400
In-Reply-To: <20230805012421.7002-2-ricardo.neri-calderon@linux.intel.com>
References: <20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com>
         <20230805012421.7002-2-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-04 at 18:24 -0700, Ricardo Neri wrote:
> Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> adds functionality that architectures can use to optionally allocate and
> build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo: Add
> arch specific early level initializer") lets secondary CPUs correct (and
> reallocate memory) cacheinfo data if needed.
>=20
> If the early build functionality is not used and cacheinfo does not need
> correction, memory for cacheinfo is never allocated. x86 does not use the
> early build functionality. Consequently, during the cacheinfo CPU hotplug
> callback, last_level_cache_is_valid() attempts to dereference a NULL
> pointer:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 BUG: kernel NULL pointer dereference, address: 0=
000000000000100
> =C2=A0=C2=A0=C2=A0=C2=A0 #PF: supervisor read access in kernel mode
> =C2=A0=C2=A0=C2=A0=C2=A0 #PF: error_code(0x0000) - not present page
> =C2=A0=C2=A0=C2=A0=C2=A0 PGD 0 P4D 0
> =C2=A0=C2=A0=C2=A0=C2=A0 Oops: 0000 [#1] PREEPMT SMP NOPTI
> =C2=A0=C2=A0=C2=A0=C2=A0 CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc=
2 #1
> =C2=A0=C2=A0=C2=A0=C2=A0 RIP: 0010: last_level_cache_is_valid+0x95/0xe0a
>=20
> Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback i=
f
> not done earlier.
>=20
> Cc: Andreas Herrmann <aherrmann@suse.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Radu Rendec <rrendec@redhat.com>
> Cc: Pierre Gondois <Pierre.Gondois@arm.com>
> Cc: Pu Wen <puwen@hygon.cn>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: stable@vger.kernel.org
> Acked-by: Len Brown <len.brown@intel.com>
> Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level initialize=
r")
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> The motivation for commit 5944ce092b97 was to prevent a BUG splat in
> PREEMPT_RT kernels during memory allocation. This splat is not observed o=
n
> x86 because the memory allocation for cacheinfo happens in
> detect_cache_attributes() from the cacheinfo CPU hotplug callback.
>=20
> The dereference of a NULL pointer is not observed today because
> cache_leaves(cpu) is zero until after init_cache_level() is called (also
> during the CPU hotplug callback). Patch2 will set it earlier and the NULL=
-
> pointer dereference will be observed.
> ---
> Changes since v2:
> =C2=A0* Introduced this patch.
>=20
> Changes since v1:
> =C2=A0* N/A
> ---
> =C2=A0drivers/base/cacheinfo.c | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index cbae8be1fe52..461a77ece4b0 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -554,7 +554,11 @@ static inline int init_level_allocate_ci(unsigned in=
t cpu)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ci_cacheinfo(cpu)->early_=
ci_levels =3D false;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (cache_leaves(cpu) <=3D ear=
ly_leaves)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Some architectures (e.g., x=
86) do not use early initialization.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Allocate memory now in such=
 case.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (cache_leaves(cpu) <=3D ear=
ly_leaves && per_cpu_cacheinfo(cpu))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(per_cpu_cacheinfo(c=
pu));

For this patch only:

Reviewed-by: Radu Rendec <rrendec@redhat.com>

Thanks for submitting!

Best regards,
Radu

