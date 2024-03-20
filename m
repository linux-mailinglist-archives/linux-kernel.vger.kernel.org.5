Return-Path: <linux-kernel+bounces-109267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C465881702
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01A6DB240D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6445C6A8AD;
	Wed, 20 Mar 2024 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="E+sKbDfp"
Received: from sonic311-24.consmr.mail.gq1.yahoo.com (sonic311-24.consmr.mail.gq1.yahoo.com [98.137.65.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196C76A327
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957747; cv=none; b=qRf614vwAImX/0EeyxSq4VQvTYDOeRGVwYlwBtZAln9CiOw1IjDjHPT6Eff3VtuJ2NoXlN+jsR/ZTYdKs8yDg4hVb+Tp401wU/4J6LrqlIGCp0J4OoSpJeeY/w5nOKSKrpPZ+8kDQmDxOLAV132w+CTpbtZKr38xfJ8Ep3QCOGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957747; c=relaxed/simple;
	bh=bgVYqzWvfpqE6jxKb66SRmkeso/7iWyCQu7GKuwJRro=;
	h=Date:From:Subject:To:MIME-Version:Message-Id:Content-Type:
	 References; b=JRii1myzCbO+5adO7eTQk9MxZyOOiNQH3ECd2sRWfoZYmLcFiuemo+HGmtX7huovYmpGIZwXxYuueH60FNddceTgvImIW0fzhtGzXBeIA2Ni+vkWrbo63JxBPOVMR1GsXev+2JUDxZldI8RLpnS4VBe91UaWiYVtVfZbFkaHleQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.ca; spf=pass smtp.mailfrom=yahoo.ca; dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b=E+sKbDfp; arc=none smtp.client-ip=98.137.65.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1710957745; bh=0yMZBXcBZkZ/M2EO1/087sLa8IJRDaXBPocFKvglIy8=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=E+sKbDfpSzY9vUSq++bzAKxnbNEK1+devjZQh/VqxkBYxc1Rhlo+2y4KQt/LWjfWyqwwXBaWwX8To9b+MLwptIrTma5/9A5Zt85wlXAhs29K0fekU5hvb6urXg+ZuMu+mLhU4QcsMfxlOTXFXJ6aDuSBemdy8acvXtoquOeJYcrZPCx22liBIVSB48K9hKJ0XavrvxLpw8TR5h3JDK18J/TznK5XOQRJoQtXKinKrX8jRJW0mTswXMxoBaMWHQTPc05T3K6XGyI9EsnrjvFU8aw1jr0sYN/bTBvKBJhxfED2Vg3xTC3Mi+z+jXNm/uULcM+b4mNRSu7vzpVSO20WFg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710957745; bh=uedLumy/n1TyR6muam0lqLNvS08Kl1kfB7eD6vG4EnS=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=XWiu/Bx90GpC08zAexDyqFSp3MGDLdeJ4DaqmvutJHbSELRQjp8iyXkGsBveUFB5fAN5UMUxACEBFtwhsc9CcOcWHvR00B1SRFidGO4FyRd9RwFKTsIshSso0PwKv6iDxlcRRcggb2NDDLcrf/xBMmnJj8XPVtoMR+9XitChvemHIfs1vB3HTVgaiUgqTz23AHiLV8CoANU0CVDsJ83710y4oFnXKmjsJoRMYJUII4jg86HAWg1rbKcLUiI/C1aYmKf8q4grzL4i09mdGZMehcVEkq7cvAzZ0RtAmJ9Iv1h8lMG8TPIaveCBaTYr8IIDI3T0DTMYr598tYScDM1Odg==
X-YMail-OSG: OnVf6EsVM1nMhDwwtaQga9n.gjV.dCdbO8OfcMELD13nX.SUrFvjCDwN8zC.5.C
 y5bruO67fJO0.cx3XVdj.XmfCQo2LQ1l3_KRwzbuELThDJizKWHZmODyzWSfgOq8HLbqfjCH9OjN
 k0M04uqvoBMHEhxzPo8ZNYI2wWHTjKTjYlNBzeEuORTxd4TBtIp4yXwGJJGL0TEGWZdW8f4VovS.
 Xc3FjGQicJyTQ1gqQmlLvEzfi8qaTjXcbZMKlRUeLK54MDZsV5Nb2DFzroXKhI4GwMppzrD5yS5m
 OzolBfihWTq79eB9pwQBcDZnBdUNgyYBsNChsCMZK_9CNDXf0tfO8dMPqslwXiyi2wE1Ow0SMhQP
 iHa_yAAXNgPgvyU7Rvhq2FvkViuFe1DRlEVtue_pFwgjYJNBH.V_1b4IGbkayMbvbO7ja55LYYy4
 HKCsHzmCb9N.RehTIBYKWq24iUNbHZDJze7g.pvYJpiDRSawiSUWB4CYWw0cgNj0j_r9QT2USXza
 g.2gd8E78GsNShr2YcfCHp8.AXVKlusWGpn8G037TXXTO6qicOb0h08sDO5YCVpheVdsAtvPOADb
 DQKm2pUv075Bg2r5PkfxDcmoOhtsVFG6..mlVH5GQd4L5IWvVOsYYFhVxYg6s60sePtAkIboB85u
 F_lUvJXGWClk3HKtZ0Cid1VfY6uHtxYeO8m7v_5b6gjPe34_8s..bTPzDbBFUnCFnTDjbyQODMLi
 TIVrCOS25NVwpdqb7ySgRHgZ4fpTlkRU6WNYKtg8NjoOeXu.OTZROI7e.SSL7q5vWyo1PH_i5Au1
 lpHl3mcsaq2DashwluRBWRN9PruWM2XKFO.B8yBxSkiln.veP9Eh3xKRyijW4DbOEfa_FQPmNFMk
 qnzJJaZayol0YlPsTyECMV6uZI34yUmJw6PHBECZPGp2afkUbaWjmT.0iy6zv2Bk8uI__KiXlIHX
 subaCCwPktJhcOShc1U6aMb_CrNN7tagx3ejGZX9YCuwaeRpb3onKxXAtuLhnlJkvQy5JRuXu1M.
 jLa1BIxPH5FUMJTLFgqm9PZ6rQ7ugp3OhHkWvV0t_MJ_IYwTKU7ifwxPCTPgAY51zJxWCxJHPPpC
 2mSuZJ9g7pttXDVPdcsduA2076DQMXnpuXkW8atxHnrC8TCrLk57RDZjCTiKOyuoZItP85hU7alw
 J8ileF_cRQYNaHiAm45RtLpQ2jSrgnuMoyRMRq4I7b0Xe_Ofb8s4jBzvtuO2jsHd87PKB.Jc7yEq
 p_9lsm50Vjt11E0eNlp24_aTMa5QWI9PHNknM8R1g_PhzlZ1hKSGTTy65tsf_2ug2IfcVMcrd4v8
 RKaPMSfCIvewp7wc8mNIqgTQV.c9nUqMtX5Y5_65bstDnrmsVuKbWsmd8tNQkQ6fIFOuVf3ygfhq
 O4vKmTzqQrfHRK.Jgzl_L2ZTKOiivV.GzCorVx4t6W_UBI3UUiHQg_EuWG3ouf7lpoJjJk25dWdr
 Tmc7CcC2SLqaMz88KNzZM0TXFIVbFV0Prt_LgItwzKzr._VzeN2SH9MukVDFzEwAI6DGzJrSGm0c
 4Z_Z0fCKUnoNI.B1trotC5qN8VCOU.R.lLNNkjNQpSiXz9GnriJm4C66t24f4JcHB0apWQEgvak1
 6Na.HMmPJNMThJt7ZI8A0r4csnNGZpVp5tMUAahShfZMphHns9IJyQEATwlWIC8r3ElHYc.xrR4h
 srwtFk.Om4ZDWBsAen7QhsO_i8ZFwDgqMjVqjrCT.I5xNE4jOwTZCLw29AIEoEPDUpxAqbeOIK_R
 71iu4A6J7IcQldfP_7QuiPnMBlqZosbGzVmPahLX4jkfj3E37Rfa58cOBPSgE0AK_In5zcv1Cbtg
 lY1yL5vqWYkKa83WYmcphgXZ.Untq2NesO2gXtH53_MQi31qKwOvRGpnHD413JFx5kODJowVjsSi
 Dft4J1kCzbJYGDssuVS1_B6iVsmXbolqmOgoidk5qy2y20jZvTJWCwoMpkF7Eph1P657rcGM2LB.
 wQ9CRYd5LT847zOlFMjDBW6.yeknIRThXlwLYT3MiluloCytnBkqGH0t7c.4LuXhIrpwqgqRjoui
 Wzv5AST7gjYHZjYj_pPjI75kfIcYJHviwXtDJv7BVUwfZ2UG24pT0r4kBPhBIaz5SBIUCTEdUFN3
 AjBTsUI4ZmRRG7MeMkL.oXpdb4iOBnRrHB3c_mD9OdW9VJOXigTkDpYylDrZKMR5iGkzbeq.7dQV
 jji1gEPjz.vqmBB0-
X-Sonic-MF: <alex_y_xu@yahoo.ca>
X-Sonic-ID: bf0f5cf1-488c-43ce-b4fb-1c44294e8624
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Wed, 20 Mar 2024 18:02:25 +0000
Received: by hermes--production-bf1-7d6dbd57c9-hwf7b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8148c9f88f5021eb0a73e4f9f7a97599;
          Wed, 20 Mar 2024 17:01:46 +0000 (UTC)
Date: Wed, 20 Mar 2024 13:01:22 -0400
From: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Regression: SUnreclaim leak: snd_ctl_ioctl?
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1710953751.8yx03664pf.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
References: <1710953751.8yx03664pf.none.ref@localhost>
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi all,

In the last few days of running torvalds master kernel, I found that=20
SUnreclaim memory seems to increase indefinitely. slabinfo -r kmalloc-2k=20
says:

Slabcache: kmalloc-2k       Aliases:  0 Order :  3 Objects: 1272941

Sizes (bytes)     Slabs              Debug                Memory
------------------------------------------------------------------------
Object :    2048  Total  :  264991   Sanity Checks : On   Total: 8683225088
SlabObj:    6144  Full   :  264972   Redzoning     : On   Used : 2606983168
SlabSiz:   32768  Partial:      19   Poisoning     : On   Loss : 6076241920
Loss   :    4096  CpuSlab:       0   Tracking      : On   Lalig: 5213966336
Align  :    2048  Objects:       5   Tracing       : Off  Lpadd: 542701568

kmalloc-2k has no kmem_cache operations

kmalloc-2k: Kernel object allocation
-----------------------------------------------------------------------
1272283 snd_ctl_ioctl+0x45f/0x6d0 waste=3D1048361192/824 age=3D6141/183854/=
366927 pid=3D687-33984 cpus=3D0-1,3-8,10
        memdup_user+0x21/0x70
        snd_ctl_ioctl+0x45f/0x6d0
        __x64_sys_ioctl+0x85/0xa0
        do_syscall_64+0x3d/0xf0
        entry_SYSCALL_64_after_hwframe+0x46/0x4e

    189 acpi_add_single_object+0x38/0x710 waste=3D119448/632 age=3D368130/3=
68134/368138 pid=3D1 cpus=3D0
[ ... ]

kmalloc-2k: Kernel object freeing
------------------------------------------------------------------------
 633587 <not-available> age=3D4295305473 pid=3D0 cpus=3D0
 382872 rcu_core+0x284/0x540 age=3D4513/194630/361523 pid=3D0-21201 cpus=3D=
0-11
        rcu_core+0x284/0x540
        __do_softirq+0xad/0x1de

 247690 amdgpu_dm_atomic_commit_tail+0x1721/0x3740 age=3D6157/199198/366963=
 pid=3D163-19507 cpus=3D0-11
        amdgpu_dm_atomic_commit_tail+0x1721/0x3740
        commit_tail+0x8a/0x120
        process_one_work+0x12b/0x250
        worker_thread+0x2d9/0x3f0
        kthread+0xac/0xe0
        ret_from_fork+0x28/0x40
        ret_from_fork_asm+0x11/0x20

   2794 __sk_destruct+0x17a/0x1b0 age=3D994/147194/368001 pid=3D0-19414 cpu=
s=3D0-11
[ ... ]

So, if I understand correctly, some memory copied from userspace for=20
snd_ctl_ioctl is not freed correctly. The PIDs were pipewire,=20
wireplumber, and pipewire-pulse, so I restarted those but it didn't=20
resolve the issue.

Let me know what other information is needed.

Thanks,
Alex.

