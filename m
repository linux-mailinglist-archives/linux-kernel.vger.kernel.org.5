Return-Path: <linux-kernel+bounces-32527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A3F835CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021321C21265
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB39A33CF8;
	Mon, 22 Jan 2024 08:32:34 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CBE2110B;
	Mon, 22 Jan 2024 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912354; cv=none; b=ksdP0qfb+rrtrEIAq5RHccOfk68Rj2lr9YS8bJ1pH78ndN3j+SCQmKvYbxFT62CLcpEEo9msf+0bDonc6ZQKsaeMLId5kOekx4ecdpgdf1bbxw3LAZ3O2+gn/QalSzRq8J8y8omDC88Qxsv8LFAWKzIrbtXa94zzCjkQtqxhQXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912354; c=relaxed/simple;
	bh=hI3RltjIMGXevPYm0LRBHuDZvSVHVegDJEQwPNgLkhk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=TfekZDLkKEXKuWyXMoK/GOg97uPWKvPLddywvUppNCRf9RH/LAp77rOledWPERahFnyBOMEtEYErKszsFCzOPFaR7FpQipqY5knMlqd4ahy1noOsVf24gaq97u9y3yocxarM5lk5qnbeeyx7roJpaRCXlaysywwl6TanI3L537U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.5I.B1_1705912333;
Received: from 30.221.145.129(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.5I.B1_1705912333)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 16:32:26 +0800
Message-ID: <be1abcda-4cf0-4441-9a27-831eaef28f2e@linux.alibaba.com>
Date: Mon, 22 Jan 2024 16:32:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: [MAYBE REGRESSION] kbuild time of kernel compiling
To: linux-kbuild@vger.kernel.org, masahiroy@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, nicolas@fjasle.eu
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I noticed a regression of kbuild time in v6.7, especially when running
`make` command when all images have already been compiled.  In v6.6 it
takes ~3s, while in v6.7 it takes ~18s.

I'm not sure if it's a known issue, or an extra action configurable with
a "CONFIG_XX" option.


Following is the kbuild time in v6.6 versus v7.7, with
arch/x86/configs/x86_64_defconfig used here:


v6.6
```
make clean
make olddefconfig

# first full compiling
$time make bzImage -j128 -s

real	1m9.896s
user	36m56.153s
sys	4m21.748s

# second time with image already compiled
$time make bzImage -j128 -s

real	0m2.776s
user	0m13.823s
sys	0m3.936s
```


v6.7
```
make clean
make olddefconfig

# first full compiling
$time make bzImage -j128 -s

real	1m22.865s
user	37m25.977s
sys	4m22.094s

# second time with image already compiled
$time make bzImage -j128 -s

real	0m18.209s
user	0m29.243s
sys	0m4.330s
```


I tried to bisect, while commit d4e175f2c460 ("Merge tag 'vfs-6.7.super'
of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs") is identified
as the first bad commit, which is obviously wrong.  As I'm not familiar
with the structure of the merge commit, the further investigation has
not been made yet.


Besides, it seems that it will take most of the time before "CALL
scripts/checksyscalls.sh" is printed (with "INSTALL libsubcmd_headers"
has already printed).

$time make bzImage -j128
  DESCEND objtool
  INSTALL libsubcmd_headers

  CALL    scripts/checksyscalls.sh
  BUILD   arch/x86/boot/bzImage
Kernel: arch/x86/boot/bzImage is ready  (#437)

-- 
Thanks,
Jingbo

