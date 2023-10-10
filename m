Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD39B7C41DE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjJJUqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbjJJUqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:46:50 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A26C9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZjM0BZ2B+imF+e7nVEUOXcqsRR5lRsjAFwx3fauKZey/NpnDz5H87hsgfPwWA/ybR4iiU7eLQ/o1ar+hz+6vwsRWry7BZlekaPZ4MrQ9jW752vDcT2fQ3Ti6g1DAZR7bT4NzpcN7zwFax5+nOVy3+qex0f1rdXJMhsmEIk7vywTIhpxdqb9Rzp3PQqBkrDItm+CyA7nwqtF+FXU5z++zrxu/0EoK6pYmbmVVuD2EIhuHyyw63WOqaByFmyPoQxfHFrlifm1STA9vrLooX+RZf0+Vzla6kf3FQH+XY2dNK4po3/k6m4yde5GocxwG9Q3qtMdcjEWWUd/nngyEYudBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3XNimrErvGvBHwyY3Y7iDG/Psvt1jzSrqB3L53WH/I=;
 b=TXkofeRUCtFAGho2MViM3OzcaOxHcV+2gsVsehEBJH1AgyUD2frHgl4y15vxn0aaiWrQ3VDSBupszBVRkKXJmux2lNps8q3DtRR5Geu07ACC1nxLgf3D5zDT2ojB2A2tuLoW1/KdB8gXSlv7BVBUm27jok/yQT+OfOO5C9shVqPJ+731CRPrUnO2itJ33Wh+OyY7vCzbpcHbMhbgZCrmaPSMqayYxYszPIQA1GpvKL1n0lKiYbomJyBHTEgMXn2RUlqLbMfFrLfiQoufMbGgKrupnFhBBXqpSO0afPjWjMFqjiQckgavnGVJ8UABBlb9wMW1iaskIuuDDuVL9rX+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3XNimrErvGvBHwyY3Y7iDG/Psvt1jzSrqB3L53WH/I=;
 b=n4A6pbG3o5F8EIfFTxZPOQYEIfda60PclYaZbaS7+HL8CJansX2ckISG5yHci6Ru77+EJLtwGxCuCOyeXo/HOpM13D3gzuYm0BHTgI9LafBLo1Y3B/ZBj4zIYJaxDT3CXEksxH7ecnwMphSZrzcU8dneyYUjtTAAUI7MXZp+w0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 20:46:39 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::a13:336d:96a5:b7bf]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::a13:336d:96a5:b7bf%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 20:46:39 +0000
Message-ID: <34c937ad-f8d8-4f03-9f0d-bf46398b31df@amd.com>
Date:   Tue, 10 Oct 2023 15:46:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] x86/sev: Generalize sev_setup_arch()
Content-Language: en-US
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>
References: <20231010145220.3960055-1-alexander.shishkin@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 xsFNBFaNZYkBEADxg5OW/ajpUG7zgnUQPsMqWPjeAxtu4YH3lCUjWWcbUgc2qDGAijsLTFv1
 kEbaJdblwYs28z3chM7QkfCGMSM29JWR1fSwPH18WyAA84YtxfPD8bfb1Exwo0CRw1RLRScn
 6aJhsZJFLKyVeaPO1eequEsFQurRhLyAfgaH9iazmOVZZmxsGiNRJkQv4YnM2rZYi+4vWnxN
 1ebHf4S1puN0xzQsULhG3rUyV2uIsqBFtlxZ8/r9MwOJ2mvyTXHzHdJBViOalZAUo7VFt3Fb
 aNkR5OR65eTL0ViQiRgFfPDBgkFCSlaxZvc7qSOcrhol160bK87qn0SbYLfplwiXZY/b/+ez
 0zBtIt+uhZJ38HnOLWdda/8kuLX3qhGL5aNz1AeqcE5TW4D8v9ndYeAXFhQI7kbOhr0ruUpA
 udREH98EmVJsADuq0RBcIEkojnme4wVDoFt1EG93YOnqMuif76YGEl3iv9tYcESEeLNruDN6
 LDbE8blkR3151tdg8IkgREJ+dK+q0p9UsGfdd+H7pni6Jjcxz8mjKCx6wAuzvArA0Ciq+Scg
 hfIgoiYQegZjh2vF2lCUzWWatXJoy7IzeAB5LDl/E9vz72cVD8CwQZoEx4PCsHslVpW6A/6U
 NRAz6ShU77jkoYoI4hoGC7qZcwy84mmJqRygFnb8dOjHI1KxqQARAQABzSZUb20gTGVuZGFj
 a3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPsLBmQQTAQoAQwIbIwcLCQgHAwIBBhUIAgkK
 CwQWAgMBAh4BAheAAhkBFiEE3Vil58OMFCw3iBv13v+a5E8wTVMFAl/aLz0FCQ7wZDQACgkQ
 3v+a5E8wTVPgshAA7Zj/5GzvGTU7CLInlWP/jx85hGPxmMODaTCkDqz1c3NOiWn6c2OT/6cM
 d9bvUKyh9HZHIeRKGELMBIm/9Igi6naMp8LwXaIf5pw466cC+S489zI3g+UZvwzgAR4fUVaI
 Ao6/Xh/JsRE/r5a36l7mDmxvh7xYXX6Ej/CselZbpONlo2GLPX+WAJItBO/PquAhfwf0b6n5
 zC89ats5rdvEc8sGHaUzZpSteWnk39tHKtRGTPBSFWLo8x76IIizTFxyto8rbpD8j8rppaT2
 ItXIjRDeCOvYcnOOJKnzh+Khn7l8t3OMaa8+3bHtCV7esaPfpHWNe3cVbFLsijyRUq4ue5yU
 QnGf/A5KFzDeQxJbFfMkRtHZRKlrNIpDAcNP3UJdel7i593QB7LcLPvGJcUfSVF76opA9aie
 JXadBwtKMU25J5Q+GhfjNK+czTMKPq12zzdahvp61Y/xsEaIGCvxXw9whkC5SQ2Lq9nFG8mp
 sAKrtWXsEPDDbuvdK/ZMBaWiaFr92lzdutqph8KdXdO91FFnkAJgmOI8YpqT9MmmOMV4tunW
 0XARjz+QqvlaM7q5ABQszmPDkPFewtUN/5dMD8HGEvSMvNpy/nw2Lf0vuG/CgmjFUCv4CTFJ
 C28NmOcbqqx4l75TDZBZTEnwcEAfaTc7BA/IKpCUd8gSglAQ18fOwU0EVo1liQEQAL7ybY01
 hvEg6pOh2G1Q+/ZWmyii8xhQ0sPjvEXWb5MWvIh7RxD9V5Zv144EtbIABtR0Tws7xDObe7bb
 r9nlSxZPur+JDsFmtywgkd778G0nDt3i7szqzcQPOcR03U7XPDTBJXDpNwVV+L8xvx5gsr2I
 bhiBQd9iX8kap5k3I6wfBSZm1ZgWGQb2mbiuqODPzfzNdKr/MCtxWEsWOAf/ClFcyr+c/Eh2
 +gXgC5Keh2ZIb/xO+1CrTC3Sg9l9Hs5DG3CplCbVKWmaL1y7mdCiSt2b/dXE0K1nJR9ZyRGO
 lfwZw1aFPHT+Ay5p6rZGzadvu7ypBoTwp62R1o456js7CyIg81O61ojiDXLUGxZN/BEYNDC9
 n9q1PyfMrD42LtvOP6ZRtBeSPEH5G/5pIt4FVit0Y4wTrpG7mjBM06kHd6V+pflB8GRxTq5M
 7mzLFjILUl9/BJjzYBzesspbeoT/G7e5JqbiLWXFYOeg6XJ/iOCMLdd9RL46JXYJsBZnjZD8
 Rn6KVO7pqs5J9K/nJDVyCdf8JnYD5Rq6OOmgP/zDnbSUSOZWrHQWQ8v3Ef665jpoXNq+Zyob
 pfbeihuWfBhprWUk0P/m+cnR2qeE4yXYl4qCcWAkRyGRu2zgIwXAOXCHTqy9TW10LGq1+04+
 LmJHwpAABSLtr7Jgh4erWXi9mFoRABEBAAHCwXwEGAEKACYCGwwWIQTdWKXnw4wULDeIG/Xe
 /5rkTzBNUwUCYSZsLQUJDvBnJAAKCRDe/5rkTzBNU+brD/43/I+JCxmbYnrhn78J835hKn56
 OViy/kWYBzYewz0acMi+wqGqhhvZipDCPECtjadJMiSBmJ5RAnenSr/2isCXPg0Vmq3nzv+r
 eT9qVYiLfWdRiXiYbUWsKkKUrFYo47TZ2dBrxYEIW+9g98JM28TiqVKjIUymvU6Nmf6k+qS/
 Z1JtrbzABtOTsmWWyOqgobQL35jABARqFu3pv2ixu5tvuXqCTd2OCy51FVvnflF3X2xkUZWP
 ylHhk+xXAaUQTNxeHC/CPlvHWaoFJTcjSvdaPhSbibrjQdwZsS5N+zA3/CF4JwlI+apMBzZn
 otdWTawrt/IQQSpJisyHzo8FasAUgNno7k1kuc72OD5FZ7uVba9nPobSxlX3iX3rNePxKJdb
 HPzDZTOPRxaRL4pKVnndF2luKsXw+ly7IInf0DrddVtb2647SJ7dKTvvQpzXN9CmdkL13hC5
 ouvZ49PlXeelyims7MU0l2Oi1o718SCSVHzISJG7Ef6OrdvlRC3hTk5BDgphAV/+8g7BuGF+
 6irTe/qtb/1CMFFtcqDorjI3hkc10N0jzPOsjS8bhpwKeUwGsgvXWGEqwlEDs2rswfAU/tGZ
 7L30CgQ9itbxnlaOz1LkKOTuuxx4A+MDMCHbUMAAP9Eoh/L1ZU0z71xDyJ53WPBd9Izfr9wJ
 1NhFSLKvfA==
In-Reply-To: <20231010145220.3960055-1-alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:5:190::35) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MW4PR12MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e35104e-40bb-485d-1eb2-08dbc9d2008f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzLaZVmRAumpBc7PGuB+Zjiqzvd+LHK8i4U3pdkX4kmrcOfNDiJoPE1bRPbxzucheE0P5+/DSR+2lCz7+MZAZVv3XQvv6hSaZG8ZEpaBB7zs/rjmOGhlNuaWQwBtmRClOqojMasr/gsvqgeqnM1XqW68kCr7eOhu23XNrqEdR/OtIzcPSJV2wwlSz70ksecwNl8d4UTIz5SdXEdKXvCcD51PNQ1/n8dmlHUjMUGyoUAa1x0IZJyVrouRxYdCYcYk4Y3MXUaQSsfn1okhNFJbHyI0J6DlyASvcwhp9ZiWuUXKD0fS+T243RaIxaF/CFN8HFsRmHKPoOfwwxkPS209HDCOTMQnsstLVTQrqS/x8bVgHJKAqXu4HxJLKo9U85OSSYe4sUrl6c7vdfSg46c3BbDUvMERsjry106Ekkl2BYha2nSEufjUsmzahc3j/3l7PDEs+giFuJAAwveDrJ0DT9fcElA0pBhHhvM7A/QU851B3/cWLca8y5mxs4bt3H0+EFlYayXuY6/k3xtJl5RDpbMvcgRwHDcVDQ9HuiG8zp1UrZJ51bss+2KqrKeG+lFTcDkxAYIZuIrVEkHB0n/vBpL6FvSg4yjqIAhcp8bsuqK5Arcemfjh7Qok4oZlOYbSbTwjapnkxoQzwf0qusitWGi+hpJp0eg42asGYDDlM0uZ3xc6puiySfoKjSCj6nA6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(366004)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6512007)(6506007)(53546011)(2616005)(478600001)(41300700001)(6486002)(31696002)(83380400001)(7416002)(966005)(2906002)(66556008)(54906003)(5660300002)(66476007)(66946007)(8676002)(8936002)(4326008)(26005)(38100700002)(86362001)(36756003)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aStXUkYwaGtyKzJnNXdMQjNQZFYyZk4xcXZGc3poN0pYYjZXd2RieEwxQUVF?=
 =?utf-8?B?WUd1MnBMcDg0SVdsamw4WmJmZ2lYNVFQOU5RWkdwSyt3enh2Qk5wazkzOFR5?=
 =?utf-8?B?dnBNRER0SFFDMzFPSUY1RGlLUmdqaVE3dTFvQzlxNFBXelhLUzF5Y25sRmJY?=
 =?utf-8?B?WWRYOUREOE5MdU0yajZNYkY3VGg1VlJYMVA3VjhRZHVwSlZCUTdNTTZyQXMr?=
 =?utf-8?B?eVl0aTRWTWh5T0pHaU5HMlhweHFQSUtvSDR4dlYyMVo5ZUNSZW4yMUVldkRv?=
 =?utf-8?B?Rk50MnFDMzZGWEFaSnhqSW9hUTEyUUZwMm40VFJYR0prOVB5NTJyR1ZmL1V6?=
 =?utf-8?B?NXUzQ09nTWhuOXlWU2I2ajV6VWhCdXZ3R3ZZNlQ1T01JeDBrd21pQjEyTXR0?=
 =?utf-8?B?R3FMUjMyZ2o2ays0Umw5SmJhalVjN0dBM0Q2VGtIZytCRDdqZjV3TWdLQU5H?=
 =?utf-8?B?UGIybG9FRnNBT3BoVDZ3NEt4ZU1INnlRTFZIcUtnSEtiR3dVVmhCb1VsSTVS?=
 =?utf-8?B?d1BrbGpLZnBNTER0MEtBd2ZhRmN4RFFaNFY4SkxyN0lNK2YvajkvMCtXYTVt?=
 =?utf-8?B?ajcvS1VKVGloVzBkeWNBOElQZ1kzVnRudnd0YnJoaW94V3pCTjFGUHJQZmd4?=
 =?utf-8?B?ZjlqNzFKSlhIaGlDbWU1TzFlVDMzNkJ4cWRTL3BmOW9MbzV3UFZsMThIREd0?=
 =?utf-8?B?blhZNENJZU5pb1ZVMmdnbUV2Qm5ZV0hwTmNVK1J0cVFhQlVwSmZndVpSVnpR?=
 =?utf-8?B?NEtXc1NoeWs2akk4dHdNRmNrWjBTV1JOUmt5ZWlnQm8vYXh5V3JEcTdDY2Zz?=
 =?utf-8?B?cm8wRWFZYVJyREhCMkhhVEpEUThNRjREMDZndjJOakZzejFINzFGMmk0a1Ft?=
 =?utf-8?B?NG5vRXVlYVBDYkZlUDc2L1NWS2ljQVl4NWdUeGRSbnEvSWRGZmdtUE14Slhz?=
 =?utf-8?B?Um5xYXZEbERSdm0zVWgyRXBSSk82U3haelczakdGNWFpYVh1L3ZxaGtjR21t?=
 =?utf-8?B?SWRUU3E1Smt1RmdPeUc5dVo3Y2JzOS9GYVJ5QWsyZ3haWDNNUTIxaDZlMmti?=
 =?utf-8?B?cld4U1AxWS8ybUN3Q1pjNUZ3eHZld215SEpRUUdYWXBIZ2MyNG9zUnlaaVc0?=
 =?utf-8?B?OW1GR25wYUQ0bEk3RHVMT0ljWmY2ZlBHMXVFZ1pUU1REYXhSUFViQzA5TXZx?=
 =?utf-8?B?b1VjVWxzcEJidGdJMTBwMHMvdkZMYjFKU1JSV3BGWGpQQnlVUGRqb3ZSRmpK?=
 =?utf-8?B?czhGQ1BLQWh4TGVjNDdMZm82M3B6TVJFSkFQM01URy8wY3lXOUtnVHZCTXor?=
 =?utf-8?B?K3FVSHR1dnEyY0loU3VRWWRxNEtmL3lHZFAzWDliZXRRMU9WUHRjU2J0L00r?=
 =?utf-8?B?WXBJTWI4cWZyN2Rrc0dlb0NTVGhMR3JDUy84c0loVGhBaklvNHJ0TXIzalQz?=
 =?utf-8?B?RjIwQmdVQVdRdEFzZFYwQlVTMHVpM00wTGgvMHlFNCtRM0JYRzBFV1BSMnQz?=
 =?utf-8?B?N21DblBFTGJhcWJBSDVUWHgzVUx0WU96Z1RGd0JZK0VBNmNMazlLVnRTY1pY?=
 =?utf-8?B?QXB4MHV1TTJlU2pQTkxQUFcyeUx0MjBqcWN6VmtZSHRTWEpCZ1cwUlRnWjBt?=
 =?utf-8?B?b015VEhsNHJCcXBiYW5nTGhCNUhYUkVLYUZKQ0YrVEZuU3BHcWlIVWJaMHpx?=
 =?utf-8?B?Wk1sNkJwMWRxY2tHd2srbXpSRFF6c01mMlNRKys3aXhMQ3A2TmZ0VDRjUGx5?=
 =?utf-8?B?a2h6RVczY2UrR0RScDV3bDl3dHpJeFY2d0JyN2hCMXVGYUhvSU9TRW1EWjF2?=
 =?utf-8?B?b1hNb0dMQ0F3NUx2RFNKNVRhOTZMalJXbXljTkV6MlBRTjduVlB3OCtrMVZW?=
 =?utf-8?B?clY0SFhzUkhHa3ErV0JLQUw4RWprdk9wQlkweHpNUnhIYWZxa2w4TnZnRTJ1?=
 =?utf-8?B?NWdQYU5ZVEh1aThHL2JrU1hsaVlyL3RkYm5JUmhFeGYrNTJWdnhXS2lnZzlS?=
 =?utf-8?B?UW4vQ0NTY2FidXU0Z0Y2aFArN1k0cTBOVm9nc0dvNisrcHdhQ25XUm5SR1Yz?=
 =?utf-8?B?TEcxMldmMVZhaE5sbXltbU1LdW9pTGVtWDF5WCtFLzRWTzE5ZWhNOVJjVmpU?=
 =?utf-8?Q?nB57MjC32bchauUajOab8q8hF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e35104e-40bb-485d-1eb2-08dbc9d2008f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 20:46:39.4292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eC4Rv+ipNWaDnRwSEk61ewqiWnzKZH3AUU4REfyxeW4PkpKOW34o+hRrdwUCNOsP1YSDZOpWV3qUdRKHxxofIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 09:52, Alexander Shishkin wrote:
> Hi,
> 
> v3:
>   * rebased
>   * moved mem_encrypt_setup_arch under a common #ifdef CONFIG_X86_MEM_ENCRYPT
>     per Tom's comment
> 
> v2: [1]
>   * added 2/2, which is a minor cleanup
> 
> v1: [0]
> 
> The main intention of this is to move sev_setup_arch() to mem_encrypt.c
> to reflect the fact that it's not SEV-specific, but covers TDX as well,
> although unintentionally.
> 
> While looking at it, I also noticed that mem_encrypt_amd.c still
> includes virtio_config.h, which was needed for the code that since got
> moved to a different place (and even there doesn't require the include
> any more).
> 
> [0] https://lore.kernel.org/all/20230530121728.28854-1-alexander.shishkin@linux.intel.com/
> [1] https://lore.kernel.org/all/20230609171214.31846-1-alexander.shishkin@linux.intel.com/
> 
> Alexander Shishkin (2):
>    x86/sev: Move sev_setup_arch() to mem_encrypt.c
>    x86/sev: Drop unneeded include
> 
>   arch/x86/include/asm/mem_encrypt.h |  4 ++--
>   arch/x86/kernel/setup.c            |  2 +-
>   arch/x86/mm/mem_encrypt.c          | 34 ++++++++++++++++++++++++++++
>   arch/x86/mm/mem_encrypt_amd.c      | 36 ------------------------------
>   4 files changed, 37 insertions(+), 39 deletions(-)
> 

For the series:

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
