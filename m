Return-Path: <linux-kernel+bounces-100804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35924879D75
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E99284BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849EF144029;
	Tue, 12 Mar 2024 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="WBDlgpJV"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2126.outbound.protection.outlook.com [40.107.237.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905F2143C7F;
	Tue, 12 Mar 2024 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710278811; cv=fail; b=Mi7hgp1LAOZiDtZbQT2pDkZj/FOaeC8GK0chk2stOSCc61Oq9ft69jXd/uaqmH2Qq0O8X+LhdfDT4RM08NQnUWy3+D85+E3fE/o9E9iM1U5C6x4e7KdN7au89+QYt1B5h/T/BZqGTXAajS9UNpjxiqZ4y7G4XGCHZ6kR8X/E+Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710278811; c=relaxed/simple;
	bh=Zouqv0H5L57F70wlrfIVnkRFBAfzjyUsXKhaeVoGmkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F4s2Q+UGd+aYiyObM/R/HKC1LGkTUt2bMOGtl7PA47SWpMY73EON1+6uemIDvm7ghCbRDenbwkiBHj9w9MJhradfAkIOEspD/efNFOv+evmglS6ikrp/rTCNZy2nW7wahe9oKZhxpEnpiRuZJNV6UITMPXsXgArVdydndwxJh14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=WBDlgpJV; arc=fail smtp.client-ip=40.107.237.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS80xVn65FJHm0kPrDr7CjBedfbTlqR8qGtsjfq/5/ku1Ua/g2jLVwYXHXGlRXqnLo8HcDOlv0aEMDnduuIUxlI7RsHXUvaKd1e50tDXLr1ntvlVz2BkZQ10+11s5YXL3+a/mdh4uDyi+TX0Y+feXxyxPlZsHqxalfWMfyW++jjVcnaTI1Uz6k5JNbLVAHM1U8RCNf4Xdfo2r0Vqm0F1BLrJu/v540/PyBFnokD7nC8zfbEuCUTDRCNFaExlsBVK0bHaj4ySaakyBpSTUP4HQuz8H6D9wZn6E4QWE4h5OFsPJlHG8dPQ8as/c2dRUuRoSSmKlaMq215gCnFhiD48dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E72ao28cVRLUj9uWfez2xjvUiB007hmiNtOKAy/mdHI=;
 b=UaBFmKi6VaT6hHMVA1tFH4JD9gk99bNYQM33bbBcn8WZ7Ei6hrxt2PJx5VapONWtMRUeX+Hk3ghPsoa0sZEVlccHym0+PnbGvJnWTM1Z/TnTKbZozERWLmGNPSg42WeIlFBCPbwBc6kq8uXAmWDNuxqfxm9BBBWES89TAdl0wnbGTvuLmqqXQ3270hWtoajDQD75e5tEtgtZqJdJu/HP2UoeUprzzMUidB7yKopCALdCvQdNyg60uK6ph6Msmt+hrKa52Plw/r58FGT0t0M1jVxJ5IVSw/n9L1wM66GqzjOTvKtbNvra2fe4LxgSKndLPxjXmUa+5Q5bvkkWr+d9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E72ao28cVRLUj9uWfez2xjvUiB007hmiNtOKAy/mdHI=;
 b=WBDlgpJVeP4FJCaW9zQeM7QUm5ZESibOjq77xFM7pwFMm50ZjWTKeb5AmoWSKmrC6gyiv7U57F0yAtMJqI256fKYlLgwEhUw0LHNgSE7kRzcz6/g+QZLf9jz2ai1IANcrdna6nv1ZY35DAwVNKZu0sNAHw9Gal/frgfB4Hh9LdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SJ2PR01MB8102.prod.exchangelabs.com (2603:10b6:a03:4fd::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.18; Tue, 12 Mar 2024 21:26:41 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::32c0:d77c:f00b:bacd]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::32c0:d77c:f00b:bacd%6]) with mapi id 15.20.7362.031; Tue, 12 Mar 2024
 21:26:41 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: zaidal@os.amperecomputing.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	Avadhut.Naik@amd.com,
	xueshuai@linux.alibaba.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [RFC PATCH 4/5] ACPI: APEI: EINJ: Enable EINJv2 error injections
Date: Tue, 12 Mar 2024 14:26:25 -0700
Message-Id: <20240312212626.29007-5-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312212626.29007-1-zaidal@os.amperecomputing.com>
References: <20240312212626.29007-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:907::18)
 To SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SJ2PR01MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b34ced-6d06-4ed3-f0bf-08dc42db1bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rJpFK+q7oRo+BlmaMtFwruV1qSwTh29Hi8jtddh5enCr7PkLb4LN9knOaLtmKdcxjF9LnFFjV4VgTnHxvxkReFh0TL+MUvBv6OAbzVyFKvzfefx8plTTVTJ/pVRWNLF5u8skj8BCJy15k9D0wfLXdE5MKiXsmYCYS2B5S2DEI+6ock9uCnxSiXHREX8eR6b5u+Uz+eSnjxi/zJUgbuYCsWPb+speLM1YEQm1BGcbYUEKNBaPASaVYOiyzqZXaDUdkZHFC9uRAMaGJDYwSPFP2MYubNjiUyyEIZ9QUkmybZoVdYZYrtRteQQ3G2nDDXP6bS7SOtQJXuHW2y9aE7dCE8WuCC81t1fFxpSwQnJeKZcuXmwEhEU8oxjLYY+Do+GrnAvSr/+3OLmKMy3ukDsh7dsQBA8J+2V96uL1YQ7uXFRC4cRK5BArrviBFk9Gx2N2pyXN1wFLYkx3/UBzVHCPpBuqq/VOA/sKP9arD/QHFhYOP+Xu3RizXwsYRwxwMtilEFO/pK8MbKtRT7u6pCNQSd4UN5PbZ96mJsZy5YsSFCdO+GFcmfAdivfN7jT6GqigMCb1M/IUwzkxImq50qdJtL3Dza8r6WSs86SrnmWhmobZD4/2dGtIFpjkKpk1TEvaC5V87/Hkp7UnUj+wPgBSioUPAUY+W4SK2RfcKbjBppaqJ2dT2kq3ostc9OQSjTOvnKaEog/3SR4tNVKLQquJvpwhkB4J1f3nrKHlB3GFEWo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IuFDM08occ+M8cc5xUbS5cvn7stbKg5pqvd11N+yRGkwE0+t+kCBTrAbDg37?=
 =?us-ascii?Q?5wTW4aDIiqwVunEObmtqFYfQnbRoV4Suow0g/oWjPgdgxr4JwG20udfb/do3?=
 =?us-ascii?Q?g3zEFH3NAxT9Crs/NGK1edaHxG+5CDa06ronzZfyNwzUj+5ZqwxR91Whb4SD?=
 =?us-ascii?Q?i9xrrt/mDou+zrv1nDEtSyF0dY2dAwbuWzSdTpm+7Wap69uFgHRg3EBaRMrp?=
 =?us-ascii?Q?1rGHf7PJUMDl+L295Gzx6Ucc+eP8BLWM7Rtvz7mo5vCwjMLrirTQI/bgpn0n?=
 =?us-ascii?Q?/lymspzvcHxJ3dxrtIBbWMozYSIwD4gesq0KDegtq+kQCq/HIFhylxby4U4c?=
 =?us-ascii?Q?0DgptuuEYf1ZmUf/SYbipXTG1ETpCciccV3UD2JpSYKDc0N03nwsmPZ2Oyr1?=
 =?us-ascii?Q?M8Z92qDLmYOcG+XkWEI3e47/LgkR8V/YNyHiiD/3a2IKbTChUnAJ6FMGY6hF?=
 =?us-ascii?Q?ywlc5Nnt90W01KUiwk1N1dIVXH/pac0fcbv/O82lK3tWrjVVIXh4eHvPlcR6?=
 =?us-ascii?Q?mJZ0kcwpYdwDkzyfBDzOOJ+Em0+BXnEEpJHQ0gMRUjBwYSD6Bpvyh5wR7Ctj?=
 =?us-ascii?Q?RwX7L5ysS+JBTvKXbRpdF4r1M1ked54vfMCesCgLorkIVmoMzy/itROdPP8S?=
 =?us-ascii?Q?f6YEAvm1jDlCbcD9AbNN7rknVXwBsvEsRIlVyJwL7ccQtDkjCTgP3id63uEk?=
 =?us-ascii?Q?fSkHHqMRbIC6/9gOhDxxD66Hu55zVDOmiHCaLwWvpLFE6Slrl8BpTm5us4qs?=
 =?us-ascii?Q?Ko1lPn4vfrM/xIcEjKrVmhVIojk8aOR8tEiIqrHmKKSKaqwBm13Wp1C3ZkZg?=
 =?us-ascii?Q?pxFw/SUTi2+U4H01Su07z/N7IAadyBaEEGi2iFOxGdE82rUhgtSRlXKpwa7X?=
 =?us-ascii?Q?IRky8Vc6Vq6r3VthZefA+sQ6m/3zetDDBFlj5T1+q+gYoX5bC9K39/i2XO8f?=
 =?us-ascii?Q?qaJ3sV6iXIRzPN5Td4y1+nk5JXb9OXytxHobsSJT0nYVmwzuLIygmfsM8AGy?=
 =?us-ascii?Q?3s5+xWGpOC5hZnwhBBKDmbM6FnCvw+1cmnQWAxyzplG4HIZituJ472bnGps2?=
 =?us-ascii?Q?FFHsfBEGGhct1qKtDX70toFqr5nAyOLPuubE3KJ1F12TqoGaeok0nHvJyZlf?=
 =?us-ascii?Q?qmSYgNKuwNhgjGbjGrb6fNNrBkCwkdkaipfuWW+IS4mAFAEMBAUdWHsT/mB4?=
 =?us-ascii?Q?8uvf640B+O+WXdtT6OW8o0c0x4DqQ6sqUz91U+u8kuJo4MXGPBXBzaFf6EPD?=
 =?us-ascii?Q?kVzNeRC9a9Bn+sxXjt6KylHtFr6E2HVDbwe/pw1ovSXcdCJTkWAXGh4vSZ8L?=
 =?us-ascii?Q?oVMDKhFQ7Ny/HTTs/9TSzCU94snUWb8tLbG+6irlPQ3G+yLHtlOJz8fcbbjG?=
 =?us-ascii?Q?6jrROF6pQVM9BkgQQ790WHOPHmUdeSBugEaZIYB+apv2GlIsag4HOEUXSbr1?=
 =?us-ascii?Q?kHodcp0++wIHioC9yMiP4GBWioL8rK19rtoZ0bIHaktUrqAyPP316XZR2n0B?=
 =?us-ascii?Q?iS8TO5lXlYAjcuILviTv5L2DD/9bYTjN3FHRgrplFShr/VPHiy7twbTKqldR?=
 =?us-ascii?Q?LOGfP4D3KbojHcHx2sLYfLFJe/hBcryBTfTM/ClbI9w9PIBL9MaVwNsqgEMc?=
 =?us-ascii?Q?4591GmB1XOa413CJFed1aj4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b34ced-6d06-4ed3-f0bf-08dc42db1bea
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 21:26:41.4661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dD7DNn3sCXGw/94U677JFel5UbvBUTHmOrzl48r19oQYpRRTcSGaGLTCivEQ1BGYZIH5q4N7lr8gJSenCvsCNx5tJsbzhV73GSszJbG+3iOlgt4/D/jt5O6iurCOKWqW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8102

This commit enable the driver to inject EINJv2 type errors.
The component array values are parsed from user_input and expected
to contain hex values for component id and syndrom seperated by
space, and multiple components are separated by new line.

for example:
component_id1 component_syndrom1
component_id2 component_syndrom2
 :
component_id(n) component_syndrom(n)

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj.c | 89 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index ceac53aa0d3f..9e31bf707ced 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -80,6 +80,13 @@ enum {
 	SETWA_FLAGS_APICID = 1,
 	SETWA_FLAGS_MEM = 2,
 	SETWA_FLAGS_PCIE_SBDF = 4,
+	SETWA_FLAGS_EINJV2 = 8,
+};
+
+enum {
+	EINJV2_PROCESSOR_ERROR = 0x1,
+	EINJV2_MEMORY_ERROR = 0x2,
+	EINJV2_PCIE_ERROR = 0x4,
 };
 
 /*
@@ -104,6 +111,7 @@ static char vendor_dev[64];
 static struct debugfs_blob_wrapper einjv2_component_arr;
 static u64 component_count;
 static void *user_input;
+static int nr_components;
 
 /*
  * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
@@ -275,11 +283,20 @@ static void *einj_get_parameter_address(void)
 	}
 	if (pa_v5) {
 		struct set_error_type_with_address *v5param;
-
 		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
 		if (v5param) {
+			int offset, len;
+
 			acpi5 = 1;
 			check_vendor_extension(pa_v5, v5param);
+			if (error_type & ACPI65_EINJV2_SUPP) {
+				len = v5param->einjv2_struct.length;
+				offset = offsetof(struct einjv2_extension_struct, component_arr);
+				nr_components = (len-offset)/32;
+				acpi_os_unmap_iomem(v5param, sizeof(*v5param));
+				v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param) + (
+					(nr_components) * sizeof(struct syndrome_array)));
+			}
 			return v5param;
 		}
 	}
@@ -485,10 +502,47 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			v5param->flags = vendor_flags;
 		} else if (flags) {
 			v5param->flags = flags;
-			v5param->memory_address = param1;
-			v5param->memory_address_range = param2;
-			v5param->apicid = param3;
-			v5param->pcie_sbdf = param4;
+			if (flags & SETWA_FLAGS_MEM) {
+				v5param->memory_address = param1;
+				v5param->memory_address_range = param2;
+			}
+			if (flags & SETWA_FLAGS_EINJV2) {
+				if (component_count > nr_components)
+					return -EINVAL;
+
+				v5param->einjv2_struct.component_arr_count = component_count;
+				int count = 0, bytes_read, pos = 0;
+				unsigned int comp, synd;
+				struct syndrome_array *component_arr;
+
+				component_arr = v5param->einjv2_struct.component_arr;
+				while (sscanf(user_input+pos, "%x %x\n%n", &comp, &synd,
+							&bytes_read) == 2) {
+					count++;
+					pos += bytes_read;
+					if (count > component_count)
+						return -EINVAL;
+
+					switch (type) {
+					case EINJV2_PROCESSOR_ERROR:
+						component_arr[count-1].comp_id.acpi_id = comp;
+						component_arr[count-1].comp_synd.proc_synd = synd;
+						break;
+					case EINJV2_MEMORY_ERROR:
+						component_arr[count-1].comp_id.device_id = comp;
+						component_arr[count-1].comp_synd.mem_synd = synd;
+						break;
+					case EINJV2_PCIE_ERROR:
+						component_arr[count-1].comp_id.pcie_sbdf = comp;
+						component_arr[count-1].comp_synd.pcie_synd = synd;
+						break;
+					}
+				}
+
+			} else {
+				v5param->apicid = param3;
+				v5param->pcie_sbdf = param4;
+			}
 		} else {
 			switch (type) {
 			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
@@ -572,9 +626,19 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 
 	/* If user manually set "flags", make sure it is legal */
 	if (flags && (flags &
-		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
+		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF|SETWA_FLAGS_EINJV2)))
 		return -EINVAL;
 
+	/*check if type is a valid EINJv2 error type*/
+	if (flags & SETWA_FLAGS_EINJV2) {
+		u32 error_type;
+
+		rc = einj_get_available_error_type(&error_type, ACPI_EINJV2_GET_ERROR_TYPE);
+		if (rc)
+			return rc;
+		if (!(type & error_type))
+			return -EINVAL;
+	}
 	/*
 	 * We need extra sanity checks for memory errors.
 	 * Other types leap directly to injection.
@@ -694,7 +758,7 @@ static int error_type_get(void *data, u64 *val)
 static int error_type_set(void *data, u64 val)
 {
 	int rc;
-	u32 available_error_type = 0;
+	u32 available_error_type = 0, available_error_type_v2 = 0;
 	u32 tval, vendor;
 
 	/* Only low 32 bits for error type are valid */
@@ -716,7 +780,13 @@ static int error_type_set(void *data, u64 val)
 				ACPI_EINJ_GET_ERROR_TYPE);
 		if (rc)
 			return rc;
-		if (!(val & available_error_type))
+		if (available_error_type & ACPI65_EINJV2_SUPP) {
+			rc = einj_get_available_error_type(&available_error_type_v2,
+					ACPI_EINJV2_GET_ERROR_TYPE);
+			if (rc)
+				return rc;
+		}
+		if (!(val & (available_error_type | available_error_type_v2)))
 			return -EINVAL;
 	}
 	error_type = val;
@@ -886,7 +956,8 @@ static void __exit einj_exit(void)
 			sizeof(struct set_error_type_with_address) :
 			sizeof(struct einj_parameter);
 
-		acpi_os_unmap_iomem(einj_param, size);
+		acpi_os_unmap_iomem(einj_param,
+				size+((nr_components) * sizeof(struct syndrome_array)));
 		if (vendor_errors.size)
 			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
 	}
-- 
2.34.1


