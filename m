Return-Path: <linux-kernel+bounces-49064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C15846570
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E958D28734D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7071463B7;
	Fri,  2 Feb 2024 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J02tDG6t"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F933FD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706837666; cv=none; b=slPHl7hlYvOmaxwSaALChRNe1Y8CATZ17Jkvhdc787tCoOUdRXh2U/hDPvLpxUOnYsC4155wuLPkJ+/qqiCBARs/9WwV815hPgzHTetGz32Hxh4CkBo+HjMlcn/VL15abPdpS471r6r1v2Tn4WEaHHTCUKz8LEd232nifKcigvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706837666; c=relaxed/simple;
	bh=7ihXqqZLoq0FoRue8iQkfFrTtELwLrJz4KU3OQJCe80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=KdKNxMPvNoqzSAO1Mav2/CrTHPfGoX1fO3boIQu08aSABhgTE/REyQ9kOIdnO2HrtZI6RwY99iuqvm+d7t/qAUu3j6X/1vvFhgGjjlRez6ZRQ4+C45BnkHsO61etYr1oP3rWayUeRppwwBgPuGf8lRH+cfWNesV+x1H4n24iLwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J02tDG6t; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240202013415epoutp01ab45040117f2fb619ce0c77f770e8655~v583xmuhg3120731207epoutp01a
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 01:34:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240202013415epoutp01ab45040117f2fb619ce0c77f770e8655~v583xmuhg3120731207epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706837655;
	bh=8GM3DMWIehaIuX6fmNbvXTvKHtAEeQ9Hv6/OgIbhMMo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=J02tDG6tfz2FkiYaINn6ubQOyNS3ZrRrIYz+nLGmiQv8Le/fpLvibqy7m2v0n8g/n
	 5/JFv4YanwzvQUJH0jKXHZVRoy2qLI0vadEDBSayhv7perONc+Hqso1bVtz2rfR9KL
	 PD2QU/xnY83yh/FHcWFHSDIl5rb76H1StJHFZUK0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240202013415epcas1p22951ef1e68aed7d3df507e3c2b5f166e~v583Upl7m0486804868epcas1p2y;
	Fri,  2 Feb 2024 01:34:15 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.226]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TQyx26ZKmz4x9Q2; Fri,  2 Feb
	2024 01:34:14 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	B6.DB.09731.6964CB56; Fri,  2 Feb 2024 10:34:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240202013414epcas1p28ce117bb1e5e7f03b68365ec0d3a9c89~v5827Ksav0510905109epcas1p2p;
	Fri,  2 Feb 2024 01:34:14 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240202013414epsmtrp181332c4fdbca611578c43d154ba5646f~v5826ZQ1r2668826688epsmtrp1d;
	Fri,  2 Feb 2024 01:34:14 +0000 (GMT)
X-AuditID: b6c32a36-cebfd70000002603-d1-65bc4696dbd7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	21.BC.07368.6964CB56; Fri,  2 Feb 2024 10:34:14 +0900 (KST)
Received: from parkseongsu-desktop.. (unknown [10.252.69.73]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240202013414epsmtip12c9d966537b12e277ad53582da875ee6~v582n_4is1032810328epsmtip15;
	Fri,  2 Feb 2024 01:34:14 +0000 (GMT)
From: Seongsu Park <sgsu.park@samsung.com>
To: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	broonie@kernel.org, oliver.upton@linux.dev, suzuki.poulose@arm.com,
	maz@kernel.org, ryan.roberts@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Seongsu Park <sgsu.park@samsung.com>
Subject: [PATCH] arm64: fix typo in comments
Date: Fri,  2 Feb 2024 10:33:06 +0900
Message-Id: <20240202013306.883777-1-sgsu.park@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdlhTV3ea255UgzX/TSymPnzCZvF+WQ+j
	xabH11gtLu+aw2ax9PpFJoudc06yWkz9+YbNomf3VEaL9w1drBYzb99mtGi5Y+rA7bFm3hpG
	j02rOtk8FjZMZfbYvKTeo2/LKkaPz5vkAtiism0yUhNTUosUUvOS81My89JtlbyD453jTc0M
	DHUNLS3MlRTyEnNTbZVcfAJ03TJzgK5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak
	5BSYFegVJ+YWl+al6+WlllgZGhgYmQIVJmRnPP50j6Wgg61i14VLTA2Mv1m6GDk5JARMJNrf
	bWTuYuTiEBLYwSjx6cAXJgjnE6PEh/8z2EGqhAS+MUp8OV0B03Htww6ojr2MEg8bNyJ0HJvU
	yQhSxSagJbH6Xy87SEJEYAOjxLy7V9lAEswCeRJXbr5kBbGFBXQkGlZNA7NZBFQl3lzZwwxi
	8wpYS/w6e4oJYp28xP6DZ6HighInZz5hgZgjL9G8dTbYGRICX9klPnZ/gmpwkTjScokNwhaW
	eHV8CzuELSXxsr8Nyi6W2PdlDTOEXSPxYN4eKNteouNZG9ACDqAFmhLrd+lD7OKTePe1hxUk
	LCHAK9HRJgRhKkuc2+oIYUpK/FmgBzHDQ2Lnr3XMkHCLlVh++i/zBEa5WUjun4Xk/lkIqxYw
	Mq9iFEstKM5NTy02LDCCx2Nyfu4mRnCa1DLbwTjp7Qe9Q4xMHIyHGCU4mJVEeFfK7UwV4k1J
	rKxKLcqPLyrNSS0+xGgKDNGJzFKiyfnARJ1XEm9oYmlgYmZkYmFsaWymJM575kpZqpBAemJJ
	anZqakFqEUwfEwenVANT3iwe999+y2bliK5Q/jyDNS578W/FuiNznxy/mXqt7Rpbq/6d21lv
	fy75Zit+PJ/HlPeIpuRCdmt93+XS7Ac8vmx6F7Ly0g2X2W6/VqddV/G90e4nviXu+vekvU+W
	7I/NELu4Y5/A0YmuOle4hTmsj3+/l9EeX7+i55NqyfnTIRJx1yuM9ntJ1Gqt3/m2zX7ypenL
	eb7uvCQdXiPyPvnTq6VtP+VFVtw49T1qfhfLoZzrH5R+8xyQf8+a2MJU0ZsvFcMyQ//kiow5
	J7mDOk+ePyH+cWOLxqrKw2+YphXe73fm9tz+NOH1nEXmyqGXmrnL5TezLwiw1RUvNYmaPelU
	w1Vn/+uJohPnCx5m8H4rqcRSnJFoqMVcVJwIAFmgPFMcBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSnO40tz2pBk/PS1pMffiEzeL9sh5G
	i02Pr7FaXN41h81i6fWLTBY755xktZj68w2bRc/uqYwW7xu6WC1m3r7NaNFyx9SB22PNvDWM
	HptWdbJ5LGyYyuyxeUm9R9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGU8/nSPpaCDrWLXhUtM
	DYy/WboYOTkkBEwkrn3YwdzFyMUhJLCbUeLVv1tQCUmJ9neXgWwOIFtY4vDhYoiaD4wSr7/O
	ZAepYRPQklj9r5cdJCEisItR4u6BRkaQBLNAgcT5f1vABgkL6Eg0rJrGCmKzCKhKvLmyhxnE
	5hWwlvh19hQTxDJ5if0Hz0LFBSVOznzCAjFHXqJ562zmCYx8s5CkZiFJLWBkWsUomVpQnJue
	m2xYYJiXWq5XnJhbXJqXrpecn7uJERzUWho7GO/N/6d3iJGJg/EQowQHs5II70q5nalCvCmJ
	lVWpRfnxRaU5qcWHGKU5WJTEeQ1nzE4REkhPLEnNTk0tSC2CyTJxcEo1MJUcuhF16oH6/TTB
	SOW/T4XulWr7WdXOT37NuKTD5dqWFaLPvfv3RE37n8mXHCqab/+514h/cu3vsKcXdfeezRIM
	iUtfuML4dOTD3Z80Ux6ueL9OZsa662k8vRO45mYfVt70u5xTtjgliCc9+O4nJ7FLPxa217Yt
	7D8cdot5/cc7dZODedP0KmWVq9698y6Ps1Oas+H8zJ3X/x7+u1szYyOn+gPO9+Wnp7SWbGLx
	Tlyl5/35G4ta/9sFd1nqwyT6HerrU08dPdd22b1gQ5C/D/P8hJDFTu9nnz04V+NE+inuyOkC
	ojpxza5v1lqe8WN+uG/Pltfll4s3xzfeeytybF2zlOx67jSGx1UXLM12flBiKc5INNRiLipO
	BAAmCnUh2QIAAA==
X-CMS-MailID: 20240202013414epcas1p28ce117bb1e5e7f03b68365ec0d3a9c89
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240202013414epcas1p28ce117bb1e5e7f03b68365ec0d3a9c89
References: <CGME20240202013414epcas1p28ce117bb1e5e7f03b68365ec0d3a9c89@epcas1p2.samsung.com>

fix typo in comments

thath -> that

Signed-off-by: Seongsu Park <sgsu.park@samsung.com>
---
 arch/arm64/include/asm/cpufeature.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 21c824edf8ce..bd8d4ca81a48 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -83,7 +83,7 @@ struct arm64_ftr_bits {
  * to full-0 denotes that this field has no override
  *
  * A @mask field set to full-0 with the corresponding @val field set
- * to full-1 denotes thath this field has an invalid override.
+ * to full-1 denotes that this field has an invalid override.
  */
 struct arm64_ftr_override {
 	u64		val;
-- 
2.34.1


