Return-Path: <linux-kernel+bounces-2869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49FB816379
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C5A282325
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7919B4B12D;
	Sun, 17 Dec 2023 23:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="ZyGWsNXM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293BF4B123
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 23:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id CDA75240101
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 00:46:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1702856767; bh=B7Ta4BYxySDCYAL3BF4XbGL4luNo1llUkloFHtXOoVs=;
	h=MIME-Version:Content-Transfer-Encoding:Date:From:To:Cc:Subject:
	 Message-ID:From;
	b=ZyGWsNXMb73ZimzRWC8KpTrQ+30HjjWda/KoDSvKsOQEGCrzdKlLy5m7hW7/8Tm7f
	 MBtzND3hwMPUo+WkceoPHGyQoN1hiI3OM8rjKoOLaCPVQDQhfM55aMqfX42CcXzKeF
	 OgpEDPsx9A4u1qlBgBvvCT/vGvvni3yZg1GNH7kq3J6n+pPYlMaQan3c9+xa4uqryP
	 Kpszl1xMWdPbLmrYfINnc22GmYGpAAQLI7BSFZbR9rzue0vEgQ9oYw4olBYKT9zZpC
	 KCyZI4jh+FTKNsT509UY0WmVCeR0NtpyCpRv74lZVXv2nFIKIhI0J3d0VTzCxcm7+q
	 F5kwgKsavWURQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4StfjW0LjSz9rxF;
	Mon, 18 Dec 2023 00:46:06 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sun, 17 Dec 2023 23:46:06 +0000
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Irrelevant documentation recommending the use of
 "include/linux/kernel.h"
Message-ID: <bc63acd7ef43bdd8d9609fa48dbf92f9@posteo.net>

Dear Maintainer,

The section "18) Don't re-invent the kernel macros" in
"Linux kernel coding style" (Documentation/process/coding-style.rst)
recommends re-using the macros defined in "include/linux/kernel.h"
instead of the improvised ones locally.

However, There's a note in the comment block added by commit 
40cbf09f060c
("kernel.h: include a note to discourage people from including it in 
headers")
two years ago, saying that there's an in-progress splitting of kernel.h
and inclusion in headers under include/ is discouraged.

Considering that the section was added 17 years ago by commit 
58637ec90b7c
("Add a new section to CodingStyle, promoting include/linux/kernel.h"),
the section about kernel.h in the "Linux kernel coding style" 
documentation seems outdated.

Reproduction steps:

```sh
# cd to the kernel source tree
cd path/to/source/linux
# Show the git blame of the documentation section added in 2006
git blame -L 1051,1071 Documentation/process/coding-style.rst
# Show the comment note on top of include/linux/kernel.h added in 2022
git blame -L 2,10 include/linux/kernel.h
```

Should we change

```
The header file include/linux/kernel.h
```

to something like

```
The header files under the include/linux/ directory
```

or a specific header that contains standalone helper macros?

It might be out of scope here,
but such a header that collects standalone helping macros
seems non-existent so far.
It would be great to have one that contains things like
"STRINGIFY", "CONCATENATE" (or "PASTE"), "UNIQUE_ID"
and other helper macros without external dependencies.
There's one called "include/linux/util_macros.h", but it depends on 
"include/linux/math.h".

It's the first time for me to report an issue in LKML.
Please kindly point out anything
that I should fix or could improve.

Best regards,

Shamrock

