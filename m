Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141FE7BB507
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjJFKXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjJFKXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:23:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762A1E4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696587779; x=1728123779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6UoK+trP3hABfpYWtammAMcZ8Wa5jsDn7Bj/8dIZpu8=;
  b=KRSP+gcyzY7ac7IxdkzONSGM6sxtlbl7EvD8bNO+YdRZ1Yvf9zI/iHx2
   E8O0emBqtVU+SIaPy5xLY4TUNmKw+l/xR7w0KjcnZ320ABz/La8tURUS2
   JB4Zv3TD67Y2VnfOKF84rlhddB0iqrsZnroSURQjmtFg3IHJdUB7LAdJp
   oQVxN2zL37tx0M/4ckL83QGuWukJ8mGRxCzM7w424D7SW+J1HL3O8PLkP
   3D54xLy6LyQDIkHzYewk3xmb2kTnTKlJ8DORCf1noh68IyqDqQhN5CmCA
   T0Zm4xHQlpZeH3UcxPc+kACFbyd5T+FYf2ubup7tfRoaeK6deb8YDqJh5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="368799448"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="368799448"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:22:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="868293947"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="868293947"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 03:22:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 03:22:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 03:22:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 03:22:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 03:22:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1gjmVuzaqnAE5kTYjI8Bue86/hI5jpb3CHCjwjIMa1+H800Do5G4/gtNESfG789HucEmucCh2oXBcoZ/F1nXZm8Ec1m2KKi/8iCJ7ICjFTSynnAGrZfRB0MCJiqqmlgS8RJB/j10Lb0lF0YzMlu8XaB9rTDFZDoz373gDtOpUkxL5LpHF32kj12xI5N68HEC8wPKvsHn//wAkfUY4JIPRfE0DmtHxNcmzlC6+/7HoFqa1M9eBAGO0AIV4atY6UbrvoBN5Pdyu25vpEwNqL4nt2di0hmdrbZeARA4P9r5N2VNEGp6eVrzT9/KZgIYjDSzKUoy9UiPI+RAP1QYa8xVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UoK+trP3hABfpYWtammAMcZ8Wa5jsDn7Bj/8dIZpu8=;
 b=Rkdpvjl2xX7WVIusBpeOuZYDvbWYmElKr9WnaC/v6reAFMdpCDyCoaph2twGtwEDcHZdLeWcud4ZHiTYu3aB86N1Pm2JLrXLX+5h9RS8PCGzvsptAOjoWWJevh6tVu/nNxbQ4eeNOjNQS5vb3F8XJcrdvExQG3s6Gy0DvB3CfxF81hRwbsI95zuNX0mWH3T1jqjW2714XUy6JDn4rf+Q5AcUKuFVGg7bAN1J5KZYTsgDVPeDxxj9seTqSsYYNPSVUmFKX4C2qM1S4IO4/T+WJLo/4zsghaMIR7rjkITWl4f59Bw0936qmqQ/OOoEZwUa35ai9uwyjitSfjB5P74EzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ2PR11MB8470.namprd11.prod.outlook.com (2603:10b6:a03:56f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 10:22:55 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 10:22:55 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 01/13] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Thread-Topic: [PATCH 01/13] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Thread-Index: AQHZ948jgFv/HBrZr06FJhLv6gJebLA8jvuA
Date:   Fri, 6 Oct 2023 10:22:54 +0000
Message-ID: <e11888bc9775a8083b72cce8c58ee71b39d0e17f.camel@intel.com>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
         <20231005131402.14611-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231005131402.14611-2-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ2PR11MB8470:EE_
x-ms-office365-filtering-correlation-id: e29b4ed0-9459-48a8-45e5-08dbc65633f2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SrvkBZd/ThyLsVK2PiMsW6sh3SP5ee4w6Wj1P7BD5rz8FoFGGjT37/L8iyPV32WgN2abZ5N10mUTwl3BTNNVnLNSekDVb79cs51QbM+f65Q/zyBvXgowj2Tu4SuRZmkBXQsVP1zLcoHiLqS+X0cUyjzAEL8oKDT/C9FX+e0s/FdqPHnzByoLqLcf9AFuw5Hw60OrsC0KMJGG3e/MxLhU2vJb+wvH8ZHCpMzbdIzRkymav3FUO42hFb2zmqn010iijNKUS+FrPvTaAzC8xw2x9R8ilXRbDPXwJrnEEhqXF55bo97q5cqMn0sUrX1EHGOpJ+Sk0UmXZpOuOGsxfaW1+ciFfnmVjJuCjXMI/j2tKnj+/Om6/ChF7Og0faSLZ6XlQRN/0p7OJUPFhhRDRH67vTFXrzUGRzkZDBF8TnX/J1U/3ZBf2zslrtkwpTTFYsISDeOmzy3jtI1s7isRoKMXDqZzoetHO4gEJXTDhCwwf8zhzWv33IQNtzUEPEKWSl4GdM1ePMhyuj9wF+Dk3b6WFvz+3EFUosi+TTLwe07BS1DPVRj0IXucPrKElOzLrnXTzscC4k3i0aEdXXa9S8HNtyimCVvRyUq5f5iEMJUFCp2jJedoerFItCIdmbAYTq9z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6486002)(83380400001)(6506007)(82960400001)(71200400001)(6512007)(2616005)(38100700002)(38070700005)(26005)(110136005)(64756008)(54906003)(316002)(41300700001)(122000001)(478600001)(66946007)(66446008)(66556008)(66476007)(76116006)(91956017)(8936002)(8676002)(5660300002)(7416002)(4326008)(86362001)(36756003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk5CeWIwVVp4NGNySkxEWHRCeGowOVVQbXVmOFE4SFVzaGtPK1ZXSFpaZkpG?=
 =?utf-8?B?SkFFcTd2MTNlbi9tMnlaS3VuRHZlMitCeXN4cGFkTE5EdEdtSnZ4M1pDQWZB?=
 =?utf-8?B?R2NONXVPd0ZIV1VudVl2WG5mUjRxNjNTZ3FuS1h5VGZVRElJTGkrbGlWWDJK?=
 =?utf-8?B?QVJLeCtURnpiVnVQaHFLdDdHSXI4YUMzL0gxVTUrVUlDK2ladkFRVmk2dFU5?=
 =?utf-8?B?cVYxRlRJZVQ0YStSanVrWnJ0K2xqMGNnaWJlc3pWaU10QzAwVWpwZG85aTlm?=
 =?utf-8?B?S2NWV3owU3ZTNzZGQUMyZHZ0dnZDYUdmcFVYUE5EWG50eDdiQUZCaHRJVVBB?=
 =?utf-8?B?Ymw1bmEvMU5SQVh6OW9oTlhqaTZGdC9VeEZTOGFlaUI5U0I1T0NWZ01QU1dl?=
 =?utf-8?B?SzdhcDE3SlZHcmxWU2dxUkZJWTJUZk9OTEZ2SnJwclJCRHQyNGx5eDFnMjVJ?=
 =?utf-8?B?cFFuVTFRK2E0eVR6blZCSS8zbUhDbXVOVExIQVg1WVV1SWo0ZWdndk0zWFpk?=
 =?utf-8?B?NnA3cDZaVUU1VTlQYkd5dGVTQlhmUk1tV2NkK0VjRVk5eDdIZUhMN3hpaTBH?=
 =?utf-8?B?bFM2SG5jTXRVTXV2SXpHcDJacWwyQnRrWGdYcGhBY3BZM09WQXZ4TU1yd2ky?=
 =?utf-8?B?cVZZRkZpSmczVi93QVBGeXFKb1JRNERlM2p1Q2hzR1NzbDdMWGRBQm9vekNZ?=
 =?utf-8?B?bHlhaHJSWjZxSzcyUFBuUllJQTI0cm9sR1pKS2xrTk03QjBDZG9iNHJ0V05C?=
 =?utf-8?B?TVQ4WHF1ZGJKYXo4M1NGUEppUU5NczZlRlN0dkFUVVpSY0t3eGtjVDB4STh1?=
 =?utf-8?B?U0ZOVFh6ekFBcHZseHE1RTlleFFoaWJJZmZLMUZIeXNLc2lGVUNpcW9FV1dh?=
 =?utf-8?B?Z0s1ODhlWG1LUzk3eUZDMVdKQXJSTGp2Yk5oV2txNXVLdkhXYXVuQWpGWFEy?=
 =?utf-8?B?NVdIQWRSb25kc3NMb0xtc2IwbHFDME5EOEFWdTJaeW92dUZ6NzIxODBiNlVm?=
 =?utf-8?B?OUdlWkJkUUUxcmY3VjJKdzZiV1pPYWlMQ1RLQXp0Yi9iaXhIdE10SXlQazc3?=
 =?utf-8?B?dWtCNyt3VTRyM0FnbGd2bHJSOXpWREhoL2V0cVJ6RTFhdnN0QUd2Z1d3ZHlD?=
 =?utf-8?B?ekpGNlRVRHdZRG85VUQ0SWNHY3ZBeWUxempyUU5Lc202UFJhcDhyNGo5dXpG?=
 =?utf-8?B?UUNKU3FORGt4VVpiYUYxeDNYd0ZmRkZnYzBQbWxTRGRUUnNuZFFHR0RWQXVs?=
 =?utf-8?B?OC9vRlJrRmFaSjJCNXFORWxSRWhWTlVHenVCbmpwVEVxVWtFbmhIRWFzekEy?=
 =?utf-8?B?aHRRcTkrOXdrd2VjNG5XUUYrSmRoZFh5anNnSnFvSUU2L1JtaGZnb1BaTGE1?=
 =?utf-8?B?c3l3ZGtVNFk1QXE5Vlc2MzA5RjZVWktLcUNKb2oxdG44Q3RtN1NUSUxqbzQx?=
 =?utf-8?B?by9tTEo4dnpvUGgyejZNeHNZQS93T290cU4xSytBb3ZkRnYzMVAwV2kyaGhm?=
 =?utf-8?B?Skw5OGVBMVR3RnpMb01jYkR6OERxUWVFb0hEdnV0Z2JLZ0VQbENCbm9OR0xQ?=
 =?utf-8?B?V1BISjVoSE1zUE1id0luWmxFMHhTaVNwVTFIVSs4NVNXWStlRy82cU9HaHJB?=
 =?utf-8?B?c0gxeFRTdFpGMDcrK3VCaFd3SE5IYW1lNGhZdmZxck45VHB4ODVKT1lpZFRY?=
 =?utf-8?B?bnFZbGJTcFZzYmswV2JhL3dCRnVCaVJTUTJuZTRrR0dLOHdTSGd1Z2gxaUNR?=
 =?utf-8?B?b3FZeWNsMVNldkJwRUJRQnBUOGE3UGc3NmFGVXV3RTBvMlBzMWtXNGhUYWhw?=
 =?utf-8?B?cTdrTGpuRWVicTE2NUVXNTdyL2FRd2lid2k4dG4veFRhaVZOYlp1WmU3ODc2?=
 =?utf-8?B?RkcwSGF0Wmh2UGxRak5wcUV1QThLQk82YUtFcTdrM3lHUWNQQVJyeG40VGFF?=
 =?utf-8?B?SEg2Z2pxZmhRcmNacHJkZHlteThIRkp2c2U2d21BcXhWaVlOWjl6TkJMd3Fu?=
 =?utf-8?B?YXBNNzBnV29reERtbXc1TXlpak1COFl3dytyeHlvWnZ5MGdYbkF1Z2JCdUNE?=
 =?utf-8?B?cEt4WG96YXJ2TGRYY1A0ZG5oWTlyeDFRYzFod29CVXNPaEtjMU5vRkdKazRD?=
 =?utf-8?B?MUhzbUxXNFQwamNHVzFrL1ZZVUdmQi9VVEkyREl0Q3ZkeXd3Rk9TL2xuMFNJ?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BF32015AA84A54F9517C094FB54CC71@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29b4ed0-9459-48a8-45e5-08dbc65633f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 10:22:54.3522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OJd9ARo0L6ma/uC8zz68oegVitvZBmPHwS4DKD3sBiH5IoXpBxPSKj5w0FRMYSfagoHHVZMgm02yDE3efC0M2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8470
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTA1IGF0IDE2OjEzICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IEluIG9yZGVyIHRvIHByZXBhcmUgZm9yIHRoZSBleHBhbnNpb24gb2Ygc3VwcG9ydCBm
b3IgdGhlIEFDUEkgTUFEVA0KPiB3YWtldXAgbWV0aG9kLCB0aGUgcmVsZXZhbnQgY29kZSBoYXMg
YmVlbiBtb3ZlZCBpbnRvIGEgc2VwYXJhdGUgZmlsZS4NCj4gQSBuZXcgY29uZmlndXJhdGlvbiBv
cHRpb24gaGFzIGJlZW4gaW50cm9kdWNlZCB0byBjbGVhcmx5IGluZGljYXRlDQo+IGRlcGVuZGVu
Y2llcyB3aXRob3V0IHRoZSB1c2Ugb2YgaWZkZWZzLg0KDQpVc2UgaW1wZXJhdGl2ZSBtb29kPyDC
oA0KDQotIE1vdmUgdGhlIHJlbGV2YW50IGNvZGUgaW50byAuLi4NCi0gSW50cm9kdWNlIGEgbmV3
IGNvbmZpZ3VyYXRpb24gb3B0aW9uIHRvIC4uLg0KIA0KPiANCj4gVGhlcmUgaGF2ZSBiZWVuIG5v
IGZ1bmN0aW9uYWwgY2hhbmdlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0
ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3g4
Ni9LY29uZmlnICAgICAgICAgICAgICAgICAgIHwgIDcgKysrDQo+ICBhcmNoL3g4Ni9pbmNsdWRl
L2FzbS9hY3BpLmggICAgICAgIHwgIDUgKysNCj4gIGFyY2gveDg2L2tlcm5lbC9hY3BpL01ha2Vm
aWxlICAgICAgfCAxMSArKy0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwvYWNwaS9ib290LmMgICAgICAg
IHwgODYgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwv
YWNwaS9tYWR0X3dha2V1cC5jIHwgODAgKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICA1
IGZpbGVzIGNoYW5nZWQsIDk5IGluc2VydGlvbnMoKyksIDkwIGRlbGV0aW9ucygtKQ0KPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGFyY2gveDg2L2tlcm5lbC9hY3BpL21hZHRfd2FrZXVwLmMNCj4gDQo+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9LY29uZmlnIGIvYXJjaC94ODYvS2NvbmZpZw0KPiBpbmRl
eCAzMTU0ZGJjNDljZjUuLjczNjhkMjU0ZDAxZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvS2Nv
bmZpZw0KPiArKysgYi9hcmNoL3g4Ni9LY29uZmlnDQo+IEBAIC0xMTA4LDYgKzExMDgsMTMgQEAg
Y29uZmlnIFg4Nl9MT0NBTF9BUElDDQo+ICAJZGVwZW5kcyBvbiBYODZfNjQgfHwgU01QIHx8IFg4
Nl8zMl9OT05fU1RBTkRBUkQgfHwgWDg2X1VQX0FQSUMgfHwgUENJX01TSQ0KPiAgCXNlbGVjdCBJ
UlFfRE9NQUlOX0hJRVJBUkNIWQ0KPiAgDQo+ICtjb25maWcgWDg2X0FDUElfTUFEVF9XQUtFVVAN
Cj4gKwlkZWZfYm9vbCB5DQo+ICsJZGVwZW5kcyBvbiBYODZfNjQNCj4gKwlkZXBlbmRzIG9uIEFD
UEkNCj4gKwlkZXBlbmRzIG9uIFNNUA0KPiArCWRlcGVuZHMgb24gWDg2X0xPQ0FMX0FQSUMNCj4g
Kw0KPiAgY29uZmlnIFg4Nl9JT19BUElDDQo+ICAJZGVmX2Jvb2wgeQ0KPiAgCWRlcGVuZHMgb24g
WDg2X0xPQ0FMX0FQSUMgfHwgWDg2X1VQX0lPQVBJQw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
aW5jbHVkZS9hc20vYWNwaS5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vYWNwaS5oDQo+IGluZGV4
IGM4YTdmYzIzZjYzYy4uYjUzNmI1YTZhNTdiIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9hY3BpLmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vYWNwaS5oDQo+IEBA
IC03Myw2ICs3MywxMSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgYWNwaV9za2lwX3NldF93YWtldXBf
YWRkcmVzcyh2b2lkKQ0KPiAgDQo+ICAjZGVmaW5lIGFjcGlfc2tpcF9zZXRfd2FrZXVwX2FkZHJl
c3MgYWNwaV9za2lwX3NldF93YWtldXBfYWRkcmVzcw0KPiAgDQo+ICt1bmlvbiBhY3BpX3N1YnRh
YmxlX2hlYWRlcnM7DQo+ICsNCj4gK2ludCBfX2luaXQgYWNwaV9wYXJzZV9tcF93YWtlKHVuaW9u
IGFjcGlfc3VidGFibGVfaGVhZGVycyAqaGVhZGVyLA0KPiArCQkJICAgICAgY29uc3QgdW5zaWdu
ZWQgbG9uZyBlbmQpOw0KPiArDQo+ICAvKg0KPiAgICogQ2hlY2sgaWYgdGhlIENQVSBjYW4gaGFu
ZGxlIEMyIGFuZCBkZWVwZXINCj4gICAqLw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVs
L2FjcGkvTWFrZWZpbGUgYi9hcmNoL3g4Ni9rZXJuZWwvYWNwaS9NYWtlZmlsZQ0KPiBpbmRleCBm
YzE3YjNmMTM2ZmUuLjhjNzMyOWM4OGE3NSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVs
L2FjcGkvTWFrZWZpbGUNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2FjcGkvTWFrZWZpbGUNCj4g
QEAgLTEsMTEgKzEsMTIgQEANCj4gICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAN
Cj4gIA0KPiAtb2JqLSQoQ09ORklHX0FDUEkpCQkrPSBib290Lm8NCj4gLW9iai0kKENPTkZJR19B
Q1BJX1NMRUVQKQkrPSBzbGVlcC5vIHdha2V1cF8kKEJJVFMpLm8NCj4gLW9iai0kKENPTkZJR19B
Q1BJX0FQRUkpCQkrPSBhcGVpLm8NCj4gLW9iai0kKENPTkZJR19BQ1BJX0NQUENfTElCKQkrPSBj
cHBjLm8NCj4gK29iai0kKENPTkZJR19BQ1BJKQkJCSs9IGJvb3Qubw0KPiArb2JqLSQoQ09ORklH
X0FDUElfU0xFRVApCQkrPSBzbGVlcC5vIHdha2V1cF8kKEJJVFMpLm8NCj4gK29iai0kKENPTkZJ
R19BQ1BJX0FQRUkpCQkJKz0gYXBlaS5vDQo+ICtvYmotJChDT05GSUdfQUNQSV9DUFBDX0xJQikJ
CSs9IGNwcGMubw0KPiArb2JqLSQoQ09ORklHX1g4Nl9BQ1BJX01BRFRfV0FLRVVQKQkrPSBtYWR0
X3dha2V1cC5vDQo+ICANCj4gIGlmbmVxICgkKENPTkZJR19BQ1BJX1BST0NFU1NPUiksKQ0KPiAt
b2JqLXkJCQkJKz0gY3N0YXRlLm8NCj4gK29iai15CQkJCQkrPSBjc3RhdGUubw0KPiAgZW5kaWYN
Cg0KdW5pbnRlbmRlZCBjb2RlIGNoYW5nZT8NCg0KWy4uLl0NCg0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2tlcm5lbC9hY3BpL21hZHRfd2FrZXVwLmMgYi9hcmNoL3g4Ni9rZXJuZWwvYWNw
aS9tYWR0X3dha2V1cC5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAw
MDAwMC4uMWI5NzQ3YmZkNWI5DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvYXJjaC94ODYva2Vy
bmVsL2FjcGkvbWFkdF93YWtldXAuYw0KPiBAQCAtMCwwICsxLDgwIEBADQo+ICsjaW5jbHVkZSA8
bGludXgvYWNwaS5oPg0KPiArI2luY2x1ZGUgPGFzbS9hcGljLmg+DQoNCkZ1bmN0aW9ucyBsaWtl
IG1lbXJlbWFwKCksIHNtcF9zdG9yZV9yZWxlYXNlKCkgYW5kIGNwdV9yZWxheCgpIGFyZSB1c2Vk
IGluIHRoaXMNCmZpbGUuICBTaG91bGQgd2UgZXhwbGljaXRseSBpbmNsdWRlIHRoZSByZWxldmFu
dCBoZWFkZXJzPw0KDQo+ICsNCj4gKy8qIFBoeXNpY2FsIGFkZHJlc3Mgb2YgdGhlIE11bHRpcHJv
Y2Vzc29yIFdha2V1cCBTdHJ1Y3R1cmUgbWFpbGJveCAqLw0KPiArc3RhdGljIHU2NCBhY3BpX21w
X3dha2VfbWFpbGJveF9wYWRkcjsNCj4gKy8qIFZpcnR1YWwgYWRkcmVzcyBvZiB0aGUgTXVsdGlw
cm9jZXNzb3IgV2FrZXVwIFN0cnVjdHVyZSBtYWlsYm94ICovDQo+ICtzdGF0aWMgc3RydWN0IGFj
cGlfbWFkdF9tdWx0aXByb2Nfd2FrZXVwX21haWxib3ggKmFjcGlfbXBfd2FrZV9tYWlsYm94Ow0K
PiArDQo+ICtzdGF0aWMgaW50IGFjcGlfd2FrZXVwX2NwdShpbnQgYXBpY2lkLCB1bnNpZ25lZCBs
b25nIHN0YXJ0X2lwKQ0KPiArew0KPiArCS8qDQo+ICsJICogUmVtYXAgbWFpbGJveCBtZW1vcnkg
b25seSBmb3IgdGhlIGZpcnN0IGNhbGwgdG8gYWNwaV93YWtldXBfY3B1KCkuDQo+ICsJICoNCj4g
KwkgKiBXYWtldXAgb2Ygc2Vjb25kYXJ5IENQVXMgaXMgZnVsbHkgc2VyaWFsaXplZCBpbiB0aGUg
Y29yZSBjb2RlLg0KPiArCSAqIE5vIG5lZWQgdG8gcHJvdGVjdCBhY3BpX21wX3dha2VfbWFpbGJv
eCBmcm9tIGNvbmN1cnJlbnQgYWNjZXNzZXMuDQo+ICsJICovDQo+ICsJaWYgKCFhY3BpX21wX3dh
a2VfbWFpbGJveCkgew0KPiArCQlhY3BpX21wX3dha2VfbWFpbGJveCA9IG1lbXJlbWFwKGFjcGlf
bXBfd2FrZV9tYWlsYm94X3BhZGRyLA0KPiArCQkJCQkJc2l6ZW9mKCphY3BpX21wX3dha2VfbWFp
bGJveCksDQo+ICsJCQkJCQlNRU1SRU1BUF9XQik7DQo+ICsJfQ0KPiArDQo+ICsJLyoNCj4gKwkg
KiBNYWlsYm94IG1lbW9yeSBpcyBzaGFyZWQgYmV0d2VlbiB0aGUgZmlybXdhcmUgYW5kIE9TLiBG
aXJtd2FyZSB3aWxsDQo+ICsJICogbGlzdGVuIG9uIG1haWxib3ggY29tbWFuZCBhZGRyZXNzLCBh
bmQgb25jZSBpdCByZWNlaXZlcyB0aGUgd2FrZXVwDQo+ICsJICogY29tbWFuZCwgdGhlIENQVSBh
c3NvY2lhdGVkIHdpdGggdGhlIGdpdmVuIGFwaWNpZCB3aWxsIGJlIGJvb3RlZC4NCj4gKwkgKg0K
PiArCSAqIFRoZSB2YWx1ZSBvZiAnYXBpY19pZCcgYW5kICd3YWtldXBfdmVjdG9yJyBtdXN0IGJl
IHZpc2libGUgdG8gdGhlDQo+ICsJICogZmlybXdhcmUgYmVmb3JlIHRoZSB3YWtldXAgY29tbWFu
ZCBpcyB2aXNpYmxlLiAgc21wX3N0b3JlX3JlbGVhc2UoKQ0KPiArCSAqIGVuc3VyZXMgb3JkZXJp
bmcgYW5kIHZpc2liaWxpdHkuDQo+ICsJICovDQo+ICsJYWNwaV9tcF93YWtlX21haWxib3gtPmFw
aWNfaWQJICAgID0gYXBpY2lkOw0KPiArCWFjcGlfbXBfd2FrZV9tYWlsYm94LT53YWtldXBfdmVj
dG9yID0gc3RhcnRfaXA7DQo+ICsJc21wX3N0b3JlX3JlbGVhc2UoJmFjcGlfbXBfd2FrZV9tYWls
Ym94LT5jb21tYW5kLA0KPiArCQkJICBBQ1BJX01QX1dBS0VfQ09NTUFORF9XQUtFVVApOw0KPiAr
DQo+ICsJLyoNCj4gKwkgKiBXYWl0IGZvciB0aGUgQ1BVIHRvIHdha2UgdXAuDQo+ICsJICoNCj4g
KwkgKiBUaGUgQ1BVIGJlaW5nIHdva2VuIHVwIGlzIGVzc2VudGlhbGx5IGluIGEgc3BpbiBsb29w
IHdhaXRpbmcgdG8gYmUNCj4gKwkgKiB3b2tlbiB1cC4gSXQgc2hvdWxkIG5vdCB0YWtlIGxvbmcg
Zm9yIGl0IHdha2UgdXAgYW5kIGFja25vd2xlZGdlIGJ5DQo+ICsJICogemVyb2luZyBvdXQgLT5j
b21tYW5kLg0KPiArCSAqDQo+ICsJICogQUNQSSBzcGVjaWZpY2F0aW9uIGRvZXNuJ3QgcHJvdmlk
ZSBhbnkgZ3VpZGFuY2Ugb24gaG93IGxvbmcga2VybmVsDQo+ICsJICogaGFzIHRvIHdhaXQgZm9y
IGEgd2FrZSB1cCBhY2tub3dsZWRnZW1lbnQuIEl0IGFsc28gZG9lc24ndCBwcm92aWRlDQo+ICsJ
ICogYSB3YXkgdG8gY2FuY2VsIGEgd2FrZSB1cCByZXF1ZXN0IGlmIGl0IHRha2VzIHRvbyBsb25n
Lg0KPiArCSAqDQo+ICsJICogSW4gVERYIGVudmlyb25tZW50LCB0aGUgVk1NIGhhcyBjb250cm9s
IG92ZXIgaG93IGxvbmcgaXQgdGFrZXMgdG8NCj4gKwkgKiB3YWtlIHVwIHNlY29uZGFyeS4gSXQg
Y2FuIHBvc3Rwb25lIHNjaGVkdWxpbmcgc2Vjb25kYXJ5IHZDUFUNCj4gKwkgKiBpbmRlZmluaXRl
bHkuIEdpdmluZyB1cCBvbiB3YWtlIHVwIHJlcXVlc3QgYW5kIHJlcG9ydGluZyBlcnJvciBvcGVu
cw0KPiArCSAqIHBvc3NpYmxlIGF0dGFjayB2ZWN0b3IgZm9yIFZNTTogaXQgY2FuIHdha2UgdXAg
YSBzZWNvbmRhcnkgQ1BVIHdoZW4NCj4gKwkgKiBrZXJuZWwgZG9lc24ndCBleHBlY3QgaXQuIFdh
aXQgdW50aWwgcG9zaXRpdmUgcmVzdWx0IG9mIHRoZSB3YWtlIHVwDQo+ICsJICogcmVxdWVzdC4N
Cj4gKwkgKi8NCj4gKwl3aGlsZSAoUkVBRF9PTkNFKGFjcGlfbXBfd2FrZV9tYWlsYm94LT5jb21t
YW5kKSkNCj4gKwkJY3B1X3JlbGF4KCk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0K
PiAraW50IF9faW5pdCBhY3BpX3BhcnNlX21wX3dha2UodW5pb24gYWNwaV9zdWJ0YWJsZV9oZWFk
ZXJzICpoZWFkZXIsDQo+ICsJCQkgICAgICBjb25zdCB1bnNpZ25lZCBsb25nIGVuZCkNCj4gK3sN
Cj4gKwlzdHJ1Y3QgYWNwaV9tYWR0X211bHRpcHJvY193YWtldXAgKm1wX3dha2U7DQo+ICsNCj4g
KwlpZiAoIUlTX0VOQUJMRUQoQ09ORklHX1NNUCkpDQo+ICsJCXJldHVybiAtRU5PREVWOw0KDQpO
b3cgeW91IGhhdmUgbWFkZSBYODZfQUNQSV9NQURUX1dBS0VVUCBkZXBlbmQgb24gU01QLCBhbmQg
dGhpcyBmaWxlIHdpbGwgb25seSBiZQ0KY29tcGlsZWQgd2hlbiAgWDg2X0FDUElfTUFEVF9XQUtF
VVAgaXMgdHVybmVkIG9uLiAgSUlVQyB0aGlzIGVzc2VudGlhbGx5IG1lYW5zDQpJU19FTkFCTEVE
KENPTkZJR19TTVApIHdpbGwgYWx3YXlzIHJlcG9ydCB0cnVlPw0KDQo+ICsNCj4gKwltcF93YWtl
ID0gKHN0cnVjdCBhY3BpX21hZHRfbXVsdGlwcm9jX3dha2V1cCAqKWhlYWRlcjsNCj4gKwlpZiAo
QkFEX01BRFRfRU5UUlkobXBfd2FrZSwgZW5kKSkNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsN
Cj4gKwlhY3BpX3RhYmxlX3ByaW50X21hZHRfZW50cnkoJmhlYWRlci0+Y29tbW9uKTsNCj4gKw0K
PiArCWFjcGlfbXBfd2FrZV9tYWlsYm94X3BhZGRyID0gbXBfd2FrZS0+YmFzZV9hZGRyZXNzOw0K
PiArDQo+ICsJYXBpY191cGRhdGVfY2FsbGJhY2sod2FrZXVwX3NlY29uZGFyeV9jcHVfNjQsIGFj
cGlfd2FrZXVwX2NwdSk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCg0K
