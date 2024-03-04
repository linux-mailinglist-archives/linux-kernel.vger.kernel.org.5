Return-Path: <linux-kernel+bounces-90515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D371D870078
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041681C22130
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC32E39843;
	Mon,  4 Mar 2024 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QQItQUT+"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C88E3A1A6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552041; cv=none; b=m8eACxpoT9k6ma1IKa0nAuRIKcBi7UI2A+nj2JO6ebTj523EtIiyKHnvSzF4/qo9vapquVAAjFhSLd1I5UfBIrSi2hGWxhmWqwevsAZsIm3i3y4hxZdblLlQUwN3duV29/4mGCe+bysYibdlHUJsV0t4gjSm5+GXjuCLknZhjh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552041; c=relaxed/simple;
	bh=Zs4eOa9lD0S3V+GxqVGupl5/7/G3drv1pzhvefiMB4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOedJacgBkuF1eSxekgP24q30yyYOZCTn5t8Duzfn94nwjwVVE6FKIZ1XHeB06dCqb6TNVyObtUsXLuwAESazVIrJSF1UbcyziCUFJNG25Pl9vNuAGlHFW0EYV5hHaGZY8Tz3jZ3521UxNWNVeFks9VIjK18291B1+OnKIEgccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QQItQUT+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BS8UI018293;
	Mon, 4 Mar 2024 11:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=W3YhFb5udMiWpiD5ED3rnz22UVMNWRAFfwYUifVJGjM=;
 b=QQItQUT+10IvMMVbC6HyqckhdKaHC2lUUnNf62gTAfbnLmwsoKFkB16xr2HqEzE0NvHw
 mFc9XN6pcElI1btDiwGCLsTOXZcbDUqJCeEaN1HawRnY9mPbH8xL+djF0RxahZCIEKHR
 7UbAz90/a+h0H6XEN60ZBtqcOfAOQ8gL1/VcHJeAuzgd1w37vhGOaDgaC4bFCWrU84Yb
 4O6hBMm+nJjvweHwg1N5HZXbaA+CvFjt40kJXhEHVfTwsKMZlQlvOndsqVmBst+VlR7B
 FqNPD0NTMogqadJs3yp4oqLD5u7W/70ER+uaUZRBcGh01aUL0a1sQINTPYv53W2hN4PO dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wndes84yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 11:33:32 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 424BSATf018360;
	Mon, 4 Mar 2024 11:33:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wndes84y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 11:33:32 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4249is6l025387;
	Mon, 4 Mar 2024 11:33:31 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmety8cat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 11:33:31 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 424BXSwr38600994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Mar 2024 11:33:30 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADF0F5803F;
	Mon,  4 Mar 2024 11:33:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B30D58067;
	Mon,  4 Mar 2024 11:33:24 +0000 (GMT)
Received: from [9.43.29.6] (unknown [9.43.29.6])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Mar 2024 11:33:24 +0000 (GMT)
Message-ID: <1d929941-2017-4137-990c-94453acd248f@linux.vnet.ibm.com>
Date: Mon, 4 Mar 2024 17:03:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [revert 0d60d8df6f49] [net/net-next] [6.8-rc5] Build Failure
Content-Language: en-US
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        edumazet@google.com
Cc: arkadiusz.kubalewski@intel.com, jiri@nvidia.com, kuba@kernel.org,
        "abdhalee@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>,
        "mputtash@linux.vnet.com" <mputtash@linux.vnet.com>,
        "sachinp@linux.vnet.com" <sachinp@linux.vnet.com>,
        venkat88@linux.vnet.ibm.com,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <3fcf3a2c-1c1b-42c1-bacb-78fdcd700389@linux.vnet.ibm.com>
 <85b78dad-affa-47c3-9cd0-79a4321460b8@linux.dev>
From: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
In-Reply-To: <85b78dad-affa-47c3-9cd0-79a4321460b8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HzI-RWxLrbYO1QSa3gC1JbofOjRLG2_g
X-Proofpoint-ORIG-GUID: MSoKidZkKyl_dfrSPD48IY8Jfz8ZVPSe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_06,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=957 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403040087

Greetings,

The build error is seen on linux-next and mainline also

Mainline : 6.8.0-rc7

linux-next : 6.8.0-rc7-next-20240304

--- Traces ---

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

On 2/28/24 19:37, Vadim Fedorenko wrote:
> On 28/02/2024 11:09, Tasmiya Nalatwad wrote:
>> Greetings,
>>
>> [revert 0d60d8df6f49] [net/net-next] [6.8-rc5] Build Failure
>>
>> Reverting below commit fixes the issue
>>
>> commit 0d60d8df6f493bb46bf5db40d39dd60a1bafdd4e
>>      dpll: rely on rcu for netdev_dpll_pin()
>>
>> --- Traces ---
>>
>> ./include/linux/dpll.h: In function ‘netdev_dpll_pin’:
>> ./include/linux/rcupdate.h:439:9: error: dereferencing pointer to 
>> incomplete type ‘struct dpll_pin’
>>    typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>>           ^
>> ./include/linux/rcupdate.h:587:2: note: in expansion of macro 
>> ‘__rcu_dereference_check’
>>    __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>>    ^~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/rtnetlink.h:70:2: note: in expansion of macro 
>> ‘rcu_dereference_check’
>>    rcu_dereference_check(p, lockdep_rtnl_is_held())
>>    ^~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/dpll.h:175:9: note: in expansion of macro 
>> ‘rcu_dereference_rtnl’
>>    return rcu_dereference_rtnl(dev->dpll_pin);
>>           ^~~~~~~~~~~~~~~~~~~~
>> make[4]: *** [scripts/Makefile.build:243: drivers/dpll/dpll_core.o] 
>> Error 1
>> make[4]: *** Waiting for unfinished jobs....
>>    AR      net/mpls/built-in.a
>>    AR      net/l3mdev/built-in.a
>> In file included from ./include/linux/rbtree.h:24,
>>                   from ./include/linux/mm_types.h:11,
>>                   from ./include/linux/mmzone.h:22,
>>                   from ./include/linux/gfp.h:7,
>>                   from ./include/linux/umh.h:4,
>>                   from ./include/linux/kmod.h:9,
>>                   from ./include/linux/module.h:17,
>>                   from drivers/dpll/dpll_netlink.c:9:
>> ./include/linux/dpll.h: In function ‘netdev_dpll_pin’:
>> ./include/linux/rcupdate.h:439:9: error: dereferencing pointer to 
>> incomplete type ‘struct dpll_pin’
>>    typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>>           ^
>> ./include/linux/rcupdate.h:587:2: note: in expansion of macro 
>> ‘__rcu_dereference_check’
>>    __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>>    ^~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/rtnetlink.h:70:2: note: in expansion of macro 
>> ‘rcu_dereference_check’
>>    rcu_dereference_check(p, lockdep_rtnl_is_held())
>>    ^~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/dpll.h:175:9: note: in expansion of macro 
>> ‘rcu_dereference_rtnl’
>>    return rcu_dereference_rtnl(dev->dpll_pin);
>>           ^~~~~~~~~~~~~~~~~~~~
>> make[4]: *** [scripts/Makefile.build:243: 
>> drivers/dpll/dpll_netlink.o] Error 1
>> make[3]: *** [scripts/Makefile.build:481: drivers/dpll] Error 2
>> make[3]: *** Waiting for unfinished jobs....
>> In file included from ./arch/powerpc/include/generated/asm/rwonce.h:1,
>>                   from ./include/linux/compiler.h:251,
>>                   from ./include/linux/instrumented.h:10,
>>                   from ./include/linux/uaccess.h:6,
>>                   from net/core/dev.c:71:
>> net/core/dev.c: In function ‘netdev_dpll_pin_assign’:
>> ./include/linux/rcupdate.h:462:36: error: dereferencing pointer to 
>> incomplete type ‘struct dpll_pin’
>>   #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
>>                                      ^~~~
>> ./include/asm-generic/rwonce.h:55:33: note: in definition of macro 
>> ‘__WRITE_ONCE’
>>    *(volatile typeof(x) *)&(x) = (val);    \
>>                                   ^~~
>> ./arch/powerpc/include/asm/barrier.h:76:2: note: in expansion of 
>> macro ‘WRITE_ONCE’
>>    WRITE_ONCE(*p, v);      \
>>    ^~~~~~~~~~
>> ./include/asm-generic/barrier.h:172:55: note: in expansion of macro 
>> ‘__smp_store_release’
>>   #define smp_store_release(p, v) do { kcsan_release(); 
>> __smp_store_release(p, v); } while (0)
>> ^~~~~~~~~~~~~~~~~~~
>> ./include/linux/rcupdate.h:503:3: note: in expansion of macro 
>> ‘smp_store_release’
>>     smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
>>     ^~~~~~~~~~~~~~~~~
>> ./include/linux/rcupdate.h:503:25: note: in expansion of macro 
>> ‘RCU_INITIALIZER’
>>     smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
>>                           ^~~~~~~~~~~~~~~
>> net/core/dev.c:9081:2: note: in expansion of macro ‘rcu_assign_pointer’
>>    rcu_assign_pointer(dev->dpll_pin, dpll_pin);
>>    ^~~~~~~~~~~~~~~~~~
>> make[4]: *** [scripts/Makefile.build:243: net/core/dev.o] Error 1
>> make[4]: *** Waiting for unfinished jobs....
>>    AR      drivers/net/ethernet/built-in.a
>>    AR      drivers/net/built-in.a
>>    AR      net/dcb/built-in.a
>>    AR      net/netlabel/built-in.a
>>    AR      net/strparser/built-in.a
>>    AR      net/handshake/built-in.a
>>    GEN     lib/test_fortify.log
>>    AR      net/8021q/built-in.a
>>    AR      net/nsh/built-in.a
>>    AR      net/unix/built-in.a
>>    CC      lib/string.o
>>    AR      net/packet/built-in.a
>>    AR      net/switchdev/built-in.a
>>    AR      lib/lib.a
>>    AR      net/mptcp/built-in.a
>>    AR      net/devlink/built-in.a
>> In file included from ./include/linux/rbtree.h:24,
>>                   from ./include/linux/mm_types.h:11,
>>                   from ./include/linux/mmzone.h:22,
>>                   from ./include/linux/gfp.h:7,
>>                   from ./include/linux/umh.h:4,
>>                   from ./include/linux/kmod.h:9,
>>                   from ./include/linux/module.h:17,
>>                   from net/core/rtnetlink.c:17:
>> ./include/linux/dpll.h: In function ‘netdev_dpll_pin’:
>> ./include/linux/rcupdate.h:439:9: error: dereferencing pointer to 
>> incomplete type ‘struct dpll_pin’
>>    typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>>           ^
>> ./include/linux/rcupdate.h:587:2: note: in expansion of macro 
>> ‘__rcu_dereference_check’
>>    __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>>    ^~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/rtnetlink.h:70:2: note: in expansion of macro 
>> ‘rcu_dereference_check’
>>    rcu_dereference_check(p, lockdep_rtnl_is_held())
>>    ^~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/dpll.h:175:9: note: in expansion of macro 
>> ‘rcu_dereference_rtnl’
>>    return rcu_dereference_rtnl(dev->dpll_pin);
>>           ^~~~~~~~~~~~~~~~~~~~
>> In file included from net/core/rtnetlink.c:60:
>> ./include/linux/dpll.h:179:1: error: control reaches end of non-void 
>> function [-Werror=return-type]
>>   }
>>
>
> Hi, Eric!
>
> Looks like we have to move struct dpll_pin definition to 
> include/linux/dpll.h to have this fixed, right?
>
>
-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center


