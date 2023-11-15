Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D937E7ED797
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjKOWss convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Nov 2023 17:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjKOWsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:48:47 -0500
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC30F98
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:48:43 -0800 (PST)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id F0908B5E55;
        Wed, 15 Nov 2023 22:48:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 199816000A;
        Wed, 15 Nov 2023 22:48:38 +0000 (UTC)
Message-ID: <f9f628a0685b948898a83e7946833b2f5c5a1e7f.camel@perches.com>
Subject: Re: [PATCH] kasan: default to inline instrumentation
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Paul =?ISO-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@tum.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 Nov 2023 14:48:38 -0800
In-Reply-To: <20231115143410.e2c1ea567221d591b58ada1f@linux-foundation.org>
References: <20231109155101.186028-1-paul.heidekrueger@tum.de>
         <CA+fCnZcMY_z6nOVBR73cgB6P9Kd3VHn8Xwi8m9W4dV-Y4UR-Yw@mail.gmail.com>
         <CANpmjNNQP5A0Yzv-pSCZyJ3cqEXGRc3x7uzFOxdsVREkHmRjWQ@mail.gmail.com>
         <20231114151128.929a688ad48cd06781beb6e5@linux-foundation.org>
         <918c3ff64f352427731104c5275786c815b860d9.camel@perches.com>
         <20231115143410.e2c1ea567221d591b58ada1f@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: uk7k935cawkyafek398e3iyqfsf9k3cc
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 199816000A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+wDg5LdrfCcCLT+4LxH/Apx6oxYFicFXE=
X-HE-Tag: 1700088518-469990
X-HE-Meta: U2FsdGVkX18jeUuZkdM7rLgGPSe35YepDf/rquiQwKBiZjeBo3pOlOCuf2+xr2OIPXgnAaoK7MqPE7i7NoAI9G1rhd62Bi0x2F6kbsPu8r4dVEk9Wxo4yZhJGv6JSirpJJousQFawUAjDAts/hROOV3pqzJi4Ab1HHiKHuxvBuQ+WVfupOOXMXadvTiHh3z2R6nGZZ93XSH84ic9nTqA5ypmzYEg4yi9UiVOCR2eX3WUZzdt7GsGrBPqXn3MV7NJXAcz+HPgHbYTV3bmLmLki+JIXxbv8OoKI33zEWaMuxOyd5vpQpBG5uJ6B1NYndKMRVwQSteUzf/U90sK7G2A8uSyXCqPepH/nLyfbXPQ6FnI7ENMd8QH8bo3GFkYZk+EmD1vd9Fvv4dzmQcGZsTMmh/5gCSQzn197jGyQyME0tsHAAsbJ/bY8mDHpgxVOW27mgxdMEgw1nPpuzhMNvzPMYXAfXhPhngR1PSaIho0eqUPRYgSzvOSIwtAoWEHWsShF+SW1U3/IV0r27UbrWCX2vPsw2j8tejyFt40w0Yv1jFZW+x4zWmEkA+fXgHALYs4
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-15 at 14:34 -0800, Andrew Morton wrote:
> On Tue, 14 Nov 2023 21:38:50 -0800 Joe Perches <joe@perches.com> wrote:
> 
> > > +LIBRARY CODE
> > > +M:	Andrew Morton <akpm@linux-foundation.org>
> > > +L:	linux-kernel@vger.kernel.org
> > > +S:	Supported
> > 
> > Dunno.
> > 
> > There are a lot of already specifically maintained or
> > supported files in lib/
> 
> That's OK.  I'll get printed out along with the existing list of
> maintainers, if any.
> 
> > Maybe be a reviewer?
> 
> Would that alter the get_maintainer output in any way?

Not really.  It would allow someone to avoid cc'ing reviewers
and not maintainers though.

Perhaps change the
	S:	Supported
to something like
	S:	Supported for the files otherwise not supported

> I suppose I could list each file individually, but I'm not sure what
> that would gain.
> 
> btw, I see MAINTAINERS lists non-existent file[s] (lib/fw_table.c). 
> Maybe someone has a script to check...

--self-test works

$ ./scripts/get_maintainer.pl --self-test=patterns
./MAINTAINERS:3653: warning: no file matches	F:	Documentation/devicetree/bindings/iio/imu/bosch,bma400.yaml
./MAINTAINERS:6126: warning: no file matches	F:	Documentation/devicetree/bindings/watchdog/da90??-wdt.txt
./MAINTAINERS:10342: warning: no file matches	F:	drivers/iio/light/gain-time-scale-helper.c
./MAINTAINERS:10343: warning: no file matches	F:	drivers/iio/light/gain-time-scale-helper.h
./MAINTAINERS:22062: warning: no file matches	F:	arch/arm/boot/dts/imx*mba*.dts*
./MAINTAINERS:22063: warning: no file matches	F:	arch/arm/boot/dts/imx*tqma*.dts*
./MAINTAINERS:22064: warning: no file matches	F:	arch/arm/boot/dts/mba*.dtsi

and: see commit a103f46633fdcddc2aaca506420f177e8803a2bd

$ git log --stat -1 a103f46633fdcddc2aaca506420f177e8803a2bd
commit a103f46633fdcddc2aaca506420f177e8803a2bd
Author: Dave Jiang <dave.jiang@intel.com>
Date:   Thu Oct 12 11:53:54 2023 -0700

    acpi: Move common tables helper functions to common lib
    
    Some of the routines in ACPI driver/acpi/tables.c can be shared with
    parsing CDAT. CDAT is a device-provided data structure that is formatted
    similar to a platform provided ACPI table. CDAT is used by CXL and can
    exist on platforms that do not use ACPI. Split out the common routine
    from ACPI to accommodate platforms that do not support ACPI and move that
    to /lib. The common routines can be built outside of ACPI if
    FIRMWARE_TABLES is selected.
    
    Link: https://lore.kernel.org/linux-cxl/CAJZ5v0jipbtTNnsA0-o5ozOk8ZgWnOg34m34a9pPenTyRLj=6A@mail.gmail.com/
    Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
    Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
    Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    Signed-off-by: Dave Jiang <dave.jiang@intel.com>
    Acked-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
    Link: https://lore.kernel.org/r/169713683430.2205276.17899451119920103445.stgit@djiang5-mobl3
    Signed-off-by: Dan Williams <dan.j.williams@intel.com>

 MAINTAINERS              |   2 ++
 drivers/acpi/Kconfig     |   1 +
 drivers/acpi/tables.c    | 173 -------------------------------------------------------------------------------------------------------
 include/linux/acpi.h     |  42 +++++++------------------
 include/linux/fw_table.h |  43 ++++++++++++++++++++++++++
 lib/Kconfig              |   3 ++
 lib/Makefile             |   2 ++
 lib/fw_table.c           | 189 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 251 insertions(+), 204 deletions(-)
