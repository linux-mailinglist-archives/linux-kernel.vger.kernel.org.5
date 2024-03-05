Return-Path: <linux-kernel+bounces-92791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9CC872606
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE5A1C26173
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB05318628;
	Tue,  5 Mar 2024 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sr4DAfj3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034AB14F64;
	Tue,  5 Mar 2024 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661120; cv=fail; b=lJiQ1DQIZkwAsN3mprYtbnsKcdqxLkIvD+XqGm7wsrZSOlzM1xkLOV7S8+8m00Ied1qTAfPQhmeEub5zGkGysaFcmlMwPpYKuy5Q/QeRPe1GoFEsXiUH+W+uT4bFHnojmPV9t8EiMEv+gdJd6Z/Xg+K25ALvwXOJfrrLJq46NhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661120; c=relaxed/simple;
	bh=2sK8lScd9DUKmG+6vWUYXNddRNP1DVEBLCw/lcHZlis=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qG4Oi4mcYfwb/qb5RZMKYpzebiVhWz8+799E5wncvThzzGS6GnvNHJCvCfq42CajEopzef+fWs8pp/709xe2lFcoUkkhGNlq7DxyuzhYYGa9qOh7BrL8nQ3j6GdmP5GzJemirhlA3GfIU89I3NgQo832AeNDb2yjqEU45BHea4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sr4DAfj3; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709661119; x=1741197119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2sK8lScd9DUKmG+6vWUYXNddRNP1DVEBLCw/lcHZlis=;
  b=Sr4DAfj3yOCwzg4YiIvJIJfUQwPsQIpwHLh+u/8Mt6kBP6Gk08SlY0YH
   rmTtWIy/3zPXL045F9AvbsU5XPcEF8yvDMCoNKH6njx7VuxtKFG7KmZlE
   UD3yEeuHibW8UrehFHLGBoR/REUk0a4iYl8ZCQmUz1ouddaAl91Aqm8X9
   EdU+5SZdZ/njIjWRt8qiHgQXcq2HxwkJnOuV68YgrKVhoKx/eCZYrvfIV
   8fjZzR1zbh98cYKeYXDYc7IZqhL1mUGk2s6ht5GhfBmNREShY7aD+nkIx
   1NNZ6T+Q1sy0rTE3hxFxHl7iV2Qwl9zukl3h56TmaIv02zYktW0Y4usJn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="7177635"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="7177635"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 09:51:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9395303"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 09:51:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 09:51:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 09:51:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 09:51:57 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 09:51:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajU0ng6xV1ovDyBmbrtZHgQcdGIF0Qmw8XomkJznn/Ym+z6G/n9bRc7xmTU4Oft/cfxnhE85wXHvoa27d5MBjOCfQIU4tQihHKQsA2Zkbi8KcXSpzJF7wtURwG2GDVCU5KJnizIJwvkzOreEF5LfEFD2G0GXwAub73HqmDBbNac/0ukcGh0twkU/cyoGsLnkvIQAq4/jSnO2yk2kltacat4BH6EKqCKdKEAYxj2aPzfkJ++HOG0W8ewzZH5UGE8uvRIeVkXkOaDWE9dvJmxsDWVtuT7BZTSL2DDymwNyLOY7UhT9NmYWcfbtv5uik040naafoYHY6I2qmHmSOn+9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sK8lScd9DUKmG+6vWUYXNddRNP1DVEBLCw/lcHZlis=;
 b=M2MegVsAyoom46XtIRRnNJUQnkX17yRn89cjrk4mI/gF3DwavdSMA1ZkXtqH4eKZVBoxY/wSi/gZILqvu1rH8xB8tII6U6VO+q5w4AkquZSf87HpD4cNtMcwKTcCB8oDUefmdUL0aiT330XkHppNJJt05zBTvPlKuVuY+cL4hkqpTlbpct2GEHbupoBLlcnwOkCwagNuay+eEpBDSAfF98BiqLsiTFRZezbNFnZesTXLQo7xqAq9G+uhrKnFrXuBu63148zkFPkoic1lpREku5uga1WLxHs+nDGJ7ddkLFmCdsytfKbgeLDqYCZRBlWpGJqrR82wjhV7aKE8MO8TFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BN9PR11MB5242.namprd11.prod.outlook.com (2603:10b6:408:133::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Tue, 5 Mar
 2024 17:51:55 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9%7]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 17:51:55 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, Peter Newman <peternewman@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	"x86@kernel.org" <x86@kernel.org>, Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, "Babu
 Moger" <babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, "Drew
 Fustini" <dfustini@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: Cover-cover letter for two resctrl patch sets
Thread-Topic: Cover-cover letter for two resctrl patch sets
Thread-Index: AQHabs6oHkcOOZfsEkWvQoNAq+dXBLEpbAyg
Date: Tue, 5 Mar 2024 17:51:55 +0000
Message-ID: <SJ1PR11MB60835E98D52C2A0A90C2BFB1FC222@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240228112215.8044-tony.luck@intel.com>
 <zhfckkyc7yr57kdcru3x4d2btuqq5dp3x5qdv26agfq2tlai4d@ice7se7vfctp>
In-Reply-To: <zhfckkyc7yr57kdcru3x4d2btuqq5dp3x5qdv26agfq2tlai4d@ice7se7vfctp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BN9PR11MB5242:EE_
x-ms-office365-filtering-correlation-id: 9eea195b-8dd4-409d-2b4a-08dc3d3cf23a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3A7aTYeh5kDVE1rLy5vxwjS6Z44/B3OoLjdcxOpRX7LjuU9DpTTBduoQSDdkB4HVNPFGb5DIwlkuJUkqCwbAAfpPg5kYaTN9QQU/b97/HHLAsk8uhfei19rL97zu3Q0+4nVkFkyxwBw/iy/KvdSPXzWzFM5o63w3SowXxCIz/N990zN7TDrmCRREAwXleSFwnf1oySxRVywH4KMq2cWm+1BazYw8ZmM6qcuZxGvbnthAUC7jVJkU2Bgpi5oAxmtBu4W7glqv+6VYOjCTXezmu2xIV86TfTk1cNNqSCsh46SwmqPxY1KDP1SLeoKHp9LA/K/l315I18vgx7zVO6w95EMyJJh6+VBv/9EesSSfx1Qx4x6h2RNtNH8Z8Uq6OVZP/dCho0wd8s65+CVcRNq3ck0xcvCZBYz7eHnWsotKJJ3/Ckjw3/WcsBdmCD+LdkSYj5bHsSOQw0f/Zg/teOCPIvJhw3H8nJvG9EOJNymjQGtirlBEXGbj/hY/p3grp/iD4OyW9g6wWok/AYPV80glKvBQUYGM8nJsM+JDooRhM2wcez6rmNxSE+aqshb6vXT79Pt5N4+gIxpzc2c3lZjyoLqaR7UGfsaSve0NvBrcJLJrvuq/sEqRsq4fRbpREDn5aT3BizJkGkMfmQGBP5QjF1xzHDMNGeEkWGWKbJ92/n0/iKrhlvIXNbdu34N1l7ql+/iInM685hXlbyJ+ElT6nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OHu9C0obV1WQCvD/0bw1rogfDYLufEKPkHkPcXcpy8jOv/6jK68uVd0dBEpK?=
 =?us-ascii?Q?xYG/KJS2DXVCgymeBXUaloIDmmxZid5G8afM7jBE/D1wuzb5DmIl23NVio/9?=
 =?us-ascii?Q?pxspwpPh3EDd68lnU1OJW2+6pDq2HV5zkNuXsbD9Oz63HHsCJwJadgvw4JMF?=
 =?us-ascii?Q?vZg5DbH08DdRbotl4WKuBiIdaAob9g0FZCfBK4NIRpVBW/85RzZxWBWkz7Ao?=
 =?us-ascii?Q?4UuSs7K328Tv15Bx5/+vh9xzHarG9XqvOv6Nf9NNfRpSK3QzcvGmYvxDPBrC?=
 =?us-ascii?Q?Fp7vYuy2m8dw0UvnytgxvkMNeLs/e5L8s+oqmN74U5UjjZYYRplm9J7rPt2O?=
 =?us-ascii?Q?qGOS9IXVki8vnmoItI/2HmFPLqbESPpx0PMFraXKYUGI0tGg/yViwQsfonEl?=
 =?us-ascii?Q?4qI60A3Xl5zi9GIeLeJub28TZsihHD6WQ+4F7UJOyPlEAWy5uv4+QJf7TauD?=
 =?us-ascii?Q?xZBrqaInFWTa0HIb/TvAjeav/oDJ0jmHG94UdXvv4nFK9IG+CKa/Hhcwzx37?=
 =?us-ascii?Q?q9DiLKgSerOtKP9gDn+ANWAlmw/kb3IoECkWPFZVz5aGu94gRZM3V7SN5N9w?=
 =?us-ascii?Q?755MIqeOTO9zDMbMrYIza7ac+biPqlRyfkylLG3T1zBSJHz1MlF4yGHHn6Cx?=
 =?us-ascii?Q?hg/SavsGjtgYR4aALHWJRPUhn4A9NBzaHskHsbIrtSXmzHSD7xFLap5+3+Iv?=
 =?us-ascii?Q?jtvcqaKCNtsDQfKu3/eKFTmBjwN9C5LjjFC5VGyU8VM3xGnQpRRbX6BWnROz?=
 =?us-ascii?Q?ob7wJSOUtx4/KnjYDvF3pBTELiTl6jJOS2+q+eeAelJ9rX41TPbI+fx3W2Pd?=
 =?us-ascii?Q?NOUOKgqwo5CHJXAhm1O7wM3sJby7daxCC4jvbMOI6yXLxbIaBIj9qkgH8Cqj?=
 =?us-ascii?Q?Qdc0jYRe6P3pR0zrg2HyAD2eANGGxK2rIYOx9HGFJ8gcw/1kVpj3RXGk0Q32?=
 =?us-ascii?Q?mSVAjMtGj5PdFKqWp+cmB/4R1hCazbiDai+H9akUVyZNimAfQJyXnZMgIdbM?=
 =?us-ascii?Q?kGATmmh1cCDMWfaV4FzHsD8S5JFDpDtFa4qkzdieDwpCeykxXXWrYhykwOZP?=
 =?us-ascii?Q?e08bZ/eeRx1V7LIanyxqYcbAaI34UTKIL9LggYOE3UZSMxGifdMv9/Ze9nbw?=
 =?us-ascii?Q?eYf9rHd5KXUEDuUbrui/r/bQ2mjVR29w8nh0ybBUSLe6tGv5vetmiEPLg3y7?=
 =?us-ascii?Q?3u+9AImGYLzB4IxeImOetxCY3DDBcRdHt7wPUqOAJ86vAVSpzxxajhfh+fO0?=
 =?us-ascii?Q?hIN7GLBOPP8qpfF28/kjKXFHqOZsZrgt1KZorhmwOQ2HG+BeZmq0zaBFWf9F?=
 =?us-ascii?Q?H+Kvi5OJBM5QXQ/FmbB6xEtXTfwfB5BnKBR2Jc61xR2rFtUvoqLtdjRD8iiT?=
 =?us-ascii?Q?lCqPu3QgBwoj4kTVP0yQYABKiVIIy/KlYRktCdgGjejc3ugy1plQqSzXupkF?=
 =?us-ascii?Q?K8SMvKXJiRLyJyn2vvpqHUle0Ws0uqYo/u7up+iiU2M9OcR2uHBYPJvVJSXE?=
 =?us-ascii?Q?ue+jsc6AZwD/iwvsZ5oyFlEKJWH6QVLEoVr0Nbt5OKwgOFii9k1OGCbRbsZT?=
 =?us-ascii?Q?/3LZl0w409CySdT55YB89qYB44LK6eojZaJwRbjJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eea195b-8dd4-409d-2b4a-08dc3d3cf23a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 17:51:55.0531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyegS+ra/NuFlctkEzxqvExVOTnr66VAYihY3yfiZCW9jND1c/yStGhqd+esra1fSW/fuGo6dZPTWskEW9oLTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5242
X-OriginatorOrg: intel.com

> Hi, I wanted to ask a mailing technical question.
>
> My mailing setup with b4 is capable of downloading series by their messag=
e id.
> With these two series tied together it for some reason doesn't want to do=
wnload
> the smaller series (even when I pass the smaller series ID it ignores it =
and
> fetches the SNC one).
>
> Do you have some trick or method to download a series with this type of
> formatting easier than manually saving emails?

The cover-cover letter seemed like a neat idea, but since it is breaking ot=
her
tools and workflows I'm not going to do that again.

I tried asking b4 to specifically pick up version 4:

$ b4 am -v4 20240228112952.8090-tony.luck@intel.com

which worked for me (though it did apply Reinette's conditional
"Reviewed-by" tag without the suggested change).

-Tony

