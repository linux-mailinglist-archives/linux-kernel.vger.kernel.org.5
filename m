Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE13878DD10
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243305AbjH3Srh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343766AbjH3QqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4181A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693413928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2kcdAhul63F+gq9DZ4acKwcsYj0UGqnNLCr2y+dE+Js=;
        b=PB1ou2LmXMTCMjX70Xe165kkYwLv0egFWmSEhNTDBFmI+fvgsFoJ1KItl5JcATqPtbQKaR
        etyPqMr3xs7fZ9YM/Kh5ihwMk3XgJVIlsAvlH0Rowy82bfxBzwXj7AzzL1te6iJyILbFLu
        0W1T8epW/HxDLSt2M55Wq/azVQYX0XM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561--uIWugmLNtGSqzMiElP7hg-1; Wed, 30 Aug 2023 12:45:25 -0400
X-MC-Unique: -uIWugmLNtGSqzMiElP7hg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6491907dba4so9677096d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413925; x=1694018725;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2kcdAhul63F+gq9DZ4acKwcsYj0UGqnNLCr2y+dE+Js=;
        b=UI9pF3XRY5aTPykwOndicEJEY5WdqIMUd8HWxH4024JFPu5U0cLk2omHj3rR++aRsp
         UqYYuSUIyf7ZwwGbNMD29yCiM6ZM/BQ2X8wVOOmrPLZrZrxrVRoZrpDsgC47q28z+kmf
         c4Pf+6jnpL/R45dttC2pqLnX6wpsuekLNFStsOgg1fEPYHaI4KunTuA3MOXtKwj9xd5w
         2YQFf3xjJup1JzLe5ddQZlyzrMc5Ce9+BowToCgeFNFVc2UbdmD7ldZv26T0YsGewDVN
         U+kT/OsBQwE+d3JYVgzW/1iMvjMqsiX7Q8X3Mxh9hUiJcSfsjhpVl+oFkZVnErq4s2Fw
         jyrQ==
X-Gm-Message-State: AOJu0Yw4Eoji7qhMDI+rT4PCzb1t316RvXMgQ2y8LUR8nP+ZA0EgbjBh
        HdPCn4Q5ixkEAGQiMyJ+hQaQkUlPhFQsZiMPnC0qxc2MK2/E+YfvSJUQGoD5YZgFAnWgJ3sYWkq
        ilS6HFc8zgVqqn6ztN0bnabui
X-Received: by 2002:a05:6214:27c9:b0:651:66a3:64bd with SMTP id ge9-20020a05621427c900b0065166a364bdmr196227qvb.29.1693413924849;
        Wed, 30 Aug 2023 09:45:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnCvIEzPGc5rHAL2vsQBMugMyi/n5SuZwZyTezJhJjpxOHcoiAWXL9olYFTddaJkJYQlIVMQ==
X-Received: by 2002:a05:6214:27c9:b0:651:66a3:64bd with SMTP id ge9-20020a05621427c900b0065166a364bdmr196198qvb.29.1693413924599;
        Wed, 30 Aug 2023 09:45:24 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id m4-20020a0cf184000000b0063cfb3fbb7esm4224108qvl.16.2023.08.30.09.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 09:45:24 -0700 (PDT)
Message-ID: <03e51c6072d80931a6b532ce1d4d7388a6f84d32.camel@redhat.com>
Subject: Re: [PATCH v3 1/3] cacheinfo: Allocate memory for memory if not
 done from the primary CPU
From:   Radu Rendec <rrendec@redhat.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Pu Wen <puwen@hygon.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        stable@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Wed, 30 Aug 2023 12:45:22 -0400
In-Reply-To: <20230830154707.dyeihenolc5nwmi2@bogus>
References: <20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com>
         <20230805012421.7002-2-ricardo.neri-calderon@linux.intel.com>
         <20230830114918.be4mvwfogdqmsxk6@bogus>
         <23a1677c3df233c220df68ea429a2d0fec52e1d4.camel@redhat.com>
         <20230830154707.dyeihenolc5nwmi2@bogus>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-30 at 16:47 +0100, Sudeep Holla wrote:
> On Wed, Aug 30, 2023 at 08:13:09AM -0400, Radu Rendec wrote:
> > On Wed, 2023-08-30 at 12:49 +0100, Sudeep Holla wrote:
> > > On Fri, Aug 04, 2023 at 06:24:19PM -0700, Ricardo Neri wrote:
> > > > Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary C=
PU")
> > > > adds functionality that architectures can use to optionally allocat=
e and
> > > > build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo:=
 Add
> > > > arch specific early level initializer") lets secondary CPUs correct=
 (and
> > > > reallocate memory) cacheinfo data if needed.
> > > >=20
> > > > If the early build functionality is not used and cacheinfo does not=
 need
> > > > correction, memory for cacheinfo is never allocated. x86 does not u=
se the
> > > > early build functionality. Consequently, during the cacheinfo CPU h=
otplug
> > > > callback, last_level_cache_is_valid() attempts to dereference a NUL=
L
> > > > pointer:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 BUG: kernel NULL pointer dereference, addr=
ess: 0000000000000100
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 #PF: supervisor read access in kernel mode
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 #PF: error_code(0x0000) - not present page
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 PGD 0 P4D 0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 Oops: 0000 [#1] PREEPMT SMP NOPTI
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.=
4.0-rc2 #1
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 RIP: 0010: last_level_cache_is_valid+0x95/=
0xe0a
> > > >=20
> > > > Allocate memory for cacheinfo during the cacheinfo CPU hotplug call=
back if
> > > > not done earlier.
> > > >=20
> > > > Cc: Andreas Herrmann <aherrmann@suse.com>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Chen Yu <yu.c.chen@intel.com>
> > > > Cc: Len Brown <len.brown@intel.com>
> > > > Cc: Radu Rendec <rrendec@redhat.com>
> > > > Cc: Pierre Gondois <Pierre.Gondois@arm.com>
> > > > Cc: Pu Wen <puwen@hygon.cn>
> > > > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Cc: stable@vger.kernel.org
> > > > Acked-by: Len Brown <len.brown@intel.com>
> > > > Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level init=
ializer")
> > >=20
> > > Not sure if we strictly need this(details below), but I am fine eithe=
r way.
> > >=20
> > > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > > ---
> > > > The motivation for commit 5944ce092b97 was to prevent a BUG splat i=
n
> > > > PREEMPT_RT kernels during memory allocation. This splat is not obse=
rved on
> > > > x86 because the memory allocation for cacheinfo happens in
> > > > detect_cache_attributes() from the cacheinfo CPU hotplug callback.
> > > >=20
> > > > The dereference of a NULL pointer is not observed today because
> > > > cache_leaves(cpu) is zero until after init_cache_level() is called =
(also
> > > > during the CPU hotplug callback). Patch2 will set it earlier and th=
e NULL-
> > > > pointer dereference will be observed.
> > >=20
> > > Right, this is the information I have been asking in the previous ver=
sions.
> > > This clarifies a lot. The trigger is in the patch 2/3 which is why it=
 didn't
> > > make complete sense to me without it when you posted this patch indep=
endently.
> > > Thanks for posting it together and sorry for the delay(both reviewing=
 this
> > > and in understanding the issue).
> > >=20
> > > Given the trigger for NULL pointer dereference is in 2/3, I am not su=
re
> > > if it is really worth applying this to all the stable kernels with th=
e
> > > commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU=
").
> > > That is the reason why I asked to drop fixes tag if you agree with me=
.
> > > It is simple fix, so I am OK if you prefer to see that in the stable =
kernels
> > > as well.
> >=20
> > Thanks for reviewing, Sudeep. Since my previous commit 6539cffa9495
> > ("cacheinfo: Add arch specific early level initializer") opens a door
> > for the NULL pointer dereference, I would sleep better at night if the
> > fix was included in the stable kernels :) But seriously, I am concerned
> > that with the fix applied in mainline and not in stable, something else
> > could be backported to the stable in the future, that could trigger the
> > NULL pointer dereference there. Ricardo's patch 2/3 is one way to
> > trigger it, but you never know what other patch lands in mainline in
> > the future that assumes it's safe to set the cache leaves earlier.
> >=20
>=20
> Fair enough. I agree with you, so please retain the fixes tag as is.
> Please work with x86 maintainers to get it merged along with other patche=
s.
> Let me know if you have other plans.

Thanks, Sudeep. Technically, these are Ricardo's patches, so I will let
him engage with the x86 maintainers and drive the integration work. But
the plan looks good to me, and I will stand by and offer any support
may be needed for the fix patch.

--
Regards,
Radu

