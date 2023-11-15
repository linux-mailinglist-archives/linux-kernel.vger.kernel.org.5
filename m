Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726D47EC7FF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjKOP66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjKOP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:58:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CA3A2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700063932; x=1731599932;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2+P2J4fVHPmRd2tf5MjqPT2BT6thjPzktYTbs+xBylw=;
  b=VpakIPB+d2KsW1+5t/C7WU9XwOVFgDFLRzfPiuMt3QLa4BiH3NjHWfJz
   Yci6KstsU/WA1t+c2vwgpovnqhvmWw7BePzzFHRxECssej+8asUIBxOg0
   bLwbYOOAHgHXl2A+DF6iN0XLhQHWpAh02tojuCvXby4KGyyROj0gBYTLu
   p9C5lJkONqPf8u1jA0apsKP/83Oal6tGfoyNP6k5JGrNr3Vgevzk/86Bo
   dDIZbMJ0RkN7sBvDoLESrMK1pYmO5AyiAW7sOWrtu1x4dMqn43GFulIsE
   yP7Uc/GRo3iWmPJiZo/gl75wj7oSZePtoexbIA5F/+0zTa1+qvgAGp539
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="381294294"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="381294294"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 07:58:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="6438619"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 07:58:47 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 07:58:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 07:58:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 07:58:46 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 07:58:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/YWO/agNF9P445fO0uB4M/O3lIErcN+B/dDoJI4X9UFP43OeOVOqx8fJNDrH4NSqCtde9awQcaMSe9jEuZn5J8wrhi7JPpIT9UJAiSZFOfxcXo0l8QPJFkTKbf+mDUC9bhPgOY9hbiUqHHPv2HLRbInpXfz9sjJm7Pp/QgEXXByHWCxDyU3KtTLIsKn48m9R6/Y6xmgnHnKs2RiHYoVfQ23RkMR5XMxWREry5cmxV8cJo134Zt7VB1T6YpUlDfxTDF/g8UGYfLhMXVBna0tJXLTApgKCxV9v5WArlKQQQ2fJE5AgFCSKRlOtVvuME4nZmTu6rWBmGomOeIq0twQ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+P2J4fVHPmRd2tf5MjqPT2BT6thjPzktYTbs+xBylw=;
 b=Wcb+a6VJq3gn4Ruv3ZUor6wpbGxVHo43RHw139nafYsk9kSyCp4CIp6tw06qmGyHG1BXwgJ0IIeNhz9KSVPC7+eXSveSCoKxsKVs08HmTguzoBBGR9QUgE/kiPe+he7pXU01JIgSGfAX3Za2ZQK6yJ9rAZm77+sJbKK8MPLsZTiFJUt9skBw6/Y3G1Gl3I56SQEf78T5evp1qmZj2PvSqYbbwiNsSYmFXelBWm9ytj2dkmkswIL157+nfNd6d7nMoP+i/7cc0V7+jtRyqupNmWqb3eYvns5w/p6j+LnyYlvrHKr9XLq7lvCvU+TaFB/lk+062d/8C2xskxDiqKHuNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SA1PR11MB5778.namprd11.prod.outlook.com (2603:10b6:806:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 15:58:37 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57%4]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 15:58:37 +0000
From:   "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To:     "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>
Subject: Re: [Intel-gfx] [char-misc-next 3/4] mei: pxp: re-enable client on
 errors
Thread-Topic: [Intel-gfx] [char-misc-next 3/4] mei: pxp: re-enable client on
 errors
Thread-Index: AQHaFwMFEhJhnau7g0KvfxNFJWcULbB58UMAgAFw3wCAACkFgA==
Date:   Wed, 15 Nov 2023 15:58:37 +0000
Message-ID: <ff8bc1309baae536db19569c6e7a51070503dec1.camel@intel.com>
References: <20231011110157.247552-1-tomas.winkler@intel.com>
         <20231011110157.247552-4-tomas.winkler@intel.com>
         <ZVN9e3BczixJy_1H@intel.com>
         <ade96d9edd8bce1bc63dba4e2f1a92517180d774.camel@intel.com>
         <02377290-cb5f-48ca-afe3-0e59b70a43de@linux.intel.com>
In-Reply-To: <02377290-cb5f-48ca-afe3-0e59b70a43de@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SA1PR11MB5778:EE_
x-ms-office365-filtering-correlation-id: c878b23e-4c6f-4f03-836c-08dbe5f3ba97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jjuyMcxJM6GZDobdU/71hLBS3gvDbvoU4QAHqkPP33M8UXhf2XnDStPSe/HNXfH4hqY/O40vGIvVjvQaeqpBB/hz6scWENF+LsvyBkLV4OTGplgZlPUhAYClgFZNW+vmEdDBesdNkE4Vve6R4qG+EpNIP4OeFnzoNlEAyabRkQ/k3as35HG2EqHgYjeXhJ2JbVZVyJmrbxIWhrFUsnpTidNMw+JJk7u9Ja/i1O6TIxAgpMLhUb6nRtlj52GKrKy3E+tguJaFTVF/X9LoaDDlE07eC+gWe1OH0HgQzmDaPUG2MnNYOFOmELr15is/FoYu3kdEyWYhCE6viT5BfIbu3LGM5qrjQ1rlIhlEIfnvEJcpDcVJg1DT7e5jqWjEA2h/rbAd10lBxuITwhzUYTQb17iABi++U+FawaOrdVVZ2Inws1Pl2snmEXZ8WmlwUpWrbfdLlX0c9g3ZwfVRrwSinYCchPbNUGs7byjx/vqpHU8lHraOlKJTrezkdarue2DEDktIyjzf0ZSjTgxu/vTVksq8CdtoChPP7MPVwrGKZHsU/Awo2FcNl2YZdkkp3XYero9ahfkWRmtJ91GNN09CNwj60Xof1+zifK4wUDP+5o4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(66446008)(966005)(6486002)(54906003)(66946007)(91956017)(66556008)(66476007)(76116006)(316002)(64756008)(478600001)(4326008)(71200400001)(8936002)(8676002)(110136005)(6506007)(6512007)(86362001)(41300700001)(82960400001)(83380400001)(5660300002)(2616005)(4001150100001)(66574015)(36756003)(38100700002)(26005)(53546011)(38070700009)(122000001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0ZVOVpPckppWmtxaWx4aFlwbGFsRjJic1cwSStOU2xoZEo5dDQza1NpTkNk?=
 =?utf-8?B?TENzanEvN3FUU1ArL2VUanplMEc4QVc2ejJGc1pYM3FQTGR3TlJEWHE5TUw4?=
 =?utf-8?B?S0FJT01JN1NJV2ROZUxseHJaU0lMcVRqWEUrcjVOMVVLMnRsUyt1eUYzUXpq?=
 =?utf-8?B?SjNtQXpxaGpJekVEZGZ3T0lFMEJzaGNkc09DR0ZPN1NpOHdWQytPR1lUdW5N?=
 =?utf-8?B?OWZtd1lPSWF0NWhRZGpoKzdraDNjZWxzcnJaUGpXVGEwbDF0TVVDRWx2dnJU?=
 =?utf-8?B?ZE02OHZselhVc2JlK3dCV1BPcmtXTTFoQmZkNXNqUzl4UEJTTmNWbHIxNlVi?=
 =?utf-8?B?RmY0QXl0akkveWZncTk3Qk5FdVNEbDZDMGZnYk51bXd3UkNOdGVWQzRuN2Fu?=
 =?utf-8?B?WGlkbGx4dFgydTBXT3RZdStMY0dzSU1uVy81YUpGdWJDS0ltWEpUZnExWkVG?=
 =?utf-8?B?RGZwMWZKaDYyT1pTZ0lNeVVHSHpnZ1RrV0VMdzVINTJpbWVLMWhrMHlqc2dM?=
 =?utf-8?B?QzhvVzl0aW42ZDdtOVlyYi9kN0Q1bURZRWlWK3NIMW1NTUhBNTFRQzF5Q2R0?=
 =?utf-8?B?Z0hFQ3RvUGxYYkxBc005ajE5cXpKb0ZwaTZKQWpxT0N3Y3V2ZHRhRHlzdHZp?=
 =?utf-8?B?eEJRSGZHMzNYMHg2N0RHOGkzbStReHZwNi9EUnBhaWhndGJWRm1BSTluUWhI?=
 =?utf-8?B?WFl1Umk5TGNWbWZVM0FWVlJESFpublFKWnBQaXBtUWZYUDFCQ09UZmdzaU5I?=
 =?utf-8?B?ZXRWclRqNUhiM1dIUGVIQndyK1AvY1ZCMWd1RlpONXNyN3ZZTWphZndJOGs3?=
 =?utf-8?B?RWtZTndQUTVPNk56S28zQnJSWXREc0tPcUp4YVJyQ0JHaHl3bWR4TnFOTDZq?=
 =?utf-8?B?Ymt2aVpyY0hYQkUyWjhEMlZ2dWVxbmd1SnBaZGpRTCs5UDNRdzVUd25GaHJm?=
 =?utf-8?B?TkFBWlgySE9jRFRoNnRTSU5abFd5MEZpRCtVK2NxaUVocXJxTlRzS1doTEln?=
 =?utf-8?B?VTVCYVNydmlpQnJuV2d0WXpJTVNPQ1dIZSsxNldmRnZ2T1Y1Q0VFUkxjYkcy?=
 =?utf-8?B?ZjQwTnFsR0hsOTVwb0ZMbXU1MWRpVzI1YmNoY2F1T1prZVlVbjZ4YzNiMjJM?=
 =?utf-8?B?V1BtTlppZjR5OU9wOUVtVWNSVTVCYk9rOXZ6cHBOdU1YN0x0L01sa1ZXbEV1?=
 =?utf-8?B?YWZoa1VxYVhYRE9OTFFVRk96ckEvNG5iY25vQzV5REVEL2pVNEFVUDR2Vjc5?=
 =?utf-8?B?TW8wZ2pBcEpTc1lWTU4zUzlxS2d4YkMzaVJ3KzlPR3drKzFTaXVKd1ZIcVJK?=
 =?utf-8?B?dVRubVdBQmVCUTkxVUZEYUtsRVBSaU4xOGV4R3UraW9RWWxnRnJxWW90djhS?=
 =?utf-8?B?d2Y1djVJSVZxekVHZHAzVW9PQll4SFlBeTE1UXY3MUFZVi9SMW13SkNEMnhl?=
 =?utf-8?B?cEtBYUgxZFNjZ1hZWHlpWmh0TFRzcG1kYjUrL0RQSmp3YkNjTDZ1WHVYOXAz?=
 =?utf-8?B?TzNKdkhBd0t6OWdrMGsySUhkVk5FRzBtcWs1ZVZlQVl2WTdaNVNLMk1UTk0x?=
 =?utf-8?B?dGdpVGVGM2RMQlZwQlIrdTg4MGxYZUdpaTZxWEp3KytBYzlLa1JSRWxHVDBJ?=
 =?utf-8?B?dnU1VW5FOGh5ZHo1LzliOEx4bUp0ZWZjRjN2WG5LbW82eTZQS1ZORGtRdXo5?=
 =?utf-8?B?U0ZPZENGSjFiMVlWMWE0ZWVVWkQwL2JCdHh4cVExdXA0OG9PY3BkZndJdW4v?=
 =?utf-8?B?bi9mL0FEOFdQS1g0WThhemFJdTgvaFFMdWxHTmE2QXJWWHM1WHVuN0toWFNX?=
 =?utf-8?B?a0Zlc2RPOENTVUVSN1Y5OFJwcXJ0NGhaN2xOTXI4QTA1ZStyZ3h0RnJxN3ZF?=
 =?utf-8?B?d0lNTlMycEd6ZXQvVEtqaVV5RzJNRzRCTVpiMUplWm5aaVN6a3QwZkVPWm5y?=
 =?utf-8?B?T2dHZUxXMTFURjZTSXBwQ0RucHE5S0Z5N3pCbXlnZmEvNDFPai95L2FlMERk?=
 =?utf-8?B?UXZNSVNEdFNTck5TSVNQNWhnTERHbVVhOWt4RVp4WmU2S0ZzaDhoQWRrckZj?=
 =?utf-8?B?K0tPaXZYdktLVmxqMDYyUW9FQmxVcDU0elVKUW9wOURKREYyREdFL25kN0xN?=
 =?utf-8?B?aUNXN1JjZExycUR4ZGZZWEc1VVM3RHZMYkpTcGhtaWdkeTFvMXBIZ0hKalNJ?=
 =?utf-8?Q?RvXDOJqbA/yHvVEp3BUODeE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0D02D1792B1594FA231BDE85A593902@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c878b23e-4c6f-4f03-836c-08dbe5f3ba97
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 15:58:37.3249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DrXTft01Wydd1pQdQYvmB7EleC8ka3Dfg651WXpo+qj0BwVjkSorRV2UQmjgD9CnL+cfvD3rkDU1ld6rl5FYIRVPDOMXZnMER5omkxjVsDYJERL53nQXJoNiyMXx8dC/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5778
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTExLTE1IGF0IDEzOjMxICswMDAwLCBUdnJ0a28gVXJzdWxpbiB3cm90ZToN
Cj4gT24gMTQvMTEvMjAyMyAxNTozMSwgVGVyZXMgQWxleGlzLCBBbGFuIFByZXZpbiB3cm90ZToN
Cj4gPiBPbiBUdWUsIDIwMjMtMTEtMTQgYXQgMTY6MDAgKzAyMDAsIFZpbGxlIFN5cmrDpGzDpCB3
cm90ZToNCj4gPiA+IE9uIFdlZCwgT2N0IDExLCAyMDIzIGF0IDAyOjAxOjU2UE0gKzAzMDAsIFRv
bWFzIFdpbmtsZXIgd3JvdGU6DQo+ID4gPiANCj4gDQo+IFJlZ2FyZGxlc3Mgb2YgdGhlIG1laV9w
eHBfc2VuZF9tZXNzYWdlIGJlaW5nIHRlbXBvcmFyaWx5IGJyb2tlbiwgZG9lc24ndCANCj4gVmls
bGUncyBsb2dzIHN1Z2dlc3QgdGhlIFBYUCBkZXRlY3Rpb24gaXMgYWx0b2dldGhlciBtZXNzZWQg
dXA/IEFGQUlSIA0KPiB0aGUgcGxhbiB3YXMgZXhhY3RseSB0byBhdm9pZCBzdGFsbHMgZHVyaW5n
IE1lc2EgaW5pdCBhbmQgbmV3IHVhcGkgd2FzIA0KPiBhZGRlZCB0byBhY2hpZXZlIHRoYXQuIEJ1
dCBpdCBkb2Vzbid0IHNlZW0gdG8gYmUgd29ya2luZz8hDQo+IA0KPiBjb21taXQgM2I5MThmNGYw
YzhiNTM0NGFmNDA1OGYxYTEyZTIwMjMzNjNkMDA5Nw0KPiBBdXRob3I6IEFsYW4gUHJldmluIDxh
bGFuLnByZXZpbi50ZXJlcy5hbGV4aXNAaW50ZWwuY29tPg0KPiBEYXRlOiAgIFdlZCBBdWcgMiAx
MToyNTo1MCAyMDIzIC0wNzAwDQo+IA0KPiAgICAgIGRybS9pOTE1L3B4cDogT3B0aW1pemUgR0VU
X1BBUkFNOlBYUF9TVEFUVVMNCj4gDQo+ICAgICAgQWZ0ZXIgcmVjZW50IGRpc2N1c3Npb25zIHdp
dGggTWVzYSBmb2xrcywgaXQgd2FzIHJlcXVlc3RlZA0KPiAgICAgIHRoYXQgd2Ugb3B0aW1pemUg
aTkxNSdzIEdFVF9QQVJBTSBmb3IgdGhlIFBYUF9TVEFUVVMgd2l0aG91dA0KPiAgICAgIGNoYW5n
aW5nIHRoZSBVQVBJIHNwZWMuDQo+IA0KPiAgICAgIEFkZCB0aGVzZSBhZGRpdGlvbmFsIG9wdGlt
aXphdGlvbnM6DQo+ICAgICAgICAgLSBJZiBhbnkgUFhQIGluaXRpYWxpemF0b2luIGZsb3cgZmFp
bGVkLCB0aGVuIGVuc3VyZSB0aGF0DQo+ICAgICAgICAgICB3ZSBjYXRjaCBpdCBzbyB0aGF0IHdl
IGNhbiBjaGFuZ2UgdGhlIHJldHVybmVkIFBYUF9TVEFUVVMNCj4gICAgICAgICAgIGZyb20gIjIi
IChpLmUuICdQWFAgaXMgc3VwcG9ydGVkIGJ1dCBub3QgeWV0IHJlYWR5JykNCj4gICAgICAgICAg
IHRvICItRU5PREVWIi4gVGhpcyB0eXBpY2FsbHkgc2hvdWxkIG5vdCBoYXBwZW4gYW5kIGlmIGl0
DQo+ICAgICAgICAgICBkb2VzLCB3ZSBoYXZlIGEgcGxhdGZvcm0gY29uZmlndXJhdGlvbiBpc3N1
ZS4NCj4gICAgICAgICAtIElmIGEgUFhQIGFyYml0cmF0aW9uIHNlc3Npb24gY3JlYXRpb24gZXZl
bnQgZmFpbGVkDQo+ICAgICAgICAgICBkdWUgdG8gaW5jb3JyZWN0IGZpcm13YXJlIHZlcnNpb24g
b3IgYmxvY2tpbmcgU09DIGZ1c2luZw0KPiAgICAgICAgICAgb3IgYmxvY2tpbmcgQklPUyBjb25m
aWd1cmF0aW9uIChwbGF0Zm9ybSByZWFzb25zIHRoYXQgd29uJ3QNCj4gICAgICAgICAgIGNoYW5n
ZSBpZiB3ZSByZXRyeSksIHRoZW4gcmVmbGVjdCB0aGF0IGJsb2NrYWdlIGJ5IGFsc28NCj4gICAg
ICAgICAgIHJldHVybmluZyAtRU5PREVWIGluIHRoZSBHRVRfUEFSQU06UFhQX1NUQVRVUy4NCj4g
ICAgICAgICAtIEdFVF9QQVJBTTpQWFBfU1RBVFVTIHNob3VsZCBub3Qgd2FpdCBhdCBhbGwgaWYg
UFhQIGlzDQo+ICAgICAgICAgICBzdXBwb3J0ZWQgYnV0IG5vbi1pOTE1IGRlcGVuZGVuY2llcyAo
Y29tcG9uZW50LWRyaXZlciAvDQo+ICAgICAgICAgICBmaXJtd2FyZSkgd2UgYXJlIHN0aWxsIHBl
bmRpbmcgdG8gY29tcGxldGUgdGhlIGluaXQgZmxvd3MuDQo+ICAgICAgICAgICBJbiB0aGlzIGNh
c2UsIGp1c3QgcmV0dXJuICIyIiBpbW1lZGlhdGVseSAoaS5lLiAnUFhQIGlzDQo+ICAgICAgICAg
ICBzdXBwb3J0ZWQgYnV0IG5vdCB5ZXQgcmVhZHknKS4NCj4gDQo+IEFGQUlVIGlzIHRoaW5ncyBm
YWlsZWQgdGhlcmUgc2hvdWxkbid0IGJlIGxvbmcgd2FpdHMsIHJlcGVhdGVkL2NvbnN0YW50IA0K
PiBvbmVzIGV2ZW4gbGVzcyBzby4NCj4gDQphbGFuOiBJIGFncmVlIC0gYnV0IEkgZG9uJ3QgdGhp
bmsgTUVTQSBpcyBkZXRlY3RpbmcgZm9yIFBYUCBmb3IgYWJvdmUgY2FzZS4uLg0Kd2hpY2ggaXMg
ZGVzaWduZWQgdG8gYmUgcXVpY2sgaWYgdXNpbmcgdGhlIEdFVF9QQVJBTSBJT0NUTCAtIGkgYmVs
aWV2ZSBNRVNBDQptYXkgYWN0dWFsbHkgYmUgb3B0aW5nIGluIHRvIGVuZm9yY2UgUFhQLiBXaGVu
IHRoaXMgaGFwcGVucyB3ZSBhcmUgcmVxdWlyZWQNCnRvIGJlIHN0cmluZ2VudCB3aGVuIG1hbmFn
aW5nIHRoZSBwcm90ZWN0ZWQtaHctc2Vzc2lvbnMgYW5kIGZvciBjZXJ0YWluIFBYUA0Kb3BlcmF0
aW9ucyB3ZSByZXRyeSB3aGVuIGEgZmFpbHVyZSBvY2N1cnMgLSBvbmUgaW4gcGFydGljdWxhciBp
cyB0aGUgUFhQIGh3DQpzZXNzaW9uIHRlYXJkb3duIG9yIHJlc2V0LiBXZSBhcmUgZXhwZWN0ZWQg
dG8gcmV0cnkgdXAgdG8gMyB0aW1lcyB0byBlbnN1cmUNCnRoYXQgdGhlIHNlc3Npb24gaXMgcHJv
cGVybHkgdG9ybiBkb3duIChyZXF1aXJlbWVudHMgZnJvbSBhcmNoaXRlY3R1cmUpDQp1bmxlc3Mg
dGhlIGVycm9yIHJldHVybmVkIGZyb20gRlcgaW5kaWNhdGVkIHRoYXQgd2UgZG9udCBoYXZlIHBy
b3BlciBmdXNpbmcgb3INCnNlY3VyaXR5IGFzc2V0cyBpbiB0aGUgcGxhdGZvcm0gKGkuZS4gbG93
ZXIgbGV2ZWwgYXNwZWN0cyBvZiB0aGUgcGxhdGZvcm0gd29uJ3QNCnBlcm1pdCBQWFAgc3VwcG9y
dCkuIEFsbCBvZiB0aGlzIGlzIGFscmVhZHkgY29kZWQuDQoNClNvIHdlIGhhdmUgdHdvIHByb2Js
ZW1zIGhlcmU6DQoNCjEuIFRoZSBjb2RlIGZvciBlbmZvcmNpbmcgUFhQIHdoZW4gUFhQIGlzIGV4
cGxpY2l0bHkgcmVxdWVzdGVkIGJ5IFVNRCBpcw0KZXhwZWN0aW5nIHRoZSBtZWktY29tcG9uZW50
IGRyaXZlciB0byBmb2xsb3cgdGhlIG1laS1jb21wb25lbnQtaW50ZXJmYWNlIHNwZWMNCmJ1dCBh
IGNoYW5nZSB3YXMgaW50cm9kdWNlZCBieSBBbGV4IHRoYXQgY2F1c2VkIGEgYnVnIGluIHRoaXMg
bG93ZXN0IGxheWVyIHNwZWMNCihzZWU6wqBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51
eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvbWlzYy9tZWkvcHhwL21laV9weHAuYyNMMjUpDQoiUmV0
dXJuOiAwIG9uIFN1Y2Nlc3MsIDwwIG9uIEZhaWx1cmUiIGZvciBzZW5kIGFuZCAiUmV0dXJuOiBi
eXRlcyBzZW50IG9uDQpTdWNjZXNzLCA8MCBvbiBGYWlsdXJlIiBmb3IgcmVjZWl2ZSAtIHRoZSBj
aGFuZ2UgdGhleSBtYWRlIHdhcyByZXR1cm5pbmcNCmEgcG9zaXRpdmUgbnVtYmVyIG9uIHNlbmQn
cyBzdWNjZXNzIGFuZCBpOTE1IHdhcyBjaGVja2luZyB0aGUgYWNjb3JkaW5nIHRvIHNwZWM6DQoN
CiAgICAgICAgIHJldCA9IHB4cF9jb21wb25lbnQtPm9wcy0+c2VuZChweHBfY29tcG9uZW50LT50
ZWVfZGV2LCBtc2dfaW4sIG1zZ19pbl9zaXplLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFBYUF9UUkFOU1BPUlRfVElNRU9VVF9NUyk7DQotLS0tLT4gICBpZiAocmV0
KSB7DQogICAgICAgICAgICAgICAgIGRybV9lcnIoJmk5MTUtPmRybSwgIkZhaWxlZCB0byBzZW5k
IFBYUCBURUUgbWVzc2FnZVxuIik7DQogICAgICAgICAgICAgICAgIGdvdG8gdW5sb2NrOw0KICAg
ICAgICAgfQ0KDQogICAgICAgICByZXQgPSBweHBfY29tcG9uZW50LT5vcHMtPnJlY3YocHhwX2Nv
bXBvbmVudC0+dGVlX2RldiwgbXNnX291dCwgbXNnX291dF9tYXhfc2l6ZSwNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQWFBfVFJBTlNQT1JUX1RJTUVPVVRfTVMpOw0K
ICAgICAgICAgaWYgKHJldCA8IDApIHsNCiAgICAgICAgICAgICAgICAgZHJtX2VycigmaTkxNS0+
ZHJtLCAiRmFpbGVkIHRvIHJlY2VpdmUgUFhQIFRFRSBtZXNzYWdlXG4iKTsNCiAgICAgICAgICAg
ICAgICAgZ290byB1bmxvY2s7DQogICAgICAgICB9DQoNClNvIGkgcmVhbGx5IGNhbm5vdCBndWFy
YW50ZWUgYW55dGhpbmcgaWYgdGhlIG1laSBjb2RlIGl0c2VsZiBpcyBicm9rZW4gYW5kIG5vdA0K
Y29tcGx5aW5nIHRvIHRoZSBzcGVjIHdlIGFncmVlZCBvbiAtIGkgY2FuIGNoYW5nZSB0aGUgYWJv
dmUgY2hlY2sgZm9yIHNlbmQNCmZyb20gImlmIChyZXQpIiB0byAiaWYgKHJldCA8IDApIiBidXQg
dGhhdCB3b3VsZCBvbmx5IGJlICJ3b3JraW5nIGFyb3VuZyINCnRoZSBtZWkgYnVnLiBBcyBhIHNp
ZGUgbm90ZSwgd2hlbiB3ZSBiYWlsIG9uIGEgc3VjY2Vzc2Z1bCAic2VuZCIgdGhpbmtpbmcgaXRz
DQphIGZhaWx1cmUsIGFuZCB0cnkgdG8gInNlbmQiIGFnYWluLCBpdCB0cmlnZ2VycyBhbiBsaW5r
IHJlc2V0IGluIHRoZSBtZWktaHcNCmxpbmsgYmVjYXVzZSB0aGUgcmVjZWl2ZSB3YXMgbmV2ZXIg
cGlja2VkIHVwLiBJRiBpIHVuZGVyc3RhbmQgdGhpcyBjb3JyZWN0bHksDQp0aGlzIGlzIGh3LWZ3
IGRlc2lnbiByZXF1aXJlbWVudCwgaS5lLiB0aGF0IHRoZSBzZW5kLXJlY3YgYmUgYW4gYXRvbWlj
IEZTTQ0Kc2VxdWVuY2UuIFRoYXQgc2FpZCwgaWYgdGhlIHRoZSBzZW5kLWZhaWx1cmUgd2FzIGEg
cmVhbCBmYWlsdXJlLCB0aGUgdGltZW91dA0Kd291bGQgaGF2ZSBub3QgYmVlbiBoaXQgYW5kIHRo
ZSByZXRyeSB3b3VsZCBoYXZlIGJlZW4gbXVjaCBmYXN0ZXIuIEFzIGEgc2lkZSBub3RlLA0KQWxl
eCBmcm9tIG1laSB0ZWFtIGRpZCByZXBseSB0byBtZSBvZmZsaW5lIHdpdGggaW5kaWNhdGlvbiB0
aGF0IHRoZSBmaXggd2FzDQpzdXBwb3NlZCB0byBoYXZlIGJlZW4gc2VudCB2aWEgInVyZ2VudCBx
dWV1ZSIgYW5kIGhlIHdpbGwgZm9sbG93IHVwIG9uIHRoYXQuIA0KDQoyLiBJIGRvbnQgYmVsaWV2
ZSBNRVNBIGlzIHVzaW5nIHRoZSBHRVRfUEFSQU0gaW9jdGwgZm9yIGRldGVjdGluZyBQWFAgYXZh
aWxpYmlsaXR5LA0KSSB0aGluayBNRVNBIGlzIGV4cGxpY2l0bHkgb3B0aW5nIGludG8gY3JlYXRp
bmcgUFhQIGNvbnRleHRzLiBUaGF0IHdpbGwgb2YgY291cnNlDQp0cmlnZ2VyIHRoZSB0aGUgYmFj
a2VuZCBQWFAgY29kZSB0aGF0IGFjdHVhbGx5IGV4ZWN1dGVzIGFueSBQWFAgb3BlcmF0aW9uLiBQ
cmV2aW91c2x5DQppbiB0aGUgb2xkZXIgY29kZSBNRVNBIHdhcyBjcmVhdGluZyBQWFAgY29udGV4
dHMgb24gZXZlcnkgY29udGV4dCBjcmVhdGlvbiBqdXN0IHRvDQp0ZXN0IGlmIFBYUCB3YXMgYXZh
aWxhYmxlIHdoaWNoIGlzIG11Y2ggd29yc2UgLSBlc3BlY2lhbGx5IG9uIE1UTCB3aGljaCBjYW4g
dGFrZQ0KbXVjaCBsb25nZXIgZm9yIHRoZSB1bmRlcmx5aW5nIGZpcm13YXJlIHRvIGNvbWUgdXAu
IEkgaGF2ZSBhbiBvbmdvaW5nIGVtYWlsIHRocmVhZA0Kd2l0aCB0aGUgTUVTQSBmb2xrcyB3aGlj
aCBpIHdpbGwgaW5jbHVkZSB5b3Ugb24gdG8gY2xhcmlmeSB0aGlzLg0KDQoNClByb2JsZW0gIzEg
aXMgcmVzb2x2ZWQgYW5kIHRoZSBwYXRjaC1maXggd2lsbCBuZWVkIHRvIGJlIG1lcmdlZC4gQnV0
IFByb2JsZW0gIzIgaXMNCnN0aWxsIGFuIG9wZW4gYmVjYXVzZSBWaWxsZSBzYWlkIGhlIGRpZCBu
b3QgbW9kaWZ5IE1FU0EgdG8gb3B0LWluIHRvIGVuZm9yY2UNCnByb3RlY3RlZCBzZXNzaW9ucyBm
b3IgYWxsIHRoZSBQWFAgY29udGV4dHMuDQoNCi4uLmFsYW4NCg0K
