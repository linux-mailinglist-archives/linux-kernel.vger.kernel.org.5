Return-Path: <linux-kernel+bounces-14716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7A282211B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B415E28441B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BE4156FC;
	Tue,  2 Jan 2024 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YySpnHzq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ehv0Jfss"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2D15AC0;
	Tue,  2 Jan 2024 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4029Sja5021127;
	Tue, 2 Jan 2024 18:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ClEq0m0woOSZzzvs1adKR2tfLqcjZ1dXfue3z4mT9rc=;
 b=YySpnHzqt5yLO3BA5+avG/5Pp8yTKSASuNuirNlYe/xYWZysIpkDDYsv4RZjJGUeD3qC
 RIjbiEDTBnrYkguZS81T1GW3hN5Q4njAcickrSiRvsmQT417xFa3UlbWnayhhqcNZ7HU
 FAVWbC8sf04SjMrUbisg1wx2oFzgsyOPotgLAfSm7psOqZXq8bY5cUeVua0kZgshXc6B
 oAcD2bZCfU+27QGS+1kl3h/9vRaW4+06JIxTNFKRBQ41ksIdta7QyNH29iwRqvEQ+JJ4
 piEFRtvJ9EbxSdNTf8syyry1n82ng3xJQ7KDi/M+0y+0rYPx9ekwq9yRD9+EOvRDy3P/ uA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaatu3jjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jan 2024 18:37:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 402I4WAO013637;
	Tue, 2 Jan 2024 18:37:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3va9ndvpyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jan 2024 18:37:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpiuozLIJJRHpXjxPf/vhua9nu5ZAmAgugznp6ykn95QVbtm1M6E62XNXqKEa6TMFGh8U4zpljdUiOecXS0iRqYOAxIg/Ya3jgpWBbWCmWH+1z6x/fTyknaxjOmxfl2Q55lu31kk/Rqw+r1SB49/+xpG5y0PKJkhg/8SzhSX1wEWJn66JrNNMHu5VDzOcovPIzpxk/Fmm1HCcfigY/pN76IBlIvwWiWgTX1JOLCBzxXK8sZyGYGHm6LS+n7Zisk2Ad+G1qOa2+sx8s/jbkBFq/nbC8ndXPH+2+FFIdd+Udry14Ra2HnjwFvLR+5Td+zi+JFeMuy3aYC0ME8kbAyKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClEq0m0woOSZzzvs1adKR2tfLqcjZ1dXfue3z4mT9rc=;
 b=GFmh9hazNvujAIDM6CYWSS52p/pEpaFTcMIxkEWBPGkJfVTB8CWQqkLwFkn7ryQhRoZvt3lR0Jty25QzowMWijjyJqTHYErN51rONMkC9bXa+ivpCBGqQpcjgjDvPmLnQ5cRRq0in9Kfgs488/iMbIPUTdjDnCG8OOJ/5o0jFMjziwz711qpmjBmNRDUVVqrHIXPFijYWDX6wRB6Gv8ubRgcXyduJG0Sg+Gu7/YRSGaMnSOFwszVumR2IcIjZjgNePrbgA+WboJKVXUtHK6M7sml8Oc1NVpwQgOqjHw7AZBVKuaTg+YiMXYEpm4l2d+rkJiE5qfeMzAhdMUKH+L3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClEq0m0woOSZzzvs1adKR2tfLqcjZ1dXfue3z4mT9rc=;
 b=Ehv0Jfssx7kf4KAAjPAZbP0ouzIy0Nh2hlPHD03WnP06NWwgZwv7H7G32xCbgJydX4U4uQEL8Y/S3uHbeDKLEYGJRAq/r/uYnMu+Hli09emLzXAA7Sp2EDQJNSdvvsSCvzdW0iCECosoMuqpY2WHwIoXoOVk4I6YcffVWqZN+C0=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BN0PR10MB5336.namprd10.prod.outlook.com (2603:10b6:408:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Tue, 2 Jan
 2024 18:37:43 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7159.013; Tue, 2 Jan 2024
 18:37:43 +0000
Message-ID: <e7e1bda7-3067-4e27-8db4-8406c4e088a0@oracle.com>
Date: Wed, 3 Jan 2024 00:07:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] VMCI: Silence memcpy() run-time false positive
 warning
Content-Language: en-US
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-hardening@vger.kernel.org, keescook@chromium.org,
        gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: vegard.nossum@oracle.com, darren.kenny@oracle.com,
        syzkaller <syzkaller@googlegroups.com>
References: <20240101130828.3666251-1-harshit.m.mogalapalli@oracle.com>
 <cc8d5ac1-99b6-480d-86ca-f76ed9c324c3@embeddedor.com>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <cc8d5ac1-99b6-480d-86ca-f76ed9c324c3@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::27) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BN0PR10MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c152877-e0ec-4bd1-b51c-08dc0bc1e7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Q0ie/XztmbrafHnhtT9KbczQEzzwR0qrRb2BPkzDiBQtoZ56c6EySAPPOvrxRMCKjOmNSBiK3bgpP5cGzjAKWGzN5AHXaTaapLq3SQcfyvOZMU3+P6CstyN7oLF93A7M8rL+Z833IItdXBW/m9/NtkhUS3scD59vlDHJSOoklw7y3aMi0KFQR+fz6ITC42Br0RoJXAv3q2+CgTGDAemTsAKl71ChWKAjw90cdqLD0Z/nlKnoludQ7yQwPTgNpMA+9360y1c88z6Ulg7xpQ8RBCb9W4Q9du9e7neC/Hywpg0fe4wGr5/nQ7BNMUlu+foc/O0kdeqNmaK8BuOlS64d2Co3Vg7EA3Ybzff26bv7DTifouO5XHl66t7rRroEPHacBqymVJbinMwHTmvmp/p2EpcthoamAwrikxF7onLmeBXsJswmCu73Ae+wFsre/B19ww9Sy+hvXErzxwuz8nASkqiwiS+YYQ7aJ2uP792mRSLUokg5kJU651XmLSTOodasM8Np8Dp48jeC+2TjMt6HdZj2Nf2dn/qfCHj11WqsCeyqYqSsaiNEVWfRRvU9+H1KrqxtClCaLZbQfUlt4EgIm/8hHV1FO5sI/VtkfOKSM0IIjQW/AyXK4v27xuITNs4QX9QgW/HgP5Ceagqt08n1OVZrWRF1lFfa7dnph6ubdm8Eb3BEeqz8QQpqxhEI38kkI7HWvQ7LvZ21kl1DImie2A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230173577357003)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(66556008)(83380400001)(2906002)(2616005)(26005)(38100700002)(41300700001)(316002)(8936002)(8676002)(110136005)(4326008)(7416002)(6666004)(5660300002)(478600001)(66476007)(6506007)(53546011)(66946007)(6486002)(6512007)(86362001)(31696002)(36756003)(31686004)(921011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WHNNREo3MUhmNUk0OVdOaEZFQVJqcHdIZTgzekU1QjllazBCbFJUMmtsRFkv?=
 =?utf-8?B?cnBCTTBkUVdJZjJDTUlaUXZ1dE1ZMUgxS0I2WlZCN0ozZGttUnpjclU4ODNB?=
 =?utf-8?B?SURPRDh5Q3JScXVNeVpoQWszR0cyWndEWlUvRHJTVHRYeE93VGM2K1d3Q2xT?=
 =?utf-8?B?NFRFb0FuZGpLVEFWYVR3QmF1NHplNnZSOG1QcnV5TS85THZLSUJ1ZnBzdERu?=
 =?utf-8?B?emtmc2ZZVjRRMkFiNG9ZODdkT1FWM2k5K283dnoyeXd4SVc0Y3Myb0l3Q1l3?=
 =?utf-8?B?MndyY0xuVXVTVkZ6cUhIQzl5Q0laaG02ZTZmTzVSTFBFcTkzNXh6Q3V3eGtl?=
 =?utf-8?B?Wk5MTU9aME9SRU4zejJsb1F1ZGMzUm0vWHFYWnNLV2lQUmxpOXNjcGZTek8v?=
 =?utf-8?B?Vy9qWk5FaWZubHRsUWtRTDVVWFN1aUw1U3o1d0tVK3pVTXV5ZkQ2L1Q0Ymgy?=
 =?utf-8?B?a3pZTE1QajBJaEh4NnhTRHphemx2U1lNZW0vYm1kcnpsVWlHQ1RSU2ZIbk1Q?=
 =?utf-8?B?S1R1ZVBnd01wWVFqNXlCMEI3eEpzaVJhVWZOSEppT1RIZWNiY1hUQzFlendV?=
 =?utf-8?B?WTJ3eStMRmdhYmtYbER2QWs1eHg4aGFpYzN4MFlPSDQ4djJ3SFdnRzUwYmxV?=
 =?utf-8?B?SFVWelB2L3h2Y3V5cmVzOVUrYUx1STBXYTd5K0JjMVhwdWFmVXpTemZRVWZR?=
 =?utf-8?B?Z1A0WmJvKzJRcTMxZ3FyVFM0NmJTdldIdXFsNS9aZ2kyQmlZMkI4ZWsxLzR5?=
 =?utf-8?B?clFkcVczcHdFNHh2NGx3WUxEeU40S1h6Mkl2Vy9Bc3JiSXQwNTNRNm5WMHNM?=
 =?utf-8?B?YklQWkNqWElmMExscW9GVjAyMVdvM05NbTFkcitRTnNNNVVuOWUwY2VDTUlO?=
 =?utf-8?B?Ri9udUpqWUhIbTFXTDBHcnRjNG1tSTR4SG82cFdPMU5FL1U1VUhvWk1TR2Vt?=
 =?utf-8?B?MitiQUhWZ09pQ3lDeEp1bFhjRFRKN3phRzFldzJmUjY4ZCtxNjU1OGdrK0FZ?=
 =?utf-8?B?LzJtdFltZVpHYWkxcUF4SkFIdjNZS0pxQUl0MXNKaUUrWUdnTHc1YVZXUFMy?=
 =?utf-8?B?VWVuMmV4c241OXFQdW5MMUxCdkVQd2N4UWVEZ0FzVGw1RmFYZ3AzZGlheEh1?=
 =?utf-8?B?Q1ZYVkliR2JncG4wV1ZBREpaL3NmV1VoVkVUR1F6U2NjTU5HdldVVnRLU2lO?=
 =?utf-8?B?SWxubEllOVhrM3pCTVgvRFRYcjZvaVhkYUdSbHNtMVZBWEkrMi9HWWMxTVRZ?=
 =?utf-8?B?NXBkRjRvaVVkUWVNeVNiS3FkeUdNdTl5VGlVN3VkY3F0dDFmSkY3cXJiNXUy?=
 =?utf-8?B?ZjJFQWpMdzFheVV1cFdZTHdZYm1QZEV4RWFoQndvQk94eXR2eSs5bEFzSkl3?=
 =?utf-8?B?T3QzMEF5cUo2MmNlMnk1RGFScFlITXk0RFpYUnF2U3YwV1kvSTlWbVZZbFVW?=
 =?utf-8?B?T295T2sxRjZQZ2xJVnk2ZExEckVTbytsUTIwK1ovanlKb2Q4QXpWT25vQnlP?=
 =?utf-8?B?Q2JweDIzMFdtcEo0U2RCbFNGd2tKVTlDNEpzVEFLR29QS0JvMzFjdGI5TE4y?=
 =?utf-8?B?VkJuYURSKzZOSklUN0UreHVqZW1yVktud2hReXVJZEg4T2VXV1NHc1FwV2Y3?=
 =?utf-8?B?SWxjT0Z0cVhlUThBdElXYmdvbnlzcWJ2SzEzTXdlYnVjWGlzZUx6Q0dvRDdt?=
 =?utf-8?B?WHo0WFdHRmNuWkp2RzczaEhrNEFEZ3A4c0U4ZnlmeFZOT3QvTGJVaExZc040?=
 =?utf-8?B?QXBIWlVXeE9maVJoTEYraW1vaFZmUW1xWUV5T3JoNmZuajl4TENCTXZIYk5J?=
 =?utf-8?B?UVMzeTdwYmR2bVZVVUhMVGkrVENZNVlNc2h5aHBCUkNGcUE0c05BUHdiWHBN?=
 =?utf-8?B?WEZiVDBhb1NNMkJrMnJNanVSbkRZcU1iQ3NsaUNJS1VURjlEb1FRb1hodzVB?=
 =?utf-8?B?UFJrT0h6K1ZoN3VBSzJEN2d3WTdLd25zTmxhWklJSldzVHFLNkdXQXF5M2Zz?=
 =?utf-8?B?cnAwZC9yM3JWMEJIMDFkMUlFaGNEaUVMc3c4ZW9sbVVMV2tqVHM3QmZCNTJl?=
 =?utf-8?B?UmN5dnA0NGUxenpxYjIvMGhQU2Jhc3BiK2x1OGFLR0llSG4reTE2TjhiZWlI?=
 =?utf-8?B?U3FqRStuVFVraVJFdW45UC9ueFBwR1F5aFcyN3RGazVhUHdEbnJ5R1dmWXdm?=
 =?utf-8?Q?6K8R5Rt1owH8iOQUsBW5AOc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fApFKJBLnx0u+xGYkkxA8r2a24j1h21mMuFpfmNLTBlGRDiTAQF5onh5Are1ssFbXYhg40ba0OhBoA/72tbSLVSC/TJdzP55OqTihsjuqwEsAjqhM2/7jNXG/MkhRJ/oXBYTN2A3rAzpmyEzq1IwbsPuMSRJYtRs0jU8Vz8hvxyRyuc4xixgm2dTP+7zc+bLLP5IwpY9IEFdT42dvR2D4ktsndk5wSiSHnqLbIrBD3lTXRuF9cO+Dlb2eaVjnXctTOIaKwa+UxMLi0PzgEYafWfEpEMuxu1x5joXBMfEudP8ri9HOT1FJMNDDwNRd8K0XBXU+dN1t3FcKPOfon5FS1arnH+yYbqaA8SeUZ0uPBIiRqt1rqaCaOej6M7TjM+nEt+4352Q/JTGMc1BtcuO77I9yuzkrfE0nbMNvv7Y5f8u0owQvjmOWwX8hA/Kv7d5qqtxr0wmHmVgwuA5zcoP+0dC+gb9BLUgMYdSPuQwrSmtp09h9OAlSpE1Ya1dHHy42B+JiAAjWmK9Kgf++Gx99xPNg3YKuSmUm7B1tpP3ikM2+e4m6VJ7ndpK5uysRzxtHTvJ9S3LnDaTofMreya92WeesQ2fag/l0K62P+0w6dY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c152877-e0ec-4bd1-b51c-08dc0bc1e7ef
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 18:37:42.9238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUtBrujz/C8qEEQF6/G1TIDj9pkU8IgIM+9C0Lm0X7qy6iYqfgx8fwurpUJpUWz9j3iCnlDETCUA5FlipXFkViL2uI81hZ/UQvR2w1LyDzi0Lzb39uO3qomvZ6JyBR0s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_06,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020139
X-Proofpoint-GUID: vuuyfzUV4DGlwJNRBi7AVO7l46pwKFGq
X-Proofpoint-ORIG-GUID: vuuyfzUV4DGlwJNRBi7AVO7l46pwKFGq

Hi Gustavo,

On 01/01/24 11:13 pm, Gustavo A. R. Silva wrote:
> 
> 
> On 1/1/24 07:08, Harshit Mogalapalli wrote:
>> Syzkaller hit 'WARNING in dg_dispatch_as_host' bug.
>>
>> memcpy: detected field-spanning write (size 56) of single field 
>> "&dg_info->msg"
>> at drivers/misc/vmw_vmci/vmci_datagram.c:237 (size 24)
> 
> This is not a 'false postive warning.' This is a legitimately warning
> coming from the fortified memcpy().
> 
> Under FORTIFY_SOURCE we should not copy data across multiple members
> in a structure. For that we alternatives like struct_group(), or as
> in this case, splitting memcpy(), or as I suggest below, a mix of
> direct assignment and memcpy().
> 

Thanks for sharing this.
> 
>>
>> struct vmci_datagram *dg)
>>           if (dst_entry->run_delayed ||
>>               dg->src.context == VMCI_HOST_CONTEXT_ID) {
>>               struct delayed_datagram_info *dg_info;
>> +            size_t payload_size = dg_size - VMCI_DG_HEADERSIZE;
> 
> This seems to be the same as `dg->payload_size`, so I don't think a new
> variable is necessary.
> 

Oh right, this is unnecessary. I will remove it.

>>               if (atomic_add_return(1, &delayed_dg_host_queue_size)
>>                   == VMCI_MAX_DELAYED_DG_HOST_QUEUE_SIZE) {
>> @@ -234,7 +235,8 @@ static int dg_dispatch_as_host(u32 context_id, 
>> struct vmci_datagram *dg)
>>               dg_info->in_dg_host_queue = true;
>>               dg_info->entry = dst_entry;
>> -            memcpy(&dg_info->msg, dg, dg_size);
>> +            memcpy(&dg_info->msg, dg, VMCI_DG_HEADERSIZE);
>> +            memcpy(&dg_info->msg_payload, dg + 1, payload_size);
> 
> I think a direct assignment and a call to memcpy() is better in this case,
> something like this:
> 
> dg_info->msg = *dg;
> memcpy(&dg_info->msg_payload, dg + 1, dg->payload_size);
> 
> However, that `dg + 1` thing is making my eyes twitch. Where exactly are we
> making sure that `dg` actually points to an area in memory bigger than
> `sizeof(*dg)`?...
>

Going up on the call tree:

-> vmci_transport_dgram_enqueue()
--> vmci_datagram_send()
---> vmci_datagram_dispatch()
----> dg_dispatch_as_host()

1694 static int vmci_transport_dgram_enqueue(
1695         struct vsock_sock *vsk,
1696         struct sockaddr_vm *remote_addr,
1697         struct msghdr *msg,
1698         size_t len)
1699 {
1700         int err;
1701         struct vmci_datagram *dg;
1702
1703         if (len > VMCI_MAX_DG_PAYLOAD_SIZE)
1704                 return -EMSGSIZE;
1705
1706         if (!vmci_transport_allow_dgram(vsk, remote_addr->svm_cid))
1707                 return -EPERM;
1708
1709         /* Allocate a buffer for the user's message and our packet 
header. */
1710         dg = kmalloc(len + sizeof(*dg), GFP_KERNEL);
1711         if (!dg)
1712                 return -ENOMEM;

^^^ dg = kmalloc(len + sizeof(*dg), GFP_KERNEL);
I think from this we can say allocated memory for dg is bigger than 
sizeof(*dg).


> Also, we could also use struct_size() during allocation, some lines above:
> 
> -                       dg_info = kmalloc(sizeof(*dg_info) +
> -                                   (size_t) dg->payload_size, GFP_ATOMIC);
> +                       dg_info = kmalloc(struct_size(dg_info, 
> msg_payload, dg->payload_size),
> +                                         GFP_ATOMIC);
> 
Thanks again for the suggestion.

I still couldn't figure out the performance comparison before and after 
patch. Once I have some reasoning, I will include the above changes and 
send a V2.

Thanks,
Harshit
> -- 
> Gustavo
> 
>>               INIT_WORK(&dg_info->work, dg_delayed_dispatch);
>>               schedule_work(&dg_info->work);


