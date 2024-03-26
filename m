Return-Path: <linux-kernel+bounces-119164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A0688C501
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CED9302668
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C1212D77F;
	Tue, 26 Mar 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dq4OF52W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02D86CDD4;
	Tue, 26 Mar 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462816; cv=fail; b=tD7h2S1e7CPvb73XMV/W79pjQO2584U7wt9gCy6Uo0QLWBhloHOKB7b5W0bn2PRGwrS9d1+K1iyeqPSaghKi0Ui5p16BZOzXOccrh0ZjEmwv6e2oPbZZMAHA3k735trVYmEzMQwioAA9Abdrectj7bddobZvnulEzlbf41LdnGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462816; c=relaxed/simple;
	bh=WhrjQFLNSLzsb0Bk7vHJr/NG1V5GYYMjTK/34n0YT64=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CD+mHzbZFtH1Yn/YpKORHls8/ghbxKxhMMCaGxHVjQ5sGI+XETPEiKAQYIkb1lYg4prBiFO/6SJxfRCaivwhTL53TCEA4PJMM54MQriD8ux4qxl1R+AgJSVuOvx7CJygEZkTV0lOd9FxPILU3iMf1dabE5g31/5WGYn/l+4Sf9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dq4OF52W; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711462814; x=1742998814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WhrjQFLNSLzsb0Bk7vHJr/NG1V5GYYMjTK/34n0YT64=;
  b=Dq4OF52Wa00tFyPp4o8ZB63RVQiy1LgFvWh2hkrp5/5SeO+CnubVLFRa
   g0u8a0NxLh/BK/acDv0Y1VDFInXNJZE9nhjEE7alc8wjPfl4Rv/QALxfx
   1qPuyg+cizqeEaplfGNJZKXVxgAgQk6ycIhMAkFxO/yqH3t0bdztgpnkl
   HwqgAtFPgQf9Z8Y46P9wTJK3OhH/fsCpoM/8y+cwb7NCSdGB2XUXTYmIL
   14rlhgnqGgqHrppIZkn2NMgHOGU7yyEVBxJ8AC2l0GBRdpRHKuQaHqHQa
   NzgKnrDCmGU5QRU1AzEtKJUA/2UOuhHBlHPY9phr3R0s0DoRjhl/LPwWs
   g==;
X-CSE-ConnectionGUID: QcHajHG6R++EPvsgTZMhqg==
X-CSE-MsgGUID: P17GYM32ShivrO0/79uwgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17945578"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17945578"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:20:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="16058569"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 07:20:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 07:20:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 07:20:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 07:20:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1J8ej1/l++2AwNNJlAdcyIDAZgL9YKmwvVg509IO2WZeaN3KgU9aRP6/qg3P8p+RtjqJ2HsHmkBx0IBnR/WnuQP29mByqLI+1Rjr2LXZ69LOxoHn3qPyf9R5VZtK6PSUbnJdheTJRY46rZM4jOa2/t9U4NgzV2Q2k0eh2gNY2Ljes/i0RLuchBVit2bTc0i27gRCuCQUULnyE5042wt3e2zAI27zCzi3rphAqBn98B45GHEU2tdScPVmdEUIIqoBlBr02fxskx+V3+aR2yVbUJrZr9Z231TgW5BStypyfKjgTIFHShGi8w4xcMucCLxUw0XmIYcGSzJTxioLcdxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAyCKRzUoGNYZy6DzE1GiFTgCFUvCNhp+4dQ0lKA+x4=;
 b=SxPZaeMByCOBHXbSQVmg8g/2/WEUppuHcsU5HSXrTAakVgaEdX/9BEDl0Hh7WevbOSCJ0g7aGbcGM1mBR57rmwnHGofZUdlhm92i16EMlH66qDl8fCbzxfWtYTNHaazCoARWVVjY6y6u1nnqfT1CXYL/Q7upUvOko/CL5dNZU4KdSi0k0quF6ougckPhDeTYHoM2H3yRGXjEU6v2CkGfNNy3ot1+CuxPqKWVaUfOeie+9i2w9B+TXG2obpS7rS3huOhsmrBmikh2DtSseg7NGePuYR3dxQ1bYyVpoDa/9N31khJrs1cq0uKTgmb8B7S9Ex8A7AzViWT/ku/sNfr9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by PH7PR11MB6546.namprd11.prod.outlook.com (2603:10b6:510:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 14:19:55 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::9445:5793:b0b7:711a]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::9445:5793:b0b7:711a%7]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 14:19:55 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: "Gomes, Vinicius" <vinicius.gomes@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>, "Bezdeka, Florian"
	<florian.bezdeka@siemens.com>, Kurt Kanzenbach <kurt@linutronix.de>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>
Subject: RE: [PATCH iwl-next,v4 1/1] igc: Add Tx hardware timestamp request
 for AF_XDP zero-copy packet
Thread-Topic: [PATCH iwl-next,v4 1/1] igc: Add Tx hardware timestamp request
 for AF_XDP zero-copy packet
Thread-Index: AQHafyVoRBBG3fA1TkG1EIP3FZYpnLFKEC6g
Date: Tue, 26 Mar 2024 14:19:55 +0000
Message-ID: <PH0PR11MB58308AF32C9678FA550F38BCD8352@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20240325020928.1987947-1-yoong.siang.song@intel.com>
 <87h6gtpvyn.fsf@intel.com>
In-Reply-To: <87h6gtpvyn.fsf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|PH7PR11MB6546:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3vohTW8XvlihEQEeoLGmU2JZZ/X03dwBXCnbwD1UnXysvpNc4uhtZ6nGn0SokUU23Bymsm+j12dx5xxrt4T4PjjTpue0xLJ3Wa/622eZTLqv27FxjGg0BMw5/PDWntXZfRfYrQ5z8HljF4eO9wLVuwMlvS29Jr/9YIveOBm9zdTdKq0xGrFBotktO8bd/oVxcN7LmQmYCLG6Vb83dZFJmRrzuZhbnMYnujSW1F+77b0FqfA139e/iU8tcwVrKHLEGd2XIM21YuntwMFrLXjCHFLhUlKFY/fXPG0jPeOprUtmgVgfTdexn2mKUjHCpbhdO/O97cRRMIrGupSPQORF0ugaB85aVAtYKpPYpxBf4OjJFAtTvGY39JrDoIffzzqRXrSXclef1OjxD+Ci0tb8/mmdTnsmLiFhU1BHb/G5CqnRKRr6ZZ8YbIlAfeI/RU/b4eF1juMSThFgiXOlWN+kwsd9+jk/GXo83hkvNHu4uzCvG1ewAKmsLNK3UxgZQKshGg8T/ZNg1Vrs8UIVZgi1TNaY7xgESEBbI8qqcMCSWEWhyBMnBXG1xcyz68rJmF3qqoE48Kf+u8jUFrKTeYQM5p0uW5XlfzpIDWnTawivggBHWbrRWfSEXPyGgo797canqzj+svYzQwPPJr9wX4MMOlOQzOGumJ+lZeQnAPM6RdI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sqkyYhpP3jybTTQIWVIbQ8+2IDoLjxFsrVZ6nCvMfNDZoiTzhZuS+5zSbKYG?=
 =?us-ascii?Q?BAbQxk4FslW5uWd5fxFV3y//Je2aoQ4DLFBTRppSTgSP8WKx8LxEUXoAQ4It?=
 =?us-ascii?Q?3pX5/OZt2Z23Gj1NPNNrrg2rjbRJxpJSwo4AdI5X3d3dEPFnqjVpLk6B+Pa6?=
 =?us-ascii?Q?f1dA+osDcuj/EWZI++MAGNs8EK1lc+2PCvUnUiYH/4ioF0CD82MxvSRk3fw6?=
 =?us-ascii?Q?8f00JAhBJulT1zVcKVKjd+c+q6FM+H1LOWcArRKjwmnV1BbbnQtYn9DWI1oQ?=
 =?us-ascii?Q?30onLtakLMpoei2tBq8HfBZTJ0TtWO2FVwYCnbaRywYswJfO06l9dv8WVd34?=
 =?us-ascii?Q?l1lUBT790e7T+Zd1fCTCK2catzByQtbEH9kV1q4UHpJAvm1U2yby3ul0zIQb?=
 =?us-ascii?Q?gc8j/Y4Z+YKB+y8tlo78DuQeozmVWaZd0aDiQ9oeSqteNVLTPIz5N89ptK7p?=
 =?us-ascii?Q?Weok5AoOmvMSwzeTgwjO/cdKbJzSFYMhlqhldDnSV+Ala8l7Af+G9sbjgMOZ?=
 =?us-ascii?Q?KeSSABqrrB8xmkvhuqBNPL0S+zCfr9ArC686yARGCnaNiw3ZaXpFdJwyOkQC?=
 =?us-ascii?Q?RXALreXGG41makjx+uNs31ohzt5bjYnOV/X+haYj3g+Z0xxiqCEsmncOo/Ct?=
 =?us-ascii?Q?wqEckp3tVvNNHaYwfZ1CTYGXDERlFgNQYR/6n8ixGeC5pjwSgq2HtyhUfsnN?=
 =?us-ascii?Q?Wlx4aELOqnrQI27HHjoivpHYiSIHW7eQDXdIpD9nPc7l0XnpwyhSDkGW0ueo?=
 =?us-ascii?Q?RRXjkCpFM3RVVZqjqgbnZh3ZcOpZg0RbFFtsb2ER8fpi2ooXKh0DhIsmJ40d?=
 =?us-ascii?Q?MY4rhJZ4ZFr+OzWepUv5xKOaiM/Htb38l72P3Cp9LJMidJs17yOE/pHiBQF8?=
 =?us-ascii?Q?rA3iOiESpEXpAgeoeX+N/FPGEpPoBGUPlG2/L6OsVl+dR5A7Gs8qSw8/dA6L?=
 =?us-ascii?Q?PMcaLURHMx3vebHZ99ItjU+bUoNEkLbn4Wbq4i6fIm7TiEt8kAMYh27g8OB1?=
 =?us-ascii?Q?H8v2ZCklovrLpMIejXweByShZAZNgeJsJNWhyDdFb6Enbg9XM2A79TM8Ko6s?=
 =?us-ascii?Q?MGGIDqrUX1IzDD+IXQ05JiwoM0/W87ME4yHaCEA1MRCDcU0WZNNcWBgrHJ2S?=
 =?us-ascii?Q?dSp26ttX7rVD/FNvN9eMXSjO1s2MpZjz6ZCBhGHsqWG5z4aEH+owuZyz4HOv?=
 =?us-ascii?Q?t/ClZ9ulSCtw1UcejSGR9TnceO2AJCyunCOF2uKryfYgFww7q6imiIBTPUKU?=
 =?us-ascii?Q?OoODtbyoDtFDWnyqKHiCowRMzl1eIdHVFeEYs/kGjg9iiPPUHR3AD/6NDP0n?=
 =?us-ascii?Q?pwqFwJM5eCwFi0NObBJxPGWdI4gezipdSmY8iVdgePNgbO19c9yrb+0qROuQ?=
 =?us-ascii?Q?zAkemD5I1YSjeJQq1aKgy8f9/OXr5bC2YkkVMyItztaWWalJ2/MxjqjnXu3l?=
 =?us-ascii?Q?4XJD5epHejVPUcKNnrvClX5JF3MYKYFAall5hhiL7hlBUyS7ICKj8AmawXAd?=
 =?us-ascii?Q?6wm9xvXKvh6plFen86mP3i2qCUbRNJK2hWNLS+bRr8dR87QUD+zHul48kips?=
 =?us-ascii?Q?XpFD67sxl5T/15oJ9ug8awc14c09kakmoONZgi1hljdUkb6a7louoO1gMiG0?=
 =?us-ascii?Q?bQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f05972f-57c5-464e-294f-08dc4d9fcf94
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 14:19:55.6993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UVXxhPEAAU2KoiPVOJ2NUnfCZnufuVD2cZIVBq4yKSHAraEKN8zHyTXD4IgvTxPZU8C65t2Ar+eQ4X9d64IFZu2FyNxOBZ0Z57FLEUEUReI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6546
X-OriginatorOrg: intel.com

On Tuesday, March 26, 2024 10:29 AM, Gomes, Vinicius <vinicius.gomes@intel.=
com> wrote:
>Song Yoong Siang <yoong.siang.song@intel.com> writes:
>
>> This patch adds support to per-packet Tx hardware timestamp request to
>> AF_XDP zero-copy packet via XDP Tx metadata framework. Please note that
>> user needs to enable Tx HW timestamp capability via igc_ioctl() with
>> SIOCSHWTSTAMP cmd before sending xsk Tx hardware timestamp request.
>>
>> Same as implementation in RX timestamp XDP hints kfunc metadata, Timer 0
>> (adjustable clock) is used in xsk Tx hardware timestamp. i225/i226 have
>> four sets of timestamping registers. *skb and *xsk_tx_buffer pointers
>> are used to indicate whether the timestamping register is already occupi=
ed.
>>
>> Furthermore, a boolean variable named xsk_pending_ts is used to hold the
>> transmit completion until the tx hardware timestamp is ready. This is
>> because, for i225/i226, the timestamp notification event comes some time
>> after the transmit completion event. The driver will retrigger hardware =
irq
>> to clean the packet after retrieve the tx hardware timestamp.
>>
>> Besides, xsk_meta is added into struct igc_tx_timestamp_request as a hoo=
k
>> to the metadata location of the transmit packet. When the Tx timestamp
>> interrupt is fired, the interrupt handler will copy the value of Tx hwts
>> into metadata location via xsk_tx_metadata_complete().
>>
>> This patch is tested with tools/testing/selftests/bpf/xdp_hw_metadata
>> on Intel ADL-S platform. Below are the test steps and results.
>>
>> Test Step 1: Run xdp_hw_metadata app
>>  ./xdp_hw_metadata <iface> > /dev/shm/result.log
>>
>> Test Step 2: Enable Tx hardware timestamp
>>  hwstamp_ctl -i <iface> -t 1 -r 1
>>
>> Test Step 3: Run ptp4l and phc2sys for time synchronization
>>
>> Test Step 4: Generate UDP packets with 1ms interval for 10s
>>  trafgen --dev <iface> '{eth(da=3D<addr>), udp(dp=3D9091)}' -t 1ms -n 10=
000
>>
>> Test Step 5: Rerun Step 1-3 with 10s iperf3 as background traffic
>>
>> Test Step 6: Rerun Step 1-4 with 10s iperf3 as background traffic
>>
>> Based on iperf3 results below, the impact of holding tx completion to
>> throughput is not observable.
>>
>> Result of last UDP packet (no. 10000) in Step 4:
>> poll: 1 (0) skip=3D99 fail=3D0 redir=3D10000
>> xsk_ring_cons__peek: 1
>> 0x5640a37972d0: rx_desc[9999]->addr=3Df2110 addr=3Df2110 comp_addr=3Df21=
10 EoP
>> rx_hash: 0x2049BE1D with RSS type:0x1
>> HW RX-time:   1679819246792971268 (sec:1679819246.7930) delta to User RX=
-time
>sec:0.0000 (14.990 usec)
>> XDP RX-time:   1679819246792981987 (sec:1679819246.7930) delta to User R=
X-time
>sec:0.0000 (4.271 usec)
>> No rx_vlan_tci or rx_vlan_proto, err=3D-95
>> 0x5640a37972d0: ping-pong with csum=3Dab19 (want 315b) csum_start=3D34
>csum_offset=3D6
>> 0x5640a37972d0: complete tx idx=3D9999 addr=3Df010
>> HW TX-complete-time:   1679819246793036971 (sec:1679819246.7930) delta t=
o
>User TX-complete-time sec:0.0001 (77.656 usec)
>> XDP RX-time:   1679819246792981987 (sec:1679819246.7930) delta to User T=
X-
>complete-time sec:0.0001 (132.640 usec)
>> HW RX-time:   1679819246792971268 (sec:1679819246.7930) delta to HW TX-
>complete-time sec:0.0001 (65.703 usec)
>> 0x5640a37972d0: complete rx idx=3D10127 addr=3Df2110
>>
>> Result of iperf3 without tx hwts request in step 5:
>> [ ID] Interval           Transfer     Bitrate         Retr
>> [  5]   0.00-10.00  sec  2.74 GBytes  2.36 Gbits/sec    0             se=
nder
>> [  5]   0.00-10.05  sec  2.74 GBytes  2.34 Gbits/sec                  re=
ceiver
>>
>> Result of iperf3 running parallel with trafgen command in step 6:
>> [ ID] Interval           Transfer     Bitrate         Retr
>> [  5]   0.00-10.00  sec  2.74 GBytes  2.36 Gbits/sec    0             se=
nder
>> [  5]   0.00-10.04  sec  2.74 GBytes  2.34 Gbits/sec                  re=
ceiver
>>
>> Co-developed-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
>> Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
>> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
>> Acked-by: John Fastabend <john.fastabend@gmail.com>
>> ---
>> V1:
>https://patchwork.kernel.org/project/netdevbpf/patch/20231215162158.951925=
-1-
>yoong.siang.song@intel.com/
>> V2:
>https://patchwork.kernel.org/project/netdevbpf/cover/20240301162348.898619=
-1-
>yoong.siang.song@intel.com/
>> V3:
>https://patchwork.kernel.org/project/netdevbpf/cover/20240303083225.118416=
5-1-
>yoong.siang.song@intel.com/
>>
>> changelog:
>> V1 -> V2
>> - In struct igc_tx_timestamp_request, keep a pointer to igc_tx_buffer,
>>   instead of pointing xsk_pending_ts (Vinicius).
>> - In struct igc_tx_timestamp_request, introduce buffer_type to indicate
>>   whether skb or igc_tx_buffer pointer should be use (Vinicius).
>> - In struct igc_metadata_request, remove igc_adapter pointer (Vinicius).
>> - When request tx hwts, copy the value of cmd_type, instead of using
>>   pointer (Vinicius).
>> - For boolean variable, use true and false, instead of 1 and 0 (Vinicius=
).
>> - In igc_xsk_request_timestamp(), make an early return if none of the 4 =
ts
>>   registers is available (Vinicius).
>> - Create helper functions to clear tx buffer and skb for tstamp (John).
>> - Perform throughput test with mix traffic (Vinicius & John).
>> V2 -> V3
>> - Improve tstamp reg searching loop for better readability (John).
>> - In igc_ptp_free_tx_buffer(), add comment to inform user that
>>   tstamp->xsk_tx_buffer and tstamp->skb are in union (John).
>> V3 -> V4
>> - Add protection with xp_tx_metadata_enabled (Kurt & Maciej).
>> ---
>> ---
>>  drivers/net/ethernet/intel/igc/igc.h      |  71 ++++++++------
>>  drivers/net/ethernet/intel/igc/igc_main.c | 113 ++++++++++++++++++++--
>>  drivers/net/ethernet/intel/igc/igc_ptp.c  |  51 ++++++++--
>>  3 files changed, 195 insertions(+), 40 deletions(-)
>>
>
>[...]
>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c
>b/drivers/net/ethernet/intel/igc/igc_ptp.c
>> index 885faaa7b9de..1bb026232efc 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/ktime.h>
>>  #include <linux/delay.h>
>>  #include <linux/iopoll.h>
>> +#include <net/xdp_sock_drv.h>
>>
>>  #define INCVALUE_MASK		0x7fffffff
>>  #define ISGN			0x80000000
>> @@ -545,6 +546,30 @@ static void igc_ptp_enable_rx_timestamp(struct
>igc_adapter *adapter)
>>  	wr32(IGC_TSYNCRXCTL, val);
>>  }
>>
>> +static void igc_ptp_free_tx_buffer(struct igc_adapter *adapter,
>> +				   struct igc_tx_timestamp_request *tstamp)
>> +{
>> +	if (tstamp->buffer_type =3D=3D IGC_TX_BUFFER_TYPE_XSK) {
>> +		/* Release the transmit completion */
>> +		tstamp->xsk_tx_buffer->xsk_pending_ts =3D false;
>> +
>> +		/* Note: tstamp->skb and tstamp->xsk_tx_buffer are in union.
>> +		 * By setting tstamp->xsk_tx_buffer to NULL, tstamp->skb will
>> +		 * become NULL as well.
>> +		 */
>> +		tstamp->xsk_tx_buffer =3D NULL;
>> +		tstamp->buffer_type =3D 0;
>> +
>> +		/* Trigger txrx interrupt for transmit completion */
>> +		igc_xsk_wakeup(adapter->netdev, tstamp->xsk_queue_index, 0);
>> +
>> +		return;
>> +	}
>> +
>> +	dev_kfree_skb_any(tstamp->skb);
>> +	tstamp->skb =3D NULL;
>> +}
>> +
>>  static void igc_ptp_clear_tx_tstamp(struct igc_adapter *adapter)
>>  {
>>  	unsigned long flags;
>> @@ -555,8 +580,8 @@ static void igc_ptp_clear_tx_tstamp(struct igc_adapt=
er
>*adapter)
>>  	for (i =3D 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
>>  		struct igc_tx_timestamp_request *tstamp =3D &adapter->tx_tstamp[i];
>>
>> -		dev_kfree_skb_any(tstamp->skb);
>> -		tstamp->skb =3D NULL;
>> +		if (tstamp->skb)
>> +			igc_ptp_free_tx_buffer(adapter, tstamp);
>>  	}
>>
>
>More a question: you are potentially triggering an interrupt from
>igc_ptp_clear_tx_tstamp() (igc_xsk_wakeup()) which can be called from
>igc_down(). So, how does it work when there's a pending timestamp and
>you remove the igc module? (example of a situation that it might be
>problematic).

Hi Vinicius,

Thanks for reviewing the patch.

There is test_bit(__IGC_DOWN, &adapter->state) checking in
igc_sxk_wakeup(). Since igc_down() will set __IGC_DOWN before
call into igc_ptp_suspend(), so I believe the checking in igc_sxk_wakeup()
should be enough to prevent the situation that you mentioned.

>
>
>Cheers,
>--
>Vinicius

Thanks & Regards
Siang

