Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5DE7EEACA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 02:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345632AbjKQBlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 20:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjKQBlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 20:41:20 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED6A182;
        Thu, 16 Nov 2023 17:41:16 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH10Fck010896;
        Thu, 16 Nov 2023 17:40:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=FruuIqe5NR7S43Q0D08AJDFmaSVH8gSntLZZCBQ8ypk=;
 b=cRF3q3gsny4Ax8Z4hHGAO3TsYzqTcz+ch/9V+jpc17WAGsf4qqhyzP7bNbkl/vsPM0Zd
 LGs+a9KeIzVoP37XH9VClv9S87rkASVaBGDnir7h9uh5S+nQKIAq1iSEJZZyNbiWmTvS
 bQsnampuEbiviYgEc9vrIVz1a6NHNgMabL0ZRVUs0L273pi7GJFLpmrUo7/IyB19pS1Q
 D9gbLFc2h1zdU7KNgnOC8+R/kgXidls9D6TMolvzzrrF+zX2jyGD/Bb3wsj+WOr6DJjz
 Ja2AW/RU60T/HrZayPxH5Won+klvLMeL9tsX389smFKilh4dcwyynqqppzePvlzfrCBK 6A== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3ua94ka46c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 17:40:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1700185251; bh=FruuIqe5NR7S43Q0D08AJDFmaSVH8gSntLZZCBQ8ypk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fQDagDj2ADwzooFDnR/X4hryDa69fjdG3GJJgM8r9Mm90qo56eRi7q85U2qStChHj
         3TV4FQLiAFZdnGNgb0NAFx4KQ/t1VU8XtyyKDopADVrBsFWC0ul9pjJB4pl59kwE73
         XNud4OLVDLIERaBhn3viJFJ6fojVzq0/VZS/uJGSBqY8wmjm6MZ5yPFqAwDJhUt3o8
         ecVD6teT/AtzQtdwl7XF0mNegvQGdyDXraEiCiOXw+1A+D328q43hgsn1w8HaCp96x
         piRbk8PMX6s2avIMPiJJu37epmYiy22Dd4/uR4Dkw2iKRfyPL7+iv0sxF5cAV272hN
         muHKzhGc5Gw4g==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3C15840565;
        Fri, 17 Nov 2023 01:40:51 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C9FA8A025D;
        Fri, 17 Nov 2023 01:40:50 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=JAMV0+0x;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3AB194048F;
        Fri, 17 Nov 2023 01:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRQmOybMURQTFOssgFvIoD9pI+3uq2l2nVLA3xgSf4dX3CySf20yuljRHApBxjHWG8b6Ut9YwO9Smd2o40YNdH4RuohYYtniE7ppIapSXovv72E/jpMlmdASOqjAy9GFWP7N4TbST/OVdlmyFExAcTwZdXsLTqFtoRdpjTlrxya1PSICRr0TJuqdxp6wwbwXbd928g65+UAg72siQEJox77MfubuV/yftd8q746DFUq4cvfRV1YpY9/Za1789WCB58WqTbkD2pDQSMsVSDC7LKbYwSYoBYw+0/cqIq+9izhiH7YIniexa6WSV3ingqAnOMx8mGtihz4c0wOFpLORDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FruuIqe5NR7S43Q0D08AJDFmaSVH8gSntLZZCBQ8ypk=;
 b=btQccJ4ausqHPWVZ9XoAqeu+m6BSBCQIGTpfge63REtllNwzhJUtRs0vgA8nXxJTUPStWSbbcMEbmpUVHNoURuaCfi9Uop19X31pyCclpdMJlW19E5xRvbCs7C8H6iqZTlNOcRZ9KhbjYTg2o44+PMJPC7H9DfssFqU5HuB2DbiaRb55oTxjO4Iz6e/2Z4QY1DHQq5OeSRURbmExQZXBykmwsqGlHkdS81DpTisSSCuWc3AOPRQckoVLZOPF1NyOrXnS0c0jMSNSNL1l1MdP20nHEw2m2iQk44TtVfsuCR1HSFu1nr4frdtxbGCdPmazxLjU0S7HXGcn44eWsP1THA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FruuIqe5NR7S43Q0D08AJDFmaSVH8gSntLZZCBQ8ypk=;
 b=JAMV0+0xYPXzNOSbOgwgoPDQmtN96Ejtcx/L9O96SrAabuX+9YyqXk+DkqLZgOsuVHd6gG5FF6shtv5G7ViwhstID+Tx+o/ZM0X2XKwT6NHS6H9d1d7wnd3idengA8FhYMp8uB5fM7/Q6qnawAM/9rE14tuw9GOpjXdJvjoXYIE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Fri, 17 Nov
 2023 01:40:46 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e%5]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 01:40:46 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     "20231116174206.1a823aa3@synopsys.com" 
        <20231116174206.1a823aa3@synopsys.com>
CC:     Jisheng Zhang <jszhang@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lu jicong <jiconglu58@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] usb: dwc3: don't reset device side if dwc3 was configured
 as host-only
Thread-Topic: [PATCH] usb: dwc3: don't reset device side if dwc3 was
 configured as host-only
Thread-Index: AQHaGKveCMbrfcJ+4k2eyt7FIy9Uo7B9K1KAgACReAA=
Date:   Fri, 17 Nov 2023 01:40:46 +0000
Message-ID: <20231117014038.kbcfnpiefferqomk@synopsys.com>
References: <20231116174206.1a823aa3@kmaincent-XPS-13-7390>
 <20231116175959.71f5d060@kmaincent-XPS-13-7390>
In-Reply-To: <20231116175959.71f5d060@kmaincent-XPS-13-7390>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB7842:EE_
x-ms-office365-filtering-correlation-id: b38fe5e1-be9c-4ce2-51e7-08dbe70e3861
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7eIexZPAx+3ES1+0+b6qZ46DSPWtzfKk9B9UlazOrJHkn4b2SjZUxfj/TjeiE1c9Buw1fBNLYxf1DMqZqUSQ47qLQGx/RV2p5sg0MHFBiUyGrNYILX2UFm+zXfGo6JGVsaYs0fTNgLOJi0CXeSxIm4kl3OZ2ocAvZ6RPBbqHSBFGJn6AsguCGSqoF3s1xCxPVHUcbhocrm+cYcFbO5vdERjC9bOwro6GGm2OLoYXKMgqWrCfSncNqHT7+tKhUAEfqekFjidtcUcmTxvPyJByQWbtAC9u6Z8fo5wJVfjsj7a2kO8RafPSNasxyjfExvocZzicv3dilCI0BqM9kHJHJhjgL8PslFF14LP/BrSdbxgtaGQBqJiV2YnRtXeuWTJcGXDjn4Qg15M30WQUXZIPj/JQf+McoJrtLUEmo+W0+L6gWbAe9Da68Xov/JyvbTUECspYqHmizcIaOa1Zg06b8IPEv6W1FwiZ/HO1Yh64Z31iG+ZsJz/9oDQQFw/0x32ZzXc4R5eoKDJuUpA/46XUdfaX+4QhpjoJwblvfsi2mZb5mXzNabN3rTvuaOvoOq1soH0K5OFNpBI2j8BnQ/COI8E6m/RY5yFAvUBUzICiICpPrPlneQTE8jAObRDAPVI0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(8676002)(122000001)(38100700002)(36756003)(3716004)(5660300002)(41300700001)(83380400001)(38070700009)(66574015)(2616005)(6512007)(26005)(6506007)(1076003)(86362001)(71200400001)(2906002)(66476007)(64756008)(66556008)(76116006)(54906003)(6486002)(6862004)(4326008)(478600001)(66446008)(66946007)(8936002)(6636002)(37006003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2w0OHRiVWJpcE1DN3JDNS84Z0NRb3dsUTBGUGRQZ3lnTGYwbDkyVTBTVVMy?=
 =?utf-8?B?SExPa1JEQVFwU21rNjlOQTdUcUJRbTcwRXBmOTJ3Z3NmU3daV3MyYW1HV2hS?=
 =?utf-8?B?R1IvOUFHNHBlRWREbzlPTEx5c1ZJMWRnMTQxMlVmbTRwMVU4L3N4UkxJOTd2?=
 =?utf-8?B?ZDBzUDF0dVFTOGpRT1V4bFFYTFlPMW42MkJHOEttZFdvdk1YVnpvaGFpZVBJ?=
 =?utf-8?B?SXYzWGw4anVUR0MxVHpMWUwwSDR5V3oweUtjeWgwR2hpeTlKYmNuN2lOK0Iy?=
 =?utf-8?B?OG9JbHRkK1FRcWlDK1Y4eFlTYlpkQVdJb2VUMzRNNEVOditpTHdnSkdZWVRw?=
 =?utf-8?B?MEZpNzhQY0lTcGV5aVA2VjQxZ2x0NHJwUzkwcXpmZEVtWlFBRkFybmNDcmFQ?=
 =?utf-8?B?djVEWWN6UVZyQ2RZeCtrSlhnaXRsVjF0d1Nhd2hRMGZKeG9nYksvdHlLTVhU?=
 =?utf-8?B?SmpLdUVUZlFxWDA4SUl5cGJ6WkFsdEl2S3hiUUNJNHBsVWl6U24zNkJhQ2ht?=
 =?utf-8?B?cjEwNnVNTUhlWGlBZWMvY2FEbDZ1L2xpc2dRL2I1V1hyL0srN3ZtOFZFY3VC?=
 =?utf-8?B?MnllYTIzTmJUU2s1ZDhlS2JVbVNwaTNsdXBUTXJGc2tTbjJQdEZPb0RJV2Fn?=
 =?utf-8?B?ZnV2ak16VENwRGdDdEhUNmNmN2REWkpHa2VWSitrcDYvWHJ2ZGxTTDdTUmp6?=
 =?utf-8?B?K3RzU2RFLzg3Y0V3R1dTRnBZRGNDb1o2U3R6ZWpJQ0JVZXJET3RHZmMwcWhP?=
 =?utf-8?B?QVNrclJyQ2o0MlBSdWNEaTNoeUMxM1hCL3RmSXkvdUpXdmlLR2pmQk1ocGxM?=
 =?utf-8?B?ZVQ4WlVXNDZZc0JyRkliaUt0NXBoM05pWlFxNlh0RkxXT1JJVStjZ0VoMVN0?=
 =?utf-8?B?dWVKbDFQOENTbkQrQVhpd2Qrdkt0eldLbEVkNlM3ZTRJamJ5NWRxVzZ2N01O?=
 =?utf-8?B?K1pjcnhLR1UzeW1qYjhSZ0tCVzBjNUVyQnllajNIams3bm5nb1hyRmx3WEww?=
 =?utf-8?B?a2VMbDRGaXVmSDlzaDkzM3BEZUNidjJtRTZQM0doN1ZZVVlGWHJ6QUlwMlBx?=
 =?utf-8?B?YzAyWUdJcTBjVTgzM2JOQ0RBQ25HQ3lRNTNWRUZ1SzlRWDljaFBYSkpkdkVa?=
 =?utf-8?B?OFJGN3lNOUNrdjFZL0RweUs4bC82NTNiQkFubHg3Ry94NWpkblN2K3BwNmlm?=
 =?utf-8?B?RE5KUUJMd1g0a21jRTJFYzFETFJUazJXNnhkVXJzNlpxMFFmZFovMWZESjNo?=
 =?utf-8?B?M2RhbXdLaktRaEFXOEoveU5tdS85OFM0V3dFdEVLc3ZGKzZGZ0xQaUt1OVBN?=
 =?utf-8?B?L0w5aVcyWml4UFdVZGV5cm9DQ2VIbEg2YUtvd2FoMnB2cEFGRXVBYVE2RU5j?=
 =?utf-8?B?d001cmVZdStFcm9Sc3JlRUVMd2lmVmhETzk5RHlsNlM2K1VTVktPaDFndE5i?=
 =?utf-8?B?bitzUlRrZU9pdjQvOFFRS1IxbW9SUCs3Qk8wZzQwK2o2MDAvak51cEREMS9D?=
 =?utf-8?B?amYyTlFqKzIrK2YzYmFESzhqcEM1M1lySldhQzZ5Smd0M3ZVT0Rkc29SY3ow?=
 =?utf-8?B?ZWcyR3ZraU9sSjhOZFVMdmpEbEt5OFdqZjZCRFgvaVN3b3YxVzArRW96TEFa?=
 =?utf-8?B?RkR0QVZHWUw5bTYyck94eEx1VU5nbWRpMjQrNERDa3FMTFB2and1bmFIRzQ4?=
 =?utf-8?B?UGlMRllmSWtFMUdaUnIvNmYyaTg5OGFQOE8yeFJ3TFk3RFhwVk1oSUV3TVVZ?=
 =?utf-8?B?cytaVGV1ZWNtVW9PYjNtYWx1a1VTT1A5MTFnMzEwRktQTnR5dXhhZ3B6a2c5?=
 =?utf-8?B?ZENRNk9YSHcrcTd4Z0x4azY4Q0g1UEZuQUJoTlVob09GMjFlNUJTMHROZHcr?=
 =?utf-8?B?aDdLcGNvS0hLb2poL0VMVGdwQTNBQW9lbCtkdzlGZVhZcWcxUXVhZWhFa0pk?=
 =?utf-8?B?QVN4TWZBcG01aDUvN3lGcTVnR2FsRDB3MmJ3akpUZUM3dW40LzcwdnhjcmYz?=
 =?utf-8?B?S1NOWjVEbnIyQm45YWVweElHbDZEN0psOFJJMG5oNWoxOTFla3FSeWROWVBt?=
 =?utf-8?B?R3VCSzljUC9OR3ZWQlBCeFR1QThsRDdtblkvOHpyNEJjeHBXU2hlVlovMm1o?=
 =?utf-8?Q?XU9zpFonOaS+JnDUE0GKXoNTR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D0F445521186C44BACECA201BEEE9C7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RThRUVpmUFhURWRCTjZ2R1J2TmthMm4yRk5OOHJHUWZncDRnK1doL2ZVdnNi?=
 =?utf-8?B?Qm1DSVMyVGRCR0ZzYkU3R3pTeFdTenE3djVwRzJnd2hyNTVpQzU5Wmcwbjgr?=
 =?utf-8?B?Ly8zS3VFKyt1UmJMZUN2dFJJdjAyTHVnWDF4VXVSMlMreDUwRGNtdmFyNE9i?=
 =?utf-8?B?WG55cXU1VThTb3ExVWJvSUEvamF3VVVXYXdrK240MGxzYU82cStBRWpDUU5C?=
 =?utf-8?B?RXA3QzVYNmN6Mk04Y1UwV1Nlam43R3lVdVV2YnJlWXpsdmcydEx6cXNlS0J6?=
 =?utf-8?B?NWkwRm9zdTdmclJ1aDBJK0dFNmNzWkxOdHFhUWRMYjU0QVhLZnR2dTRTZWta?=
 =?utf-8?B?ZDkzb2VweTIwSXlBTkx2R2xpQ2xnWHBFY0tmcnhxYzlRMnM2S0U3QUY0VW81?=
 =?utf-8?B?VitRS0hqc1RLZmFVSlUvWXQzMnlnLzdjSkp4ODVncEhjQ090YTNyS1loc2JH?=
 =?utf-8?B?dnJVSE9rSFJUWXJuWTA4c1FvTGIwVGZoMXBqSjd5SHNXVkx5bkgzaHF6Kytv?=
 =?utf-8?B?TWZDME1obFpUUHIxdGJOU1hISk16OGliZTZsMjRIZGxTLytpL1kraG8ralNG?=
 =?utf-8?B?elpBOVQwUTB3S3NVdUFvZmIzNzMvbnh2THU2RUFrOUYyZDdYVU5FRmJMMDFw?=
 =?utf-8?B?M3czajhncDdvMkFSSXdwWUxkNHFCcG4wWERRMkdqZXlCenBOYjBDR1VyTHYv?=
 =?utf-8?B?dzBORERiV0t5VVJBQXpCR1V3WkdSNzl2OFpvamNWRlJUN1dzVDJ4bHc2dy9B?=
 =?utf-8?B?RGsxVW9uRUFaRk1pdXhsQ3RDcENxUHlKQm0wUWFJUnduMnRPZ2lnTmRFZ0o1?=
 =?utf-8?B?ODRsTUhNMzZUOTFWWno3aWNQVFRzZ05YVnpVSm5WbjRXYnRzRGVxNXlVaXVz?=
 =?utf-8?B?MWlicklMejNlVUE5NEphU0pUelFOZnNVdStESHhtNDI3T0tLK1VLYWZ0cXVa?=
 =?utf-8?B?RnFoUGs1RnNidW5iQWl6RERrNFV0bGdJbEZFNHozOHA2RnJoUDA0SWk0VlVm?=
 =?utf-8?B?ZThPUVc0RjJud2NETWw2bGRBVjRaK3N3cytnL2lSVi9hRmdHdXBMNTFiTCsz?=
 =?utf-8?B?YURuNVNVbzBORFZacnB4azkzM1JmREl0OGVlRithOHNNSWFrYlMvM3JNUkRV?=
 =?utf-8?B?RzdNSXRUd2haby9MSGFVQ2pJTjNnU0FodEIwbEdlS3A4MDNQSHptcVhZSTZn?=
 =?utf-8?B?QnlPby9udVVyVy9SNXZBMFczajJZM1pBaXBzQzJndXpvTmdBVDF2b2FDR2Ns?=
 =?utf-8?Q?KNJnuqOLtee3M4N?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38fe5e1-be9c-4ce2-51e7-08dbe70e3861
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 01:40:46.4322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pkE8u/1RtMmhqjaeAbmmGaskS8LDjQZb0VmsABfvo1gag98xByB2VEhyuzLUvmSM9AcmnzucK4kxm/++z5GTgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842
X-Proofpoint-GUID: m2Ist_uZzNIB46VskVHeeORo4sKuMRCu
X-Proofpoint-ORIG-GUID: m2Ist_uZzNIB46VskVHeeORo4sKuMRCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 mlxlogscore=639 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311170011
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFRodSwgTm92IDE2LCAyMDIzLCBLw7ZyeSBNYWluY2VudCB3cm90ZToNCj4gT24g
VGh1LCAxNiBOb3YgMjAyMyAxNzo0MjowNiArMDEwMA0KPiBLw7ZyeSBNYWluY2VudCA8a29yeS5t
YWluY2VudEBib290bGluLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEhlbGxvLA0KPiA+IA0KPiA+IFNp
bWlsYXIgaXNzdWUgd2l0aCBaeW5xTVAgYm9hcmQgcmVsYXRlZCB0byB0aGF0IHBhdGNoOg0KPiA+
IA0KPiA+IHhpbGlueC1wc2d0ciBmZDQwMDAwMC5waHk6IGxhbmUgMyAodHlwZSAxLCBwcm90b2Nv
bCAzKTogUExMIGxvY2sgdGltZW91dA0KPiA+IHBoeSBwaHktZmQ0MDAwMDAucGh5LjM6IHBoeSBw
b3dlcm9uIGZhaWxlZCAtLT4gLTExMA0KPiA+IGR3YzMgZmUzMDAwMDAudXNiOiBlcnJvciAtRVRJ
TUVET1VUOiBmYWlsZWQgdG8gaW5pdGlhbGl6ZSBjb3JlDQo+ID4gDQo+ID4gV2l0aCBDT05GSUdf
VVNCX0RXQzNfRFVBTF9ST0xFIGFuZCBkcl9tb2RlID0gImhvc3QiOw0KPiA+IA0KPiA+IEl0IG1h
eSBub3QgYmUgdGhlIGNvcnJlY3QgZml4Lg0KPiANCj4gSnVzdCBmaWd1cmVkIG91dCB0aGVyZSB3
YXMgYSBwYXRjaCAoMzU3MTkxMDM2ODg5IHVzYjogZHdjMzogU29mdCByZXNldCBwaHkgb24NCj4g
cHJvYmUgZm9yIGhvc3QpIGZyb20gVGhpbmggYWltZWQgdG8gZml4IGl0IGJ1dCB0aGUgaXNzdWUg
aXMgc3RpbGwgaGVyZSBvbg0KPiBaeW5xTVAuDQo+IA0KDQpIb3cgbWFueSBwb3J0cyBkbyB5b3Ug
dXNlPyBDYW4geW91IHRyeSB0aGlzOg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KaW5kZXggMDMyOGM4NmVmODA2Li45OTIx
YzI3Mzc4MjkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KKysrIGIvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmMNCkBAIC0yOTYsMjMgKzI5NiwyOCBAQCBpbnQgZHdjM19jb3Jl
X3NvZnRfcmVzZXQoc3RydWN0IGR3YzMgKmR3YykNCiAJaWYgKGR3Yy0+ZHJfbW9kZSA9PSBVU0Jf
RFJfTU9ERV9IT1NUKSB7DQogCQl1MzIgdXNiM19wb3J0Ow0KIAkJdTMyIHVzYjJfcG9ydDsNCisJ
CWludCBpOw0KIA0KLQkJdXNiM19wb3J0ID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VT
QjNQSVBFQ1RMKDApKTsNCi0JCXVzYjNfcG9ydCB8PSBEV0MzX0dVU0IzUElQRUNUTF9QSFlTT0ZU
UlNUOw0KLQkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dVU0IzUElQRUNUTCgwKSwgdXNi
M19wb3J0KTsNCisJCWZvciAoaSA9IDA7IGkgPCAxNjsgaSsrKSB7DQorCQkJdXNiM19wb3J0ID0g
ZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VTQjNQSVBFQ1RMKGkpKTsNCisJCQl1c2IzX3Bv
cnQgfD0gRFdDM19HVVNCM1BJUEVDVExfUEhZU09GVFJTVDsNCisJCQlkd2MzX3dyaXRlbChkd2Mt
PnJlZ3MsIERXQzNfR1VTQjNQSVBFQ1RMKGkpLCB1c2IzX3BvcnQpOw0KIA0KLQkJdXNiMl9wb3J0
ID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VTQjJQSFlDRkcoMCkpOw0KLQkJdXNiMl9w
b3J0IHw9IERXQzNfR1VTQjJQSFlDRkdfUEhZU09GVFJTVDsNCi0JCWR3YzNfd3JpdGVsKGR3Yy0+
cmVncywgRFdDM19HVVNCMlBIWUNGRygwKSwgdXNiMl9wb3J0KTsNCisJCQl1c2IyX3BvcnQgPSBk
d2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HVVNCMlBIWUNGRyhpKSk7DQorCQkJdXNiMl9wb3J0
IHw9IERXQzNfR1VTQjJQSFlDRkdfUEhZU09GVFJTVDsNCisJCQlkd2MzX3dyaXRlbChkd2MtPnJl
Z3MsIERXQzNfR1VTQjJQSFlDRkcoaSksIHVzYjJfcG9ydCk7DQorCQl9DQogDQogCQkvKiBTbWFs
bCBkZWxheSBmb3IgcGh5IHJlc2V0IGFzc2VydGlvbiAqLw0KIAkJdXNsZWVwX3JhbmdlKDEwMDAs
IDIwMDApOw0KIA0KLQkJdXNiM19wb3J0ICY9IH5EV0MzX0dVU0IzUElQRUNUTF9QSFlTT0ZUUlNU
Ow0KLQkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dVU0IzUElQRUNUTCgwKSwgdXNiM19w
b3J0KTsNCisJCWZvciAoaSA9IDA7IGkgPCAxNjsgaSsrKSB7DQorCQkJdXNiM19wb3J0ICY9IH5E
V0MzX0dVU0IzUElQRUNUTF9QSFlTT0ZUUlNUOw0KKwkJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywg
RFdDM19HVVNCM1BJUEVDVEwoaSksIHVzYjNfcG9ydCk7DQogDQotCQl1c2IyX3BvcnQgJj0gfkRX
QzNfR1VTQjJQSFlDRkdfUEhZU09GVFJTVDsNCi0JCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdD
M19HVVNCMlBIWUNGRygwKSwgdXNiMl9wb3J0KTsNCisJCQl1c2IyX3BvcnQgJj0gfkRXQzNfR1VT
QjJQSFlDRkdfUEhZU09GVFJTVDsNCisJCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VT
QjJQSFlDRkcoaSksIHVzYjJfcG9ydCk7DQorCQl9DQogDQogCQkvKiBXYWl0IGZvciBjbG9jayBz
eW5jaHJvbml6YXRpb24gKi8NCiAJCW1zbGVlcCg1MCk7DQotLS0NCg0KQlIsDQpUaGluaA==
