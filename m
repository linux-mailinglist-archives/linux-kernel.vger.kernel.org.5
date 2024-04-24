Return-Path: <linux-kernel+bounces-156999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE418B0B68
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39CA1C22290
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A5915D5A1;
	Wed, 24 Apr 2024 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WX80LI8y"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965F15B0EE;
	Wed, 24 Apr 2024 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966262; cv=fail; b=CxL7FL05L1ucrd5PKXNFb/GsLx/cuyzctC80Lm4Gt+Lf6iMnWppvgnr6oS9FCS0kH3Xq9/DYaF7ah+t5lwiXYo+1Ix7E7ekA+D7IBHal0/pvCSJ+MlOrsdgUVF5YrMB0jHtwpYrVAkJxdt/6I4utMul27bbj17u9fhD1wqoNAhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966262; c=relaxed/simple;
	bh=UPROZ2sYSj7vnmqtKgH66vsjHfvv4zCd5uF8g9HvypE=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LtyEkFNOmjKbiiE4U77o4PIJQXhOXJFbpGS26LAWXhVWFUOQNQKpAcrq3FMlEFiKcoZTq6Qiqx4V//CGtdieWFUbTv2RUmShPmtQR+GWv1rJMY70Ijp4iZuD+fVs0pUo04RngxqOTS4LN4Aby9N32EAxCg8slTz8HVpVkDAQ7T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WX80LI8y; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrwiB5SO0h9061l2W9lg8fGJaeUUciz96Sr5AtLcgNw+Z5C9sm+xi6qpiEHbhMVwVKnH1IaXemEfnJWT4I2GFxhYXySpD5cpOvaeIpakGLfrhYxhxCN7Bvjv+c85CYN5kOoS8FoAQtwxuBz6ipDaDk3/UhHAnWOHgWNG7MIpR2mQYLBBi+Ym/6fnnMG69PgwO+7fXk/+5mmGaleoQ10QRDtSM2RQ0Rh5T8advDkymPKWEjzj2yJA7A36Cl8+PdH6F8sc9v5qSWomhvOFB5U3EGbZT8ovOwF65Bq4WcLRxzuOp9asp7FwN4fqvAyUxOyiKCObT9BGSMwjdFXXCLjQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NP87iFbQ6LaCu//eTtWey1zyGdiKcIW4fCAZdNU/u4g=;
 b=YfqBb7PH2IzakjJvs40KGszuq24bZjVppbRtx5xWUqVt7DItYJkzDdV6fzcoMm64+D3nzlVVEXv2/RE5cVpnB39tyAs0IDOK1HTmiS2nVT2FRBOGEhg/GLlcNHQVPQ9db2vf6RACHyUyiDj0wAr/wXh2GKelxqjO2ndPrDrd4Jwylq/u3R4tGi+Z6YbAQGJD1vz7xp7YzGNDSQJ24lrXN/2vifowd0fplbVQLYrZzLqX3lreGaBFbO1sd7xOB4DdXRLkqKSI6C9NVTs7fTeby+fAxe7W6CRQpGR+3UwsHHi69iaaHX9bHZGW4BoJTWWt7C9g8AU6iwCLTTo3+1pEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP87iFbQ6LaCu//eTtWey1zyGdiKcIW4fCAZdNU/u4g=;
 b=WX80LI8ypoaGBGrzr+Hh6a8kswHVhgnRHlOO4v6NSvIXumt8pQ6Dib8VSA4kZbsz1DbZs6MiGKV1Ffp8flFrk0ql05svrsZfkiTe72fiDXslQMTeXxRLNj/FEkbzKAIo3/Xpxwjw2z3rEu3DoVESVqPpXLRdeH0NnL8cclKXNWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 13:44:19 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 13:44:19 +0000
Message-ID: <e9bb8474-ae18-4e1e-9bba-0ae5c04624cd@amd.com>
Date: Wed, 24 Apr 2024 09:44:18 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 05/16] x86/mce/amd: Clean up SMCA configuration
To: Borislav Petkov <bp@alien8.de>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-6-yazen.ghannam@amd.com>
 <20240423190641.GDZigGwXXEPeDnfOsr@fat_crate.local>
 <eb9c5d9b-07d2-4b56-98dd-c2616ef73a0a@amd.com>
 <20240424022822.GAZihuRjwlK6kOF0ya@fat_crate.local>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240424022822.GAZihuRjwlK6kOF0ya@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:408:e1::31) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d7a2aa-2d24-4dcb-abcc-08dc6464a40e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0pCZWRPZllIVm1aT3lxdThvVkI2QzFSUGNOTG5kWmsrSEM1WUtSajRhMlor?=
 =?utf-8?B?VUNCd1dpSWF3dFozbHpwYTRMWTlGcHQ3VWFwR2t1UG5mZXJQdDVmUjZsMUN2?=
 =?utf-8?B?Y0VEUlAzU0l2ZmpCR2VRMjEvZUpzdWh6YTFkd1E2QmN1ZDg3Nm5iQWkycEdX?=
 =?utf-8?B?V3NMMHEzK2Ywa0syM0ZGblJJbEpPTWxhemhQdUNvZllHT2k5SlgrK1M4TWhY?=
 =?utf-8?B?cXVQSTExemdkMzFEeUFnYmM4OWhBRnZkMlRuRm9zUXJZa0VpQmkrSExwMUxq?=
 =?utf-8?B?bjZUWUZNcm9yMWpNQ2VnZG1iU1RBS0tWRlNNSURHd1lpN2o2R0Y5NHJIZ005?=
 =?utf-8?B?WnFnZjZxeUpCUG5wajBVSTdUekNTT0JCUi8xYWZWYmFKZWoyVms3WGZCTVlq?=
 =?utf-8?B?MFhqbG9tTXlhMVozeFdHWFBydU1PeGYwUzFsUDZ0MEFEekVycEI2UEYydDRp?=
 =?utf-8?B?RlgwZjFBQ3RKOGVGSFVzZmFxRm92eVFoa0hJcnQ0WFRLRDVjL3NyMzQ4dTNo?=
 =?utf-8?B?UlhVL3JzM0x5ME1wY1FDWUloSHRaQ2dTS3l1elhnaE04TjR5RlgvajZNNDlW?=
 =?utf-8?B?VjZoMjNXTlJKY3N5dWp1UzkvWTBSdUpubk52ZFhqUjh5ckpTbkI2TGhmMFVU?=
 =?utf-8?B?aUIrTWdFZVEyRFlUaDkrOWdsRUN5ZnZNT3Jha1VzZGdoNCt1NzdYaExVZUgy?=
 =?utf-8?B?cVFSSzQ5N2IvVGhQSnF5YkNQQXJVMjNJeWNHTVZ5RkI2NWx0a2QwZkZ0SG0r?=
 =?utf-8?B?RlpzQTFiM0ppUk02K3BOK1ZSQ2cxT2tzQUNOWUovTDY1L2tqNkxaeDZUTnVv?=
 =?utf-8?B?MktVRXp2bi9zUHFraDV2bGZ3b2FIajFhaERSSG52d2U5ZklRV2Vqc3FuZWNq?=
 =?utf-8?B?d2JkMXVsYW15eVkyTmJoUU9DQXNWZWNKRUNJbHhxSHBUN1BzcjQ4Z2dJRGs5?=
 =?utf-8?B?K1FXcXg5R0h1NTZsQWgzOTZtUE9vV2hjaUZ3TnJ3LzEwK2FnWmhPNUVWakg1?=
 =?utf-8?B?V05JSlNjUzV2Q2Y4dXpZbk4vbFBHSFJYY3VEUHBOWGNiWjhQVy91dUlDNnNZ?=
 =?utf-8?B?QnF6dXhUSkxrSUVCMmkyNzhMekdZekVWTUtMK1lTeFBtOUlQZU84SnlDZHBM?=
 =?utf-8?B?eGN6TWVFWk82S2NFUVRKUi9Qeko2SjJMY1ZNWS9oVEgvcW9JT3lSNlppenh5?=
 =?utf-8?B?RnJCalFKZFhOeE5FN3FZb1YzRW5oZ0pmMU1GNkRvWUsrMnF3TG05R0FkQ3Jl?=
 =?utf-8?B?cU5EeURULzBGM25oUzhTTFhqbmRYSlpzdWxnR0dEditreWxUWFd1bjVYME5S?=
 =?utf-8?B?bXlCT0VKRW12bVdZRmVhMFV2SEp4TXppQlRwQkdNL2Fmb0dUeE8zcGtwR2h3?=
 =?utf-8?B?bjFzOXRSN0VraUFjYStZQWRYSTB2eFNoOXRLa1hsYjFUVDB0dHpoTXZ4VWh1?=
 =?utf-8?B?a0c4eXBFYlA1aVBVQzhKZmRBUTVsczFlVzVYVWsxVGcyaXlXRVZYd002RTho?=
 =?utf-8?B?RXkvQTMwa045SnVwc0RzdlpPQXlCWVllL0dhcUl6bEhYa05YZ2VkclpXc25q?=
 =?utf-8?B?dDhvbmd6bzIvU1lFcmI0K3RRL0hmeFRVbTgxRHdzd1VGUkZhUjlzTWVwMDgx?=
 =?utf-8?B?dWVpaE8ybGg3TFB5eGZqd0MzaG45eXNNcXZhRDZ2dEttZlcrWTdDd2JVdUR5?=
 =?utf-8?B?b2lYRUNuN0xlSzR4cHhEcVR0UVlGcmZhazlBZEdub05BblJ3TVkxcTJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU5BZG9KN2xDalFDVkFHR21ranF2R3VoUlR3bXNRTDFzQVh4Y0VTaUJOajZs?=
 =?utf-8?B?Mld6TEpCSnpRWUl0RERyeUVucTlyZmF1OVE3TnE0ZDVzdWRnNnU4akxKUWdk?=
 =?utf-8?B?QnE2UXF6STNLQ1ZCRXpxZTdOdzRtRlV4dTBKaGtRenpDOHdYYVRHZ294QTBN?=
 =?utf-8?B?Y3BTeGJHRGxGdkdMeGtGQ3FpMTA1cmtBQkl2Y0owQmNabHV3WGRDUzZUUDZv?=
 =?utf-8?B?WllWTk5JQkw1cWdoS1BPdUhRNVFyODJFZ0dERVhVLzlxMjVpaGl0YVhobk9o?=
 =?utf-8?B?aWhMSldUYWJDODd1WklDMy9rRFlCSnhKL1p6QWFqa0hrbUIrR1RpcnVSb21Z?=
 =?utf-8?B?anNpbnpxQ29ncDlNNE1LbXduQ1ljeU0yMWE0QksyY0xhcG9vOUI2VTlHSVZr?=
 =?utf-8?B?d3RkV2VUSnJSMHVQWC9ZZ2pBY1dGTWIzRXV2aTJwMkVXMEZod1VYZzBnMmpw?=
 =?utf-8?B?RlorcGhCTFI2M3ZGRDFmbW5YYTZYRHhlNHB4OHhlOGV1a3V3NDFFRW5TWjlD?=
 =?utf-8?B?VjU0djlHdXVCUjRqOGpSZncyVTdCajZFU1E0eDFGZG1NbXM5aVJPcTRLRlpo?=
 =?utf-8?B?YzVWdU0xQ2QvWHQwK0s5dlJwb0V1SUkwQ0xmaHFLSTFzYlZYanBDN1BXVVgv?=
 =?utf-8?B?OE9uUEhkcnRWR3FNL3AxaXlNblBlRW9UcFRwQUgxYytMdVA2cEd4NHFYREhY?=
 =?utf-8?B?enQyV0trRFUzQnRxa2FSckl3c3F5UFBFejFtS1IvaWphTmd3K1dSZkw1NlNB?=
 =?utf-8?B?ckJGRHFOVm1IeTVEaFcvdWU1T1Zza3lrUmp3VitVQkw4Z0kxK3lsRmZzWFEv?=
 =?utf-8?B?aC9DNHVONG56ZDhqQS8yUEM2L0JxZUNFQ1ZKL1pBdlpHL2ZXVWNNK01mdm9X?=
 =?utf-8?B?NVhkdHp3aS9sZTltclBjd2s5b0ZNeUVhYldNdURweUx3QjhKdHBOMWtaa0NL?=
 =?utf-8?B?ZVM2NWtlTjJwdnFZY2pJWGQwQndiejUyUFdRNEdRekI5bTlBSzBoSy83dEFT?=
 =?utf-8?B?Rkd3ZG1BT3ZnOUpoQ0wwNlFuYWl3blhCTjFST2pHL0ZNVzFyNmluNHhTd3ZH?=
 =?utf-8?B?b3l0c2pNNHVMY3U5RG9mUVAvSmZaRXQ1TmxSblV4ajRmczNUK2c0VTY1Wm5I?=
 =?utf-8?B?bkJSNURFK1VobUJoVEsvOXZSQ1JRTzdaMnBaTEZ2cU9mN3Vqak40UVlqUlBJ?=
 =?utf-8?B?NG5ONzRYazQxOFlmSW16ZTdoSzd3OEZEbGwyUXBLdzk2cXFISktjUHRXV1RJ?=
 =?utf-8?B?Mm5nWWdZbUZtNlljZEJLNFY0Yk9Ydk5XNlRRRzNoSlFtU2duOThuYm9EVEJl?=
 =?utf-8?B?eExxSHhsZmdVclJhdnZlVlZYTmxrVXhZdXdQcVR4WFpEenQ1enBZWEx5OXdC?=
 =?utf-8?B?N05rbGRydWhOOURUM3FNNFMzbHNrdzl0cTFCSDFoc1FuZDg5bFNsK2RvOEJh?=
 =?utf-8?B?RDRVTXF5aGtneXFxMGdFZXM4bFBjSUZHZDZhNThHLzZ0c1ZCcWppSEtaRXho?=
 =?utf-8?B?dnRHMHhyQXZWZ1J3SmN0eUlmLzZqWCtVUDBBdmJYRW5TVDFaTmtPaU5FWnhi?=
 =?utf-8?B?dWhXU0pjYWpRM0pqUU11TVhvdXJqNzNReDA2blRoOThkN0pFVytFQWcrTndZ?=
 =?utf-8?B?K3pWdThaeHQ4dE1pc1hlU0hUc3NCblpnQkZRNjBVcTdrczFoWmtpc2NtWjVr?=
 =?utf-8?B?MHlxcE5DUm9kNXVoNW80bi9XMk5YUDNVVXNnTUp0Tm52MU14Zkp4SVZHSXBv?=
 =?utf-8?B?eVMzZzhhYUhVS3NabHh0dXhrQmo0Z2U0SlRFNHJNZTdscFUwOWJ5OUFaZkwr?=
 =?utf-8?B?V24xSUJ1ME1ybDdQbStMR0w2WjZiWWU4NktzcGRSejJDL2t6S1FoYjYvUE5j?=
 =?utf-8?B?VXlub3pBNXVKa2FQUUYrL1NuRW1ndXJCbGlHQnNMQWJRc0NhVjFYT3NCTlgz?=
 =?utf-8?B?UC9RZFdJbTdjcTJISDNXQkgwb2REM1hZaTM1cTJPNTRDNElCdG5yR1ZTanpo?=
 =?utf-8?B?ZlNFeXBkN0RFNEdSSVFoS1JPN0pzTUh2SDRRQ1NUdlJ0NmcwNTZlRXg3cTND?=
 =?utf-8?B?YkpGaHpFV1V4TDZpUEFwSk4vaHVPam5CMmFxUks4L0VBRWZybWxFQ3l5M1E0?=
 =?utf-8?Q?T9mmT2lDXff5gj+cOoU5WZtKY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d7a2aa-2d24-4dcb-abcc-08dc6464a40e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 13:44:19.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGNb0v3E8BP++O75u+ZE9tGWqa18N9ZpOWMX9l/Ge85LoLlBhc1XQ2HaQHs2GCq7qcaxtegsXO422yKF72d8Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167

On 4/23/2024 10:29 PM, Borislav Petkov wrote:
> On Tue, Apr 23, 2024 at 03:32:00PM -0400, Yazen Ghannam wrote:
>> This is not the same.
>>
>> "CFG_DFR_INT_TYPE" is a register field.
>>
>> "INTR_TYPE_APIC" is a value. And this same value can be used in other register
>> fields.
> 
> I don't care - this was just an example of how it should look like. Like
> the rest of the code around the kernel and not like an obfuscated
> C contest mess.
> 
>> I think it's fair to just use logical AND for single bit checks instead of the
>> FIELD_GET() macro.
>>
>> But the FIELD_PREP() macro does help for setting bitfields. I think it's
>> clearer than manually doing the proper shifts and masks.
> 
> To you maybe.
> 
> Pls stick to how common code does masks generation and manipulation so
> that this remains readable. This FIELD* crap is not helping.
> 

Okay, will do. I'll drop all the bitfield stuff from the entire set.

>> Okay. I was thinking to keep the names shorter since they are only used in
>> this file. But I'll change them.
> 
> If you want to keep them shorter, then think of an overall shorter
> scheme of how the register *and* the fields which belong to it, should
> be named. But there's a point in having the same prefix for register and
> bits which belong to it.
>

Okay, understood.

Thanks,
Yazen

