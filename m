Return-Path: <linux-kernel+bounces-144905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F87A8A4C75
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D5AB226D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4C355761;
	Mon, 15 Apr 2024 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Dp40vcL9";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="jX1dzNgG"
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A8E29CF1;
	Mon, 15 Apr 2024 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176557; cv=fail; b=k2hIfqKs2RZP48NJ3LyNjmbscKO1OSb1yGBJi3d5QEu5eSb4rq0CUfYeD/3sk5NDMW914OtwnUMjse9t9DBgv99vuMR6lP4yEhy2qwDMqpgWwCewoWPl7Uu2p0RioJW8DkyGX4/W6RO4BMce6wkBJDj+2NanVJJUFf5OJWpZvLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176557; c=relaxed/simple;
	bh=17A5svmAxsRP3K2W0XVkpaKsQ7/1eNo1U1+xIXYyBOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dWLTQHgxbwRoMynMhhFG75LnnaW2A+40d8P3gT5tTHIhGXuUSOtMeXKfxsPgT0Nh5ZOtwJy0ZxHlToA80U4LBRYZeFZ1VrAWmxSgZK2CK+mMTpRHX9XkupSNjXuI6yEOvErchtxx/CRHekofhM0He0e09tvahTU8Gna5X1uWv2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Dp40vcL9; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=jX1dzNgG; arc=fail smtp.client-ip=173.37.142.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=8537; q=dns/txt; s=iport;
  t=1713176555; x=1714386155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YLNyoQLXRDqTZ6syzbt7WInkn4fxRINZmcrJDnNmPQE=;
  b=Dp40vcL9SlPsKJuoU0k8UtFFCWSGzsnxTHen9EH1UBydf3NwC/RlWMdp
   tsvmSy3PGRtfANJgfuEUknbxXCZJE6va2ztQYEC5DxHv4AmlhWN9fX/rF
   DvaQGEXHYQkCaA6IDqERThT1kMTebgbyk2zlQNs857fiLA1a9IjKvVob3
   4=;
X-CSE-ConnectionGUID: 5LLXQLGPQp2yrmxKD82NSQ==
X-CSE-MsgGUID: aqj/j9IgRYeC4H+nqZKSJg==
X-IPAS-Result: =?us-ascii?q?A0AEAACx/hxmmJFdJa1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUAlgRYGAQEBCwGBcVJ6AoEXSASIHQOETl+GSoIiA54IgSUDVg8BAQENA?=
 =?us-ascii?q?QE7CQQBAYUGAogXAiY0CQ4BAgICAQEBAQMCAwEBAQEBAQEBBgEBBQEBAQIBB?=
 =?us-ascii?q?wUUAQEBAQEBAQEeGQUQDieFbQ2GWQEBAQECARIoBgEBNwEECwIBCBEEAQEfE?=
 =?us-ascii?q?DEdCAIEDgUIEgEHgl4BgjwjAwEQpiUBgUACiih4gTSBAYIKAQEGBAXddQMGG?=
 =?us-ascii?q?IEwAYgtAYo8JxuCDYFXgWaBAj6CYQKBYAKEEoIvgRh/jlOHIhmDRRAthUpUf?=
 =?us-ascii?q?RwDWSERAVUTIg8MGgIbFA0kIwIpPgMJChACFgMdFAQuEQkLJgMqBjkCEgwGB?=
 =?us-ascii?q?gZbIBYJBCMDCAQDUAMgcBEDBBoECwd1gXyBPQQTRxCBMooSDIMxKYFOKYERg?=
 =?us-ascii?q?yFLcYQbgTkDRB1AAwttPTUUGwUEHwGBGAWcbAGCHmE+PgMRGxAgCSQNFxs5C?=
 =?us-ascii?q?A0eDAovPZIuZgKCYK9BCiiDa4wOlVUXqjSYYo10l0iDHwIEAgQFAg8BAQaBZ?=
 =?us-ascii?q?DqBW3AVO4JnUhkPjiAZg2GFFI93eAI5AgcLAQEDCYZIhCABAQ?=
IronPort-PHdr: A9a23:5s5YXhOkKwpg1feM6DUl6nfPWUAX0o4cdiYP4ZYhzrVWfbvmpdLpP
 VfU4rNmi1qaFYnY6vcRk+PNqOigQm0P55+drWoPOIJBTR4LiMga3kQgDceJBFe9LavCZC0hF
 8MEX1hgrDmgKUYAIM/lfBXJp2GqqzsbGxHxLw1wc/r+GoPIicOq/+uz4JbUJQ5PgWn1bbZ7N
 h7jtQzKrYFWmd54J6Q8wQeBrnpTLuJRw24pbV7GlBfn7cD295lmmxk=
IronPort-Data: A9a23:ivPSYaM7ltzY6kDvrR1hl8FynXyQoLVcMsEvi/4bfWQNrUoh3mFSn
 zNLXm6OP/nfYmekfI0gb9jl8UwEvJ+AzdFiSnM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCdaphyFjmF/kvF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/W1zlV
 e/a+ZWFZAf5gmMsawr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQrl58R7PSq
 07rldlVz0uBl/sfIorNfoXTLiXmdoXv0T2m0RK6bUQNbi9q/UTe2o5jXBYVhNw+Zz+hx7idw
 /0V3XC8pJtA0qDkwIwgvxdk/y5WYIliyIbjDkCGqZaC1UjWUFe8mdNVNRRjVWEY0r4f7WBm7
 /cULnUGaQqOwrPwy7OgQe4qjcMmRCXpFNpA4Tc7kneIVrB/Hc2rr6bivbe02B8ujcBDB/DZe
 uISaCFka1LLZBgn1lI/Us9lxLv42CWiG9FegFuMp+01sknc9j18++TNc9zMSP+xZ8oAyy50o
 UqdojymWUtFXDCF8hKB83SxlqrMkDn9VYY6CrK17LhpjUeVy2hVDwcZPXO/oP+kmguyXNl3N
 UMZ4GwtoLI0+UjtScPyNzW8oXiZrlsfUcdRF+ES9g6A0OzX7hyfC2xCSSROAOHKr+csTjAsk
 1SOhd6sVHpksaaeTjSW8bL8QS6O1TY9cEsmVRYgYjM8+4PyuoQjrT6fFPBYKfvg5jHqIg3Yz
 zePpSk4orwci88Xyqm2lWwrZRrx9vAlqSZrvG3qsnKZ0+9vWGKyi2WVBbXz9/1MKsOSSUOM+
 SlCkMmF5+dIBpaI/MBsfAnvNO7wjxpmGGSA6bKKI3XH327zk5JEVdsOiAyS3G8zbq45lcbBO
 Sc/Qz956p5JJ2eNZqRqeY+3AMlC5fG/TI+8D6GIMIsQM8MZmOq7EMdGOBX4M4fFzRlErE3DE
 cbznTuEVC9FWfo9kFJauc9Hied0rszB+Y8jbcuml0v8i+X2iI+9QrYeO1zGdfEi8K6Bu03U9
 d0ZX/ZmOD0BONASlhL/qNZJRXhTdCBTLcmv+6R/KLXZSiI4Qz5JNhMk6e57E2CTt/4Lxr6gE
 7DUchIw9WcTclWccFTaNSg7MeKwNXu9xFpiVRER0Z+T8yFLSa6k7bwUcN08erxPyQCp5aQco
 yUtEylYPslydw==
IronPort-HdrOrdr: A9a23:Gybgmqscb1Vx+wSLg/ntQ7JT7skCBIAji2hC6mlwRA09TyXGrb
 HMoB1L73/JYWgqOU3IwerwSZVoIUmxyXZ0ibNhRItKLzOWyFdAS7sSrbcKogeQWhEWk9Qtt5
 uIHJIOdeEYYWIK6voSpTPIberIo+P3s5xA592us0uFJDsCA8oPnmIJbjpzUHcGOzWubqBJbK
 Z0k/A33QZIDk5nFfhTaEN1OdQrjue75q7OUFotPTJiwg+Iij+j9b79FDal/jp2aVly6IZn21
 Lo1yji6Iuek9zT8HLhPmnogKh+qZ/E8J9uFcaMgs8aJnHHkQCzfrlsXLWEoXQcvPyvwExCqq
 iInz4Qe+BIr1/BdGC8phXgnyP61iw11nPkwViExVP+vM3CQi4gAcYpv/McTvKZ0TtmgDhP6t
 MT44urjesOMfoGplWn2zH8bWAtqqNzmwt5rQdctQ0DbWJUUs4jkWVWxjIhLH5HJlO51Gjie9
 MeU/01I51tAA+nh3y1hBga/PW8Gns0BRuIWU4Ep4ic1CVXhmlwyw8CyNUYhWpozuNwd3Bo3Z
 WPDk1TrsACcuYGKaZmQOsRS8q+DWLABRrKLWKJOFziUKUKIWjEpZL76Kg8oLjCQu1H8LIi3J
 DaFF9Iv287fEzjTcWIwZ1Q6xjIBGGwRy7kxM1S74Vw/rf8WL3oOyueT01Gqbrun9wPRsnAH/
 qjMpNfBPHuaWPoBIZSxgX7H4JfLHEPOfdl8erTm2j+6v4jBrea/9AzKsyjU4YFOQxULF/CPg
 ==
X-Talos-CUID: 9a23:J1vyWG+5B37JfaqGIWmVvxMwPvAcVlLl9W+KMlW9GUVFGOezcmbFrQ==
X-Talos-MUID: 9a23:+l5OsQYkuS1CaeBTvibuwzMzFchS0qmFVGBOl4w0mPKmOnkl
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by alln-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 10:21:26 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
	by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 43FALQun021190
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 10:21:26 GMT
X-CSE-ConnectionGUID: jAP58JI8RzGgOS5vbj3HGw==
X-CSE-MsgGUID: j6maNpyhT8mhjqXoNC7kiQ==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=vchernou@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.07,203,1708387200"; 
   d="scan'208";a="12322109"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 10:21:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F01tuF6t4ZxWadofzWj+Q5TNGtX2lpXEEtrs8VGG7kkTSY6V5RQ1dz5C9CoptJGtqGPmkFWWDBzOM+vKdcfX0KSwlfTNlaiQ9Npbk0SPhS4xev6WAUGOejjMGrCa82gYVY0kiZjjKlkZ1TxkiOO9NALRLsb3At745W3sjPXoXMKRnUgDrwqnWryfyADCwLigiWj1sm3wWyPpnB6fM6LJAactdkaTnmerjrX5c5yvN98wiag6TmqE8TCUwljUWzh/xZ0+PcVNO8jDUbbDbf/Aew1sGVranMWYJdcyHffAYOfwApBP4BFEVoDx0rdteAJ5Apqsk5PXm7oWQ75iSYPXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLNyoQLXRDqTZ6syzbt7WInkn4fxRINZmcrJDnNmPQE=;
 b=nChDqD7VxLLhwduw2LcP2q5Um9MmZLtgMndcPcQl/br1oqwZY0WsobjMAS97Jepn4H/HQl/mNAL5+T1RZQ76+99sF0U0PAe3iCQSvtg6alPPKdGyhnkjRkQlP/kbpsf0+9CDEAQyMOepf7hC0kKHJgM0D/02lrLmvjVim+mX15NhYSmnOqTk96eDeuknG5vMNQpKBRdFoLQUcqmKIMjsl3/KtuK4JgAHxYpYtuak7eoDtOSoBGsMlBdRjLSMDEfD0AWdaLKKxYg4XfFKWZWnl7V6DgBirMKStKBi2VNM3m1tihoXXmAOJeD2LsOv/gWi+145ZZ8XaM5354CwbJsY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLNyoQLXRDqTZ6syzbt7WInkn4fxRINZmcrJDnNmPQE=;
 b=jX1dzNgGbGyP7w+1IrMECToqYh5y0Yn38t0w1Q7Y0I6zpILkMEYl0WQYQX5q0N6cqnTwiGLAVBl2lWnIA5hSQnCYQkfQBhs/GOeL8vMIzhSlFtiftv36V747GkdUBu392kRkeBaEul7ZJy8nk73iBPENe3SWDIl1x6t8p+Zfdl4=
Received: from DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) by
 PH7PR11MB7049.namprd11.prod.outlook.com (2603:10b6:510:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Mon, 15 Apr
 2024 10:21:22 +0000
Received: from DS0PR11MB7765.namprd11.prod.outlook.com
 ([fe80::d142:4626:e291:96cb]) by DS0PR11MB7765.namprd11.prod.outlook.com
 ([fe80::d142:4626:e291:96cb%7]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 10:21:22 +0000
From: "Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)"
	<vchernou@cisco.com>
To: Masahiro Yamada <masahiroy@kernel.org>
CC: Nicolas Schier <nicolas@fjasle.eu>,
        "Daniel Walker (danielwa)"
	<danielwa@cisco.com>,
        Nicolas Schier <n.schier@avm.de>,
        Nathan Chancellor
	<nathan@kernel.org>,
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
Thread-Index:
 AQHah3oweea7kfF3nUimhkbf9/nABbFi+owAgABhnQCAACDwgIAA6GrcgAMcjICAAatimQ==
Date: Mon, 15 Apr 2024 10:21:22 +0000
Message-ID:
 <DS0PR11MB7765C2C39C92B3A23188E0DEDE092@DS0PR11MB7765.namprd11.prod.outlook.com>
References: <20240405165610.1537698-1-vchernou@cisco.com>
 <ZhfLrGrED-ls6i5V@buildd.core.avm.de> <ZhgdjpE+yl3IYSzl@goliath>
 <Zhg5L2xO_lT4lLwp@fjasle.eu>
 <DS0PR11MB77652A4C98FCB671F5E5F3EEDE042@DS0PR11MB7765.namprd11.prod.outlook.com>
 <CAK7LNASYjbMdq=R5hpgrGH3LFMhNKaEK4BEQOe3XoHDMrEaaDQ@mail.gmail.com>
In-Reply-To:
 <CAK7LNASYjbMdq=R5hpgrGH3LFMhNKaEK4BEQOe3XoHDMrEaaDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7765:EE_|PH7PR11MB7049:EE_
x-ms-office365-filtering-correlation-id: c34c7db5-d04b-432f-7638-08dc5d35cc8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 L69gRzeNBrVet0/6C2RszTiQYv6ZDntHj3GHrCf3SVoFfSnIUvl58buHG4j9ZupszHSUODE1MnV3VZjs1HE5nLvfjPoGtLHRGNSOHrEBoBqWgyKv7u61gPsFBU7+QuLPmGNcQWcv1p793c9gFdGeL6eUXLThoXjz6IKq+OTlQy/gGJlB/O/CzXO34raQYlIOHN6GBhcRxMXOIx/N7RH0EkEIrt4PvdbWCHfeIxS4VgbNiyOperIp+wp2/W6JeBHLXUqoubs8YlTguNB4TqHiPVkMQZYlGtujEZ14euOQEAz67gMbD+7Ci8l/us9eJXrcPHYFJxNt8jqzJMrXDuv/aC36b06ycW9G7IDlZso9PZjnWyPMLNiP1bxQV3jrcRU84zNIEVfZCWqtY8jIW8+PFUkQGU9xXqSamuYWH4rAbKjPWoQL8/NpjDixttG9m3LNPsd1dpIkzOiqkJTNdM4NeDTmhYsbBizRJ/7VGo0PN9U0ZzisKz2/yoR5qKYb+ILPVHMurQeqWyI4ZnTzztELqMHdx9YE7MthUlJpbujJGNmpm8X46BHYqxVTzAYuyLs0JhJOJ0Y4hZnbhduOKIpiq8C7QD3iO9lvHSEMj5XVNHd2nbkz8L0eBG768FpOsWMqRcrM/px1lyQQkMFeRg1UeYIaNGd6dXLjxcRffKnrQo8/Cl1PvBEJDN9PE7q1b9zM6fPujRzXNzwGIzm1IyGzuxLBo6AbQq3HDghm2Zlu0vM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7765.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sPzYd+MgW9ZC1E88WaBdEZDC6ASm73CzxKyoE9aYcxl/GznNfom8lLJvAXHp?=
 =?us-ascii?Q?C4Hjl9ZgUZY7AKhE6GNC7AE52Cp+vqGrJv5VkRJAjJzoyOVMheskdBWACFQW?=
 =?us-ascii?Q?XnzyoLZKB1ylGz18qDXd6LYkZcZZXNMIFBIn14tx1noppuB2zUQueTnLNTEX?=
 =?us-ascii?Q?UZWZQ3O1k+dJ1TAqISQw22prAeFdq4UhKQFe95AoJBEWd0/RivAM1AuMLJqg?=
 =?us-ascii?Q?pukZepftPLzNAiUE21i5FrEFmMcDuedfSDrkDlAdalb8lADmizig/OMSCvIM?=
 =?us-ascii?Q?Nq6ALDKeF2aofhMw6EYLSynnwyQvXH+lG2LWibVNWpAo63faobuIhxcAZFmK?=
 =?us-ascii?Q?ATe3//PjbPMSW4+4H12p/skqTRD83lVr+TZrPigb6HG8wkRZeW72wz3eITm4?=
 =?us-ascii?Q?uhv5ESDmL6MyG6IDs8l6nga58dGwqn6OxhPBlkkuXYqAb246v9rthgjYd4JV?=
 =?us-ascii?Q?iMCLgfxGc3Bp7t4a5ZhoSqseQVzqmjz4nLo20PZ+R0VDUmF+oyh3PjguaP35?=
 =?us-ascii?Q?9TkqilGhAyPxUuPVLHqpN071/sjed6OEadnkX0t2EfB0NByCedu/tuVARxk8?=
 =?us-ascii?Q?g8wTFSVvVjqS7IhzWcxCDiHb4P9SUVUMwHDIlJk53NOJGEKm9xP8k7w3ATAO?=
 =?us-ascii?Q?WhGxkeXjlN/M9gABSuoM1JzWYOfgaxKELklsue/bgFh29XOCKGEFtg1Fgknz?=
 =?us-ascii?Q?gAR8eMarzduW/Gc/FskkhBDdtfQB0yktktfuRd2oOD0uz3QiSuDCm/u7D/OU?=
 =?us-ascii?Q?gSzEZxCS2xxVykK0XnDuEdPEu7dTntA480yoZZHKJITbai3ytZ7r4u4nuxQy?=
 =?us-ascii?Q?p15T6/Lm9jSQHh7DQRSnnLt7lTskCSR6zNAkBnSyMHiUhV1ItQh8mMYELQ37?=
 =?us-ascii?Q?czDDVvtSATSys5JsxYGDKM5O7Rq3kcfLPav3HLvKTaB9U/raBwdkpIKb1a8g?=
 =?us-ascii?Q?Y6se7YMmhyT4B+uYUcrtfAoX6ZDCdHnQJ+WyrHuSzvi4kzrgnAcPO0ohkh8c?=
 =?us-ascii?Q?2ZLJMBSy6gysu4zZB0LfwEWn4tYUF0T7hGe/NR+wPPto6DcB/IewEVv7TEvX?=
 =?us-ascii?Q?+zwkY3PoqqU14YHejOT6CQLCDqewFBoeW9rBc68M7gv/dqIyDw0rdXWng1fo?=
 =?us-ascii?Q?tDAYdXcMhPjLgt3qdwBXylYt3NCXqHxcu/8RoWZmfMauy0vuYKT3gs/1zreL?=
 =?us-ascii?Q?jIAFCRskb99Zh1HqvrhXHvV+jgs3ca+n7/lwbTUh41csAtiY3cEDEpFoGZOE?=
 =?us-ascii?Q?Qpddbx050ocUN4V0pcP8DQj60HJb16ZV+wlWqKW1hJbYn2IiqYMQzX5Eec94?=
 =?us-ascii?Q?SKZOqzmA4ECFwswWqWBL0YkK6VV2csfjZAL6+DmjD9247Wb2FTpPT0PY1T9M?=
 =?us-ascii?Q?GG3szBUAH3YPOiEG5Dyoqlw1SzUVDTWVZPXf4obw5+m1XKZv1wB/IRcQo1ru?=
 =?us-ascii?Q?k6lGeEcfsVvahSOkKYi16AAZ32pbbOJUGujVHcmr6iCRV5e3UkK7AZTDcPns?=
 =?us-ascii?Q?Lm3Sd7WttUgHBFB3qwdz4vY8wfiWF6rIbLnrpZQcir1V8fSOBiXzTqYof2xf?=
 =?us-ascii?Q?TObS20Alv0ML6lVmmyWNQZxkHA8HZxFBgraE41ietb6adbkcwpZSwEmTuPf9?=
 =?us-ascii?Q?FQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7765.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34c7db5-d04b-432f-7638-08dc5d35cc8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 10:21:22.5759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ge9ka25d7MkkNDeC88LH1jnGSQ6deJMZ+K9seHiDignGe94uS1HbhudaES13vHzKS/TY0q4wfMYiOiG9cmymUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7049
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: rcdn-core-9.cisco.com

Hi Masahiro,

Thank you for your response and for description of relative method with
"O" and "M" variables. I'm tried it before start upstreaming my patch.
It working but have strong restriction on external modules location corresp=
ond
to kernel sources/output objects.
Unfortunately, proper external module location for your method can't be gua=
rantee
into all projects and my not exceptional one.

> The workaround described in the commit message
> (overwrite 'src') is different from what I know.
Yes, your method is relative method with using "O" and "M" variables and it
different from one that I used

> As I explained to Daniel before, the point is,
> O=3D refers to the kernel output directory, and
> M=3D specifies a relative path to your downstream
> module directory.

Thank you, again, for your explanation and I'm tried this before starting
discussion with You and other guys from kernel team

> Say, you have a linux source tree and external modules
> under ~/my-project-src/, and you want to output all
> build artifacts under ~/my-build-dir/.

> my-project-src
> |-- linux
> \-- my-modules

> masahiro@zoe:~/my-project-src/my-modules$ tree
> .
> |-- Kbuild
> |-- dir1
> |   |-- Kbuild
> |   |-- bar.c
> |   `-- dir2
> |       |-- Kbuild
> |       `-- baz.c
> `-- foo.c
> 3 directories, 6 files

> masahiro@zoe:~/my-project-src/my-modules$ cat Kbuild
> obj-m +=3D foo.o
> obj-m +=3D dir1/

> masahiro@zoe:~/my-project-src/my-modules$ cat dir1/Kbuild
> obj-m +=3D bar.o
> obj-m +=3D dir2/

> masahiro@zoe:~/my-project-src/my-modules$ cat dir1/dir2/Kbuild
> obj-m +=3D baz.o

> First, build the kernel and external modules
> in separate output directories.

> masahiro@zoe:~/my-project-src/linux$ make O=3D~/my-build-dir/linux defcon=
fig all
> [ snip ]

> masahiro@zoe:~/my-project-src/linux$ make O=3D~/my-build-dir/linux M=3D..=
/my-modules
> make[1]: Entering directory '/home/masahiro/my-build-dir/linux'
>   CC [M]  ../my-modules/dir1/dir2/baz.o
>   CC [M]  ../my-modules/dir1/bar.o
>   CC [M]  ../my-modules/foo.o
>   MODPOST ../my-modules/Module.symvers
>   CC [M]  ../my-modules/foo.mod.o
>   LD [M]  ../my-modules/foo.ko
>   CC [M]  ../my-modules/dir1/bar.mod.o
>   LD [M]  ../my-modules/dir1/bar.ko
>   CC [M]  ../my-modules/dir1/dir2/baz.mod.o
>   LD [M]  ../my-modules/dir1/dir2/baz.ko
> make[1]: Leaving directory '/home/masahiro/my-build-dir/linux'

> masahiro@zoe:~/my-build-dir/my-modules$ tree
> .
> |-- Module.symvers
> |-- dir1
> |   |-- bar.ko
> |   |-- bar.mod
> |   |-- bar.mod.c
> |   |-- bar.mod.o
> |   |-- bar.o
> |   |-- dir2
> |   |   |-- baz.ko
> |   |   |-- baz.mod
> |   |   |-- baz.mod.c
> |   |   |-- baz.mod.o
> |   |   |-- baz.o
> |   |   `-- modules.order
> |   `-- modules.order
> |-- foo.ko
> |-- foo.mod
> |-- foo.mod.c
> |-- foo.mod.o
> |-- foo.o
> `-- modules.order
> 3 directories, 19 files

> I saw this before somewhere.
> I believe it is a well-known workaround
> that works with recursion.

I agree with You, Masahiro, this workaround works but it contain significan=
t
restriction that can't be implemented into all projects and as you told - i=
t's
workaround but not official method

> This patch submission is not helpful.

> Kbuild does not support the external module builds
> in a separate output directory.
> Most people know this limitation for a long time.
> You are not the first person to discover it.

Problem will be raised again and again, until somebody will implement it pr=
operly :).
Of cause I'm not first who trap to this issue but I'm also not the last :)

> Second, anybody can write a patch like yours
> in several minutes.

I'm totally agree with you, it's not a complex patch and that's a good news
because small change can provide required functionality :).

> There already exists a similar (but more correct) patch:

>   https://lore.kernel.org/linux-kbuild/e58cba84c90c40108ac678500f33655e@x=
iaomi.com/

> That one works more correctly than yours, because modpost
> works with no error, and 'make clean' works too.
> I am not suggesting to fix scripts/{Makefile.modpost,Makefile.clean}.

> If such a patch had been acceptable,
> it would have been accepted many years before.

> Things are, the decision is postponed until
> we are confident about a solution.
> I must avoid a situation where a bad solution
> is upstreamed as official.
> That is worse than nothing.

Ok, I'm understand your opinion.

> And, I am pretty sure that your patch is not
> the right solution.

> --
> Best Regards
> Masahiro Yamada

Ok, maybe one line patch that I submitted today will be more acceptable
compare to current one.
It don't create any new variables, it only fix "src" variable recursion.

Best regards,
Valerii

________________________________________
From: Masahiro Yamada <masahiroy@kernel.org>
Sent: Sunday, April 14, 2024 10:48 AM
To: Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)
Cc: Nicolas Schier; Daniel Walker (danielwa); Nicolas Schier; Nathan Chance=
llor; xe-linux-external(mailer list); Jonathan Corbet; linux-kbuild@vger.ke=
rnel.org; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Add MO(mod objs) variable to process ext modules wi=
th subdirs

The workaround described in the commit message
(overwrite 'src') is different from what I know.


As I explained to Daniel before, the point is,
O=3D refers to the kernel output directory, and
M=3D specifies a relative path to your downstream
module directory.


Say, you have a linux source tree and external modules
under ~/my-project-src/, and you want to output all
build artifacts under ~/my-build-dir/.


my-project-src
|-- linux
\-- my-modules




masahiro@zoe:~/my-project-src/my-modules$ tree
.
|-- Kbuild
|-- dir1
|   |-- Kbuild
|   |-- bar.c
|   `-- dir2
|       |-- Kbuild
|       `-- baz.c
`-- foo.c

3 directories, 6 files


masahiro@zoe:~/my-project-src/my-modules$ cat Kbuild
obj-m +=3D foo.o
obj-m +=3D dir1/

masahiro@zoe:~/my-project-src/my-modules$ cat dir1/Kbuild
obj-m +=3D bar.o
obj-m +=3D dir2/

masahiro@zoe:~/my-project-src/my-modules$ cat dir1/dir2/Kbuild
obj-m +=3D baz.o



First, build the kernel and external modules
in separate output directories.

masahiro@zoe:~/my-project-src/linux$ make O=3D~/my-build-dir/linux defconfi=
g all
[ snip ]


masahiro@zoe:~/my-project-src/linux$ make O=3D~/my-build-dir/linux M=3D../m=
y-modules
make[1]: Entering directory '/home/masahiro/my-build-dir/linux'
  CC [M]  ../my-modules/dir1/dir2/baz.o
  CC [M]  ../my-modules/dir1/bar.o
  CC [M]  ../my-modules/foo.o
  MODPOST ../my-modules/Module.symvers
  CC [M]  ../my-modules/foo.mod.o
  LD [M]  ../my-modules/foo.ko
  CC [M]  ../my-modules/dir1/bar.mod.o
  LD [M]  ../my-modules/dir1/bar.ko
  CC [M]  ../my-modules/dir1/dir2/baz.mod.o
  LD [M]  ../my-modules/dir1/dir2/baz.ko
make[1]: Leaving directory '/home/masahiro/my-build-dir/linux'


masahiro@zoe:~/my-build-dir/my-modules$ tree
.
|-- Module.symvers
|-- dir1
|   |-- bar.ko
|   |-- bar.mod
|   |-- bar.mod.c
|   |-- bar.mod.o
|   |-- bar.o
|   |-- dir2
|   |   |-- baz.ko
|   |   |-- baz.mod
|   |   |-- baz.mod.c
|   |   |-- baz.mod.o
|   |   |-- baz.o
|   |   `-- modules.order
|   `-- modules.order
|-- foo.ko
|-- foo.mod
|-- foo.mod.c
|-- foo.mod.o
|-- foo.o
`-- modules.order

3 directories, 19 files


I saw this before somewhere.
I believe it is a well-known workaround
that works with recursion.






This patch submission is not helpful.


Kbuild does not support the external module builds
in a separate output directory.
Most people know this limitation for a long time.
You are not the first person to discover it.


Second, anybody can write a patch like yours
in several minutes.


There already exists a similar (but more correct) patch:

  https://lore.kernel.org/linux-kbuild/e58cba84c90c40108ac678500f33655e@xia=
omi.com/


That one works more correctly than yours, because modpost
works with no error, and 'make clean' works too.


I am not suggesting to fix scripts/{Makefile.modpost,Makefile.clean}.


If such a patch had been acceptable,
it would have been accepted many years before.


Things are, the decision is postponed until
we are confident about a solution.
I must avoid a situation where a bad solution
is upstreamed as official.
That is worse than nothing.

And, I am pretty sure that your patch is not
the right solution.








--
Best Regards


Masahiro Yamada

