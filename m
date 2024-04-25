Return-Path: <linux-kernel+bounces-158162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E608B1C62
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0D51C22A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB9F6EB60;
	Thu, 25 Apr 2024 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b="bnj8KwJZ"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11010001.outbound.protection.outlook.com [52.101.229.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F357E67A1A;
	Thu, 25 Apr 2024 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032052; cv=fail; b=GvHeICAvQ5x9fcJjvRP+tLbVkXA3RMQuKSqwFsC9I0CPn0K33p8nDO1BLF5G/UaLL0Bbp+p5y6vR63hHZaZ8kiiowh5UDD2u/UebMSJDVYlsC+JdCK6YKaVlYwbup6nbvZR6p3xPoroG+ixZD9l5d3mrf8drbPMkaoj6t6Pz5m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032052; c=relaxed/simple;
	bh=tsx0ltmVPzZ1PGGYsp/mkGb/wz32H1XaquGOPKjUyXs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h1KkV1+GZTy56nRXqb+YwUNZnPbb0teRu17C/qLIl3/2wrsL7O2hORNJkWW0NLhOeDP6591deM8InjjrwTSCpH1v86C899DmMBS8GmPK/85XxEZx3bE79na+JS+IwsQK/QqnES0DjE0MJP2fKC//MKsHY5YRNXt3/KuXosZIHYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com; spf=pass smtp.mailfrom=alpsalpine.com; dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b=bnj8KwJZ; arc=fail smtp.client-ip=52.101.229.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpsalpine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1SZ5K3mEriPdSDwS8Z9q2/qlKgxBL3Qg+kuWLhNjHe5VH/xdrFgIPhp1fT0glDbm2YuR6FZQe5daJ5MXz+IUDDOuLcDLigzZSdwitubQR22mszsRFBVAUf6vNhDcHIHmUozAbEtJ/Mj2z9htNhAs0QsF0fJjbXQMoYrY8QMOb+3XG8nHfara6d1YKhRaUqJrVhldMxG89E7faYlmt6oiI3tc9br6J5AJWMNW+LHP1HaROekmiGbS6U16z0gt0BFIYg+NvjMIFkRuLynOT1g7bjYmx7dM9Fkkz7F3/3P5x4IGyTpVKlDV5M9X91lbWLE2ODowNCXpFOqJJ/od1GfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdLGeZwpaaL78Bm3fNtd55+k4TJuGO6oUlVHjzENf3s=;
 b=c2GkLit+4bt34+kvKRUSVISMA4wOuAkdwhssNQ5xkzJFXWxDOVurU57KH2ovJ2fO9Uf7CgEUfroo/I/srUKJfb5lySiOYCIv0CRq/ZUbD/yhQziBw5B51iA7YKZyydnH2RGmRb/i9H3CHScoKVtZ/vx5wH413od5ek54/ft23p+4ZBz3pLVZSEHp2HvFOjv1UJ0VeeSGJl29Y9vP6OTWG4t6pAZDwxXGUBJ9f8NcYJGDAAqkYSPDVxUdYd3iikNgkQvSW4aeub/HqyWBMu120Hd1BdsRSeZ3hf9G2L+KGTq4Xb4rXAk5rmohMK/QObzIUtm4NbqMBEZNItJVFUFqIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alpsalpine.com; dmarc=pass action=none
 header.from=alpsalpine.com; dkim=pass header.d=alpsalpine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpsalpine.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdLGeZwpaaL78Bm3fNtd55+k4TJuGO6oUlVHjzENf3s=;
 b=bnj8KwJZg3plgmmFtFBtez+V68umwo7Our+y3BWhDCD12Ql9BEw+1oKRcp2QYWTXq1PcGu6hsXaJKz8DhA8uABnAHtXQ1+KSMEIBnjfC3hguARCzFzmiRgaTOA0OYgrdXrLSp1vWDmVXI2Fpkj+Nrn/iq43zFhyHTh1wZF1S091G7pF1FQFAt24NUazW687+bNjiqM0aEtTwbkSO4tKLgG8mgGSNcfH4i/0EdN6PkDkZMp8MFQCRNVHxw26tqThutpcIVI7nWAWqFXBq/Idhse/CRUVNun840AEBTdmPFEXVKwHC6hxn4x+LJItVw8TeeJsZc+UGlWyGhK1CwIaomg==
Received: from TYWPR01MB10773.jpnprd01.prod.outlook.com (2603:1096:400:2a5::6)
 by TYWPR01MB11018.jpnprd01.prod.outlook.com (2603:1096:400:392::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25; Thu, 25 Apr
 2024 08:00:44 +0000
Received: from TYWPR01MB10773.jpnprd01.prod.outlook.com
 ([fe80::5ef9:9250:d1a5:1aae]) by TYWPR01MB10773.jpnprd01.prod.outlook.com
 ([fe80::5ef9:9250:d1a5:1aae%3]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 08:00:44 +0000
From: Norihiko Hama <norihiko.hama@alpsalpine.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "usb-storage@lists.one-eyed-alien.net"
	<usb-storage@lists.one-eyed-alien.net>
Subject: RE: [PATCH v4] usb-storage: Optimize scan delay more precisely
Thread-Topic: [PATCH v4] usb-storage: Optimize scan delay more precisely
Thread-Index: AQHaleZUfInJEgZeY0OV7izYkTBKmLF3ghuAgAAB4QCAARgpEA==
Date: Thu, 25 Apr 2024 08:00:44 +0000
Deferred-Delivery: Thu, 25 Apr 2024 08:00:00 +0000
Message-ID:
 <TYWPR01MB10773C220D1E6C1AFD1BD2F8890172@TYWPR01MB10773.jpnprd01.prod.outlook.com>
References: <20240424013134.17307-1-Norihiko.Hama@alpsalpine.com>
 <c06aaaa1-a2af-47c6-a615-602f2c70de86@rowland.harvard.edu>
 <515c273c-9bb0-4830-a3a5-e9a485356434@rowland.harvard.edu>
In-Reply-To: <515c273c-9bb0-4830-a3a5-e9a485356434@rowland.harvard.edu>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alpsalpine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10773:EE_|TYWPR01MB11018:EE_
x-ms-office365-filtering-correlation-id: f1ed80dd-05cd-4b58-2e06-08dc64fdceec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-7?B?TVVka2VtYk9kdm5MTFdGR3VqNnAzdFBYZk9hUTdqdkZJWmsxVGVPNDRrUVQ=?=
 =?utf-7?B?Ky1jUzZ0aEVwcG91TGZ4OGIxd0o1bENkR1RMYzJCQ04zTFZHSGFUc0lvbVlh?=
 =?utf-7?B?eXJDbjZLREYrLUxUOEpxMXFpOTRiN1lvSlI0WistTEI2ekE4eTkvVGNpQ3pj?=
 =?utf-7?B?TzRrb2QrLVN6NHhSaGpSenNRbE94SmhMTEllSENrTWFpMUNwY3RCY2ovVlNF?=
 =?utf-7?B?dlhuZzcwWDZrTlBhZk9DUVFCUGRpQ2MzbHExTXFIYWR0WVZGU3h4aSstalhI?=
 =?utf-7?B?QTRQRVh1djRQd01ucUJ1NGlsSWIxcXVTNmp4cERBVGUrLUpFVzZBVmRHUUJX?=
 =?utf-7?B?Q0hGcFFSM2EvbystWlZtZFBPMnFob3ltU0JSb3Z5V0Rad3U3UlN6WlpXNFBG?=
 =?utf-7?B?N3E1ckxVZS96U2Fock0vaVp3OVpiY0NIbG1jN21sKy1WSTBXYldNY0xQWlNo?=
 =?utf-7?B?dm1laDFOdlVPU1FOYzRxOW9YTFU4dmxydWlITjJGR3A5Ky1iVUxTNVFLMist?=
 =?utf-7?B?MGkxMHVZVmVDamVnTXl5M3BpcU5LQ1o5UDBLeVpxclBiKy03UlNyaUhTVlFt?=
 =?utf-7?B?VnNubWFnT1dwdm8vUnNuUXdUL0wwa2NiNDByWTFuWEE5MTBIRXpoem1XWG5Y?=
 =?utf-7?B?dWVnSnJKYXpTbjArLUJHaXZzek10d2h6ZzZEMHhmV3ozNFRFazRTblRTU2ty?=
 =?utf-7?B?RU5JVWR3WE16UDdScnA0YnphKy1pZFJGUHVueUgyMHpHNTBNSmp4YUNXZFlK?=
 =?utf-7?B?RGlJNHQ3QVcyMS9XWmkyOExVTkZ2U3NuN3FRaVh3MHZ6NVNtbzFzOUpGblFv?=
 =?utf-7?B?QlUrLS9sVks3R3pNN3JXV0VPNG5sYVBtdmdxTjdPN1ZtR1JodlBuUy8vQkJr?=
 =?utf-7?B?OEZSYXM0dTR6NVJCVistMXZReWdaaFBpSmsxN2pjSDdsaUZzMFNTbGRlZUgz?=
 =?utf-7?B?YjBMMXp0bUFFbDQ5SThBczlFc3NiNmhrSUlFM3NPcG5yQnhLdWRVeDNUUkNs?=
 =?utf-7?B?YkxoSEpxbGZRME04TXNUVVlwQTA4Mm42elMzUk1TdHc1RmNRYVZtZ2lSUVQ0?=
 =?utf-7?B?dWlTaTFFWXU2S25rVXdreTZCbTVpbEhrbllmZ1g1WDRySjQ5Q0xiQ2dCTzVv?=
 =?utf-7?B?S3NxL3lJS09YR2dLTWk5R1lnRWRBb2Q2bSstSFE2UFpxMEcwZUdZaEp2OWds?=
 =?utf-7?B?dTVLT0ZLZ1llMFBnMmRTYlJpVVFzUmdCQlZtUXZWTlUwUzVkajdWYnVRWmkv?=
 =?utf-7?B?WHhVRVgyaktRdFV0M1lMRHdaUlR3bEpZM1dCcDZIWlNJWEZhWnREVUNXa1pV?=
 =?utf-7?B?ZHh2eWVMbm84THJrTUFXd1UyZGJXN3BMSVVLUzJmZjJWU0VYbVY2djR5QjBi?=
 =?utf-7?B?Nk1EalZ3VkovMWRSU2V0VmNJdHl3Uk1VY3lOVWwxMjErLWhRYVdFT0RCaXFt?=
 =?utf-7?B?ZCstWlRqaWJMN2hMTWZ4bWRuMmdEZG8wdHNHVkdWME5UdFlyZTcvZ1plSDNX?=
 =?utf-7?B?L0xkUlJqZXhuOTBFczJnei9LM0xoQistN1h0Tkl4VDQwVk1Tems3M3NqSjI5?=
 =?utf-7?B?TDhCMmhVVldpV0NCZ3kxQTEvcGwyUE9GS29sQkdvZistdUl6dWdxdEZIUVFR?=
 =?utf-7?B?VlVSM1Ntcy8zMXo3dXdEdk9rOXNGeWcxM3BJM0JoMkRJN2p1Tnp1YWdud1lQ?=
 =?utf-7?B?Qkwyb0lpSTIvUFM5cEd5TWV1Z21uV0ltWmVvTnFTekRYbnY0UkZGbFJ2dTdY?=
 =?utf-7?B?MHYzdWdUelhZcHgvaDZnbzk5VHFrSFRVUGFvdVJOdTVoRCstTUJTVFJrdGNS?=
 =?utf-7?B?dUpQcERPYUJIMmdhMUxiRzBlc2JObHdwd2tZckd1OFRUN0kwQ1ErQUQwLQ==?=
 =?utf-7?B?K0FEMC0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?M1M2dnVzNnhXMWl6N0NJZnBSUVFmRkpteE50aXVqZkRyWSstSEhFM2NwU3Mw?=
 =?utf-7?B?SHRadDJsV2hERkYyWUF3WEJCTGFzeU1EYS8ySVJCWC9HWlFuSC9pSi9RV2Vk?=
 =?utf-7?B?ZWFwV3NRWTBDeHgvS243OEx6Z1QwSzN0VXVQSVR1dzU0U1g0TGhMaDFKaEVt?=
 =?utf-7?B?bzRiUzhZSER1UEFsM3JESVEvU2ZDdVpTRHFCNGxKcFpaMFhLbG03andrREMv?=
 =?utf-7?B?aW5weistc1IwcUFFTmJTb0JnWHZySXd3ZHh3N0k2emxRaUFDNTdBV0Zvc1Ey?=
 =?utf-7?B?NWd6ZUNKR0lrdi9ZRGw3cVQ1RDluNmpkMG5saGdoVjYyNThsTXp6N3hZM1Fv?=
 =?utf-7?B?djJVcDRiaTJsRno2dzU3RnJpOW1xQVpRS2ViVGZOb0w2NUMvUXl5QnBPbGRu?=
 =?utf-7?B?MUZiVktjemg5RERTVmlVbzJISE1PcVdrVkZ0RVRYRkFDbEFiR1pOZ1F2Umlo?=
 =?utf-7?B?bzNNTHNlRm1XM2R3bmxraXpwd0tiSy95QUkvYVk4VUJNSHBlQUhsSTJSVXdj?=
 =?utf-7?B?T3hjekpsU21TNFd0azJ5TEhNaWtwS1dkWTVSUllGOFpVV28xWm1ra3pXcDZl?=
 =?utf-7?B?QkpLWE84NXQ2d0VmM3pqTEZ3R2lsSFJzMUlKSlVnWmVhM0tyTWNxREFoYmIy?=
 =?utf-7?B?N1ZMWkJmdDFQOEVwZFkzZWhRQ1pHS21UUkZ4czhhaDY2L01ZWElXYzFQN3dr?=
 =?utf-7?B?WTNNcXRQOG9XdDNZSlVPeFIrLWx0YXpBRzFYMmY0bFZnTmRHSjdUNVpiRyst?=
 =?utf-7?B?dUcrLWh4SENNU1paWXhwaHJlanNBZi82TnBVYjZyb21OMWwyKy1NcnNMVDBJ?=
 =?utf-7?B?N29CSnRlVDFvYkY4Z0hveWx4eWkwTkhSN2VIWjIxbmE3Q1FpZjFvcjh5eVZs?=
 =?utf-7?B?Z1luaFVHKy1TMXZDRHdMR29aVXkxeS9mc2hwN0lOMW9FYU1qOHJTeHhKaGta?=
 =?utf-7?B?aTBlc3d6NTdRUFBMOUxHMzdOanZlWmtmRk9GdWl1WU5QSVgzUS8zYmhWbk54?=
 =?utf-7?B?Q1hVMVE3eXFpOVhzS1JSRlhWUzFpNmt5UHdYN2V4Q3QveVZ0SDZmWm8zSURu?=
 =?utf-7?B?N2RRYnJDSEl1OGVRV1JwcUN2UkRiN1VSZDJudi9sQlRIL2x1cWIyMDhpU2M0?=
 =?utf-7?B?UW5sWEE3UmIwRU1SRE1kYmFGeUN6dzZNblFQNGtwdWVyRXdTV1oyczByNHFV?=
 =?utf-7?B?OUlvelEzeFIzUmFGR1M2UmZiWDlqTXVodTRUUXZHdGpOYWZJQmx3QktraUJU?=
 =?utf-7?B?UUt4TS82WFFTS3p6SndFOGpoSExrVllwZEFnNUN6dTZGcmVla0J0V0RGRUNK?=
 =?utf-7?B?WlJJWEw4UmZOdWw4WkViQVVWSG00RldlbmNrQmkxTGExdTU2N1EwUjIxYUFC?=
 =?utf-7?B?OEZKWklHckZKZ2xKOUYvUVMvUUQzZE9BbTRoSUZUckVITTFsRVk4M1VNS0pi?=
 =?utf-7?B?b3NwSWJVWDJhTkwxeXpkQWtZQWFRL1FaWGVPZEdrS0lCdXpLUmxxQWZxcEVT?=
 =?utf-7?B?WkdaUy9xTTJuODNtSlZTWWNiamptZ05sdzNPc0pTeXNXcFZrYWl2YjhYdFNV?=
 =?utf-7?B?NEk2RlQvLzRJeTZjRS8wMk9weXBFVzNzU202T3pzYkZIU2tqbHlaRTRzdWtq?=
 =?utf-7?B?SDVXKy02RXorLWdRN2hyZW5BZmYxakg0bW5MbEhCejNoRkFobUxURERUV3hR?=
 =?utf-7?B?VTB6Q1A2TDNnQ0pmMFJQSkdCWG5IKy1mZFNLKy0rLUJOTDJ3MzNDaHRmV1dT?=
 =?utf-7?B?dEVFZmk4clA1d3pXNmV6SElrS1J1RGlHZHVlcXBzdWt2VFI2bzVKRnQ4YjUv?=
 =?utf-7?B?OSstdC9sZ2U4NzNzQistVXNENjgvVU5XY2pwLy9OOGpLVldQcDRBTFBBMWpE?=
 =?utf-7?B?RUxZMjlIZG9DTGRrNWVmbkl0T2JrdTBnbVNTbUd1Q0xYckxFRTlnNDBEVVdk?=
 =?utf-7?B?VG5MbXBPb1dYS2hpSTFYUFZFSnlYNGF1SSstZHcwVnhRL2djMFRBUE1BQmQ=?=
 =?utf-7?B?dCstVVNvajY3Qkc3V0UrLXRUKy1kVVRkUzlNWWtGOFc1eGJpRDBxN0NKdVFV?=
 =?utf-7?B?d2t1OHZPT0pNQ05vWlBxSFhwdm5YbjVyaHJZaGlYSzRYMFV1U25NU2lBKy1Z?=
 =?utf-7?B?cG9xeE8rLTJNb3A0NkFRR0x6dG1HZGVtbmhua0RnSktzbmhSaXR6WUtSOA==?=
 =?utf-7?B?Ky1MKy0=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: alpsalpine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ed80dd-05cd-4b58-2e06-08dc64fdceec
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 08:00:44.0389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CeENFSVZ1+igDer6yGCmmSDFGe4dstn8Q6msIDe9Rq87My8uURlwB/NiShginPW3GDAjK1p86/rd9B3CEHluJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11018

+AD4- On Wed, Apr 24, 2024 at 10:51:57AM -0400, Alan Stern wrote:
+AD4- +AD4- On Wed, Apr 24, 2024 at 10:31:34AM +-0900, Norihiko Hama wrote:
+AD4- +AD4- +AD4- +-			Example:
+AD4- +AD4- +AD4- +-				delay+AF8-use+AD0-2.567
+AD4- +AD4-
+AD4- +AD4- This could go on the previous line.
+AD4- +AD4-
+AD4- +AD4- 			Example:  delay+AF8-use +AD0- 2.567
+AD4-=20
+AD4- Oops, this shouldn't have the extra spaces around the '+AD0-' sign.
+AD4-=20
+AD4- 			Example:  delay+AF8-use+AD0-2.567
+AD4-=20
Thank you for reviewing patch.
I'll fix it based on your proposal (also on your previous reply) and submit=
 it as v5.

