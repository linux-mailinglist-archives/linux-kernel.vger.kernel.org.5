Return-Path: <linux-kernel+bounces-17170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 549AA824924
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE26B1F257D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409C32C68F;
	Thu,  4 Jan 2024 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b1c3HN2L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="heXGgoyR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CB02E841;
	Thu,  4 Jan 2024 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404JUX89006324;
	Thu, 4 Jan 2024 19:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2pUfZYKAbTVYFcbnVDsEGb2B03+Ft5Z/+U+GwaQUCGU=;
 b=b1c3HN2Lt0tBoDzoRWCMK/12YqxeMM5Ck310nVNVw3RgVMwrXsfprFHqdJDvUedk6Ha+
 719AgmlxWYDf+e4uRRdt42D/2yA6oJeE7ddulnEw/MefWCZ7o4B/jqgLHlW3naHFY3zs
 6v9P6IfZU5zu/L93j4MRtRGL9efIdB8mVed8U3oTvFdvPD/UJ1VHYDWQf3JTLfOCN311
 bQACRBSpExfiMuTWEvzvSCYXvyaVsed0laYI8Gf3W/62/vxiuSreYQVuWw95KRoMKtfX
 N3bsXUikiecPUtRsmo+wCbwt/8icI4vQpfQwefat9B20z8+qLXwzzGFzpZgMY6QTjf0U 0Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ve2vs009w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 19:33:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 404JVZdS030439;
	Thu, 4 Jan 2024 19:33:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ve1n64fhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 19:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bg56fFbz3fZTeO7Xnz133THFWgh3w/wF0JXxbKgxu9Gsu1It9dwxfcsux7lVXxc3TCEfKg7w3T9nW2Nl1uRntd+dkLs9xmo+rs6pjEzXeMugWiA4Hpcs5r2niOUEKpktv+0hJI+VqxE/7f5ofr6m8NU6cXMToDiocYuLISr6v3O/hgUpWkrk7cyK6WUV0GuDnBDFcbYrfs7GWXX2/VvKJuOOSPCHfM2O7XJSyhBXl/HondU4IewockATEcAR+8agm+ngt9G1gWLOBdoLfA9ZiugryAFxXa6ph/8Nzjnd9RHLODiAyRn9QAswfNFpKYWRwzIwp10CMegbDNhmzf44GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pUfZYKAbTVYFcbnVDsEGb2B03+Ft5Z/+U+GwaQUCGU=;
 b=i0yBag/HGWpw1mslfzFwfxGuO3NKlHA0sOcdCGr8S/aMArSecUGn0yWgrQjx6kgvUclS8DqU15+VcxSx+cY3ZbNO8AIe8oaOxTogc9DWmJyQugGQWVrZsZd1nOwGfIlMFwqjig8TfaYl6HwcYYLHpw1zijLcIYhFyTTKyw40mvIayBuhTNS7Yz/u1q49wuWY4zp2CJjTF49Jwi3szvHeLuBugqfp9aTepU4aT4XJB2pc5Xeyz9XEuhSpTZfjRLiNmyt0zHp8Bv8Ow4+hvsbzTxCJo6BczW4QR5qSRhw9sZf/CIE9IJdnGky54CCriD61KJOSK7RC5C+5b6fRA7Wnxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pUfZYKAbTVYFcbnVDsEGb2B03+Ft5Z/+U+GwaQUCGU=;
 b=heXGgoyRwXJ2nwCW7oa2gWKPtRPJZgt2M16j08aa53U4fg2T5HLaudQLXxzTKc+mrSBrLnhJ3w+exd7O3IXxR9vzhK/moscjOk6SP5l2rTaEKH2gcXOxUjTn62D3XwG1/Lj44AK34ymml1HpxRcbj7b7br9hqL9u3KBgrjmQc7U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4929.namprd10.prod.outlook.com (2603:10b6:208:324::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 19:33:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 19:33:47 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Feng Tang <feng.tang@intel.com>, "Sang, Oliver" <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, lkp <lkp@intel.com>,
        Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Brauner
	<brauner@kernel.org>, linux-mm <linux-mm@kvack.org>,
        "Huang, Ying"
	<ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Liam Howlett
	<liam.howlett@oracle.com>
Subject: Re: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Thread-Topic: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Thread-Index: 
 AQHZ4hUlovnTGopJRkWINRJx8jG2QrARAWsAgAVqhYCAAMJWAIAAJUUAgAANNoCAs2TmAA==
Date: Thu, 4 Jan 2024 19:33:47 +0000
Message-ID: <D00399D9-D629-4CE3-AC32-636FD6F06C24@oracle.com>
References: <202309081306.3ecb3734-oliver.sang@intel.com>
 <C85F44FD-BC7D-421B-9585-C5FDFAEA9400@oracle.com>
 <ZP++GV9WURg1GhoY@xsang-OptiPlex-9020>
 <84984801-F885-4739-B4B3-DE8DE4ABE378@oracle.com> <ZQCAYpqu+5iD0rhh@feng-clx>
 <ZQCLdzmtVcjxZWXt@casper.infradead.org>
In-Reply-To: <ZQCLdzmtVcjxZWXt@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4929:EE_
x-ms-office365-filtering-correlation-id: 86a2e50c-db63-4a72-8a39-08dc0d5c1222
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Lrxtlf6ChVHGvnnGdr90XSijBREoJ0ynWvCI0s+XYZ11PAF82kKGsl0JrNufIyDerni+S9LWnqxUIJsmtBcQdYFbR3Uz7xNbEWTJVaA4B88i0lohNIXOLmqx/l+PB5EiPoCFuB9V5hiI2rf2HrfgIE7ZrMVuB3ZeynW8gLfIeniXIiu2uw+3p6Yb06r5jA0mb9qj1bdh2h0D/Y4qewafo3TXBvykZ9DHK4yBHaSC1EA06bpms81D3l0OxbJ0klmNK883DSM1TYMq5twH2npAUEu0So+S8mXS8iXPTjM7ZOexlwLLEE2vIkqPE2xSqF81d2E7OME+7w2XMiwSBHE9i5UasYqez/l1RxvZyOHYATfeKnvhi9cofDV922C8ZCrN3uAKcq2YIm9R9AGQ+DVDLO+NGevh815GKsKZZn9aiXe3g7hUasflMCg/8SrtVelDMDzBUelm/ZCN0bm8C1MZncvDEBcceCA6FRI2zJJZelvXf9EY3YaMccOS+j8r97QnToRzoB39flPiZMbUJwobGOmUFtB3aLBWtFDhYoNQZY2s3rtbg8FAYRX4h3Z8F4Iqb/0uDuPHnrFyMc2Q/kjECIah33ic0T311inDIbXmVfMeh687rbPUojmFI38hPbkUmo7PwZz9RQOnVn63jRPsDQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(26005)(6486002)(2616005)(107886003)(478600001)(6506007)(6512007)(53546011)(71200400001)(122000001)(38100700002)(83380400001)(41300700001)(8676002)(66946007)(8936002)(4326008)(54906003)(91956017)(6916009)(66446008)(316002)(64756008)(5660300002)(2906002)(7416002)(76116006)(66556008)(66476007)(33656002)(38070700009)(36756003)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NlJnWkRjNC9MR3BwdkxrYVl4dExkL3llbFdaM0lVUE5aczduc1dTa1lZRER4?=
 =?utf-8?B?MmVHSkZMNmRmTEMxU1pYVTB4dkdYdlp3bnhEUmYyd2w4Kzd6N0c5cWF5RUhX?=
 =?utf-8?B?bFErNEpCNTloenQ1YXhRSFJmNlFjemwxc29jQmlHSWllWGhyMUZSV212ZHB6?=
 =?utf-8?B?S3FsRU5sMVVMTVhRZXp5d0loSitqZEttMVpBZDlweTVHa1dOLytlTjVTQU5j?=
 =?utf-8?B?clpqaFVCWjM4NXZaR05ua0puelc0alREZ21aSkNYa0hYdHpta3Z5VXFzZ3JP?=
 =?utf-8?B?dVNHQnN5QkhIT01aZmhKeGVnYm9IR3Nya1FaMi9DR0loN3Y2RGY3VWJmcGdE?=
 =?utf-8?B?TlU3b21jUU5aWUVldGVDWEpEaEVWUkY5dXUvQm5jYXlGUmMwMWlIaDRNWjgx?=
 =?utf-8?B?V1htbGVxdDM3NURieTJRbThkaXRTWWlFc2ZTSmF3OWtReVRkMUg3YVBrVkFV?=
 =?utf-8?B?TWh4eDg5bmFNdVNiMlVZMkkvak1MaU96dmdSMXEzZVFzZWNEMWx1QWZucnYw?=
 =?utf-8?B?V2FOQVVUTFVaM2RyQVFDQVY0QU9lQmJwekIrK1A4ZEJhNzVFY0M5bXIxN3NE?=
 =?utf-8?B?NCsxcEo4VWpQTWFoTEJZTzdkYm13ZTRtVGppL3hoWTFhaVZTaXppNmx6THYv?=
 =?utf-8?B?ZitFdm9yN291ZUhQbkpCWHRVdTdwRXZqTGdHdnE2OTl3Nkk2WXFpMzg2b1FQ?=
 =?utf-8?B?NG9HaXBhb2V5REZPL3UvS1p3VVMxdC9sSS9zQmpSR1V5NFBhSk9vbjc0R3I5?=
 =?utf-8?B?REFCcXVtREgvMEs0UXNTZmZFZjJoZW5vQUE4dmpIOGNpaE4vZnEzaHZaWjFa?=
 =?utf-8?B?VnVlNmNiM0JWeDkvYWxrdHprWVdwWTRaaFZ3WjlvQkUzYzNWNXJhVjJUenZE?=
 =?utf-8?B?WVVhVnZKWENrSzVwRzJRcHRCVVYvUVR6WEc4cjZuWmEwQlFRYklYZkZRTmNs?=
 =?utf-8?B?Mk55Um9hb09uUWlGcXdVR2NCLzNJbFdKVGhQbE5FRFRFZGZxN3RBNkJSbklF?=
 =?utf-8?B?MFVxb2JBL2JIRlB3amFnZ2VkSmVQSmNlWjBSYi9DUTZ3RktHSk1xeDBzcUJO?=
 =?utf-8?B?SGhLWU1PWisvYWkvdjZtUVI3anU2WkZISW0xbXZFcGhtSHFXWDhHSmUwNGRG?=
 =?utf-8?B?UGl5RWw0dU9sUXZXWU8rOXNWV1ZibGo0cjdWTXIyWEZkVTJLeUxmQko1M3VF?=
 =?utf-8?B?T3UvWkl2SktkNzRzWW80eGNscVBGN2l2QzdXTlpiN0VWSEJlUjBjMy8xMkYy?=
 =?utf-8?B?UTRoUUhpOHJWcU94bFZTT0FHT0JyY2MrOENFZmxreXBlR21jMEtoNnFRalNk?=
 =?utf-8?B?RFBRQnd1M0xxTmZnZVhGeTVYWDAvSmQ1SmVtWWF5TFIrQkozeERnTXk4WmJp?=
 =?utf-8?B?NUdOZlpIYm9wYklONjlETmpLK3RFWFpDYXRqNmlKakNJZkpoZm0wMk1QRUdq?=
 =?utf-8?B?bHZzd3gyNXRUWEppYng1TEJFVUxJVlZSb2RERkVkUmZyRVl6bGZzby84Vncv?=
 =?utf-8?B?eHd2MlBScmo4MzYzdEk3Nm9mOG1WRVRKQTY2OGZXMTd3VDZjaUZaTWMxeW1Q?=
 =?utf-8?B?TVpHekdBVUhaRzA1eEVuZ3JraUlrelZzSGRSeDVYT0xQMlFiZldkck9ZWXhZ?=
 =?utf-8?B?SGFPVXBRcGdRdWltOCtib2NsU2VqY1RQYlArbmhWMnM5NEUveXJjVURDcjdU?=
 =?utf-8?B?SGFYdmNLQnVnM1lZWURXdldQWGJoUGZ4TmRVVVVwTkFhcmlEcEMycXZiOXJx?=
 =?utf-8?B?SjN2elpwekQ3MW5Ib0pLbHBwUkFKWXVvaFJLUlI2emw5bzdMOGo2eC9wUGJr?=
 =?utf-8?B?WnFtZ2FjVzkxK0xENlgvdHpsUzJBbmNtZjhicjVWamoxb1FkNFZsTG9VSFJ5?=
 =?utf-8?B?UmNrajB1RmdOZ0xyNzdrSURVSEw4T09GbFB1RDFCd0QzZjUyQlFQME9haitP?=
 =?utf-8?B?Tmw0K3huYUZCREFJMEhmYXIxN2NZeHZxMDdrQ0JEWlNiZTBNK3NEd2prcXJn?=
 =?utf-8?B?d1hTckdYdGNxSGZFOEl1VHVmaVArejNvb283dVJ5WWordXFoYWJobHFvRGF4?=
 =?utf-8?B?bU5BUUtocTQ2bG40ajRRVlRFQjJIYmVROWdVNXh2cG5zY1pzS0FtWFY0RlN6?=
 =?utf-8?B?VUpONkVMOXZkTEY3RWVybittdTFHNks4VDhDRm9XRmNSdU1TdTlsUUdiTW9W?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55676B30AA27FD41961D0CB158007731@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	svTa4yBMQ4LUKU+G0Hwh6u/ifKbnSRr8u2tW6jJTilKSJPDOsWg4UsiNtuZiEmIKQz04VnlJq6X6WwxXg305FpFOhMnKzlwC7d2WSkUh0qqxFZb6x2NcTaBBoBiZ2GbyvLKRyCBKBtkyKpHJyt5SGiIeEaakImSptMc7ZnY857MT0yfHi/x8b9F8geQs/c7fnjLQJ3MZlnIrTzrt/BQhgkXwXKFV9SZc2VcFW/ssW2GUnGynp7sAYNR/DUUvnRgh8p+ynv+w5AY/7C0AP7Fcy0RHyX4/vq4moHAr2k5D33oDxmBdCwDN13o0Heis25P2Zb8kGX9THB/a0GOLsmaUV9gQM2Lh7dXaRtJ3WDFaJZGY5Xdhxpn0mZ5QjAD1ZqGyWy4fpNwC3+2C6x+JCpIOVkpTS1qC+FSDWZkQNPSxnB4saiCU+kGpp7zQHavpbxmuc3rtBAOWEBGqTwq5+U+BqoS3msXBkcfcWV0Qz6zyqDq6bMhKbh0R1HG5Ag+tsLgjF60Boe7LCLC4eFZJHsdyo9Z+qd3KqCATacNmu76Nu+qqI2gmWBMZaMU7Y+LsseZUwGHBNbxog1Unv4xT2g4ePkYiuoqp9VkWR+8FCgKq93c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a2e50c-db63-4a72-8a39-08dc0d5c1222
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 19:33:47.1568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fqf8yL/fqFgIo29Pfg0XTEusf/pTDLLz9XZe9PkoK4O1CCwSXsk4CBGQAmR20AKZwBM6knQzUaLuVT7kPEt0LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4929
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040152
X-Proofpoint-ORIG-GUID: QezNIFchSCrQYxIKRxxIIgBY_Fs-Oc_8
X-Proofpoint-GUID: QezNIFchSCrQYxIKRxxIIgBY_Fs-Oc_8

DQoNCj4gT24gU2VwIDEyLCAyMDIzLCBhdCAxMjowMeKAr1BNLCBNYXR0aGV3IFdpbGNveCA8d2ls
bHlAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIFNlcCAxMiwgMjAyMyBhdCAx
MToxNDo0MlBNICswODAwLCBGZW5nIFRhbmcgd3JvdGU6DQo+Pj4gV2VsbCB0aGF0J3MgdGhlIHBy
b2JsZW0uIFNpbmNlIEkgY2FuJ3QgcnVuIHRoZSByZXByb2R1Y2VyLCB0aGVyZSdzDQo+Pj4gbm90
aGluZyBJIGNhbiBkbyB0byB0cm91Ymxlc2hvb3QgdGhlIHByb2JsZW0gbXlzZWxmLg0KPj4gDQo+
PiBXZSBkdWcgbW9yZSBpbnRvIHRoZSBwZXJmIGFuZCBvdGhlciBwcm9maWxpbmcgZGF0YSBmcm9t
IDBEYXkgc2VydmVyDQo+PiBydW5uaW5nIHRoaXMgY2FzZSwgYW5kIGl0IHNlZW1zIHRoYXQgdGhl
IG5ldyBzaW1wbGVfb2Zmc2V0X2FkZCgpDQo+PiBjYWxsZWQgYnkgc2htZW1fbWtub2QoKSBicmlu
Z3MgZXh0cmEgY29zdCByZWxhdGVkIHdpdGggc2xhYiwNCj4+IHNwZWNpZmljYWxseSB0aGUgJ3Jh
ZGl4X3RyZWVfbm9kZScsIHdoaWNoIGNhdXNlIHRoZSByZWdyZXNzaW9uLg0KPj4gDQo+PiBIZXJl
IGlzIHNvbWUgc2xhYmluZm8gZGlmZiBmb3IgY29tbWl0IGEyZTQ1OTU1NWM1ZiBhbmQgaXRzIHBh
cmVudDoNCj4+IA0KPj4gMjNhMzFkODc2NDVjNjUyNyBhMmU0NTk1NTVjNWY5ZGEzZTYxOWI3ZTQ3
YTYgDQo+PiAtLS0tLS0tLS0tLS0tLS0tIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSANCj4+
IA0KPj4gICAgIDI2MzYzICAgICAgICAgICArNDAuMiUgICAgICAzNjk1NiAgICAgICAgc2xhYmlu
Zm8ucmFkaXhfdHJlZV9ub2RlLmFjdGl2ZV9vYmpzDQo+PiAgICA5NDEuMDAgICAgICAgICAgICs0
MC40JSAgICAgICAxMzIxICAgICAgICBzbGFiaW5mby5yYWRpeF90cmVlX25vZGUuYWN0aXZlX3Ns
YWJzDQo+PiAgICAgMjYzNjMgICAgICAgICAgICs0MC4zJSAgICAgIDM3MDAxICAgICAgICBzbGFi
aW5mby5yYWRpeF90cmVlX25vZGUubnVtX29ianMNCj4+ICAgIDk0MS4wMCAgICAgICAgICAgKzQw
LjQlICAgICAgIDEzMjEgICAgICAgIHNsYWJpbmZvLnJhZGl4X3RyZWVfbm9kZS5udW1fc2xhYnMN
Cj4gDQo+IEkgY2FuJ3QgZmluZCB0aGUgYmVuY2htYXJrIHNvdXJjZSwgYnV0IG15IHN1c3BpY2lv
biBpcyB0aGF0IHRoaXMNCj4gY3JlYXRlcyBhbmQgZGVsZXRlcyBhIGxvdCBvZiBmaWxlcyBpbiBh
IGRpcmVjdG9yeS4gIFRoZSAnc3RhYmxlDQo+IGRpcmVjdG9yeSBvZmZzZXRzJyBzZXJpZXMgdXNl
cyB4YV9hbGxvY19jeWNsaWMoKSwgc28gd2UnbGwgZW5kIHVwDQo+IHdpdGggYSB2ZXJ5IHNwYXJz
ZSByYWRpeCB0cmVlLiAgaWUgaXQnbGwgbG9vayBzb21ldGhpbmcgbGlrZSB0aGlzOg0KPiANCj4g
MCAtICIuIg0KPiAxIC0gIi4uIg0KPiA2IC0gImQiDQo+IDI3IC0gInkiDQo+IDQwMDAgLSAiZnp6
Ig0KPiA2NTUzNyAtICJjenp6Ig0KPiA2NDMyODk3NjcgLSAiYnp6enp6eiINCj4gDQo+IChpIGRp
ZG4ndCB3b3JrIG91dCB0aGUgbmFtZXMgcHJlY2lzZWx5IGhlcmUsIGJ1dCB0aGlzIGlzIGFwcHJv
eGltYXRlbHkNCj4gd2hhdCB5b3UnZCBnZXQgaWYgeW91IGNyZWF0ZSBmaWxlcyBhLXosIGFhLXp6
LCBhYWEtenp6LCBldGMgYW5kIGRlbGV0ZQ0KPiBhbG1vc3QgYWxsIG9mIHRoZW0pDQo+IA0KPiBU
aGUgcmFkaXggdHJlZSBkb2VzIG5vdCBoYW5kbGUgdGhpcyB3ZWxsLiAgSXQnbGwgYWxsb2NhdGUg
b25lIG5vZGUgZm9yOg0KPiANCj4gZW50cmllcyAwLTYzIChjb3ZlcnMgdGhlIGZpcnN0IDQgZW50
cmllcykNCj4gZW50cmllcyAwLTQwOTUNCj4gZW50cmllcyAzOTY4LTQwMzEgKHRoZSBmaXJzdCA1
KQ0KPiBlbnRyaWVzIDAtMjYyMTQzDQo+IGVudHJpZXMgNjU1MzYtNjk2MzENCj4gZW50cmllcyA2
NTUzNi02NTU5OSAodGhlIGZpcnN0IDYpDQo+IGVudHJpZXMgMC0xNjc3NzIxNQ0KPiBlbnRyaWVz
IDAtMTA3Mzc0MTgyMw0KPiBlbnRyaWVzIDYzNzUzNDIwOC02NTQzMTE0MjMNCj4gZW50cmllcyA2
NDMwMzkyMzItNjQzMzAxMzc1DQo+IGVudHJpZXMgNjQzMjg5MDg4LTY0MzI5MzE4Mw0KPiBlbnRy
aWVzIDY0MzI4OTcyOC02NDMyODk3OTEgKGFsbCA3KQ0KPiANCj4gVGhhdCBlbmRzIHVwIGJlaW5n
IDEyIG5vZGVzICh5b3UgZ2V0IDcgbm9kZXMgcGVyIHBhZ2UpIHRvIHN0b3JlIDcNCj4gcG9pbnRl
cnMuICBBZG1pdHRlZGx5IHRvIGdldCBoZXJlLCB5b3UgaGF2ZSB0byBkbyA2NDMyODk3NjUgY3Jl
YXRpb25zDQo+IGFuZCBuZWFybHkgYXMgbWFueSBkZWxldGlvbnMsIHNvIGFyZSB3ZSBnb2luZyB0
byBzZWUgaXQgaW4gYQ0KPiBub24tYmVuY2htYXJrIHNpdHVhdGlvbj8NCj4gDQo+IFRoZSBtYXBs
ZSB0cmVlIGlzIG1vcmUgcmVzaWxpZW50IGFnYWluc3QgdGhpcyBraW5kIG9mIHNoZW5hbmlnYW4s
IGJ1dA0KPiB3ZSdyZSBub3QgdGhlcmUgaW4gdGVybXMgb2Ygc3VwcG9ydGluZyB0aGUga2luZCBv
ZiBhbGxvY2F0aW9uIHlvdQ0KPiB3YW50LiAgRm9yIHRoaXMga2luZCBvZiBhbGxvY2F0aW9uIHBh
dHRlcm4sIHlvdSdkIGdldCBhbGwgNyBwb2ludGVycw0KPiBpbiBhIHNpbmdsZSAyNTYtYnl0ZSBu
b2RlLg0KDQpIZWxsbyBNYXR0aGV3LCBpdCdzIGJlZW4gYSBjb3VwbGUgb2Yga2VybmVsIHJlbGVh
c2VzLCBzbw0KZm9sbG93aW5nIHVwLg0KDQpJcyBNYXBsZSB0cmVlIHJlYWR5IGZvciBsaWJmcyB0
byB1c2UgaXQgZm9yIG1hbmFnaW5nIGRpcmVjdG9yeQ0Kb2Zmc2V0cz8NCg0KU2hvdWxkIHdlIGp1
c3QgZ28gZm9yIGJyb2tlIGFuZCBjb252ZXJ0IGxpYmZzIGZyb20geGFycmF5IHRvDQpNYXBsZSB0
cmVlIG5vdz8NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

