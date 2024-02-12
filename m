Return-Path: <linux-kernel+bounces-61516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0817B85131F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57BDFB27B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297D03A27B;
	Mon, 12 Feb 2024 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gkhhkkPy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576873A1CB;
	Mon, 12 Feb 2024 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739552; cv=fail; b=sKLmQw10vhfK26aFdknvATWwmzHtQUlE0J2n1+Wyz3A9mWEPxq5ThaHRf0TC39ysE1st7zQlvjXJsDqs+UrDR13dbovwPmYUPZ+n5aK1tRJdHuHsLE+T8psOAU/MsAwBJzZzyv8t7nwui0mfOmYJQTzZR0qfArbzgG8p8ZFe/r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739552; c=relaxed/simple;
	bh=VXoN90nOGiI3P7J7VDcFKacLaCWJd8c+0jJCqAbApbo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nqJhZdZ21gx6BJzgLjpu6oE/l+VRbblGLkjaeb4G0p4J5i8xJwCtq51JUmdQ9qaDZcK5amUwFqxBooFgnOgM++cGSpDL8gQxjaWhD1t/cLyKxK/sEMuwJ/e/gX7WtEOI2DjP5BLwpUvOVqstA1NKG8ZMQMV8SjZrONiiI+UHsUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gkhhkkPy; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707739551; x=1739275551;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=VXoN90nOGiI3P7J7VDcFKacLaCWJd8c+0jJCqAbApbo=;
  b=gkhhkkPytqA+PoQJ4bsIjZZf9qP2hCYsykdweBbS8ir+qqSd9ldiE3LR
   lysWyZVqNQ4wkcSCm0pMPW+jJP3PbBv03uzuDI6K8EkjDkgAn/mwN9Gwc
   iRG8jai8PzLOSKW1ZQ4X/zIH2LuWf7MCZUWIYxlKeCcGr+/4Yq4l9jyZP
   R7KyxvUiW3ZFaGYtnW7FX50V2HkZQO5fHk4cuZdIr1nO/YobMFmnziaGP
   XhGT/UK5aXy1TOyhPvRzFQ2IXuIQv3tTtceQvwVkOpJNHu3cM7qVd92en
   FQ21JLQhreDAudeQ8mswSa+T9osuCQdq0a9j8++TK2bCJyVtfADGBJ18g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="5490345"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="5490345"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:05:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="2772661"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 04:05:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 04:05:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 04:05:48 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 04:05:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIBnFAc4nuvQWp8qI+nnZ07OErGvyhIjKDD3/iKseGcScSfEeol4sodIDvwpBIgjm8AsRqUyD2zKGBOvDSAZLVFY1PcVrU3MEgOTH5tad50jU+eMpXBtHFWw/iZz3xs+79R10dW8dZGnXv7ebMR2kY19nR/yNt8eq173CvzLcLlr6HtZ4dXuSF63nuZ/wntznZ7FcYC8pHUtlVuQAfb8Xm7cemM2xTdFslL0GK9E3n6LHK0vDfGZIlOS/oS0R2Z4Sdnphcdp/2H8quineZfcbPd6R+MyO+DkFih//UTr5/RqQ541uCJ8RheEtJKOw0P0JAnZKcOW/2pIwfFG9zpu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0K7/EgyZquVyY5Jyit3Ug6kHh+UShVl3RgsCTIWtpco=;
 b=jPI0FJRLE5l3ttelLEiLEvdjbptlTkajJE13QH0HmGDUgfAu+C6QvVO1IpPCK6uNUYESYvNcJ+JflkJQ/+IyAlo0TKO3ZElCV1YMXlCyYnbwZRCNYgmv2GOpAmiEbLhnckF5i3eSROBKpnarrlvHiS/cn48DDOJgS7UTgU5nzKETT8e3wDQ6BesVYMn4esAlhc1tpI7wsQIZE/j3Bt7BBmaowqNvAqxLmLKOsg237qrP+zMwgiPG7n2BXa0ZEPW1BUN3IfwkWt/DQCTHclSuK6sDiCDom1GS51YUm4Qa8utapiv3Xc61GoiD2ZgAIOj3IxplpeFP8JzPNuaCJRXClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by SA0PR11MB4687.namprd11.prod.outlook.com (2603:10b6:806:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 12:05:43 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708%4]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 12:05:43 +0000
Date: Mon, 12 Feb 2024 20:05:33 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Andrey Skvortsov <andrej.skvortzov@gmail.com>
CC: <oe-kbuild-all@lists.linux.dev>, Icenowy Zheng <icenowy@aosc.io>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Subject: Re: [PATCH 2/4] dt-bindings: iio: magnetometer: Add DT binding for
 Voltafield AF8133J
Message-ID: <ZcoJjfumScsnkiB+@rli9-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240211205211.2890931-3-megi@xff.cz>
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8414:EE_|SA0PR11MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f10b148-587a-4e4f-9a0e-08dc2bc2f024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hH8DoLS4RtZIWS0zLIMb/tFR6jktS0UsbZpap/tX9cJPNwfKRv3xsFodAOEt9oDrv+sY1yredLqf7czCNLnzm5GTSoWKdlSkwTa/aZJREYxkNQn292l7exedE4K7YAasTA+xKeeszDv/1TzI0hzc6jNp1V71OMFz7YMvnMKSPFJgsSChLHy/XYD2yMHdG3sWFgE4gOop4iVtUNiZGGvCEnHSEuVUvpgI4Zs2ZZYdIHd9Up3uRQ9duazTIfJO5jQlU+BksViYGiCWmRAmNjNPAu2W0bz/MJxJXcpR7ceMMSt4NO7T2Sma1Tdhae8qzO2AGopKwOkJ9Kqpv0ChwCvb/NMuWElltqU85Xmti7otKFJuNqrvGouqyoCMvj/DqyHY0Y/UOWeeAJkgkRghTDt9fwB8MYEOem3DDd+trIP0T8JrGi5cyXc+S3Dj0Br3hbp3C+mVqCJScaQMZltrEwwsUlm0HaxbuTJlW5wf/2SgxcWmrxE1nmSApEmp+8CD6V+RaXF5JRdxox2uX9goEwX6F/9Ap0vMVD5IMDioQTEkIGEjgTRzhUD3kvxqyywDsKkqt5ao3b8FK/SyWVQSQ/LcXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(396003)(346002)(376002)(366004)(230273577357003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(9686003)(478600001)(6512007)(6486002)(966005)(41300700001)(33716001)(7416002)(8936002)(4326008)(8676002)(2906002)(5660300002)(110136005)(54906003)(66476007)(6506007)(6666004)(316002)(66946007)(66556008)(83380400001)(66574015)(86362001)(82960400001)(26005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUhYbldmbWF3SXlwL1VNaEZvY014U0VTdG15MDdFcGQzYk5QTFlNWFdBVFVN?=
 =?utf-8?B?Y0JrSTNhTDI1cnJESjlrRnRLclN1N2JzNlZZdnFXQmdheWZUSFlNTHF2MjNq?=
 =?utf-8?B?NHg1TVgvbjU5MTJKNWg5KysvdlkxQlM3dmJ2M1RLMmJWZlFYR1NsN05SR29C?=
 =?utf-8?B?ekhkUmxpWnBYZmpDbFZDVUpWbXAyd29LdEpzaTNqVDBEcE9JVE1iZ3RpQTBJ?=
 =?utf-8?B?NGJadHlsNzhXNE8wSU84OVBxZHlEeVZNT0xXNER1dit6TG80Q3ZzYzB1ZU4z?=
 =?utf-8?B?dkNjbXROczVOdWNUeld2OHBESFEzUGZKZnEvVDQ0dlhqRWdxVHJxYjJuVW83?=
 =?utf-8?B?cTNDRHNnOWJQa1daQzBOK0xlTzlzWGxydnJCSzRxUU9ZR0pZS2dnWmVmOGpw?=
 =?utf-8?B?OFRNMFBHdmdHYXZPM0ZiTTdHY1p0N1FVREw4OEkxSWwzNjB3SU9VejZIRUQw?=
 =?utf-8?B?bjNSK3lLZnQzT1pkV05YQjZsWGtkQ3puQmhzT0J6d1lCbnZiVXRVKzUxVmJJ?=
 =?utf-8?B?aFVUb2RvVUI3dTU4QzZMNmhKZm94cHRlYmtmTmdEOGRIaExYMGVhbW9RUCtG?=
 =?utf-8?B?QWtUNGpycG1zNW1IUkhJUHNrRTRJcmR1NDFEaHJtRXJhL05NRGdIbmF2VTVr?=
 =?utf-8?B?K3J4dDlWMHlzMm5WdXdLWG4vOFZ0Y3o4aCtXSmxBTnNPdUt5bWtvWmFLSjhY?=
 =?utf-8?B?TEJTUzEra1pZQm1EMjNCSlJHaWdsYVUrWWRLOUJubkQyeXdmZ1NyS1IxMy9z?=
 =?utf-8?B?S21PcnduclYwQVJRMTA3TjBZKzNJK2pTMnlQNkkyVmRNU2pvbytaTE84OVBN?=
 =?utf-8?B?Qm1FRWlQRGRNbnV3b3NsOG8yNCsyZU8zSTBuSEo0MHl3dXFHb2JRSFlLZVMx?=
 =?utf-8?B?UXNpMWR2N2wvdWJORDcyTnIrMVJDRUI0Y3p6NUlieHMwVEEvY2R6YXo3S0hk?=
 =?utf-8?B?VDliRnBiVTZKUUJDTm1FY2k2M3pWNkN6dGJSSDArRGlWa3g1RHVlRjlBOWJh?=
 =?utf-8?B?N2VrNzgxRzdjZHZFOExFc3BvK3dxbTczRm1FaVhUclUwQWwxSlQzdlpNSks4?=
 =?utf-8?B?czB0ODRJK2Fibk5YZTJpOVhsTUliQXMvYWRWQXAzRmxFRXB0WHBNTUdIWERj?=
 =?utf-8?B?elVsZUl6UloweGFXQWhmN0k1UFJKVHdrQ3BIWGpEVDlvMGJqQklpY09IZHBG?=
 =?utf-8?B?QWVwYldpY3BRS0VXRWRPK1VnbytrdnlhTmY5TTlXTmFKTFVtU0VnZ2hwRVI2?=
 =?utf-8?B?Zk13a1BJNFhxcmd4Nm1XeEo5TFpaeUJTcFFabS91ZVZLc2p0N0FPdjhFTmdv?=
 =?utf-8?B?ci8xcXN4SUNDbWpNQmtQcWp3VnRvZnp2SWk1b2Y3MzdFL0phMi9VZ2NLWWFR?=
 =?utf-8?B?V2VPODJSK3ppSy9jRUZabFJJc1l0VzdlemNHVEtmUW9TUjFHeTg1RFp1V0NJ?=
 =?utf-8?B?WWVha1hBTXJLbnZ0VXMxR2d0VEg5WE1oWlBEd2g2SVZQTS9uMUZhWHZyc3d2?=
 =?utf-8?B?Uk9vcmpBeW54c0lvRHBoU3JYZ3NCM2RXV1ZHKzJtaWt4QWZIcnhkNnZ4eldO?=
 =?utf-8?B?cGhDK1E4ejQ0blFvbmdTMVJ0YzRYU0RLRUFCaEYyYlFnZ0pzNjRlWXJmdncz?=
 =?utf-8?B?K2c5NFBna0Q3US9tcldudE5TR1o3OFZEamRRZUJzUXZHNEFYZVgzcVJIMlhX?=
 =?utf-8?B?ZXJzeWpBaWo4a2k0ZkRrOGRNdXZxa2ozY1Jyc2JwL2doZkYzVmxIY1ZPTzd0?=
 =?utf-8?B?cDVvVW1PSURkMlAvaVdPTno5d0JsQ1g4djZlenZNaGwzb1djWEVtZ0piU25o?=
 =?utf-8?B?QkIvTGV6aURtQXFBSytrUmZXVjhrTG1YMmJkazczV09lSW9xWTlBWW1kMnJW?=
 =?utf-8?B?UnJkalNNeThtV0JvZkx6K2kvcXc1dXNNc3l0ejZBMmZodnl0NVhYR3NnVEZJ?=
 =?utf-8?B?diswNm9YWStkWWJQSmVIZ2l4SVNrK014b05CSmVqd0Q2QUdrNUNpWDhMWnM4?=
 =?utf-8?B?YmpBbWlOQ3l6enkrR2N6ZWc0YWxGUnUzeU9yVTU1MjVIK0RBeFRhSmtWdVZ4?=
 =?utf-8?B?anJpcExaODdmYlR1M0IvZkMzZkMzcHpOTk5hSmRia1NUQmd0RUtkbHJHL2dm?=
 =?utf-8?B?ZmNocllIeGZPNTJqOXczQkhTUkQxWXJGYlRvdzYybytodGJldmVlMTB1Y3V4?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f10b148-587a-4e4f-9a0e-08dc2bc2f024
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8414.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 12:05:43.5216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5upVB0lvhClCre+j8FNdkLwfIj+k4zPs+cL3u9yWV2lE+ebHuFjdgOW1InBDNCWKyY8FhmGie7/wsyGm+4mtzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4687
X-OriginatorOrg: intel.com

Hi Ondřej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.8-rc4 next-20240212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ond-ej-Jirman/dt-bindings-vendor-prefix-Add-prefix-for-Voltafield/20240212-045510
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240211205211.2890931-3-megi%40xff.cz
patch subject: [PATCH 2/4] dt-bindings: iio: magnetometer: Add DT binding for Voltafield AF8133J
:::::: branch date: 11 hours ago
:::::: commit date: 11 hours ago
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240212/202402121531.EoXy0HWe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202402121531.EoXy0HWe-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml: properties:compatible: ['voltafield,af8133j'] is not of type 'object', 'boolean'
   	from schema $id: http://json-schema.org/draft-07/schema#
>> Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml: properties:compatible: ['voltafield,af8133j'] is not of type 'object', 'boolean'
   	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
--
>> Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml: ignoring, error in schema: properties: compatible

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


