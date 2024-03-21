Return-Path: <linux-kernel+bounces-109671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843C5881C42
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED401F223E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C23481B4;
	Thu, 21 Mar 2024 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9KvdsPR"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8163FE4B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000837; cv=none; b=VF80BeNFcOdSaAa15bQmI+lrG+f7Q4FEpDB5kI9jslcUTSZZc2CHCfau4bGRIAJis4iL33/c3peijckk06X0am7oRVdzlOISaaRWpkNb6sgFo+2sj+NqUkGfwqc2PVQo1Y7Q3RDi1gcQU1nhFBBZHnzoES2dmad/6sWRXyQbWfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000837; c=relaxed/simple;
	bh=oRRr9HO2AV3synONSCw4+OBh566OUixFlJFvCqVgim4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dohCVhvDOQVibnSh9ip8dxyiE3Zoa2GgqYZxaEESdd06rhi76bxEUhyR5sqiQx7Ca0Y2dw27mAR6R96y5DfnO4/pO0zfzFgqA4XL0hoKHCjv7DReajcq7/d0mpJa43YOq7J3VrRg/FIi25H8PtLcrYs8V4A6twk9SIvXq8cyYFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K9KvdsPR; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd0ae66422fso1405430276.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711000833; x=1711605633; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtyqXatU3IKgpUYh/CKI++KW2zFgicWRyxErwKPQI6k=;
        b=K9KvdsPRQOUlpPHqrHTeTiWFVBfFLgQoWt0W4avzeIhDfXu9uj2CtNfPj9+L9aRVRR
         jbvGmA9BevhGbLE2MLVtCTXYWX/63VGGQ2/0mIokotESp2ACOOA3FWr6Z5BQ9Ub8mx+X
         z/7ezZV+uu6U9vE/uuGIet/Yhlx62WKbTFJ1XRSsJNJCXE7ae0yl9L/GsUryStMOj0Ib
         7vg0dZS62huHyOjezcQV3LoJAyWfvkAfbbvmTZb1XFgVlvzkHdIF4sAiE2lBoRnjxOfj
         aBgi62DLWRfO72NoIb76wA/7zQhlBmpT6ivcZajTJxIbQlYHG4BLRDaUG/Bs1fAERWjQ
         fFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000833; x=1711605633;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PtyqXatU3IKgpUYh/CKI++KW2zFgicWRyxErwKPQI6k=;
        b=mNIXZ2UN4/C6I+su8FsskvuMlFC18/BzoXBfC0jXy5eNlc0hQ/WyNIw9xQ3snPIq9W
         qu/nWyGyekrtjbpw91nCVFRshYqKLOj86Nowh+AIP6qsxx/3IwCDx/P24iMkt4QgHk8y
         Tn5U9wdo5QVy4oKUTbO6A0lMkWiJo4X+sZ4U2LKeVX4vV444ZFnJIWQ9kfREBTKAmd83
         1u5VOqt12bEKfY5S+kNguNQ2cQdeEx0vPXYSK4mMHKLVpiB+V0IpvrAFbj492OH2CkD9
         /FWzBc8RUYAMBenxCLAhIlOf8QQGUJ9COFUxyMkf3uCC/CV/YiOv4on2CltgSd1gR/zK
         fweQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfuYnSZRxoYpM/EZsrbNYc3aFlLWYKRgHVCMYomzzLRuC0Da1TGUYIAVHgZazXzaZkA6kgbZrySxqtqlyTisAvEvufcfZ0a0OWdJJP
X-Gm-Message-State: AOJu0YyH1zQCk9Jl6Q0DvIBkZi7d1CIbgl5RQNOetAuEMjj5XMUE9mT2
	sro1/xDhSsE0/iuGd+MsyUZVwD2rt2K2oBUh/WNFnkMErrQl9891oRBeJZetI0TInZ+s7gaJuer
	9UYSDbg==
X-Google-Smtp-Source: AGHT+IEwb2WnONnxZQU7XOyHS5WwbeI15LbCXLpjdrkFoInmHF2AwbbP1GArMXU6K7MckAR9ZVcczcD09sby
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a25:694b:0:b0:dd3:f55f:ff02 with SMTP id
 e72-20020a25694b000000b00dd3f55fff02mr343476ybc.1.1711000833121; Wed, 20 Mar
 2024 23:00:33 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:00:08 -0700
In-Reply-To: <20240321060016.1464787-1-irogers@google.com>
Message-Id: <20240321060016.1464787-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321060016.1464787-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v1 04/12] perf vendor events intel: Update icelakex to 1.24
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from 1.23 to 1.24 as released in:
https://github.com/intel/perfmon/commit/d883888ae60882028e387b6fe1ebf683beb=
693fa

Fixes spelling and descriptions. Adds the uncore events
UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_LOCAL and
UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_REMOTE, while removing
UNC_IIO_NUM_REQ_FROM_CPU.IRP.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/icelakex/frontend.json           |  2 +-
 .../pmu-events/arch/x86/icelakex/memory.json  |  1 +
 .../arch/x86/icelakex/uncore-cache.json       | 22 ++++++-
 .../x86/icelakex/uncore-interconnect.json     | 64 +++++++++----------
 .../arch/x86/icelakex/uncore-io.json          | 11 ----
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 6 files changed, 55 insertions(+), 47 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelakex/frontend.json b/tools/=
perf/pmu-events/arch/x86/icelakex/frontend.json
index f6edc4222f42..66669d062e68 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/frontend.json
@@ -282,7 +282,7 @@
         "CounterMask": "5",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_OK",
-        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the D=
SB (Decode Stream Buffer) path. Count includes uops that may 'bypass' the I=
DQ.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/memory.json b/tools/pe=
rf/pmu-events/arch/x86/icelakex/memory.json
index f36ac04f8d76..875b584b8443 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/memory.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/memory.json
@@ -319,6 +319,7 @@
         "BriefDescription": "Number of times an RTM execution aborted.",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED",
+        "PEBS": "1",
         "PublicDescription": "Counts the number of times RTM abort was tri=
ggered.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
index b6ce14ebf844..a950ba3ddcb4 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
@@ -1580,7 +1580,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_LOOKUP.CODE_READ",
+        "BriefDescription": "This event is deprecated.",
         "Deprecated": "1",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.CODE",
@@ -1677,7 +1677,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_LOOKUP.DATA_READ",
+        "BriefDescription": "This event is deprecated.",
         "Deprecated": "1",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_ALL",
@@ -6782,6 +6782,24 @@
         "UMask": "0xc8f3ff04",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "PCIRDCUR (read) transactions from an IO devic=
e that addresses memory on the local socket",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
 and targets local memory : Counts the number of entries successfully inser=
ted into the TOR that match qualifications specified by the subevent.   Doe=
s not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8f2ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PCIRDCUR (read) transactions from an IO devic=
e that addresses memory on a remote socket",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
 and targets remote memory : Counts the number of entries successfully inse=
rted into the TOR that match qualifications specified by the subevent.   Do=
es not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8f37f04",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts : RFOs issued by IO Devices",
         "EventCode": "0x35",
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
index a066a009c511..6997e6f7d366 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
@@ -13523,7 +13523,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Bypass : Matches on Receive path of a UPI port.\r\nMatch based on =
UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enable=
\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote E=
nable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr E=
nable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are excluded=
 (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r\n=
Note: If Message Class is disabled, we expect opcode to also be disabled.",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Bypass : Matches on Receive path of a UPI port. Match based on UMa=
sk specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opcod=
e (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr Ena=
ble R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Enabl=
e Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) even un=
der specific opcode match_en cases. Note: If Message Class is disabled, we =
expect opcode to also be disabled.",
         "UMask": "0xe",
         "Unit": "UPI"
     },
@@ -13532,7 +13532,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Bypass, Match Opcode : Matches on Receive path of a UPI port.\r\nM=
atch based on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Messag=
e Class Enable\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\=
r\nT: Remote Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: D=
ual Slot Hdr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control type=
s are excluded (LL CTRL, slot NULL, LLCRD) even under specific opcode match=
_en cases.\r\nNote: If Message Class is disabled, we expect opcode to also =
be disabled.",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Bypass, Match Opcode : Matches on Receive path of a UPI port. Matc=
h based on UMask specific bits: Z: Message Class (3-bit) Y: Message Class E=
nable W: Opcode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S=
: Data Hdr Enable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single =
Slot Hdr Enable Link Layer control types are excluded (LL CTRL, slot NULL, =
LLCRD) even under specific opcode match_en cases. Note: If Message Class is=
 disabled, we expect opcode to also be disabled.",
         "UMask": "0x10e",
         "Unit": "UPI"
     },
@@ -13541,7 +13541,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Standard : Matches on Receive path of a UPI port.\r\nMatch based o=
n UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enab=
le\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote=
 Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr=
 Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are exclud=
ed (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r=
\nNote: If Message Class is disabled, we expect opcode to also be disabled.=
",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Standard : Matches on Receive path of a UPI port. Match based on U=
Mask specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opc=
ode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr E=
nable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Ena=
ble Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) even =
under specific opcode match_en cases. Note: If Message Class is disabled, w=
e expect opcode to also be disabled.",
         "UMask": "0xf",
         "Unit": "UPI"
     },
@@ -13550,7 +13550,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Standard, Match Opcode : Matches on Receive path of a UPI port.\r\=
nMatch based on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Mess=
age Class Enable\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enabl=
e\r\nT: Remote Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ:=
 Dual Slot Hdr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control ty=
pes are excluded (LL CTRL, slot NULL, LLCRD) even under specific opcode mat=
ch_en cases.\r\nNote: If Message Class is disabled, we expect opcode to als=
o be disabled.",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Standard, Match Opcode : Matches on Receive path of a UPI port. Ma=
tch based on UMask specific bits: Z: Message Class (3-bit) Y: Message Class=
 Enable W: Opcode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable=
 S: Data Hdr Enable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Singl=
e Slot Hdr Enable Link Layer control types are excluded (LL CTRL, slot NULL=
, LLCRD) even under specific opcode match_en cases. Note: If Message Class =
is disabled, we expect opcode to also be disabled.",
         "UMask": "0x10f",
         "Unit": "UPI"
     },
@@ -13559,7 +13559,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.REQ",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Requ=
est : Matches on Receive path of a UPI port.\r\nMatch based on UMask specif=
ic bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enable\r\nW: Opcod=
e (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote Enable\r\nS: =
Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr Enable\r\nP: =
Single Slot Hdr Enable\r\nLink Layer control types are excluded (LL CTRL, s=
lot NULL, LLCRD) even under specific opcode match_en cases.\r\nNote: If Mes=
sage Class is disabled, we expect opcode to also be disabled.",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Requ=
est : Matches on Receive path of a UPI port. Match based on UMask specific =
bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opcode (4-bit) V:=
 Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr Enable R: Non-D=
ata Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Enable Link Layer=
 control types are excluded (LL CTRL, slot NULL, LLCRD) even under specific=
 opcode match_en cases. Note: If Message Class is disabled, we expect opcod=
e to also be disabled.",
         "UMask": "0x8",
         "Unit": "UPI"
     },
@@ -13568,7 +13568,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.REQ_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Requ=
est, Match Opcode : Matches on Receive path of a UPI port.\r\nMatch based o=
n UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enab=
le\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote=
 Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr=
 Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are exclud=
ed (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r=
\nNote: If Message Class is disabled, we expect opcode to also be disabled.=
",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Requ=
est, Match Opcode : Matches on Receive path of a UPI port. Match based on U=
Mask specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opc=
ode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr E=
nable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Ena=
ble Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) even =
under specific opcode match_en cases. Note: If Message Class is disabled, w=
e expect opcode to also be disabled.",
         "UMask": "0x108",
         "Unit": "UPI"
     },
@@ -13577,7 +13577,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSPCNFLT",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Resp=
onse - Conflict : Matches on Receive path of a UPI port.\r\nMatch based on =
UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enable=
\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote E=
nable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr E=
nable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are excluded=
 (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r\n=
Note: If Message Class is disabled, we expect opcode to also be disabled.",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Resp=
onse - Conflict : Matches on Receive path of a UPI port. Match based on UMa=
sk specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opcod=
e (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr Ena=
ble R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Enabl=
e Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) even un=
der specific opcode match_en cases. Note: If Message Class is disabled, we =
expect opcode to also be disabled.",
         "UMask": "0x1aa",
         "Unit": "UPI"
     },
@@ -13586,7 +13586,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSPI",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Resp=
onse - Invalid : Matches on Receive path of a UPI port.\r\nMatch based on U=
Mask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enable\=
r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote En=
able\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr En=
able\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are excluded =
(LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r\nN=
ote: If Message Class is disabled, we expect opcode to also be disabled.",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Resp=
onse - Invalid : Matches on Receive path of a UPI port. Match based on UMas=
k specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opcode=
 (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr Enab=
le R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Enable=
 Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) even und=
er specific opcode match_en cases. Note: If Message Class is disabled, we e=
xpect opcode to also be disabled.",
         "UMask": "0x12a",
         "Unit": "UPI"
     },
@@ -13595,7 +13595,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Resp=
onse - Data : Matches on Receive path of a UPI port.\r\nMatch based on UMas=
k specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enable\r\n=
W: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote Enabl=
e\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr Enabl=
e\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are excluded (LL=
 CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r\nNote=
: If Message Class is disabled, we expect opcode to also be disabled.",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Resp=
onse - Data : Matches on Receive path of a UPI port. Match based on UMask s=
pecific bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opcode (4=
-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr Enable =
R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Enable Li=
nk Layer control types are excluded (LL CTRL, slot NULL, LLCRD) even under =
specific opcode match_en cases. Note: If Message Class is disabled, we expe=
ct opcode to also be disabled.",
         "UMask": "0xc",
         "Unit": "UPI"
     },
@@ -13604,7 +13604,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_DATA_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Resp=
onse - Data, Match Opcode : Matches on Receive path of a UPI port.\r\nMatch=
 based on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Cl=
ass Enable\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT=
: Remote Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual =
Slot Hdr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types ar=
e excluded (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en =
cases.\r\nNote: If Message Class is disabled, we expect opcode to also be d=
isabled.",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Resp=
onse - Data, Match Opcode : Matches on Receive path of a UPI port. Match ba=
sed on UMask specific bits: Z: Message Class (3-bit) Y: Message Class Enabl=
e W: Opcode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Da=
ta Hdr Enable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot=
 Hdr Enable Link Layer control types are excluded (LL CTRL, slot NULL, LLCR=
D) even under specific opcode match_en cases. Note: If Message Class is dis=
abled, we expect opcode to also be disabled.",
         "UMask": "0x10c",
         "Unit": "UPI"
     },
@@ -13613,7 +13613,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_NODATA",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Resp=
onse - No Data : Matches on Receive path of a UPI port.\r\nMatch based on U=
Mask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enable\=
r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote En=
able\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr En=
able\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are excluded =
(LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r\nN=
ote: If Message Class is disabled, we expect opcode to also be disabled.",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Resp=
onse - No Data : Matches on Receive path of a UPI port. Match based on UMas=
k specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opcode=
 (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr Enab=
le R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Enable=
 Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) even und=
er specific opcode match_en cases. Note: If Message Class is disabled, we e=
xpect opcode to also be disabled.",
         "UMask": "0xa",
         "Unit": "UPI"
     },
@@ -13622,7 +13622,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_NODATA_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Resp=
onse - No Data, Match Opcode : Matches on Receive path of a UPI port.\r\nMa=
tch based on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message=
 Class Enable\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r=
\nT: Remote Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Du=
al Slot Hdr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types=
 are excluded (LL CTRL, slot NULL, LLCRD) even under specific opcode match_=
en cases.\r\nNote: If Message Class is disabled, we expect opcode to also b=
e disabled.",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Resp=
onse - No Data, Match Opcode : Matches on Receive path of a UPI port. Match=
 based on UMask specific bits: Z: Message Class (3-bit) Y: Message Class En=
able W: Opcode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S:=
 Data Hdr Enable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single S=
lot Hdr Enable Link Layer control types are excluded (LL CTRL, slot NULL, L=
LCRD) even under specific opcode match_en cases. Note: If Message Class is =
disabled, we expect opcode to also be disabled.",
         "UMask": "0x10a",
         "Unit": "UPI"
     },
@@ -13631,7 +13631,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.SNP",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Snoo=
p : Matches on Receive path of a UPI port.\r\nMatch based on UMask specific=
 bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enable\r\nW: Opcode =
(4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote Enable\r\nS: Da=
ta Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr Enable\r\nP: Si=
ngle Slot Hdr Enable\r\nLink Layer control types are excluded (LL CTRL, slo=
t NULL, LLCRD) even under specific opcode match_en cases.\r\nNote: If Messa=
ge Class is disabled, we expect opcode to also be disabled.",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Snoo=
p : Matches on Receive path of a UPI port. Match based on UMask specific bi=
ts: Z: Message Class (3-bit) Y: Message Class Enable W: Opcode (4-bit) V: O=
pcode Enable U: Local Enable T: Remote Enable S: Data Hdr Enable R: Non-Dat=
a Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Enable Link Layer c=
ontrol types are excluded (LL CTRL, slot NULL, LLCRD) even under specific o=
pcode match_en cases. Note: If Message Class is disabled, we expect opcode =
to also be disabled.",
         "UMask": "0x9",
         "Unit": "UPI"
     },
@@ -13640,7 +13640,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.SNP_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Snoo=
p, Match Opcode : Matches on Receive path of a UPI port.\r\nMatch based on =
UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enable=
\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote E=
nable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr E=
nable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are excluded=
 (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r\n=
Note: If Message Class is disabled, we expect opcode to also be disabled.",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Snoo=
p, Match Opcode : Matches on Receive path of a UPI port. Match based on UMa=
sk specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opcod=
e (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr Ena=
ble R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Enabl=
e Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) even un=
der specific opcode match_en cases. Note: If Message Class is disabled, we =
expect opcode to also be disabled.",
         "UMask": "0x109",
         "Unit": "UPI"
     },
@@ -13649,7 +13649,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.WB",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Writ=
eback : Matches on Receive path of a UPI port.\r\nMatch based on UMask spec=
ific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enable\r\nW: Opc=
ode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote Enable\r\nS=
: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr Enable\r\nP=
: Single Slot Hdr Enable\r\nLink Layer control types are excluded (LL CTRL,=
 slot NULL, LLCRD) even under specific opcode match_en cases.\r\nNote: If M=
essage Class is disabled, we expect opcode to also be disabled.",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Writ=
eback : Matches on Receive path of a UPI port. Match based on UMask specifi=
c bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opcode (4-bit) =
V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr Enable R: Non=
-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Enable Link Lay=
er control types are excluded (LL CTRL, slot NULL, LLCRD) even under specif=
ic opcode match_en cases. Note: If Message Class is disabled, we expect opc=
ode to also be disabled.",
         "UMask": "0xd",
         "Unit": "UPI"
     },
@@ -13658,7 +13658,7 @@
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.WB_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Receive path of a UPI Port : Writ=
eback, Match Opcode : Matches on Receive path of a UPI port.\r\nMatch based=
 on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class En=
able\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remo=
te Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot H=
dr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are excl=
uded (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.=
\r\nNote: If Message Class is disabled, we expect opcode to also be disable=
d.",
+        "PublicDescription": "Matches on Receive path of a UPI Port : Writ=
eback, Match Opcode : Matches on Receive path of a UPI port. Match based on=
 UMask specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: O=
pcode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr=
 Enable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr E=
nable Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) eve=
n under specific opcode match_en cases. Note: If Message Class is disabled,=
 we expect opcode to also be disabled.",
         "UMask": "0x10d",
         "Unit": "UPI"
     },
@@ -14038,7 +14038,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Bypass : Matches on Transmit path of a UPI port.\r\nMatch based o=
n UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enab=
le\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote=
 Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr=
 Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are exclud=
ed (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r=
\nNote: If Message Class is disabled, we expect opcode to also be disabled.=
",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Bypass : Matches on Transmit path of a UPI port. Match based on U=
Mask specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opc=
ode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr E=
nable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Ena=
ble Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) even =
under specific opcode match_en cases. Note: If Message Class is disabled, w=
e expect opcode to also be disabled.",
         "UMask": "0xe",
         "Unit": "UPI"
     },
@@ -14047,7 +14047,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Bypass, Match Opcode : Matches on Transmit path of a UPI port.\r\=
nMatch based on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Mess=
age Class Enable\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enabl=
e\r\nT: Remote Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ:=
 Dual Slot Hdr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control ty=
pes are excluded (LL CTRL, slot NULL, LLCRD) even under specific opcode mat=
ch_en cases.\r\nNote: If Message Class is disabled, we expect opcode to als=
o be disabled.",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Bypass, Match Opcode : Matches on Transmit path of a UPI port. Ma=
tch based on UMask specific bits: Z: Message Class (3-bit) Y: Message Class=
 Enable W: Opcode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable=
 S: Data Hdr Enable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Singl=
e Slot Hdr Enable Link Layer control types are excluded (LL CTRL, slot NULL=
, LLCRD) even under specific opcode match_en cases. Note: If Message Class =
is disabled, we expect opcode to also be disabled.",
         "UMask": "0x10e",
         "Unit": "UPI"
     },
@@ -14056,7 +14056,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Standard : Matches on Transmit path of a UPI port.\r\nMatch based=
 on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class En=
able\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remo=
te Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot H=
dr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are excl=
uded (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.=
\r\nNote: If Message Class is disabled, we expect opcode to also be disable=
d.",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Standard : Matches on Transmit path of a UPI port. Match based on=
 UMask specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: O=
pcode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr=
 Enable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr E=
nable Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) eve=
n under specific opcode match_en cases. Note: If Message Class is disabled,=
 we expect opcode to also be disabled.",
         "UMask": "0xf",
         "Unit": "UPI"
     },
@@ -14065,7 +14065,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Standard, Match Opcode : Matches on Transmit path of a UPI port.\=
r\nMatch based on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Me=
ssage Class Enable\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Ena=
ble\r\nT: Remote Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\n=
Q: Dual Slot Hdr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control =
types are excluded (LL CTRL, slot NULL, LLCRD) even under specific opcode m=
atch_en cases.\r\nNote: If Message Class is disabled, we expect opcode to a=
lso be disabled.",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Standard, Match Opcode : Matches on Transmit path of a UPI port. =
Match based on UMask specific bits: Z: Message Class (3-bit) Y: Message Cla=
ss Enable W: Opcode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enab=
le S: Data Hdr Enable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Sin=
gle Slot Hdr Enable Link Layer control types are excluded (LL CTRL, slot NU=
LL, LLCRD) even under specific opcode match_en cases. Note: If Message Clas=
s is disabled, we expect opcode to also be disabled.",
         "UMask": "0x10f",
         "Unit": "UPI"
     },
@@ -14074,7 +14074,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.REQ",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Req=
uest : Matches on Transmit path of a UPI port.\r\nMatch based on UMask spec=
ific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enable\r\nW: Opc=
ode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote Enable\r\nS=
: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr Enable\r\nP=
: Single Slot Hdr Enable\r\nLink Layer control types are excluded (LL CTRL,=
 slot NULL, LLCRD) even under specific opcode match_en cases.\r\nNote: If M=
essage Class is disabled, we expect opcode to also be disabled.",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Req=
uest : Matches on Transmit path of a UPI port. Match based on UMask specifi=
c bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opcode (4-bit) =
V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr Enable R: Non=
-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Enable Link Lay=
er control types are excluded (LL CTRL, slot NULL, LLCRD) even under specif=
ic opcode match_en cases. Note: If Message Class is disabled, we expect opc=
ode to also be disabled.",
         "UMask": "0x8",
         "Unit": "UPI"
     },
@@ -14083,7 +14083,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.REQ_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Req=
uest, Match Opcode : Matches on Transmit path of a UPI port.\r\nMatch based=
 on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class En=
able\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remo=
te Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot H=
dr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are excl=
uded (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.=
\r\nNote: If Message Class is disabled, we expect opcode to also be disable=
d.",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Req=
uest, Match Opcode : Matches on Transmit path of a UPI port. Match based on=
 UMask specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: O=
pcode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr=
 Enable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr E=
nable Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) eve=
n under specific opcode match_en cases. Note: If Message Class is disabled,=
 we expect opcode to also be disabled.",
         "UMask": "0x108",
         "Unit": "UPI"
     },
@@ -14092,7 +14092,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSPCNFLT",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Res=
ponse - Conflict : Matches on Transmit path of a UPI port.\r\nMatch based o=
n UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enab=
le\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote=
 Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr=
 Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are exclud=
ed (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r=
\nNote: If Message Class is disabled, we expect opcode to also be disabled.=
",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Res=
ponse - Conflict : Matches on Transmit path of a UPI port. Match based on U=
Mask specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opc=
ode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr E=
nable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Ena=
ble Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) even =
under specific opcode match_en cases. Note: If Message Class is disabled, w=
e expect opcode to also be disabled.",
         "UMask": "0x1aa",
         "Unit": "UPI"
     },
@@ -14101,7 +14101,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSPI",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Res=
ponse - Invalid : Matches on Transmit path of a UPI port.\r\nMatch based on=
 UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enabl=
e\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote =
Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr =
Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are exclude=
d (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r\=
nNote: If Message Class is disabled, we expect opcode to also be disabled."=
,
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Res=
ponse - Invalid : Matches on Transmit path of a UPI port. Match based on UM=
ask specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opco=
de (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr En=
able R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Enab=
le Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) even u=
nder specific opcode match_en cases. Note: If Message Class is disabled, we=
 expect opcode to also be disabled.",
         "UMask": "0x12a",
         "Unit": "UPI"
     },
@@ -14110,7 +14110,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Res=
ponse - Data : Matches on Transmit path of a UPI port.\r\nMatch based on UM=
ask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enable\r=
\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote Ena=
ble\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr Ena=
ble\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are excluded (=
LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r\nNo=
te: If Message Class is disabled, we expect opcode to also be disabled.",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Res=
ponse - Data : Matches on Transmit path of a UPI port. Match based on UMask=
 specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opcode =
(4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr Enabl=
e R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Enable =
Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) even unde=
r specific opcode match_en cases. Note: If Message Class is disabled, we ex=
pect opcode to also be disabled.",
         "UMask": "0xc",
         "Unit": "UPI"
     },
@@ -14119,7 +14119,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_DATA_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Res=
ponse - Data, Match Opcode : Matches on Transmit path of a UPI port.\r\nMat=
ch based on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message =
Class Enable\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\=
nT: Remote Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dua=
l Slot Hdr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types =
are excluded (LL CTRL, slot NULL, LLCRD) even under specific opcode match_e=
n cases.\r\nNote: If Message Class is disabled, we expect opcode to also be=
 disabled.",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Res=
ponse - Data, Match Opcode : Matches on Transmit path of a UPI port. Match =
based on UMask specific bits: Z: Message Class (3-bit) Y: Message Class Ena=
ble W: Opcode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: =
Data Hdr Enable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Sl=
ot Hdr Enable Link Layer control types are excluded (LL CTRL, slot NULL, LL=
CRD) even under specific opcode match_en cases. Note: If Message Class is d=
isabled, we expect opcode to also be disabled.",
         "UMask": "0x10c",
         "Unit": "UPI"
     },
@@ -14128,7 +14128,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_NODATA",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Res=
ponse - No Data : Matches on Transmit path of a UPI port.\r\nMatch based on=
 UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enabl=
e\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote =
Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr =
Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are exclude=
d (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r\=
nNote: If Message Class is disabled, we expect opcode to also be disabled."=
,
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Res=
ponse - No Data : Matches on Transmit path of a UPI port. Match based on UM=
ask specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opco=
de (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr En=
able R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Enab=
le Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) even u=
nder specific opcode match_en cases. Note: If Message Class is disabled, we=
 expect opcode to also be disabled.",
         "UMask": "0xa",
         "Unit": "UPI"
     },
@@ -14137,7 +14137,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_NODATA_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Res=
ponse - No Data, Match Opcode : Matches on Transmit path of a UPI port.\r\n=
Match based on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Messa=
ge Class Enable\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable=
\r\nT: Remote Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: =
Dual Slot Hdr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control typ=
es are excluded (LL CTRL, slot NULL, LLCRD) even under specific opcode matc=
h_en cases.\r\nNote: If Message Class is disabled, we expect opcode to also=
 be disabled.",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Res=
ponse - No Data, Match Opcode : Matches on Transmit path of a UPI port. Mat=
ch based on UMask specific bits: Z: Message Class (3-bit) Y: Message Class =
Enable W: Opcode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable =
S: Data Hdr Enable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single=
 Slot Hdr Enable Link Layer control types are excluded (LL CTRL, slot NULL,=
 LLCRD) even under specific opcode match_en cases. Note: If Message Class i=
s disabled, we expect opcode to also be disabled.",
         "UMask": "0x10a",
         "Unit": "UPI"
     },
@@ -14146,7 +14146,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.SNP",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Sno=
op : Matches on Transmit path of a UPI port.\r\nMatch based on UMask specif=
ic bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enable\r\nW: Opcod=
e (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote Enable\r\nS: =
Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr Enable\r\nP: =
Single Slot Hdr Enable\r\nLink Layer control types are excluded (LL CTRL, s=
lot NULL, LLCRD) even under specific opcode match_en cases.\r\nNote: If Mes=
sage Class is disabled, we expect opcode to also be disabled.",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Sno=
op : Matches on Transmit path of a UPI port. Match based on UMask specific =
bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opcode (4-bit) V:=
 Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr Enable R: Non-D=
ata Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Enable Link Layer=
 control types are excluded (LL CTRL, slot NULL, LLCRD) even under specific=
 opcode match_en cases. Note: If Message Class is disabled, we expect opcod=
e to also be disabled.",
         "UMask": "0x9",
         "Unit": "UPI"
     },
@@ -14155,7 +14155,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.SNP_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Sno=
op, Match Opcode : Matches on Transmit path of a UPI port.\r\nMatch based o=
n UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enab=
le\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote=
 Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr=
 Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are exclud=
ed (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r=
\nNote: If Message Class is disabled, we expect opcode to also be disabled.=
",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Sno=
op, Match Opcode : Matches on Transmit path of a UPI port. Match based on U=
Mask specific bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opc=
ode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr E=
nable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Ena=
ble Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) even =
under specific opcode match_en cases. Note: If Message Class is disabled, w=
e expect opcode to also be disabled.",
         "UMask": "0x109",
         "Unit": "UPI"
     },
@@ -14164,7 +14164,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.WB",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Wri=
teback : Matches on Transmit path of a UPI port.\r\nMatch based on UMask sp=
ecific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enable\r\nW: O=
pcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote Enable\r\=
nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr Enable\r\=
nP: Single Slot Hdr Enable\r\nLink Layer control types are excluded (LL CTR=
L, slot NULL, LLCRD) even under specific opcode match_en cases.\r\nNote: If=
 Message Class is disabled, we expect opcode to also be disabled.",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Wri=
teback : Matches on Transmit path of a UPI port. Match based on UMask speci=
fic bits: Z: Message Class (3-bit) Y: Message Class Enable W: Opcode (4-bit=
) V: Opcode Enable U: Local Enable T: Remote Enable S: Data Hdr Enable R: N=
on-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr Enable Link L=
ayer control types are excluded (LL CTRL, slot NULL, LLCRD) even under spec=
ific opcode match_en cases. Note: If Message Class is disabled, we expect o=
pcode to also be disabled.",
         "UMask": "0xd",
         "Unit": "UPI"
     },
@@ -14173,7 +14173,7 @@
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.WB_OPC",
         "PerPkg": "1",
-        "PublicDescription": "Matches on Transmit path of a UPI Port : Wri=
teback, Match Opcode : Matches on Transmit path of a UPI port.\r\nMatch bas=
ed on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class =
Enable\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Re=
mote Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot=
 Hdr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are ex=
cluded (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en case=
s.\r\nNote: If Message Class is disabled, we expect opcode to also be disab=
led.",
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Wri=
teback, Match Opcode : Matches on Transmit path of a UPI port. Match based =
on UMask specific bits: Z: Message Class (3-bit) Y: Message Class Enable W:=
 Opcode (4-bit) V: Opcode Enable U: Local Enable T: Remote Enable S: Data H=
dr Enable R: Non-Data Hdr Enable Q: Dual Slot Hdr Enable P: Single Slot Hdr=
 Enable Link Layer control types are excluded (LL CTRL, slot NULL, LLCRD) e=
ven under specific opcode match_en cases. Note: If Message Class is disable=
d, we expect opcode to also be disabled.",
         "UMask": "0x10d",
         "Unit": "UPI"
     },
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-io.json b/tools=
/perf/pmu-events/arch/x86/icelakex/uncore-io.json
index 9cef8862c428..1b8a719b81a5 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-io.json
@@ -2476,17 +2476,6 @@
         "UMask": "0x10",
         "Unit": "IIO"
     },
-    {
-        "BriefDescription": "Number requests sent to PCIe from main die : =
From IRP",
-        "EventCode": "0xC2",
-        "EventName": "UNC_IIO_NUM_REQ_FROM_CPU.IRP",
-        "FCMask": "0x07",
-        "PerPkg": "1",
-        "PortMask": "0xFF",
-        "PublicDescription": "Number requests sent to PCIe from main die :=
 From IRP : Captures Posted/Non-posted allocations from IRP. i.e. either no=
n-confined P2P traffic or from the CPU",
-        "UMask": "0x1",
-        "Unit": "IIO"
-    },
     {
         "BriefDescription": "Number requests sent to PCIe from main die : =
From ITC",
         "EventCode": "0xC2",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 650c28574576..a219dc3bd1ef 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -15,7 +15,7 @@ GenuineIntel-6-A[DE],v1.01,graniterapids,core
 GenuineIntel-6-(3C|45|46),v35,haswell,core
 GenuineIntel-6-3F,v28,haswellx,core
 GenuineIntel-6-7[DE],v1.21,icelake,core
-GenuineIntel-6-6[AC],v1.23,icelakex,core
+GenuineIntel-6-6[AC],v1.24,icelakex,core
 GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
--=20
2.44.0.396.g6e790dbe36-goog


