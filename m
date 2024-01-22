Return-Path: <linux-kernel+bounces-34230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39788375E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816B61F2531B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B17482FB;
	Mon, 22 Jan 2024 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aAibXP3H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ED248CCD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961562; cv=fail; b=Ol8vumGU5sAjgjDheSQOQPa6WEKhSu7HmIw6h5tUDfJP7UI0u1hbUx8hl/yyT5Xx08Q54IN1RJ/h18CQjl4XivVRlyRss4jvwhe3xJT5uhDilv53+Lzc671xBFMQGoHqp7gL5HIWqG1IeeYasZCxtDPLk1Uw3wl2iNy9rYNVyic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961562; c=relaxed/simple;
	bh=SgwLEd7zfqBFiVF20gDe1hKr2mXAepz38nEOYo2P8rs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GHKI1p5/dOL6WKshEri4usWC4Wsw8lyHPJxB4i1B3DNzMFKnFt1+uTOUGYEJX4tyEGBaagvbyLiu/5yqKxuC4nWiBoYWkUwczhGQaS/l4ndNEL2CP/ToKByw0Yasw/RJQo65/7HkIsuODTZ5/DM7xr1Zy+1Bwaslxu1D8Sq1G+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aAibXP3H; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705961561; x=1737497561;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SgwLEd7zfqBFiVF20gDe1hKr2mXAepz38nEOYo2P8rs=;
  b=aAibXP3Ht9B0ULv/OPbvzn0XJesED22bUi3Sk0PsNOGZalg99SWxlnKH
   aA3YpKTQZoF7yRI5GWCE+Fp9MJ6HGzw+QRPbVairi1TAVm5Z4HIU+noln
   BotpFhkXOVj7rtvAZ/pp+PJGVzG5ptutNKoRca4dtyvPyZAmlOti11zHl
   riFx04GUVYUWLWT082swduuyN3kOSN0q3hBRd+rBqf/8FD/E4L5jNznao
   hR0XCDCKNiEBVADddecrml5MfABx0BPWGFXQ0q2Bl9uKVZb9SA00/gERa
   lau11fFE1ykUMPx9V5QFyVS4dh3seNCkmISXzDZ6JMJq4RPPrs46fnR0b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8739004"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="8739004"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 14:12:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1332136"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 14:12:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 14:12:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 14:12:37 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 14:12:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnKM26XLiwv+7I62A4/qFoz+ss1TIc9a0uj09segPRTcUowZiicPSi/Ovszfuyabtmr/aASkPLtDf/DK9zdT0xKGkDARpBDUcmpf5BtsY89oTzlRspp/yUEP2Wf/q9TsHUtHOTxlsMqvXxyHn6qzPvRl+Wbds8PszwwvE71TeO9Loo3pkQDWDEDbDGQe+xZZy0vVO9YtGdA2msygZh/6vakJ2NN85VQk1nwC9WFMDEk0IBwvnQO8ZLouxe8mUgUyuytr7XMru6CdyD5+AnRWvBSOYIAWIJlkwoIu5U/wriYI3Ey9gdunYm3dyNwE3fjIOHLyEb6r7gblEhYfshMkGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E01YhC2Hii1GDKigrZPJt+xW37aT7PdwlFE7gyehgaA=;
 b=KIWfc2EfZkikSygPGFS4051f5js7HT59zalI5YUXYI0n6D4miCxSHQTstB78B3DWTg7sNmsmyDetbgBazwL53hsZ7jyEs6RtZxVVvEvrz24UfUV14TLIbbRQxjW2kZ534oCnv1CA9W1jOM+mTUyGEgwfIC6cRbg2rKuU4kZfia//INV4JPXa3572SRaCn9d296Zd4QcqF7HokqCMwB/LQGob2/XV8+QhYYPKjYQae5GGymO+rXocdX7ORUc7oCgZkIo/2yHmK2kXy90MwPN00zpWykLdzW8HnenGnabFYSJGnA+uhea3l9N462TTQoc8GQNqKT9CBKpoaofD4ZmceA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 SA2PR11MB4891.namprd11.prod.outlook.com (2603:10b6:806:11e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 22:12:33 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::52c6:33d7:27be:28c5]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::52c6:33d7:27be:28c5%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 22:12:33 +0000
Message-ID: <b20a4dc2-2794-46a9-b3d5-41e06ce22e34@intel.com>
Date: Mon, 22 Jan 2024 14:12:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] tsm: Runtime measurement registers ABI
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, Samuel Ortiz
	<sameo@rivosinc.com>, <biao.lu@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240118033515.2293149-1-biao.lu@intel.com> <Za1eXWiKPQp//1CO@vermeer>
 <65ad6d3db040d_107423294de@dwillia2-xfh.jf.intel.com.notmuch>
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <65ad6d3db040d_107423294de@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:303:2b::22) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|SA2PR11MB4891:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b87383-46e1-472f-7ad8-08dc1b973b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lxA80x/rCpGOW5EKjBIY+seZ4wyhgZ1joc734weWEmY2gqUUgXe4TN+Zc9AfTZ7QNECAjEj/sJLUVASLQ91VO3xbNhxdbrHei2A8vK27AGiIcq9nCdnqhR3D51GrgiGcr5Ul/m4FGTecqEQ9ARaOH0bq8RXVpA9oly9Io0KsIfldS4i8kh2Hvogp19LhMwgFX21sMArwRwBx2HQhymUgBHEwoxwHqhzFDZ65vrTsQdQ5rCpm5wXQJCqDAy3dIxOzB3qo3uFyTJf3CaFT/Bb1AbPxu7ospsqtV+DQVx9vo4KlC/w6TZ80gwRr2i3KA1PtAEnxVhEhRqDmlzoTzT127TJUlZWWdN5lyPylwtuGaCYPKd0Ih+rOiEX/2QmPZIbCDcRD3BBQMombr+jGT5dwTUbtLDUbdYRW4g7LfgdCIyeBYW6YwrfvMnxWIH3MBILFG23B+Z+8Fo8wtA20Gn6avOlY78n9M5G0sDJDa42v5sf3T0hS29tuBJcSEpZf6b2rQXK92w05H/ljygu2rsMv5bhDjl+WGMhliAmws+xPAth529e9gpNqaT2fOCLR6N3Cjg4S1pRwlp5Q0lDP3jhFBNQ8qtzskj83O9NHiMv5H/l5qAeSJlXOoWNZAPlhQn+a2Jr7qpghUscDJNxP6b9rDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(5660300002)(2616005)(6486002)(53546011)(83380400001)(8676002)(6506007)(8936002)(4326008)(316002)(6636002)(478600001)(110136005)(66476007)(6512007)(6666004)(66556008)(66946007)(26005)(82960400001)(2906002)(38100700002)(36756003)(41300700001)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEYrZ3NwaTViSUtvRDJCR3FqTTRvYjVjSVpxRkE2RDgrdkJndkpZTDdBTkZ4?=
 =?utf-8?B?dW9IK25VY2drb0xXbEpnTWp5MGI2TzhMZDVTb2I5Nm82cXZIL3NqYUZuNlVS?=
 =?utf-8?B?elRyems3c3ovQkx6djJjWDdBblE1aTBuQnN2aHorbXdLWjBVbjFvaC9qbmdZ?=
 =?utf-8?B?Q3JOdkZuYW91M3dzVnVTbFFBdm5CQWF2NjlFOCtzMFVpNk9ISkpnejRXdkdt?=
 =?utf-8?B?RndnY3B2bUpCOG84bytxRlFqa09peGl1Sk9UYUdlZzlyVjFWbEN6UWRuNzJY?=
 =?utf-8?B?bDB5N1VyaGkyRjFLZU9FNUNYTzM0Y1VlNnV5MHFoUlhIdXVORFpGWDlLR01R?=
 =?utf-8?B?WlczdjJzZ1V1dEVnVmFSeGhoeEY1K0ZaYnN1c2J6K0NQTXB0aEU5aGttTm1K?=
 =?utf-8?B?d1UyVlNjZkZmcHorMDdrVGpvZEZ4V3JpOVg1S2NXM1ZaYkRzSTFQbU9Cam15?=
 =?utf-8?B?MlpmS2E5SzNpbVU3OGdOQngyUzlYUEpkNUJOYUNmYUVLVjdmNk1lMnVGYVJW?=
 =?utf-8?B?bFZKZlN4Ynd6M2tiWUtXRitwSitvQWorTTNSL0doWk9ZZVJvMHhubXpoZ1lW?=
 =?utf-8?B?dWFLeWpxUkVxNThsVWpvR1V0ejdOeXNrUmpNSnIvWkJ1RDZBWEVFNytnU3dt?=
 =?utf-8?B?WHdBVGtRYVNyNkhlMkk3aS9reEdlNnBJN09lSDBCY2hjN3ZQQmR0K0FFbkxB?=
 =?utf-8?B?ZTJTM05QYks3NDkxVmtuR1hNNW1VOE9mYks5by8wbTVsbGI1bWY5V2JjUzdB?=
 =?utf-8?B?Tkc3UjYvZXIxeDJXL2lLdHNwS0c3d2xxUFNGU1hCaXpFaDVXb1FoWUlDbXZv?=
 =?utf-8?B?elprN3pycUU4bkRaSWlHcjNjWHR5eXR2elRlV1c0MTBZRVovQ0oxTEUrSzBC?=
 =?utf-8?B?ZXNUQXFxbWVDMFdMZUR2WCtIekJLOGxUejZzUld6RFpibkNtWFR0ZHJJVTJW?=
 =?utf-8?B?Vm9QR010elFORnZhemtTaGdoVWg5czUrMnk1enFkN0FVQUdNNTA0Qis2Y2R3?=
 =?utf-8?B?YjFPK01uSGN2cDZnUDhQUVN5ei9PRWVzdGlwc2wybFZGNElmaVZDTE9yKzA2?=
 =?utf-8?B?WmZLUFZFMElWVUN2UWNmN0UxTTNXMGMvclFpVE13SjVEbzZFWTZzdmFiZC9u?=
 =?utf-8?B?bXVuUk5BbEMwKzgxdW1BcXV0ek1kbVBaUzBTSFc0Y1BpWEtMZjFSRWdkVXFn?=
 =?utf-8?B?N3FyaGZGN3o2S2kyYm5wUUJpMloxL0IzMmNiaVNjWFJHWGhHZm43ZXFjTmM2?=
 =?utf-8?B?andncWhLUG5NWEZMMkdBb1FpcXZ4Z2UycTFCNndtb3UyNG44b3ZGVXhET0h0?=
 =?utf-8?B?T0V6d2JxVkd2SG1ZTVZrWldrb0hCcTE3NDZnOWpONjRzTGhjdDQvZWRIdmlN?=
 =?utf-8?B?ZnQxL281ai9iU1BFeEVPeDNHU28rTHpzSTcvL1YvOVJoUEhmL215ZWtnUGUz?=
 =?utf-8?B?aW1jWWdjdlJ4N3g4WGxjTFFEVSszZGlRR2dEZjA5Tk9CNzJkdG9ZemxUZGJx?=
 =?utf-8?B?SFJ0ZkpNRjhUclYwSy9SMlErcWZzcTRhWG1WanliT3pJWnd4TDBRYmVEbmhB?=
 =?utf-8?B?SkVtYURzSENDeDFjSWNEUSs3d3RrS1pjL2xodFN3Q0M3RXVJT0tEVEtIOGFO?=
 =?utf-8?B?bDQ3TlhRNGVsTTg2OEhYKzFlY3JOMGNacHFNK1EySitVUnJ1MmtBcVNVVjJ5?=
 =?utf-8?B?YkdKSlVZSWpTcVRrK2xwMFEwUjRJOVVGUE1HUVZna2VNRHRmeXpJemFScFQ4?=
 =?utf-8?B?cHlMZE1iTU9OTTBDclZyTmtUSEtWYUt4VmdhcEdqV1ZPZ2YzckRRWEFkajRn?=
 =?utf-8?B?QWw0NGc1ZDF6YlBKcTdvYnZIcEdqYmkzNHJ2VVlGYlI5SFFiM1oyT0JvSWRS?=
 =?utf-8?B?ZERIamFvbDZoYk44dVIxMHJpNkptWm50eXNVV1JmeUtCcXhRR1NXaURJQkdi?=
 =?utf-8?B?UFV0UVdndnpqblNhRm1DWlE0Rk5hNmgxZEdPVGptQ0JnR3VZZksvYlJXVlk5?=
 =?utf-8?B?alhhZWt5UnZXWDFnckpxeUVZcnRycER3V01FZ2g0U3J3YWx6c0VwamtrRjRn?=
 =?utf-8?B?dGpXcjF5cG1Ld0FEM1AzRXRvOW5oVDBDNmR6OTF6SDJsb092UmdzcUs4bVVF?=
 =?utf-8?Q?ZsiPyasPdfQfgEVfaFM7wWt05?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b87383-46e1-472f-7ad8-08dc1b973b6c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 22:12:33.2155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zNsnWYOyUseBmGacxrhI8IXYLCgeCyv41XaCR8w7HdiWDuNG8bIzSmWAcbnEa34vnOJTQDKSntdeLvMSmeiBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4891
X-OriginatorOrg: intel.com



On 1/21/2024 11:15 AM, Dan Williams wrote:
> Samuel Ortiz wrote:
>> On Thu, Jan 18, 2024 at 11:35:15AM +0800, biao.lu@intel.com wrote:
>>> Samuel Ortiz wrote:
>>>> Some confidential computing architectures (Intel TDX, ARM CCA, RISC-V
>>>> CoVE) provide their guests with a set of measurements registers that can
>>>> be extended at runtime, i.e. after the initial, host-initiated
>>>> measurements of the TVM are finalized. Those runtime measurement
>>>> registers (RTMR) are isolated from the host accessible ones but TSMs
>>>> include them in their signed attestation reports.
>>>>
>>>> All architectures supporting RTMRs expose a similar interface to their
>>>> TVMs: An extension command/call that takes a measurement value and an
>>>> RTMR index to extend it with, and a readback command for reading an RTMR
>>>> value back (taking an RTMR index as an argument as well). This patch series
>>>> builds an architecture agnostic, configfs-based ABI for userspace to extend
>>>> and read RTMR values back. It extends the current TSM ops structure and
>>>> each confidential computing architecture can implement this extension to
>>>> provide RTMR support.
>>>
>>> Hi, Samuel
>>> The ABI does not include eventlog, but eventlog is usually used with RTMR.
>>> What do you think about how to implement eventlog?
>>
>> Since the event log is typically maintained in the firmware and not in
>> the TSM itself, I don't think we should expose e.g. an event log
>> extension ABI through the config-tsm one.
>> We could decide to check for an EFI CC protocol availability and extend
>> the event log when any RTMR gets extended, and that would be an
>> internal, not userspace visible operation. I'm not sure that this
>> would scale well with e.g. IMA (a lot more events than pre-OS boot
>> afaik).
> 
> Another observation after chatting with my colleague Cedric is that the
> TPM layer that builds on RTMR can maintain an event log that forks from
> the RTMR log. I.e. instead of the TPM event log containig pre-OS events
> starting from 0, it would start from a golden point in the RTMR
> measurements.
> 
That's right. What's needed in verification is the full history of how a 
measurement register's value was transitioned from A->B, which could be 
segmented as A->X then X->B and stored in separate event logs. Those 
event logs don't have to be maintained by the same entity or in the same 
format.

