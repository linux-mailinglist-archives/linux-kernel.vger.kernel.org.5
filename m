Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A564579322A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjIEWxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbjIEWxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:53:46 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DCC11F;
        Tue,  5 Sep 2023 15:53:43 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385IP8IN013902;
        Tue, 5 Sep 2023 15:53:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=KuHdiX0QEbmW1ndEEvNzttJW/OaFfDoo/LIf7tIdOoY=;
 b=eVlLomzH8JRa16QuRA+actzirzxlI2kVi4NsxeA1wECWtwm+OG78xGTp99PvGBrtHySg
 AiMp0AcDDmuORjMfe/sGuUGId49aH7MmYkCOLnn4F7qZZXq4aFfcdDyMkci/6yjarvBO
 tvPLxON922eR5AZX0YZtG5t0TaQdOnkgMZo//NSi1WmJol9ydac7nto4Fu5ZF9kBJ8FW
 pKyGse+xo2LF9InhjNlTch96mZH9Mjzi6Whm49Z0B4DJxq/YTZGyfvq7+M7qiuRuQesV
 XE0W76nzLD3TvgBptu2OI5oWStqDWFhBylj6Ys5y8JaoltAFX5X+7kZFcTiA/znZeBfP Zw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3sv4a5de3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 15:53:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1693954402; bh=KuHdiX0QEbmW1ndEEvNzttJW/OaFfDoo/LIf7tIdOoY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=eKlmpOZuGv4Sgt4WQzyPNPyUM49VWDj2RDotbgLZouNPSGz+8ye3g4OqnadPG8PFV
         ta4ZyC4oTgRo8AM8XlfT5EnqXXGYPktj+4ipTt2Bf9OiNbfAb6e9BzV1hohhgLxun4
         d+kXw1YPpRhBWjmqEhpjfDmIZJwXBHlihCgrQakFkvQHXT3KdC6OiNUK0EQPP+0TIf
         hlKDTbSKRie+tFj9/arEioXDSmXhdjFiFw+GsejoqLz/BgTjyb9yYG8+DkpAaAtP35
         6gWkhGU414qa6m5MDf8HZceJAYIu5xt2Nas9H3TrP3naEz7IL0dIJlZtPCPZuKAs7h
         MLekwCK+j1Dig==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8F72640121;
        Tue,  5 Sep 2023 22:53:21 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8FBDEA0060;
        Tue,  5 Sep 2023 22:53:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=EzPDNfpu;
        dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7740F40811;
        Tue,  5 Sep 2023 22:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtOS2rzNVTVIXqgzuCQ7fv3+XigiwdAI/yfZJG1XMsSZOoZF2dLjYmGOHReJZeFjA8zxWJOCDCzv8m9g1uOVed+ZHiVWZNJf2wOExCFya9UQL+BA0BT40CRgZvCjAEkvlxc1kbgok+jRcEQgOCi29/H+xBFFEB/Fburol9lu04uGbnhNh5sRTJGNEc2Mn5idhHgPQ1szDVx53ZJ2hOuebLxRu1dhhJXOXvOgWmFFkQfXUK5Wmxi8bOuZnumIS4YmlILPdpOiG18HxhwVhWUlZ53wLzDqTDgcgZ8P0xAjFCLYC2p0XMtVblRIGYmHd0sOCR8gKAZUQdAeB27Fkj6Epg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuHdiX0QEbmW1ndEEvNzttJW/OaFfDoo/LIf7tIdOoY=;
 b=lJzXEokf2kHD6Bl708k1egrBF0Y1VYZzR+oFNFHmZzOTKf9xJp1szT2j1FCQovRmRI55wi8Ga6qz90boZ0SHVqvbMTV0sP6UH70RX91nFzTQ0e6TZgpu85pznBb2U1s0g4mTLnZ7AzGPnEI7yQ0d1qWghZnmv8PZpAjFdeMb8wth+bCuMs4vI04QP5yO/fnvGWQ4sgQVjd5oja/dNqTwJU4939XZoPaqGwlouBsgE15LPAtsxkMWLLXocT1EUJBVHIedGG4yoWJWum3YF8ZcTZBTlHFSNLFlTFaf4BGMiMlgu7rQyENXhkSY/vRUmXqjInnasL+6aDYDg6j+rM0Nkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuHdiX0QEbmW1ndEEvNzttJW/OaFfDoo/LIf7tIdOoY=;
 b=EzPDNfpuPv0wGDhR0q09FDxhd/1nQWvSvCxKVdjdwodTvPnVANrPdxiJrTStWQuI0P6OYt6qc6vhb18SRPWMCPPLapLpWNWFoYnQdWEE+O2AuSpe58EetaMaGiFh8F+B2THLDIY9YBlRdV5pGH9tw98I78aKuNrqHRkzvVVp9yQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 22:53:16 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 22:53:16 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Thread-Topic: dwc3: unusual handling of setup requests with wLength == 0
Thread-Index: AQHZ0WkxsEX2ZGMtZEmcF1gvP2WuTK/vPhuAgAAY0oCAAAlogIAACMGAgAEOQgCAADc1AIAAELKAgAKA6gCAA+wcgIAA2rMAgAAtNoCAABaOgIAAMuwAgABCyQCAAxO2AIAAHuQAgAYtxwCAAN5PAIAAx/iAgADZEoCAAKLNAIABECkAgAA8jACAAS4AAIAFNu4A
Date:   Tue, 5 Sep 2023 22:53:15 +0000
Message-ID: <20230905225258.llz3akay2s2hcsfq@synopsys.com>
References: <20230826012024.mboftu3wk7fsrslp@synopsys.com>
 <ba06679f-93d2-4cb4-9218-9e288065bdfb@rowland.harvard.edu>
 <20230830013222.ukw5dtburjnrrjko@synopsys.com>
 <61cf24db-9dbb-4bf3-aafe-d515fc37cca8@rowland.harvard.edu>
 <20230831024345.lwd6ehcbjdlczjpa@synopsys.com>
 <1a66bb8f-9680-424a-a051-27353b8a4130@rowland.harvard.edu>
 <20230901012322.rwpj32rx36xjtlb6@synopsys.com>
 <4e67f96d-250a-4ee1-9f2c-ad321fa50fdc@rowland.harvard.edu>
 <20230901211410.u444xy5rou6ibg2d@synopsys.com>
 <0b8abec0-c422-45f8-a8d6-998f33080373@rowland.harvard.edu>
In-Reply-To: <0b8abec0-c422-45f8-a8d6-998f33080373@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ0PR12MB6687:EE_
x-ms-office365-filtering-correlation-id: cfd2cb0f-21be-4db8-6d88-08dbae62e415
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5DSzPq2f4vkAIaseXvsf/eCm0Np5rthQNM2+S4ityZuWWepxGJz8DtGKVLqE9a6zwCAiaQvYOkyU4mB9l8G08O9D3F6xa+pl+qDVr0J/MCbaSStMRHPvd1AKDHRAMxafkRcNq9SKpdbuvK6nMvRRIWQ/i3nFKy2aUo0Cz+4f4heEENp0yUfgLYqVbb85PEtHfL/MxWROT1QGGdmKt8Y2VxuR/qmdr+rqO2sjXWbxL+2LMQJiy2MwVCyd6UJuV8BLFEraQl/TcxTRyPUxzlJo2waHQykEzzJVJoc7ZJwspV6WrCnGakNx5jvrxOyvrB0p26JkfFtTU0JZc4xF/0WfgPRe+GPmOCTMzRlruX9kDi6GyZLnkafPi9r83V9vu7zA1z1Yuub1wz6EET0FRqW4lXl6p4kFeIsWuzFeJSU6rv/KbkkQrd79D9R/9UHrhA978wL/VG3U+tbpSLyzzuBIK1qL55s/z4Ze9ary3SrGm3fvijz7JbtejlO9iOdzzqLSD2vQWBEIMSjEoz6oTqhyxL78VgZH2EcxoVK0BxWmGkY6cmFys61PizwZ4nvujT3o6OlDo4A+M0PbbeUAHHVxFRiyuR11pQN/QvdlUIBaKgzX9jOIxFNdDKl4TMWIXqjl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199024)(1800799009)(186009)(478600001)(6512007)(38070700005)(38100700002)(36756003)(122000001)(316002)(6916009)(1076003)(54906003)(64756008)(66446008)(66946007)(66556008)(76116006)(66476007)(41300700001)(6486002)(6506007)(2616005)(26005)(83380400001)(71200400001)(5660300002)(4326008)(8676002)(8936002)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUljUk5vMDY3WnRRcVBuSG96K1pQdGMwNFBkNHNCbFROSk96ZWdYTjNuWmRK?=
 =?utf-8?B?WG1PR1pyNHp0aGJwa3JEcG4wWW5XQ2xhZTdWZXVRayt6elgxdzJ5dDNwMHBZ?=
 =?utf-8?B?MDh1VVpkQUh4SSsvUUpDL1ZlbjlJaFA5SE1RYkh6V3BrcXRtcVhTUkozUTFh?=
 =?utf-8?B?UTJ3eURXV242a29xUURGQjVGUC9HQ0ZlSCtZTGh3Z21CVXNaZlJsVGVyS1lW?=
 =?utf-8?B?c0ZabXlKVVhTZDRhbjNvSEhjL0xQVHdIUTE2QTRQK0ZPeUVZeHpDVnIzazJT?=
 =?utf-8?B?ZUpBcG5pMHo0K0xRaXp3QzhvUmp6V096MjZjVDROM3RsVjNBVis0bTFvU2Zy?=
 =?utf-8?B?emVJQmpjT0MvRndxL0g0Snc0VSt6WjhObDBTb0FMcmFLTy94S2h6UHN5OEEv?=
 =?utf-8?B?RTFnYnpkaTIxMHFwbStuczZadVBmbG9aV2ZJbTU5RHZMbE1tNTRnaTdGQmdC?=
 =?utf-8?B?UDdFY0dEaWx2MDdhMUM4M1hXQ1NqNDZTWnlCdlVTd2l3OW1aWG14NDJtVGRz?=
 =?utf-8?B?RmVUb3o2bnhEVXBnc1RiUEpYRVlRLzFHb3ZGc2k1em94eUJqYjhoUGFDZ0Jw?=
 =?utf-8?B?VU9BRkFqM2VyMHRGYWI0dkIzM3lPZnNhamJueXdnVDhiSU9BTFJUYmp3YWpV?=
 =?utf-8?B?K2JobGV2ZG13SEs5bnJLTndMMWExTEkxSUpsbVgwZTcyYTlCdnhxc2F2Yldo?=
 =?utf-8?B?RFZTRnBWS1B1UjhlQVViWEozY1JiM2VEdlNBM0FXczR5NTRRVkxRRHZvb0pJ?=
 =?utf-8?B?REdOTzRwc0hzcWVaUjNTNGF3M0FHdDZoeFBYUmdVRnBmajJ5YlhHc2VlREVs?=
 =?utf-8?B?SUVrNjNEVTlQOWkybjU0YnNveURLb05LV21BWFNac0dlRkFzU21tY1o1VEpj?=
 =?utf-8?B?QWJOcGlwRk1GSTlCNHBKUzZQb2ZEUVhzOEhqeEhqbmRDbkYzTDAzY3lKMlhS?=
 =?utf-8?B?UjhCOXFZVTNVYmh0eGVIcnVYOG9Zb3ZhcmwrZkNXNVlGTFVudisxeWZCVldm?=
 =?utf-8?B?dWJxdmlVa1dKVzErTzlmKzdVeWdWbVlJNGovZjBZd1JtTVFqY3ppSVZ5Ty9u?=
 =?utf-8?B?NFBaREEyWjVySFlUdVd3MmRHbEtzZGc4Rk1qdzEwby9CRkZGa2ZmcU1zaVJD?=
 =?utf-8?B?RGI3NkQ5TkdzTU55N0ZKUitqd0lORk5TV0JNSGgwbGtrRWZSVFdBbllDZUhW?=
 =?utf-8?B?NEtWUVM3VnhwNE1CYnVoTEpEUm5oVEdsQXoyTDhlMmtpaStVdFhiZjRWbTNn?=
 =?utf-8?B?QklSeTU5Mk5nYjhlSitCdDc2SmhhU29TSmoxeVU2QzNTemw2OTdBR2JZZXNL?=
 =?utf-8?B?MEtrZUIrbmZQdzg1UkMxeDFYY05XL0FUS3dlUUJZZ0RnazNIL3NwaW8xaW8r?=
 =?utf-8?B?M21xVzBXRFpRQmVaTFFIbTFpSUxMSndOYW1Kam5WYlhLcHl0UzFSRDE2OTJP?=
 =?utf-8?B?RUR2MDlXOEYraWhWdHpYOXZma0NTbVJhMDl2V0dGMXVzRTBqVkthQk5uWlpw?=
 =?utf-8?B?Vnl5dFdtbkpFR0NtNUJ0UmZsNVp2WndCMUtFQjUwa1V4S1pGci9KaFBVSEYy?=
 =?utf-8?B?VFprZ25wU2FKbG9uSjhTQW5zeTJMcUVCSHhTc3h3VmwrZjVTQng0L2I2TU5V?=
 =?utf-8?B?SzF4YnhFQzgrSUd4VlhCV0VLUU1TZG5KaHZyNCsrMlp5dElaYWZCZnBKeGJ0?=
 =?utf-8?B?dzdqdGFER2J0K2NPdVlFVEdOZ2htclVoVlM5M2ZyL2dXMFRXNzk2Rk9nV1J4?=
 =?utf-8?B?ZFpxNFVPNGdlZFRqUWJEK1krajdTSDYyY2gwSXEvdVhTRFpWaTM0d3dYc09I?=
 =?utf-8?B?TTJOMG5Vekk3UDk3bWJ4NzNHdDM2bXI1c2VXZ1NQdWRQaGNWUUdxK2Y3a0VI?=
 =?utf-8?B?R1lwUzhwWmRvQk8vTDl5QXViVWVwQ3lyV2J1cE9uK2MzMFVkaG9sWkxoY2ow?=
 =?utf-8?B?MVJWUnZrVjZHeGkvazRDU3JKNnVjUU9kZm9Pa1RiSndNTnVPU1I2ZU93Zyta?=
 =?utf-8?B?YnR1WnRpR3R5TWFaTUxwZXhtZ0ZrVHJMdWtPelFZSjBYb3pyME5jaXFxMURD?=
 =?utf-8?B?a3FzckhPL0dsZnFHeFJlL2ZUN1UwcjBLWnJFSEt4dTZYaDMyaWQ1NXNOSVVF?=
 =?utf-8?Q?gfqWmOijiFHLs2Sqts+qrjaFK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C66407AAE03D4447B13ABBD2DC424E3E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a2xGUVQrTGJ0elNreVJMY3N0QmFZYWw0MzRCbS9UQkd4VVhEQXBsbjdGOXRI?=
 =?utf-8?B?WWJUTTk2WURaR2w0dW5IbGxhNjU4QkEycENjYTRkeGZHbEE1YmRENlJKdnph?=
 =?utf-8?B?Mm9PNjdGMTdrNmFJTFg0V3lrQ2U2Tko2Nk1NeFlCbEo0SDg0ZlgxOHBvdE9D?=
 =?utf-8?B?M0NVUWxqdHlva0xBQkNLRnF1ZitwR0J5RlpIYWVqclU4Vlo1RU9JcVdkN0hG?=
 =?utf-8?B?QzhFRGk5ZThuN29wNzdpZ0ZMYjd0d2ZjMHJDSXIrSE1NaXcwbEQwaGprQWhE?=
 =?utf-8?B?Q0U2QUdpMlBOV0VBUUcxaFhKVG1sZEZYMWxDbVk0ZkN6SjJiRzVrY3dIcmtP?=
 =?utf-8?B?dlFCajBFT2VSUVYvSmZZV1JpRWhhNjRRYnlCYzBSYlFRWml5VVpFUU8vOHQx?=
 =?utf-8?B?a1FOUFJJbzRDUTJGSSsxNk1QOG1aa05yT2dlcHd2Yng5SjZ4MkRtZEFGQlI1?=
 =?utf-8?B?NFJQVlBwQUR5bG14ZHBmdldKOVpCbWVkbTNCRDhDeHM3TnNPU3hWeXRIRFBM?=
 =?utf-8?B?N0V2ZHh1aXBmc2h3bHU2RFZVakdrdFVWZ3NkQ1pMRHJlc2hIbjZpc0JFSEVq?=
 =?utf-8?B?dEJyVDRJMjN1SVMyc1VsVWFlMFoyTVBtajZSTnhobG9JUUl6VEd6dHZla1NR?=
 =?utf-8?B?NGxGMXEwak56R1ZtK0twN3dYRSt5V2hIY0lPTlpZQjIxT0xTTEd1U01LMGFz?=
 =?utf-8?B?bnhUc0MvRkZZaFNKWm1BVDEwcXdNSFE4WkhzSEhLOWJ3eCtzQldVek8rTzY3?=
 =?utf-8?B?NmlrMUVWcWV6UmVaeXJMQWVhYk1aaEh4bkJRZGRkSDZSaUFEbEFha3JvQmhH?=
 =?utf-8?B?UHBFU3NvUHlLQzJvQ0FVbFJDMVRNQTRFajVHekdralpIc1V3dUl0c1AxalF6?=
 =?utf-8?B?aEdRM3p0QTVPWXRxUHEzdU9NS0kweWNpYXRXNVN2ZWNXdHU2dVJncHA0dzlB?=
 =?utf-8?B?dUZldlVzd1hrMHQxRXBnb3BWSUZQaFFtM0lUd1FldlhzMkNwbm9qL3RFQ1RI?=
 =?utf-8?B?UTNkQlNMcm5yTkJ6czFJOWdRbHEza1ZOK1YyWjNVMWM4U2VCTlZJOEZBMXRH?=
 =?utf-8?B?V0lvRTZrcGRTeUQvb3R0WHVhdjhQdE02Y0tZMGRab1hvZW9adTUrZHFGRGxX?=
 =?utf-8?B?ZHFzMHB5WjU1Z2V2MWtOam9vS0trZ2U1ZlNtZFJJTnlxUkxxVkd3UlZ6cHpC?=
 =?utf-8?B?OW1BVUNEQUZ0Rm56NndBOHdvcTlqQ0NncVZnc2FRVWtRSG1uMUIwUTRQeC9U?=
 =?utf-8?B?aVExZ0dCQ0tsMmJoT0VmaFR3VlpaYys4OHVIZnVzTDN6NnZGUT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd2cb0f-21be-4db8-6d88-08dbae62e415
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 22:53:15.9680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dgWNuLYipgMrWTdmwDso38qJI1LT99JFRHK9w+v8KF9vVccIsXVJ/ukPy8d34AI8smOgV3QM8wZj3PUfphEZBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687
X-Proofpoint-GUID: GWPQE9RBXFEiDN61F0pZAzkNpgSEs4kz
X-Proofpoint-ORIG-GUID: GWPQE9RBXFEiDN61F0pZAzkNpgSEs4kz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=922 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBTZXAgMDIsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+ID4gIyBIb3N0IGNvbXBs
ZXRlbHkgZHJvcHBlZCB0aGUgU0NTSSBjb21tYW5kIHdpdGggdHJhbnNhY3Rpb24gZXJyb3IuIEl0
DQo+ID4gIyBkb2Vzbid0IHJlcXVlc3QgZm9yIHRoZSBzdGF0dXMuIFNpbmNlIGl0J3MgZHJvcHBl
ZCwgdGFnIDIgaXMNCj4gPiAjIGF2YWlsYWJsZS4gTm93LCBhIG5ldyBTQ1NJIGNvbW1hbmQgY2Fu
IHVzZSBUYWcgMi4NCj4gDQo+IFRoYXQgaXMgd2hhdCB0aGlzIGxvb2tzIGxpa2UuICBJJ20gbm90
IGF3YXJlIG9mIGFueSBwbGFjZSBpbiB0aGUgVUFTIA0KPiBzcGVjIHdoZXJlIGl0IHNheXMgdGhh
dCBhIGhvc3QgaXMgYWxsb3dlZCB0byBkbyB0aGlzLg0KPiANCj4gSXQgd291bGQgYmUgdmVyeSBp
bnRlcmVzdGluZyB0byBrbm93IGF0IHRoaXMgcG9pbnQgaWYgdGhlIGhvc3QgdHJpZWQgdG8gDQo+
IHJlYWQgbW9yZSBkYXRhIG9uIHRoZSBkYXRhIGVuZHBvaW50IGR1cmluZyB0aGUgMTYwLW1pY3Jv
c2Vjb25kIHBlcmlvZCANCj4gYmVmb3JlIHRyYW5zZmVyIDI5Mi4gIERvZXMgdGhlIGZ1bGwgbG9n
IHNob3cgd2hldGhlciB0aGlzIGhhcHBlbmVkPyAgDQo+IERvZXMgdGhlIGZhY3QgdGhhdCB0aGUg
dHJhbnNmZXJzIGhhdmUgY29uc2VjdXRpdmUgbnVtYmVycyBtZWFuIHRoYXQgDQo+IG5vdGhpbmcg
aGFwcGVuZWQgb24gdGhlIGJ1cyBkdXJpbmcgdGhpcyB0aW1lPyAgV2FzIHRoZSBkZXZpY2Ugd2Fp
dGluZyANCj4gZm9yIHRoZSBob3N0IGJlZm9yZSBzZW5kaW5nIG1vcmUgZGF0YSwgb3IgZGlkIGl0
IGNhbmNlbCB0aGUgZGF0YSB0aGF0IA0KPiB3YXMgYWxyZWFkeSBxdWV1ZWQ/DQo+IA0KDQpIZXJl
J3MgdGhlIHBhY2tldCBsZXZlbCB2aWV3ICh3L28gbGluayBjb21tYW5kcyBhbmQgbWlzYyBwYWNr
ZXRzKToNCg0KX19fX19fX3xfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX0wgDQpQYWNrZXQoMzAyMTYxKSBMZWZ0KCJM
ZWZ0IikgRGlyIEcyKHgxKSBUUCBTdGF0dXMoNCkgQUREUigzKSBFTkRQKDApIA0KX19fX19fX3wg
RGlyKC0tKSBQUChOb3QgUG5kKSAgIExDVyAgKEhzZXE6OSkgRHVyYXRpb24oMTYuNTQwIG5zKSAN
Cl9fX19fX198IFRpbWUoNzcyLjAwMCBucykgVGltZSBTdGFtcCgxMCAuIDAwOSA2NjkgMzEwKSAN
Cl9fX19fX198X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19SIA0KUGFja2V0KDMwMjE2OSkgUmlnaHQoIlJpZ2h0Iikg
RGlyIEcyKHgxKSBUUCBBQ0soMSkgQUREUigzKSBFTkRQKDApIA0KX19fX19fX3wgVFQoQ29udHJv
bCkgRGlyKC0tKSBTZXFOKDEpIE51bVAoMCkgU3RyZWFtIElEKDB4MDAwMCkgUFAoTm90IFBuZCkg
DQpfX19fX19ffCAgIExDVyAgKEhzZXE6NikgV2FybmluZyBEdXJhdGlvbigxNi41NDAgbnMpIFRp
bWUoMTQ1Ljc1NiB1cykgDQpfX19fX19ffCBUaW1lIFN0YW1wKDEwIC4gMDA5IDY3MCAwODIpIA0K
X19fX19fX3xfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX0wgDQoNCg0KIyMgQWZ0ZXIgdGhlIGRldmljZSBBQ0snZWQg
dGhlIHN0YXR1cyBzdGFnZS4gTm90aGluZyBoYXBwZW5lZCB1bnRpbCB0aGUNCiMjIGhvc3Qgc2Vu
ZHMgYSBuZXcgY29tbWFuZC4NCg0KDQpQYWNrZXQoMzAzMDEzKSBMZWZ0KCJMZWZ0IikgRGlyIEcy
KHgxKSBEUCBEYXRhIExlbigzMikgQUREUigzKSBFTkRQKDQpIA0KX19fX19fX3wgVFQoQnVsaykg
RGlyKE91dCkgU2VxTig1KSBFb0IoTikgU3RyZWFtIElEKDB4MDAwMCkgUFAoTm90IFBuZCkgDQpf
X19fX19ffCAgIExDVyAgKEhzZXE6MTEpIERhdGEoMzIgYnl0ZXMpIER1cmF0aW9uKDU2LjI0MCBu
cykgVGltZSggIDEuMzkwIHVzKSANCl9fX19fX198IFRpbWUgU3RhbXAoMTAgLiAwMDkgODE1IDgz
OCkgDQpfX19fX19ffF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQoNCg0KDQo+ID4gDQo+ID4gIyBUaGlua2luZyB0
aGF0IHRoZSBwcmV2aW91cyBUYWcgMiBjb21tYW5kIHdhcyBzdGlsbCBhY3RpdmUgYW5kDQo+ID4g
IyByZXNwb25kZWQgd2l0aCBhbiBPVkVSTEFQUEVEIFRBRy4gVGhpcyBwcm9iYWJseSBjYXVzZXMg
dGhlIGdhZGdldCB0bw0KPiA+ICMgY2FuY2VsIHRoZSB0cmFuc2ZlciBhbmQgZHJvcCB0aGUgY29t
bWFuZCBzbyBpdCBjYW4gYmUgaW4gc3luYyBhZ2Fpbi4NCj4gDQo+IEluZGVlZC4gIElmIHRoZSBD
bGVhci1IYWx0IGhhZCBjYXVzZWQgdGhlIGRldmljZSB0byBhYm9ydCB0aGUgb25nb2luZyANCj4g
dHJhbnNmZXIsIHdvdWxkIGl0IGhhdmUgcmVzcG9uZGVkIHRoaXMgd2F5PyAgV291bGRuJ3QgaXQg
aGF2ZSB0aG91Z2h0IA0KPiB0aGF0IHRoZSBwcmV2aW91cyBUYWcgMiBjb21tYW5kIHdhcyBjb21w
bGV0ZWx5IGZpbmlzaGVkPyAgT3Igd291bGQgaXQgDQo+IGhhdmUgY2FuY2VsbGVkIGp1c3QgdGhl
IGRhdGEgcGFydCBvZiB0aGUgdHJhbnNmZXIsIHdoaWxlIGtlZXBpbmcgdHJhY2sgDQo+IG9mIHRo
ZSBmYWN0IHRoYXQgdGhlIHN0YXR1cyBwYXJ0IHN0aWxsIG5lZWRlZCB0byBiZSBzZW50Pw0KPiAN
Cj4gVG8gcHV0IGl0IGFub3RoZXIgd2F5LCBpdCBzZWVtcyB0aGF0IHRoZSBPVkVSTEFQUEVEIFRB
RyByZXNwb25zZSB3YXMgDQo+IGNhdXNlZCBieSB0aGUgZmFjdCB0aGF0IHRoZSBzdGF0dXMgd2Fz
IG5ldmVyIHNlbnQuICBTbyB3aGV0aGVyIG9yIG5vdCANCj4gdGhlIGRldmljZSByZXNwb25kZWQg
dG8gdGhlIENsZWFyLUhhbHQgYnkgY2FuY2VsbGluZyBhbnl0aGluZywgaXQgDQo+IGJlY2FtZSBh
d2FyZSB0aGF0IHNvbWV0aGluZyB3YXMgd3Jvbmcgd2hlbiBpdCByZWNlaXZlZCB0aGlzIGR1cGxp
Y2F0ZSANCj4gdGFnLg0KPiANCj4gPiANCj4gPiBTbywgZm9yIHRoaXMgc2NlbmFyaW8sIHRoZSBo
b3N0IHdhcyBwcm9iYWJseSBzdGF5IGluIHN5bmMgd2l0aCB0aGUNCj4gPiBkZXZpY2UgZHVlIHRv
IHRoZSBvdmVybGFwIGNvbW1hbmQgdGFnIGlkIGNhbmNlbGluZyB0aGUgdHJhbnNmZXIuIEknbSBu
b3QNCj4gPiBzdXJlIGlmIHRoaXMgaXMgdGhlIGludGVudCBvZiB0aGUgV2luZG93cyBVQVNQIGNs
YXNzIGRyaXZlciwgd2hpY2ggc2VlbXMNCj4gPiBsaWtlIGEgbm9uLWNvbnZlbnRpb25hbCB3YXkg
b2Ygc3luY2hyb25pemF0aW9uLiBQZXJoYXBzIGl0IHdhcyBkb25lDQo+ID4gYmVjYXVzZSBzb21l
IGRldmljZXMgbWF5IG5vdCBzdXBwb3J0IFRBU0tfTUFOQUdFTUVOVChBYm9ydF90YXNrKT8NCj4g
DQo+IFRoYXQncyBwb3NzaWJsZS4gIFdpbmRvd3Mgc2VlbXMgdG8gdXNlIGEgbm9uLWNvbnZlbnRp
b25hbCBhcHByb2FjaCB0byANCj4gbWFueSB0aGluZ3MuDQo+IA0KPiA+IFJlZ2FyZGxlc3MsIGlm
IHRoZSBob3N0IHJlc2V0cyB0aGUgZW5kcG9pbnQsIHRoZSB0cmFuc2ZlciBtdXN0IGJlDQo+ID4g
Y2FuY2VsZWQgb3RoZXJ3aXNlIHdlIHJpc2sgZGF0YSBjb3JydXB0aW9uLg0KPiANCj4gRG8gd2U/
ICBXaGF0IHdvdWxkIGhhdmUgaGFwcGVuZWQgaWYgdGhlIHRyYW5zZmVyIGhhZCBub3QgYmVlbiAN
Cj4gY2FuY2VsbGVkPyAgVGhlIGRldmljZSBtaWdodCBoYXZlIHNlbnQgc29tZSBkYXRhIGxlZnQg
b3ZlciBmcm9tIHRoZSANCj4gb3JpZ2luYWwgY29tbWFuZCBhbmQgdGhlIGhvc3QgbWlnaHQgaGF2
ZSBtaXNpbnRlcnByZXRlZCBpdCBhcyBiZWxvbmcgdG8gDQo+IHRoZSBuZXcgY29tbWFuZC4gIEJ1
dCB3aGVuIHRoZSBkZXZpY2Ugc2VudCB0aGUgT1ZFUkxBUFBFRCBUQUcgcmVzcG9uc2UsIA0KPiB0
aGUgaG9zdCB3b3VsZCBoYXZlIHJlYWxpemVkIHRoYXQgYW55IGRhdGEgaXQgcmVjZWl2ZWQgZm9y
IHRoZSANCj4gbmV3IGNvbW1hbmQgd2FzIGludmFsaWQgYW5kIGFiYW5kb25lZCB0aGUgY29tbWFu
ZC4NCj4gDQoNCklmIHRoZSBob3N0IHJlc2V0cyB0aGUgZW5kcG9pbnQsIHRoZSB0cmFuc2ZlciBt
dXN0IGJlIGNhbmNlbGVkLiBIb3cNCmNhbmNlbGF0aW9uIGlzIHRyaWdnZXJlZCBpcyBhbm90aGVy
IHRoaW5nLiBJbiB0aGlzIGNhc2UsIGl0IG1heSBub3QNCmJlIHRyaWdnZXJlZCBieSB0aGUgQ0xF
QVJfRkVBVFVSRShoYWx0X2VwKSwgYnV0IHByb2JhYmx5IHRocm91Z2ggdGhlDQpvdmVybGFwIHRh
ZyBkZXRlY3Rpb24uDQoNCj4gSW4gZmFjdCwgdGhhdCdzIHdoYXQgaXQgZGlkIGRvIGluIHRyYW5z
ZmVyIDI5NS4gIEFzIGZhciBhcyBJIGNhbiB0ZWxsIA0KPiBmcm9tIHRoZSBsb2csIHRoZSBDbGVh
ci1IYWx0IGRpZG4ndCBjYXVzZSB0aGUgZGV2aWNlIHRvIGZ1bGx5IGNhbmNlbCANCj4gdGhlIHRy
YW5zZmVyLg0KDQo+IA0KPiA+IEFsc28gd2hlbmV2ZXIgdGhlcmUncyBhIE9WRVJMQVBQRUQgdGFn
IGVycm9yLCBXaW5kb3dzIGhvc3QgdGFrZXMgYSBsb25nDQo+ID4gdGltZSAofjEgc2VjKSB0byBz
ZW5kIGEgbmV3IGNvbW1hbmQgKGNoZWNrIGRlbHRhIHRpbWUgb2YgVHJhbnNmZXIgMjk1DQo+ID4g
YW5kIDMxMykuIElmIHRoZSBnYWRnZXQgZHJpdmVyIGNhbiBiYXNlIG9mZiBvZiB0aGUNCj4gPiBD
TEVBUl9GRUFUVVJFKGhhbHRfZXApLCB0aGlzIGltcHJvdmVzIHBlcmZvcm1hbmNlLg0KPiANCj4g
T2theSwgdGhhdCdzIGEgZ29vZCBwb2ludC4NCj4gDQo+IEhvd2V2ZXIsIHNpbmNlIG5vdCBjYW5j
ZWxsaW5nIHRoZSB0cmFuc2ZlciBhcHBhcmVudGx5IGRpZCBub3QgbGVhZCB0byANCj4gY29ycnVw
dGlvbiwgSSB0aGluayBpdCdzIG9rYXkgdG8gYWxsb3cgVURDIGRyaXZlcnMgbm90IHRvIGNhbmNl
bCANCj4gcmVxdWVzdHMgd2hlbiB0aGV5IHJlY2VpdmUgYSBDbGVhci1IYWx0LiAgVGhpcyBkZWNp
c2lvbiBjb3VsZCBiZSBsZWZ0IA0KPiB1cCB0byB0aGUgZHJpdmVyLg0KPiANCg0KT2ssIGZhaXIg
ZW5vdWdoLg0KDQpGb3Igb3VyIHRlc3RzLCB3ZSBiYXNlZCB0aGUgdHJhbnNhY3Rpb24gZXJyb3Jz
IHRocm91Z2ggdGhlDQpDTEVBUl9GRUFUVVJFKGhhbHRfZXApIGFuZCBkcm9wcGVkIHRoZSBNU0Mg
Y29tbWFuZCBhbHRvZ2V0aGVyIHRvIHN0YXkgaW4NCnN5bmMsIGp1c3QgYXMgaG93IHRoZSBXaW5k
b3dzIGhvc3QgZHJvcHMgdGhlIE1TQyBjb21tYW5kLg0KDQpCdXQgYXMgdGhyb3VnaCB0aGlzIGxv
bmcgZGlzY3Vzc2lvbiwgd2UgbWF5IG5vdCBuZWVkIGFuZCBwcm9iYWJseSBjYW4NCmF2b2lkIGZv
cmNpbmcgdGhlIGdhZGdldCBkcml2ZXIgdG8gbGVhcm4gYSBuZXcgZXJyb3IgY29kZSB0byBzdGF5
IGluDQpzeW5jIHdpdGggV2luZG93cydzIGhvc3QuDQoNClRoYW5rcywNClRoaW5o
