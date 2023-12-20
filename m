Return-Path: <linux-kernel+bounces-6984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B3F81A019
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975011C22696
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159973529C;
	Wed, 20 Dec 2023 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KVvA48/y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D845224C8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKDgd4Q027406;
	Wed, 20 Dec 2023 13:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fcHRCp5w2YWuy/eMqRaODPsb4JubOz1Zn5ZsnKondP8=;
 b=KVvA48/y1qGodZjd9vWCsbMLcbcZAm3DcpahgXjBd5zmMY92Banjx44BvjoznuAyWJeK
 Q2sayj/uwI+DjtRfrdTIfLdOkiL/+G8LSVICSGgpt6QvaxbR/n8UA18jYgBKM5GZZGMy
 SFCikWA4t8mz6Ahk58aU0pq8LpUX8dr684ebAx93J3JV9uyBe+oEci5vxJOGZS/2/6Ei
 hagxBSTri/430fBoJgmVQrviGw70QkyC3hV3TmZBVn9JFl3/2OKZNogCcWX/EGncI3vB
 P5HihpfeDWzVa+f9MfdLokTZyzS1xo2hunipuH769DhYStaYgV+qlZPQP3C5TuMHdcoa SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3q9jpq4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 13:45:44 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BKDgCc1026504;
	Wed, 20 Dec 2023 13:45:44 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3q9jpq48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 13:45:43 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKBe1v4013890;
	Wed, 20 Dec 2023 13:45:42 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1qqkeh7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 13:45:42 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BKDjf8o1507850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 13:45:41 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57E9E5805F;
	Wed, 20 Dec 2023 13:45:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D6595805A;
	Wed, 20 Dec 2023 13:45:39 +0000 (GMT)
Received: from [9.109.245.191] (unknown [9.109.245.191])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Dec 2023 13:45:39 +0000 (GMT)
Message-ID: <7baea98a-90ff-4c2d-9d00-d3ddc715c235@linux.vnet.ibm.com>
Date: Wed, 20 Dec 2023 19:15:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v3 0/4] mm/mglru: Kconfig cleanup
Content-Language: en-US
To: Yu Zhao <yuzhao@google.com>, Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231220040037.883811-1-kinseyho@google.com>
 <CAOUHufaK3X0d9ovEMkFfb3cugqzcnxxqn=o6O-1oohaYANtB0A@mail.gmail.com>
From: Donet Tom <donettom@linux.vnet.ibm.com>
In-Reply-To: <CAOUHufaK3X0d9ovEMkFfb3cugqzcnxxqn=o6O-1oohaYANtB0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: puDlAcNJQPGUi4fvU8lBfj4qUPDX_7hl
X-Proofpoint-GUID: Card6dRjRRw2AEnykh0kIT3qv6O5_htO
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_02,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=871 impostorscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312200097


On 12/20/23 09:46, Yu Zhao wrote:
> On Tue, Dec 19, 2023 at 9:01 PM Kinsey Ho <kinseyho@google.com> wrote:
>> This series is the result of the following discussion:
>> https://lore.kernel.org/47066176-bd93-55dd-c2fa-002299d9e034@linux.ibm.com/
>>
>> It mainly avoids building the code that walks page tables on CPUs that
>> use it, i.e., those don't support hardware accessed bit. Specifically,
>> it introduces a new Kconfig to guard some of functions added by
>> commit bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
>> on CPUs like POWER9, on which the series was tested.
>>
>>
>> Kinsey Ho (4):
>>    mm/mglru: add CONFIG_ARCH_HAS_HW_PTE_YOUNG
>>    mm/mglru: add CONFIG_LRU_GEN_WALKS_MMU
>>    mm/mglru: remove CONFIG_MEMCG
>>    mm/mglru: remove CONFIG_TRANSPARENT_HUGEPAGE
>>
>>   arch/Kconfig                   |   8 +
>>   arch/arm64/Kconfig             |   1 +
>>   arch/x86/Kconfig               |   1 +
>>   arch/x86/include/asm/pgtable.h |   6 -
>>   include/linux/memcontrol.h     |   2 +-
>>   include/linux/mm_types.h       |  16 +-
>>   include/linux/mmzone.h         |  28 +---
>>   include/linux/pgtable.h        |   2 +-
>>   kernel/fork.c                  |   2 +-
>>   mm/Kconfig                     |   4 +
>>   mm/vmscan.c                    | 271 ++++++++++++++++++---------------
>>   11 files changed, 174 insertions(+), 167 deletions(-)
> +Donet Tom <donettom@linux.vnet.ibm.com>
> who is also working on this.
>
> Donet, could try this latest version instead? If it works well as the
> old one you've been using, can you please provide your Tested-by tag?
> Thanks.

Hi Yu Zhao,

This patch set looks promising.

I have conducted tests on PowerPC and x86.

In old patch set there is a cleanup patch which removes
struct scan_control *sc argument from try_to_inc_max_seq() and
run_aging(), Do we need to include that patch?

=>Here are some test results from PowerPC.

# ls -l vmscan.o
-rw-r--r--. 1 root root 3600080 Dec 19 22:35 vmscan.o

# size vmscan.o
   text       data           bss      dec         hex filename
   95086      27412          0        122498      1de82 vmscan.o

# ./scripts/bloat-o-meter vmscan.o.old vmscan.o
add/remove: 4/8 grow/shrink: 7/9 up/down: 860/-2524 (-1664)
Function                              old       new     delta
should_abort_scan                      -        472     +472
inc_max_seq.isra                      1472      1612    +140
shrink_one                            680       760     +80
lru_gen_release_memcg                 508       556     +48
lru_gen_init_pgdat                    92        132     +40
shrink_node                           4040      4064    +24
lru_gen_online_memcg                  680       696     +16
lru_gen_change_state                  3968      3984    +16
------
shrink_lruvec                         2168      2152    -16
lru_gen_seq_write                     1980      1964    -16
isolate_folios                        6904      6888    -16
lru_gen_init_memcg                    32        12      -20
mm_list                               24        -       -24
lru_gen_exit_memcg                    388       344     -44
try_to_shrink_lruvec                  904       816     -88
lru_gen_rotate_memcg                  832       700     -132
lru_gen_migrate_mm                    132       -       -132
lru_gen_seq_show                      1484      1308    -176
iterate_mm_list_nowalk                288       -       -288
lru_gen_look_around                   2284      1984    -300
lru_gen_add_mm                        528       -       -528
lru_gen_del_mm                        720       -       -720
Total: Before=116213, After=114549, chg -1.43%

=>Here are some test results from x86.

$ ls -l vmscan.o
-rw-r--r--. 1 donettom donettom 2545792 Dec 20 15:16 vmscan.o

$ size vmscan.o
   text          data          bss    dec        hex filename
   109751        32189         0      141940     22a74 vmscan.o
$

$ ./scripts/bloat-o-meter vmscan.o.old vmscan.o
add/remove: 7/3 grow/shrink: 14/4 up/down: 2307/-1534 (773)
Function                                old       new      delta
inc_max_seq                             -         1470     +1470
should_abort_scan                       -         229      +229
isolate_folios                          4469      4562     +93
lru_gen_rotate_memcg                    641       731      +90
lru_gen_init_memcg                      41        99       +58
lru_gen_release_memcg                   282       336      +54
lru_gen_exit_memcg                      306       350      +44
walk_pud_range                          2502      2543     +41
shrink_node                             2912      2951     +39
lru_gen_online_memcg                    402       434      +32
lru_gen_seq_show                        1112      1140     +28
lru_gen_add_folio                       740       757      +17
lru_gen_look_around                     1217      1233     +16
__pfx_should_abort_scan                 -         16       +16
__pfx_inc_max_seq                       -         16       +16
iterate_mm_list_nowalk                  277       292      +15
shrink_one                              413       426      +13
lru_gen_init_lruvec                     190       202      +12
-----
try_to_shrink_lruvec                    717       643      -74
lru_gen_init_pgdat                      196       82       -114
try_to_inc_max_seq.isra                 2897      1578     -1319
Total: Before=101095, After=101868, chg +0.76%
$


Tested-by: Donet Tom <donettom@linux.vnet.ibm.com>

Thanks
Donet Tom


