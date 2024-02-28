Return-Path: <linux-kernel+bounces-84860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB5D86ACB3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872571F22BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F712BF1D;
	Wed, 28 Feb 2024 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BCP34bii"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324147E577
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118627; cv=none; b=riRC4bSlxz4oEIAfXKBcyQLZNC9g4OgrF0h/e/q7kopptU33en83FBmx96rHZldKZ108Cz/nkCvrByPXoP+KMp6e/sDpjdLWTJrwesWkdUNn1M3ixQNUhely0dgz92Mh6jzY4wkY2cAs6b6Ho8w7TRmpujFbz+SvWxY0J1C1b+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118627; c=relaxed/simple;
	bh=PfqU7uA6b7dMR1kzf7jYeXTTRknNdOYXGPGnvYJA6Wo=;
	h=Message-ID:Date:MIME-Version:From:Subject:Cc:To:Content-Type; b=BNgrRR3NAMvMfmMBqknL+NGMmdrPS1JhGWTbo+TdMn3SN8WYMd5Jg+Nk8Q3NdY4CGfSPF+U2kupghXMb6HH1TKQ8bHXSSu0G6V8NpH/nfe/3IrgFMjApzD5U2IWbImX6uEf4OoacSYfmIv/RzNvEOn3RRPsU1YV8pi+d+QoG/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BCP34bii; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SB7V2R011223;
	Wed, 28 Feb 2024 11:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : cc : to : content-type :
 content-transfer-encoding; s=pp1;
 bh=52A2G+541bLMJ6jZjrElp7EEQT7x+XbUle4lY6JJPxg=;
 b=BCP34biiJCAtGfsHrexfjFQq22SVAAqKxinwgqOymiOqZBC0hAII9ainLIoBk2H72Wd6
 VESvjdbkHGXMFuJBF0tTaNysz/EdBzycjwCZxV+EnVZQgMUgbeEuiBFBjROUCyIwDbeV
 +kKwJZyTSrb/JJTNWGaKNKkxiwELLSx04HXuQX9IppENwg58nXZn3wMCXh3XpqwWIVHA
 AkD8KMkcGjAB5VB8w4rOcVKxqXLVUV70suQKqc2WO6v9KlVB+MV1B63Bv6Kh7CTrsQyh
 F0QnCvkad8+sT0OljXAfUOrNH71ehYMEBbODa3jQPIlwtkQ496QBtWUVRFHA0KEAAL0B Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj3p8g216-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 11:10:06 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41SB7uUp012145;
	Wed, 28 Feb 2024 11:10:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj3p8g20m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 11:10:05 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41SA1q2A012332;
	Wed, 28 Feb 2024 11:10:05 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfwg2ddh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 11:10:05 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41SBA2BT16319034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 11:10:04 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DC1F58060;
	Wed, 28 Feb 2024 11:10:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6A3858226;
	Wed, 28 Feb 2024 11:09:57 +0000 (GMT)
Received: from [9.43.45.154] (unknown [9.43.45.154])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Feb 2024 11:09:57 +0000 (GMT)
Message-ID: <3fcf3a2c-1c1b-42c1-bacb-78fdcd700389@linux.vnet.ibm.com>
Date: Wed, 28 Feb 2024 16:39:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: [revert 0d60d8df6f49] [net/net-next] [6.8-rc5] Build Failure
Cc: edumazet@google.com, arkadiusz.kubalewski@intel.com,
        vadim.fedorenko@linux.dev, jiri@nvidia.com, kuba@kernel.org,
        "abdhalee@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>,
        "mputtash@linux.vnet.com" <mputtash@linux.vnet.com>,
        "sachinp@linux.vnet.com" <sachinp@linux.vnet.com>,
        venkat88@linux.vnet.ibm.com
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sZ589O02l1ifUPtawFzvK7bMoGj-SKFR
X-Proofpoint-GUID: mOetCtA3rhIofLK0cfL6PpxVMBb8ZdfP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=749 impostorscore=0 clxscore=1011 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402280088

Greetings,

[revert 0d60d8df6f49] [net/net-next] [6.8-rc5] Build Failure

Reverting below commit fixes the issue

commit 0d60d8df6f493bb46bf5db40d39dd60a1bafdd4e
     dpll: rely on rcu for netdev_dpll_pin()

--- Traces ---

/include/linux/dpll.h: In function ‘netdev_dpll_pin’:
/include/linux/rcupdate.h:439:9: error: dereferencing pointer to 
incomplete type ‘struct dpll_pin’
   typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
          ^
/include/linux/rcupdate.h:587:2: note: in expansion of macro 
‘__rcu_dereference_check’
   __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
   ^~~~~~~~~~~~~~~~~~~~~~~
/include/linux/rtnetlink.h:70:2: note: in expansion of macro 
‘rcu_dereference_check’
   rcu_dereference_check(p, lockdep_rtnl_is_held())
   ^~~~~~~~~~~~~~~~~~~~~
/include/linux/dpll.h:175:9: note: in expansion of macro 
‘rcu_dereference_rtnl’
   return rcu_dereference_rtnl(dev->dpll_pin);
          ^~~~~~~~~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:243: drivers/dpll/dpll_core.o] Error 1
make[4]: *** Waiting for unfinished jobs....
   AR      net/mpls/built-in.a
   AR      net/l3mdev/built-in.a
In file included from ./include/linux/rbtree.h:24,
                  from ./include/linux/mm_types.h:11,
                  from ./include/linux/mmzone.h:22,
                  from ./include/linux/gfp.h:7,
                  from ./include/linux/umh.h:4,
                  from ./include/linux/kmod.h:9,
                  from ./include/linux/module.h:17,
                  from drivers/dpll/dpll_netlink.c:9:
/include/linux/dpll.h: In function ‘netdev_dpll_pin’:
/include/linux/rcupdate.h:439:9: error: dereferencing pointer to 
incomplete type ‘struct dpll_pin’
   typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
          ^
/include/linux/rcupdate.h:587:2: note: in expansion of macro 
‘__rcu_dereference_check’
   __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
   ^~~~~~~~~~~~~~~~~~~~~~~
/include/linux/rtnetlink.h:70:2: note: in expansion of macro 
‘rcu_dereference_check’
   rcu_dereference_check(p, lockdep_rtnl_is_held())
   ^~~~~~~~~~~~~~~~~~~~~
/include/linux/dpll.h:175:9: note: in expansion of macro 
‘rcu_dereference_rtnl’
   return rcu_dereference_rtnl(dev->dpll_pin);
          ^~~~~~~~~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:243: drivers/dpll/dpll_netlink.o] 
Error 1
make[3]: *** [scripts/Makefile.build:481: drivers/dpll] Error 2
make[3]: *** Waiting for unfinished jobs....
In file included from ./arch/powerpc/include/generated/asm/rwonce.h:1,
                  from ./include/linux/compiler.h:251,
                  from ./include/linux/instrumented.h:10,
                  from ./include/linux/uaccess.h:6,
                  from net/core/dev.c:71:
net/core/dev.c: In function ‘netdev_dpll_pin_assign’:
/include/linux/rcupdate.h:462:36: error: dereferencing pointer to 
incomplete type ‘struct dpll_pin’
  #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
                                     ^~~~
/include/asm-generic/rwonce.h:55:33: note: in definition of macro 
‘__WRITE_ONCE’
   *(volatile typeof(x) *)&(x) = (val);    \
                                  ^~~
/arch/powerpc/include/asm/barrier.h:76:2: note: in expansion of macro 
‘WRITE_ONCE’
   WRITE_ONCE(*p, v);      \
   ^~~~~~~~~~
/include/asm-generic/barrier.h:172:55: note: in expansion of macro 
‘__smp_store_release’
  #define smp_store_release(p, v) do { kcsan_release(); 
__smp_store_release(p, v); } while (0)
^~~~~~~~~~~~~~~~~~~
/include/linux/rcupdate.h:503:3: note: in expansion of macro 
‘smp_store_release’
    smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
    ^~~~~~~~~~~~~~~~~
/include/linux/rcupdate.h:503:25: note: in expansion of macro 
‘RCU_INITIALIZER’
    smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
                          ^~~~~~~~~~~~~~~
net/core/dev.c:9081:2: note: in expansion of macro ‘rcu_assign_pointer’
   rcu_assign_pointer(dev->dpll_pin, dpll_pin);
   ^~~~~~~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:243: net/core/dev.o] Error 1
make[4]: *** Waiting for unfinished jobs....
   AR      drivers/net/ethernet/built-in.a
   AR      drivers/net/built-in.a
   AR      net/dcb/built-in.a
   AR      net/netlabel/built-in.a
   AR      net/strparser/built-in.a
   AR      net/handshake/built-in.a
   GEN     lib/test_fortify.log
   AR      net/8021q/built-in.a
   AR      net/nsh/built-in.a
   AR      net/unix/built-in.a
   CC      lib/string.o
   AR      net/packet/built-in.a
   AR      net/switchdev/built-in.a
   AR      lib/lib.a
   AR      net/mptcp/built-in.a
   AR      net/devlink/built-in.a
In file included from ./include/linux/rbtree.h:24,
                  from ./include/linux/mm_types.h:11,
                  from ./include/linux/mmzone.h:22,
                  from ./include/linux/gfp.h:7,
                  from ./include/linux/umh.h:4,
                  from ./include/linux/kmod.h:9,
                  from ./include/linux/module.h:17,
                  from net/core/rtnetlink.c:17:
/include/linux/dpll.h: In function ‘netdev_dpll_pin’:
/include/linux/rcupdate.h:439:9: error: dereferencing pointer to 
incomplete type ‘struct dpll_pin’
   typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
          ^
/include/linux/rcupdate.h:587:2: note: in expansion of macro 
‘__rcu_dereference_check’
   __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
   ^~~~~~~~~~~~~~~~~~~~~~~
/include/linux/rtnetlink.h:70:2: note: in expansion of macro 
‘rcu_dereference_check’
   rcu_dereference_check(p, lockdep_rtnl_is_held())
   ^~~~~~~~~~~~~~~~~~~~~
/include/linux/dpll.h:175:9: note: in expansion of macro 
‘rcu_dereference_rtnl’
   return rcu_dereference_rtnl(dev->dpll_pin);
          ^~~~~~~~~~~~~~~~~~~~
In file included from net/core/rtnetlink.c:60:
/include/linux/dpll.h:179:1: error: control reaches end of non-void 
function [-Werror=return-type]
  }

-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center


