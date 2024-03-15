Return-Path: <linux-kernel+bounces-104241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E095C87CB16
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F712837D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601FF18040;
	Fri, 15 Mar 2024 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="TGW2b/bJ"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B4E17BBF;
	Fri, 15 Mar 2024 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710497032; cv=fail; b=ptnFnsYbkDBdKAsuGDLnS66XUX4SjrQZdqhBaWn0kgIiCm+mHV3Uuyqljbox9N/wqKswt5qN/Ma7TdU225gpi2vQL77sZHfj6Benu0zDzU+lKPz6Pa3ZryNSEdO1bOPLeP/r0ItxRW15KWrmGy4W4pvOVcs4aPv4n6x09AZq180=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710497032; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YlzoZnAZrtfO7RuCohrg6F4hF5YArREf/ZK1kqMsFE+ERiYVYtMWdGUtDMom5HOdXhBHER8g3CLrHofbHH0RJ9iaSPYoeoydWS2/FnBoILrHdAK7j4LrsmhPmfIjiKHdi9PmsESvG6nppPyinHA68Ii6HbtqKCFu9toy8RKWm2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=TGW2b/bJ; arc=fail smtp.client-ip=40.107.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNGNTeClfwjt/nS1yF29SbeJDoKWaPUMFuelIez6bZ6OCAehTpclGYINcEiiwu5VuRdgkWb8I5c+F5EvjV5p2zGRTWhU9M4LAXdR3rOIAo5wLQWCYqnUg9zauGG1ynQJdjf62PUPJtDuxaB2t1EDsQM3n7vlASvfzDh5gr2KXLXDqFiWhfMr2oXFOwsbaAAcOgAJdO9hgfOJN22WOJJw7seXO1yuNLBKlR1IfZCAmjdM4OXrIA1ghNvjwvxhLBEjpZR6o6C1aveENqUysqwgnn5dWhMq+GN/1eTsqQcgIZZAtj4Al8pNLNBbjZZvnIRDEjnms8/GzJQml5+VxQX4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=UBrmnWs75ClapucGzjy16Vli4TWm2nytXDRfApSImMOd5+Bo9w3DUs7laRPGSYXFtKSAnhXiBlpgTD85ghLynGB8md9V5tWeKKuzOT3PrB5lHnO6BPNLmejCCT/oYf7m1N/J+ve6YbplxbyLzMbH7NulNeO8Fdgc5KjHf9AExMVyEB/60JSFX51TB+Grjp9kSsMHVspxw9XYRx21I6jQe2zazZJv27E1lGGdQ8mVLQ0xXvr6Z8CDKfCXpUXtYKCwd0k1cIZceEOEptcuXSlg5SnfZSCSVvexkVihxI7p0PbMSXsjcIGJzUccjtndMxcTsJyDXGZK3mvib/X+C+FoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=TGW2b/bJv+OBDHMY/EACZDPv6bfPfYOWvUv4PhKCR8j1HrGcUVqZ9LqVSzPJeNQWnazQuugzxe9aKdb95z6Fx4VhGJAG9R3bWTYQ8bWOYhmMK+QAgRGUqlP4IpcBIzmqKvbNZKvLr2F/HYX8yUQOODP9R+/oJ8lXXFPvcc7MSBHFzlOCQkYSvpwwrmDI/Ls+hdqiqHCtgFPqSc6e/779s4S0A6G9i/30Bp3/BsSfi7i9gnstonuEtg1qYBAtHPF9Y+H4lrdjHD9fMhwuwmzMOhEqT1idrYChMmOGKkuzMrr+I45eSlvzK93FzSAz6Qae9ugR2aVsilo9bO/5Ag/MxA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAVPR10MB7116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:315::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 10:03:45 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ab67:6d35:16b1:81c8]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ab67:6d35:16b1:81c8%3]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 10:03:41 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC: "Stockmann, Lukas" <lukas.stockmann@siemens.com>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: pcf85063: do a SW reset after rtc power fail
Thread-Topic: [PATCH] rtc: pcf85063: do a SW reset after rtc power fail
Thread-Index: AQHaaX8AVt2JFt0PzEGKX0717h7j8LEh5IgAgADaiQCAFe4MAA==
Date: Fri, 15 Mar 2024 10:03:41 +0000
Message-ID: <37524eee0cf4fd550a7338aadef02fff34619902.camel@siemens.com>
References: <20240227131436.3342807-1-alexander.sverdlin@siemens.com>
	 <2024022922080217cbe165@mail.local>
	 <f882d7964d2d905288bcb7d01421b5eb5bd1b6f2.camel@siemens.com>
In-Reply-To: <f882d7964d2d905288bcb7d01421b5eb5bd1b6f2.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAVPR10MB7116:EE_
x-ms-office365-filtering-correlation-id: db457cc8-3b1a-4947-9456-08dc44d73141
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hvdfU9r+/UIkeVGpUkJINvsc9IOnUEo/qb86qgB0znHUtO+juWPg1usJp4NB1lVMepqo49zAwRZbn/FYYxPTQSWpI1mY0pwOK03/nav604fqTHzKgtlQ18YuqaGpyUmAVwc+4cAtxk0M8E0cRklNqVSYyiU8jrtwhij9dtPec6un3rtg/+cI9iuXJVXRJAqeFYjxZ0EAxZAQm/U/zs52e4PBLoUh4yVkw0SF1gkkalI2skEz6z/LGLtnjgztcoz48ejLSIXyGcvJX+DUeDysTMJcvwwT+yZqzjR+u0PE7mDjxAGMGIoIyVQ7LM1Zvn/SFR2cSeTq6Y7oZyrAs17DCvkHPtwIcWiGenNJeol8k06HBG06tklfaWOXY/gsC+Ld6kDlfmA8kC5M6+1sdb8QfDYtXRfQVzEIBFqCbldVDlSGuq7ZtmpkIznF8XtsPl+4SXoWmOv4JlS/WrgXkDUDsg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TXoHI7iw9Gj45NFqOmjW4oWI0LAivm8rEhsnH3MS3yT35+nw0KVg3Xtq7C?=
 =?iso-8859-1?Q?SN3FoqWVS17vysPmVQ2W8fn/8Osk63Ul7iE6Y/d8xc5mwQOqEiytKl7Z+m?=
 =?iso-8859-1?Q?70ymrtdrSV1CvFbRdChVOnghzMrV7k8in+RZBXsig/9C1/xZmjfPlhdvJe?=
 =?iso-8859-1?Q?pGFhAQZc/1EBmtJl1Gx5dhUvnkw9ZkXLqVTDeOUZ6RPAVcTVEo5lI3Bnp3?=
 =?iso-8859-1?Q?9r7hiHeY8/w1DHE87C41QG+o8iAkJc9wVlS0guRDyWYnUeb5IBcaUWXHCI?=
 =?iso-8859-1?Q?ZO1B/vfm40w4xWIwwT5XixpdlP4cZ4T1c2dz9jPyhARTw6/d5OSP0RUEYA?=
 =?iso-8859-1?Q?3pdAJXV4X/UqEmF/cIcMtuU3gZ39HUg2ebpwAiXT0F/Du/isYUHwO195G1?=
 =?iso-8859-1?Q?5FQa82nl2wI3+5lxW92tvY5S6Z7T3PPMFVL3541uF3/XxNIMYj2eULpK3Q?=
 =?iso-8859-1?Q?vuSfXgEDBoeR+9L66cg7qFUNXYith9ApcmMEY1jnQwIuqUYuv3LF2FNHTk?=
 =?iso-8859-1?Q?P4soWYHD9QDzLjAxoUZzi05/CGUM/Q6LXIYOdZ2tYAKFUudAzgDZR/UQIT?=
 =?iso-8859-1?Q?PPt+77OHVFQ3+4bS5Zj8WgaZvxi0swwwUBWy/ocA3kmjymrnqYuvCk0RLE?=
 =?iso-8859-1?Q?nnZcqTYxaMCfacqCSca7d8EzBJk2OUUmChdt6KAnptPQhqvCOmLrNQxYlL?=
 =?iso-8859-1?Q?ZYLiyIxuLuoPi/xBn5DNGk/dfvS9kzbLVoMRnDHsOokZGwAcZk52zW94oO?=
 =?iso-8859-1?Q?wMn8/wP7M0rS6E6+Ucpb2bQ9LohsSSwvNvnKYs4CMktITYmL5cK6pNDSrw?=
 =?iso-8859-1?Q?DnVdHDofrq4hnNerjzMwlR0A2pQgL/+U67aT+ioYaYDHg/B7dWwUyUKQO+?=
 =?iso-8859-1?Q?p62v5sYI7AgmbWTZD82HH7gFfMY0UpkNYG3LIYYISZv/6jTNtzZj9CislN?=
 =?iso-8859-1?Q?f+UzlVUzcYJ0WdwXKg279DDZWeYjwVhFmFQZpqT3NzpUccRkD1tyTbo8Bd?=
 =?iso-8859-1?Q?/VcZP20h35QtXwyYDzHvCfonkcP76j3N57bOkpGoAtAwdwIsS9JwpJODcU?=
 =?iso-8859-1?Q?5iwAbaqc8SEy+K1MZ2HgPzG7vYKaGQTQLCw86O8keDvd0Nd+wkMSuKoGyQ?=
 =?iso-8859-1?Q?IBhq3X26MSDfgLCKFSOtAgYgnLrrAgzVOzBhpy9cQ9VaW3xrrBy5Z9uY6c?=
 =?iso-8859-1?Q?wpj4LiEFfQuEma8oKsCssJ+g8AVOqncPlwZHs43Sb9SzwjHTT2u0ekMpJ+?=
 =?iso-8859-1?Q?yFGWnKtU5zlRHc0jPVlnrz0Sjy0Efew8KnolBbFRW571iFO4uXn9Gsyd/r?=
 =?iso-8859-1?Q?qs/nr/HctPeDqAw5fK1MBHRXDSwX8ZNPW+0r7cytdnkVilMYjWKkxyDo2A?=
 =?iso-8859-1?Q?7AH9v54ZK7Ho34fDvTm7ImAIKRpT4QWIjemkYeJE6u9AKJbTNKYjH7Bd2I?=
 =?iso-8859-1?Q?Rjjv0rNUqhS8hM72hc5bI5CIzkRV1C61TLygiP0nXzT2rgNgQPTYj/4/Gs?=
 =?iso-8859-1?Q?Dj8/wlG8kdMX5y9BlzH+UdtnWz9NmDDSmV0YEIh9FAJsFsfzhNLx2e8yDm?=
 =?iso-8859-1?Q?KvaBolgq3kjjaccp+/rAO193iqVpeSaSj2wE1iPlop66vWBHbbY7hTdM8h?=
 =?iso-8859-1?Q?VnmA7w5ZgbX2+WhqvdtKE9rX/ot7E1fYPajv5X11bb3ciFjdvCadkz0yg+?=
 =?iso-8859-1?Q?be3OHxMJk3qGgbD7ftg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: db457cc8-3b1a-4947-9456-08dc44d73141
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 10:03:41.4630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ipS+16lDi1BrpBqKpGfur5DdnDf1S3w/j81MhaxoWVnJpsK18X2JucA4BDBmOGsgTzS5xqwofGVMJ7scUM2rvlUoWvjyv8n8ZIUfTxEJEyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7116



