Return-Path: <linux-kernel+bounces-128798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9B8895FB5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B64287543
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9982E410;
	Tue,  2 Apr 2024 22:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="l7rVY4Eq"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2166.outbound.protection.outlook.com [40.92.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135CF241E2;
	Tue,  2 Apr 2024 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097790; cv=fail; b=goHMTJc+vyjzykOXCIo/njxGaSCKty5JNzkUdMvxR1Lcp/I2hT5aiPipj0HoRLYL31H+GfC8d4QqQu8idX6atNetF7ikBrIFu/hjmHzcWDrl9PKbkj38kikz0xdQYDuhnqQEDmS4irYjSHKZnBOtk2YwVBryU0lymZ5xzjo678s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097790; c=relaxed/simple;
	bh=p0SJXuW07OUXioeZ1FtSMXv7JXysGyIZ1JQPuAoAafk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NGe19Ph4+hQQklent6mmoESE+b76SX5ORYY4JeOqLOetkB96+cIsEiaXRRXWsBd616hd7wazQ4C4AGmq58GFhc8lUpu3RYkmckfOpQXVbYMFaDbxjNU4TNOJFRxq+FDu43Z+nAuia6CllSRZJGGuvP/y6s3ij+AwczYhQlx64ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=l7rVY4Eq; arc=fail smtp.client-ip=40.92.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijcmk12I8v9ymXYWFssS1rQ0WevOiYjM7f/cK8ePkjUBNfUWwIK9/uvYmgSHRjmVW4NcWLxYI6Rn/PqxA7gzFOWMx6F1JRnk1+XMyHqG8zHnpEZygrhz12er7BVGCU0ZStF0Xt95JZY9Xuv3vegQTRHYycX7ccId+wrODxRsC7V7Zqc+wRa9Adp50bZUV3V+JsuIrEqtEVZRB9KNpu9YHSYfkQEZm3++mdg7qZfro/47c7vbNTWWvlHE3wFY4DRlv1qa3wJfeP6dwtSLdPHj2dCrVZUHWreRg6DlLjfBzQhwosTLwUbGpyzGSfZKYNRmLobhB0B/GNIhPfzlAPN8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nX8Nr/mQdDNnbtY3GMIBYEUNT4f8d0l2hfD3Seqq8h0=;
 b=kzuogkiMY7MqpwcCg7MXVeMYVSCQWCm2bfoau70Y5dELXsHUZdbXO+0d4/xrqgtLT8jbzVqhpoYLyU8XBQ8XrIYjM59udFF13eN4kSKXkcQy7qWAhUjc8O/JYD/S5S6pii6a9KUTqhwYWUMvDi6ggRjzr5KT/q8ZE358IzyCaamo4272W5uWnVjOhJq90zMfzvQOy9o/tolCdSGi/4OVu3t37tEyXkJoA15OMncoXiP9slqCazMJIrFKqrOJgK1J2hSG0P78ik+k08U3aEQMCP9LArnReIG1rjnIVRdHBHpzBy3FVVT/JMpFsMqUZEc776tbla+cjUVl6+l52ND5Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nX8Nr/mQdDNnbtY3GMIBYEUNT4f8d0l2hfD3Seqq8h0=;
 b=l7rVY4EqwFm2Xq/36sMN8imG9vXg16F8LJZFKbJxL5LTbSWmZ2Y/oa9EV2ZPaQDHMS1eMm19CPHPhhRA+jansqj5JvU/YL3yCEIwanJMuStKDE+Ry21Fmy6o4pEFj+LTy4VIcFYIdcJlFtMRzm7m2Dps18cM2Ae7y/Q4mk2K4i7jORUuPhLAXfowtS0GjTFblbx3nRQuysnBRaM1nmKVpIJQ+WeGFygVsHBDF5xyFl1ptXZY6vPUB9RmRe//yMQkaeKPhy4SkSBKElCEu3AhITOv5voQm2LCEBnoOmrYrmSCQ1XT8o9GIWr0krIV6TdeODquH8Z2PCunmh85Suzl+w==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 SY7P282MB3865.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e5::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Tue, 2 Apr 2024 22:43:05 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 22:43:05 +0000
Message-ID:
 <SY4P282MB306385448FB7B6DA57BB337FC53E2@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
Date: Wed, 3 Apr 2024 08:43:04 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: thermal: Continue registering thermal zones even
 if trip points fail validation
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <SY4P282MB3063A002007A252337A416DEC5382@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
 <CAJZ5v0icbgfNbt_5TibMWuxU=+SgdQxy8S0xFQkSY5MoPN77hg@mail.gmail.com>
Content-Language: en-AU, en-US, en-GB
From: Stephen Horvath <s.horvath@outlook.com.au>
In-Reply-To: <CAJZ5v0icbgfNbt_5TibMWuxU=+SgdQxy8S0xFQkSY5MoPN77hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [RMImxslsw8I76vDTv8pQs+hzM5pnANrM0ugaiTcFpIg8dTCLatHDMrsIEW1Ll5XaJlG/AQfZFRQ=]
X-ClientProxiedBy: SYBPR01CA0089.ausprd01.prod.outlook.com
 (2603:10c6:10:3::29) To SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:159::9)
X-Microsoft-Original-Message-ID:
 <cf2952c6-13d3-42d9-b878-6de2670bc607@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3063:EE_|SY7P282MB3865:EE_
X-MS-Office365-Filtering-Correlation-Id: e235b3b2-31cb-4027-e01d-08dc5366429d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jSif9Sz+sglQJNkHgB2QGYPcCrcjprKwUbimk7aN/tOjo6sSZBdWYEgenCKdWmc+UcX8n1yeHNLdN2Ys8KvNSBjMFaWhje7FELW09uT4TPieoBQu/ZuBlRhsVu0YW3y9ktkBiMysBXGQiSL06NAN67czDHzcHmH0EZ9gwPvXhcmblnrxlsWgD9VUK1/C8XwoLSmcRiFfqpRh3gX9mbiTla9IZ8DZbXZW7RuPM5Fy5m+rc83ZcdlSa1GjUrp9zVKE1WgsGyAQcvw7t+uJ44ZF0Igq/HMrFmNEL+aItOr4ub2Au/dEXiN5FY97A0bWjo3zAn6czH0xyyRAef5ty0YM1NBsxU5x8hKGnvBiop+i2vp1+/lalMnrEDc59NcUXrUA46wJCzDbT5+YzYbESmKy3m5TSQdQ6biPyGXIbO0oo+laVeYA2SWuG6Qk3X1i3X2OyG6leEBZblnLCAdmNByDrSHKR+ABMjOurnGpqD/6a6mPNySZFxnJoaGfcYYlDE8ULDF+3jAIJQ6Uihcp4pm5YqkrRYKR6XRyBID9v+bPqx1q3VpNqnv35kaEBXwIQyms6SDSoKTy8EQ9zT8w74U7cwTF2Ggz90O0MuASulWN+u/lx4g8N/pU6tqhQltr9WyEAhIOBy+3sKxxx8zefs8gxOiIG9L6atRS3RKUtHBEy1kPY2CqIotCgJ3wJhsTjAFB2nWd5YeJb1qYdsS1zGjqgg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZloyaTVyRHJRaFZVaUtDT3ZOWWRpbjFTTUdhelFSMk5ROGFDSUxrTURGNC8r?=
 =?utf-8?B?MnNadTFac25ZKzF3T3BvcHJqVWxlc01ZdVVaNzI0UHBDbzUrZ2hSWkJpZjVx?=
 =?utf-8?B?alNvZXpqZ2c2K2NpSll2K2hmdzR6WVQzeWMxRHEwOURXMXRiMUJIWWNaWE02?=
 =?utf-8?B?OVRqdkVZTjdsQXVWTG4vQXoyd3hFaUJiOGlvRmpjR2g1aTRYMFZBR0wrVVJl?=
 =?utf-8?B?Zm9DYUk2TlhXZllOaEtGQWkzcDBic0xIZ094REY3RDd5cW84RExRYVJmejhr?=
 =?utf-8?B?WHRuOHZtOERVTjg0d0FXYVQ3dkpoVWlIZk1TUWlXMFgxaUlIKzBDaTJ5Wm45?=
 =?utf-8?B?cnBIaTBCdnlWMVB5T2ZyT2FGMlV4VTlaY293YXFKbUZiQ2pPcHJoenRUM2Fq?=
 =?utf-8?B?UWZPVk9qRVNpNnNnMkV6ZDJPKzVFb1B2QW4wSHk5Q0cySFZLRDlnQXNxMmFz?=
 =?utf-8?B?ZEhNcGJwQVVyK3lQSE45Qm1HT1RnZnR0UHZUNS9IUkJCZUVsMUFCSS9uWVNH?=
 =?utf-8?B?TndOTHl2eStEYnhQOEpNVm1BNk42STNkY0JhOXZ3UWNad0l0N0d3MTVJV2Fq?=
 =?utf-8?B?Tnd3Q3dMWURDRDl1d0grY2lldzk5WkRkVW16UFZpTzRHR0VXVWRMbHNjekdX?=
 =?utf-8?B?Z1pnNjROSklmUFEzWjE3bEQ0T3hTOU94a005VTRrazd5cWZYUGNCMGpMVDZa?=
 =?utf-8?B?U21tRnJrMVlWYnk4allZNVRTME5OeDlaZ2I4Y01yM3pXaFJuVFNnYlVqRyth?=
 =?utf-8?B?cnkvWEhxbUFCSmxmRzZNcUZaUzRRekZLWElEOXZhZDBvUi95U0M2czAzYVhZ?=
 =?utf-8?B?MmF2Rk92N3BWd2gwbmV2ZzRWV0M5OW50V3RGY1diZE9EcEd3aDZ4WHJoVE5p?=
 =?utf-8?B?N2YyQzFvZW5FQnBTSWM3d3hlMy9BcWFRVlRBZ3BKbXc4SHViOXh0bE9kTUw3?=
 =?utf-8?B?NEJGQzVBVlRvdFppaXhsSHBmZ1RuQ3hqUmZKNTY4UGd3ZFNQKzU5cWhycTMx?=
 =?utf-8?B?ZElxOGE0YWQyVXNBNCt2NmJyLzdicmJ5ckg3VjJTd0tYUm9mSDZ5bEt4NjBS?=
 =?utf-8?B?ODdheFQ5ZVNEMGZFRmFsWUF2V2JRRlZoMWQyb0dWbHBJSVdobi8zZHkvUHJs?=
 =?utf-8?B?TlEvMTRnTjhnMXNZWU0xVU9QK1ZieXR2OXpyWHliSllEeForYzFPQVpWU2g5?=
 =?utf-8?B?d05lTlh6bVpWL2pnTjhQRHdYSTVySVk4R3ZiN2orZHlqUVNjOVB1VEtoRkNw?=
 =?utf-8?B?cWFTdWo5dTlmZjlUUFhjdmVMZUpPWXhZWHFVWWxHRjV4R0RYbERDcmlQUncx?=
 =?utf-8?B?V3JiL0E5bXo5bEpBd25rRm5TbElKc3ZlNlJwWDBjaE44QmE4RmE0dWYyVzNo?=
 =?utf-8?B?OWhZa0JtQXpmUTcwSk1XdlhYajU4TWUvTVJYeEMvK0R0MEtjOE5kZVVoS2Fs?=
 =?utf-8?B?Mk5nZURIV0l4SWZEa3FRc01MU3QwNEFZWDVTbm03Vk1VK081KzdxcS92WmlS?=
 =?utf-8?B?YW1XaEFZVUFHLzJpcFB3S2c1anlkUWRhRmwxaHkybmo1cmdDaTVoN3U5YjFY?=
 =?utf-8?B?eFhob0ZKdEdNYjBiSG9RRkh1bExCVy9XaWt6VnlnMitDc1ZtNXlkWTkzQ0tw?=
 =?utf-8?B?clMxODZlbkNqOEQxb2VOaUxhYi9iQ0pqblArdjhLWVJQRW00S3kzRWNObzRB?=
 =?utf-8?B?bHV0Z1lHdkVOM1JrMEVOMHlSQ05wM0VyOTh2dXRPV2JObzRkYlMyZm52THAr?=
 =?utf-8?Q?ECEi+VheIi26aCezzydLn5IrxgsTqb9p+BXSbCr?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e235b3b2-31cb-4027-e01d-08dc5366429d
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 22:43:05.1979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB3865

On 3/4/24 05:40, Rafael J. Wysocki wrote:> Applied as 6.9-rc material 
under a modified subject ("ACPI: thermal:
> Register thermal zones without valid trip points"), with some
> redundant braces removed and with some white space adjusted.
> 
> Please verify the result at
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=8a4ff5452dd0cdcc35940460bb777d836bece11c

Hi Rafael, it works!

Thanks a lot for your help!

Steve

