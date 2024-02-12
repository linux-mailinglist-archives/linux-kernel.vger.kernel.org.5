Return-Path: <linux-kernel+bounces-62292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A70B851E23
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA341C21EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD26E47A67;
	Mon, 12 Feb 2024 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGx2wng6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2798A47A40;
	Mon, 12 Feb 2024 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767388; cv=fail; b=Ux+WzjvB7gPc1mx5Twk/JicRzZzJsqFYiqLAO3TLYsmmfqJNOQ97pcaJkCplDSxZrwvScHx1FrZgiMx1srm75xmImjmHGEyPfK9sEbiOdqZdeWr7y64A3jHswu0Jo8bfvq/CFfCEDztDgNUvA+XSNX4qlcxFbau+gfhhWJfRv4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767388; c=relaxed/simple;
	bh=3Xi+ht8F076kPThrywLkuof8ixoqQe8SDtXJIttQSBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s+Ye46yiCclljVzL74e55HE9N1bwgLCL6X9ORKbPXJUz+81llItTd5wwAphiwSiv9o7Hd/NkCrAcO9c5lb2SUsey3w5A0prlk6cHryysSFFr08hOH0oyv9UpbUfcpGfy5AuOxQM3zMKhTfu8KAyE/nr4JLsqrxeiZagb4bg+c8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGx2wng6; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707767387; x=1739303387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Xi+ht8F076kPThrywLkuof8ixoqQe8SDtXJIttQSBg=;
  b=IGx2wng66k5zXHFlH+8+0hrOaMRp1Sb6fce3W/e+h53AJGwCyN1Acg4+
   K2oPYyhsDdXfPv6Q81rXkDFt+0VQ5JW9fSed8I/27hG+6LU39rfoxBuSJ
   o1ESaosI5z7vi/4GcVv/y2/MOcXmUU6EWJgxbYWYcI7sZqhwQktsX9Dcd
   MYFjHBYmQCjFymPpuinkCIygCLnpOYgv6vQHoHTFKA9ccINVyTzCYy7v/
   XSIkP9Z2kxZkftaCVph3I5k5XcFm2nJKc6b3oUSvjnqu9TKbhrO8R0el1
   JUO1ssZP88pxrg+xSdFTW1AXWVyhNE+JcRo9yJr6fAqLg5fmS2JmytPon
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12397470"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="12397470"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 11:49:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911581534"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="911581534"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 11:49:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 11:49:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 11:49:45 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 11:49:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gD9466Az6wp64BcMSG/HnteOFjg+fexcCmNNm847Pg+vHSJWaoksM2Uj7lQL3TZhbgZjNh1FFeYL5cntJ0vZEqyOvhETFtdFuJQ8xDBrQ+PZqZS7I+cjYNTwzpVfnWdeKxSWUmkc84fSH1xu2mGaTrwEdLBM9k6j9wbqw2nBjccDLCi8VKw7Wlr8+avoo2SHcbiPfRlJYsIBGOOFxDIQRyG3vtlOM3iLB77t6ueGbSqTRNuQbh53s/lkCuWGxdLeR7LId6RwLSI9m3kXYj6feykGWk3KRhnlMVKOuvQLB2wrlGexiEG6pwEPCHFwP/9vFoeM0z68nFcdYGoQqZdfMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Xi+ht8F076kPThrywLkuof8ixoqQe8SDtXJIttQSBg=;
 b=IiuuKXCPL+sJCpT2RXBgBetj2C0KuLXvGTtdwJUDeyj0+EaOHy98j8b2vBSa1cWTtt1JbLhLqFt85gY8TZwyn7+djp1fbS0hLgGzUyBZsQecWISy4tJmyLB6tVezbnHiVEn8RPABrXX70imDrmXAqsUAQKUCZJa0Kg9bqmqSqoFeOlYdMfgFoJ4buIUyeW7l1AmcO8F3SqHvKE/sRMJ9+LGIHqV7c3hvui+z1uTULjS9abuf0dxJXvgi7z3p8hS3uCYBHDLlLltExpxTvAfW7Lo6VCswDS6insiiIv96DpkN6f36apl/Ajr2C4of3k2ZkkOT2zj0QuS0GNrqVVwr1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB5915.namprd11.prod.outlook.com (2603:10b6:510:13c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.34; Mon, 12 Feb
 2024 19:49:43 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 19:49:43 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>,
	"Naik, Avadhut" <avadnaik@amd.com>, "Paul E . McKenney" <paulmck@kernel.org>
CC: "Mehta, Sohil" <sohil.mehta@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Avadhut Naik
	<avadhut.naik@amd.com>
Subject: RE: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Thread-Topic: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Thread-Index: AQHaWhj+DLVtkWOA50OiEqZPMnN2ZbEBPHkAgAE1PoCAAAHSAIAABzoAgAAEd4CAALjhgIAA4DsAgADqjICAAhC1AIAAAfPggAANwwCAAACQYA==
Date: Mon, 12 Feb 2024 19:49:43 +0000
Message-ID: <SJ1PR11MB6083E7E11F6C7BCC8C6C7F21FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-3-avadhut.naik@amd.com>
 <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
 <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
 <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <b5904910-ed58-405f-9425-566383b48068@amd.com>
 <SJ1PR11MB6083CF3400AD2F2047D65E17FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <34b19db5-bd72-457c-9b6a-c2089f6be83c@amd.com>
In-Reply-To: <34b19db5-bd72-457c-9b6a-c2089f6be83c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB5915:EE_
x-ms-office365-filtering-correlation-id: aed6db2c-f601-4b69-b592-08dc2c03c26e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2hkNQggmZcgXqD/Y+ID6XHctbLqmXvwz+/JhFTdPwSjYkCWGtstPTOxVUxM4ifxjNI0OFQj5AK0eGxOtatD+OkM8cwvYA6zFTWsWpZH1GszQYgIp06HsGWdcNahqHDca0Cd8S/IwEO72X/sGJS18M5niiZDpW3qMN8uz1huzV/bv3fghjanNIhEhxhNSxWKAYkFtksx7/9A5bWlQnmxJahAs7KNIvEbkhkXBfIUoOcxiatePsM5eK9Ha/ruh9fXKaRLAmSuEQx2xXfeo+NQd7TbogAF9wNFjKaYscWA7A0w4qI8tco8Rzlkim2SmIA4LdeDpG0SYw7LhvA1MFVq/5MHVinsMiN6t8l3Nuy+R75dGtaGKplYcsnosvRUYlDZrteAz9zjJf+pzcZAlOTQ8Grr+ctWxk3fPmdJzaq6hUY2Y4mfghm6V/aEhAY0uEtAHjEWJpf3pXVPm72FZcNC6arysO6kpVZvGjwiSg0sKtPPzlnPu7LjrJADQvQcOqvTTj5H4FCzLwGL8rsq8u6/j6GVtV+QaPC5YM+SuppAt3M8AIlnV8JIVO/56L86Cg0luZ+H0b+xAtUAaZhphJw2ptEJT4S29d/O8JBBbvpnc72h/UY8HXAGlW+Akt9e5pqEu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(4326008)(8676002)(2906002)(5660300002)(4744005)(52536014)(8936002)(83380400001)(26005)(38100700002)(33656002)(86362001)(110136005)(82960400001)(122000001)(7696005)(38070700009)(76116006)(66556008)(66946007)(54906003)(66476007)(316002)(71200400001)(6506007)(66446008)(64756008)(478600001)(9686003)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXRtUFJSbGo0eDFpYjVTelRFRUFYRWZNVkRjbmhoQTZXMWRCNk1VQ2VWbHc2?=
 =?utf-8?B?aWpsU3pJNVhWTm00cEpjTjlDL2djdDk4M1RIdHhKWmhQN2g2bTBuSmtrSy8y?=
 =?utf-8?B?ZVpsMWJkUUdzQWtzMnREWHhDREhmWWtudXMxRkhHZWFpU3QyWE1RelVaOHVI?=
 =?utf-8?B?cnQ1dG9HZXdjeTdFZTJYMk5UdUV1aGc5WkFONFpDRXRvRExWVDhtakU5R0d3?=
 =?utf-8?B?dVpPRlAvazFMeElEU2w5RDRiL3hHU1E2ekVGYWxCQnpNSzdpK0U1N2FRVzcx?=
 =?utf-8?B?YUkzcnRzQXJmbXF1Y2pTMzFrMkl6Q1g0dlVNSHAyeUhSWlJxczh2TmY0c2Q5?=
 =?utf-8?B?c0diYnNIYjlodVlnM0U5a1UvUGYrUFJTaW9BblNZR0lVMHFpSlZDUlU1Q0N0?=
 =?utf-8?B?T0ZhaWtNV1FUdHFRNkxOcTA0L08rNWF0b3ZQYnQwMUI3ZFVya1JoYTN2SFh5?=
 =?utf-8?B?eGJLa1FvbHgrL2IyRzR6Q2dCa0o0bXFnbFBnMWY4cUZtRnFFUEZJbjkvRDFY?=
 =?utf-8?B?N3lZcnpDZWh1aG1lRFdoNXcrSkRMUUo3ZmJzRjBDdWI1MDh2VGVjbGtPeWpN?=
 =?utf-8?B?Rk1KQVVoZnQ0QzgzQ25DanhQbGdzZ2xmQmRPTEEwSm1tZDFnRXFENFJaYkR1?=
 =?utf-8?B?SkEwaHVnL1Q0ckhQOFRVR0h1SGNqNWZUMnl2OFE5SHlNdjFZR2Fqb2MrN3pF?=
 =?utf-8?B?WGZEN0xnNG9ibjhxUTRDNk9QTmdJYkJra3E0YldRczRRL3VBczdlQTNzYnpu?=
 =?utf-8?B?YTlSM1FNcjNqb25rNGxHdDN2aHBUZEhMQVZ4MFIrZXY3R0hIeklUVnNMbGh3?=
 =?utf-8?B?S3ZxcUxibEdIdnNPYW9LUkswNkpaSUpkaE5vYllOWUV4SCt1QjhrUDNUeXRs?=
 =?utf-8?B?cTRsR0o1VEFTcm45RkUxVmttU3pTWVFwMW1zRC9JZFhWaXd4N3Y3c1NwWHVk?=
 =?utf-8?B?YStGRzVhMjk2WWVjUXNHeXl5UlVaNlhoQUVPQmllVlJQK21mL3BRblIrZ1pC?=
 =?utf-8?B?SkRJbU9CN01LcnhIOFladlYweTNEaEVDL2VhcVFjUXB0Wkp4WWsxUlJGdmMy?=
 =?utf-8?B?K0xOa3E5NmJzTExEazlIdWxDNktmS0hqUzFtYXZkbmczVTFZK2JKR2czMnQ3?=
 =?utf-8?B?OUZuOUh1UDlkVHk5c2JWaElKQ214YXRLMGYvSzZNZWwxTlFLbGlKT084SXV2?=
 =?utf-8?B?WGtaNlA3dHEvNmhzb2lTOWtpeDY4eDJmUnVXNHQ1aHBWayt4VzhNdnRuUjVL?=
 =?utf-8?B?dnNsblBQSjhrSmRBY0t6bnptQkFOdHlQcXRNazQvelAzQm5lSjI0WkFJT0I0?=
 =?utf-8?B?U0NBSjVOaHB1Ykc0U1VseUcxYStMM3Q3SDFSYWJNSzE3anNXaVhBenBWbkhw?=
 =?utf-8?B?VzRPUWltYjFOenlJWU1pTm81VTJxalpqTU1QL1Y4RHNzTCtVVGVPWk1xTm5N?=
 =?utf-8?B?cjBBZzhKczVsWm0vVlVLU3k4eWlLUDd5UnRweWVNOWpzV29hNUcxem4zUWtz?=
 =?utf-8?B?Y05XKzVMSG9ZTzhYOHNQaXk0eEpBaFgrUkE0R1FTdGdhZG9saStBNnVEcFJI?=
 =?utf-8?B?eDcrYitiSGZDVGRvYjB2NHJMR2dlWGQrd1ZDU0MrS2F6WWMzeXNSNTBOV1Bn?=
 =?utf-8?B?bnErZjJpLzN3RWVpRWdTTFFPQTZCNWZDdElwM1c5SmNma0U4aFFVeHlWOHV6?=
 =?utf-8?B?M1IraVpQOTBTMnoxa29HcWJSTmRhQW9UdTF2QlBmem9IczFyOW9mVGExQWFn?=
 =?utf-8?B?RUFvMXpQNHFpckpKWFBvRkNkQ1ArUmVlVWplR3l3R0xOeFdjVEpxaDdNZGk5?=
 =?utf-8?B?NkF4UTdtRk94UEVDaDBPNU9YTk4wdHZQVnhLOWl4eUV4UDRJZ2pDSHlqaUc1?=
 =?utf-8?B?Q3EvRHpRd0M5c213RVlxSEhyVjFMbHpRQm5sK1dNY2VSOGhhK0k2YWZYcEFu?=
 =?utf-8?B?SlBYdVYyeVg3b0kzRm5KemJlY1dDWUJwcVdkMTlZWlFGemdYaGtLODBhVzZz?=
 =?utf-8?B?VEgrd05oRThDbVF6Tm12UzU4bVZEUk8xcnM5UUNjNGhGZjVkRk8wRHpHdHhU?=
 =?utf-8?B?cHZ1TGM1QWxnRHJDdzVxUTJlWW1INHB1MTVXbzVXZ2Y1QmNJQ1FFR2ZJZUFC?=
 =?utf-8?Q?Lf7/3b9NE9WMid2NkViakzt0W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed6db2c-f601-4b69-b592-08dc2c03c26e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 19:49:43.8287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ukx8cKGFOlkAy4h3QkAgCaG4WlimQMti0WKJHlFQ7wrFg4PzI8qvNTJY70K5RQZSsksJqCv9CSEYIrB2F+4/Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5915
X-OriginatorOrg: intel.com

SSBzYWlkOg0KDQo+ICAgICAgICAgIHNwaW5fbG9jaygmcG9vbC0+bG9jayk7DQo+ICAgICAgICAg
IGxpc3RfYWRkX3JjdSgmY2h1bmstPm5leHRfY2h1bmssICZwb29sLT5jaHVua3MpOw0KPiAgICAg
ICAgICBzcGluX3VubG9jaygmcG9vbC0+bG9jayk7DQoNCkF2YWRodXQgc2FpZDoNCg0KPiBnZW5f
cG9vbF9hbGxvY19hbGdvX293bmVyKCkgaXRlcmF0ZXMgb3ZlciB0aGUgZXhpc3RpbmcgY2h1bmtz
DQo+IHdpdGhpbiB0aGUgZ2VucG9vbCB0aHJvdWdoIGxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KCks
IHdpdGhpbg0KPiBhbiBSQ1UgcmVhZC1zaWRlIGNyaXRpY2FsIHNlY3Rpb24gKHJjdV9yZWFkX2xv
Y2soKSkuDQogDQoNCj4gU28gdGhlIGNvbmNlcm4gaXMgbm90IGFib3V0IHRyYXZlcnNhbCwgYnV0
IHJhdGhlciB0aGF0IHRoZSAjTUMgY2FuIGJyZWFrIHRoZQ0KPiBsaXN0X2FkZF9yY3UoKS4gSXMg
dGhpcyBjb3JyZWN0Pw0KDQpZYXplbiwNCg0KWWVzLiBUaGUgcXVlc3Rpb24gaXMgd2hldGhlciBh
ICNNQyB0aGF0IGNvbWUgaW4gdGhlIG1pZGRsZSBvZiBsaXN0X3JjdV9hZGQoKQ0KY2FuIHNhZmVs
eSBkbyBsaXN0X2Zvcl9lYWNoX2VudHJ5X3JjdSgpIG9uIHRoZSBzYW1lIGxpc3QuDQoNClJDVSBp
cyBibGFjayBtYWdpYyAuLi4gbWF5YmUgaXQgY2FuIGRvIHRoaXM/IEFkZGluZyBQYXVsLg0KDQot
VG9ueQ0KDQoNCg==

