Return-Path: <linux-kernel+bounces-34260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FF6837685
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DF61F27E53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8F611C8F;
	Mon, 22 Jan 2024 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="Y1aD3MeF"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FD810A04;
	Mon, 22 Jan 2024 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963777; cv=fail; b=r0XsgtSQ7Pq2xFxRiBGrJKvDcLTbi1Ah8ypRX5mK3E9lLMci+MzVLT33WroU67LGYQLq1GXTvEsDyumAKJamMMjTdZ8yKxQ2cWglmbdEeubC9pqWrfn2dWh1L6K/+Puot9Vx6nidobip7TQOfAsPJUV5h8BckorzGvSb7FbHTBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963777; c=relaxed/simple;
	bh=Vl1iOS4P0O9XujMxhCA86TN2+B4paYmrtEgyegRto60=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LhoflWZs6hr7J07qKU1dx8rAHv/mSV6jIWDdeoWahreL5XO5XZOvu/1RLaSB+/gGIM1gumy2r21e4BRGWUSvN+hrmozVUW9PPdONtRPp+K8rqhw0Dp1S2Q0J8iulAvPk5rXCIWsiXHEL6WfLUtjhVyWiF3Wz/Yf3xHJ9J0OOUH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=Y1aD3MeF; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ce/Z0BtxRZR2I4sofi1z46g+nV/LdFSuY/86PvvFWu5zZ4jyNTn2obMtAjp7y9CbJ0fsxxv/C6QHrJ07BTu3wmTbFTRzjs5DZW1Jsfplaw/tgLt9z1/WYqfoVFXIdytH/Y1g1p0Go5vsLRfTt0ar3SX7zM4jGxWYZtHQfMlFQimC/8ILwEUZJUbvNwyySKk9gLe4ePm72y9TAUOs/LaL6pin8GIpW3hlChF7kwdDsGPRehdS0dLl9PEj16+KMK4miNlwxovUrY26yZwyeWTb0/L8tUk/DLQP80nuhk6K7hfmFCcALsWaQQvV79VrUq528vJ28Nl9SJhS4j0hobZwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubLbj6SJ6B0R4kEYjpaa06DsUaGogaCYoFs0Mlc0eXE=;
 b=CnTNV+RBY6dwuSAQARK4pwUJHmGguKGttDPbLUoQqfggtfdLvafyFcGPZpskwtLv6pLqVJW17BtG4vclcXjCV+6VV6EEp+F2O3s7V/oLNPKrxrqOFEPNojTCK5fUU+e+k9F7Gt4KR48A+sP9k8aNCmKQK7OMrDxXKemLnBkj7v2j4AO6jtVoZoHdEK9LiI9nkY9VSqQ83Y3uAiAXSG+CkFQFbMkEjd6drvmR1390GoeR7sn9roHHgEPCt//GC4W8JTbHQYCpl9P+DPHVUOIRNtoTxKqgH507kyus8JrH+fzk9YMMGH2IraSENHEj4kwwjUfvnuSrqwH0+dG0PcFg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubLbj6SJ6B0R4kEYjpaa06DsUaGogaCYoFs0Mlc0eXE=;
 b=Y1aD3MeFWDY6cdqxXomrC/tnU1sqi3XrjWKXXx8nwCTsMqpDhzVuAwfouBdA7ZXf4ahaiPGixReGjzoXCMaqCbl3Nh9Y4Ua062xtx3/4SAXlS+AzNi/JlB7Nyp2c50GOvxGJHqJ9/Z8RbAj+IZYYouaUzLuniLXLhnK+HuIQIze+0F4Ihm3QJxtYjh8BcFFDQqIMARmtyoAQ3GApl5eHKkVaLV2wBqeq+xyL1gCBpndO9SVONTzgZosU9sgITGRvf5khzY9ZerWMyvKUk646/vodsNbE5sQTnMXprxg4xwTwSnFPmRvjDxTtvnvpUDi3v4TSWzrDG+nupgnLDFKSbw==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by SN4PR10MB5800.namprd10.prod.outlook.com (2603:10b6:806:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 22:49:32 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::4d76:4230:708c:9eea]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::4d76:4230:708c:9eea%7]) with mapi id 15.20.7202.033; Mon, 22 Jan 2024
 22:49:32 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "quic_charante@quicinc.com" <quic_charante@quicinc.com>,
	"david@redhat.com" <david@redhat.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"mgorman@techsingularity.net" <mgorman@techsingularity.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"quic_cgoldswo@quicinc.com" <quic_cgoldswo@quicinc.com>
Subject: Re: [RESEND PATCH V2] mm: page_alloc: unreserve highatomic page
 blocks before oom
Thread-Topic: [RESEND PATCH V2] mm: page_alloc: unreserve highatomic page
 blocks before oom
Thread-Index: AQHaSjMflGKjL/PHykO7afANQUWSRrDmIBoAgABNFaY=
Date: Mon, 22 Jan 2024 22:49:32 +0000
Message-ID:
 <PH0PR10MB461565CEE892267025BC697BF4752@PH0PR10MB4615.namprd10.prod.outlook.com>
References: <1700823445-27531-1-git-send-email-quic_charante@quicinc.com>
 <3fe3b3edd33cd784071dd9b459d20a79605ec918.camel@infinera.com>
 <2024012205-undrilled-those-2435@gregkh>
In-Reply-To: <2024012205-undrilled-those-2435@gregkh>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|SN4PR10MB5800:EE_
x-ms-office365-filtering-correlation-id: 4aa203c5-be9e-429d-0a41-08dc1b9c6629
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FEqIeY4wL6uFyV2QdpxJlo5bV4M/qLlTVXkrJZNF9puGQ6mWEI4WWw9kAx0fYkrsLV7FAn0pffqcRi3domvQvdsPSfNEEX6BS2fkeTzqcRi3f9q/IleWOiCW7Oub/CroyeuMs8qflxP5yINBfqu4sQQeD3kC1tSjURCb8WwblAGNyFm7q/y66w7C/OX9bAqSWzyMg/WyiS4uBx1Dxa5rj0vsp3YlHRjiulxU/c9gidH3+9TwcLtIlGNlOLh4oP2YLgE8tr12Sy5pSw4x1Z1Id0+TPo1pbDGxczW+KVhACYLtPuIpq9mlkO9wbwwTgL/s3ERpyQHOQ+9zSzpWYXsMXveNjsc0OxWdv8vYx9ThKgyH/A81z8+fIIBwUxd0gzGnTNi1GTMV5fhSPTy18JwmBDMf/2sfLKwFJ+JAQlGTfvpGO0RxElHC9iCsZpZ2lL7FpFD6Mj24GmFFUp+ahuCOycvvCzdEcS7qBTxARYXpmYRj7DnDJSq4ksy6adePxJsLUlaolYGtgeeWSjgQLF31XbHEpChYoWCa65NHYqruT1vTSLcyhRZEExyiJ4OmWrZ8td2MYf/YvHvJdvcnLKW+Uz8De3DOqSqZ5MGqPQh/paCPOvYsG+dqdEuRkh6qazuN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(71200400001)(83380400001)(38100700002)(26005)(5660300002)(53546011)(8676002)(9686003)(41300700001)(122000001)(4326008)(8936002)(52536014)(478600001)(7416002)(2906002)(4744005)(316002)(66946007)(7696005)(64756008)(6506007)(6916009)(91956017)(66446008)(66476007)(66556008)(76116006)(54906003)(86362001)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RlKENTAJKpsOKmBvBWDxiHc6GoOJZh1XQwamv5zsDpZqRaaEUlSaxZJ0D9?=
 =?iso-8859-1?Q?y5Aq05YgfYsHd3wWmJcv6JNYxJDsLGMg+ur2nAAi2hOWrE+lnsy9uU1LqE?=
 =?iso-8859-1?Q?0Jlv3oA9d5OHweEQF/BghJoRBP7iJp/gBZv/FR/Lcmyfhg2XR0opRCk/TC?=
 =?iso-8859-1?Q?25iXELjl+dxWaXV2tpo9ldZwG3A3qtNY034sQ+gy++Zz61IsOQmgjOoX0c?=
 =?iso-8859-1?Q?L6lVKH7rWxGmmNHqOA8xb86V7UYI91ZECPw4DhFRu3r93d9SWkQlajp/Lv?=
 =?iso-8859-1?Q?NA4Yl4lA//OzervQjgOdWAD9krgUiX1sqdFowdLc1J88ClFnVjWS3UPPqO?=
 =?iso-8859-1?Q?hD/2ZCmvd/m82pq2t6drki6rDa9iXENUQ4FLBZ8QbWGohpMqu84WWi/Vn2?=
 =?iso-8859-1?Q?79PgCipz8BGxs1XoggUOqnzKxGWlLxB+tV2MPo/UtY5PWkO/GWdEbtO/08?=
 =?iso-8859-1?Q?pvvkq5TCMWrFBW8ZCc38Q+hiJVg3y3NkRzYstYa3t6aSChwK0KlWhGDPd2?=
 =?iso-8859-1?Q?LG3A9NUMlIoTGEmSLUTiSU81Uh/LKdIU4pvd8cT3mAYglVhtkWfFS19bR8?=
 =?iso-8859-1?Q?k8rKlJDP1vLOMI3BdvbwD9iucqdGzLAJ1uKZ/mylHhwuIM0baJSRI5slCj?=
 =?iso-8859-1?Q?n9kXXW7amN4k7crTy/V8LFALbjZh281lcAvML7D6kLTbVnf5QIFPCDBaQX?=
 =?iso-8859-1?Q?nu3j9YPYhg4h6oMzByKoIAT1niBHuXTLXP4nCnxQF9G3rvsDT7Wy19VVg9?=
 =?iso-8859-1?Q?2k7d3vsEqT/G2P+v+8ed0Y+osrKO8kV8Iy0Ys17ewcIm/7r4iO3kxUF/XP?=
 =?iso-8859-1?Q?e+1a7FXbxl4HKm1zo+iCCB9HZtn9wVckZYKJn8YlHCjiDUXJU6ee9qC41t?=
 =?iso-8859-1?Q?DPv4/rxGDaaRuAg98Ay1PXuKm9yYgVcTRDsxFdC3FiKemIdB81/4y+0pH6?=
 =?iso-8859-1?Q?HY3XKGG1bPhwuKUAwLwt2PlXLutjzC1M/e+akwxD1wBo6ecZvP+1mCtFUN?=
 =?iso-8859-1?Q?YKUK3Mkb2yNv56eCxUPxG0neNi9zNhh9BFapWi5VIMxjVu0nwTb4Up1kJi?=
 =?iso-8859-1?Q?OdxPjoiWoZDgAn54MY5wo/BpYuL3LBzivuBXePZ4cTqL/Ef36qSTw8wq2Q?=
 =?iso-8859-1?Q?chbohMBFaaAnDBfyLM1oL8XxAGvpEW/UY0MbNqIWxibJoxXgfNwzggpnmC?=
 =?iso-8859-1?Q?LHe4nefEg3GAz+ZRxUKHNOOJe6ecqPAannjgPb44YC7KdpJkbLxjwHmTwz?=
 =?iso-8859-1?Q?/uGKYocmXrYQ2F2a1Adzu+N5G84MHjdxZ/ffMxHHtzB6x6qdAEm6vVVRdt?=
 =?iso-8859-1?Q?ASreB4cj9Q0wHwlpZ5rOx0yvY6nvw9rEJD4XNvoWlg2uzRR/B5G293MKyp?=
 =?iso-8859-1?Q?3OcTH2GtnPUJEffZ6TsutJbrYtruOMDwPdqQPRJ/ry0cEEfFvemU6lwWLp?=
 =?iso-8859-1?Q?Va7q848YKNW7D/uAuuCbVlevabsCJMtRQx7bEHb0g/dLpZ84BrWjbX3L8P?=
 =?iso-8859-1?Q?LHd0YdQAcbvys0beYwV7cy9zd7foOiogF+v3ung8H5fiFgtLcoRtkFL+zS?=
 =?iso-8859-1?Q?8q+ugcL0C1o6QmSLSrwkz56qGqU860Y0jH4WkG8kulkGqUtPMh4x/b4jrQ?=
 =?iso-8859-1?Q?2AWZmChPoLnoWegVBbCL0wET5dIfHXMiAv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa203c5-be9e-429d-0a41-08dc1b9c6629
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 22:49:32.2102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4yZ4pKFp8IQ148uOlru6yb8i9a9nOfirgF3x1bf9BVYtvKcxcXdbVoFhg/R52XBQHY/M2vqiQb+ASGGT/GCxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5800

Seems like I pasted the wrong commit(sorry), should be: ac3f3b0a55518056bc8=
0ed32a41931c99e1f7d81=0A=
I only see that one in master.=0A=
=0A=
________________________________________=0A=
From: Greg KH <gregkh@linuxfoundation.org>=0A=
Sent: 22 January 2024 18:41=0A=
To: Joakim Tjernlund=0A=
Cc: quic_charante@quicinc.com; david@redhat.com; mhocko@suse.com; akpm@linu=
x-foundation.org; linux-mm@kvack.org; hannes@cmpxchg.org; mgorman@techsingu=
larity.net; linux-kernel@vger.kernel.org; quic_pkondeti@quicinc.com; vbabka=
@suse.cz; stable@vger.kernel.org; quic_cgoldswo@quicinc.com=0A=
Subject: Re: [RESEND PATCH V2] mm: page_alloc: unreserve highatomic page bl=
ocks before oom=0A=
=0A=
On Thu, Jan 18, 2024 at 05:23:58PM +0000, Joakim Tjernlund wrote:=0A=
> Could this patch be backported to stable? I have seen similar OOMs with=
=0A=
> reserved_highatomic:4096KB=0A=
>=0A=
> Upstream commit: 04c8716f7b0075def05dc05646e2408f318167d2=0A=
=0A=
Backported to exactly where?  This commit is in the 4.20 kernel and=0A=
newer, please tell me you aren't relying on the 4.19.y kernel anymore...=0A=
=0A=
thanks,=0A=
=0A=
greg k-h=0A=

