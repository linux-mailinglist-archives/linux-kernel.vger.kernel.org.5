Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186EF7EEAD8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 02:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345644AbjKQBzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 20:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345625AbjKQBzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 20:55:52 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2774195;
        Thu, 16 Nov 2023 17:55:49 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH109DM008692;
        Thu, 16 Nov 2023 17:55:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=rS+HEcfN0K+9H6fUyIUIxOsS9AlD6ny+Qt7gcGVxEXw=;
 b=YxY0Gb4iW55b2hUcpfvjCgn+Z2nEonPXQjHJAy2Ptzd4fDptkPQ9El5S8R84pbQVM/Nq
 ykqMMRwsObaLflWA42R943xG5EiKQY2piqjICOKFO4Z3Kxz5AbOREcZCqqQ4xLX58N4u
 u+H+KdzkZhYy9fKZ879LuzG09U4VyZHrmGghL62Zp8HQHwZcSi45yaeseMKCjIx0lwiv
 y0Jo7N2VfyhZQ5hqoByDicFshyN9l5Y6smFggAgDNdgRZu7ULr5DgXVciZ00d6cI5Pby
 jx2lPY8kaqK17MCqOFw428rshzfmHoVhw21rURisQm3c3DJrqw652uIqes/39SXZ0LuV bA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ua9raa0ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 17:55:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1700186133; bh=rS+HEcfN0K+9H6fUyIUIxOsS9AlD6ny+Qt7gcGVxEXw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=gkCVI/NA6DCcuJRqEh+IvhtIFcxpZgisJQyMK5WSyNj0WwktFL2B0v/SV7i4pPrVh
         p/4dbv0Kee+tlEWt1dw/Ma9q00afmIUyIJ01V5h2bfglTVjb0LdMhIH8inJWHQDbYo
         WtXid5lhX9WhFi+8jwDPuQKUVk9LphwphdfFlbBUZah8/p2wmog5w88i4Fy+rPedWa
         uayis0cdc+X44qMm45HKJDFXpv8Wn1DyyIdGMbtYivNknXC222B3bYe7IRD1xmjsyy
         lzxcldIMVa+w9qExNV3wHC24lNqOQAGbX9kFD2DaK+gz8yuJeXgI076hbeoQEOHEwT
         VfFPU8EkzEsFQ==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AB8E4401F2;
        Fri, 17 Nov 2023 01:55:33 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7339DA00A8;
        Fri, 17 Nov 2023 01:55:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Dg+WJ0U3;
        dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3A8684045F;
        Fri, 17 Nov 2023 01:55:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jW2mfvQOZJbLSZMH8a0V0/pycN1fA2sF3wd+PiUDIRZJ74DkKIyUoMnS8vbKK86Ctunth6bVvSf3m2mQm5uUUqxBISDSX+264a0f860ckLfPxXFBL99gyf4txfoSGWHfBFAcwWVHLyPYgd6mb+FixKYh5+X6PQlpgCE3dOwpisAn7tpimzYlyQW1JDri+GCcEUA9f+eQewy3GuMixPI2orkNcAWk04phC3GBs4xkMSOXTnWDw16vLPwECAdH0t5wrBWt3kKE2Em5+L4ifxsK/3WG5bFZ4HXpcKXu85G7j9CJO6P937rL0EinBy+iWwcb5K+P/Vm5m9RiYGO58GMGbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rS+HEcfN0K+9H6fUyIUIxOsS9AlD6ny+Qt7gcGVxEXw=;
 b=HHhcUJRp+N3Skn3f9q1RghZ3nHhNMnhMQHjaG1Vird9Sd6ieNIk3hUHJUd7R/zj5f1gk3ILvBs5v2/gRcLuN/61ZcVxbcrE1Ll1XqV4EwLiWsRW6Q11OFr8hxo+eatlDcuDVglVYvKlOmjW0BjSlr1da/5d9dim4P8Dur8FyVNfe24zBLZCEKoxuImskMPgKtxoqCIL/2pbqVhLUVEXdGpgZTcNJMIjgRQObsbUdstfNoGYVHRVfn7wQhBGUNkkRC6/PCF//TAtKwmvQCJBqvnLxAWkw05efCc19sJYeApiEU7FS972j2cXoMTLvQklnwPvBLHWGJspu9lyAq8shNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS+HEcfN0K+9H6fUyIUIxOsS9AlD6ny+Qt7gcGVxEXw=;
 b=Dg+WJ0U3cD/KSM94Go8xRwRIjTOz0uHIVpw03ScG73iwVhMZmYlqhHwQu+H9lNFi4XniuPS2nxZKs4ZNS+qAUXiNBMNZknwwwcEFN6y5vKEC4Bmr/KrQf9l+CEa+IFBmMQ0MHJ8uXa5ZOHye6m8NQ/4lKKZXN5Xfwjzn1d5g0ew=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Fri, 17 Nov
 2023 01:55:30 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e%5]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 01:55:30 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     =?utf-8?B?S8O2cnkgTWFpbmNlbnQ=?= <kory.maincent@bootlin.com>
CC:     Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lu jicong <jiconglu58@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] usb: dwc3: don't reset device side if dwc3 was configured
 as host-only
Thread-Topic: [PATCH] usb: dwc3: don't reset device side if dwc3 was
 configured as host-only
Thread-Index: AQHaGKveCMbrfcJ+4k2eyt7FIy9Uo7B9K1KAgACReACAAAQjgA==
Date:   Fri, 17 Nov 2023 01:55:30 +0000
Message-ID: <20231117015527.jqoh6i3n4ywg7qui@synopsys.com>
References: <20231116174206.1a823aa3@kmaincent-XPS-13-7390>
 <20231116175959.71f5d060@kmaincent-XPS-13-7390>
 <20231117014038.kbcfnpiefferqomk@synopsys.com>
In-Reply-To: <20231117014038.kbcfnpiefferqomk@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH3PR12MB9316:EE_
x-ms-office365-filtering-correlation-id: 2e690677-36a1-4bde-2085-08dbe7104754
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: emBFHraoUSeHkG6fV1KcJ4NN1rIDq82jHwjzhjaYbtXnJZB96h98+3V0Uva0cxqaDlN7yLsCkjIhcOvxersSy4eeFUbNoHFuCApFVab5Ie083N4gkQFHbqXOr+hO7l/dvTlLZPcHhCkIoAL3VkF5jCqYO1J3yXSHF8wscZK+BGhZ7AD/Ehbc8bxmnBBDztaDbXY1mGMcdyVDWW0hc5LnN8XRydG54RKerCkUMm+8s0cQSwb/3I+4wJ/xCYz+WRa2i/iwifAeDDGP4nW7F4rmzJ3sHX+x0hmHrAkdQAO1yx+f4ppAZb5Mc35aHgIMcncIbzjj5bQnq/hOi+ze2hkFH1kUwDfvtHxeLtwF+cdGAWkB+sKP/25ED4vkkla49XM2px1x1CR/I1Zu/dAs8gOolcVlRLP38rAmrdb4lXnO6T/B3Hlbpk9CrrKEguvF786CTlDQk/rcz46SaHtO9R2CxsYHw0gFem1R/Or7p6wgi8CZJUftFnO0zuKS66u0bl84iuwC/sKK4475PivG1k9Wg31cxbLrYCNUdsK4ThAcBKi7Qr9uU0iPeYej7I06tAyWbgOUn98AFwOjaBe8snvefOunWmAjhCe35DH5S0m8Hq45ZzJ8KaLLLvCfk9INNPuO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(478600001)(2906002)(6486002)(71200400001)(6506007)(6512007)(2616005)(86362001)(6916009)(5660300002)(316002)(64756008)(4326008)(76116006)(66556008)(8936002)(66446008)(8676002)(66946007)(54906003)(38100700002)(38070700009)(83380400001)(66476007)(41300700001)(1076003)(26005)(122000001)(36756003)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a043NVpUYTgyeit4clc2Sm9vdVB5VzlrTnVBU2RKTzNZY1dxMzVjQkZNV015?=
 =?utf-8?B?eUpIWEhIMnZrNG1DVDJObGVBSUxoTkU5cVdUeGg5bU1jUWppWDJMenhWN2E1?=
 =?utf-8?B?UFJyZXY2VEtQcVR2Q3lNNGtFR0JmK2NJTlFCUm1uTnRqdnVUZjA2V0JpYlYw?=
 =?utf-8?B?ZWFwaUxrcUt5MXlMZEo2R2lQeFFqUGdFSGRNTjRwcXNsVkpSdndja2t5TnNC?=
 =?utf-8?B?SDJnbVlVZHZSMlZaUW1xVDhldGtVTTd2WmNiVXZta3pBYTR6RCs5bjZubXZp?=
 =?utf-8?B?clJJcFA1ZlhTYUlDOVlsSndnSW5qeWVYV2NrODhMMGgzMmVhZFlaMU9xY1hZ?=
 =?utf-8?B?aGtKNGIrU0x6NVhxL2Q4MVQ0Zmg3UGg0S3VhMi95QkpnNVZuMUJTMW1YYXIv?=
 =?utf-8?B?ZEpJa3Brd3N5a1piYlpKYi9FdmRNajRuSEw3NEptb1ZnNUVlY1JlblNWMEhy?=
 =?utf-8?B?NFhuNmZVMmRzc2ZBMUJoM29DQ1dBQjdQRWVBM2piRTAyZ2ZaaHhnYWVGWWJr?=
 =?utf-8?B?VllIcFpSUW03ZURIbk5IT3k4cklhSjA2aUxoTm44ZGlrY2lwU05XMzhoelc5?=
 =?utf-8?B?eGw3enEvUE5QWVZXOUxDT3JrV2FNUXk0RUJGSmQrYVRZRnF6cXM5MzRSekZT?=
 =?utf-8?B?ajZyTjRSeU9kNjVSQ3g3aXhNMGJoRzZKSG1SR2ZqK2RmTXduUkU0YmhWcTVK?=
 =?utf-8?B?dGxvbU82aEZJUFNnUW9YaDhCQUNsL1FhWnhmU2xnMlVyNVhnczNqUjhvcG02?=
 =?utf-8?B?ZE9TdWEvOUJ5Q0Y0UXRCUzY0QlFKVGVITWFKZjlTTWJFVGtDcFRMak9jajRI?=
 =?utf-8?B?U3pXVHUxelVPdEVyc2hqSms3VWg4WkhlK0MyRFJyTVUxTmVaODhUMGd2eXJ0?=
 =?utf-8?B?NUdMTktSeGtWR011Q2RnRXpldHBYclZtNTNBUHBPOSsvOVcyZzBvdmNJY1hr?=
 =?utf-8?B?V0JMMEZ3aFd1bUNVTUsvQ2VJM1pDS2dXOGZ0MmtaNHA4a2ltcWhSQUtvK1lJ?=
 =?utf-8?B?eW1pV3p4M3R5MzFsKzJHVHQ1eC82Tm1nNkVLNGZtZnU1eGMwNnVuaUY5b09J?=
 =?utf-8?B?VTdDa1YvdktuZllxd2NYc2ZheWVqZmZJM3BiU1FhY00rSldFTHl3SWN5RTBN?=
 =?utf-8?B?cjZTb1RUNkl2S1ZNRHNvUkxLTEhqWktJcC9hZXhhVmYzZmdjZEV6Y0oxK2JZ?=
 =?utf-8?B?ZEMvUTlhRVZEQkF3VG5sNUVVRVNzZWRaVHNhRUMxSkRyc2h2KzdqN2lXbG85?=
 =?utf-8?B?ZFh5VEJLdmxyakFhc1VDWDVYZDRsd2x5aXZMbHc1eTU2WHVhT0pCMGpFRTBF?=
 =?utf-8?B?R0xpUGdVUnFabDBBTXNJY1hSL3B6YUNLTk11N2o1ZkN6eVkyaEFDeklyN2lP?=
 =?utf-8?B?WkZEaWR3RTlrSXdUSG5NeGd2RkxGbHFRV3FPS3BkQUpseDFQb2xITVlxMzVT?=
 =?utf-8?B?MmtRSGt4clA4YXFNTHhEL0VVc1k3cVBVVjU3TmpjWnNaSHlrZFJsdVdJT09J?=
 =?utf-8?B?YnZiWjVFSmpMMnp0cWxqRSs5OFdOdndudWY1TVhydVpNWVJTTXZJb3pOMkRM?=
 =?utf-8?B?cHB2Tk1TOC8xQ0c2bnlvenA0OStsNUxuNHpseEFWMTlZSkp6Nm9tZit3aXpB?=
 =?utf-8?B?U1pab2tRNDlnNUVYdHNUS1IrZ0lkMmlnbmRYcjZwamVtR1VFTzlmN29vTW0x?=
 =?utf-8?B?c0FHbDFLYTZjTDRRL0U4LzFPclRnd3pSV0NYWXY4OGpGZlpTR2VUblpnZGlY?=
 =?utf-8?B?V2gxcnhyVDNZcUF5akVodmRKR2lxYkQrWnBoMnNVVzlkd0xiL3NLaEIrRFR4?=
 =?utf-8?B?eXJoZ0FYdmUvVmVhVExlV0pNN3hoQ1d1RGlOWlpuY2l1cERSNGVUaDB2bjhr?=
 =?utf-8?B?THRBZTBjRXNrSCt3MEJOZnlqaU9ndmpiS1N2UUhxUnY4YXBLcGJCZjhqMmRT?=
 =?utf-8?B?ZFNsbDZUeEtCMGpROUozMDRHYmZ1dklEaURTOFFwRUsxYmlQbjVoS2tPRVd3?=
 =?utf-8?B?Ti9KRklDd1ZFN0ZYSmZOS2orNHY2eWh6S2F2K0I4eUpwZVpLdXF3bm50WTVY?=
 =?utf-8?B?Q21md2JyOS9xcVpjdXF1UTJQMkp2a1FFaEpTVmN5OFphMjFJQzJITnh5cU5w?=
 =?utf-8?Q?7HXzTEkJN6NJGGmsCxGWLJ/GO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B1FDA510B1DFE47ADF8AB7B8CE5AC5D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MEFlM1ZsajRkTkc2RzJpZWI2TkYrWGR4Q3dUZ1RycG1nMm9UaVlhZmlEaWVI?=
 =?utf-8?B?OUpoMkVsODFBbU5CTnYwU1ZoTXRkOGp2bWd1RU9MNjFHdkowVjZZNkk1c2NS?=
 =?utf-8?B?OUdGNVYvOHRkQ1ZXM242VmZhN1l5QWpBQktuRXEzN0puU3lPSjlaRStjOVZ3?=
 =?utf-8?B?dHNLTCtFd243UG9LRkc1ZmVXR1NCMm00eFBTNkFBZjNLaXRMVDJWVmFoTEJr?=
 =?utf-8?B?M3BSTVdlcHQ4MzQ2VlpHcXdvaXlBS0FqY1RmQytrcmJDOU41NncyQ2RQSTJz?=
 =?utf-8?B?bmlUUVFXbGtscUhpV29tTXpnZ0lVeE1ER0IxVkRLcnN1QktITnUvVXVuRjUw?=
 =?utf-8?B?bVZUWmZ2bHZIRXZyd0lxZzlzQmlORDRZMlliVTdYdzBkSWY0RU5zbGRXdzVB?=
 =?utf-8?B?ZDI0cnVzMFJRT3RLckFwV1ZJT0tMM1BSWStHOGcrZ2hCVW8yYkZwWEdNUzJ1?=
 =?utf-8?B?YnVCNks4MHBMV0VLL2F5TEhTUThsL0EwbC9zdUplbmNJeU5BcXNlM1NxMTRP?=
 =?utf-8?B?em1CTDM5UzE5aElVU3MvQmxNazV2dy9tYXFhOXBwSGhpeXhiQ1BpcDhON2Ni?=
 =?utf-8?B?SXlaek1Ia2w3amkyai9hMVcyWHJ6VVA5V251QkQ2V1N2TVliQzFFVnR4YXhh?=
 =?utf-8?B?ODVEN2NwZFRmeVM1Tk5yRkJuRTJ2UCtPdFJHUlhnbCtMcXhicm9lSWhmL21m?=
 =?utf-8?B?bXZ5ZW5FNXRtUEx3b3F1WS9Yc3VzUGdmakpLcVdoRGZka2JrWGlWWmZDM1d1?=
 =?utf-8?B?K2tsYWdnTGh0RjNMTUdQWFNDSDhtOTZwN05vdE9JUGRGWDc4bG9NdGFOaGo5?=
 =?utf-8?B?N1J5UHVNQll4VUIzcjl5S2NJeElPb0x3YU5KQVhiUzRiMjdHR2trYjFlTjBR?=
 =?utf-8?B?c3h5RUhIb1ovMkMwWVdYTGZQcHhtYlpQTUEzNTNCS0wrckE5eFlDcm5LVmg5?=
 =?utf-8?B?ZHNCNWFhb3NhWndQSU13eWw3YjhGWGppeWxsYWJsMEJqemZ4OTE2UGk5NmZL?=
 =?utf-8?B?N0xkRkFrR3NDbzIyYUVNMzlESVl2b1ZTNkJrcGE5Mi9MZWNsd201RW9FbW53?=
 =?utf-8?B?ZytWWjFmT244cm9LSGU1Y1pjMjYyWVVIZFJLT1BZMnkxTE1JZnl2dHJsQWg4?=
 =?utf-8?B?VmZDN0ljc0FnQVcyK3lmdVAydXE1M0w0Wks2QnZ4THJXZ2NYLzFtSkpaY0lQ?=
 =?utf-8?B?WXQyWXJoZXd0RVZuRDJaeENuUmZpbWt0K21FUWpBMm5yUUZ3TVRMNmJRTHJv?=
 =?utf-8?Q?YPveQ7p6lOxwNO3?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e690677-36a1-4bde-2085-08dbe7104754
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 01:55:30.5139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V3xtkdHv82WXKnR+BTaYkSskjeCDukXujJVz4wCkSKXcEFVI+4sUEtE114f+JMv0yxPDsZ56iPvwf+K2ZpCbuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316
X-Proofpoint-ORIG-GUID: k07FZkoFv0pEb1LdJeoLh_WyhiaqXWHI
X-Proofpoint-GUID: k07FZkoFv0pEb1LdJeoLh_WyhiaqXWHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 mlxlogscore=768 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170012
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

SGksDQoNClNvcnJ5LCBlbWFpbCBjbGllbnQgaXNzdWUgd2l0aCB5b3VyIGVtYWlsLiBBdHRlbXB0
IHRvIHJlc2VuZDoNCg0KT24gRnJpLCBOb3YgMTcsIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToN
Cj4gSGksDQo+IA0KPiBPbiBUaHUsIE5vdiAxNiwgMjAyMywgS8O2cnkgTWFpbmNlbnQgd3JvdGU6
DQo+ID4gT24gVGh1LCAxNiBOb3YgMjAyMyAxNzo0MjowNiArMDEwMA0KPiA+IEvDtnJ5IE1haW5j
ZW50IDxrb3J5Lm1haW5jZW50QGJvb3RsaW4uY29tPiB3cm90ZToNCj4gPiANCj4gPiA+IEhlbGxv
LA0KPiA+ID4gDQo+ID4gPiBTaW1pbGFyIGlzc3VlIHdpdGggWnlucU1QIGJvYXJkIHJlbGF0ZWQg
dG8gdGhhdCBwYXRjaDoNCj4gPiA+IA0KPiA+ID4geGlsaW54LXBzZ3RyIGZkNDAwMDAwLnBoeTog
bGFuZSAzICh0eXBlIDEsIHByb3RvY29sIDMpOiBQTEwgbG9jayB0aW1lb3V0DQo+ID4gPiBwaHkg
cGh5LWZkNDAwMDAwLnBoeS4zOiBwaHkgcG93ZXJvbiBmYWlsZWQgLS0+IC0xMTANCj4gPiA+IGR3
YzMgZmUzMDAwMDAudXNiOiBlcnJvciAtRVRJTUVET1VUOiBmYWlsZWQgdG8gaW5pdGlhbGl6ZSBj
b3JlDQo+ID4gPiANCj4gPiA+IFdpdGggQ09ORklHX1VTQl9EV0MzX0RVQUxfUk9MRSBhbmQgZHJf
bW9kZSA9ICJob3N0IjsNCj4gPiA+IA0KPiA+ID4gSXQgbWF5IG5vdCBiZSB0aGUgY29ycmVjdCBm
aXguDQo+ID4gDQo+ID4gSnVzdCBmaWd1cmVkIG91dCB0aGVyZSB3YXMgYSBwYXRjaCAoMzU3MTkx
MDM2ODg5IHVzYjogZHdjMzogU29mdCByZXNldCBwaHkgb24NCj4gPiBwcm9iZSBmb3IgaG9zdCkg
ZnJvbSBUaGluaCBhaW1lZCB0byBmaXggaXQgYnV0IHRoZSBpc3N1ZSBpcyBzdGlsbCBoZXJlIG9u
DQo+ID4gWnlucU1QLg0KPiA+IA0KPiANCj4gSG93IG1hbnkgcG9ydHMgZG8geW91IHVzZT8gQ2Fu
IHlvdSB0cnkgdGhpczoNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
YyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDAzMjhjODZlZjgwNi4uOTkyMWMy
NzM3ODI5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMjk2LDIzICsyOTYsMjggQEAgaW50IGR3YzNf
Y29yZV9zb2Z0X3Jlc2V0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJaWYgKGR3Yy0+ZHJfbW9kZSA9
PSBVU0JfRFJfTU9ERV9IT1NUKSB7DQo+ICAJCXUzMiB1c2IzX3BvcnQ7DQo+ICAJCXUzMiB1c2Iy
X3BvcnQ7DQo+ICsJCWludCBpOw0KPiAgDQo+IC0JCXVzYjNfcG9ydCA9IGR3YzNfcmVhZGwoZHdj
LT5yZWdzLCBEV0MzX0dVU0IzUElQRUNUTCgwKSk7DQo+IC0JCXVzYjNfcG9ydCB8PSBEV0MzX0dV
U0IzUElQRUNUTF9QSFlTT0ZUUlNUOw0KPiAtCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNf
R1VTQjNQSVBFQ1RMKDApLCB1c2IzX3BvcnQpOw0KPiArCQlmb3IgKGkgPSAwOyBpIDwgMTY7IGkr
Kykgew0KPiArCQkJdXNiM19wb3J0ID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VTQjNQ
SVBFQ1RMKGkpKTsNCj4gKwkJCXVzYjNfcG9ydCB8PSBEV0MzX0dVU0IzUElQRUNUTF9QSFlTT0ZU
UlNUOw0KPiArCQkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dVU0IzUElQRUNUTChpKSwg
dXNiM19wb3J0KTsNCj4gIA0KPiAtCQl1c2IyX3BvcnQgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywg
RFdDM19HVVNCMlBIWUNGRygwKSk7DQo+IC0JCXVzYjJfcG9ydCB8PSBEV0MzX0dVU0IyUEhZQ0ZH
X1BIWVNPRlRSU1Q7DQo+IC0JCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HVVNCMlBIWUNG
RygwKSwgdXNiMl9wb3J0KTsNCj4gKwkJCXVzYjJfcG9ydCA9IGR3YzNfcmVhZGwoZHdjLT5yZWdz
LCBEV0MzX0dVU0IyUEhZQ0ZHKGkpKTsNCj4gKwkJCXVzYjJfcG9ydCB8PSBEV0MzX0dVU0IyUEhZ
Q0ZHX1BIWVNPRlRSU1Q7DQo+ICsJCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VTQjJQ
SFlDRkcoaSksIHVzYjJfcG9ydCk7DQo+ICsJCX0NCj4gIA0KPiAgCQkvKiBTbWFsbCBkZWxheSBm
b3IgcGh5IHJlc2V0IGFzc2VydGlvbiAqLw0KPiAgCQl1c2xlZXBfcmFuZ2UoMTAwMCwgMjAwMCk7
DQo+ICANCj4gLQkJdXNiM19wb3J0ICY9IH5EV0MzX0dVU0IzUElQRUNUTF9QSFlTT0ZUUlNUOw0K
PiAtCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VTQjNQSVBFQ1RMKDApLCB1c2IzX3Bv
cnQpOw0KPiArCQlmb3IgKGkgPSAwOyBpIDwgMTY7IGkrKykgew0KPiArCQkJdXNiM19wb3J0ICY9
IH5EV0MzX0dVU0IzUElQRUNUTF9QSFlTT0ZUUlNUOw0KPiArCQkJZHdjM193cml0ZWwoZHdjLT5y
ZWdzLCBEV0MzX0dVU0IzUElQRUNUTChpKSwgdXNiM19wb3J0KTsNCj4gIA0KPiAtCQl1c2IyX3Bv
cnQgJj0gfkRXQzNfR1VTQjJQSFlDRkdfUEhZU09GVFJTVDsNCj4gLQkJZHdjM193cml0ZWwoZHdj
LT5yZWdzLCBEV0MzX0dVU0IyUEhZQ0ZHKDApLCB1c2IyX3BvcnQpOw0KPiArCQkJdXNiMl9wb3J0
ICY9IH5EV0MzX0dVU0IyUEhZQ0ZHX1BIWVNPRlRSU1Q7DQo+ICsJCQlkd2MzX3dyaXRlbChkd2Mt
PnJlZ3MsIERXQzNfR1VTQjJQSFlDRkcoaSksIHVzYjJfcG9ydCk7DQo+ICsJCX0NCj4gIA0KPiAg
CQkvKiBXYWl0IGZvciBjbG9jayBzeW5jaHJvbml6YXRpb24gKi8NCj4gIAkJbXNsZWVwKDUwKTsN
Cj4gLS0t
