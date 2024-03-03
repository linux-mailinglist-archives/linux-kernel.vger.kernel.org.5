Return-Path: <linux-kernel+bounces-89924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6798886F75C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD264281229
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA127A709;
	Sun,  3 Mar 2024 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UG1mG1Hs"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDD143AB5;
	Sun,  3 Mar 2024 22:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709503830; cv=none; b=FhGT2xMS3g3skGgMgVj0Wkiw4mPdt78EImRZ5nsl6/LZVBKkWPHKfMUGixyXNjWgeEZZsGg/04FwaAU+albJdk7suY2uo3VLsqtXsgetOjY4Ox9mQBetAyHtyg+eqTtSiGxKLysj/qBErKQ+xFh6/opheJflZ7ACUbtjHNEN6RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709503830; c=relaxed/simple;
	bh=VAh4dIkTENU2/QEjIcjwE+UuoxnSUGcJoPqGUDx5MCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyH6nHowzT2uhUIJLJ2V5mdSqTDV7sJ8sLNselTEGt1AI/z+De1UL0sFKJyYR3MyDzTaLMFfx0ZIXLWvJDKJzEBLGm+dWZ73vQ4Plt3r/mvSLo92fyKt084mJS+vaHdj4RBP3u0U7q9x44mi0UYhNwA/2OdANUrIy8Dj/K7tq7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UG1mG1Hs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0g5zoVT+JVW02GwsTEDCm7DmiF1qRMx3Unb0+lN7s4c=; b=UG1mG1HsZor8kvPgUKPIAi3Dsx
	ytA6TJVPQOsJZSxzVIrKu2ZwVYh3Plp8NRL9ZDnpJInBen1kxyXw/BQWWU+d/N6BBfgriWQCRDrS+
	kJ7fF7YJyIk8lZ2IZYtPg/xsgDCL0TEfbAAIV2z2avyiG2AGeyutPjVvRCEgCcP2oUjW09tIDxtXe
	ya0rgkq5N0PQvthdHeegJcveWc85bJZBfYmwGj+nJ3exIxKlT8laS0MlPT8wJ+gW0w3xVavZYFBNK
	ftPQfPvSy6OQ8Wph7eUzAprdMvcl+4ylrDWFmEkUVHI3n8TpK33bDd+OZBWxESZddtiZiDrUU1L3N
	YYUyqtsw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rgu2D-002GxX-0S;
	Sun, 03 Mar 2024 22:10:17 +0000
Date: Sun, 3 Mar 2024 22:10:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: kernel test robot <lkp@intel.com>
Cc: Jing Cai <jing.cai@mediatek.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Chris Lu <chris.lu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: WARNING: modpost: "strcpy" [drivers/bluetooth/btmtk.ko] has no
 CRC!
Message-ID: <20240303221017.GB524366@ZenIV>
References: <202403040552.0iyr20St-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403040552.0iyr20St-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Mar 04, 2024 at 06:02:08AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   58c806d867bf265c6fd16fc3bc62e2d3c156b5c9
> commit: 0b70151328781a89c89e4cf3fae21fc0e98d869e Bluetooth: btusb: mediatek: add MediaTek devcoredump support
> date:   7 months ago
> config: alpha-buildonly-randconfig-r004-20220321 (https://download.01.org/0day-ci/archive/20240304/202403040552.0iyr20St-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240304/202403040552.0iyr20St-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403040552.0iyr20St-lkp@intel.com/

commit 8a4a2705ed98c33c2ad5f3e504efe2d379cf72d7
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Dec 18 22:59:26 2023 -0500

    alpha: fix modversions for strcpy() et.al.
    
            On alpha str{n,}{cpy,cat}() implementations are playing
    fun games with shared chunks of code.  The problem is, they are
    using direct branches and need to be next to each other.
            Currently it's done by building them in separate object
    files, then using ld -r to link those together.  Unfortunately,
    genksyms machinery has no idea what to do with that - we have
    generated in arch/alpha/lib/.strcat.S.cmd, but there's nothing
    to propagate that into .stycpy.S.cmd, so modpost doesn't find
    anything for those symbols, resulting in
    WARNING: modpost: EXPORT symbol "strcpy" [vmlinux] version generation failed, symbol will not be versioned.
    Is "strcpy" prototyped in <asm/asm-prototypes.h>?
    WARNING: modpost: EXPORT symbol "strcat" [vmlinux] version generation failed, symbol will not be versioned.
    Is "strcat" prototyped in <asm/asm-prototypes.h>?
    WARNING: modpost: EXPORT symbol "strncpy" [vmlinux] version generation failed, symbol will not be versioned.
    Is "strncpy" prototyped in <asm/asm-prototypes.h>?
    WARNING: modpost: EXPORT symbol "strncat" [vmlinux] version generation failed, symbol will not be versioned.
    Is "strncat" prototyped in <asm/asm-prototypes.h>?
    spew on modversion-enabled builds (all 4 functions in question
    are in fact prototyped in asm-prototypes.h)
    
            Fixing doesn't require messing with kbuild, thankfully -
    just build one object (i.e. have sty{n,}cpy.S with includes of relevant
    *.S instead of playing with ld -r) and that's it.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/arch/alpha/lib/Makefile b/arch/alpha/lib/Makefile
index 6a779b9018fd..84046e730e6d 100644
--- a/arch/alpha/lib/Makefile
+++ b/arch/alpha/lib/Makefile
@@ -44,17 +44,3 @@ AFLAGS___remlu.o =       -DREM -DINTSIZE
 $(addprefix $(obj)/,__divqu.o __remqu.o __divlu.o __remlu.o): \
 						$(src)/$(ev6-y)divide.S FORCE
 	$(call if_changed_rule,as_o_S)
-
-# There are direct branches between {str*cpy,str*cat} and stx*cpy.
-# Ensure the branches are within range by merging these objects.
-
-LDFLAGS_stycpy.o := -r
-LDFLAGS_styncpy.o := -r
-
-$(obj)/stycpy.o: $(obj)/strcpy.o $(obj)/$(ev67-y)strcat.o \
-		 $(obj)/$(ev6-y)stxcpy.o FORCE
-	$(call if_changed,ld)
-
-$(obj)/styncpy.o: $(obj)/strncpy.o $(obj)/$(ev67-y)strncat.o \
-		 $(obj)/$(ev6-y)stxncpy.o FORCE
-	$(call if_changed,ld)
diff --git a/arch/alpha/lib/stycpy.S b/arch/alpha/lib/stycpy.S
new file mode 100644
index 000000000000..32ecd9c5f90d
--- /dev/null
+++ b/arch/alpha/lib/stycpy.S
@@ -0,0 +1,11 @@
+#include "strcpy.S"
+#ifdef CONFIG_ALPHA_EV67
+#include "ev67-strcat.S"
+#else
+#include "strcat.S"
+#endif
+#ifdef CONFIG_ALPHA_EV6
+#include "ev6-stxcpy.S"
+#else
+#include "stxcpy.S"
+#endif
diff --git a/arch/alpha/lib/styncpy.S b/arch/alpha/lib/styncpy.S
new file mode 100644
index 000000000000..72fc2754eb57
--- /dev/null
+++ b/arch/alpha/lib/styncpy.S
@@ -0,0 +1,11 @@
+#include "strncpy.S"
+#ifdef CONFIG_ALPHA_EV67
+#include "ev67-strncat.S"
+#else
+#include "strncat.S"
+#endif
+#ifdef CONFIG_ALPHA_EV6
+#include "ev6-stxncpy.S"
+#else
+#include "stxncpy.S"
+#endif

