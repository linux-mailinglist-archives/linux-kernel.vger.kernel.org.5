Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CD276F9EE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjHDGUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjHDGUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:20:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986EDE70
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 23:20:29 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3746GMsn025766;
        Fri, 4 Aug 2023 06:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=gJ3SOok65eAVpTYJuD8sRliwPADnpXU7i1PauxghA0s=;
 b=YHwTTH4b40/9az9M11LgeTPjKkY7UVua8yexwzohvko/1ET7RFiSyVA0yEcuLjckRSbo
 qKIwNBdAiiq+1QlOCM72kPZ6hu3gDihDRetjGsXDOvO7pF4SOqdwY0bm3WiwDb7zkpGg
 QTPSRU9VG2m19KJIo7CYJcAGc3PRBEayHCSRkfiNjs/5fXsbZ90eyC6FH0OWbb1wMhXl
 KScOptkfvIaJGzODvRN2cjgP7Fw8S8HFqUL1NNgOU5IzzcV85YU1KF1ihnTgcCmrK/I8
 tc4fptUw5fSJQ2+AH/8YXWzI7Wezi0aFEgtcQhjkArpuGuOpwLnaQNurgsBYCDRF8bWy gg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8uww01wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 06:20:27 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3744Whf2027806;
        Fri, 4 Aug 2023 06:20:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s8kp2u7w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 06:20:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3746KOI436635048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Aug 2023 06:20:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65F4D20040;
        Fri,  4 Aug 2023 06:20:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34F4D2004B;
        Fri,  4 Aug 2023 06:20:24 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  4 Aug 2023 06:20:24 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt (Google) <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: BUG: KASAN: slab-out-of-bounds in print_synth_event+0xa68/0xa78
Date:   Fri, 04 Aug 2023 08:20:23 +0200
Message-ID: <yt9dsf8zfhw8.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain; charset=utf-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TyjEjbAUzv2FPI_T9aCQOIu-sZ19wCA3
X-Proofpoint-GUID: TyjEjbAUzv2FPI_T9aCQOIu-sZ19wCA3
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_03,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

i noticed the following KASAN splat in CI (on s390):

[  218.586476] /home/svens/linux/tools/testing/selftests/ftrace/test.d/trig=
ger/inter-event/trigger-synthetic-event-stack.tc
[  221.610410] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  221.610424] BUG: KASAN: slab-out-of-bounds in print_synth_event+0xa68/0x=
a78
[  221.610440] Read of size 8 at addr 0000000087753ebc by task grep/1321
[  221.610445]
[  221.610451] CPU: 9 PID: 1321 Comm: grep Not tainted 6.4.0-rc3-00008-g4b5=
12860bdbd #716
[  221.610457] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
[  221.610462] Call Trace:
[  221.610466]  [<00000000026026e6>] dump_stack_lvl+0x106/0x1c8
[  221.610479]  [<00000000009cdbbc>] print_address_description.constprop.0+=
0x34/0x378
[  221.610488]  [<00000000009cdfac>] print_report+0xac/0x240
[  221.610494]  [<00000000009ce32a>] kasan_report+0xf2/0x130
[  221.610501]  [<00000000005e4f60>] print_synth_event+0xa68/0xa78
[  221.610508]  [<00000000005809c0>] print_trace_line+0x2a8/0xc00
[  221.610516]  [<0000000000582d4a>] s_show+0xc2/0x3d0
[  221.610522]  [<0000000000b09db2>] seq_read_iter+0x912/0xf88
[  221.610530]  [<0000000000b0a582>] seq_read+0x15a/0x1d8
[  221.610535]  [<0000000000a75f66>] vfs_read+0x186/0x778
[  221.610551]  [<0000000000a77b26>] ksys_read+0x126/0x210
[  221.610557]  [<000000000010d044>] do_syscall+0x22c/0x328
[  221.610564]  [<000000000266ea02>] __do_syscall+0x9a/0xf8
[  221.610571]  [<000000000269f068>] system_call+0x70/0x98
[  221.610577] 3 locks held by grep/1321:
[  221.610580]  #0: 00000000a99db2f8 (&p->lock){+.+.}-{3:3}, at: seq_read_i=
ter+0xca/0xf88
[  221.610595]  #1: 00000000032d0c18 (trace_event_sem){++++}-{3:3}, at: s_s=
tart+0x3c2/0x7c0
[  221.610606]  #2: 00000000032c8cb8 (all_cpu_access_lock){+.+.}-{3:3}, at:=
 s_start+0x502/0x7c0
[  221.610617]
[  221.610619] Allocated by task 1:
[  221.610623]  kasan_save_stack+0x40/0x68
[  221.610628]  kasan_set_track+0x36/0x48
[  221.610632]  __kasan_kmalloc+0xbc/0xe8
[  221.610636]  bdi_alloc+0x58/0x160
[  221.610642]  __alloc_disk_node+0x96/0x558
[  221.610648]  __blk_alloc_disk+0x42/0x88
[  221.610652]  brd_alloc+0x2d8/0x730
[  221.610659]  brd_init+0xd4/0x150
[  221.610668]  do_one_initcall+0x17c/0x750
[  221.610672]  do_initcalls+0x256/0x500
[  221.610677]  kernel_init_freeable+0x59a/0xa60
[  221.610681]  kernel_init+0x2e/0x1f8
[  221.610685]  __ret_from_fork+0x8a/0xe8
[  221.610689]  ret_from_fork+0xa/0x30
[  221.610695] The buggy address belongs to the object at 0000000087754000
[  221.610695]  which belongs to the cache kmalloc-4k of size 4096
[  221.610700] The buggy address is located 324 bytes to the left of
[  221.610700]  allocated 2464-byte region [0000000087754000, 0000000087754=
9a0)
[  221.610705]
[  221.610708] The buggy address belongs to the physical page:
[  221.610711] page:00004000021dd400 refcount:1 mapcount:0 mapping:00000000=
00000000 index:0x0 pfn:0x87750
[  221.610718] head:00004000021dd400 order:3 entire_mapcount:0 nr_pages_map=
ped:0 pincount:0
[  221.610722] flags: 0x3ffff00000010200(slab|head|node=3D0|zone=3D1|lastcp=
upid=3D0x1ffff)
[  221.610729] page_type: 0xffffffff()
[  221.610735] raw: 3ffff00000010200 000000008008e800 000040000259cc10 0000=
000080081470
[  221.610739] raw: 0000000000000000 0002000400000000 ffffffff00000001 0000=
000000000000
[  221.610743] page dumped because: kasan: bad access detected
[  221.610746]
[  221.610748] Memory state around the buggy address:
[  221.610752]  0000000087753d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[  221.610755]  0000000087753e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[  221.610759] >0000000087753e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[  221.610762]                                         ^
[  221.610766]  0000000087753f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[  221.610770]  0000000087753f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[  221.610773] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

git bisect says:

% git bisect log                                                           =
                                                                           =
       git:(eaa2fa66c0a1|=E2=80=A61=E2=9A=9132
git bisect start
# status: waiting for both good and bad commits
# good: [457391b0380335d5e9a5babdec90ac53928b23b4] Linux 6.3
git bisect good 457391b0380335d5e9a5babdec90ac53928b23b4
# status: waiting for bad commit, 1 good commit known
# bad: [57012c57536f8814dec92e74197ee96c3498d24e] Merge tag 'net-6.5-rc4' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect bad 57012c57536f8814dec92e74197ee96c3498d24e
# good: [50fb587e6a56dba74c3c56a7a09c48bff25cc5fa] Merge tag 'net-6.4-rc4' =
of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good 50fb587e6a56dba74c3c56a7a09c48bff25cc5fa
# bad: [f8824e151fbfa0ac0a258015d606ea6f4a10251b] Merge tag 'sound-6.5-rc1'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect bad f8824e151fbfa0ac0a258015d606ea6f4a10251b
# bad: [6aeadf7896bff4ca230702daba8788455e6b866e] Merge tag 'docs-arm64-mov=
e' of git://git.lwn.net/linux
git bisect bad 6aeadf7896bff4ca230702daba8788455e6b866e
# bad: [e940efa936be65866db9ce20798b13fdc6b3891a] Merge tag 'zonefs-6.5-rc1=
' of git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs
git bisect bad e940efa936be65866db9ce20798b13fdc6b3891a
# bad: [8f0e3703571fe771d06235870ccbbf4ad41e63e8] Merge branch 'udplite-dcc=
p-print-deprecation-notice'
git bisect bad 8f0e3703571fe771d06235870ccbbf4ad41e63e8
# bad: [e684ab76afebcaccd428f7d55361d5669ccc3e2d] Merge tag 'wireless-2023-=
06-06' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
git bisect bad e684ab76afebcaccd428f7d55361d5669ccc3e2d
# bad: [1683c329b6a2ee54989811089854a8ac2d5b5fc1] Merge tag 'regmap-fix-v6.=
4-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap
git bisect bad 1683c329b6a2ee54989811089854a8ac2d5b5fc1
# good: [18713e8a689377386f639d9317f958244825bd7b] Merge tag 'arm-fixes-6.4=
-1' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good 18713e8a689377386f639d9317f958244825bd7b
# good: [2d5438f4c6fdaa34c5d7de89a5331b8dbcd920af] Merge tag 'perf-urgent-2=
023-05-28' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 2d5438f4c6fdaa34c5d7de89a5331b8dbcd920af
# good: [7a6c8e512fa072cfe8ad7a3b26666b6f26435870] Merge tag 'v6.4-p3' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect good 7a6c8e512fa072cfe8ad7a3b26666b6f26435870
# bad: [9da705d432a07927526005a0688d81fbbf30e349] tracing: Have tracer self=
tests call cond_resched() before running
git bisect bad 9da705d432a07927526005a0688d81fbbf30e349
# good: [dcbd1ac2668b5fa02069ea96d581ca3f70a7543c] tracing/user_events: Ren=
ame link fields for clarity
git bisect good dcbd1ac2668b5fa02069ea96d581ca3f70a7543c
# bad: [4b512860bdbdddcf41467ebd394f27cb8dfb528c] tracing: Rename stacktrac=
e field to common_stacktrace
git bisect bad 4b512860bdbdddcf41467ebd394f27cb8dfb528c
# good: [e30fbc618e97b38dbb49f1d44dcd0778d3f23b8c] tracing/histograms: Allo=
w variables to have some modifiers
git bisect good e30fbc618e97b38dbb49f1d44dcd0778d3f23b8c
# first bad commit: [4b512860bdbdddcf41467ebd394f27cb8dfb528c] tracing: Ren=
ame stacktrace field to common_stacktrace

I don't see how 4b512860 might cause this, but i haven't spent much time
on it, maybe someone who knows the code recognize the problem much
quicker. I did the bisect twice, and it always ended up at that commit.
manually compiling and testing the revision before also shows that
it happens only with 4b512860.

For reproducing, the following script is good enough to trigger it
reliably on my system:

cd /home/svens/linux/tools/testing/selftests/ftrace
for i in $(seq 1 10); do
	./ftracetest -v /home/svens/linux/tools/testing/selftests/ftrace/test.d/tr=
igger/inter-event/trigger-synthetic-event-stack.tc
	dmesg|grep "BUG: KASAN"
	if [ "$?" -eq 0 ]; then
		exit 1
	fi
done
exit 0

Regards
Sven
