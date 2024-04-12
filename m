Return-Path: <linux-kernel+bounces-142896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A78D38A31BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1D2B242E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279321474D9;
	Fri, 12 Apr 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="hdOe+AhU";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="cDDcouut"
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46605E22C;
	Fri, 12 Apr 2024 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934160; cv=fail; b=MX9aZ48ezSPn5emoam79+D4aocLpnGb1hwDbY71hI/voFqEZ8LL73ls8S/MpaZwHL+OLmBqjG1KZO6FjI2HPt7y9a2/paqPztAMcZA7P15YfitMxA/KAQ7BzqnP+z1n56Nmc9ftotXuKD67oP/uvqCSgmNqChsMvcaTtFurftcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934160; c=relaxed/simple;
	bh=OoB2LPT7km3Gpim48I+jXTOanY9H+p79SZf9y2miCLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cx8SwnUe47Uqaw+wUy+nHUexl+Qs2HWaI1RsEmTdf730EcwvYermNT0X8cLYnbjINYpsf/3pNK0U2A/5r67oZY7KRH8CwhvwAVr/ssr+sntmbHHC0DaOigWbjAsvg+b/l7E/wOiJfVjEdl4FB0iwgwcFt/mteIf46bkoVZD6HVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=hdOe+AhU; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=cDDcouut; arc=fail smtp.client-ip=173.37.142.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3633; q=dns/txt; s=iport;
  t=1712934159; x=1714143759;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=S+5mcYAF9vSpL7n2TYtGdHQPQkUHxzmwowY7JAJ2xIw=;
  b=hdOe+AhUQ+TOLDLA8JYmcKaF3s0JAIX7MxsEE177Ze66B85RgW8E4cCM
   CFqjhhS5OGzvfIN0reRcrjRlUY0NGYhAVxIY8+iO0pzR3xEi09hkBNkfD
   NN1NPICkGEhw4+hn7ZayTpJKL/pFuIQllgN8RYCtnr5WxHXtgqVVo9Zgt
   E=;
X-CSE-ConnectionGUID: /SJLd1TpRpuHkVzVoFy7ZA==
X-CSE-MsgGUID: prZrePQXQ7uj8PgJo/5Q9g==
X-IPAS-Result: =?us-ascii?q?A0AnAAApTBlmmIQNJK1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEXBgEBCwGBcVJ6gQcSSIghA4UthkqCBR0DhXqMZ4sngSUDVg8BAQENAQFEB?=
 =?us-ascii?q?AEBhQYCiBYCJjUIDgECAgIBAQEBAwIDAQEBAQEBAQEGAQEFAQEBAgEHBRQBA?=
 =?us-ascii?q?QEBAQEBAR4ZBQ4QJ4U7AQUsDYZZAQEBAQIBEigGAQE3AQQLAgEIGB4QECElA?=
 =?us-ascii?q?gQOIAeCXoI9IwMBpQgBgUACiih4gTSBAYIKAQEGBAXddQkYgTABiC0BiR2BH?=
 =?us-ascii?q?ycbgUlEhD8+gmECgWCGQ5QugjiBcIkNVH0cA1khEQFLCjQJOg8MGgIvDSQjA?=
 =?us-ascii?q?ixKChACFgMdGDIRCQsmAyoGNgISDAYGBlsgFgkEIwMIBANQAyBwEQMEGgQLB?=
 =?us-ascii?q?zg9gX6BPQQTR4FCihcMgzMpgVApgRKDLUJxhCB+A0QdQAN4PTUUGwYiAaA5H?=
 =?us-ascii?q?4FSSwJqOQgRXzqVea4FgTwKhBOiDYNyjH6ZMZhiozyFHwIEAgQFAg8BAQaBZ?=
 =?us-ascii?q?QE4gVtwFYMiUhkPhkGBBIZbGYNhohN4OwIHCwEBAwmKaAEB?=
IronPort-PHdr: A9a23:Hf5XLxVeHwLfFvjeMYq0NU9aYHLV8K02AWYlg6HPw5pHdqClupP6M
 1OauLNmjUTCWsPQ7PcXw+bVsqW1QWUb+t7Bq3ENdpVQSgUIwdsbhQ0uAcOJSAX7IffmYjZ8H
 ZFqX15+9Hb9Ok9QS47lf1OHmnSp9nYJHwnncw98J+D7AInX2si+0eG//4LaSw5JnzG6J7h1K
 Ub+oQDYrMJDmYJ5Me5x0k7Tr3lFcPgeyWJzcFSUmRu9rsvl9594+CMWsPUkn/M=
IronPort-Data: A9a23:YV/QlKknxofThFelVJHLEjjo5gxHJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIfXTiFM/vfamHwKd9+Ydzg908Cv5GHmoMySgRupSo9F1tH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaB4E/rav649SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+5K31GONgWYubjpIsvjb8nuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSq
 zHrlezREsvxpn/BO/v9+lrJWhRiro36YWBivkFrt52K2XCukMCdPpETb5LwYW8P49mAcksYJ
 N9l7fRcQi9xVkHAdXh0vxRwS0lD0aN6FLDvZkOdlcDK81X8a2bMwMt8MkYYLNIq07MiaY1O3
 aRwxDElZxSHgae9x6i2D7A0wM8iN8LseogYvxmMzxmAUq1gGs6FGv6MvIQCtNszrpgm8fL2a
 8MfaDdrcx3oaBxUMVBRA5U79AutriOiKmQB8gnO/MLb5UDL1j5r3YDUAOOKZ97afcp3mQHFn
 zPJqjGR7hYyb4HHlmHfrRpAnNTnmSL9RZJXF7Ci8PNuqEOcy3ZVCxAMU1a/5/6jhSaWX9NZN
 lxR9i0lhbY9+VbtTdTnWRC85nmesXY0X9tWDv1/6wuQy67YyxiWC3JCTTNbbtEi8sgsSlQXO
 kShltftA3lkt6eYDCvFsLyVtji1fyMSKAfueBPoUyNC2PvHrNgPlijXU/ZgLryLifPkRgPZl
 mXiQDcFu50fissC1qOe9F/Bgi6xqpWhcuLTzluPNo5Cxl0gDLNJd7CVBU7nAeGsxbt1o3GIu
 HwC3sOZ9u1LVMnLny2WS+JLF7asjxpkDNE+qQAyd3XC323xk5JGQWy2yGoiTKuOGp1bEQIFm
 GeJ5WtsCGZ7ZRNGl5NfbYOrENgNxqP9D9njXf28RoMRO8IhKlfdo3EyNRb4M4XRfK4EzPFX1
 XCzLJfEMJrmIfUPIMeeHr5CgeFxmkjSO0uJHcilp/hY7VZuTCXIEeheagTmghER56KfqwKd6
 MdEK8aP0F1eVua4ChQ7AqZNRW3m2UMTXMisw+QOL7brClM/RAkJVaSLqZt/INMNokigvrqSl
 p1LchUGmAOXaLyuAVjiV02Pn5uzAcYv8itjZXFE0JTB8yFLXLtDJZw3LvMfVbIm7+dki/VzS
 pE4lw+oWJyjlhyvF+whUKTA
IronPort-HdrOrdr: A9a23:o3PtoqmPevuMNAcPj7mtI2tOYvzpDfNeiWdD5ihNYBxZY6Wkfp
 +V7ZcmPE7P6Ar5BktApTnZAtjwfZq9z/JICYl4B8baYOF/0FHYbb2KnrGSswEIfBeOttK1tJ
 0QPZSWbeeAb2SS4vyKnTVQf+xQp+VvtZrY+9s2rE0dDj2CCZsQkzuRYzzzeiYZNWw2YabRVq
 DsmfavzADQAUj/G/7LfEXtKNKz3OEj+qiWByLuLiRXmjWmvHeD0pK/OR6e2RsVTjNIxpkf0U
 WtqWbEz5TmmcuWjjvH2UHuz7k+orbcI914a/Cku4wwEHHBmwyobINuV/mppzYuutyi714sjZ
 3lvwogF94b0QKVQkiF5T/WnyXw2jcn7HHvjXWCh2H4nMD/TDUmT+JcmINidAfD4UZIhqA57E
 sL5RPfi3NkN2KYoM3P3amRa/isrDvunZMWq59Us5WYa/pFVFYel/1DwKofKuZyIMuz0vFTLA
 ApNrCf2B6TGmnqMEwweQJUsYCRd2V2ERGcTkcYvMuJlzBQgXBi1kMdgNcSh3Ea6fsGOtR5Ds
 n/Q+9VfYt1P4UrRLM4AP1ETdq8C2TLTx6JOGWOIU7/HKVCP37WsZb47Lg8+envIfUzvdQPsY
 WEVEkduX85ekroB8HL1JpX8grVSGH4WTj20MlR65Vwp7W5Trv2Ni+ITkwojqKb0rkiK9yeX+
 z2NINdAvflI2erEYFV3xfmU50XMnUaWN19gKdyZ7tPmLODFmTHjJ2sTB+IHsuYLd8NYBKJPk
 c+
X-Talos-CUID: 9a23:tAcaQm1+nWRIX6SixLjp3bxfXfsHVnGE8G/qO1KYClh7drq7WACi0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AoQzBXAwM8ISSETcZoE89c/+nwVSaqLy0OloAqaw?=
 =?us-ascii?q?2gpaZN3xINBWay2mOE4Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-10.cisco.com ([173.36.13.132])
  by alln-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 15:01:29 +0000
Received: from alln-opgw-5.cisco.com (alln-opgw-5.cisco.com [173.37.147.253])
	by alln-core-10.cisco.com (8.15.2/8.15.2) with ESMTPS id 43CF1TfP007909
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 15:01:29 GMT
X-CSE-ConnectionGUID: nYTGjQHTSsSJhMMmXF7Y8w==
X-CSE-MsgGUID: rIcRjCOtQ0Cf07FWr3XZew==
Authentication-Results: alln-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=danielwa@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.07,196,1708387200"; 
   d="scan'208";a="7180059"
Received: from mail-bn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.41])
  by alln-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 15:01:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmKq9FhJuzRg75AfGURJPFmVNe5w8D6oblTr/2Slx/DcxVAkTzXgQf5GdQ93iGazEnakQkzeCwZ3LJonr/WbBbgHCbRVuIpPDPvqM7ZD21MD4PwIdPuHYuK7sXzlqj5To1oBpkd7iTvoenmwk8/KY2fmoTjausw907FkFYb1L5eX9+focl5UlW255z1KJuA6sp2hn5qq/S5tmcv0FYG4mzD+0k4dM54CAhpqKiWbtO+BHKSq+v5KJ6pLfUW0g9DygTLJHyUF6jBUNzb7QsIOcPMEro/ATf+A304gssHHSZFGHO6offdUP1kkfBjyGycuFlXoF+5E5zmkQmUo2KjbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+5mcYAF9vSpL7n2TYtGdHQPQkUHxzmwowY7JAJ2xIw=;
 b=QR5CG5/s2w/T3oEqsxBjmVqg1qDEduqUQkPgykAGx3HH1C3TqYjJqdpb8693LHizZlJy6SsB8NIOQQIIybyT7VIjKlGRhUOmYLMlFoAhE2SWHRpUEzggSOmgC7TSqJFbmkBLq6ICJmlD0cenYGyLD6AqQCIQci6we7x5SZs+WgFZHPlS41c6icjqfOpf3m5wBgsU7/mcnf9RZb0DKhejxUnfQWw2WRBDkGhBLwyjs5OpYad7y9B+sPdj5iPySYnoROubvMtiTLeT3tkEnL3XWixx/0LZC8nhm/t3Rmj6Qs24U4h3NOnEAeVd2hoz4lY77vqe9x5maoRTfsDQowrfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+5mcYAF9vSpL7n2TYtGdHQPQkUHxzmwowY7JAJ2xIw=;
 b=cDDcouutQenUGayk8x21sw/oVoVRi/PhYuIQXlaeH0mrTYnK0014t8pwUqO5mFlBuNUco0z946uaSWdKKNmKxIIiNkwW/n+j62A1WSQWbNTTIPKl3i1ECzrE4Fl0xpC5ou8PkAqhKUJbIYgdpJOy4HAVm43lNbmdxB2YMkjBG9M=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Fri, 12 Apr
 2024 15:01:25 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::22f4:4617:117:7a44]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::22f4:4617:117:7a44%6]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 15:01:25 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Nicolas Schier <nicolas@fjasle.eu>
CC: "Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)"
	<vchernou@cisco.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan
 Chancellor <nathan@kernel.org>,
        "xe-linux-external(mailer list)"
	<xe-linux-external@cisco.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Add MO(mod objs) variable to process ext modules with
 subdirs
Thread-Topic: [PATCH v3] Add MO(mod objs) variable to process ext modules with
 subdirs
Thread-Index: AQHajDWPNw0w9AAG+kK+xjeBwf3pzA==
Date: Fri, 12 Apr 2024 15:01:25 +0000
Message-ID: <ZhlMwQhlxm7QVlPx@goliath>
References: <20240405165610.1537698-1-vchernou@cisco.com>
 <ZhfLrGrED-ls6i5V@buildd.core.avm.de> <ZhgdjpE+yl3IYSzl@goliath>
 <Zhg5L2xO_lT4lLwp@fjasle.eu> <ZhhNAQtV3StbaA4z@goliath>
 <ZhjV90qSCPSyWiBh@buildd.core.avm.de>
In-Reply-To: <ZhjV90qSCPSyWiBh@buildd.core.avm.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|MN0PR11MB5987:EE_
x-ms-office365-filtering-correlation-id: 583d829c-3808-49e0-fdbb-08dc5b016c73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cgqIRRSSduOYu0T5Q7ikvWhQ6TcgQxozYQXwcAomxOo/kf3w6x1lkHUQpyK36RUQN/gWkbQHeCZ8zJIkD7tpzqUwEn83An28+ycDI5DA/suX29z5CXplOHe6sqPjBe+/+1+X0rYLOh0+UEREcKkqF1gVRE1k6Mi37C0SA4fL36bOFqJqLtaoR2EhlLq4xrdoQm3NI52y5WpwZeB87e2UAmoYSRwtYCuAxLBxH8ZPGnhju5p+lXp1jIUf/mhphvAkiNmF8aGw/nI7Von4mYkhvEiPmsjngfQbaiRkqVxMNDfVtAl3wcc7kfHtloLi1wYEthXOYsxGzBdof9M0GxEILX6DLFDIrMXBdQjH+4OlJP1a+tRTXV/znPSWD6JWzh55SJeXJ9ZgjEUKtz4X+mtUfTyC3GoYcJCd7VnJQPy6w7SPYpuzmGPpYcWcyytgn79X9TSOl5N4B6Gz2IY3mYeJVvDc+vyfC4Y3bZ+C2zUg4PzAbYjfuidnAPmryeo7PVNc7L+Hg5eTOySctoCLFHZFdWd2P+ZaEVHUXHt/VHWt3SOK4LZZ9TBIOVeqv9P9EMYQ9AjaJ4t+k93hUB270eq6nCzsUmTsyj2DovcfqBIvt+zaku+4CThnNdPkkAGmg9NrBe8hxpMKGMVLJDEaRXMsiciJyck0S+TOqvHKLhAo0LSHNlN6pLEc2NSwbscJs1RJ69nU3bvhkkkxaWvRB4VeJNgB40Taxf/1x7v9nfkSQzA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8ZMiDLqbyEiL1eeEkUYaOyF6zZBg4VTQAdmNsw70GAirvTkEGuxNVmWY0P9P?=
 =?us-ascii?Q?axpy5VpsGUoET3WYx2gnXL3MBpNzzZ7c7vRGQ0pZpF/D5va14Pl1XKgJP84y?=
 =?us-ascii?Q?D5894wlPeFRRAbDuIuSZOivN8azhW9KJ8zIkGxwWZjM22RkzqQInBMt9YQ7Z?=
 =?us-ascii?Q?uukJwmilFL6IprSlX0bX/9MUS5F2kyx8eCNgDHGj+5GMijMmvG6VRVYGBfYl?=
 =?us-ascii?Q?OCgKgx5ZRPJP6H7nv8hHvdEVLs3ABhwV3ZcysQFUgFzjVmEziDzD3wqWIUbt?=
 =?us-ascii?Q?31AD3ltuQwffCrdHCI6shJSm3NtNgzSo3EI6f3utPcMylItKzwWyNp0jwil1?=
 =?us-ascii?Q?tS5EjhOvdwtvm6UkzlkN06WLCcnmRyQujkhoO9mxW5LybmM6GFpHyOH+QG6l?=
 =?us-ascii?Q?Bg5sWabUZltSyHtpcYDs9Ggd47I/9xMDcVUFb9j2U4aMgm5WdHR6AQ/NoFWW?=
 =?us-ascii?Q?HnOK4PkaTiLyqnj5IwpLqIgXnCMWUQGa7WAAUahFcZI90R/S4EBCFCytDTs2?=
 =?us-ascii?Q?EaYKu/LJeRzFVOg/Ai7PoLwCkdeDNjxFD/l01/G5Fy3J1MIN5CO9a4jT/FD5?=
 =?us-ascii?Q?bXZJfaCnsoTohz9jW4/s5ptAtyYSq0kVvDy9T7k4NouRveoI1Cl7pVvjP44Z?=
 =?us-ascii?Q?BnSwk1iwP7bHzeIjwWCkTWqF77cEWTWssiEtLW/iWKa5GiqDKHut50oAPVgd?=
 =?us-ascii?Q?90cbxeduKrfzeqiThV+eWFkEre/8SqcDXsA6WO7m4+mwbJ/mMAd554njmkkF?=
 =?us-ascii?Q?Sp/MrFCOiFvgFqgwnxXzmU4gHU2Ih6/W8xTLWdcBWJxKhTxNsohOtHM7a4Ai?=
 =?us-ascii?Q?IsiyX2mhci9VGyO+Mn7kxpTvJ91fXJBu7AXH8WKlIoR4DOgji6YOLR9ksXKt?=
 =?us-ascii?Q?hIdHY3EtMKhw9tvDTZiyYyxFG3m+/6vgZVbB+0+W+tTAD3zWYUzDoRHIzn9N?=
 =?us-ascii?Q?T010cbIBDEKDBX832WDEuZHj1Qq69Ehm6cOOmv4vWAjduFhQRf/MCeZyv4sA?=
 =?us-ascii?Q?Ykg7jpOJZPjq3uk8ttqlACcWC/pXPFt9YxE5PpIm0VnDht9k74cI8nUJ/vv7?=
 =?us-ascii?Q?v4eKLvNRRy/IvHf6AW/hHCT3lz9A+0jPDd9lDkEHJ9sqg/mhY3Gn/TDn8tua?=
 =?us-ascii?Q?6x8f0PCJYM73uXcRpPygtTxGTLWUumzN1UTdaMfJIPbcZPdGSPU1F+mliXsp?=
 =?us-ascii?Q?t/ojPZZb+ydiBRjFXNmsgQSzZmvFFHU13wA9x2uDhWQKHGY7ugpgxOYoYanZ?=
 =?us-ascii?Q?YzT5pkzODIHfMMcj/QXPldkuI5oJurn3cDHVPVRNxopXfGYcpxhjPOSQoDOC?=
 =?us-ascii?Q?rMUnUMcuQv8IAcoAeUmKnLlMcp6oXgn5Em9bnCYkeYJhuq7eSDt2r79OOkxG?=
 =?us-ascii?Q?mmnuFcFm10/wnWR7QEYNwIMqrIIzyuWumjrsym9BrSrGg87yg0+njv3L5XDx?=
 =?us-ascii?Q?Gsxo4ZaYYmKMnkHBzHr7aZBxHsKAf7DVlHW0qPgUpY+EGQK7pON8H0qb0n2/?=
 =?us-ascii?Q?t8lHACO/6gmPo01aQQ0PIDUpLfSxJ7NFQxv+fZqWVKhwns7sS+Qu2SLLuB2J?=
 =?us-ascii?Q?HKadIJ6+Ia78FRjS8saaFEYZ47xjglIkFbAtCB2h?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0802039DF443144FA304F1ACFDA4C645@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583d829c-3808-49e0-fdbb-08dc5b016c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 15:01:25.1831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OSi3aK6wjRD5oEPP1/SOaU+hxOrRyFn3T8JlZVxk7V0p5FCriNdHZ6EO0f+ot/xDyTuE/kmR17VHudmNlhN1VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5987
X-Outbound-SMTP-Client: 173.37.147.253, alln-opgw-5.cisco.com
X-Outbound-Node: alln-core-10.cisco.com

On Fri, Apr 12, 2024 at 08:34:31AM +0200, Nicolas Schier wrote:
> On Thu, Apr 11, 2024 at 08:50:10PM +0000, Daniel Walker (danielwa) wrote:
> > On Thu, Apr 11, 2024 at 09:25:35PM +0200, Nicolas Schier wrote:
> > > On Thu, Apr 11, 2024 at 05:27:42PM +0000 Daniel Walker (danielwa) wro=
te:
> [...]
> > > > If that were true we would not have driver/uio/ for example. It see=
ms like
> > > > Cisco and NVM should work together produce a solution.
> > > >=20
> > > > You could run into this issue even with entirely in tree modules. F=
or example,
> > > > we may have a v6.6 kernel but we need some modules from v5.15 for s=
ome incompatibility
> > > > reason in v6.6. Then we may build the v5.15 modules as out of tree =
modules
> > > > against the v6.6 kernel.
> > =20
> > All problems should be fixed or worked around. One bit of code maybe is=
n't
> > the best choice or maybe another is, but not fixing or working around t=
he
> > problem is not really an option.
>=20
> Let me sum up: It is possible to build out-of-tree kmods with subdirs
> in their source tree.
> The patch attempts to put support for _out-of-source builds_ of
> out-of-tree kmods with subdirs into kbuild itself.
>=20
> If you really out-of-source builds for your complex out-of-tree kmods,
> than, as a "work-around", you can simply put those 'src' override lines
> into your oot-Kbuild files.  But you probably know that already, right?

I tried "make src=3D..." and Valerii also tried it.  I think that's what yo=
ur referring
to. There must have been a defect added which prevents that from working. I=
t
has some sort of recursion issue. It seems this method was not "official" a=
nd
only work by accident.=20


> > > If your in-tree module in question does compile and run properly in v=
5.15 and
> > > in v6.6: why don't you just compile it in-tree in v6.6?  Which driver=
/module do
> > > you refer to?
> >=20
> > I believe it was this driver drivers/crypto/marvell/octeontx2 . I don't=
 recall
> > every aspect of the issues but it has to do with what Marvell supported=
 in their
> > SDK and the exact hardware we were using and the bootloader we had on t=
he
> > product.
> >=20
> > > > You also have just normal developers making kernel modules which al=
ways start as
> > > > out of tree modules before they are upstreamed. Those modules could=
 be any level
> > > > of complexity.
> > >=20
> > > I do not agree, but there is no need to convince me as I am not in th=
e position
> > > to decide between acceptance or denial.  I just thought it might be f=
air to
> > > warn that I do not expect acceptance.
> >=20
> > I think it's incorrect, unhealthy even, to look at it that way. If your=
 using
> > Linux to make a product and you have an issue, it should be consider as=
 a real
> > issue. Not something maintainer can just discard. Unless the maintainer=
 has
> > a suggestion to do what is needed or different code to do it.
> >=20
> > Daniel
>=20
> Daniel,
>=20
> I am confused about the outcome from your argumentation that you might
> expect.  And I think, I as a spare-time reviewer (not maintainer), am
> not the one you want to argue with.

I don't care if your a maintainer or not.

> If you have a concrete technical issue or bug, please explain it
> concretely to linux-kbuild and we will probably find someone trying to
> help you.  If you want me to hide critical thoughts when reviewing
> patches under your pillow, then please tell me so.

I don't think it's critical thinking to effectively tell someone to stop
submitting code.

Daniel=

