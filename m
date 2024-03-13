Return-Path: <linux-kernel+bounces-101542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B09687A883
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D221F24056
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1F41757;
	Wed, 13 Mar 2024 13:33:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BB73F9E1;
	Wed, 13 Mar 2024 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336802; cv=none; b=WCSx8CDEHf8Ztj7ZTeYo34MsV52zz1UfRdp6K2AwdgQ/WD/7oNZUq2s3J0J+Q1kGqE8RnqDSlcl4NHLWtH1Ed8V4acbNNcesv7HINsmbp+zHcrO696gJarCBtTO17YKkC+NN1mnC0pfnvU3ayfuThcUp3SqR9C7dXImV4TgQQyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336802; c=relaxed/simple;
	bh=FKWbd19jalYEG55oF8LJjTSqih/yVNXlXY42nJdE2h8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Gtr4bLRg8fxaIdwjnn74lDh/TAzqSamdiFM4rAp7aC1BfscxBP40U+gGML155IWUGGxcfB+wctzx07hpkUi95xYIbv9wXMNqokmlzFh5zV8U9wlYEmokBzeXUJyfbFKhkuLwLS7GVMjM8hMWmGMQcTCAK5KL4+dTQWaN8YZzKSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E564EC433C7;
	Wed, 13 Mar 2024 13:32:57 +0000 (UTC)
Date: Wed, 13 Mar 2024 09:34:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yufeng Mo
 <moyufeng@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH] net: hns3: tracing: fix hclgevf trace event strings
Message-ID: <20240313093454.3909afe7@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

[
   Note, I need to take this patch through my tree, so I'm looking for acks.
   This causes the build to fail when I add the __assign_str() check, which
   I was about to push to Linus, but it breaks allmodconfig due to this err=
or.
]

The __string() and __assign_str() helper macros of the TRACE_EVENT() macro
are going through some optimizations where only the source string of
__string() will be used and the __assign_str() source will be ignored and
later removed.

To make sure that there's no issues, a new check is added between the
__string() src argument and the __assign_str() src argument that does a
strcmp() to make sure they are the same string.

The hclgevf trace events have:

  __assign_str(devname, &hdev->nic.kinfo.netdev->name);

Which triggers the warning:

hclgevf_trace.h:34:39: error: passing argument 1 of =E2=80=98strcmp=E2=80=
=99 from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
   34 |                 __assign_str(devname, &hdev->nic.kinfo.netdev->name=
);
 [..]
arch/x86/include/asm/string_64.h:75:24: note: expected =E2=80=98const char =
*=E2=80=99 but argument is of type =E2=80=98char (*)[16]=E2=80=99
   75 | int strcmp(const char *cs, const char *ct);
      |            ~~~~~~~~~~~~^~


Because __assign_str() now has:

	WARN_ON_ONCE(__builtin_constant_p(src) ?		\
		     strcmp((src), __data_offsets.dst##_ptr_) :	\
		     (src) !=3D __data_offsets.dst##_ptr_);	\

The problem is the '&' on hdev->nic.kinfo.netdev->name. That's because
that name is:

	char			name[IFNAMSIZ]

Where passing an address '&' of a char array is not compatible with strcmp(=
).

The '&' is not necessary, remove it.

Fixes: d8355240cf8fb ("net: hns3: add trace event support for PF/VF mailbox=
")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h  | 8 ++++----
 .../net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h    | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h b/dri=
vers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
index 8510b88d4982..f3cd5a376eca 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
@@ -24,7 +24,7 @@ TRACE_EVENT(hclge_pf_mbx_get,
 		__field(u8, code)
 		__field(u8, subcode)
 		__string(pciname, pci_name(hdev->pdev))
-		__string(devname, &hdev->vport[0].nic.kinfo.netdev->name)
+		__string(devname, hdev->vport[0].nic.kinfo.netdev->name)
 		__array(u32, mbx_data, PF_GET_MBX_LEN)
 	),
=20
@@ -33,7 +33,7 @@ TRACE_EVENT(hclge_pf_mbx_get,
 		__entry->code =3D req->msg.code;
 		__entry->subcode =3D req->msg.subcode;
 		__assign_str(pciname, pci_name(hdev->pdev));
-		__assign_str(devname, &hdev->vport[0].nic.kinfo.netdev->name);
+		__assign_str(devname, hdev->vport[0].nic.kinfo.netdev->name);
 		memcpy(__entry->mbx_data, req,
 		       sizeof(struct hclge_mbx_vf_to_pf_cmd));
 	),
@@ -56,7 +56,7 @@ TRACE_EVENT(hclge_pf_mbx_send,
 		__field(u8, vfid)
 		__field(u16, code)
 		__string(pciname, pci_name(hdev->pdev))
-		__string(devname, &hdev->vport[0].nic.kinfo.netdev->name)
+		__string(devname, hdev->vport[0].nic.kinfo.netdev->name)
 		__array(u32, mbx_data, PF_SEND_MBX_LEN)
 	),
=20
@@ -64,7 +64,7 @@ TRACE_EVENT(hclge_pf_mbx_send,
 		__entry->vfid =3D req->dest_vfid;
 		__entry->code =3D le16_to_cpu(req->msg.code);
 		__assign_str(pciname, pci_name(hdev->pdev));
-		__assign_str(devname, &hdev->vport[0].nic.kinfo.netdev->name);
+		__assign_str(devname, hdev->vport[0].nic.kinfo.netdev->name);
 		memcpy(__entry->mbx_data, req,
 		       sizeof(struct hclge_mbx_pf_to_vf_cmd));
 	),
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h b/d=
rivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
index 5d4895bb57a1..b259e95dd53c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
@@ -23,7 +23,7 @@ TRACE_EVENT(hclge_vf_mbx_get,
 		__field(u8, vfid)
 		__field(u16, code)
 		__string(pciname, pci_name(hdev->pdev))
-		__string(devname, &hdev->nic.kinfo.netdev->name)
+		__string(devname, hdev->nic.kinfo.netdev->name)
 		__array(u32, mbx_data, VF_GET_MBX_LEN)
 	),
=20
@@ -31,7 +31,7 @@ TRACE_EVENT(hclge_vf_mbx_get,
 		__entry->vfid =3D req->dest_vfid;
 		__entry->code =3D le16_to_cpu(req->msg.code);
 		__assign_str(pciname, pci_name(hdev->pdev));
-		__assign_str(devname, &hdev->nic.kinfo.netdev->name);
+		__assign_str(devname, hdev->nic.kinfo.netdev->name);
 		memcpy(__entry->mbx_data, req,
 		       sizeof(struct hclge_mbx_pf_to_vf_cmd));
 	),
@@ -55,7 +55,7 @@ TRACE_EVENT(hclge_vf_mbx_send,
 		__field(u8, code)
 		__field(u8, subcode)
 		__string(pciname, pci_name(hdev->pdev))
-		__string(devname, &hdev->nic.kinfo.netdev->name)
+		__string(devname, hdev->nic.kinfo.netdev->name)
 		__array(u32, mbx_data, VF_SEND_MBX_LEN)
 	),
=20
@@ -64,7 +64,7 @@ TRACE_EVENT(hclge_vf_mbx_send,
 		__entry->code =3D req->msg.code;
 		__entry->subcode =3D req->msg.subcode;
 		__assign_str(pciname, pci_name(hdev->pdev));
-		__assign_str(devname, &hdev->nic.kinfo.netdev->name);
+		__assign_str(devname, hdev->nic.kinfo.netdev->name);
 		memcpy(__entry->mbx_data, req,
 		       sizeof(struct hclge_mbx_vf_to_pf_cmd));
 	),
--=20
2.43.0


