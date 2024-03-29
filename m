Return-Path: <linux-kernel+bounces-125519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94158927B4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DD62839A0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513BF13E881;
	Fri, 29 Mar 2024 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCUtJric"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED713F447;
	Fri, 29 Mar 2024 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711753695; cv=none; b=qeYhJkMFIDl5k9ixFMfPDE2MINPURgsNot/rccX2DpPqZNDzHzPXJfMKjodx2tLYb2k+7NQ/qM3dzN9SoP+lBWu62jBBBryAsExXwKNK+9DPYUxn04p4oiWiE/a0++L2Q8fPXVQjEkYoyMkuEY5GigXe4mSUThs+rLes4d1qvcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711753695; c=relaxed/simple;
	bh=YDvBnJDT+P+FfR2r2Xqdl1/sni05Zype/Cn8wCryMVk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GnT7vifvc8v+dwKPTDJFQB97tgk8Lrz8AQ/sQqQwxVerCllHtB57ZWCsCW5e7zv9bhWUsttIWx1H2F18x+Xf5vzol1Jj5aIHdL8Jf3i8V2g1z6UBGt0NnWolZ99spp1lYwGyJN5Mi5tsloFC7d3naHnXql+XXLAxsK5ms5NApYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCUtJric; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-430a65e973bso15098421cf.3;
        Fri, 29 Mar 2024 16:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711753693; x=1712358493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MImVHWtFYfRRx31LLQmyf0lh9NeToatxJG5zQIijxdg=;
        b=LCUtJricYIhT8rHbkMKsD9eQGqKJgjnKhBW6NhiK9woaOGxQxJCPJQHU/Mgd+dqrI1
         khGcSTSfEAZCX8Ufa8bq2Swa3jHC+6yM169ajjwL1ZLKQCV5bXfR66CLH/xpF66N+ZQk
         ytTABHCzz3prNbQ8Ow/D1Gv4JDRIiXmcTY6IeqBiCu74sTZ8NyqLU0rjGc41YJX/0eVM
         8q4NpvcGIjtpSdPmCOIwPlVWOvadozOou0yf5J0JT5eu++/SjfQ3eSsTJb09nGTBQWN+
         jq0gGzKd5QLwBEHJnZt/BFKMjY/ENu/P8FU7YT2IoL8mhvcuPXPxQmka5vzKArqpKQlG
         ZvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711753693; x=1712358493;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MImVHWtFYfRRx31LLQmyf0lh9NeToatxJG5zQIijxdg=;
        b=lQg4m5GEfXWFDDmeVikvOK+dTQ/mzTSXrv0O/HY3Rh+t8jEsOunl8JeqEOwnioh9jX
         R8lloRN7ENdK0mQeRjUg9ojuznmSWGGgibwme2CKQU2YNcXJ9dh51vDB9oCJvQbCVgG0
         F816QXoufIUJ8jnoCCo/KVK+enK2+GBP92nA0KT9oUMz3wtID/w6UTFUhvAoASGNlWo+
         bRF1P6paFUw/UfH3KfFqIn84VkdJBInNCgoOULAO71cdWYQ9DGR1P4K463KeTNeN911K
         Mo+JriTB4LAMcudNWt59k9KbxvVDu2i6FcjziWNWBxjhUbPvHzCzyooN5DXYZpiDsv0/
         HLJA==
X-Forwarded-Encrypted: i=1; AJvYcCWvxrFK7ROU9gMrHUvZg++NZnBTZ8mKqciPmSwpYTayPheJaEoyixyzUg5Qf2HAqzN9IR0JnRQl5jEWMKUDxgv78WNPoNmJbz0mHW9Sj9UiZooV0QpbhHxhKBtc93gUyy6HgpJh
X-Gm-Message-State: AOJu0YwTnwWS8Nh1OYPpVvC7p3MzLtaIfdPsKbd3gq2nrejsrc5+BJQZ
	ANRL0wIl/bucDVhjIg63O9fZnIBnUarEMHwIjWe2Ciz52m/Ih4/k7nmW3SYE6eyiJZUO/nxLxge
	VNGz8R8GDamru+U++BxBeyks7k1Y=
X-Google-Smtp-Source: AGHT+IGtVP3a1ZWHImv3JvX7fzhAVtdFRCfPVGnDc7XL/LZK6jZh80RoqP3Av+VNlaKB5Ww8QGCGT4WVRbJ0j51ujW0=
X-Received: by 2002:a05:622a:306:b0:432:b741:73b4 with SMTP id
 q6-20020a05622a030600b00432b74173b4mr3422703qtw.9.1711753692979; Fri, 29 Mar
 2024 16:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Charlemagne Lasse <charlemagnelasse@gmail.com>
Date: Sat, 30 Mar 2024 00:08:02 +0100
Message-ID: <CAFGhKbz70E3vihRkG4Hi20Tw8i7mGp=Z6j+NnELDTJd9cj9+Aw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] scripts: checkpatch: check unused parameters for
 function-like macro
To: Barry Song <21cnbao@gmail.com>, Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, Andy Whitcroft <apw@canonical.com>, 
	Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, lukas.bulwahn@gmail.com
Cc: LKML <linux-kernel@vger.kernel.org>, Xining Xu <ma.xxn@outlook.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Can this patch please be dropped from Linux-next (currently via
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm#mm-everything)?
It is obviously wrong when dealing with named variadic macro
parameters:

 ./scripts/checkpatch.pl -f include/linux/rculist.h
ERROR: Parameter 'dummy' is not used in function-like macro, please
use static inline instead
#51: FILE: include/linux/rculist.h:51:
+#define __list_check_rcu(dummy, cond, extra...)
         \
+       ({                                                              \
+       check_arg_count_one(extra);                                     \
+       RCU_LOCKDEP_WARN(!(cond) && !rcu_read_lock_any_held(),          \
+                        "RCU-list traversed in non-reader section!");  \
+       })

ERROR: Parameter 'extra...' is not used in function-like macro, please
use static inline instead
#51: FILE: include/linux/rculist.h:51:
+#define __list_check_rcu(dummy, cond, extra...)
         \
+       ({                                                              \
+       check_arg_count_one(extra);                                     \
+       RCU_LOCKDEP_WARN(!(cond) && !rcu_read_lock_any_held(),          \
+                        "RCU-list traversed in non-reader section!");  \
+       })

ERROR: Parameter 'dummy' is not used in function-like macro, please
use static inline instead
#64: FILE: include/linux/rculist.h:64:
+#define __list_check_rcu(dummy, cond, extra...)
         \
+       ({ check_arg_count_one(extra); })

ERROR: Parameter 'cond' is not used in function-like macro, please use
static inline instead
#64: FILE: include/linux/rculist.h:64:
+#define __list_check_rcu(dummy, cond, extra...)
         \
+       ({ check_arg_count_one(extra); })

ERROR: Parameter 'extra...' is not used in function-like macro, please
use static inline instead
#64: FILE: include/linux/rculist.h:64:
+#define __list_check_rcu(dummy, cond, extra...)
         \
+       ({ check_arg_count_one(extra); })

