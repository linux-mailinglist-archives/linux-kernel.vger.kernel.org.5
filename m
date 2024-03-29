Return-Path: <linux-kernel+bounces-126233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F17689340F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E74B24056
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918A442A90;
	Sun, 31 Mar 2024 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEwfdHvc"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1AE158A08
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903249; cv=fail; b=moLK0+WEROEZ2oXg5EZV+84KxL9XUWBM/nOprQSjQe4uXRKC80NQmac55GdVY8gwK3Wk+cQa/giI40GjLgv0Pint67tWiOQvU6QjXSCxcJ7h/27gv+I3OPRth1b7ZzuPgJ94geSvgqOem7FXQSovfZELxdAFZUrSXujVO7I6D2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903249; c=relaxed/simple;
	bh=LetMHBPBQXz6ixIsInVumoaExZfUK1GJsZvW08MI+m4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q1wDXjmnqErd7VZiB6SgsuEbUnVcMpOpTqeBxo+YUH8MnrPAKuZWZibm0PtUg/jcYuN/x1Ngv3caX45+dQjH0gS2uqf6ASF5OubSFQw7nZx39Nb5zeTej4IUcyycP1H7/h4FEEs/F3HbPrDIVWol1uTLx9gAdJzFIt5jexHgOrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEwfdHvc; arc=none smtp.client-ip=198.175.65.9; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5F964208AC;
	Sun, 31 Mar 2024 18:40:46 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TidHvkG87cI2; Sun, 31 Mar 2024 18:40:45 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 2B01B20842;
	Sun, 31 Mar 2024 18:40:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 2B01B20842
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 1E56780005E;
	Sun, 31 Mar 2024 18:40:45 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:40:44 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:42 +0000
X-sender: <linux-kernel+bounces-125446-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAeUemlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 11491
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125446-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com AC417200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEwfdHvc"
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711747630; cv=none; b=HhcIg39p2zm9vp7wuRRmy5yuvn6kguiRPND+Oc+QNfndskE7H+Qmz0eJPxz4zDueqfmUbq++7c/RJ3J7iTm0gWXQFvcCBJUNMD7GUlxME38d8d9pcvQbD6Y7MEyKy3M2N8rhd320DSelYs5FjqjEV4ibHfIwSAagQ65vBlkRm74=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711747630; c=relaxed/simple;
	bh=LetMHBPBQXz6ixIsInVumoaExZfUK1GJsZvW08MI+m4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZNaLcXHrH/pI2V8B4Mpg4KULZ4GDqaUbEJpjjobX8W7rr7esuNhuqZN20GOPPPXuhNIiCendozxIMl0PF3YkoOMV8zlGdpMN1vNPD9u20QmiefxvpMVBiT+3y+oHT7SWf2rEDEs9eiV9/uSw9wQjbVLsKmE8tiXCh5xahE2QJ2Y=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEwfdHvc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711747629; x=1743283629;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LetMHBPBQXz6ixIsInVumoaExZfUK1GJsZvW08MI+m4=;
  b=EEwfdHvcpPJhrPRqGLuhdR7hrkAU07XPH4QR6TPrSTuftJilzC3mqcv5
   cHoVLZ4QmONIISidOqz8rVts4T8piqFvObvvym70xHMyJ8lVIfcMLFalG
   oOWWS6tST3zkL9sjTZo32yOFbr5ro8D3BZ9uXDwRQnWuVnsV+3cBB79VK
   yMlHCRBdHJ0U3vCCsscEymChhgfNQkQ/hRrAYhG4WXF7ZN4H2rNAYo22l
   ZQsxPbH3lBZyq9Uic1og/lhDEM8lhSe1Q/izKhAfbYOEgbgYbAnTHBTl9
   GYXi0g/zsGI5NhnRU1plKCvuM1Opalv6fk2v270HeJZGwLdcMKc9HMHYr
   w==;
X-CSE-ConnectionGUID: niDxB5GzSOutHDpZK/RWcg==
X-CSE-MsgGUID: 4tgjrxNgQC+Fk5GAr85dWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="29430416"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="29430416"
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="48055763"
Date: Sat, 30 Mar 2024 05:26:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.03.27b 61/69] lib/cmpxchg-emu.c:24:11:
 warning: no previous prototype for 'cmpxchg_emu_u8'
Message-ID: <202403300508.Xz7XNp71-lkp@intel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.03.27b
head:   786fab3085d764055a78edb54023420920344333
commit: b48ffed4c636b96d2be7a93806870772ce34961f [61/69] csky: Emulate one-byte and two-byte cmpxchg
config: csky-allnoconfig (https://download.01.org/0day-ci/archive/20240330/202403300508.Xz7XNp71-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240330/202403300508.Xz7XNp71-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403300508.Xz7XNp71-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/cmpxchg-emu.c:24:11: warning: no previous prototype for 'cmpxchg_emu_u8' [-Wmissing-prototypes]
      24 | uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
         |           ^~~~~~~~~~~~~~
>> lib/cmpxchg-emu.c:51:11: warning: no previous prototype for 'cmpxchg_emu_u16' [-Wmissing-prototypes]
      51 | uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new)
         |           ^~~~~~~~~~~~~~~


vim +/cmpxchg_emu_u8 +24 lib/cmpxchg-emu.c

0bbce967f3ecfc Paul E. McKenney 2024-03-17  22  
0bbce967f3ecfc Paul E. McKenney 2024-03-17  23  /* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
0bbce967f3ecfc Paul E. McKenney 2024-03-17 @24  uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
0bbce967f3ecfc Paul E. McKenney 2024-03-17  25  {
0bbce967f3ecfc Paul E. McKenney 2024-03-17  26  	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
0bbce967f3ecfc Paul E. McKenney 2024-03-17  27  	int i = ((uintptr_t)p) & 0x3;
0bbce967f3ecfc Paul E. McKenney 2024-03-17  28  	union u8_32 old32;
0bbce967f3ecfc Paul E. McKenney 2024-03-17  29  	union u8_32 new32;
0bbce967f3ecfc Paul E. McKenney 2024-03-17  30  	u32 ret;
0bbce967f3ecfc Paul E. McKenney 2024-03-17  31  
0bbce967f3ecfc Paul E. McKenney 2024-03-17  32  	old32.w = READ_ONCE(*p32);
0bbce967f3ecfc Paul E. McKenney 2024-03-17  33  	do {
0bbce967f3ecfc Paul E. McKenney 2024-03-17  34  		if (old32.b[i] != old)
0bbce967f3ecfc Paul E. McKenney 2024-03-17  35  			return old32.b[i];
0bbce967f3ecfc Paul E. McKenney 2024-03-17  36  		new32.w = old32.w;
0bbce967f3ecfc Paul E. McKenney 2024-03-17  37  		new32.b[i] = new;
0bbce967f3ecfc Paul E. McKenney 2024-03-17  38  		instrument_atomic_read_write(p, 1);
0bbce967f3ecfc Paul E. McKenney 2024-03-17  39  		ret = data_race(cmpxchg(p32, old32.w, new32.w));
0bbce967f3ecfc Paul E. McKenney 2024-03-17  40  	} while (ret != old32.w);
0bbce967f3ecfc Paul E. McKenney 2024-03-17  41  	return old;
0bbce967f3ecfc Paul E. McKenney 2024-03-17  42  }
0bbce967f3ecfc Paul E. McKenney 2024-03-17  43  EXPORT_SYMBOL_GPL(cmpxchg_emu_u8);
0bbce967f3ecfc Paul E. McKenney 2024-03-17  44  
0bbce967f3ecfc Paul E. McKenney 2024-03-17  45  union u16_32 {
0bbce967f3ecfc Paul E. McKenney 2024-03-17  46  	u16 h[2];
0bbce967f3ecfc Paul E. McKenney 2024-03-17  47  	u32 w;
0bbce967f3ecfc Paul E. McKenney 2024-03-17  48  };
0bbce967f3ecfc Paul E. McKenney 2024-03-17  49  
0bbce967f3ecfc Paul E. McKenney 2024-03-17  50  /* Emulate two-byte cmpxchg() in terms of 4-byte cmpxchg. */
0bbce967f3ecfc Paul E. McKenney 2024-03-17 @51  uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new)

:::::: The code at line 24 was first introduced by commit
:::::: 0bbce967f3ecfc6da1e7e8756b0d398e791b8dee lib: Add one-byte and two-byte cmpxchg() emulation functions

:::::: TO: Paul E. McKenney <paulmck@kernel.org>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


