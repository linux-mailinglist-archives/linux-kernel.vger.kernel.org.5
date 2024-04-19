Return-Path: <linux-kernel+bounces-151838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0828E8AB491
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E6E4B21AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4599D13AD26;
	Fri, 19 Apr 2024 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IehBl+aA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24407130E5E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549387; cv=none; b=BesMPxqlMAzScRlIZzB18oEzNZujKJ98weUlGXNGiTavmdkUooYl2dHbMBgWW8v7tOSdi9I4QaHkFw5OEHU+dp9uwHKUecGP3mpJbKzYn7IiTaIW5Q4kocvaRE6U/C60Fs3bbNS9Dm5KebOpW/32erGudOnLs/LW8XfkhBi6+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549387; c=relaxed/simple;
	bh=EH4oorwZc3OtqHaYGL7XKoQ4ECTvU0y/TOOoMZ+6TZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FHFy5yT22uYOOkPs2zFWHVjk+EPt0q/voGfKa9+hVLT1TjjzHgR9fqjTaTWunnh7B8o1p45qzZwpT8xSGYyPIDa4PcmZoUDDvZttI68ow/6v8FewdqZ1aiMlVyGLrfnKWrmJ5C7LzwHu2Zku2GRAHomD21hGzExcSgjKJzoFle8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IehBl+aA; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43JGiLv8028465;
	Fri, 19 Apr 2024 17:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=sEyQAxGxkU6mSg9BlzN0eOIMTIjIcy8X5ZvmftEfrfQ=;
 b=IehBl+aAG37co6abmxWdSg1oRCJ9zcSFM7nS3t+jq2Jk/GDd0yiatz7cGZJoIjRtOoye
 xSnc3s9WwN2D/oHGNjtCJoio4/almODMTEX2qNAiyukL2uut++6TuJRO3DZ6j8q9Z37m
 8T3CzUvwnyWpBdwcec4YVP4e70nK73pLUi3zNP3sd6/Le+sMZuE8k4hFO2CotFz5cMSh
 iQGOMI5EY0KLwlGxw3QKVhvmKK1ECg0mtOYrd8utIsZpjEICrq4PGS2Bnw3gXQfuO9kv
 WpSWdVu/ZunKGSEKjJnixWIuWjxnuoSS/d7yTDftG7HulXdGpnxSVhTyp5KDAoTKmWhR og== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgn2wemx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 17:56:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43JH48SH005568;
	Fri, 19 Apr 2024 17:56:12 GMT
Received: from jfwang-mac.us.oracle.com (dhcp-10-159-230-131.vpn.oracle.com [10.159.230.131])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xkc7xd76r-1;
	Fri, 19 Apr 2024 17:56:12 +0000
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: vbabka@suse.cz, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com
Subject: [PATCH v3 0/2] slub: introduce count_partial_free_approx()
Date: Fri, 19 Apr 2024 10:56:09 -0700
Message-ID: <20240419175611.47413-1-jianfeng.w.wang@oracle.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_13,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404190137
X-Proofpoint-ORIG-GUID: coliv5PNpXCgK6sJJQ9zoeoB9O46W5Nq
X-Proofpoint-GUID: coliv5PNpXCgK6sJJQ9zoeoB9O46W5Nq

This patch fixes a known issue in get_slabinfo() which relies on
count_partial() to get the exact count of free objects in a
kmem_cache_node's partial list. For some slubs, their partial lists
can be extremely long. Currently, count_partial() traverses a partial
list to get the exact count of objects. This process may take a long
time, during which slab allocations are blocked and IRQs are disabled.
In production, even NMI watchdog can be triggered due to this matter.

The proposed fix is to limit the number of slabs to scan and output an
approximated count for a long partial list. The v1 patch counts N slabs
from the list's head and then uses it to estimate the total object
count in the list. As suggested by Vlastimil, the v2 patch uses an
alternative, i.e., counting N/2 from the list's head and tail, produces
a more accurate approximation after the partial list is sorted by
kmem_cache_shrink(). In this version, the implementation is moved to a
new function count_partial_free_approx(). count_partial() is still used
in sysfs for users who still want the exact object count.

---
Changes since v2 [2]
 - Introduce count_partial_free_approx() and keep count_partial()
 - Use count_partial_free_approx() in get_slabinfo() and slab_out_of_memory()

Changes since v1 [1]
 - Update the approximation method by counting from the list's head and tail
 - Cap the approximation by the total object count
 - Update the commit message to add benchmark results and explain the choice

[1] https://lore.kernel.org/linux-mm/20240411164023.99368-1-jianfeng.w.wang@oracle.com/
[2] https://lore.kernel.org/linux-mm/20240417185938.5237-2-jianfeng.w.wang@oracle.com/

Thanks,
--Jianfeng

Jianfeng Wang (2):
  slub: introduce count_partial_free_approx()
  slub: use count_partial_free_approx() in slab_out_of_memory()

 mm/slub.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

-- 
2.42.1


