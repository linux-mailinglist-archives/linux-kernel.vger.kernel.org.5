Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A7C767961
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjG2AIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbjG2AID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:08:03 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7561B1AD;
        Fri, 28 Jul 2023 17:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690589282; x=1722125282;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=09WPjjsbdKjBBFgc8EBWzs08qRIMOpeVAEzPNKgotF8=;
  b=lY4fyVZVhiiXOi6Itm2j1QBroqdO7K7zf9GbX6OELrvamnlFL7NzlgZK
   oTxD9C2ch2bKVAdJ8u55386mdbCWNOmZ/i5CGaDmKK9FbbOouMfnhPDbX
   TcB6XdOebP47rHy3ERFXhnghJMLJ0BfRNIAW4nObzH11Z2MZzs+q8nAMl
   rbt/01NCj4eIRtJU0H5OS235/ILGkMtrRiVdwhgDsxROa2rEIrsUzg/q2
   Yl7dExSclY6U3dyowJTcztgYqdlwfIBRzoJ+i82lvL1xBSCSLH/c4gyNv
   cHcmYLuOwqzeokEDZVfPZXPkSyPb7rpLa631SDs0b+9vr71i8ONnffFc9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="432519178"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="432519178"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 17:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="871006480"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jul 2023 17:08:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 17:08:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 17:08:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 17:08:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 17:08:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvhQBR3nJIEIDTItx+8Re17o7ojmy5khhDZBfMI2CNOkjWuJxbQVyJJe+1JlGYh81oDQw2ASosRgMHjpQKybdMfyBXed3GMSXr9xrTsHXwTlr/mFwnxcQQ+rbuhIXPnyvilgc7jBfobG/iji93Y6kQoMNWoK0Pa3p+BHTBWQi0aSm48oiVJUH7CtWbrQNbzIarHbuFzz8ZOovrh0C3bVp2BRbemWF2v6T2k0/ILf5HlK7BvigNg7ILq3zOqRDQEAxG8cT8KUcUbbhXLh+leLM890CvYLZX39Vz/SfOz5AaeJqMg+bTu+2EZ0CQVhmdQAgEzaY98Bv20jkqBHZO7TxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09WPjjsbdKjBBFgc8EBWzs08qRIMOpeVAEzPNKgotF8=;
 b=eD8fE9CJ6kfcTy/a7K4oCZOdyGD0OGzZfGnaT5SaIm0RM+qWHzaRtQv4pQ9TWZpjqdCd4O4E3dXY3VRu+fQiadJ1sfPde5+50QReFxQPpqLJQFTXqWGnuPczj/9aHsNFJZw9ejxuyUuHSLqVVaT/Nmq+w7DLuBgeyF8XAMAAVgQnugzZvgMOF3fXMDiiKD+3Kg5KOj9iZ/UCIeYfy3Ncocc1LFzaamNivq7vFFW7xfdPDdiJFPH54kJsyZZZNgWlRQEp7wqEFNmKlLafD2xfXvYQil57TWDXqJvA8nfnNtjoeDR51433stVghuWJqo4tMCyvkSFwgRZ4SyOWCnlaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MN0PR11MB6184.namprd11.prod.outlook.com (2603:10b6:208:3c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 00:07:57 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2%2]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 00:07:57 +0000
Message-ID: <0b8c6cd8-3848-00ac-582f-13788bf0492e@intel.com>
Date:   Fri, 28 Jul 2023 17:07:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch v2 27/38] x86/cpu/amd: Provide a separate acessor for Node
 ID
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, "Jean Delvare" <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "Russ Anderson" <russ.anderson@hpe.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120931.171636739@linutronix.de>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230728120931.171636739@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0034.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::47) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MN0PR11MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a14f2d3-03b9-4b80-f4f2-08db8fc7dd2b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0iLqtC2PXp9dDvy5jbhwCL9atausH8NpEjzJjHGXuJvtMuQZjvyx6k4o0EU6wrRC49ZoZbCi31HXLmOA3xWyizQV3GxxkVQ7G8qE6O1CNzs6eAEY4qe+1lMA/B/o3rYY5QspXD8F0KwkDizzcQgN/X1KSYueeSPLMlNwiRxGQnp32XPbdqsELphjtiMvpE2bXD0jyvY9kgCKgLH1hHh9lcAyd9NehUnV/ltPPP5TAi4/msyb5ZuUvfzNiMao13TKoG/QhvohfsbnMZHFYmits9aWg2dazaIjH7AxdimlLiXGpLh9MlL6DCrcuh/VU7sH5Zc4pxbLBL4BKXJ3N306SQqAOAvtnfNdxHsbOOfZFzSJ06kvAnG7wOZnscTL1XDoCyH3JW73FzaY6LScR4FjnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(26005)(6506007)(478600001)(4270600006)(186003)(82960400001)(110136005)(54906003)(6486002)(66476007)(2616005)(4326008)(31686004)(6512007)(83380400001)(38100700002)(66556008)(66946007)(7416002)(41300700001)(44832011)(19618925003)(316002)(31696002)(558084003)(8936002)(8676002)(2906002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDZiYUNoeEk0S1puckF5dkl4US8wOFV5NFUvWjQwaTNNT3lhaTBEdDArSFcw?=
 =?utf-8?B?dW9lazV1dXdTREJqY2NTaE5oaTJHa3p2VUhRbTdqM2hCd1YybVY1NlFZWlpZ?=
 =?utf-8?B?QURPOEpZK1YwcENBVlpGMEg5QktDQTZGOXlVUkFDaElxWVNtT0NnWFNCNDNR?=
 =?utf-8?B?K1d2NE5QT0hpTGVHMitndGo1Yi9jOWFGbWM4ZTd5aUJlWk9Od1ZNMzBEaHpu?=
 =?utf-8?B?NFg2VUVPdmEya0RvS00zUjVSTUpQdjM1bHV0RjJVSEttRUlrRHFxYU12ZHY4?=
 =?utf-8?B?d2t5dXB1dXl0NFFxRk9oMFhmZzJzVUIxNXZ2eGdCSy9MK1hEdTZISm5hbUZ6?=
 =?utf-8?B?Z3FGZUdxUzRMVGxQeVFPQ0hndEg3bGVuY2traDA5WVB0Wkd2NEF5eFE2NHpB?=
 =?utf-8?B?TktSR2VUSERPeWNzNnRFZkh2akNzK0FwdmMzeUJXenludm00MFoxWXpMTHFv?=
 =?utf-8?B?dGpuOW0xRS8wZkIySzlVd09NMWJ5VUJqZys0dnNWSGFDK2FMOEE5RjV0R1Vu?=
 =?utf-8?B?cVlNVDJ4KzZwdHZMOVBQM2l2V2tJbGUzTzlLQ2h4Ym9INDNVOEp2NTFyNlov?=
 =?utf-8?B?cGVmNFFvNWtua2NEVTBQL1JyelFUK005VHhnSkV4bkJnemh6bHNsNEhWM1I4?=
 =?utf-8?B?ekJSdTVhcHFQQjBXR1BuZ3VEZFlHd2RXaHVIZ2pCTFUrMEQ4akYwNlE3REZs?=
 =?utf-8?B?RW9lT3g4YVdVcThyejZmQzl1TDE5VUVqL3VOK285Tmt3amVmTFNRdVByVlI4?=
 =?utf-8?B?ZWV2bjNJZHMvdDZyeUt6NHJreDFiZE9Mck1JU2Vpam9NUVJqOWZlVjlQQTJS?=
 =?utf-8?B?MTlBVG4wUEVZMmN0YmlDd3RqKzFiNk92K2pVdWNuMm9wQ1I1QWwyUWx2RUV2?=
 =?utf-8?B?N1RuTHlmdCtUZU5EUUF6MVg2bkF5cWhJV0JBODJ3eHpEN2hCTE0yM3QybkVj?=
 =?utf-8?B?RUVKb002dTM3SXBydVJEUUtaU0xQM000ZFB2MXZzQWRObmYzV1QxQmFxZnM2?=
 =?utf-8?B?MGtCMjR6YXVGQitVK0VwVDhrNTB2UFZYMjU0eno4WnpZbVFGenducGRUVnM5?=
 =?utf-8?B?NHZKU05xUXFoUGlGcTN1OVpKRE1vUm5Hb3hGVzRsb1pBUnQ0ZGJyZk9YSFR5?=
 =?utf-8?B?U2FuY29PdHIxMFBXbzE3MWJWSUt2Q210U3R2di9WZ1JHSUdKYzhzd041RjRU?=
 =?utf-8?B?RnBEbDFybG5PRDBodlZDMmtoYXZXdTU3UEcwTU1ENzBTeVhWK29zWE9LMS9j?=
 =?utf-8?B?d0ZkVTNQNGNlSy9ZaVMvYnNrUklMb0QrWkFIeTdZQjdVT3BLUWFoUElMTGJG?=
 =?utf-8?B?ZXhIS1Bpd1Q5b3ZkODVlM3NWbzE2ZFRSZWRvcXlrR1pwdjFQZWpGamhCOWlt?=
 =?utf-8?B?MHRSc1IyaUtsYUpNR2FIMVZSbzAyZDRJWmxTZ2U0UFhRTGRMUzFSY3dZOExS?=
 =?utf-8?B?M0lWWnJhR2lQSG9hWTBic0J2Z2FFa2pFOEhZdGZ3VTBUK090MkU5ZmpQMFpx?=
 =?utf-8?B?ZEFyZnBpWGxDbUZuQVorSlRaa2VqaHFUWGl0blRtQkRaazFBN2duWm8yVm95?=
 =?utf-8?B?M1orTm1CRUhZbnVOY1VEQjNVMXkxb01KNTFoT0pDd1lTQVFGMU5ZaTRWZ3hY?=
 =?utf-8?B?T2tXMmV6M2ZNTkp6QzVFd2ZIVS9TSENTT2hwUGxMN2tWKzMvYVdTQW0vRG9B?=
 =?utf-8?B?aUlURjNsbXZLTHRjcThrK2VoNmJjSVlYM1F2U2Vqd2h1UGtxTWEvQk44WlBv?=
 =?utf-8?B?cVhydDhvcTJxalNPTUU4SVkySlIzeTRPOEpJNUNLeDBiVkxNcVFMaUJvL3ZG?=
 =?utf-8?B?bFFTTDZHZzh4YXVGRjdXWVpCVTdGS2pHSWVJZGh0MDhDdWQwTUZKc3dyZ2J5?=
 =?utf-8?B?NUNRUmJFdTNMSGlzS0FDNE5HdlRQV0x5bTAwZlV2eWExMHBmTTZ5bFlMS2E3?=
 =?utf-8?B?SHpULzhEQ25hYmM1K1MvYkFFOHJ0ZVE1Q01yK0FPQ3hzMnJpbkVMOE96SjRl?=
 =?utf-8?B?VEdWQ0lBalpMYmR5SkVaUWFmUDNzSSs3cXQrRTUzTmg2aElyUGVLNzU5RkM0?=
 =?utf-8?B?aUtwVHE4YWs4a3ptaUwwK3VnaThHbXJkQjVndWorb2x5Y3hYcjI5Ti9vQzJu?=
 =?utf-8?Q?Ge0xPxm31Cq25pl5afqZNJXWL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a14f2d3-03b9-4b80-f4f2-08db8fc7dd2b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 00:07:57.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ep6VKNht+VC8aacuF+RnFP7SFxW+pH+7E2SLqbtwcjb3HIMgaVjppLqTHoWogijc29mPf614he8BdAl5mgp2WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6184
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,BODY_SINGLE_WORD,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SCC_BODY_SINGLE_WORD,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/acessor/accessor

