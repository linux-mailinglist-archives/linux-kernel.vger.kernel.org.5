Return-Path: <linux-kernel+bounces-417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 502238140C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E221C222E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2017B111A4;
	Fri, 15 Dec 2023 03:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="YDJX5xy+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pv50p00im-ztdg10021901.me.com (pv50p00im-ztdg10021901.me.com [17.58.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A8810A15
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1702611823; bh=445I71dWNky8gFBXioboudiXUB/462lbJ09ljq2mQN4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=YDJX5xy+W1UfNbpOBoXmIjJYhQF1Ceu3p8Dkx7b9/KzzjIQUnBpu9dcohJw+H5mLA
	 FnT8DjHyxNjgo1h76F+ZAgUsw1lMc+8H+CELa7EeTILVzWBYqFE4JkQTNE8k9f6hK/
	 hYadR5auSh+QcZhwd5Vajf5vmRiULiPDDNczRtIzOUqRol7UORD6QXatwEW7HLpSbz
	 jxeACvPM5LbqnVjf13xFt58jSBRt6Y3E8XdygB/Ar4WWPY3YX5My9BX4TgdEuvtW7Z
	 9OcX+Ga010xmPgTwVWrjUqEtqDrA2uz8piKj8zU+pKc1+Zz+7mrUfAbSrdbbPBxQP+
	 AYL/6h3Em0LVw==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021901.me.com (Postfix) with ESMTPSA id A07BF813C8;
	Fri, 15 Dec 2023 03:43:36 +0000 (UTC)
From: sxwjean@me.com
To: vbabka@suse.cz,
	42.hyeyoo@gmail.com,
	cl@linux.com,
	linux-mm@kvack.org
Cc: penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	roman.gushchin@linux.dev,
	corbet@lwn.net,
	keescook@chromium.org,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	quic_jjohnson@quicinc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH v4 4/4] mm/slub: make the description of slab_min_objects helpful in doc
Date: Fri, 15 Dec 2023 11:41:50 +0800
Message-Id: <20231215034150.108783-5-sxwjean@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215034150.108783-1-sxwjean@me.com>
References: <20231215034150.108783-1-sxwjean@me.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8lD-3Etja8ZIaO9ffj4EqA9SJ3T_cRqs
X-Proofpoint-ORIG-GUID: 8lD-3Etja8ZIaO9ffj4EqA9SJ3T_cRqs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_17,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2312150026

From: Xiongwei Song <xiongwei.song@windriver.com>

There is no a value assigned to slab_min_objects by default, it always
is 0 that is initialized by compiler if no assigned value by command line.
min_objects is calculated based on processor numbers in calculate_order().
For more details, see commit 9b2cd506e5f2 ("slub: Calculate min_objects
based on number of processors.")

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 Documentation/mm/slub.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
index 6579a55b7852..213491ffb66f 100644
--- a/Documentation/mm/slub.rst
+++ b/Documentation/mm/slub.rst
@@ -150,7 +150,7 @@ list_lock once in a while to deal with partial slabs. That overhead is
 governed by the order of the allocation for each slab. The allocations
 can be influenced by kernel parameters:
 
-.. slab_min_objects=x		(default 4)
+.. slab_min_objects=x		(default:automatically scaled by number of cpus)
 .. slab_min_order=x		(default 0)
 .. slab_max_order=x		(default 3 (PAGE_ALLOC_COSTLY_ORDER))
 
-- 
2.34.1


