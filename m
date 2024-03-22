Return-Path: <linux-kernel+bounces-111182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B488868CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8A62853DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEB11AAD4;
	Fri, 22 Mar 2024 09:05:39 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7DF171AC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098338; cv=none; b=e7x9q5/FWu/dY2loKnaJSlO+3V4boDlU1vM77tfWaVOgYFJbESk0GYDw5avV1fMGqyXW7ka0iIcRtKN2KgbVR4BPih4rjGctnPctylMOORN9NAdRtEQgaDrjPYP05oFMJzcwhDQ5uZahfoNy0NjkMWsu455VdASbnZlMejRWRGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098338; c=relaxed/simple;
	bh=0SfqVZk9hcRK6f4B5G6z0EpueUIq5c4y6dDJtYndN1Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O54b5QKH3pVkY648geusCWQR/ysDcD+fg0pkyISYOoUsqw5Ih2C8BlOBJ1zJ7H3R1X5ljMF9SJ3W16iPdWMctVbb3ewK/uGz2tHLvZfMIL/mlTO70m3Z9wl6fKj/VKoH6+9Ww9rx+h1aIMZuYpMxMjhGE687K5ntn9oJ5xI55q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msexch01.omp.ru (10.188.4.12) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 22 Mar
 2024 12:05:32 +0300
Received: from msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753]) by
 msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753%5]) with mapi id 15.02.1258.012;
 Fri, 22 Mar 2024 12:05:32 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
	<chao@kernel.org>
CC: "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, "Karina
 Yankevich" <k.yankevich@omp.ru>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [bug report] fs: f2fs: integer overflow in
 f2fs_truncate_inode_blocks()
Thread-Topic: [bug report] fs: f2fs: integer overflow in
 f2fs_truncate_inode_blocks()
Thread-Index: AQHafDfLQelSTjCNm0mAqA97oN6w2Q==
Date: Fri, 22 Mar 2024 09:05:32 +0000
Message-ID: <085b27fd2b364a3c8c3a9ca77363e246@omp.ru>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: msexch01.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 3/22/2024 6:00:00 AM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello.=20

There is a possible bug in f2fs_truncate_inode_blocks():

    if (err < 0 && err !=3D -ENOENT)
    			goto fail;
        ...
        offset[1] =3D 0;
        offset[0]++;
        nofs +=3D err;

If err =3D -ENOENT then nofs will sum with an error code,
which is strange behaviour. Also if nofs < ENOENT this will
cause an overflow. err will be equal to -ENOENT with the
following call stack:

truncate_nodes()
  f2fs_get_node_page()
     __get_node_page()
        read_node_page()

It looks like ENOENT processing is missing here. What can you
say about it? How can it be fixed?

Found by Linux Verification Center (linuxtesting.org) with the
Svace static analysis tool.=

