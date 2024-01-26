Return-Path: <linux-kernel+bounces-40008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9863C83D880
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269562881B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB799134A3;
	Fri, 26 Jan 2024 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=unist.ac.kr header.i=@unist.ac.kr header.b="jjaVNwAH"
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2097.outbound.protection.outlook.com [40.107.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9921BE5D;
	Fri, 26 Jan 2024 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.128.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266467; cv=fail; b=u4naulQZUJ21dP+tKo1XnPgR/yoscRdXpLSBjBNOcS32noe39Xf/a8F6U2jmzHVMqV1GrPT6o874JSDjln5/wqNyJKokRGlQ3M8dI8aJDWc8E4hWZtprhO8Rlo8JbuHt5PcXr7LnaiB6OLrrfG7vhuMGmCR52lRcaA4RNOl1igE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266467; c=relaxed/simple;
	bh=xNlprFAu3T4JMnAjcDM5oLdRHOTfpJtS8XRLVt7/9JM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=omP/8hl0LeX8KrEv2JnrmnKA6P0i8Gok8uLbx/uFWKpqz5P8dTGvkXHFM2Rh3PDEfrEeALKEwi2GhRkSBUgzubwJExESwVSzKsJm9cv5OJ0i5vpWBFp3XLpv+hyAweVUhnzsaU5v/VDJ0/uGzBZmrY3IfWBxyUlbXrlnhPUQQwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unist.ac.kr; spf=pass smtp.mailfrom=unist.ac.kr; dkim=pass (1024-bit key) header.d=unist.ac.kr header.i=@unist.ac.kr header.b=jjaVNwAH; arc=fail smtp.client-ip=40.107.128.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unist.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unist.ac.kr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PX5aXEf/3rVdfj6COpqkDN+OpsiEECCasMmuduqF0DWAGhtHucfgE0yf+Pa8f9z/16UQJuEq38rCsBpyrF30ovzu88oxPVV8uczWzxpEI48USCE77n3Q9zTFI0vB8JgUTwXVP7lg6UBc1aKiRZHkmtjhA/pVlkzNr2EGY2KKpEOXCgyiDxKAqzc/SxIJBBIVY6d5lIGYolns++Su5j7HN4/gMxdbTBqI+UbjKX4K4Foc6wSt+OzFBNMaokkMlV2XA7AGiDcyYM92nP0VUEXa1VRy6H3tO1Wyd+pLd7vABiRZIEsd3T0qTxq1TnNPKc0fnYuV0kePc2UppChpe463Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lB1XCGpItIJ82hHwPdABa+ZLy+x8BK11yqjqgZ6K+VU=;
 b=jpr2OIh3Q7vZwjvZcj3crKSJQndG0OnvCijRCGd76pGDyNtSdT2lMcLMuM0X6f0ymJ+ZE2b6UdAvK0SI8Agj0r/EyGOptBcLKsMW0MXmBQ3gqfp6lQbTrXy9tp76VkuwbXVULX35s22v2rD4ANUSvNuxqndo0CN98KChsjPb5GRtRavqqmWiQJv64reyg9LS+lxvlrRyIbaZxJ68RRRCrJGd7/x+IHVdnfLt/9hhxh8pdJBOq4O11WMDvOSdb4YyzPl/PwIT+JTxPL0KOz8n8axfTLj6OU/+aSOrtgQfHf2m6TW7Tr7/Cqy0eJilc5xkFKWYKz1HQoWqNvUNVT4PDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=unist.ac.kr; dmarc=pass action=none header.from=unist.ac.kr;
 dkim=pass header.d=unist.ac.kr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unist.ac.kr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lB1XCGpItIJ82hHwPdABa+ZLy+x8BK11yqjqgZ6K+VU=;
 b=jjaVNwAHeq4Et+UVg56GXzQ/5ZYYFpi9FTRrxocPP24KlUSrDsFWnVqBENsq6iK/mOYnXtubjlsn54EPIZjOeIQjh8h1ChQAda4wSjA+V51xyOacV6EHdqfHGJHbZlqGCtJ++Oct3yoIvYt2/WYZ90H4NH/b4+zfL+Spd4ZooSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=unist.ac.kr;
Received: from SE1P216MB2287.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15d::5)
 by SE1P216MB2451.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 10:54:20 +0000
Received: from SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
 ([fe80::d365:3ee8:ce4d:c15c]) by SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
 ([fe80::d365:3ee8:ce4d:c15c%3]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 10:54:20 +0000
From: Ingyu Jang <ingyujang25@unist.ac.kr>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ysjeon@unist.ac.kr
Subject: [PATCH] Remove redundant check for usb_generic_driver_probe
Date: Fri, 26 Jan 2024 19:54:12 +0900
Message-Id: <20240126105412.1353037-1-ingyujang25@unist.ac.kr>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0161.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::20) To SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:15d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1P216MB2287:EE_|SE1P216MB2451:EE_
X-MS-Office365-Filtering-Correlation-Id: 08194c4e-e72b-462c-cf12-08dc1e5d2608
X-LD-Processed: e8715ec0-6179-432a-a864-54ea4008adc2,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5c9AIcaHO2mGpvG5vBiq/lTP1IqE02aIdxFveBIMHGZjsM/b3n9w5X9FY9KhY7BM7RGN2W0v38WKO0CrKK9RQRjgpDXfAHNbIao1+1ziLDSEwf2PbQ0D5nQrEx/FQvTY8S/E4WeuheCmgx5uTnRQ+ljX/6bgXGNAeDBAynQnLINwWOYvxaoD7rzDIbRZRU1PhrpC6CFLTc39odBlvjjwIG1dy9WtqI4uAtjc3zCZuFvZZ5visvfG9v0jwCEjt0pacxiDW1IO/l3vjZvTOkXhGaahGi9pfpmx+C9lReCGFd97HXfcuC7JNUMBiCRjBU/fd1ppfTSwDEdUeHrsmvPmvIttSNNcu+XHjB4gpMJ7MVr8AtStJq1P2+eWuNU39bSgppYRGFhSnh47ZtjS6zqIFZBEORzrcQqOqewN3WvKr3fz6YR6D09wyXdlMh89lN4wkDs5YWvTlW5QUC+2QcO3GRt5phAZ6jOf5cccRpyQRZ7gZLbvHrYHOpajZ4Z+WN49Xc34k2fWrRsK6Z7IzRYGPzl+TpYPrvKIDoKaAX1yk9CdleF72l/2j+z9wTs6wFct3duRRtJCLMB2LKOj8ixCd53WSlcDIeJ9/eRGwp9bcy4feiC5ZZHze43dPgApSUEpsH1E2TRvq9kL7FpzgFjphw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2287.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(366004)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(38350700005)(41320700001)(6916009)(66946007)(316002)(66476007)(66556008)(786003)(83380400001)(5660300002)(4744005)(2906002)(6512007)(8676002)(8936002)(4326008)(2616005)(6666004)(6506007)(41300700001)(38100700002)(52116002)(478600001)(1076003)(107886003)(6486002)(26005)(86362001)(36756003)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ca2NZ7OaO2zWTJ0mz8HKtw5XWtdz3+v0IXtIL1cCg/UxvN7hwCh28Xdc1KxV?=
 =?us-ascii?Q?S0NKXt8KEmDw/YWoENxKTtysF9faWw93AcxJB6Ey27rKJ9PHubRqoaaLsh/f?=
 =?us-ascii?Q?eTPzZTjlGFUJt/HB+lhm/iEpuAF4XNsQ1oL7LCHpSGQjNiQ3koG6HlK+suDd?=
 =?us-ascii?Q?mOjGy88R8OdyogUena2+exxQvIxO4f583iLp11ZqC7sxQc+ik4l39b+jkfKg?=
 =?us-ascii?Q?B3aafESLtQ06tXA69XqqAMwYxqvfu1Ig80URoY2B9xJWhsSHyOShAuY8xgqB?=
 =?us-ascii?Q?n0qAhSsNL5aI7BBfh4WpfIgj+OqmAL2K12RCAB3+avuK77YhK5tH+p/iiHuj?=
 =?us-ascii?Q?jpQf/jbH1lfqNBLKmEGhVqP6iUatBaqBlFu7HfFZTvkueFimhtGkwCGA2gbk?=
 =?us-ascii?Q?Ga4h6rLUM2QUCicTClEFYvrEiSHMs78b0EfmL2mjxHePaNJOCr29mQP4UWni?=
 =?us-ascii?Q?e8I9C0d7y6M6vuHhJdwX3+LOVzwQo8vwvG6wBiH6sIRCs5KU26PRMM7zOTzr?=
 =?us-ascii?Q?08h2GsvycA0UGg1f9tBPM2L2NXqJgARnw3BbZHuEovYTAkAubCRg6zNebTYb?=
 =?us-ascii?Q?u4nAnrL9SpV1Dsng0Jrkr906R+CIlACRaIMjwjerya9Fn8XojvsvmUXOrBwc?=
 =?us-ascii?Q?tZD7X9g+FNVRUWQG1MML7fScdmNE3isR0P29HgJIZb8m2YopPlhC9KajZnwH?=
 =?us-ascii?Q?8hdapbleD1mFmb0MsABYowdtc1H8oc2lenx2F8EdYhdGJs/Q0jOJHlUNtDdG?=
 =?us-ascii?Q?O/YN4lKDaHMYjSl8LPRZgjlwOED2RvLXjYTz/fWnuB+axNoz72XfoA3ra9vY?=
 =?us-ascii?Q?HuCasJFJE0yaLbnibIt7/+wG40MWq5GbyuImu9gfV2leAS/sQDzVZ9vtFXuo?=
 =?us-ascii?Q?IMscRCcMsHrEQVrP6H/iXJiaybn3boi8IdFtzb27m1gdFvQwliGeIHjpmOI3?=
 =?us-ascii?Q?v9P/FbhNXIS5jqanL6irhO4tSQviciB/+5ltIUM0kI2rAnXYR8Z9Oy5nKRpr?=
 =?us-ascii?Q?J9ZuS81GzV+WglM8Yhd7Z+/9gX5rrvwvlmnpRflhRzNecAuf+yvv/jDbSzXF?=
 =?us-ascii?Q?4wI17poh2Atbn1m7ugwNi+B/ZVGIQt9rM8uasZ84uDdnmmnkxbt9qLn23BqZ?=
 =?us-ascii?Q?7X5uUgTTAXHxsBRi3ZuVDKg7BU3tHp2haimhUB+ZTtFjUKXspwcRXrVIcRaJ?=
 =?us-ascii?Q?FOqink6KvUQE1BggR2wkdRf9RZHq4JbjorLUaQzVCW835NQFp4Njh+DfTngp?=
 =?us-ascii?Q?4uk1C6xiXvuIfwBHrpGCgNEkvaugkrPlYWD3ZDZtR/nwpC0IREId6uND+Pq5?=
 =?us-ascii?Q?Oy+fcjmhfjpQJ25UYqR7I9YGEvUF17NKlD1vYaG2MnrA0IjJLDwQVRHXETEn?=
 =?us-ascii?Q?ayXNQCmlgxXea+Xci4mGL0Is0Lov0DWsMaRb0Qk/cRc7XGFQknfmZajueB+A?=
 =?us-ascii?Q?XmTgIhobbHKzUNyW1Pkl+loNTdcFZtQAcoHGh9XqIrhSN3XKGdxxwPR0JipG?=
 =?us-ascii?Q?9Xo9OLQn2Tf9Z7aQ71I4gTX1Hzlg+9wy4Z3TB285LFBDUx97W18aL7Pr3ofN?=
 =?us-ascii?Q?fHhSNtaLq0sycWkScVPY0/kCrH7O0ve9lN3XMg5d?=
X-OriginatorOrg: unist.ac.kr
X-MS-Exchange-CrossTenant-Network-Message-Id: 08194c4e-e72b-462c-cf12-08dc1e5d2608
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 10:54:20.0701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8715ec0-6179-432a-a864-54ea4008adc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQIB+1OlCCBKoonm0eBzsPTbSvzgoQxV/iXQoNVSZ3r26wTHeLusBl2qyuhhuYegIUCRFLKHQoTA4JdUto0cew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB2451

usb_generic_driver_probe only returns 0.
Inside this function, there are only errors that are marked as not fatal.
No need to change usb_generic_driver_probe to return error, only remove redundant error check.
---
 drivers/usb/core/driver.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index e01b1913d02b..b6274580b7ca 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -266,8 +266,6 @@ static int usb_probe_device(struct device *dev)
 
 	if (udriver->generic_subclass)
 		error = usb_generic_driver_probe(udev);
-	if (error)
-		return error;
 
 	/* Probe the USB device with the driver in hand, but only
 	 * defer to a generic driver in case the current USB
-- 
2.34.1


