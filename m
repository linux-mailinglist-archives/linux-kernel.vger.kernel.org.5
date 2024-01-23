Return-Path: <linux-kernel+bounces-35916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C46E98398C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27CF5B23F18
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC38A85C74;
	Tue, 23 Jan 2024 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISiF8abp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDDB81AB4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035689; cv=fail; b=SDgavi9fgGkjegxzA6YnwnHoe1zyCx3Ev4rQPchgvulsxwwkoK+5hz/tHKrXUC10u4ADxpMHHhIUShNhBr/C4iPrK2RW2Z5TFnx0aDXswmX/5n3jr+xIyh9Ak2wZp3xBic4aUdDu1WNFPQKMFiX3/1hTH0bp/hQLa/sgWxBmAc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035689; c=relaxed/simple;
	bh=K3lugz5OxX4EzeB2ZN2CyEt2WYmOaSIXuNCmm0D1Kio=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h365soGqyACdQDdVQB2K3bhFbU0cb1Yb06JT8ZzGx2M6afHu0x3o2xMt4g+fvI8Bdl9Z90N4sMkoHS/MvROY5eVEjwb7ON7o2PQymTROshWNnQFA5i9Q3p9WjnAdTeJD0BjIBT5QzFoj2eqvNY96V+v25Tto6rCmUEFWEio5m70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISiF8abp; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706035688; x=1737571688;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K3lugz5OxX4EzeB2ZN2CyEt2WYmOaSIXuNCmm0D1Kio=;
  b=ISiF8abpNyTSqPJfSPfz79YzJq6M9hlUPMjseE77xjxXY5Arb0XMuuyg
   pHu6Or6W6naYvpmoSQg/+TKXCHVFl48DC1CZdiUWOiFN/fXW+sTUAmNaW
   I0nDa1ZRYy1b+EhWXu7IGPhyl6WWPqJC8O60O8K8AouluSW7FRCB6PC2A
   Rgq6vBf6kTqxSYeKXtKEZsYftB+D0j1r/8dP0C8FrhmPIyRegTZW1pbPR
   7ZNIcOeSPyebsrtmxCyuP2tzWC82w1+jwIm2TdbJMignVCouvGm/svyfu
   38qkhThUqzk7QEeeDc3rRt/N/P/J9F8SDmhG48OaXY0ySM0DlL0Sg4oOv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1501031"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1501031"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:48:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820198155"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="820198155"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2024 10:48:07 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 10:48:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 10:48:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 10:48:06 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 10:48:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/R3LGC7Dqe5g3lvP7MdjgcpKPUEQz2SiLYYA1DOJuHtoZiTu3k89rZcTaP11gtps/eVlnW1IDBR2qDKF5M15igw9FW4HmzE+2Rva9oI+zzmpt3C3sJ5Pwt9j5VIPCby7sTTtDPnh0oegQY4cK4BrzSAFLENhQ5zOzY7cHh1+ECAP2FBQnreE/4SR0Lycoh0SW3kFu2ZN1uHUn3Dv+3O5xXZIcDmjGq9HNeFDKNiyBeTbTU8yLJhEDcmMPNTHuZualfBP/lkREjoQydUdopQJwN3nHHZJEJkuQ6m1MBZKreN1X2UbpVkjHpBt8fkiut8WMQHuIa0pFzFBx72lxAwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6iKf7yQZH4UWrfwohC7pMx5u8CZSsiLA23fu+y2VL0=;
 b=YbSVejI+dgen4Gpl4rKaRMH5PVIj/CXWd6PgIaurMHt5IESsBIRw/83rls6rzDP9mtw5UAehcYgRppieHFGiFTLo6HceeAQHmv3nQyZ687jk4WEvxCOaWW3kFYiTvc197vnt2uuf1jfPElpZHo0U8MirZGc/Fjm06FO5SSlA9TMVvWCOPqH37lHKsBI3CRSLgEQR0CCxiL7ihOAnb70zi2uaa7yxiyl3EzKg1K4y0pu3GETRIsf74U43dnu9bUzJb6N9CkAmKvrdanqA9MeFCvWaByApIun8C2n8xI3juhL9ZIW9CMhV5072/DPlp/blzeshpVKMI2tnu7dbF7bqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 MW4PR11MB7128.namprd11.prod.outlook.com (2603:10b6:303:22b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Tue, 23 Jan 2024 18:48:03 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::52c6:33d7:27be:28c5]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::52c6:33d7:27be:28c5%4]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 18:48:03 +0000
Message-ID: <14dffda2-f413-4304-9932-3ac8ddfb30e4@intel.com>
Date: Tue, 23 Jan 2024 10:48:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
To: Dan Williams <dan.j.williams@intel.com>, "Yao, Jiewen"
	<jiewen.yao@intel.com>, Qinkun Bao <qinkun@google.com>, Samuel Ortiz
	<sameo@rivosinc.com>, "Lu, Ken" <ken.lu@intel.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240114223532.290550-4-sameo@rivosinc.com>
 <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com>
 <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
 <5539c533-37b2-4b12-a5c5-056881cf8e3c@linux.intel.com>
 <Za1G9I+tYuIL9ser@vermeer> <CF3D8DE1-AD47-4A77-B8BD-8A12A6F7E9DB@google.com>
 <MW4PR11MB5872F46A2089C8C2D8EF7A008C752@MW4PR11MB5872.namprd11.prod.outlook.com>
 <65aecbbce09dd_107423294b7@dwillia2-xfh.jf.intel.com.notmuch>
 <c3b99264-233b-4997-9e20-c4c2693b8cdc@intel.com>
 <65aeecea827f0_37ad2948@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <65aeecea827f0_37ad2948@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:303:2a::25) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|MW4PR11MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8227cc-4381-4ee5-eca8-08dc1c43d440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/HqZhley37my7xngbn6eUPLW7p8/p0T2FzAPa1ExUVu5c8tMEFRuPOKPNaIsvERtmk4kaGZxhOjZbXPBXiHs+N0ZKeBH1yQ4Be11ayeJXZ7TtH0S6kOVbHpxmrTboogNOeBl2Ci9Ih2quroFvb2C+t0gIdxj9y49vhpl3LFmWadXhH43U9fgDuoP46krQg4ud6x0vmMU7m/VeWCL6JO99JzS8XPSJ9Kqau+GrnJcmX36XvJaCEUZgf3wlQidXxAVImBTCuFByntU1uqIOb3sHzYGn2CrY8zrJbkcCFBkW5+TMPlsP8vAVhqvXgbKOCvf2RDvLeOeIMFJUwDOCIUyxpKgO781d0lqCI6RhbEVKkvb6EnAQwvevJ01fUUbYuepye1rdIPFCTdQF6Y1UniV2rc9mcPlzB/1Ox5jMzCFn4Zrg21ibie5zoTT1hk9VPQycI5PydqEr5i2lpRVTpUgRnBmvEUDnmevhvlKbobqWwpIwBXyBGWzUFXSPcbZUUMQYmQb4tPR7p6GFyIuxP76Q7HfH4NGfadWISorrNR+o9CPdsezvCsolUQ2f+D+dPYt8Wr3gRLT42WIfVi/BMFzFk9FxF/SiSJUZZtBBw4FK77vej+xmhQhHAqnIBhYxslUUb2uI9O5bY7W4YWDINcMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(31686004)(6512007)(6506007)(53546011)(2616005)(26005)(6636002)(86362001)(31696002)(38100700002)(82960400001)(36756003)(41300700001)(316002)(5660300002)(8936002)(4326008)(8676002)(66556008)(2906002)(54906003)(6486002)(66946007)(66476007)(110136005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1BPRlRVMmhWcE5YeSt2RzZCY0ltbjN1bzFDUnViNEhhZDlJaWcyUmxvakpL?=
 =?utf-8?B?VWZOZFhVdGcwMFN1MzFNQlllTVJ1SmIyek55UnJSRnQvak9GM2tRUHZMeFp2?=
 =?utf-8?B?eEVVYUc3V2Q0SDZRcEROWUh3STF0ZTFYRTlxd01jaVQ1NWIzQmNlQVRZcUdy?=
 =?utf-8?B?TmtROUY5OFQ4UzRoSkJ6Z21Uazg0L1JuWjY1bXpRTDkxeG9aNVJscjk1Vi96?=
 =?utf-8?B?N2tPS0xoU24yUXk1YWR6MXNmRG5PZ3ByaVZzbDA4MVBpaW5tOU9kK0wrU3Jy?=
 =?utf-8?B?ZlhNcWJPdklmTVEzU0hXdG5QNWVaSmFZWGNWM0dmcU9wRXFDaHhpYWNKekxF?=
 =?utf-8?B?YzNweSs2eDlvRmFzSmwwTkhrZG5JckpLU0F6NlFhZkxmeDdiVVlqT2pWUlZY?=
 =?utf-8?B?ZndyQVBEaXN5cTRWblNlZTFuejRTeWVnLzlYTmJ2S20yT3VHV1ZLRFV5SjRU?=
 =?utf-8?B?UmpmK294NmsxRENHTGhHYVBZczRqTUg4ZzR5WEZEdDNMK2JJNHRpN2ZUK1I1?=
 =?utf-8?B?ZCtIMkR1cWE2dDBreDgzYUFWUmhqak1aOExhM1BmUmhwb3RJUllZN1NidXcr?=
 =?utf-8?B?a3RzVWorSmdBZ01UTlg4d1FjVFd4K3YvNVJrYUV2SGtzZTNxMHExOUpRcDQr?=
 =?utf-8?B?MUF0OG14YVk4a3c0TklXcGtpKzlkWkF1VCtkMDZ3TDdtVjN0T1ovd3BlOEVW?=
 =?utf-8?B?VVA0d09ETDBBYUFjNGRES0ZaZDd0bmNJaEJnUGlWTkxXeUcvUnlBYlJERjNl?=
 =?utf-8?B?VFdWRFoyblBHMVlxdHJyV0JQRVRLcmlnYjR5UnBVUEpwWElqdTJ2cjBrVlJz?=
 =?utf-8?B?T1p6OXR3QXBCNkhQQS9uVE43TldYZGpxajRWTGVtTGlncndOdUZaN2tQb2ND?=
 =?utf-8?B?MUlTb1kwdWdmNkQrZE15cHhDNUFjYkdab0NpOXUvL05qRFdQa1RpMWpaVUt5?=
 =?utf-8?B?QUVET3BKNjJGUXkvdWJEai9McTVjalpnWkREbWRYTnhvakZRaFVtaUQ4dDVP?=
 =?utf-8?B?TXlzUENOMHh1dHR5NXgzcUMxYUVWYVJtSCszcWtRVGY1b090bkM5TDNiK1pL?=
 =?utf-8?B?NnVWQm9za3JxcFRXcFF4Tk1XRXJuS2M3MFhnTTBsc1hLMEx0bGYwdzczdysy?=
 =?utf-8?B?OTUrYU5FZWNFaFR6NXE1bVVZK0dwdlZsbnpHeTFHeld5RGhLb2ZzMHZnVXpY?=
 =?utf-8?B?TzdRMU5ZUjF4Szl0azhGRDgwK0xTSDBQQ2l1ZDFFbkZKNW93QWhEZEZaOUMx?=
 =?utf-8?B?bGF1aFo5Q1lrOW03cCs0bWEvOWRKaTZUMWdrR3IxOVVNQkRJNy9OcDgraSs2?=
 =?utf-8?B?MTU3UUF2Y1lSeWMwT2dWNzY4SnMwSGF4N2JHTTdEemkwbW14QnRrbG0ySTRW?=
 =?utf-8?B?R2hFRDVRRmhHMTErYi9QLzJrTisvN0hUekRHeE5lQ0NyNTZmNEZFSmQyMjFi?=
 =?utf-8?B?K2tIbE5URXZZSVd1ZzBhRnozSC9LdFZBT3VrTjljTlcwNVZ2cUdQeGoyZWwr?=
 =?utf-8?B?TUJubXVtOFoyUWpSajljOEVmTC9ham5lcEgyblZUUFNRdXZ0SXJtemVmNStO?=
 =?utf-8?B?N1hTU2xUL0YvMkVqQ0psSHAvWVhpakhVQ0dzakM0eVY3QnlJTVhjWWNCNDlI?=
 =?utf-8?B?U0lzUjliZUFFV0JpU3BYZGdsdDFvT0NyTklMRDBJMDNxY056OUk1dkM2d2FL?=
 =?utf-8?B?NUNROEpjSlJqK0tRenlPVXRqYlk3OERmU01BazVxS0tDYTlGdEVDUi9LK2d0?=
 =?utf-8?B?UWpsdmR1VG5zZG5LOFJLb01td2NEUWNBNWN1aDljSkR5ZkhTV2FQMjBmV1Fp?=
 =?utf-8?B?cytyK241WjBNWk5LemlIRzlCelhoa1RrRWFnK1BkcEc1VEJlZElSa3gxd2E5?=
 =?utf-8?B?WHZ4SWNQV1FjUUh1LzltMGdacm5QVFE0SUxaZWZnT1hzbC9oMitEdzRtMUJs?=
 =?utf-8?B?aUVJRldxejNoemlEQkhRdExZdFFHMHkvQzlReXphMEl4WVM2MktHSHh4QTh1?=
 =?utf-8?B?MjVSR3hKcnR3OGE1MFBxQk85UkVrajEvYjNQelF0M0Z5dlNpY1IrbnMxOFpR?=
 =?utf-8?B?d0ZrbkpXVURYREFobzVjUlYyb0tZNWFtd0MzbE9mZ1lnZXVKZTdGbmZJZVhz?=
 =?utf-8?Q?/+fmJnpcEaLk9X6tIWISWjpsh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8227cc-4381-4ee5-eca8-08dc1c43d440
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 18:48:03.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sm3qmOGh0xAp6HFzbZPi9RKhlZu+DmEvVxF5PhRvqY3p8aYgluy0N3mu+mogIv0tQWsceYH9KBbe7kk5jAdk2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7128
X-OriginatorOrg: intel.com

On 1/22/2024 2:32 PM, Dan Williams wrote:
> Xing, Cedric wrote:
> [..]
>>> So, yes, the mapping should be allowed to specified by the low-level
>>> driver, but at the same time every vendor should not reinvent their own
>>> enumeration method when we have EFI for that.
>>
>> Given PCR->RTMR mapping is static, I just wonder why it needs to be kept
>> in kernel. Given that PCRs can never be 1:1 mapped to RTMRs, and that
>> TDX quotes are never TPM quotes, applications used to extend PCRs would
>> have to be changed/recompiled. Then wouldn't it suffice to define the
>> mappings as macros in an architecture specific header file?
> 
> I think something is wrong if applications are exposed to the PCR->RTMR
> mapping thrash. I would hope / expect that detail is hidden behind a TPM
> proxy layer sitting in front of this mapping on behalf of TPM-client
> applications.

Hi Dan,

My apology for the confusion! I think we are talking about 2 different 
scenarios - (1) this patch alone; and (2) this patch + vTPM.

Scenario 1: This patch provides RTMR access only. My assumption is, 
there are existing application (and/or kernel modules) that extend to 
PCRs today and would like to work in TDs where only RTMRs are available. 
Changes are of course necessary in those applications as TPMs/PCRs are 
no longer available, but from security perspective they would like to 
keep the same activity log and just change to use RTMRs (in lieu of 
PCRs) as the secure storage. Hence a PCR->RTMR mapping is necessary and 
must be agreed upon by all those applications and relying parties. IIUC, 
this is the intention of having PCR->RTMR mapping config maintained by 
the kernel, as proposed by Sam O. originally.

Scenario 2: A vTPM is implemented on top of this patch, in which case 
the existing applications don't have to change as they can continue 
extending to the same PCRs, which will then be emulated by the 
underlying vTPM implementation. PCR->RTMR mapping in this scenario is 
obviously internal to the vTPM and I agree with you completely that it 
should be hidden inside the vTPM.

My comment in my previous email was regarding Scenario 1. I hope the 
clarification above helps.

-Cedric

