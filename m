Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9727BE3B1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344984AbjJIO4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjJIO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:56:47 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E65AB7;
        Mon,  9 Oct 2023 07:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1Nl26YY3qHlemLUM2/cAi/Rc4lwi7N/DfaeqUPiyGYcwNoPBC3wH0OQ4WKYnpjhmZTyZv26HQBjROALAyKmRISUortmXs67WKu+YXGu+JTRTl6BCQfRMbspvqeRbGlUZN+zy23LfF5QtC95WF26WNnwb/ffFBOLDDN3fEVxG5/0USqRJToUq4L2y5jdCwyOWAlQZBVkeBgiW1FYRpAThn9F6P3gA+I9SaVPWaQaydCH34YT2hR0MotkdU8+pmp4AyJsAHF8Xv0nF1uAys5XCrARn9yKH+SWBxKvMPm43IZ1lDopJS8QfkocPipWOFY18HqVGkEsma0YvlUsPHg+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8x71WRCTU0T6pjuZHPQAsyTCbwpAsG5csWagaHXxhM=;
 b=VTac9TjnWFsXrr9uqTMH1KNIP2O18JsDFV0F3KAGK8oObuBSm/LSPa5D4ijrBVJKMED1CcObvOBkgWEuQAaeZvAdnIodNIskUs8kjZplgEJPm7dMbDgaf6Wfm0Hkdx7t1jAPxwoMzqX26bhC+iUSQtZqu6jDcm9j4sT3PWCvN+lyVD73GDSuP54XzKJ+j4HleigiWeo0vLKGVzldNsmX/BULc7ud/Me0a+SyBQavI5D/PjHoFt5RQQoqBdTim9oiuE+RBkr0y3w/CYQv+KR4JGmgVjKWi0Ko9Jf0MI3yzrH2KcBoePKr/38iT3z19qD3DPnx5626c37zNaBtF3sqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8x71WRCTU0T6pjuZHPQAsyTCbwpAsG5csWagaHXxhM=;
 b=iXz2ebHKKAZ8j6ympXdbedU9UYEmGebGyWxXSLQdjdbJklwqP6IwF0qnEd/iiJWKDo5VOwyTGuyWznqpJ48/v2uy5MALbPMukQj/Z0lQU7DZI80tPkBDuYrlipMUEWzXuVVbhtImNJMk5roqxLJIMBZk4IkF791kOFASLfhOTvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Mon, 9 Oct 2023 14:56:43 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::bc87:8b0e:246d:5d85]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::bc87:8b0e:246d:5d85%7]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:56:42 +0000
Message-ID: <b8dca5f4-533d-4a9c-a177-fbdf3ad7848a@amd.com>
Date:   Mon, 9 Oct 2023 09:56:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 14/20] cxl/pci: Map RCH downstream AER registers for
 logging protocol errors
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Robert Richter <rrichter@amd.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20230927154339.1600738-1-rrichter@amd.com>
 <20230927154339.1600738-15-rrichter@amd.com>
 <20231002155658.00004ac0@Huawei.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20231002155658.00004ac0@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:806:d0::14) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 092fd3f7-ad67-4b22-c349-08dbc8d7f308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hiyo2/V9gZXp/ZCyqAFyOLW41vs6hwZ1xyVwpsW5LvxsI98ufaG3eoLBMiRmArhSTBK3wcwBG7suvooDV4pg/3nFA0+en00jPmC5rZUtipck4grHNi2MvCcuzH1/oP+X+ZDOd5+qCEXYHIXtNkvPkhUnyVCbp3vJHMzz4zZdmW/ssqOKpPgcP7ll6eOwID7/7xP5JT+UFVP2RxSwiMl6jqC8Pnjky6942ievm1S5q5DhK8+LunjpasPs8fzFd6DhavFTleOV8ZkfbtQGEUCe+eZCPAzz65Tl5vJnnL+yg6qiL3PoNZp7RNWRb71DpQHfjz4GtwBBVxuK2PzO1XBqaqhwf2W2DYfgPo/eKh0q4x4WmqKpPpEtuxqgliJpXL4H+tzdjem6xc8HAIX6mkr/03wcUBv9NObY+8cJG8L6fmUyAVJwtXgrYilDCLvrSlObWfDlZnVUZUXQKLk4Dnbv03V9TeugqWmQkfDwIue8m4NlFQJKGydQCblxmdQn8XxLwu7r10cN11ORL3WZm5cE+d6SuxaAsNfKB3hPC0udiv2qwWBkeGuGa4gx/flZqtbiD9K5vTmSxNHJ73PN0237Bof/23COqElN01sjzIA+3aL8rade5ep0UHuk5AdWr55u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31696002)(38100700002)(86362001)(36756003)(31686004)(6512007)(2906002)(966005)(478600001)(6486002)(5660300002)(8936002)(4326008)(8676002)(41300700001)(53546011)(6506007)(83380400001)(2616005)(66556008)(6636002)(66476007)(7416002)(66946007)(54906003)(110136005)(26005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzNJUXRBY3NHeEh6WmpteE1iM3ZYK082NzhQT2xsSUJFZVhOQVRLRXYwRDV6?=
 =?utf-8?B?eDhoaTF3UVRSbTBCWnBjWlFsQVJmMUlNMU51NDdPTk5Yc3lBbUk4MXJnR1dE?=
 =?utf-8?B?cndmRTFXTXFEdllPRWRaTWJJQmxDcGxYZVdoVWNzMms4VldSWlhLRVVueWN6?=
 =?utf-8?B?MVRjeFN3LzhlUVBBbjlHeVRmZldnYlFuU3JhdjdJbk41aGthV3VDenQxRTFl?=
 =?utf-8?B?ZHF0QW5ILzdqa2JoZXU5L0hEK0tEWnJLblNVeTZ4dXVFa2hwc0d0cmluTnF1?=
 =?utf-8?B?K1lqWmtYakdVQXNLWC9uTEw1KzZXQW02WE5SVGI4WlV0Yldtd1ZBQjFjVVZJ?=
 =?utf-8?B?cTFXczE5a2hJaVRrTkFlbWlHUllqRm5QUVVjYTJMY1lKTXZmMkNzcHZoeDRX?=
 =?utf-8?B?SUloa2lLMDhJNFVwTnZKMk5zSXh6OERab1ZEbjhTTFhxVmw4MWMyWVU3QlRZ?=
 =?utf-8?B?RmpYcWk0cDc3QTlMcE1NcUxkc2VLT1U2eURkS1Foa1NES29ldmw2aGc3MlJi?=
 =?utf-8?B?Z2FTYVZyVFNrc1I0elJTcmYzN0hWdmJ1REcxb0lkNWhqa3lyZk1Mb2ZhQzVo?=
 =?utf-8?B?dTdmWlJKMm1UWjZKSnI5NWI0bEh1ajhhZmw5Z3JsTFVxWFRRb3g4eVY4RVZk?=
 =?utf-8?B?OGVsVy9rN3BVc012NFdaK1NSb3VrWC8yblZKYlo5eVAxMzVjRkM1WkoyZDVz?=
 =?utf-8?B?U2gxRHJqcndJYkRPOU1CYm5ES0YyMVNjN29HcWFsVTJSenRNQW9QNVNYVDQw?=
 =?utf-8?B?Q3B6cVdzcUZuaDZDRzBuSHVZVmEyd0I0MHBvTFhLbFRYOGZQOENYeHJYcWpG?=
 =?utf-8?B?dUg2S3VjRGlmTDMvU0l0Mk1PVW9SSnFLZ1l4RnVmME9nVTBBcU9YK1VLYmVC?=
 =?utf-8?B?a1gyWG9oZUFNaFNqTGFCdTd5ZHp3UElVazJOOE1lQTRXVlgxZVcrMDZkV3cw?=
 =?utf-8?B?Y3pOTVZ3L1hzdFFQekVlaWVjbnErbkpzdVNxVGZYbllwcE81cTFYdURoQWtt?=
 =?utf-8?B?WmxPK0VyU3RmZVBIVDJnQWFWWUVSTEgxWDMzQUwxREkvc0xlcVR0WERoTDBi?=
 =?utf-8?B?aTAyWXNMUTg4MUlJWmtaWk9CQ3NDc0R5OWQ4cnZlVURsdTRaN01jcmRUS3Rm?=
 =?utf-8?B?RXJ5VlFwSUY5UFptSHBpc242WWZpVXNTb0g1K2s0VGtXYm1lL0t2bXVqb3Yw?=
 =?utf-8?B?c0tQVTRmRitiMnJVMi9CM3ZmU1RNV0dKL2JMVlRwR01tTGNDSlNjMzNqcUxE?=
 =?utf-8?B?SnlQckNxRG1iYm85WVJjd3JNNnNUaE9neXh3SUh4N21qUXc1NnFHZ2xaVTJS?=
 =?utf-8?B?cmkzRitGUkhNQm5lNGZBRFNKaEZsSWxhVmFPaDZ3amVNa0xKR0ZWNWRPK2Jk?=
 =?utf-8?B?cGtwdUlHbVh3dUxLQlltc0U5eG9ZY0k2aDRUcE5UYXZmMlR0eVZMTHNqTTBx?=
 =?utf-8?B?cHVsNkl3YWxXQWVyZGs1WSt2d2VDdjVoSG11cEFOUktKSGtjdWF0YjlQYmFz?=
 =?utf-8?B?Wjk1S0lteFZ2VndGbXBhcU5IQStabHZ1ejFUVkFrem1mcExqd3BsUUlrMHVU?=
 =?utf-8?B?ckJMTjJlSmcyT0kxZFIxOFlGQmlDYTRxcHdGRFcybjBwNEZLbXdGK1hGTmow?=
 =?utf-8?B?NmtiMGhtUEpMdTdRTHdrTkN1T3VPZWpNd0FtQ0d3VGIzcHR4ZE05aWpScWw4?=
 =?utf-8?B?QXpEdXpaLzVtaU1Hdnh6RXNHYnE1WEVWOWx6TUM0a0VHMGd3bG9rZjR6SDdV?=
 =?utf-8?B?VHlPRTAxRmlSeFdPOFF4MHZ0YzhNSWVSUWVIVDBpbCs1V0loMTdPMmtCK2pT?=
 =?utf-8?B?b3lJTVVVdHVzWDMyU01BaE5KdUxWUmNFNGVOekRVdHN4R05zNTBpdEkrMHN4?=
 =?utf-8?B?ZTluVkpxMi9kdFk0SlUyTlF4eFQrRW96RHdjemo3aFJHQ0hHcjBtL1kwTkpq?=
 =?utf-8?B?UndudU1jZ0x0NW9tcEFzd3YyRitRNTlST1FoUU1HOEkwelZvMC92TCtUSEpi?=
 =?utf-8?B?WU5kNnJ0QWpaN2UvbGhLMnBSQUVqMHovY3Z4Y2RpcFF3bW55Wm8raStUM25W?=
 =?utf-8?B?M1RuSVdiSGM1WmNUWWZweXB1dENVTmhYTldPYWRvZThLNlFaYVFHdXBNL1lN?=
 =?utf-8?Q?1GiADlOU8qRCJJr6TV7AskOpC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092fd3f7-ad67-4b22-c349-08dbc8d7f308
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:56:42.5270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHQzSdy6cPGbunjikgLWajwg3fKGBc6Tu6YEXl7/E5ve0v6P1S9mpKb6hqz6w9vUWrWiTHnJlZz2/Mb9i5WIhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/23 09:56, Jonathan Cameron wrote:
> On Wed, 27 Sep 2023 17:43:33 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
>> From: Terry Bowman <terry.bowman@amd.com>
>>
>> The restricted CXL host (RCH) error handler will log protocol errors
>> using AER and RAS status registers. The AER and RAS registers need to
>> be virtually memory mapped before enabling interrupts. Create the
>> initializer function devm_cxl_setup_parent_dport() for this when the
>> endpoint is connected with the dport. The initialization sets up the
>> RCH RAS and AER mappings.
>>
>> Add 'struct cxl_regs' to 'struct cxl_dport' for saving a pointer to
>> the RCH downstream port's AER and RAS registers.
>>
>> Co-developed-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> As before. Co-dev just before SoB. 
> 
> https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L521
> This example looks like what you have here.
> 
>> Signed-off-by: Robert Richter <rrichter@amd.com>
> Otherwise, LGTM
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Yes, we will fix.

Regards,
Terry
