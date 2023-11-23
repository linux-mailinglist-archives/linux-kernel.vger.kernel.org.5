Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384687F63D7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjKWQXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjKWQXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:23:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0651A4;
        Thu, 23 Nov 2023 08:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700756599; x=1732292599;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=TKeMPzbK2ClbXpVq/4TaFkb6N/ZO2ffa0lKGXrj2bYg=;
  b=W1UNAqiy+tl5/MZ/JaACW7z5J0LM5pdVt7oC7CdDmnmBAtXScVaW0lVN
   k+VtMPMqvBab1hXHfttOPIpJx6tIWDhs32OWrhQs7QYS6xsldGXNGyWez
   wEz8UJQ/Ff0mVbTFATTfSqGEkLv1EZKd+xbi5o8bXsEH74SQgXIch6nY9
   qfDsaWP9C8wjQ6YjRRqg0Jm+2hp/57hiKFVHF5p8XdK53I7AqrbM+YnY1
   9h9tMbZg/4ZgnskihZ2H34ETBng9RWJcdckg1GJ4IGugZtyH1kxeiiFm2
   ZdxfiMsdRLR1Az4EMNvS6gQdZvl/6CWJMA/HDawpqWlwd0mBwTVoK9s1q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="377320892"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="377320892"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 08:23:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="743635782"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="743635782"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 08:23:19 -0800
Received: from snpatel1-mobl.amr.corp.intel.com (unknown [10.209.89.91])
        by linux.intel.com (Postfix) with ESMTP id 0E1A4580CA5;
        Thu, 23 Nov 2023 08:23:19 -0800 (PST)
Message-ID: <67d86d38c246e78589bdb703386a6d4e9961f54b.camel@linux.intel.com>
Subject: Re: [PATCH V5 12/20] asm-generic/io.h: iounmap/ioport_unmap
 cleanup.h support
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com,
        dave.hansen@linux.intel.com, peterz@infradead.org
Date:   Thu, 23 Nov 2023 08:23:18 -0800
In-Reply-To: <f83e4a40-314-d279-75e6-17ad83501982@linux.intel.com>
References: <20231123040355.82139-1-david.e.box@linux.intel.com>
         <20231123040355.82139-13-david.e.box@linux.intel.com>
         <f83e4a40-314-d279-75e6-17ad83501982@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-23 at 16:30 +0200, Ilpo J=C3=A4rvinen wrote:
> On Wed, 22 Nov 2023, David E. Box wrote:
>=20
> > Add auto-release cleanups for iounmap() and ioport_unmap().
> >=20
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> > V2 - Move from linux/io.h to asm-generic/io.h. Adds iounmap cleanup if
> > =C2=A0=C2=A0=C2=A0=C2=A0 iounmap() is defined. Adds ioport_unmap cleanu=
p if CONFIG_IOPORT_MAP
> > =C2=A0=C2=A0=C2=A0=C2=A0 is defined.
> >=20
> > =C2=A0include/asm-generic/io.h | 6 ++++++
> > =C2=A01 file changed, 6 insertions(+)
> >=20
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > index bac63e874c7b..9ef0332490b1 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > @@ -8,6 +8,7 @@
> > =C2=A0#define __ASM_GENERIC_IO_H
> > =C2=A0
> > =C2=A0#include <asm/page.h> /* I/O is all done through memory accesses =
*/
> > +#include <linux/cleanup.h>
> > =C2=A0#include <linux/string.h> /* for memset() and memcpy() */
> > =C2=A0#include <linux/types.h>
> > =C2=A0#include <linux/instruction_pointer.h>
> > @@ -1065,6 +1066,10 @@ static inline void __iomem *ioremap(phys_addr_t =
addr,
> > size_t size)
> > =C2=A0#endif
> > =C2=A0#endif /* !CONFIG_MMU || CONFIG_GENERIC_IOREMAP */
> > =C2=A0
> > +#ifdef iounmap
> > +DEFINE_FREE(iounmap, void __iomem *, iounmap(_T));
> > +#endif
> > +
> > =C2=A0#ifndef ioremap_wc
> > =C2=A0#define ioremap_wc ioremap
> > =C2=A0#endif
> > @@ -1127,6 +1132,7 @@ static inline void ioport_unmap(void __iomem *p)
> > =C2=A0extern void __iomem *ioport_map(unsigned long port, unsigned int =
nr);
> > =C2=A0extern void ioport_unmap(void __iomem *p);
> > =C2=A0#endif /* CONFIG_GENERIC_IOMAP */
> > +DEFINE_FREE(ioport_unmap, void __iomem *, ioport_unmap(_T));
> > =C2=A0#endif /* CONFIG_HAS_IOPORT_MAP */
> > =C2=A0
> > =C2=A0#ifndef CONFIG_GENERIC_IOMAP
>=20
> Has this now built successfully with LKP? (I don't think we get success=
=20
> notifications from LKP for patch submissions, only failures).

I haven't received it yet and don't know when or if I will. The build
instructions are provided so I can attempt to check it myself.

>=20
> There were some odd errors last time but I think all they were unrelated=
=20
> to this change (besides the checkpatch false positive, I mean).

Indeed. I couldn't explain them either except to think maybe it was related=
 to
the implicit declaration warning. The implicit declaration warning was one =
that
I did see in my build after rerunning with W=3D1 C=3D1. I usually always ru=
n with
this but on V4 had done so only on the modules and forgot the bzImage.

David
>=20

